//
//  AuthAndRegistrationManager.swift
//  Done
//
//  Created by LizOk&Same on 20.09.26.
//

import Foundation
import UIKit
import KeychainSwift

final class AuthAndRegistrationManager {
    static let shared = AuthAndRegistrationManager()
    private let keychain = KeychainSwift()
    
    enum Keys: String {
        case firstName
        case lastName
        case email
        case password
        case isAuthUser
    }
    private init() {}
    
    func userRegistration(firstName: String, lastName: String, email: String, password: String){
        keychain.set(firstName, forKey: Keys.firstName.rawValue)
        keychain.set(lastName, forKey: Keys.lastName.rawValue)
        keychain.set(email, forKey: Keys.email.rawValue)
        keychain.set(password, forKey: Keys.password.rawValue)
    }
    
    func loadUser(completion: @escaping (String?, String?) -> Void) {
        let firstName = keychain.get(Keys.firstName.rawValue)
        let lastName = keychain.get(Keys.lastName.rawValue)
        completion(firstName, lastName)
    }
    
    func getEmail() -> String? {
        return keychain.get(Keys.email.rawValue)
    }

    func getPassword() -> String? {
        return keychain.get(Keys.password.rawValue)
    }
    
    func setAuthUser(_ isAuthUser: Bool) {
        keychain.set(
            isAuthUser,
            forKey: Keys.isAuthUser.rawValue
        )
    }
    
    func getAuthUser() -> Bool {
        return keychain.getBool(Keys.isAuthUser.rawValue) ?? false
    }
    
    func logout() {
        keychain.set(
            false,
            forKey: Keys.isAuthUser.rawValue
        )
    }
    
    func deleteAllUserData() {
        keychain.delete(Keys.firstName.rawValue)
        keychain.delete(Keys.lastName.rawValue)
        keychain.delete(Keys.email.rawValue)
        keychain.delete(Keys.password.rawValue)
        keychain.delete(Keys.isAuthUser.rawValue)
    }
}
