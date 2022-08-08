//
//  ViewController.swift
//  ExpandableTest
//
//  Created by Ibukunoluwa Soyebo on 04/08/2022.
//

import UIKit

class ViewController: UIViewController {

    var expandedSectionHeader: UITableViewHeaderFooterView!
    var arrayExpandModel: [ExpandModel] = [.init(title: "Test", content: ["Bread", "Bacon"]), .init(title: "Second Test", content: ["Cheese"])]
    
    @IBOutlet weak var tblExpand: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "Expandable Cell"
        view.backgroundColor = .black
    }
    
    private func setupTableView(){
        tblExpand.dataSource = self
        tblExpand.delegate = self
        tblExpand.tableFooterView = UIView()
        tblExpand.backgroundColor = .clear
        tblExpand.register(ExpandTableViewCell.getNib(), forCellReuseIdentifier: ExpandTableViewCell.identifier)
        tblExpand.rowHeight = 59
    }
    
    @objc
    func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! ExpandHeaderView
        let section = headerView.tag

        headerView.isExpaneded.toggle()
        arrayExpandModel[section].isExpanded.toggle()
        
        if arrayExpandModel[section].isExpanded{
            tableViewExpandSection(section)
        } else {
            tableViewCollapeSection(section)
        }
    }
    
    func tableViewCollapeSection(_ section: Int) {
        toggleTable(section: section, isExpand: false)
    }
    
    func tableViewExpandSection(_ section: Int) {
        toggleTable(section: section, isExpand: true)
    }
    
    private func toggleTable(section: Int, isExpand: Bool){
        if (arrayExpandModel[section].content.count != 0) {
//            rotateChevron(isExpand: isExpand, imageView: imageView)
            var indexesPath = [IndexPath]()
            for i in 0 ..< arrayExpandModel[section].content.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            updateTable(isExpand: isExpand, indexesPath: indexesPath)
        }
    }
    
    private func rotateChevron(isExpand: Bool, imageView: UIImageView){
        let angle = isExpand ? 0.0 : 90.0
        UIView.animate(withDuration: 0.4, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: (angle * CGFloat(Double.pi)) / 180.0)
        })
    }
    
    private func updateTable(isExpand: Bool, indexesPath: [IndexPath]){
        self.tblExpand!.beginUpdates()
        isExpand ? self.tblExpand!.insertRows(at: indexesPath, with: .fade) : self.tblExpand!.deleteRows(at: indexesPath, with: .fade)
        self.tblExpand!.endUpdates()
    }
    
}


extension ViewController: UITableViewDelegate{}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        arrayExpandModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayExpandModel[section].isExpanded ? arrayExpandModel[section].content.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblExpand.dequeueReusableCell(withIdentifier: ExpandTableViewCell.identifier) as! ExpandTableViewCell
        let isLastCell = indexPath.row == (arrayExpandModel[indexPath.section].content.count - 1)
        cell.setupExpandTable(content: arrayExpandModel[indexPath.section].content[indexPath.row], islastCell: isLastCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        arrayExpandModel[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ExpandHeaderView.getNib().instantiate(withOwner: self).first as! ExpandHeaderView
        headerView.lblTitle.text = arrayExpandModel[section].title
        headerView.tag = section
        let headerTapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderWasTouched(_:)))
        headerView.addGestureRecognizer(headerTapGesture)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        66
    }
}
