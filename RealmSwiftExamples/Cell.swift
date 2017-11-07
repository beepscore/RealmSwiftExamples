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

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
