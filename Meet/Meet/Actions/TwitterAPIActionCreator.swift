//
//  TwitterAPIActionCreator.swift
//  Meet
//
//  Created by Benjamin Encz on 11/20/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import Foundation
import SwifteriOS
import ReactiveCocoa
import SwiftFlow
import SwiftFlowReactiveCocoaExtensions

struct TwitterAPIActionCreator {
    
    var twitterClient = TwitterClient.self
    
    typealias ActionCreator = (state: AppState, store: MainStore<AppState>) -> ActionProtocol?
    typealias AsyncActionCreator = (state: AppState, store: MainStore<AppState>) -> Signal<ActionCreator,NoError>?
    
    func authenticateUser() -> AsyncActionCreator {
        return { state, store in
        
            return Signal<ActionCreator, NoError> { observer in
                if state.twitterAPIState.swifter == nil {
                    
                    self.twitterClient.login().start { event in
                        switch event {
                        case let .Next(swifter):
                            observer.sendNext(self.setTwitterClient(swifter))
                        default:
                            print("oh")
                        }
                    }
                }
                
                return nil
            }
        }
    }
    
    func searchUsers(searchTerm: String) -> ActionCreator {
        return { state, store in
            
            self.twitterClient.findUsers(searchTerm).startWithNext { users in
                store.dispatch { self.setUserSearchResults(users) }
            }
            
            return (action: nil)
        }
    }
    
    func setUserSearchResults(searchResults: [TwitterUser]) -> ActionCreator {
        return { _ in
            return .SetUserSearchResults(searchResults)
        }
    }
    
    func setTwitterClient(swifter: Swifter) -> ActionCreator {
        return { _ in
            return .SetTwitterClient(swifter)
        }
    }
    
}