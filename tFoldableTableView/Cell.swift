//
//  Cell.swift
//  tFoldableTableView
//
//  Created by tyobigoro on 2020/05/20.
//  Copyright © 2020 tyobigoro. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    func setValueToCell(str: String) {
        label.text = str
    }
    
}
