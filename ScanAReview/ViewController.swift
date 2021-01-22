//
//  ViewController.swift
//  ScanAReview
//
//  Created by Mirko Braic on 21/01/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [ReviewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination.children.first as? ReviewInputViewController {
            destination.saveReviewCallback = { [weak self] reviewText in
                guard let self = self else { return }
                let review = ReviewModel(text: reviewText, color: .label, sentiment: "None")
                self.dataSource.append(review)
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
        
        let review = dataSource[indexPath.row]
        cell.sentiment.text = review.sentiment
        cell.text.text = review.text
        cell.contentView.layer.borderColor = review.color.cgColor
        cell.cornerColor = review.color
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
