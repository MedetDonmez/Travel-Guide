//
//  DetailsViewController.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 3.10.2022.
//

import UIKit
import Kingfisher
import CoreData

protocol addProtocol {
    func addItem(title: String)
}


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var alert: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    
    var detailsText: String?
    var titleText: String?
    var imageUrlString: String?
    
    var rootVc : String? //this var is need for changing button function add or remove bookmark
    var indexNo = 0 //new items are added to top so we're going delete index 0, if items just added
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.layer.shadowOffset = .zero
        alert.layer.shadowRadius = 5
        alert.layer.shadowColor = UIColor.black.cgColor
        alert.layer.shadowOpacity = 0.5
        alert.image = nil
        loadItems()
        
        //if user coming from from bookmarks, the button will be remove bookmark
        if rootVc == "bookmarks" {
            bookmarkButton.setImage(UIImage(named: "remove"), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.popToRootViewController(animated: true)
        rootVc = ""
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        bookmarkButton.imageView?.image = nil
        bookmarkButton.imageView?.image = UIImage(named: "remove")
        
        //if root vc is bookmarks or new item just added, button will have delete func
        if rootVc == "bookmarks" {
            rootVc = ""
            saveContext()
            loadItems()
            context.delete(itemArray[indexNo])
            bookmarkButton.setImage(UIImage(named: "addBookmark"), for: .normal)
            alert.image = UIImage(named: "itemdeleted")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.alert.image = nil
            }
        }
        
        //in other situations the button has add functionality
        else {
            rootVc = "bookmarks" // we are changing the rootVc situation here to avoid
                                // same item more than once.
            bookmarkButton.imageView?.image = nil
            let newItem = Item(context: self.context)
            newItem.desc = self.detailsText
            newItem.title = self.titleText
            newItem.image = imageUrlString
            newItem.date = Date.now
            itemArray.append(newItem)
            saveContext()
            loadItems()
            indexNo = 0
            bookmarkButton.setImage(UIImage(named: "remove"), for: .normal)
            alert.image = UIImage(named: "itemadded")
            //showing alert after item added
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.alert.image = nil
            }
        }
    }
    
    func SetupUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        bookmarkButton.setImage(UIImage(named: "addBookmark"), for: .normal)
        if let url = imageUrlString {
            let newUrl = URL(string: url)
            detailImage.kf.setImage(with: newUrl)
        }
        titleLabel.text = titleText
        detailsLabel.text = detailsText
        detailImage.layer.cornerRadius = 25
        detailImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func saveContext () {
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving context")
        }
    }
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
