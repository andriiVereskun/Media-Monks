//
//  ApplicationConfiguration.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import Foundation

final class ApplicationConfiguration {
    
    // MARK: - Private Properties
    
    private let predefinedWebsiteURLString: String = {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let websiteURLString = infoDictionary["pr-predefined-service-website-url"] as? String
            else {
                return ""
        }
        return websiteURLString
    }()
    
    private let predefinedTermsAndConditionsURLString: String = {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let websiteURLString = infoDictionary["pr-predefined-terms-and-conditions"] as? String
            else {
                return ""
        }
        return websiteURLString
    }()
    
    private let predefinedPrivacyPolicyURLString: String = {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let websiteURLString = infoDictionary["pr-predefined-privacy-policy"] as? String
            else {
                return ""
        }
        return websiteURLString
    }()
    
    
    // MARK: - Public Properties
    
    var predefinedWebsiteURL: URL {
        return URL(string: predefinedWebsiteURLString)!
    }
    
    var predefinedTermsAndConditionsURL: URL {
        return URL(string: predefinedTermsAndConditionsURLString)!
    }
    
    var predefinedPrivacyPolicyURL: URL {
        return URL(string: predefinedPrivacyPolicyURLString)!
    }
    
    var applicationKeychainSafeStorageServiceKey: String {
        let applicationKeychainServiceKey = "PRKeychainServiceMediaMonks"
        return applicationKeychainServiceKey
    }
    
    var applicationVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        return "\(version) (build: \(build))"
    }
    
}
