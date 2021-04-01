//
//  ViewController.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-03-25.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.loadData(for: tableView, collectionView: collectionView, errorView: errorView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! SubwayStationTableViewCell
        if let subwayResult = self.subwayResult {
            let subwayItemViewModel = subwayResult.itemFrom(indexPath: indexPath, with: self.selectedLine)
            
            if let subwayItemViewModel = subwayItemViewModel {
                let lineViewModel = subwayItemViewModel.subwayDictionary["LINE"]
                let nameViewModel = subwayItemViewModel.subwayDictionary["NAME"]
                let positionViewModel = subwayItemViewModel.subwayDictionary["position"]
                
                if let nameViewModel = nameViewModel,
                   let lineViewModel = lineViewModel,
                   let positionViewModel = positionViewModel {
                    cell.stationName!.text = "Station Name: \(nameViewModel.object)"
                    cell.stationLines!.text = "Station Lines: \(lineViewModel.object)"
                    cell.stationLocation!.text = "Station Location: \(positionViewModel.object)"
                }
            }
        }
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subwayResult = self.subwayResult {
            return subwayResult.numberOfItems(with: self.selectedLine)
        }
        
        return 0
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if let subwayLineList = self.subwayLineList {
            return subwayLineList.count
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! SubwayLineCollectionViewCell
        
        if let subwayLineList = self.subwayLineList {
            let myIndex = indexPath.row
            let subwayLine = Array(subwayLineList)[myIndex]
            cell.subwayLine.text = subwayLine
            return cell
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let subwayLineList = self.subwayLineList {
            let myIndex = indexPath.row
            let subwayLine = Array(subwayLineList)[myIndex]
            self.selectedLine = subwayLine
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
