//
//  ViewController.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 27.09.2022.
//

import UIKit

protocol CellInfoProtocol {
    func displayInfoImage()
}


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = HomeViewModel()
    var items: [NewsCellViewModel] = []
    var oncellbuttonpress: ((Int)-> ())?
    var row: Int!
    
    
    override func viewDidLoad() {
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        collectionView.layer.shadowRadius = 5.0
        collectionView.layer.shadowOpacity = 0.3
        collectionView.layer.masksToBounds = false
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func flightsButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FlightViewController") as! FlightViewController
        navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func hotelsButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HotelsViewController") as! HotelsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI(){
        collectionView.register(.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.viewDelegate = self
        viewModel.didViewLoad()
        tabBarController?.tabBar.layer.shadowOffset = .zero
        tabBarController?.tabBar.layer.shadowRadius = 2
        tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController?.tabBar.layer.shadowOpacity = 0.3
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewController: HomeViewModelProtocol {
    func didCellItemFetch(_ items: [NewsCellViewModel]) {
        self.items = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.detailsText = items[indexPath.row].details
        vc.titleText = items[indexPath.row].name
        vc.imageUrlString = items[indexPath.row].imageURL
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.backgroundColor = .white
        cell.descText.text = items[indexPath.row].desc
        cell.nameText.text = items[indexPath.row].name
        cell.index = indexPath.row
        if let url = items[indexPath.row].imageURL {
            let newUrl = URL(string: url)
            cell.image.kf.setImage(with: newUrl)
            cell.layer.cornerRadius = 8
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        cell.delegate = self
        cell.titleText = items[indexPath.row].name
        cell.detailsText = items[indexPath.row].details
        cell.imageUrlString = items[indexPath.row].imageURL
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 253 , height: 214)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension HomeViewController: CellInfoProtocol {
    func displayInfoImage() {
        infoImage.image = UIImage(named: "itemadded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.infoImage.image = nil
        }
    }
}

