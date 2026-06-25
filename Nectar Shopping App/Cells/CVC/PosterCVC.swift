//
//  PosterCVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 23/06/26.
//

import UIKit

class PosterCVC: UICollectionViewCell {
    @IBOutlet weak var imageView : UIImageView!
//    @IBOutlet weak var pageController : UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(with imageName : String) {
        imageView.image = UIImage(named: imageName) ?? UIImage(systemName: "person")
    }
}
