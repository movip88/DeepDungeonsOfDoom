import Foundation
import UIKit

class Item: NSObject, NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    private var ataque:Int?
    private var defensa:Int?
    private var magia:Int?
    private var suerte:Int?
    private var imagen:UIImage?
    private var tipo:String?
    private var dinero:Int?
    private var corazones:Int?
    
    //funcion necesaria para codificar el objeto Coin
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ataque, forKey: "ataque")
        aCoder.encode(defensa, forKey: "defensa")
        aCoder.encode(dinero, forKey: "dinero")
        aCoder.encode(magia, forKey: "magia")
        aCoder.encode(imagen, forKey: "imagen")
        aCoder.encode(tipo, forKey: "tipo")
        aCoder.encode(suerte, forKey: "suerte")
    }
    
    //funcion necesaria para descodificar el objeto Coin
    required init?(coder aDecoder: NSCoder) {
        self.ataque = aDecoder.decodeObject(forKey: "ataque") as? Int
        self.defensa = aDecoder.decodeObject(forKey: "defensa") as? Int
        self.dinero = aDecoder.decodeObject(forKey: "dinero") as? Int
        self.magia = aDecoder.decodeObject(forKey: "magia") as? Int
        self.imagen = aDecoder.decodeObject(forKey: "imagen") as? UIImage
        self.tipo = aDecoder.decodeObject(forKey: "tipo") as? String
        self.suerte = aDecoder.decodeObject(forKey: "suerte") as? Int
    }
    
    init(ataque:Int, defensa:Int, magia:Int, suerte:Int, imagen:UIImage, tipo:String, dinero:Int){
        self.ataque = ataque
        self.defensa = defensa
        self.magia = magia
        self.suerte = suerte
        self.imagen = imagen
        self.tipo = tipo
        self.dinero = dinero
    }
    
    init(imagen:UIImage, tipo:String, dinero:Int, corazones:Int){
        self.imagen = imagen
        self.tipo = tipo
        self.dinero = dinero
        self.corazones = corazones
    }
    
    func devolverAtaque() -> Int{
        return self.ataque!
    }
    
    func devolverCorazones() -> Int{
        return self.corazones!
    }
    
    func devolverTipo() -> String{
        return self.tipo!
    }
    
    func devolverDefensa() -> Int{
        return self.defensa!
    }
    
    func devolverMagia() -> Int{
        return self.magia!
    }
    
    func devolverSuerte() -> Int{
        return self.suerte!
    }
    
    func devolverImagen() -> UIImage{
        return self.imagen!
    }
    
    func devolverDinero() -> Int{
        return self.dinero!
    }
    
    func devolverView() -> UIView{
        let view:UIView = VistaItem(frame: CGRect(x: 0, y: 0, width: 400, height: 150), item: self)
        
        return view
    }
}
