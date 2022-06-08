//
//  ViewController.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 07/06/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var greetingsButtons: UIButton!
    let support = SupportViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        support.delegate = self
        greetingsButtons.addTarget(self, action: #selector(updateMessageTitle), for: .touchUpInside)
    }
    
    @objc func updateMessageTitle(_ sender: UIButton) {
        support.handButtonTap()
    }
}

extension ViewController: ViewsDidChangeHandler {
    func handleGreetingsTapped() {
        messageLabel.text = "Message is clean"
    }
}

protocol ViewsDidChangeHandler: AnyObject {
    func handleGreetingsTapped()
}

class SupportViewController {
    weak var delegate: ViewsDidChangeHandler?
    
    func handButtonTap() {
        delegate?.handleGreetingsTapped()
    }
}
