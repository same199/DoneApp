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
    
    func loadUser() {
        let firstName = keychain.get(Keys.firstName.rawValue)
        let lastName = keychain.get(Keys.lastName.rawValue)
        let email = keychain.get(Keys.email.rawValue)
        let password = keychain.get(Keys.password.rawValue)

        print("NAME:", firstName ?? "nil")
        print("SURNAME:", lastName ?? "nil")
        print("EMAIL:", email ?? "nil")
        print("PASSWORD:", password ?? "nil")
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
}
