//
//  DgmLocalizeService.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation

public func Loc(_ key: String) -> String {
    return DgmLocalizeService.localize(key)
}

public func Error(_ key: String) -> String {
    return DgmLocalizeService.localize(key)
}

open class DgmLocalizeService {
    public static let Vietnamese : String = "vi"
    public static let English : String = "en"
    static func localize(_ key: String) -> String {
        return currentLangBundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    static var currentLangBundle: Bundle {
        get {
            var code = currentLangCode
            if code == English {
                code = "Base"
            }
            if let path = Bundle.main.path(forResource: code, ofType: "lproj") {
                if let _bundle = Bundle(path: path) {
                    return _bundle
                }
            }
            return Bundle.main
        }
    }
    
    static var currentLangCode: String {
        get {
            if let lc = UserDefaults.standard.object(forKey: "LangCode") as? String {
                return lc
            }
            if let preferred = Locale.preferredLanguages.first {
                let dict = Locale.components(fromIdentifier: preferred)
                if let langCode = dict["kCFLocaleLanguageCodeKey"] {
                    return langCode
                }
            }
            return Vietnamese
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "LangCode")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var preferredLanguage: String {
        get {
            switch currentLangCode {
            case English:
                return "1"
            case Vietnamese:
                return "2"
            default:
                return defaultLanguage
            }
        }
    }
    
    static var defaultLanguage: String = "2"
    
}
