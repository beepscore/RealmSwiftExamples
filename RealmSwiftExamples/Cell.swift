//
//  CellTableViewCell.swift
//  RealmSwiftExamples
//
//  Created by Steve Baker on 11/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    // If you override any of a class's designated initializers,
    // you don't inherit any other designated initializers.
    // But UIView adopts the NSCoding protocol, which requires an init(coder:) initializer. So you must implement that one too.
    // https://stackoverflow.com/questions/26081287/required-initializer-initcoder-must-be-provided-by-subclass-of-uitablevi#26081426
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
