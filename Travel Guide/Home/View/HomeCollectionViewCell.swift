//
//  HomeCollectionViewCell.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 4.10.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    
    
    var detailsText: String?
    var titleText: String?
    var imageUrlString: String?
    var index = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: CellInfoProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func bookmarkClicked(_ sender: Any) {
        
        let newItem = Item(context: self.context)
        newItem.desc = self.detailsText
        newItem.title = self.titleText
        newItem.image = imageUrlString
        newItem.date = Date.now
        do {
            try context.save()
            print("Success")
            self.delegate?.displayInfoImage()
        } catch {
            print("Error saving context")
        }
        
    }
}
