//
//  PixarImageViewModel.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//

import Foundation
protocol PixarImageViewHandler: AnyObject {
    func showLoading()
    func hideLoading()
    func didReceiveData()

}

protocol PixarImageViewModelProtocol {
    func getData(searchQuery: String, page: Int)
}

class PixarImageViewModel {
    private let serviceApi: ServiceApi?
    weak var delegate: PixarImageViewHandler?
    var webImage: [WebImage]?
    
    init(serviceApi: ServiceApi) {
        self.serviceApi = serviceApi
    }
    
    func getData(searchQuery: String, page: Int) {
        delegate?.showLoading()
        serviceApi?.getImageLinks(searchString: searchQuery, pageNumber: page) { result in
            switch result {
            case .failure:
                self.delegate?.hideLoading()
            case .success(let image):
                let receivedImage = image.hits.compactMap { WebImage(subPixarImage: $0)}
                self.webImage = receivedImage
                self.delegate?.didReceiveData()
            }
            self.delegate?.hideLoading()
        }
    }
}
