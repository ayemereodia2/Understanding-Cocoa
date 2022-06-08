import UIKit

private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    public var viewModel: PixarImageViewModel?
    private var hits: [WebImage] = []
    var isLoading = false
    var pageCount = 1
    var searchQuery: String? = "" {
        didSet {
            hits = []
            viewModel?.getData(searchQuery: searchQuery ?? "Baby", page: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PhotoViewerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel?.delegate = self
        viewModel?.getData(searchQuery: searchQuery ?? "Baby", page: 1)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         hits.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoViewerCell else { return UICollectionViewCell() }
    
        // Configure the cell
        cell.setImage(name: hits[indexPath.row].webformatURL)
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
    
    func didReceiveData() {
        guard let images = viewModel?.webImage else { return }
        DispatchQueue.main.async {
            self.hits.append(contentsOf: images)
            self.collectionView.reloadData()
        }
    }
}

extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == hits.count - 1 {
            pageCount += 1
            viewModel?.getData(searchQuery: searchQuery ?? "Baby", page: pageCount)
        }
    }
}
