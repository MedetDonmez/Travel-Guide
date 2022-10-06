//
//  CustomCollectionViewCell.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 29.09.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
