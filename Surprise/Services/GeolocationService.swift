//
//  GeolocationService.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/28/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import CoreLocation

protocol GeolocationService {
    var isDenied: Bool { get }
    func requestPermission() -> Bool
}

final class GeolocationServiceImpl {
    private let locationManager = CLLocationManager()
}

extension GeolocationServiceImpl: GeolocationService {
    var isDenied: Bool {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        return authorizationStatus == .denied
    }

    func requestPermission() -> Bool {
        self.locationManager.requestWhenInUseAuthorization()
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
}
