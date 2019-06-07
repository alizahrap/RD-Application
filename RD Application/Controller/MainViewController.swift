//
//  MainViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 03/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var categoryButtonsCollection: [UIButton]!
    
    // MARK: - Stored Properties
    let newsCollectionView = NewsCollectionView()
    let newsPageControl = UIPageControl()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
}

// MARK: - IB Actions
extension MainViewController {
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
    }
}

// MARK: - Setup Appearance
extension MainViewController {
    /// setup user interface
    func setupUI() {
        addNavigationTitleImage()
        addCollectionView()
        addPageControl()
        configureButtonsAppearance()
        configureNavigationBackButton()
        
        /// pass data to NewsCollectionView class
        newsCollectionView.setNewsPageControl(newsPageControl: newsPageControl)
        newsCollectionView.setNewsImages(newsImages: NewsImages.fetchImages())
    }
    
    /// add navigation title image view
    func addNavigationTitleImage() {
        /// create container for image view
        let containerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 27))

        let titleImage = UIImage(named: "namedLogo")
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 27))
        
        /// configure image view
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = titleImage
        
        /// add title view with container image view
        containerImageView.addSubview(titleImageView)
        navigationItem.titleView = containerImageView
    }
    
    /// configure navigation back button
    func configureNavigationBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// add buttons background
    func configureButtonsAppearance() {
        for button in categoryButtonsCollection {
            button.layer.cornerRadius = 10
            button.imageView?.contentMode  = .scaleAspectFit
            button.subviews.first?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
        }
    }
    
    /// add page control
    func addPageControl() {
        /// configure page control
        newsPageControl.numberOfPages = NewsImages.allCases.count
        newsPageControl.hidesForSinglePage = true
        newsPageControl.isEnabled = false
        newsPageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(newsPageControl)
        /// constrain page control
        newsPageControl.bottomAnchor.constraint(equalTo: newsCollectionView.bottomAnchor).isActive = true
        newsPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// add collection view
    func addCollectionView() {
        view.addSubview(newsCollectionView)
        
        /// constrain collection view
        newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        newsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.4).isActive = true
    }
}
