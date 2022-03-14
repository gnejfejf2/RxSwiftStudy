import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay

protocol MainPageProtocol {
    func calendarSetting(_ days : [DaysModel])
    func headerMove(_ index : Int)
}

class MainPageViewController: SuperViewControllerSetting<MainPageViewModel>{
    
    
    //
    lazy var topStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .center
        
        
        $0.backgroundColor = .primaryColorReverse
        $0.addArrangedSubview(informationStack)
        $0.addArrangedSubview(headerStackView)
        $0.addArrangedSubview(calendarCollectionView)
        $0.addArrangedSubview(toDoTodayLabel)
        $0.addArrangedSubview(bottomSpacingView)
        //        $0.addArrangedSubview(daysHeaderCollectionView)
    }
    
    lazy var informationStack = UIStackView().then{
        $0.axis = .horizontal
        
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.addArrangedSubview(menuButton)
        $0.addArrangedSubview(myNameIcon)
        
    }
    
    var menuButton = UIButton().then{
        $0.setImage(UIImage(named: "menuIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .primaryColor
        $0.contentMode = .scaleToFill
    }
    
    var myNameIcon = UILabel().then{
        $0.text = "로그인"
        $0.font = .subContentsBold
        $0.tintColor = .primaryColor
        $0.textAlignment = .right
        $0.contentMode = .scaleAspectFill
    }
    lazy var headerStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.addArrangedSubview(previousMonth)
        $0.addArrangedSubview(calendarHeader)
        $0.addArrangedSubview(nextMonth)
    }
    var previousMonth = UIButton().then{
        $0.titleLabel?.font = .subContentsBold
        $0.setTitleColor(.primaryColor, for: .normal)
        $0.setTitle("이전달", for: .normal)
        $0.contentHorizontalAlignment = .left
    }
    var nextMonth = UIButton().then{
        $0.titleLabel?.font = .subContentsBold
        $0.setTitleColor(.primaryColor, for: .normal)
        $0.setTitle("다음달", for: .normal)
        $0.contentHorizontalAlignment = .right
    }
    var calendarHeader = UILabel().then{
        $0.font = .contentTitleBold
        $0.textAlignment = .center
    }
    let calendarCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CalendarViewDayCell.self, forCellWithReuseIdentifier: CalendarViewDayCell.identifier)
        collectionView.register(CalendarViewWeekCell.self, forCellWithReuseIdentifier: CalendarViewWeekCell.identifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .primaryColorReverse
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var toDoTodayLabel = UILabel().then{
        $0.font = .contentTitleBold
        $0.textAlignment = .left
        $0.text = "진행중인 튜터링"
        $0.sizeToFit()
    }
    var bottomSpacingView = UILabel().then{
        $0.snp.makeConstraints { make in
            make.height.equalTo(0)
        }
    }
    
    lazy var tutoringTableView  = UITableView(frame: .zero).then {
        
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(TutoringViewCell.self, forCellReuseIdentifier: TutoringViewCell.identifier)
        
        //        $0.sectionHeaderHeight = 0
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    var topSafeAreaCover = UIView().then{
        $0.backgroundColor = .primaryColorReverse
        
    }
    
    lazy var calendarDataSource = RxCollectionViewSectionedReloadDataSource<DaysModel> { dataSource, collectionView , indexPath, item in
        if(indexPath.first == 0){
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarViewWeekCell.identifier, for: indexPath) as! CalendarViewWeekCell
            cell.uiSetting(item , indexPath[1])
            
             return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarViewDayCell.identifier, for: indexPath) as! CalendarViewDayCell
            cell.uiSetting(item , indexPath[1])
            
             return cell
        }
        
        
        
       
    }
    
    private var dommyDataSource = RxTableViewSectionedReloadDataSource<DaysModel> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: TutoringViewCell.identifier, for: indexPath) as! TutoringViewCell
        cell.uiSetting(item)
        cell.selectionStyle = .none
        cell.selectedBackgroundView = .none
        return cell
    }
    
    
   
    private let calenderCellWidth : CGFloat = (UIScreen.main.bounds.width - 20) / 7
    private let calenderCellHeight : CGFloat = 40
    private let topStackbottomStackSpacing : CGFloat = 20
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting(hidden: true)
    }
    
    
    override func uiDrawing() {
        view.addSubview(topStackView)
        view.addSubview(topSafeAreaCover)
        
        
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        menuButton.snp.makeConstraints { make in
            make.width.height.equalTo(IconSize.Middle.rawValue)
            //            make.leading.equalToSuperview().offset(20)
        }
        
        informationStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(.titleLeadingSpacing)
            make.trailing.equalToSuperview().offset(.titleTrailingSpacing)
        }
        
        headerStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(.titleLeadingSpacing)
            make.trailing.equalToSuperview().offset(.titleTrailingSpacing)
        }
        
        
        toDoTodayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(.titleLeadingSpacing)
            make.trailing.equalToSuperview().offset(.titleTrailingSpacing)
            
        }
                
        topSafeAreaCover.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: Dispatch.DispatchTime.now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.view.addSubview(self.tutoringTableView)
            self.view.sendSubviewToBack(self.tutoringTableView)
            self.tutoringTableView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            self.tutoringTableView.contentInset = UIEdgeInsets(top : self.topStackView.frame.height, left: 0 , bottom: 0 , right: 0)
        }
    }
    
    
    override func uiSetting(){
        view.backgroundColor = .primaryColorReverse
        
//        calendarCollectionView.rx.setDelegate(self)
//            .disposed(by: disposeBag)
//        
//        tutoringTableView.rx.setDelegate(self)
//            .disposed(by: disposeBag)
        
    }
    
    override func viewModelBinding() {
        
        let menuButtonTap = menuButton.rx.tap
        let previousMonthTap = previousMonth.rx.tap.map{ _ -> Int in
            print("실행?")
            return -1 }
        let nextMonthTap = nextMonth.rx.tap.map{ _ in return 1 }
        
        let output = viewModel.transform(input: .init(
            menuOpen : menuButtonTap.asDriverOnErrorNever() ,
            previousMonthTap : previousMonthTap.asDriverOnErrorNever() ,
            nextMonthTap : nextMonthTap.asDriverOnErrorNever()
        ))
        
    }
    
    
    func eventBinding() {
//        calendarCollectionView.rx.itemSelected
//            .subscribe { [weak self] indexPath in
//                let coordinator =  DayScheduleViewCoordinator()
//                coordinator.parentCoordinator = self?.viewModel?.coordinator
//                coordinator.start()
//            }
//            .disposed(by: disposeBag)
//
//        menuButton.rx.tap
//            .bind{ [weak self] event in
//                guard let viewModel = self?.viewModel else { return }
//                viewModel.input.menuOpen.accept(event)
//            }
//            .disposed(by: disposeBag)
//
//        nextMonth.rx.tap
//            .bind(onNext: { [weak self] in
//                self?.viewModel?.input.monthController.onNext(1)
//            })
//            .disposed(by: disposeBag)
//
//
//        previousMonth.rx.tap
//            .bind(onNext: { [weak self] in
//                self?.viewModel?.input.monthController.onNext(-1)
//            })
//            .disposed(by: disposeBag)
//
    }
    
    func uiBinding(){
//        viewModel?.output.weekDays
//            .bind(to : calendarCollectionView.rx.items(dataSource: calendarDataSource))
//            .disposed(by: disposeBag)
//
//
//        viewModel?.output.daySchedules
//            .bind(to: tutoringTableView.rx.items(cellIdentifier: TutoringViewCell.identifier, cellType: TutoringViewCell.self)) {
//                (row, element, cell) in
//                cell.uiSetting(element)
//            }.disposed(by: disposeBag)
//
//        viewModel?.output.daySchedules
//            .bind(to: scheduleCollectionView.rx.items(cellIdentifier: DayScheduleViewCell.identifier, cellType: DayScheduleViewCell.self){   (row, element, cell) in
//
//            })
//            .disposed(by: disposeBag)
//
//            .bind(to : scheduleCollectionView.rx.items(cellIdentifier: DayScheduleViewCell.identifier, cellType: DayScheduleViewCell.self){
//                (row, element, cell) in
//                cell.bind(mySectionItem : element.name)
//            })
//            .disposed(by: disposeBag)
//
//        viewModel?.output.heeaderIndex
//            .distinctUntilChanged()
//            .bind(onNext: { [weak self] in self?.headerMove($0) } )
//            .disposed(by: disposeBag)
//
//        viewModel?.output.MonthText
//            .asDriver()
//            .drive(calendarHeader.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel?.output.weekDays
//            .bind(onNext: { [weak self] days in
//                self?.calendarSetting(days)
//            })
//            .disposed(by: disposeBag)
    }
    
    
    func calendarSetting(_ days : [DaysModel]){
        var heightCount : CGFloat = 6
        if(days[1].items.count > 35){
            heightCount += 1
        }
        self.calendarCollectionView.snp.remakeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(calenderCellHeight * heightCount)
        }
        DispatchQueue.main.asyncAfter(deadline: Dispatch.DispatchTime.now() + 0.1) {
            self.tutoringTableView.contentInset = UIEdgeInsets(top : self.topStackView.frame.height, left: 0 , bottom: 0 , right: 0)
            self.tutoringTableView.setContentOffset(CGPoint(x: 0, y: -self.topStackView.frame.height - 50), animated: false)
        }
    }
    
//    func headerMove(_ index : Int){
//        var getIndex : Int = index
//        if(getIndex + 1 < viewModel?.output.daySchedules.value.count ?? 0){
//            getIndex += 1
//        }
//    }
//    
    
    
}



extension MainPageViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == calendarCollectionView){
            return  CGSize(width: calenderCellWidth , height: calenderCellHeight)
        }else{
            return CGSize(width: UIScreen.main.bounds.width , height: 30)
        }
    }
}



extension MainPageViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == tutoringTableView){
            var segmentTransform = CATransform3DIdentity // Translate only.
            // segmentViewOffset 바텀스택뷰의 기본값
            // 패딩이 늘어났으니 추가해야함
            //+ 50 스크롤뷰를 사용하면 기본값이 + 50이 있는데 해당값
            // -10 은 스크롤뷰와
            let segmentViewOffset = -(scrollView.contentOffset.y + topStackView.frame.height + 50 )
            segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset , -(topStackView.frame.height - topStackbottomStackSpacing - (topStackView.spacing ) - toDoTodayLabel.frame.height)), 0)
            topStackView.layer.transform = segmentTransform
            guard let topSection = tutoringTableView.indexPathsForVisibleRows?.first?[0] else { return }
            
//            viewModel.output.heeaderIndex.accept(topSection)
            
        }
    }
}


extension MainPageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    //테이블뷰 옵션을 그룹으로 선택했을때 약간의 공백? 이 생기는데 그걸 없애기위해 사용한다
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
