//
//  FirebaseProvider.swift
//  BaseApplication
//
//  Created by Dang Huu Tri on 1/16/20.
//  Copyright © 2020 Dang Huu Tri. All rights reserved.
//

import Foundation
import Firebase

public class FirebaseProvider : BaseProvider<Firebase.Analytics> {
    
    public static let GoogleAppId = "GoogleAppIdKey"
    public static let BundleId = "BundleIdKey"
    public static let GCMSenderId = "GCMSenderID"
    
    public override func setup(with properties: Properties?) {
        
        guard let googleAppId = properties?[FirebaseProvider.GoogleAppId] as? String, let gcmSenderId = properties?[FirebaseProvider.GCMSenderId] as? String else {
            return
        }
        
        let options = FirebaseOptions(googleAppID: googleAppId, gcmSenderID: gcmSenderId)
        
        if let bundleId = properties?[FirebaseProvider.BundleId] as? String {
            options.bundleID = bundleId
        }
        
        FirebaseApp.configure(options: options)
    }
    
    public override func track(event: TrackingEvent) {
        guard let event = update(event: event) else {
            return
        }
        
        switch event.type {
        case .default, .purchase:
            Analytics.logEvent(event.name, parameters: mergeGlobal(properties: event.properties, overwrite: true))
        case .screen:
            Analytics.setScreenName(event.name, screenClass: nil)
        case .finishTime:
            super.track(event: event)
            
            Analytics.logEvent(event.name, parameters: mergeGlobal(properties: event.properties, overwrite: true))
        default:
            super.track(event: event)
        }
        
        delegate?.analyticalProviderDidSendEvent(self, event: event)
    }
    
    public override func track(event: String, properties: Properties?) {
        Analytics.logEvent(event, parameters: properties)
    }
    
    public override func track(screen: String, properties: Properties?, className: String?) {
        Analytics.setScreenName(screen, screenClass: className)
    }
    
    public override func flush() {
    }
    
    public override func reset() {
        
    }
    
    public override func activate() {
        Analytics.logEvent(AnalyticsEventAppOpen, parameters: [:])
    }
    
    public override func identify(userId: String, properties: Properties?) {
        Analytics.setUserID(userId)
        
        if let properties = properties {
            set(properties: properties)
        }
    }
    
    public override func alias(userId: String, forId: String) {
    }
    
    public override func set(properties: Properties) {
        let properties = prepare(properties: properties)!
        for (property, value) in properties {
            if let value = value as? String {
                Analytics.setUserProperty(value, forName: property)
            }
            else {
                Analytics.setUserProperty(String(describing: value), forName: property)
            }
        }
    }
    
    public override func increment(property: String, by number: NSDecimalNumber) {
        
    }
    
    public override func update(event: TrackingEvent) -> TrackingEvent? {

        guard var event = super.update(event: event) else {
            return nil
        }
        
        if let defaultName = DefaultEvent(rawValue: event.name), let updatedName = parse(name: defaultName) {
            event.name = updatedName
        }
        
        event.properties = prepare(properties: mergeGlobal(properties: event.properties, overwrite: true))
        
        return event
    }

    private func parse(name: DefaultEvent) -> String? {
        switch name {
        case .addPaymentInfo:
            return AnalyticsEventAddPaymentInfo
        case .addToWishList:
            return AnalyticsEventAddToWishlist
        case .tutorialComplete:
            return AnalyticsEventTutorialComplete
        case .addToCart:
            return AnalyticsEventAddToCart
        case .selectContent:
            return AnalyticsEventSelectContent
        case .beginCheckout:
            return AnalyticsEventBeginCheckout
        case .campaignDetail:
            return AnalyticsEventCampaignDetails
        case .checkoutProgress:
            return AnalyticsEventCheckoutProgress
        case .earnVirtualCurrency:
            return AnalyticsEventEarnVirtualCurrency
        case .purchase:
            return AnalyticsEventEcommercePurchase
        case .joinGroup:
            return AnalyticsEventJoinGroup
        case .generateLead:
            return AnalyticsEventGenerateLead
        case .levelUp:
            return AnalyticsEventLevelUp
        case .signUp:
            return AnalyticsEventLogin
        case .postScore:
            return AnalyticsEventPostScore
        case .presentOffer:
            return AnalyticsEventPresentOffer
        case .purchaseRefund:
            return AnalyticsEventPurchaseRefund
        case .removeFromCart:
            return AnalyticsEventRemoveFromCart
        case .search:
            return AnalyticsEventSearch
        case .checkoutOption:
            return AnalyticsEventSetCheckoutOption
        case .share:
            return AnalyticsEventShare
        case .completedRegistration:
            return AnalyticsEventSignUp
        case .spendVirtualCurrency:
            return AnalyticsEventSpendVirtualCurrency
        case .tutorialBegin:
            return AnalyticsEventTutorialBegin
        case .tutorialUnlockAchievement:
            return AnalyticsEventUnlockAchievement
        case .viewItem:
            return AnalyticsEventViewItem
        case .viewItemList:
            return AnalyticsParameterItemList
        case .viewSearchResult:
            return AnalyticsEventViewSearchResults
        default:
            return nil
        }
    }
    
    private func prepare(properties: Properties?) -> Properties? {
        guard let properties = properties else {
            return nil
        }
        var finalProperties : Properties = properties
        for (property, value) in properties {
            let property = parse(property: property)
            if let parsed = parse(value: value) {
                finalProperties[property] = parsed
            }
        }
        return finalProperties
    }
    
    
    private func parse(property: String) -> String {
        switch property {
        case Property.Purchase.quantity.rawValue:
            return AnalyticsParameterQuantity
        case Property.Purchase.item.rawValue:
            return AnalyticsParameterItemName
        case Property.Purchase.sku.rawValue:
            return AnalyticsParameterItemID
        case Property.Purchase.category.rawValue:
            return AnalyticsParameterItemCategory
        case Property.Purchase.source.rawValue:
            return AnalyticsParameterItemLocationID
        case Property.Purchase.price.rawValue:
            return AnalyticsParameterValue
        case Property.Purchase.currency.rawValue:
            return AnalyticsParameterCurrency
        case Property.Location.origin.rawValue:
            return AnalyticsParameterOrigin
        case Property.Location.destination.rawValue:
            return AnalyticsParameterDestination
        case Property.startDate.rawValue:
            return AnalyticsParameterStartDate
        case Property.endDate.rawValue:
            return AnalyticsParameterEndDate
        case Property.Purchase.medium.rawValue:
            return AnalyticsParameterMedium
        case Property.Purchase.campaign.rawValue:
            return AnalyticsParameterCampaign
        case Property.term.rawValue:
            return AnalyticsParameterTerm
        case Property.Content.identifier.rawValue:
            return AnalyticsParameterContent
        case Property.User.registrationMethod.rawValue:
            return AnalyticsParameterSignUpMethod
        default:
            return property
        }
    }
    
    private func parse(value: Any) -> Any? {
        if let string = value as? String {
            if string.count > 35 {
                let maxTextSize = string.index(string.startIndex, offsetBy: 35)
                let substring = string[..<maxTextSize]
                return String(substring)
            }
            
            return value
        }
        
        if let number = value as? Int {
            return NSNumber(value: number)
        }
        
        if let number = value as? UInt {
            return NSNumber(value: number)
        }
        
        if let number = value as? Bool {
            return NSNumber(value: number)
        }
        
        if let number = value as? Float {
            return NSNumber(value: number)
        }
        
        if let number = value as? Double {
            return NSNumber(value: number)
        }
        
        return nil
    }
}


