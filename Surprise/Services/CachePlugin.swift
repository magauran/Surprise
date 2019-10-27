//
//  CachePlugin.swift
//  Surprise
//
//  Created by Alexey Salangin on 10/27/19.
//  Copyright © 2019 Alexey Salangin. All rights reserved.
//

import Moya

protocol MoyaCacheable {
    typealias CachePolicy = URLRequest.CachePolicy
    var cachePolicy: CachePolicy { get }
}

struct CachePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? MoyaCacheable else { return request }
        var cacheableRequest = request
        cacheableRequest.cachePolicy = target.cachePolicy
        return cacheableRequest
    }
}
