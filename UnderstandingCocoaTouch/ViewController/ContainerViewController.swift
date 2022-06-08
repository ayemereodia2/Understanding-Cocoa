//
//  ContainerViewController.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var bottomChildVC: PhotoCollectionViewController?
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let bottomVIew: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(bottomVIew)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: stackView.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 104),
            
            bottomVIew.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomVIew.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bottomVIew.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            bottomVIew.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        bottomChildVC = PhotoCollectionViewController(collectionViewLayout: layout)
        guard let bottomChildVC = bottomChildVC else { return }
        let service = PixarBayApi()
        bottomChildVC.viewModel = PixarImageViewModel(serviceApi: service)
        
        bottomChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(bottomChildVC)
        bottomVIew.addSubview(bottomChildVC.view)
        
        
        let topChildVC = SearchViewController()
        topChildVC.delegate =  self
        topChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(topChildVC)
        topView.addSubview(topChildVC.view)
        NSLayoutConstraint.activate([
            topChildVC.view.topAnchor.constraint(equalTo: topView.layoutMarginsGuide.topAnchor),
            topChildVC.view.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            topChildVC.view.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            topChildVC.view.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            
            
            bottomChildVC.view.topAnchor.constraint(equalTo: bottomVIew.topAnchor),
            bottomChildVC.view.trailingAnchor.constraint(equalTo: bottomVIew.trailingAnchor),
            bottomChildVC.view.bottomAnchor.constraint(equalTo: bottomVIew.bottomAnchor),
            bottomChildVC.view.leadingAnchor.constraint(equalTo: bottomVIew.leadingAnchor)
        ])
        topChildVC.didMove(toParent: self)
        bottomChildVC.didMove(toParent: self)
        
        setupStackViewConstraints()
    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ContainerViewController: SearchBarActionHandler {
    func didReceive(text: String?) {
        bottomChildVC?.searchQuery = text
    }
}
