//
//  ViewController.swift
//  shoppingApp
//
//  Created by Bayram Yeleç on 10.10.2024.
//

import UIKit

class FeedVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var footerCollectionView: UICollectionView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var manager = FetchDataManager()
    
    var timer : Timer?
    var currentIndex = 0
    
    var headerCol = [UIImage(named: "macbook"),UIImage(named: "iphone16"), UIImage(named: "iphone"), UIImage(named: "ai")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Anasayfa"
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        pageController.numberOfPages = headerCol.count
        
        manager.fetchData {
            self.footerCollectionView.reloadData()
        }
        
        footerCollectionView.dataSource = self
        footerCollectionView.delegate = self
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        
        
        let headerLayout = UICollectionViewFlowLayout()
        headerLayout.scrollDirection = .horizontal
        headerLayout.minimumLineSpacing = 1
        headerCollectionView.collectionViewLayout = headerLayout
        
        
        
        let footerLayout = UICollectionViewFlowLayout()
        footerLayout.scrollDirection = .vertical
        footerLayout.minimumLineSpacing = 5
        footerCollectionView.collectionViewLayout = footerLayout
        footerCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        headerCollectionView.layer.cornerRadius = 10
        
        startTimer()
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(transitionIndex), userInfo: nil, repeats: true)
    }
    
    @objc func transitionIndex() {
        
        currentIndex += 1
        
        if currentIndex >= headerCol.count {
            currentIndex = 0
        }
        
        headerCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentIndex
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == footerCollectionView {
            return manager.models.count
        } else {
            return headerCol.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == footerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
            let model = manager.models[indexPath.row]
            cell.tabBarControllerRef = self.tabBarController
            cell.models = model
            return cell
        } else {
            let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: "onecell", for: indexPath) as! HeaderCell
            cell.headerImage.image = headerCol[indexPath.row]
            cell.layer.cornerRadius = 20
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerCollectionView {
            return CGSize(width: headerCollectionView.bounds.width, height: 200)
        } else {
            let width = (collectionView.bounds.width / 2) - 10
            return CGSize(width: width, height: 180)
        }
    }
}
