//
//  MainReducer.swift
//  Meet
//
//  Created by Benjamin Encz on 11/11/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import Foundation
import SwiftFlow
import SwiftFlowRouter
import SwiftFlowReactiveCocoaExtensions

struct MainReducer<AppStateType: NavigationStateProtocol where AppStateType: AppStateProtocol>: Reducer {
    
    var reducers: [AnyReducer<AppStateType>] = [AnyReducer(NavigationReducer())]
    
    func handleAction(var state: AppStateType, action: ActionProtocol) -> AppStateType {
        reducers.forEach { reducer in
            state = reducer.handleAction(state, action: action)
        }
        
        return state
    }
//        switch action {
//        case .SetNavigationState(let viewController):
//            return navigationReducer.setNavigationState(state, targetViewController: viewController)
//        case .NavigateTo(let viewController):
//            return navigationReducer.navigateToViewController(state, targetViewController: viewController)
//        case .CompleteNavigationTo(let viewController):
//            return navigationReducer.completeNavigationToViewController(state, completedTransitionViewController: viewController)
//        case .PresentViewController(let viewController):
//            return navigationReducer.presentViewController(state, targetViewController: viewController)
//        case .DismissViewController(let viewController):
//            return navigationReducer.dismissViewController(state, parentViewController: viewController)
//        case .CreateContactFromEmail(let email):
//            return dataMutationReducer.createContact(state, email: email)
//        case .DeleteContact(let identifier):
//            return dataMutationReducer.deleteContact(state, identifier: identifier)
//        case .SetContacts(let contacts):
//            return dataMutationReducer.setContacts(state, contacts: contacts)
//        case .SetTwitterClient(let swifter):
//            return twitterClientReducer.setTwitterClient(state, swifter: swifter)
//        case .SetUserSearchResults(let users):
//            return twitterClientReducer.setUserSearchResults(state, userSearchResults: users)
//        }
//    }
    
}