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
    
    
    let emptyView = EmptyView().then{
        $0.contentLabel.text = "등록된 스케줄이 없습니다."
        $0.actionButton.setTitle("바로 등록하기", for: .normal)
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
        view.addSubview(emptyView)
        daysScheduleCollectionView.snp.makeConstraints { make in
          
            make.edges.equalTo(view.safeAreaLayoutGuide)
        
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(daysScheduleCollectionView)
        }
    }
    
    func uiSetting() {

        
        navigationBarSetting()
        navigationBarTitleSetting("1월 23일")
       
        navigationController?.navigationBar.topItem?.setRightBarButton(scheduleAdd, animated: true)
        
        daysScheduleCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        emptyView.delegate = self
        
        
    }
    
    func uiBinding() {
        
        viewModel?.output.daySchedules
            .map { $0.count > 0 }
            .bind(to: emptyView.rx.isHidden)
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


extension DayScheduleViewController : EmptyViewActionProtocol {
    func protocolAction() {
        viewModel?.output.daySchedules.accept([DaysModel(name: "1월1일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월2일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월3일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월4일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월5일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월6일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월7일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월8일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월9일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월10일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월11일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월12일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월13일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월14일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"])])
    }
}
