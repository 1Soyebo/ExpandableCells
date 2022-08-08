//
//  ExpandTableViewCell.swift
//  ExpandableTest
//
//  Created by Ibukunoluwa Soyebo on 08/08/2022.
//

import UIKit

class ExpandTableViewCell: UITableViewCell {
    
    var isLastCell: Bool = false{
        didSet{
            lastLineView.isHidden = isLastCell
            mainView.layer.cornerRadius = isLastCell ? 12:0
            mainView.layer.maskedCorners = isLastCell ? [.layerMaxXMaxYCorner, .layerMinXMaxYCorner] : []
        }
    }
    
    static let identifier = "ExpandTableViewCell"
    static func getNib() -> UINib{
        return .init(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var lastLineView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        lastLineView.isHidden = false
        mainView.layer.cornerRadius = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupExpandTable(content: String, islastCell: Bool){
        cellTitle.text = content
        isLastCell = islastCell
    }
    
//    func setupLastCell(){
//        lastLineView.isHidden = true
//        mainView.layer.cornerRadius = 12
//        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//    }
}
