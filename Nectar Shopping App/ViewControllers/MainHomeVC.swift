//
//  MainHomeVC.swift
//  Nectar Shopping App
//
//  Created by Goru Saini on 22/06/26.
//

import UIKit

class MainHomeVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet weak var lblLocationName : UILabel!
    @IBOutlet weak var vwBackground : UIView!
    @IBOutlet weak var posterCollView : UICollectionView!
    @IBOutlet weak var ExclusiveCollView : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var txtFldSearch : UITextField!
    
    //MARK: - Properties
    
    let viewModel = HomeVM()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        posterCollView.delegate = self
        posterCollView.dataSource = self
        posterCollView.register(UINib(nibName: "PosterCVC", bundle: nil), forCellWithReuseIdentifier: "PosterCVC")
        ExclusiveCollView.delegate = self
        ExclusiveCollView.dataSource = self
        ExclusiveCollView.register(UINib(nibName: "ExclusiveCVC", bundle: nil), forCellWithReuseIdentifier: "ExclusiveCVC")
    }
    
    //MARK: - Functions
    private func setUpUI(){
        lblLocationName.textColor = AppColors.textBlack
        lblLocationName.font = AppFonts.semibold.with(size: 18)
        
        if  let savedLocation = UserDefaults.standard.string(forKey: "selectedLocation"){
            lblLocationName.text = savedLocation
        }
        posterCollView.layer.cornerRadius = 5
        posterCollView.layer.masksToBounds = true
        posterCollView.showsHorizontalScrollIndicator = false
        posterCollView.isPagingEnabled = true
        
        pageControl.numberOfPages = viewModel.posterCount
        pageControl.currentPage = 0
        
        setUpSearchBar(textField:txtFldSearch)
        
    }
    private func setUpSearchBar(textField:UITextField){
        textField.configureSearch(title: "Search Store", font: AppFonts.medium.with(size: 16), bgClr: AppColors.midGreen, cornerRadius: 15, border: 0, borderColor: nil)
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = AppColors.textGray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        containerView.backgroundColor = .clear
        containerView.addSubview(imageView)
        
        textField.leftView = containerView
        textField.leftViewMode = .always
    }
}

//MARK: - Colection View
extension MainHomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case posterCollView :
            return viewModel.posterCount
        case ExclusiveCollView :
            return 3
        default :
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case posterCollView :
            guard  let cell = posterCollView.dequeueReusableCell(withReuseIdentifier: "PosterCVC", for: indexPath) as? PosterCVC else { return UICollectionViewCell() }
            let imagename = viewModel.poster(at: indexPath.item)
            cell.configure(with: imagename)
            return cell
        case ExclusiveCollView :
            let cell = ExclusiveCollView.dequeueReusableCell(withReuseIdentifier: "ExclusiveCVC", for: indexPath) as! ExclusiveCVC
//            cell.imgVwItem.image = UIImage(named: "BananaImage")
            return cell
        default :
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case posterCollView :
            return CGSize(width: posterCollView.frame.width, height: posterCollView.frame.height)
        case ExclusiveCollView :
            return CGSize(width: 150, height: 200)
        default :
            return CGSize(width: 150, height: 200)
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/scrollView.frame.width)
        pageControl.currentPage = page
    }

}
