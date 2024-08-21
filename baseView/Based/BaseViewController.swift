//
//  BaseViewController.swift
//  ios-swift
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

enum NavigationItemStyle {
    case left
    case right
    case both
    case none
}

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    // View
    let gradientImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
        
    // 離開畫面時，所有鍵盤都收掉
    var isViewEndEditing: Bool = true
    // 隱藏Tabbar
    var isTabBarHidden: Bool = true {
        didSet {
            hiddenTabBarItem(isTabBarHidden)
        }
    }
    var isTrans = false
    // 不要有手勢回到上一頁的動作
    var isSwipeToPop: Bool = true {
        didSet {
//            swipeToPop(isSwipeToPop)
        }
    }
   
    
    let disposeBag = DisposeBag()
    
    var isScrollToTop: Bool = false

    init(){
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initBinding()
        setNavBar()
        setupGradientView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit{
        printLog("=====\(type(of: self)) deinit=====")
        NotificationCenter.default.removeObserver(self)
    }
    

    func setupViews() {}
    func initBinding() {}
    func setNavBar() {}
    func setupGradientView()
    {
        self.view.addSubview(gradientImageView)
        gradientImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.view.sendSubviewToBack(gradientImageView)
    }
    func hiddenGradientView()
    {
        self.gradientImageView.isHidden = true

    }
    //for mode0 隱藏nav的背景圖
    func hideNavBGImage(isHide: Bool) {
    }
    // MARK: - TabBarItem Hidden
    private func hiddenTabBarItem(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }

    // MARK: - swipeToPop animation
    func swipeToPop(_ isEnableSwipe:Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = isEnableSwipe
        self.navigationController?.interactivePopGestureRecognizer?.delegate = isEnableSwipe ? nil : self
    }
    
    @objc func pop(animated: Bool = true){
//        self.navigator.pop(sender: self, animated: animated)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    
    @objc func toService() {
        //取用系統配置的客服url
//        if let urlStr = sysConfig.getZxkfUrl() {
//            self.openURLIfPossible(urlStr)
//        }
    }
    func changeNavigationColor() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.white
        }
    }
}

extension BaseViewController {
    
    func keyboardDismiss() {
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        
        tap.rx.event.subscribe { [weak self] _ in
            self?.view.endEditing(true)
        }.disposed(by: disposeBag)
    }
}


//MARK: 統一管理是否需要顯示TarBar
extension BaseViewController {
    private func isShowTarBar(_ vc: BaseViewController) -> Bool{
//        switch vc {
//            case is HomeViewController,
//                 is MineViewController,
//                 is CommunityViewController,
//                 is GameLobbyViewController,
//                 is GameLinkViewController,
//                 is InjectViewController,
//                 is InjectListViewController,
//                 is PromotionsViewController,
//                 is InjectGridViewController_47,
//                 is InjectGridViewController:
//      
//            
//            if configModeCatagory == .mode0,
//               vc is MineViewController {
//                return false
//            }
//            
//            return true
//        default:
//            return false
//        }
        return false
    }
}

