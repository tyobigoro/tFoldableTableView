//
//  ViewController.swift
//  tFoldableTableView
//
//  Created by tyobigoro on 2020/05/20.
//  Copyright © 2020 tyobigoro. All rights reserved.
//

import UIKit

class Item {
    var name: String = "A"
    var showsSelf: Bool = true
    var showsContents: Bool = true
    var items: [Item] = [Item]()
    
    init(_ items: [Item]?) {
        if let items = items { self.items = items }
    }
   
    func changeVisiblity(section: Int) -> [IndexPath]{
        showsContents.toggle()
        items.forEach { $0.showsSelf = showsContents }
        return items.enumerated().map { IndexPath(row: $0.offset, section: section) }
    }
}

class ViewController: UIViewController {
    
    var dArray = [Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)]),
                  Item([Item(nil), Item(nil), Item(nil), Item(nil)])]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 10000
        
        let cell = UINib.init(nibName: "Cell", bundle: Bundle.main)
        tableView.register(cell, forCellReuseIdentifier: "Cell")
        
        let header = UINib.init(nibName: "SectionHeader", bundle: Bundle.main)
        tableView.register(header, forHeaderFooterViewReuseIdentifier: "Header")
        
        let footer = UINib.init(nibName: "SectionFooter", bundle: Bundle.main)
        tableView.register(footer, forHeaderFooterViewReuseIdentifier: "Footer")
        
    }

    func getSection(header: UITableViewHeaderFooterView) -> Int? {
        let point = CGPoint(x: header.frame.midX, y: header.frame.midY)
        var i: Int? = nil
        for s in 0 ..< dArray.count {
            if tableView.rectForHeader(inSection: s).contains(point) {
                i = s
                break
            }
        }
        return i
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! SectionHeader
        header.sectoionHeaderDelegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Footer") as! SectionFooter
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dArray[section].items.filter{ $0.showsSelf == true }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.setValueToCell(str: String(format: "%02d", indexPath.section) + String(format: "%02d", indexPath.row))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}


extension ViewController: UITextViewDelegate {
    
}

extension ViewController: SectionHeaderDelegate {
    
    func sectionBtnDidTap(_ header: UITableViewHeaderFooterView) {
        guard let section = getSection(header: header) else { return }
        let _ = dArray[section].changeVisiblity(section: section)
        
        // ここでアニメーション変えてみて
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    func rowsBtnDidTap(_ header: UITableViewHeaderFooterView) {
        guard let section = getSection(header: header) else { return }
        let isVisible = dArray[section].showsContents
        let indexPaths = dArray[section].changeVisiblity(section: section)
        
        // ここでアニメーション変えてみて
        if isVisible {
            tableView.deleteRows(at: indexPaths, with: .top)
        } else {
            tableView.insertRows(at: indexPaths, with: .top)
        }
    }
    
}
