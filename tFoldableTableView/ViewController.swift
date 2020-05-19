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
}

class ViewController: UIViewController {

    var dArray = [[Item(), Item(), Item(), Item()],
                  [Item(), Item(), Item(), Item()],
                  [Item(), Item(), Item(), Item()]]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = UINib.init(nibName: "SectionHeader", bundle: Bundle.main)
        tableView.register(header, forHeaderFooterViewReuseIdentifier: "Header")
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dArray[section].filter{ $0.showsSelf == true }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(format: "%02d", indexPath.section) + String(format: "%02d", indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ViewController: SectionHeaderDelegate {
    
    func sectionBtnDidTap(_ header: UITableViewHeaderFooterView) {
        guard let seciton = getSection(header: header) else { return }
        let isVisible = dArray[seciton].first!.showsSelf
        dArray[seciton].forEach { $0.showsSelf = isVisible ? false : true }
        
        // ここでアニメーション変えてみて
        tableView.reloadSections(IndexSet(integer: seciton), with: .automatic)
    }
    
    func rowsBtnDidTap(_ header: UITableViewHeaderFooterView) {
        guard let seciton = getSection(header: header) else { return }
        let indexPaths = dArray[seciton].enumerated().map { IndexPath(row: $0.offset, section: seciton)}
        let isVisible = dArray[seciton].first!.showsSelf
        dArray[seciton].forEach { $0.showsSelf = isVisible ? false : true }
        
        // ここでアニメーション変えてみて
        if isVisible {
            tableView.deleteRows(at: indexPaths, with: .top)
        } else {
            tableView.insertRows(at: indexPaths, with: .top)
        }
    }
    
}
