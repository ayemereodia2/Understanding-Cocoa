import UIKit

private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    public var viewModel: PixarImageViewModel?
    private var hits: Hit?
    var isLoading = false
    var pageCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PhotoViewerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel?.delegate = self
        viewModel?.getData(searchQuery: "Books", page: 1)
    
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard let images = hits?.images else {
            return 0
        }
        
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoViewerCell else { return UICollectionViewCell() }
    
        // Configure the cell
        cell.setImage(name: hits?.images[indexPath.row].webformatURL)
        cell.setTagTitle(title: "books")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width - 20 ) / 2 , height: (view.frame.height - 20 ) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You picked cell on \(indexPath.row)")
    }
}

extension PhotoCollectionViewController: PixarImageViewHandler {
    func showLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.show(viewContoller: self)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.hide()
        }
    }
    
    func didReceiveData(images: Hit?) {
        DispatchQueue.main.async {
            self.hits = images
            self.collectionView.reloadData()
        }
    }
}

extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let images = hits?.images {
            if indexPath.row == images.count - 1 {
                pageCount += 1
                
            }
        }
    }
}
