//
//  SearchViewController.swift
//  Travel Guide
//
//  Created by Medet Dönmez on 29.09.2022.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, HotelViewModelProtocol {
    func didCellItemFetch(_ items: [HotelCellViewModel]) {
        self.hotelItems = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var flightsTabButton: UIButton!
    @IBOutlet weak var hotelTabButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var imageInfo: UIImageView!
    
    var status = ""
    
    let flightViewModel = FlightViewModel()
    var flightItems: [FlightCellViewModel] = []
    var filteredFlightData: [FlightCellViewModel] = []
    
    let hotelViewModel = HotelViewModel()
    var hotelItems: [HotelCellViewModel] = []
    var filteredHotelData: [HotelCellViewModel] = []
    
    override func viewDidLoad() {
        hotelTabButton.setImage(UIImage(named: "hotels-deselected"), for: .normal)
        super.viewDidLoad()
        self.dismissKeyboard()
        collectionView.register(.init(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        field.delegate = self
    }
    
    @IBAction func flightsTabPressed(_ sender: UIButton) {
        self.imageInfo.image = nil
        status = "flight"
        field.text = ""
        filteredHotelData.removeAll()
        filteredFlightData.removeAll()
        collectionView.reloadData()
        flightsTabButton.setImage(UIImage(named: "flights-selected"), for: .normal)
        hotelTabButton.setImage(UIImage(named: "hotels-deselected"), for: .normal)
        flightViewModel.viewDelegate = self
        flightViewModel.didViewLoad()
    }
    
    @IBAction func hotelTabPressed(_ sender: UIButton) {
        self.imageInfo.image = nil
        status = "hotel"
        field.text = ""
        filteredHotelData.removeAll()
        filteredFlightData.removeAll()
        collectionView.reloadData()
        hotelTabButton.setImage(UIImage(named: "hotels-selected"), for: .normal)
        flightsTabButton.setImage(UIImage(named: "flights-deselected"), for: .normal)
        hotelViewModel.viewDelegate = self
        hotelViewModel.didViewLoad()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.text = textField.text!.replacingOccurrences(of: "ı", with: "i")
        
        print(textField.text!)
        print("dog")
        if status == "hotel" {
            if let text = textField.text {
                if string.count == 0 {
                    filterText(String(text.dropLast()))
                    collectionView.reloadData()
                    if text == "" {
                        filteredFlightData.removeAll()
                        collectionView.reloadData()
                    }
                } else {
                    filterText(text + string)
                }
            }
        }
        else {
            if let text = textField.text {
                if string.count == 0 {
                    filterText(String(text.dropLast()))
                    collectionView.reloadData()
                    if text == "" {
                        filteredHotelData.removeAll()
                        collectionView.reloadData()
                    }
                } else {
                    filterText(text + string)
                }
            }
        }
        return true
    }
    
    func filterText(_ query: String) {
        
        let newquery = query.replacingOccurrences(of: "ı", with: "i")
        
        if status == "flight" {
            
            if newquery.count < 3 {
                self.filteredFlightData.removeAll()
                self.collectionView.reloadData()
            }
            filteredFlightData.removeAll()
            for item in flightItems {
                if item.name.lowercased().contains(newquery.lowercased()) {
                    filteredFlightData.append(item)
                    print(filteredFlightData.count)
                }
            }
            if newquery.count > 2{
                self.collectionView.reloadData()
                if filteredFlightData.count == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.imageInfo.image = UIImage(named: "nodata")
                    }
                }
            }
//            if query.count < 3 {
//                imageInfo.image = nil
//                self.filteredFlightData.removeAll()
//                self.collectionView.reloadData()
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
            }
        }
        
        else {

            if newquery.count < 3 {
                self.filteredHotelData.removeAll()
                self.collectionView.reloadData()
            }
            filteredHotelData.removeAll()
            for item in hotelItems {
                if item.name.lowercased().contains(newquery.lowercased()) {
                    filteredHotelData.append(item)
                }
            }
            if newquery.count > 2{
                if filteredHotelData.count == 0 {
                    self.collectionView.reloadData()
                    print("wowow")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.imageInfo.image = UIImage(named: "nodata")
                    }
                }
            }
//            if query.count < 3 {
//                imageInfo.image = nil
//                self.filteredHotelData.removeAll()
//                self.collectionView.reloadData()
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
            }
        }
    }
}


// MARK: -  FlightViewModel
extension SearchViewController: FlightViewModelProtocol {
    
    func didCellItemFetch(_ items: [FlightCellViewModel]) {
        self.flightItems = items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if status == "flight" {
            if !filteredFlightData.isEmpty {
                imageInfo.image = nil
                return filteredFlightData.count
            }
            else {
                return 0
            }
        }
        else {
            if !filteredHotelData.isEmpty {
                imageInfo.image = nil
                return filteredHotelData.count
            }
            else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if status == "flight" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            vc.detailsText = filteredFlightData[indexPath.row].detail
            vc.titleText = filteredFlightData[indexPath.row].name
            vc.imageUrlString = filteredFlightData[indexPath.row].imageURL
            navigationController?.pushViewController(vc, animated: true)
        }
        
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            vc.detailsText = filteredHotelData[indexPath.row].details
            vc.titleText = filteredHotelData[indexPath.row].name
            vc.imageUrlString = filteredHotelData[indexPath.row].imageURL
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .gray
        
        if status == "flight" {
            if !filteredFlightData.isEmpty {
                cell.descText.text = filteredFlightData[indexPath.row].desc
                cell.nameText.text = filteredFlightData[indexPath.row].name
                if let url = filteredFlightData[indexPath.row].imageURL {
                    let newUrl = URL(string: url)
                    cell.image.kf.setImage(with: newUrl)
                    cell.layer.cornerRadius = 8
            }
            }
            else {
                cell.descText.text = flightItems[indexPath.row].desc
                cell.nameText.text = flightItems[indexPath.row].name
            }
        }
        else {
            if !filteredHotelData.isEmpty {
                cell.descText.text = filteredHotelData[indexPath.row].desc
                cell.nameText.text = filteredHotelData[indexPath.row].name
                if let url = filteredHotelData[indexPath.row].imageURL {
                    let newUrl = URL(string: url)
                    cell.image.kf.setImage(with: newUrl)
                }
            }
            else {
                cell.descText.text = flightItems[indexPath.row].desc
                cell.nameText.text = flightItems[indexPath.row].name
            }
        }
        cell.layer.cornerRadius = 8
        return cell
    }
}

// MARK: - CollectionViewDelegate
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - TextField
extension SearchViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if field.text != "" {
            return true
        }
        else {
            field.placeholder = "Write something"
            return false
        }
    }
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action:    #selector(SearchViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}

