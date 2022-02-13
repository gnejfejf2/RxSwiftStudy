//
//  StickyHeaderViewController.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/07.
//

import UIKit

class StickyHeaderScrollViewController: UIViewController {
    
    lazy var stickyScrollView : UIScrollView = {
        var view = UIScrollView()
        
        view.addSubview(bottomContentView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //
    var topStackView : UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomContentView  : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stickyHeaderView : UIView?
    
    
    var tempHeader : UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "은하")
        view.contentMode = .scaleToFill
        return view
    }()
    var dommy : UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "은하")
        view.contentMode = .scaleToFill
        return view
    }()
    
    var dommy2 : UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var topStackViewOffSet : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stickyScrollView)
        view.addSubview(topStackView)
        stickyScrollView.delegate = self
        
        
        stickyScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stickyScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stickyScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stickyScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        
        topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        
        
        
        
        bottomContentView.widthAnchor.constraint(equalTo: stickyScrollView.widthAnchor).isActive = true
        
        bottomContentView.topAnchor.constraint(equalTo: stickyScrollView.topAnchor).isActive = true
        bottomContentView.leadingAnchor.constraint(equalTo: stickyScrollView.leadingAnchor).isActive = true
        bottomContentView.trailingAnchor.constraint(equalTo: stickyScrollView.trailingAnchor).isActive = true
        bottomContentView.bottomAnchor.constraint(equalTo: stickyScrollView.bottomAnchor).isActive = true
        
        
        
        bottomContentView.addSubview(dommy2)
        
        dommy2.heightAnchor.constraint(equalToConstant: 3000).isActive = true
        dommy2.widthAnchor.constraint(equalTo: bottomContentView.widthAnchor).isActive = true
        
        dommy2.topAnchor.constraint(equalTo: bottomContentView.topAnchor).isActive = true
        dommy2.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor).isActive = true
        dommy2.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor).isActive = true
        dommy2.bottomAnchor.constraint(equalTo: bottomContentView.bottomAnchor).isActive = true
        
        
        
        //        bottomContentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2).isActive = true
        
        
        
        
        
        stickyHeaderView = tempHeader
        stickyHeaderSetting()
        // Do any additional setup after loading the view.
    }
    
    func stickyHeaderSetting(){
        guard let stickyHeaderView = stickyHeaderView else { return }
        topStackView.addArrangedSubview(dommy)
        topStackView.addArrangedSubview(stickyHeaderView)
        dommy.widthAnchor.constraint(equalToConstant : UIScreen.main.bounds.width).isActive = true
        dommy.heightAnchor.constraint(equalToConstant : 100).isActive = true
        stickyHeaderView.widthAnchor.constraint(equalToConstant : UIScreen.main.bounds.width).isActive = true
        stickyHeaderView.heightAnchor.constraint(equalToConstant : 100).isActive = true
        //        topStackView.sizeToFit()
        DispatchQueue.main.asyncAfter(deadline: Dispatch.DispatchTime.now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.topStackView.sizeToFit()
            self.bottomContentView.layoutMargins = UIEdgeInsets(top: self.topStackView.frame.height, left: 0, bottom: 0, right: 0)
            
        }
        topStackView.backgroundColor = .red
        
    }
}

extension StickyHeaderScrollViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let stickyHeaderView = stickyHeaderView else { return }
        
        let totalOffset = scrollView.contentOffset.y
        var segmentTransform = CATransform3DIdentity // Translate only.
        var mainHeaderTransform = CATransform3DIdentity // Both Scale and Translate.
        
        var headerScaleFactor : CGFloat
        let segmentViewOffset = -totalOffset
        
        if totalOffset < 0 {
            headerScaleFactor = segmentViewOffset / stickyHeaderView.bounds.height * 2
            mainHeaderTransform = CATransform3DScale(mainHeaderTransform , 1.0 + headerScaleFactor , 1.0 + headerScaleFactor , 0)
        } else {
            mainHeaderTransform = CATransform3DTranslate(mainHeaderTransform , 0, 0 , 0)
        }

        topStackView.subviews.forEach{
            $0.layer.transform = mainHeaderTransform
        }
      
        let viewSpacing : CGFloat = CGFloat((topStackView.subviews.count - 1) * 10)
        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset , -(topStackView.frame.height - stickyHeaderView.frame.height + viewSpacing)) , 0)
        topStackView.layer.transform = segmentTransform
    }
}

