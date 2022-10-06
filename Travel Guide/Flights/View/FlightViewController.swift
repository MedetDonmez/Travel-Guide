//
//  ImagesEntity.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 29.09.2022.
//

import UIKit
import Kingfisher


class FlightViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = FlightViewModel()
    var items: [FlightCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        viewModel.didViewLoad()
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)
    }
    
    func SetupUI(){
        collectionView.register(.init(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.viewDelegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - FlightViewModelProtocol
extension FlightViewController: FlightViewModelProtocol {
    func didCellItemFetch(_ items: [FlightCellViewModel]) {
        self.items = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - DataSource
extension FlightViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.detailsText = items[indexPath.row].detail
        vc.titleText = items[indexPath.row].name
        vc.imageUrlString = items[indexPath.row].imageURL
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .red
        cell.descText.textColor = .white
        cell.nameText.textColor = .white
        cell.descText.text = items[indexPath.row].desc
        cell.nameText.text = items[indexPath.row].name
        if let url = items[indexPath.row].imageURL {
            let newUrl = URL(string: url)
            cell.image.kf.setImage(with: newUrl)
        }
        cell.layer.cornerRadius = 8
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FlightViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width-32 , height: 153)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}
