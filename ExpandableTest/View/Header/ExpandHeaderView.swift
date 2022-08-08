//
//  ExpandHeaderView.swift
//  ExpandableTest
//
//  Created by Ibukunoluwa Soyebo on 08/08/2022.
//

import UIKit

class ExpandHeaderView: UIView {
    
    var isExpaneded: Bool = false{
        didSet{
            self.layer.maskedCorners = isExpaneded ? [.layerMinXMinYCorner, .layerMinXMaxYCorner] : [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            self.imgIcon.image = .init(named: isExpaneded ? "lh.minus":"lh.plus")
            self.backgroundColor = isExpaneded ? .init(hex: "#F5F8FF"):.white
        }
    }

    static func getNib() -> UINib{
        return .init(nibName: "ExpandHeaderView", bundle: nil)
    }

    static let identifier = "ExpandHeaderView"
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
    }
    
}
