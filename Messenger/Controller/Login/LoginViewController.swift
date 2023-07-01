//
//  LoginViewController.swift
//  Messenger
//
//  Created by Ярослав Вербило on 2023-06-20.
//

import UIKit

protocol LoginViewControllerDelegate {
    func openRegVc()
    func openAuthVc()
    func startApp()
    func closeVc()
}


//let closeBar = UIButton()


class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let slidesSlider = SliderSlides()
    var slides: [Slides] = []
    let pageControl = UIPageControl()
    var authVc: AuthViewController!
    var regVc: RViewController!
    var logVc: LoginViewController!
    
    
    var delegate: LoginViewControllerDelegate!


    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configPageControl()
        
        slides = slidesSlider.getSlides()
        
        setupViews()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.barTintColor = .white
        
//        let butt = createBarButton(imageName: "phone", selector: #selector(closeAction))
        
//        navigationItem.rightBarButtonItem = butt
//        butt.isHidden = true
        
//        closeBar.setImage(UIImage(named: "close"), for: .normal)
//        closeBar.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        closeBar.tintColor = .white
//        closeBar.imageView?.contentMode = .scaleAspectFit
//        closeBar.contentVerticalAlignment = .fill
//        closeBar.contentHorizontalAlignment = .fill
//        closeBar.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
//        let menuBarItem = UIBarButtonItem(customView: closeBar)
//        navigationItem.rightBarButtonItem = menuBarItem
//        closeBar.isHidden = true
        
    }
    
    func configPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 876),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        pageControl.numberOfPages = slides.count
        pageControl.pageIndicatorTintColor = UIColor(red: 178/255, green: 190/255, blue: 195/255, alpha: 1)
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundStyle = .automatic
    }
    
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SlideCollectionViewCell.self, forCellWithReuseIdentifier: SlideCollectionViewCell.reuseId)
    }
    

}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reuseId, for: indexPath) as! SlideCollectionViewCell
        
        cell.delegate = self
        let slide = slides[indexPath.row]
        cell.configure(slide: slide)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
                pageControl.currentPage = indexPath.row
            }
    }
    
    
    
}


extension LoginViewController: LoginViewControllerDelegate {
    
    func openAuthVc() {
        if authVc == nil {
            authVc = AuthViewController() as AuthViewController?
        }
//        navigationController?.pushViewController(authVc, animated: true)
        authVc.delegate = self
        self.view.insertSubview(authVc.view, at: 1)
//        closeBar.isHidden = false

        
    }
    
    func openRegVc() {
        if regVc == nil {
            regVc = RViewController() as RViewController?
        }
//        navigationController?.pushViewController(regVc, animated: true)
        regVc.delegate = self
        self.view.insertSubview(regVc.view, at: 1)
//        closeBar.isHidden = false


    }
    
    func closeVc() {
        if authVc != nil {
            authVc.view.removeFromSuperview()
            authVc = nil
        }
        if regVc != nil {
            regVc.view.removeFromSuperview()
            regVc = nil
        }
        
    }
    
    @objc func closeAction() {
        if authVc != nil {
            authVc.view.removeFromSuperview()
            authVc = nil
//            closeBar.isHidden = true

        }
        if regVc != nil {
            regVc.view.removeFromSuperview()
            regVc = nil
//            closeBar.isHidden = true

        }
    }
    
    func startApp() {
        let startVc = AppViewController()
        self.view.insertSubview(startVc.view, at: 2)
    }
}
