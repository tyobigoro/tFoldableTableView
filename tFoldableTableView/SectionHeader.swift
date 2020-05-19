//
//  SectionHeader.swift
//  tFoldableTableView
//
//  Created by tyobigoro on 2020/05/20.
//  Copyright © 2020 tyobigoro. All rights reserved.
//

import UIKit

protocol SectionHeaderDelegate: AnyObject {
    func sectionBtnDidTap(_ header: UITableViewHeaderFooterView)
    func rowsBtnDidTap(_ header: UITableViewHeaderFooterView)
}

class SectionHeader: UITableViewHeaderFooterView {

    weak var sectoionHeaderDelegate: SectionHeaderDelegate?
    
    @IBOutlet weak var sectionBtn: UIButton!
    
    @IBOutlet weak var rowBtn: UIButton!
    
    @IBAction func sectionBtnDidTap(_ sender: Any) {
        sectoionHeaderDelegate?.sectionBtnDidTap(self)
    }
    
    @IBAction func rowsBtnDidTap(_ sender: Any) {
        sectoionHeaderDelegate?.rowsBtnDidTap(self)
    }
    
    
}
