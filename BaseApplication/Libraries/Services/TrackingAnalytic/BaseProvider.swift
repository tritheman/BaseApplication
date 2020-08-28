//
//  BaseProvider.swift
//  BaseApplication
//
//  Created by Dang Huu Tri on 1/15/20.
//  Copyright © 2020 Dang Huu Tri. All rights reserved.
//

import Foundation

open class BaseProvider <T> : AnalyticalProvider {
    
    // Stores global properties
    private var globalProperties : Properties?
    
    // Delegate
    public weak var delegate : AnalyticalProviderDelegate?
    
    open var events : [String : Date] = [:]
    open var properties : [String : Properties] = [:]
    
    open var instance : T! = nil
    
    public init () {
    }
    
    public func track(event: String, properties: Properties?) {
        
    }
    
    public func track(screen: String, properties: Properties?, className: String?) {
        
    }
    
    public func track(event: TrackingEvent) {
        switch event.type {
        case .time:
            events[event.name] = Date()
            
            if let properties = event.properties {
                self.properties[event.name] = properties
            }
        case .finishTime:
            
            var properties = event.properties
            
            if properties == nil {
                properties = [:]
            }
            
            if let time = events[event.name] {
                properties![Property.time.rawValue] = time.timeIntervalSinceNow as AnyObject?
            }
        default:
            //
            // A Generic Provider has no way to know how to send events.
            //
            assert(false)
        }
    }
    
    open func update(event: TrackingEvent) -> TrackingEvent? {
        if let delegate = delegate, let selfProvider = self as? AnalyticalProvider {
            return delegate.analyticalProviderShouldSendEvent(selfProvider, event: event)
        }
        else {
            return event
        }
    }
    
    open func global(properties: Properties, overwrite: Bool = true) {
        globalProperties = mergeGlobal(properties: properties, overwrite: overwrite)
    }
    
    open func addDevice(token: Data) {
        // No push feature
    }
    
    public func setup(with properties: Properties?) { }
    
    public func flush() { }
    
    public func reset() { }
    
    public func identify(userId: String, properties: Properties?) { }
    
    public func alias(userId: String, forId: String) { }
    
    public func set(properties: Properties) { }
    
    public func increment(property: String, by number: NSDecimalNumber) { }
    
    open func activate() { }
    
    open func resign() {
        
    }
    public func update(event: TrackingEvent) { }
    
    open func push(payload: [AnyHashable : Any], event: String?) {
        // No push logging feature, so we log a default event
        
        let properties : Properties? = (payload as? Properties) ?? nil
        
        let defaultEvent = TrackingEvent(name: DefaultEvent.pushNotification.rawValue, properties: properties)
        
        self.track(event: defaultEvent)
    }
    
    public func mergeGlobal(properties: Properties?, overwrite: Bool) -> Properties {
        var final : Properties = globalProperties ?? [:]
        
        if let properties = properties {
            for (property, value) in properties {
                if final[property] == nil || overwrite == true {
                    final[property] = value
                }
            }
        }
        
        return final
    }
}

