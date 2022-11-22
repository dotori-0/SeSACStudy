//
//  Gender.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/22.
//

import UIKit

enum Gender: Int {
    case female
    case male
    
    var description: String {
        switch self {
            case .female:
                return String.Gender.female
            case .male:
                return String.Gender.male
        }
    }
    
    var image: UIImage {
        switch self {
            case .female:
                return Asset.Gender.female.image
            case .male:
                return Asset.Gender.male.image
        }
    }
}
