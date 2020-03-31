//тип UIImage находится в библиотеке UIKit
//библиотека Foundation находится в UIKit

import UIKit

struct Place {
    
    //делаем все поля опциональными, а name оставляем обязательным
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let restaurantNames = ["1998 — Крошка моя",
                                  "1999 — Прости",
                                  "2001 — 18 мне уже",
                                  "2002 — Он тебя целует",
                                  "2018 — Плачешь в Темноте"]
    
    //делаем этот метод статичным (методом структуры). Это дает возможность обращаться к нему не через сам экзмепляр структуры, но через саму структуру. В этом случае все свойства должны также быть статичными
    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Москва", type: "Руки вверх", image: nil, restaurantImage: place))
            
        }
        
        
        return places
    }
    
}
