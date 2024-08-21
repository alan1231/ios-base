//
//  IfDebug.swift
//  ios-swift
//
//  Created by Eddie Chen on 2023/2/6.
//

import Foundation

func printLog<T>(_ msg: T, file: String = #file, method: String = #function, line: Int = #line) {
#if DEBUG
    if msg is Error
    {
        if let range = "\(msg)".range(of: "Code: ") {
            let suffix = "\(msg)"[range.lowerBound...]
            
            // 提取数字
            if let number = suffix.components(separatedBy: "/").first
            {
                var detailMsg = ""
                if number.contains("401")
                {
                    detailMsg = "token過期或者帳號跨平台登入"
                }else if number.contains("404")
                {
                    detailMsg = "The given data was not valid JSON."
                }else
                {
                    detailMsg = "資料異常"
                }
                print("\(suffix) : \(detailMsg)")
            }
        }
        print("\(msg)")
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let today = dateFormatter.string(from: Date())

    print("""
          ==================== [\((file as NSString).lastPathComponent), \(today)] ====================

          line[\(line)], \(method)

          \(msg)

          ---------------------------------------- Next Print ----------------------------------------
          """)
#endif
}
