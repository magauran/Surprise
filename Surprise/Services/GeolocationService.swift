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
    func requestPermission(then handler: @escaping (Bool) -> Void)
}

final class GeolocationServiceImpl: NSObject {
    private let locationManager = CLLocationManager()
    private var authCallback: ((CLAuthorizationStatus) -> Void)?

    override init() {
        super.init()

        defer {
            self.locationManager.delegate = self
        }
    }
}

extension GeolocationServiceImpl: GeolocationService {
    var isDenied: Bool {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        return authorizationStatus == .denied
    }

    func requestPermission(then handler: @escaping (Bool) -> Void) {
        let status = CLLocationManager.authorizationStatus()
        guard status == .restricted else {
            let isAuthorized = (status == .authorizedAlways) || (status == .authorizedWhenInUse)
            handler(isAuthorized)
            return
        }

        self.locationManager.requestWhenInUseAuthorization()

        self.authCallback = { status in
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                handler(true)
            case .notDetermined, .restricted, .denied:
                handler(false)
            @unknown default:
                handler(false)
            }
        }
    }
}

extension GeolocationServiceImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authCallback?(status)
    }
}
