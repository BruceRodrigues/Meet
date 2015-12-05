//
//  DataMutationActions.swift
//  Meet
//
//  Created by Benjamin Encz on 12/4/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import Foundation
import SwiftFlow

// MARK: Create Contact From Email

struct CreateContactFromEmail {
    static let type = "CreateContactFromEmail"
    let email: String

    init(_ email: String) {
        self.email = email
    }
}

extension CreateContactFromEmail: ActionConvertible, ActionType {

    init(_ action: Action) {
        self.email = action.payload!["email"] as! String
    }

    func toAction() -> Action {
        return Action(type: CreateContactFromEmail.type, payload: ["email": email])
    }
}

// MARK: Create From Twitter User

struct CreateContactWithTwitterUser {
    static let type = "CreateContactWithTwitterUser"
    let twitterUser: TwitterUser

    init(_ twitterUser: TwitterUser) {
        self.twitterUser = twitterUser
    }
}

extension CreateContactWithTwitterUser: ActionConvertible, ActionType {

    init(_ action: Action) {
        self.twitterUser = TwitterUser(dictionary: action.payload!["twitterUser"] as! [String : AnyObject])
    }

    func toAction() -> Action {
        return Action(type: CreateContactFromEmail.type,
            payload: ["twitterUser": twitterUser.dictionaryRepresentation()])
    }
}

// MARK: Create From Twitter User

struct DeleteContact {
    static let type = "DeleteContact"
    let contactID: Int

    init(_ contactID: Int) {
        self.contactID = contactID
    }
}

extension DeleteContact: ActionConvertible, ActionType {

    init(_ action: Action) {
        self.contactID = action.payload!["contactID"] as! Int
    }

    func toAction() -> Action {
        return Action(type: "DeleteContact",
            payload: ["contactID": contactID])
    }

}

// MARK: Set Contacts

struct SetContacts {
    static let type = "SetContacts"
    let contacts: [Contact]

    init(contacts: [Contact]) {
        self.contacts = contacts
    }
}

extension SetContacts: ActionConvertible, ActionType {

    init(_ action: Action) {
        self.contacts = (action.payload!["contacts"] as! [[String : AnyObject]]).map {
            return Contact(dictionary: $0)
        }
    }

    func toAction() -> Action {
        return Action(type: "SetContacts",
            payload: ["contacts": contacts.map { $0.dictionaryRepresentation() }])
    }

}