import Foundation
import UIKit

class Staff: NSObject, NSCopying ,NSSecureCoding {
    static var supportsSecureCoding: Bool = true

    private var items:[String:Item] = [:]
    
    //funcion necesaria para codificar el objeto Coin
    func encode(with aCoder: NSCoder) {
        aCoder.encode(items, forKey: "items")
    }
    
    //funcion necesaria para descodificar el objeto Coin
    required init?(coder aDecoder: NSCoder) {
        self.items = (aDecoder.decodeObject(forKey: "items") as? [String:Item])!
    }
    
    init(items:[String:Item]){
        self.items = items
    }
    
    func setItem(item:Item){
        self.items[item.devolverTipo()] = item
    }
    
    func getArma() -> Item{
        return self.items["arma"]!
    }
    
    func getPies() -> Item{
        return self.items["pies"]!
    }
    
    func getCabeza() -> Item{
        return self.items["cabeza"]!
    }
    
    func getCuerpo() -> Item{
        return self.items["cuerpo"]!
    }
    
    func getEscudo() -> Item{
        return self.items["escudo"]!
    }
    
    func getEspecial() -> Item{
        return self.items["especial"]!
    }
    
    func getStats() -> [String:Int]{
        var ataque:Int = 0
        var defensa:Int = 0
        var magia:Int = 0
        var suerte:Int = 0

        for i in self.items.values{
            ataque += i.devolverAtaque()
            defensa += i.devolverDefensa()
            magia += i.devolverMagia()
            suerte += i.devolverSuerte()
        }
        return ["ataque":ataque,"defensa":defensa,"magia":magia,"suerte":suerte]
    }
    
    func devolverView() -> UIView{
        let view:UIView = VistaStaff(frame: CGRect(x: 20 , y: 20, width: 400, height: 400), staff: self)
        
        return view
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Staff(items: self.items)
        return copy
    }
}
