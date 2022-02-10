import UIKit
import Then
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class SecondTabViewController: UIViewController, UIScrollViewDelegate  {
    
    lazy var mainScrollView = UIScrollView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        
        $0.addSubview(stackView)
     
    }
    
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.addSubview(topImageView)
        $0.addSubview(categoryCollectionView)
        $0.addSubview(mealsTableView)
        
    }
    
    
    let topImageView = UIImageView().then{
        $0.image = UIImage(named: "은하")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
     }
    
    
    let categoryCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 40)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let mealsTableView = UITableView().then {
    
        $0.separatorStyle = .none
       
        $0.sectionFooterHeight = 0
        $0.register(MealTableViewCell.self, forCellReuseIdentifier: MealTableViewCell.identifier)
        
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    var topSafeAreaCover = UIView().then{
        $0.backgroundColor = .red
        
    }
    
   
    let data = Observable<[MealCategory]>.just(MealManager.shared.categories)
    
  
    var sectionSubject = BehaviorRelay(value: [MealCategory]())
    
    var topIndex : Int = 0
    
    private var dataSource = RxTableViewSectionedReloadDataSource<MealCategory> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        cell.bind(mySectionItem: item)
        return cell
    }
    

 
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetting()
        
        setupViews()
        dataSetting()
        
        bind()
        
        
        categoryCollectionView.selectItem(at: IndexPath(item: topIndex, section: 0), animated: false, scrollPosition: .left)
    }
    
    
    fileprivate func uiSetting(){
        view.backgroundColor = .white
        
        view.addSubview(mainScrollView)
        view.addSubview(topSafeAreaCover)
        
        mainScrollView.snp.makeConstraints { make in
        
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
//            make.edges.equalTo(view.safeAreaLayoutGuide)
         
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(mainScrollView)
            make.width.equalTo(mainScrollView).priority(1000)
            make.height.equalTo(mainScrollView).priority(250)
        }
        
        
        topImageView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top)
       
            make.width.equalTo(mainScrollView.snp.width)
            make.height.equalTo(200)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(60)
           
        }
        
        mealsTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(stackView.snp.bottom) // 이것이 중요함
        }
        
        topSafeAreaCover.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        
    }
    
    private func setupViews() {
        categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mealsTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
       

    }
    
    
    
    
    private func dataSetting(){
        sectionSubject.accept(MealManager.shared.categories)
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].name
        }
        
        
    }
    
    
    private func bind(){
     
        sectionSubject
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: DayCollectionViewCell.identifier, cellType: DayCollectionViewCell.self)) {
                  (row, element, cell) in
                cell.bind(mySectionItem : element.name)
              }.disposed(by: disposeBag)
        
        sectionSubject
            .bind(to: mealsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
       

        
        
        
    }
 
    
    

}



extension SecondTabViewController : UITableViewDelegate {
 
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // RxTableViewSectionedReloadDataSource는 일반 dataSourec배열처럼 index로 접근 가능
       return 120
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        headerView.backgroundColor = .yellow
        let categoryLabel = UILabel()
        categoryLabel.text = MealManager.shared.categories[section].name
        categoryLabel.font = .systemFont(ofSize: 25, weight: .medium)
        headerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalTo(headerView)
        }
        
     
        return headerView
    }
 
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mealsTableView{
            let topSection = mealsTableView.indexPathsForVisibleRows?.map{$0.section}.sorted().first ?? 0
            let indexPath = IndexPath(item: topSection, section: 0)
         if(topIndex != topSection){
                topIndex = topSection
                categoryCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
        
       
    }
    

    
}
