//
//  BaseView.swift
//  ios-swift
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    
    convenience init(color: UIColor, isBorder: Bool = false) {
        self.init()
        self.backgroundColor = color
        if isBorder {
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = AD(1)
        }
    }
    
    convenience init(bgColor: UIColor,
                     isBorder: Bool = false,
                     borderColor: UIColor =  UIColor.black,
                     borderWidth: CGFloat = AD(1)) {
        self.init()
        self.backgroundColor = bgColor
        if isBorder {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetting()
        setupViews()
        initBinding()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetting()
        setupViews()
        initBinding()
    }
    
    func commonSetting() {
        self.backgroundColor = .white
    }
    func setupViews() {}
    func initBinding() {}
    
    func bindEvent<T>(_ control: UIControl, value: T, to relay: PublishRelay<T>) {
        if let button = control as? UIButton {
            button.rx.tap
                .map { _ in value }
                .bind(to: relay)
                .disposed(by: disposeBag)
        }
    }
    
    func bindTapEvent<T>(_ control: UIControl, value: T, to relay: PublishRelay<T>) {
        control.rx.click
            .map { _ in value }
            .bind(to: relay)
            .disposed(by: disposeBag)
    }
    
    func attPlaceholder(_ str: String, _ color: UIColor = .black) -> NSAttributedString {
        return NSAttributedString(string:str,
                                  attributes: [NSAttributedString.Key.foregroundColor: color])
    }

}




