//
//  HomeCollectionViewCell.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 4.10.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    
    //these variables to get info from home vc.
    var detailsText: String?
    var titleText: String?
    var imageUrlString: String?
    
    //creating context to add data to it
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: CellInfoProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookmarkButton.layer.shadowRadius = 5
        bookmarkButton.layer.shadowColor = UIColor.black.cgColor
        bookmarkButton.layer.shadowOpacity = 0.5
        // Initialization code
    }

    @IBAction func bookmarkClicked(_ sender: Any) {
        
        //adding new Item and saving it
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
