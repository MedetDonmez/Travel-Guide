//
//  BookmarksViewController.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 4.10.2022.
//

import UIKit
import CoreData
import Kingfisher

class BookmarksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemList : [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try context.save()
        } catch {
            print("Error saving context")
        }
        loadItems()
        self.tableView.reloadData()
    }
    
    func setupUI(){
        tableView.delegate = self
        tableView.rowHeight = 167
        tableView.dataSource = self
        tableView.register(.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            itemList = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

// MARK: -  TableView Data Source
extension BookmarksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.descText.text = itemList[indexPath.row].title
        cell.nameText.text = itemList[indexPath.row].desc
        if let url = itemList[indexPath.row].image {
            let newUrl = URL(string: url)
            cell.cellImage.kf.setImage(with: newUrl)
        }
        cell.cellImage.layer.cornerRadius = 8
        return cell
    }
}

// MARK: - TableView Delegate
extension BookmarksViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.detailsText = itemList[indexPath.row].desc
        vc.titleText = itemList[indexPath.row].title
        vc.imageUrlString = itemList[indexPath.row].image
        vc.rootVc = "bookmarks"
        vc.indexNo = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

