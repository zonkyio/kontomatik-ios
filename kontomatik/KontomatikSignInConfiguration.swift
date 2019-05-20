//
//  KontomatikSignInConfiguration.swift
//  kontomatik
//
//  Created by Lukas Gergel on 28/02/2019.
//  Copyright © 2019 Zonky a.s. All rights reserved.
//

import UIKit


public struct KontomatikSignInConfiguration {
    
    /// Available countries
    public enum Country: String {
        case br
        case cz
        case es
        case uk
        case mx
        case pl
        case ru
        case it
        case lv
        case ee
    }
    
    /// Available localizations
    public enum Locale: String {
        case br
        case cz
        case en
        case es
        case mx
        case pl
        case ru
    }
    
    /// The client id you received from Kontomatik. You will likely have two of them - one for the test and one for production API.
    let client: String
    /// The full name under which your company is registered, ex. “Zonky a.s.”.
    let clientIdentity: String
    /// Determines end-user interface language.
    let locale: Locale
    /// Pre-selects the country. If omitted, the country drop down list will be shown.
    let country: Country?
    /// By default, “My bank is not listed…” option is displayed on the bank selection list. Set the value to false if you do not want this option to show up on the list.
    let showTargetMissingOption: Bool?
    /// Option to toggle the visibility of beta quality labels for beta quality targets. Please note the default is true on the test environment and false on production. This is an exception that breaks the symmetry between test and production.
    let showBetaQualityLabels: Bool?
    /// Set to true to show banks’ favicons in a drop down list. Makes it easier for the end user to find a bank. Also it looks more appealing and professional. This is off by default because using bank logotypes can be a grey area in some jurisdictions.
    let showFavicons: Bool?
    /// By default, screenshot of bank’s login page is displayed. Set the value to false if you do not wish the widget to display screenshots.
    let showScreenshots: Bool?
    /// If set to true, the <iframe> width will be set to "100%" of view instead of fixed width.
    let layout: Bool?
    /// If set to true, the <iframe> height will change based on the content of the element. This feature is currently in beta state.
    let dynamicHeight: Bool?
    /// Pre-selects the bank. If omitted, the bank drop down list will be shown. Accepted values could be selected from https://developer.kontomatik.com/api-doc/#catalog
    let target: String?
    /// Optional object defining the look and feel of the widget. For more information please refer to https://developer.kontomatik.com/api-doc/#css-styling-the-widget
    let styles: KontomatikSignInStyle?
    
    /// Your own arbitrary identifier of the end user. For a lender, this might be your loan application id. If you are a bank, a credit application id might be appropriate. If you are a PFM vendor, this could be your end-user database id. Passing this param is highly recommended. It allows you to group all imported data and fetch them together, even if they span across multiple Kontomatik sessions.
    let ownerExternalId: String?
    /// The widget displays a bank with a large market share as the default value of the bank selection list. If instead of a default target you prefer to display the message Select from list, set showDefaultTarget to false.
    let showDefaultTarget: Bool?
    
    public func toDict() -> [String: Any] {
        var params: [String: Any] = [
            "client": client,
            "clientIdentity": clientIdentity,
            "locale": locale.rawValue
        ]
        country.map { params["country"] = $0.rawValue }
        showTargetMissingOption.map { params["showTargetMissingOption"] = $0 }
        showBetaQualityLabels.map { params["showBetaQualityLabels"] = $0 }
        showFavicons.map { params["showFavicons"] = $0 }
        showScreenshots.map { params["showScreenshots"] = $0 }
        layout.map { params["layout"] = $0 }
        dynamicHeight.map { params["dynamicHeight"] = $0 }
        target.map { params["target"] = $0 }
        styles.map { params["styles"] = $0.toDict() }
        
        return params
    }
}

extension KontomatikSignInConfiguration {
    public init(client: String, clientIdentity: String, country: Country, locale: Locale, style: KontomatikSignInStyle?, target: String?) {
        self.client = client
        self.clientIdentity = clientIdentity
        self.country = country
        self.locale = locale
        self.target = target
        self.styles = style
        
        showTargetMissingOption = false
        showBetaQualityLabels = false
        showFavicons = false
        showScreenshots = false
        layout = false
        dynamicHeight = true
        ownerExternalId = nil
        showDefaultTarget = nil
    }
}
