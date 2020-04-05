//тип UIImage находится в библиотеке UIKit
//библиотека Foundation находится в UIKit

import RealmSwift

//Realm работает только с класами. Наследуемся от Object. Это класс самого Realm
class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
    
}
