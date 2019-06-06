//
//  NewsCollectionView.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class NewsCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Stored Properties
    var newsImages = [UIImage]()
    var newsPageControl = UIPageControl()
    
    // MARK: - Initializers
    init() {
        /// create layout
        let layout = UICollectionViewFlowLayout()
        /// setup layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        /// configure collection view
        configureCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionView Methods
extension NewsCollectionView {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: frame.height)
    }
}

// MARK: - ScrollView Methods
extension NewsCollectionView {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        newsPageControl.currentPage = Int(contentOffset.x / frame.width) % newsImages.count
    }
    /// scroll to next cell
    @objc func scrollToNextCell() {
        scrollRectToVisible(CGRect(x: contentOffset.x + frame.width, y: contentOffset.y, width: frame.width, height: frame.height), animated: true)
    }
}

// MARK: - Setup CollectionView
extension NewsCollectionView {
    func configureCollectionView() {
        register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        delegate = self
        dataSource = self
        /// start timer for scrolling images
        startTimerForScrolling()
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        isScrollEnabled = false
    }
    
    /// Set news page control for collection view
    ///
    /// - Parameter newsPageControl: instance of NewsPageControl class
    func setNewsPageControl(newsPageControl: UIPageControl) {
        self.newsPageControl = newsPageControl
    }
    
    /// Set news images for collection view
    ///
    /// - Parameter newsImages: array of news images
    func setNewsImages(newsImages: [UIImage]) {
        self.newsImages = newsImages
    }
    /// start timer for scrolling images
    func startTimerForScrolling() {
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
}

// MARK: - CollectionViewDataSource Methods
extension NewsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Int16.max)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        cell.newsImageView.image = newsImages[indexPath.row % newsImages.count]
        
        return cell
    }
}
