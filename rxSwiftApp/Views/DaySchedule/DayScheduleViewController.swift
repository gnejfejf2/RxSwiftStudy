//
//  SimpleViewController.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture


class DayScheduleViewController: UIViewController , ViewSettingProtocol {
    
  
    
    let daysScheduleCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: 120, height: 40)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DayScheduleCollectionViewCell.self, forCellWithReuseIdentifier: DayScheduleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    
    let emptryView = UIView().then{
        $0.backgroundColor = .primaryColor
    }

    var scheduleAdd = UIBarButtonItem().then{
        $0.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.mainContents,
        ], for: .normal)
        $0.title = "스케줄 추가하기"
    }
    
    

    private let disposeBag = DisposeBag()
    
    var viewModel : DayScheduleViewModel?
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting()
    }
    
    func uiDrawing() {
        view.backgroundColor = .primaryColorReverse
        view.addSubview(daysScheduleCollectionView)
        view.addSubview(emptryView)
        daysScheduleCollectionView.snp.makeConstraints { make in
          
            make.edges.equalTo(view.safeAreaLayoutGuide)
        
        }
        
        emptryView.snp.makeConstraints { make in
            make.edges.equalTo(daysScheduleCollectionView)
        }
    }
    
    func uiSetting() {

        
        navigationBarSetting()
        navigationBarTitleSetting("1월 23일")
       
        navigationController?.navigationBar.topItem?.setRightBarButton(scheduleAdd, animated: true)
        
        daysScheduleCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
    }
    
    func uiBinding() {
        viewModel?.output.daySchedules
            .map { $0.count > 0 }
            .bind(to: emptryView.rx.isHidden)
            .disposed(by: disposeBag)
        
        emptryView.rx.tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _  in
                self?.viewModel?.output.daySchedules.accept([DaysModel(name: "1월1일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월2일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월3일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월4일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월5일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월6일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월7일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월8일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월9일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월10일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월11일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월12일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월13일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월14일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"])])
            })
            .disposed(by: disposeBag)

        
        viewModel?.output.daySchedules
            .bind(to: daysScheduleCollectionView.rx.items(cellIdentifier: DayScheduleCollectionViewCell.identifier, cellType: DayScheduleCollectionViewCell.self)) {
                (row, element, cell) in
                cell.uiSetting(element.name)
            }.disposed(by: disposeBag)
    }
    
    func eventBinding() {
        
    }
    

}

extension DayScheduleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: UIScreen.main.bounds.width , height: 60)
    }
}
