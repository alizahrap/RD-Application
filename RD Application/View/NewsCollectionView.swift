//
//  NewsCollectionView.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class NewsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var newsImages = [UIImage]()
    var newsPageControl = NewsPageControl()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        startTimer()
        
        isScrollEnabled = false
        register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getNewsPageControl(newsPageControl: NewsPageControl) {
        self.newsPageControl = newsPageControl
    }
    
    func setNewsImages(newsImages: [UIImage]) {
        self.newsImages = newsImages
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        cell.newsImageView.image = newsImages[indexPath.row % newsImages.count]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // TODO: - implement a change of current page
        //let pageWidth = scrollView.frame.width
        newsPageControl.currentPage = (indexPathsForVisibleItems.first?.row)!
        
        //scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionView.ScrollPosition#>, animated: <#T##Bool#>)
        
        //newsPageControl.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    @objc func scrollToNextCell() {
        let cellSize = CGSize(width: frame.width, height: frame.height)

        //let contentOffset = self.contentOffset

        scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        
        //let contentOffset = self.contentOffset + cellSize.width
        
        newsPageControl.currentPage = Int(contentOffset.x / cellSize.width) % newsImages.count
        print(contentOffset.x, newsPageControl.currentPage)
    }
    
    func startTimer() {
         _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        // TODO: - implement a change of current page
//        //print(#line, #function, indexPath.row)
//        //scrollToItem(at: indexPath, at: .left, animated: true)
//       // newsPageControl.currentPage = indexPath.row % newsImages.count
//
//    }
}
