import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: BaseViewController {
    
    private let imageView = UIImageView()
    private let infoLabel = UILabel()
    private let changeButton = UIButton(type: .system)
    
    private let imageNames = ["DB-DFC-01", "DB-DFC-02", "DB-DFC-03", "DB-DFC-04", "DB-DFC-05", "DB-DFC-06"] // 添加其他圖片名稱
    private var currentImageIndex = BehaviorRelay<Int>(value: 0)
    let bottomLineView = BaseView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        // 設置 UI 屬性
        view.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = 1
        view.addSubview(imageView)
        
        infoLabel.textAlignment = .center
        infoLabel.text = "This is a RxSwift Integration"
        infoLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(infoLabel)
        
        changeButton.setTitle("Change Image", for: .normal)
        view.addSubview(changeButton)
        bottomLineView.backgroundColor = UIColor.red
        view.addSubview(bottomLineView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(400)
        }
        
        infoLabel.snp.makeConstraints { 
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints{
            $0.top.equalTo(changeButton.snp.bottom).offset(30)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        // 更新圖片顯示
        currentImageIndex
            .map { index in
                self.imageNames[index % self.imageNames.count]
            }
            .map { imageName in
                UIImage(named: imageName)
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        // 按鈕點擊事件
        changeButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                let nextIndex = (self.currentImageIndex.value + 1) % self.imageNames.count
                self.currentImageIndex.accept(nextIndex)
            })
            .disposed(by: disposeBag)
    }
}
