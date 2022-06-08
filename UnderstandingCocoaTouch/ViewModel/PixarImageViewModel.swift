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
    func didReceiveData(images: Hit?)

}

protocol PixarImageViewModelProtocol {
    func getData(searchQuery: String, page: Int)
}

class PixarImageViewModel {
    private let serviceApi: ServiceApi?
    weak var delegate: PixarImageViewHandler?
    
    init(serviceApi: ServiceApi) {
        self.serviceApi = serviceApi
    }
    
    func getData(searchQuery: String, page: Int) {
        delegate?.showLoading()
        serviceApi?.getImageLinks(searchString: searchQuery, pageNumber: page) { result in
            switch result {
            case .failure:
                self.delegate?.didReceiveData(images: nil)
            case .success(let image):
                let receivedImage = image.hits.compactMap { WebImage(subPixarImage: $0)}
                self.delegate?.didReceiveData(images: Hit(images: receivedImage))
            }
            self.delegate?.hideLoading()
        }
    }
}
