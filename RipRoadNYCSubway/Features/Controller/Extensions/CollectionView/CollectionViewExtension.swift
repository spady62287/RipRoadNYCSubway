//
//  CollectionViewExtension.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-05.
//

import UIKit

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
            let viewModel = subwayLineList.node(at: indexPath.row)
            if let value = viewModel?.value {
                cell.subwayLine.text = value.itemValue
                cell.backgroundColor = value.isSelected ? .yellow : .gray
                cell.subwayLine.textColor = .black
                return cell
            }
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let subwayLineList = self.subwayLineList {
            let viewModel = subwayLineList.node(at: indexPath.row)
            if let viewModel = viewModel {
                                
                if viewModel.value.isSelected {
                    viewModel.value.isSelected = false
                    self.selectedLine = nil
                } else {
                    viewModel.value.isSelected = true
                    self.selectedLine = viewModel.value.itemValue
                    
                    if let previousPath = previousPath {
                        let viewModel = subwayLineList.node(at: previousPath.row)
                        if let viewModel = viewModel {
                            viewModel.value.isSelected = false
                        }
                    }
                    
                    previousPath = indexPath
                }
                                
                self.tableView.reloadData()
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
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
