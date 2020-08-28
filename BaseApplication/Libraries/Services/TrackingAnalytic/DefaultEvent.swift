//
//  DefaultEvent.swift
//  BaseApplication
//
//  Created by Dang Huu Tri on 1/15/20.
//  Copyright © 2020 Dang Huu Tri. All rights reserved
//

import Foundation

public enum DefaultEvent : String {

    // Common events from Firebase SDK:
        //*    Retail/Ecommerce/travel
    case addPaymentInfo     = "AnalyticalAddPaymentInfo"
    case checkoutProgress   = "AnalyticalCheckoutProgress"
    case checkoutOption     = "AnalyticalCheckoutOption"
    case addToCart          = "AnalyticalAddToCart"
    case addToWishList      = "AnalyticalAddToWishList"
    case beginCheckout      = "AnalyticalBeginCheckout"
    case ecomPurchase       = "AnalyticalaEcomPurchase"
    case generateLead       = "AnalyticalGenerateLead"
    case purchase           = "AnalyticalPurchase"
    case purchaseRefund     = "AnalyticalPurchaseRefund"
    case viewItem           = "AnalyticalViewItem"
    case viewItemList       = "AnalyticalViewItemList"
    case viewSearchResult   = "AnalyticalViewSearchResult"
    case search             = "AnalyticalSearch"
    case earnVirtualCurrency    = "AnalyticalEarnVirtualCurrency"
    case joinGroup          = "AnalyticalJoinGroup"
    case levelUp            = "AnalyticalLevelUp"
    case postScore          = "AnalyticalPostScore"
    case selectContent      = "AnalyticalSelectContent"
    case spendVirtualCurrency      = "AnalyticalSpendVirtualCurrency"
    case tutorialBegin      = "AnalyticalTutorialBegin"
    case tutorialComplete   = "AnalyticalTutorialComplete"
    case tutorialUnlockAchievement      = "AnalyticalTutorialUnlockAchievement"
    case pushNotification   = "AnalyticalEventPushNotification"
    case campaignDetail     = "AnalyticalCampaignDetail"
    case signUp             = "AnalyticalSignUp"
    case presentOffer       = "AnalyticalPresentOffer"
    case removeFromCart     = "AnalyticalRemoveOffer"
    case share              = "AnalyticalShare"
    case completedRegistration = "AnalyticalCompletedRegistration"
}

//public extension DefaultEvent {
//    func event() -> AnalyticalEvent {
//        return AnalyticalEvent(type: .default, name: self.rawValue, properties: nil)
//    }
//}
