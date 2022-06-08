//
//  SearchViewController.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    var searchQuery: String = "" {
        didSet {
            
        }
    }
    weak var delegate: SearchBarActionHandler?
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "what are you looking for?"
        searchBar.barStyle = .default
        return searchBar
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans", size: 10)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        //button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(searchButton)
        stackView.setCustomSpacing(5, after: searchButton)
        searchBar.delegate = self
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: stackView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -30),
            searchBar.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor),
            searchBar.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -5),
            searchBar.heightAnchor.constraint(equalToConstant: 44),

            searchButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -5),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            searchButton.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}

extension SearchViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        delegate?.didReceive(text: text)
        searchBar.endEditing(true)
    }
    
}

