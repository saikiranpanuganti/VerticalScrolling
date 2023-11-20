//
//  HomeViewController.swift
//  VerticalScrolling
//
//  Created by SaiKiran Panuganti on 29/09/23.
//

import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var homeLayout: HomeLayoutModel?
    
    var homeData: [HomeDataModel] = []
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [collectionView]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        collectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        collectionView.register(UINib(nibName: "PromoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PromoCollectionViewCell")
        collectionView.register(UINib(nibName: "ExpandingCarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExpandingCarouselCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        if let layout = collectionView?.collectionViewLayout as? HomeCollectionViewFlowLayout {
          layout.delegate = self
        }
        collectionView.reloadData()
    }
    
    func getData() {
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 380, isHidden: false, carouselType: .expanding))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 380, isHidden: false, carouselType: .expanding))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 380, isHidden: false, carouselType: .expanding))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 380, isHidden: false, carouselType: .expanding))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(hideCell), userInfo: nil, repeats: true)
    }
    
    func getUrlString(carousel: HomeLayoutCarousel) -> String {
        return ""
    }
    
    func getCarousel(carousel: HomeLayoutCarousel) {
        let urlString: String = getUrlString(carousel: carousel)
        NetworkAdaptor.urlRequest(urlString: urlString) { data, response, error in
            if let data = data {
                print("data: \(data)")
            }
        }
    }
    
    @objc func hideCell() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = collectionView.collectionViewLayout as? HomeCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionShouldY = cellLocation.y
            }
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let previousIndexPath = context.previouslyFocusedIndexPath, let previousCell = collectionView.cellForItem(at: previousIndexPath) as? PromoCollectionViewCell {
            if let mpxLayout = previousCell.promoCollectionView.collectionViewLayout as? MpxCollectionViewLayout {
                mpxLayout.isFocussed = false
            }
        }
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            if let nextCell = collectionView.cellForItem(at: indexPath) as? PromoCollectionViewCell {
                if let mpxLayout = nextCell.promoCollectionViewLayout {
                    mpxLayout.isFocussed = true
                }
            }
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            if let collectionViewLayout = collectionView.collectionViewLayout as? HomeCollectionViewFlowLayout {
                collectionViewLayout.preferredPositionDidY = cellLocation.y
                collectionViewLayout.focusUpdated = true
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if homeData[indexPath.item].carouselType == .mpx {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCollectionViewCell", for: indexPath) as? PromoCollectionViewCell {
                cell.configureUI(index: indexPath.item, homeData: homeData[indexPath.item])
                
                return cell
            }
        }else if homeData[indexPath.item].carouselType == .expanding {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandingCarouselCollectionViewCell", for: indexPath) as? ExpandingCarouselCollectionViewCell {
                cell.configureUI(index: indexPath.item, homeData: homeData[indexPath.item])
        
                return cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell {
                cell.configureUI(index: indexPath.item, homeData: homeData[indexPath.item])
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: HomeCollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat {
        return homeData[indexPath.item].carouselHeight
    }
}



struct HomeDataModel {
    var carouselHeight: CGFloat
    var isHidden: Bool
    var carouselType: CarouselType = .portrait
}


enum CarouselType: String {
    case mpx
    case portrait
    case expanding
}
