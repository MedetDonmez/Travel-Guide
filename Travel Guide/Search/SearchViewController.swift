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
    @IBOutlet weak var hotelsTabButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noDataImage: UIImageView!
    
    var searchTabStatus = "" //at start both tabs are not selected
    
    //here there are two arrays for fetch flights and hotels and adding them to flightItems and hotelItems
    //and two arrays named "filtered" are for after search to add expected data to them.
    
    
    let flightViewModel = FlightViewModel()
    var flightItems: [FlightCellViewModel] = []
    var filteredFlightData: [FlightCellViewModel] = []
    
    let hotelViewModel = HotelViewModel()
    var hotelItems: [HotelCellViewModel] = []
    var filteredHotelData: [HotelCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    @IBAction func flightsTabPressed(_ sender: UIButton) {
        self.noDataImage.image = nil
        searchTabStatus = "flight"  //since flights tab pressed status will be flight
        searchTextField.text = ""       //resetting text
        filteredHotelData.removeAll()   //reset data
        filteredFlightData.removeAll()
        collectionView.reloadData()   //reloading collection view.
        flightsTabButton.setImage(UIImage(named: "flights-selected"), for: .normal) // images changed to see which tab is currently active.
        hotelsTabButton.setImage(UIImage(named: "hotels-deselected"), for: .normal)
        flightViewModel.viewDelegate = self
        flightViewModel.didViewLoad() // we are calling this method to fetch data like in flights folder
    }
    
    @IBAction func hotelTabPressed(_ sender: UIButton) {
        self.noDataImage.image = nil
        searchTabStatus = "hotel"
        searchTextField.text = ""
        filteredHotelData.removeAll()
        filteredFlightData.removeAll()
        collectionView.reloadData()
        hotelsTabButton.setImage(UIImage(named: "hotels-selected"), for: .normal)
        flightsTabButton.setImage(UIImage(named: "flights-deselected"), for: .normal)
        hotelViewModel.viewDelegate = self
        hotelViewModel.didViewLoad()
    }
    
    func SetupUI() {
        hotelsTabButton.setImage(UIImage(named: "hotels-deselected"), for: .normal)
        self.dismissKeyboard()
        collectionView.register(.init(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        searchTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.text = textField.text!.replacingOccurrences(of: "ı", with: "i")
        
        print(textField.text!)
        print("dog")
        if searchTabStatus == "hotel" {
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
        
        //flight search part
        if searchTabStatus == "flight" {
            
            //if query has less than 3 letters , there will be no data shown as expected
            if query.count < 3 {
                self.filteredFlightData.removeAll()
                self.collectionView.reloadData()
            }
            filteredFlightData.removeAll()
            
            //checking the items if contains query
            for item in flightItems {
                if item.name.lowercased().contains(query.lowercased()) {
                    filteredFlightData.append(item)
                    print(filteredFlightData.count)
                }
            }
            
            //if query has more than 2 letters, data will be loaded
            if query.count > 2{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //0.5 sec delay for loading
                    self.collectionView.reloadData()
                }
                if filteredFlightData.count == 0 { //if no matches, no data image will be shown
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.noDataImage.image = UIImage(named: "nodata")
                    }
                }
            }
            
            //when user start deleting letters and query has down to 2, no data image will be nil, since we are not searching by 2 or less letters.
            if query.count < 3 {
                noDataImage.image = nil
                self.filteredFlightData.removeAll()
                self.collectionView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
            }
        }
        
        //Hotel search part are same as flight
        else {
            
            if query.count < 3 {
                self.filteredHotelData.removeAll()
                self.collectionView.reloadData()
            }
            filteredHotelData.removeAll()
            for item in hotelItems {
                if item.name.lowercased().contains(query.lowercased()) {
                    filteredHotelData.append(item)
                }
            }
            if query.count > 2{
                if filteredHotelData.count == 0 {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.collectionView.reloadData()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.noDataImage.image = UIImage(named: "nodata")
                    }
                }
            }
            if query.count < 3 {
                noDataImage.image = nil
                self.filteredHotelData.removeAll()
                self.collectionView.reloadData()
            }
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
        if searchTabStatus == "flight" {
            if !filteredFlightData.isEmpty {
                noDataImage.image = nil
                return filteredFlightData.count
            }
            else {
                return 0
            }
        }
        else {
            if !filteredHotelData.isEmpty {
                noDataImage.image = nil
                return filteredHotelData.count
            }
            else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if searchTabStatus == "flight" {
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
        
        if searchTabStatus == "flight" {
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
                //this part is to avoid runtime errors
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
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }
        else {
            searchTextField.placeholder = "Write something"
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

