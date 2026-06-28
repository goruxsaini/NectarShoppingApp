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
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var posterCollView : UICollectionView!
    @IBOutlet weak var ExclusiveCollView : UICollectionView!
    @IBOutlet weak var bestSellingCollView : UICollectionView!
    @IBOutlet weak var groceriesCollView : UICollectionView!
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
        
        bestSellingCollView.delegate = self
        bestSellingCollView.dataSource = self
        bestSellingCollView.register(UINib(nibName: "ExclusiveCVC", bundle: nil), forCellWithReuseIdentifier: "ExclusiveCVC")
        
        groceriesCollView.delegate = self
        groceriesCollView.dataSource = self
        groceriesCollView.register(UINib(nibName: "GroceriesCVC", bundle: nil), forCellWithReuseIdentifier: "GroceriesCVC")
        
        scrollView.showsVerticalScrollIndicator = false
        
        bindViewModel()
        viewModel.fetchProducts()
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
        
        ExclusiveCollView.showsHorizontalScrollIndicator = false
        bestSellingCollView.showsHorizontalScrollIndicator = false
        groceriesCollView.showsHorizontalScrollIndicator = false
        
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
    
//MARK: BindViewModel
    private func bindViewModel() {
        viewModel.onDataUploaded = { [weak self] in
            DispatchQueue.main.async {
                self?.ExclusiveCollView.reloadData()
                self?.posterCollView.reloadData()
                self?.bestSellingCollView.reloadData()
                self?.groceriesCollView.reloadData()
            }
        }
        viewModel.onError = { errorMessage in
            print("Error: \(errorMessage)")

        }
    }
}

//MARK: - Colection View
extension MainHomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case posterCollView :
            return viewModel.posterCount
        case ExclusiveCollView :
            return viewModel.exclusiveCount
        case bestSellingCollView :
            return viewModel.bestSellingCount
        case groceriesCollView :
            print("grocery : \(viewModel.groceryCount)")
            return viewModel.groceryCount
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
            let product = viewModel.exclusiveProducts(at: indexPath.item)
            cell.configure(with: product)
            return cell
            
        case bestSellingCollView :
            let cell = bestSellingCollView.dequeueReusableCell(withReuseIdentifier: "ExclusiveCVC", for: indexPath) as! ExclusiveCVC
            let bestSellingProduct = viewModel.bestSellingProducts(at: indexPath.item)
            cell.configure(with: bestSellingProduct )
            return cell
            
        case groceriesCollView :
            let cell = groceriesCollView.dequeueReusableCell(withReuseIdentifier: "GroceriesCVC", for: indexPath) as! GroceriesCVC
            let product = viewModel.groceryProducts(at : indexPath.item)
            cell.configure(with: product)
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
            return CGSize(width: 150, height: 210)
            
        case groceriesCollView :
            return CGSize(width: 200, height: 80)
            
        default :
            return CGSize(width: 150, height: 210)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case ExclusiveCollView :
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case bestSellingCollView :
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case groceriesCollView :
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        default :
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case ExclusiveCollView :
            return 15
        
        case bestSellingCollView :
            return 15
        case groceriesCollView :
            return 15
        default :
            return 0
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/scrollView.frame.width)
        pageControl.currentPage = page
    }

}
