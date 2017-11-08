////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    let realmService = RealmService.shared
    
    var results: Results<DemoObject>?
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        results = realmService.realm.objects(DemoObject.self).sorted(byKeyPath: "date")

        // Set results notification block
        // block is called every time the realm collection changes
        // realm.io sample code uses "observe"
        // video tutorial used method "addNotificationBlock", comments say it was renamed to "observe"
        self.notificationToken = results?.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self.tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the TableView
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
                break
            case .error(let err):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(err)")
                break
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // stop notifications. stop was renamed to invalidate
        notificationToken?.invalidate()
    }

    // MARK: - UI

    func setupUI() {
        // need this to avoid crash. Why?
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")

        self.title = "TableView"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BG Add", style: .plain,
                                                                target: self, action: #selector(backgroundAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self, action: #selector(add))
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results == nil || results?.count == nil {
            return 0
        } else {
            return results!.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell

        guard let object = results?[indexPath.row] else { return cell }
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.date.description
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        guard let object = results?[indexPath.row] else { return }

        if editingStyle == .delete {
            realmService.delete(object)
        }
    }

    // MARK: - Actions

    /// annotate with @objc for use with #selector()
    /// https://stackoverflow.com/questions/36962854/swift-wants-argument-of-selector-to-be-exposed-to-objective-c#36963058
    @objc func backgroundAdd() {
        // Import many items in a background thread
        DispatchQueue.global().async {
            // Get new realm and table since we are in a new thread
            let realm = try! Realm()
            realm.beginWrite()
            for _ in 0..<5 {
                // Add row via dictionary. Order is ignored.
                // realm.create(DemoObject.self, value: ["title": ModelHelpers.randomString(),
                // "date": ModelHelpers.randomDate()])

                let demoObject = DemoObject(title: ModelHelpers.randomString(),
                                            date: ModelHelpers.randomDate(),
                                            email: "foo",
                                            score: 2)
                realm.add(demoObject)
            }

            do {
                try realm.commitWrite()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    @objc func add() {
        let demoObject = DemoObject(title: ModelHelpers.randomString(),
                                    date: ModelHelpers.randomDate(),
                                    email: "foo",
                                    score: 2)
        realmService.add(demoObject)
    }
}
