//
//  TableViewCell.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 4.10.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
