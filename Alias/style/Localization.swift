//
//  Localization.swift
//  Alias
//
//  Created by shio andghuladze on 30.09.22.
//

import Foundation

fileprivate var appLocalization: Localization = UserDefaults.standard.localization

var localizationLiveData: LiveData<Localization> = LiveData(initialData: UserDefaults.standard.localization)

enum Localization: String {
    case Georgian = "ka"
    case English = "en"
    case Russian = "ru"
}

extension String {
    func localized(lang: String = appLocalization.rawValue) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

fileprivate extension UserDefaults {
    var localization: Localization {
        get {
            let key = string(forKey: "localization") ?? ""
            return Localization(rawValue: key) ?? Localization.Georgian
        }
        set { set(newValue.rawValue, forKey: "localization") }
    }
}

func changeLocalization(localization: Localization){
    UserDefaults.standard.localization = localization
    appLocalization = localization
    if localizationLiveData.data != localization{ localizationLiveData.setData(data: localization) }
}


