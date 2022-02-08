import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay

class FirstTabViewController: UIViewController {
    //
    lazy var topStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .center
        $0.addArrangedSubview(myIcon)
        $0.addArrangedSubview(headerStackView)
        $0.addArrangedSubview(calendarCollectionView)
        $0.addArrangedSubview(daysHeaderCollectionView)
    }
    var myIcon = UILabel().then{
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
        collectionView.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.identifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .primaryColorReverse
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    
    
    let daysHeaderCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 40)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    
    lazy var bottomCollectionView  = UITableView(frame: .zero, style: .grouped).then {
        
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(DayScheduleViewCell.self, forCellReuseIdentifier: DayScheduleViewCell.identifier)

        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    
    
    
    var viewModel : FirstTapViewModel?
    
    private let disposeBag : DisposeBag = DisposeBag()
    
    
    
    
    lazy var calendarDataSource = RxCollectionViewSectionedReloadDataSource<DaysModel> { dataSource, collectionView , indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarViewCell.identifier, for: indexPath) as! CalendarViewCell
        cell.uiSetting(item , indexPath[1])
        return cell
    }
    
    private var dommyDataSource = RxTableViewSectionedReloadDataSource<DaysModel> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: DayScheduleViewCell.identifier, for: indexPath) as! DayScheduleViewCell
        cell.uiSetting(item)
        return cell
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColorReverse
        
        uiSetting()
        uiBinding()
        
    }
    
    private func uiSetting(){
        
        view.addSubview(topStackView)
        
        
        
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        
        myIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        headerStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
        daysHeaderCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: Dispatch.DispatchTime.now() + 1) { [weak self] in
            guard let self = self else { return }
            self.view.addSubview(self.bottomCollectionView)
            self.view.sendSubviewToBack(self.bottomCollectionView)
            //            self.calendarCollectionView.backgroundColor = .brown
            self.bottomCollectionView.snp.makeConstraints { make in
                
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            self.bottomCollectionView.contentInset = UIEdgeInsets(top : self.topStackView.frame.height, left: 0 , bottom: 0 , right: 0)
        }
        
    }
    
    func uiBinding(){
        
        
        calendarCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        daysHeaderCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        bottomCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
        
        
        calendarCollectionView.rx
            .itemSelected
            .subscribe { [weak self] indexPath in
                
            }
            .disposed(by: disposeBag)
        
        
        nextMonth.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel?.input.monthController.onNext(1)
            })
            .disposed(by: disposeBag)
        
        
        previousMonth.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel?.input.monthController.onNext(-1)
            })
            .disposed(by: disposeBag)
        
        viewModel?.output.weekDays
            .bind(to : calendarCollectionView.rx.items(dataSource: calendarDataSource))
            .disposed(by: disposeBag)
        
        
        viewModel?.output.daySchedules
            .bind(to: daysHeaderCollectionView.rx.items(cellIdentifier: DayCollectionViewCell.identifier, cellType: DayCollectionViewCell.self)) {
                (row, element, cell) in
                cell.bind(mySectionItem : element.name)
            }.disposed(by: disposeBag)
        
        viewModel?.output.daySchedules
            .bind(to : bottomCollectionView.rx.items(dataSource: dommyDataSource))
            .disposed(by: disposeBag)
        
        viewModel?.output.heeaderIndex
            .distinctUntilChanged()
            .bind(onNext: { [weak self] in self?.headerMove($0) } )
            .disposed(by: disposeBag)
        
        viewModel?.output.MonthText
            .asDriver()
            .drive(calendarHeader.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output.weekDays
            .bind(onNext: { [weak self] days in
                guard let self = self else { return }
                var heightCount : CGFloat = 6
                if(days[1].items.count > 35){
                    heightCount += 1
                }
                self.calendarCollectionView.snp.remakeConstraints { make in
                    make.width.equalToSuperview()
                    make.height.equalTo(((UIScreen.main.bounds.width - 20) / 7) * heightCount)
                }
                DispatchQueue.main.asyncAfter(deadline: Dispatch.DispatchTime.now() + 0.1) {
                    self.bottomCollectionView.contentInset = UIEdgeInsets(top : self.topStackView.frame.height, left: 0 , bottom: 0 , right: 0)
                    self.bottomCollectionView.setContentOffset(CGPoint(x: 0, y: -self.topStackView.frame.height - 50), animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    func headerMove(_ index : IndexPath){
        daysHeaderCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
    }
    
}



extension FirstTabViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == calendarCollectionView){
            return  CGSize(width: (UIScreen.main.bounds.width - 20) / 7, height: (UIScreen.main.bounds.width - 20) / 7)
        }else if(collectionView == daysHeaderCollectionView){
            return CGSize(width: 120 , height: 30)
        }else{
            return CGSize(width: UIScreen.main.bounds.width , height: 30)
        }
    }
}



extension FirstTabViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView == bottomCollectionView){
            var segmentTransform = CATransform3DIdentity // Translate only.
            let segmentViewOffset = -(scrollView.contentOffset.y + topStackView.frame.height + 50)
            segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset , -(topStackView.frame.height - daysHeaderCollectionView.frame.height + topStackView.spacing)), 0)
            topStackView.layer.transform = segmentTransform
            
            guard let topSection = bottomCollectionView.indexPathsForVisibleRows?.first?[0] else { return }
            if(topSection + 1 != viewModel?.output.daySchedules.value.count){
                viewModel?.output.heeaderIndex.accept(IndexPath(item: topSection + 1, section: 0))
            }
        }
    }
}


extension FirstTabViewController : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        headerView.backgroundColor = .yellow
        let categoryLabel = UILabel()
        categoryLabel.text = viewModel?.output.daySchedules.value[section].name
        categoryLabel.font = .systemFont(ofSize: 25, weight: .medium)
        headerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalTo(headerView)
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    
    
}
