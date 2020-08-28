//
//  TrackingAnalyticUtil.swift
//  BaseApplication
//
//  Created by Dang Huu Tri on 1/15/20.
//  Copyright © 2020 Dang Huu Tri. All rights reserved.
//

import Foundation

public typealias Properties = [String : Any]


public protocol AnalyticalTracking {
    func track(event: String, properties: Properties?)
    func track(screen: String, properties: Properties?, className: String?)
    func track(event: TrackingEvent)
    func update(event: TrackingEvent)
}

public enum EventType {
    case `default`
    case screen
    case time
    case finishTime
    case purchase
}

public struct TrackingEvent {
    
    public var type = EventType.default
    public var name : String
    public var properties : Properties?
    
    public init(type: EventType = .default, name: String, properties: Properties? = nil) {
        self.type = type
        self.name = name
        self.properties = properties
    }
}

public protocol AnalyticalProvider: AnalyticalTracking {
    var delegate : AnalyticalProviderDelegate? { get set }

    func setup(with properties: Properties?)

    func activate()

    func resign()

    func flush()

    func reset()

    func identify(userId: String, properties: Properties?)
    
    /*!
     Connect the existing anonymous user with the alias (for example, after user signs up),
     and he was using the app anonymously before. This is used to connect the registered user
     to the dynamically generated ID it was given before. Identify will be called automatically.
     
     - parameter userId: user
     */
    func alias(userId: String, forId: String)
    
    /*!
     Sets properties to currently identified user.
     
     - parameter properties: properties
     */
    func set(properties: Properties)
    
    /*!
     Sets global properties to be sent on all events.
     
     - parameter properties: properties
     - paramater overwrite:  if properties should be overwritten, if previously set.
     */
    func global(properties: Properties, overwrite: Bool)
    
    /*!
     Increments currently set property by a number.
     
     - parameter property: property to increment
     - parameter number:   number to incrememt by
     */
    func increment(property: String, by number: NSDecimalNumber)
    
    func addDevice(token: Data)
    
    /*!
     Log push notification to the provider.
     
     - parameter payload:   push notification payload
     - parameter event:     action of the push
     */
    func push(payload: [AnyHashable : Any], event: String?)
}

public protocol AnalyticProtocol: AnalyticalProvider {
    var providers: [AnalyticalProvider] { get }
    func addProvider(provider: AnalyticalProvider)
    func provider<T : AnalyticalProvider>(ofType type: T.Type) -> T?
}


/*!
 *  Set provider delegate to modify certain analyics events on a single point of entry.
 */
public protocol AnalyticalProviderDelegate : class {
    /*!
     *  This method will be called on the delegate, before the event is sent. If delegate returns nil, event will be discarded.
     */
    func analyticalProviderShouldSendEvent(_ provider: AnalyticalProvider, event: TrackingEvent) -> TrackingEvent?
    
    /*!
     *  Called when provider finishes sending an event.
     */
    func analyticalProviderDidSendEvent(_ provider: AnalyticalProvider, event: TrackingEvent)
}
