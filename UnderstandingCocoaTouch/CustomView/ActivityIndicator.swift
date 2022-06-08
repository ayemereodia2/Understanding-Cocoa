//
//  ActivityIndicator.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//
import UIKit

class ActivityIndicator {
    static var activityIndicator = UIActivityIndicatorView(style: .large)
    
    static func show(viewContoller: UIViewController) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        viewContoller.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: viewContoller.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: viewContoller.view.centerYAnchor).isActive = true
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
