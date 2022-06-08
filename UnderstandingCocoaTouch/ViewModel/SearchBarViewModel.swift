//
//  SearchBarViewModel.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//

import Foundation

protocol SearchBarActionHandler: AnyObject {
    func didReceive(text: String?)
}

class SearchBarViewModel {
    weak var searchDelegate: SearchBarActionHandler?
    
    func onReceive(searchQuery: String?) {
        searchDelegate?.didReceive(text: searchQuery)
    }
}
