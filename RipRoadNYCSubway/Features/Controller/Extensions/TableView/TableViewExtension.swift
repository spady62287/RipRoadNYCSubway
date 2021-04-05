//
//  TableViewExtension.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-05.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! SubwayStationTableViewCell
        if let subwayResult = self.subwayResult {
            let subwayItemViewModel = subwayResult.itemFrom(indexPath: indexPath, with: self.selectedLine)
            
            if let subwayItemViewModel = subwayItemViewModel {
                let lineViewModel = subwayItemViewModel.subwayDictionary["LINE"]
                let nameViewModel = subwayItemViewModel.subwayDictionary["NAME"]
                let theGeomViewModel = subwayItemViewModel.subwayDictionary["the_geom"]
                
                if let nameViewModel = nameViewModel,
                   let lineViewModel = lineViewModel,
                   let theGeomViewModel = theGeomViewModel {
                    cell.stationName!.text = "Station Name: \(nameViewModel.object)"
                    cell.stationLines!.text = "Station Lines: \(lineViewModel.object)"
                    cell.stationLocation!.text = "Station Location: \(theGeomViewModel.object)"
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
