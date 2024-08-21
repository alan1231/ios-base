//
//  ScreenConfig.swift
//  ios-swift
//
//  Created by Eddie Chen on 2023/2/6.
//

import UIKit

/// 標準系統配置
public let kScreen_Bounds = UIScreen.main.bounds
public let SCREEN_HEIGHT = CGFloat(UIScreen.main.bounds.size.height)
public let SCREEN_WIDTH = CGFloat(UIScreen.main.bounds.size.width)
/// 無熱點欄時，標準系統狀態欄高度+導航欄高度
public let NORMAL_STATUS_AND_NAV_BAR_HEIGHT = CGFloat(SYS_STATUSBAR_HEIGHT) + CGFloat(NAVIGATIONBAR_HEIGHT)
/// 不包括導航欄狀態欄的屏幕高
public let NORMAL_HEIGHT = SCREEN_HEIGHT - CGFloat(NORMAL_STATUS_AND_NAV_BAR_HEIGHT)

/// 是否是齊瀏海機型，新增IPhone 14  812,852,926,932，瀏海高度:44，動態島高度:47
public let IS_IPhoneX_All =
   (UIScreen.main.bounds.size.height == 812) ||
   (UIScreen.main.bounds.size.height == 896) ||
   (UIScreen.main.bounds.size.height == 780) ||
   (UIScreen.main.bounds.size.height == 844) ||
   (UIScreen.main.bounds.size.height == 852) ||
   (UIScreen.main.bounds.size.height == 926) ||
   (UIScreen.main.bounds.size.height == 932) ||

   (UIScreen.main.bounds.size.width == 812)  ||
   (UIScreen.main.bounds.size.width == 896)  ||
   (UIScreen.main.bounds.size.width == 780)  ||
   (UIScreen.main.bounds.size.width == 844)  ||
   (UIScreen.main.bounds.size.width == 852)  ||
   (UIScreen.main.bounds.size.width == 926)  ||
   (UIScreen.main.bounds.size.width == 932)

/// 狀態欄
public let SYS_STATUSBAR_HEIGHT: CGFloat = {
    var window: UIWindow?
    
    if #available(iOS 13.0, *) {
        window = UIApplication.shared.windows.first
        
    } else if #available(iOS 11.0, *) {
        window = UIApplication.shared.keyWindow
    }
    
    if #available(iOS 11.0, *) {
        var height = window?.safeAreaInsets.top ?? 0
        
        if height == 0 {
            if IS_IPhone14PROMAX_STATUSBAR {
                height = CGFloat(47)
            } else {
                height = IS_IPhoneX_All ? CGFloat(44) : CGFloat(20)
            }
        }
        return height
    }
    return IS_IPhoneX_All ? CGFloat(44) : CGFloat(20)
}()

/// 导航栏
public let NAVIGATIONBAR_HEIGHT = CGFloat(44)

/// TabBar高度
public let TABBAR_HEIGHT = IS_IPhoneX_All ? CGFloat(83) : CGFloat(49)

/// 底部安全邊距
public let TABBER_BOTTOM_MARGIN = IS_IPhoneX_All ? CGFloat(34) : CGFloat(0)

///IPhone 14，932，動態島橫向寬度:47
public let IS_IPhone14PROMAX_STATUSBAR =
   (UIScreen.main.bounds.size.height == 932) || (
    UIScreen.main.bounds.size.width == 932)

public func AD(_ x:CGFloat)->CGFloat{
    let width = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    return x * width / 375.0
}


/// 獲取屏幕安全區域
public func WindowSafeAreaInsets() -> UIEdgeInsets {
    guard #available(iOS 11.0, *) else {
        return UIEdgeInsets.zero;
    }
    return UIApplication.shared.windows[0].safeAreaInsets
}

/// 計算Label Size
public func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize {
    let key = text + font.fontName + "\(maxSize)"
    let res = text.boundingRect(with: maxSize,
                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                attributes: [NSAttributedString.Key.font : font], context: nil).size
    return res
}


