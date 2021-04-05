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
