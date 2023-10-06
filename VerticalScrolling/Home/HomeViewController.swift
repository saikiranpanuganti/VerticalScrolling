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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        collectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
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
//        homeLayout = Bundle.main.decode("homelayout.json")
//        for carousel in homeLayout?.data.content.carouselsV1 ?? [] {
//            getCarousel(carousel: carousel)
//        }
        
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 270, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 370, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 470, isHidden: false, carouselType: .mpx))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false))
        homeData.append(HomeDataModel(carouselHeight: 570, isHidden: false, carouselType: .mpx))
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
            print("$$HomeCollectionViewFlowLayout Controller: shouldUpdateFocusIn y - \(cellLocation.y) ms - \(Date().timeIntervalSince1970*1000)")
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let indexPath = context.nextFocusedIndexPath, let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenter = CGPoint(x: cell.bounds.origin.x, y: cell.bounds.origin.y)
            let cellLocation = cell.convert(cellCenter, to: collectionView)
            print("$$HomeCollectionViewFlowLayout Controller: didUpdateFocusIn - \(cellLocation.y) ms - \(Date().timeIntervalSince1970*1000) carouselType - \(homeData[indexPath.item].carouselType.rawValue)")
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell {
            cell.configureUI(index: indexPath.item)
            
            return cell
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
}
