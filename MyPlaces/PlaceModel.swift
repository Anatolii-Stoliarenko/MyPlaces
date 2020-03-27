//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Anatolii Stoliarenko on 27/03/2020.
//  Copyright © 2020 Anatolii Stoliarenko. All rights reserved.
//

import Foundation

struct Place {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let restaurantNames = ["1998 — Крошка моя",
                                "1999 — Прости",
                                "2001 — 18 мне уже",
                                "2002 — Он тебя целует",
                                "2018 — Плачешь в Темноте"]
    
    //делаем этот метод статичным (методом структуры). Это дает возмодность обращаться к нему не через сам экзмепляр структуры, но через саму структуру. В этом случае все свойства должна также быть статичными
    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Москва", type: "Руки вверх", image: place))
            
        }
        
        
        return places
    }
    
}
