//
//  MainViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 03/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var categoryButtonsCollection: [UIButton]!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var noveltyImageView: UIImageView!
    
    //MARK: - Stored Properties
    var newsCollectionView = NewsCollectionView()
    let newsImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// setup user interface
        setupUI()
        
        view.addSubview(newsCollectionView)
        
        newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        //guard let navigationBarHeight = navigationController?.navigationBar.frame.size.height else { return }
        newsCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        
        newsCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
        setupButtonsAppearance()
        setupNoveltyImageView()
        
        newsCollectionView.setNewsImages(newsImages: newsImages)
    }
    
    /// add navigation title image view
    func addNavigationTitleImage() {
        let containerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 27))
        
        let titleImage = UIImage(named: "namedLogo")
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 27))
        
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = titleImage
        containerImageView.addSubview(titleImageView)
        
        navigationItem.titleView = containerImageView
    }

    /// add buttons' background
    func setupButtonsAppearance() {
        for button in categoryButtonsCollection {
            button.layer.cornerRadius = 10
            button.imageView?.contentMode  = .scaleAspectFit
            button.subviews.first?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
        }
    }
    
    /// setup novelty image view
    func setupNoveltyImageView() {
        noveltyImageView.contentMode = .scaleAspectFill
        noveltyImageView.image = #imageLiteral(resourceName: "backpack")
    }
    
//    func fetchNewsImages() {
//        let backpackImage = UIImage(named: "backpack")
//        let
//    }
}
