//
//  BaseViewController.swift
//  RipRoadNYCSubway
//
//  Created by Daniel Spady on 2021-04-01.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var subwayResult: SubwayResult?
    var subwayLineList: Set<String>?
    var selectedLine: String?
        
    lazy var loadingView: UIView = { [unowned self] in
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0
        
        view.addSubview(self.loadingSpinner)
        self.loadingSpinner.backgroundColor = UIColor.clear
        self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        self.loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.loadingSpinner.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.loadingSpinner.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.view.addSubview(view)
        return view
    }()
    
    lazy var loadingSpinner: AnimatedLoader = AnimatedLoader()
    
    func loadData(for tableView: UITableView, collectionView: UICollectionView, errorView: UIView) {
        
        hideErrorView(with: errorView)
        showLoadingView(animated: true, after: 3.0)
        
        SubwayUtility.subwayJSONObject(SubwayRequestLocal()) { response in
            DispatchQueue.main.async {
                if response.result == nil {
                    self.handleResult(subwayResult: nil)
                    self.hideLoadingView()
                    self.showErrorView(with: errorView)
                } else if let result = response.result {
                    let subwayResult = SubwayResult(json: result)
                    self.handleResult(subwayResult: subwayResult)
                    self.hideLoadingView()
                    tableView.reloadData()
                    collectionView.reloadData()
                } else if let error = response.error {
                    self.handleResult(subwayResult: nil)
                    self.showErrorView(with: errorView)
                    dump(error)
                }
            }
        }
    }
    
    func handleResult(subwayResult: SubwayResult?) {
        if let subwayResult = subwayResult {
            self.subwayResult = subwayResult
            self.subwayLineList = subwayResult.listOfSubwayLines()
            self.selectedLine = nil
        } else {
            self.subwayResult = nil
            self.subwayLineList = nil
            self.selectedLine = nil
        }
    }
    
    func showErrorView(animated: Bool = true, after delay: TimeInterval? = nil, with errorView: UIView) {
        UIView.animate(withDuration: animated ? 0.3 : 0.0, delay: delay ?? 0, options: [], animations: {
            errorView.isHidden = false
        })
    }
    
    func hideErrorView(with errorView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            errorView.isHidden = true
        })
    }
        
    func showLoadingView(animated: Bool = true, after delay: TimeInterval? = nil) {
        view.bringSubviewToFront(loadingView)
        loadingSpinner.start()
        UIView.animate(withDuration: animated ? 0.3 : 0.0, delay: delay ?? 0, options: [], animations: {
            self.loadingView.alpha = 1
        })
    }
    
    func hideLoadingView() {
        self.loadingSpinner.stop()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0
        })
    }
}
