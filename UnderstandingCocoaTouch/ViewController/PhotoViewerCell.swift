//
//  PhotoViewerCell.swift
//  UnderstandingCocoaTouch
//
//  Created by Ayemere  Odia  on 08/06/2022.
//

import UIKit

class PhotoViewerCell: UICollectionViewCell {
    private let imageView: DownloadableImageView = {
        let view = DownloadableImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Open Sans", size: 12)
        label.textColor = .white
        return label
    }()
    
    private let tagBackgroundView: UIView = {
        let opacityView = UIView()
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.layer.cornerRadius = 6
        opacityView.layer.opacity = 0.5
        opacityView.backgroundColor = .darkGray
        return opacityView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraint()
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraint() {
        addSubview(imageView)
        imageView.addSubview(tagBackgroundView)
        tagBackgroundView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            tagBackgroundView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5),
            tagBackgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -25),
            
            tagLabel.topAnchor.constraint(equalTo: tagBackgroundView.topAnchor, constant: 3),
            tagLabel.trailingAnchor.constraint(equalTo: tagBackgroundView.trailingAnchor, constant: -3),
            tagLabel.bottomAnchor.constraint(equalTo: tagBackgroundView.bottomAnchor, constant: -3),
            tagLabel.leadingAnchor.constraint(equalTo: tagBackgroundView.leadingAnchor, constant: 3)
        ])
    }
    
    func setImage(name: String?) {
        guard let name = name else {
            return
        }

        imageView.downloadWithUrlSession(at: self, urlStr: name)
    }
    
    func setTagTitle(title: String?) {
        tagLabel.text = title
    }
}
