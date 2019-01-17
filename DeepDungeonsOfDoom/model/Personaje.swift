import Foundation
import UIKit

class Personaje: NSObject, NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    private var vida:Vidas?
    private var nombre:String?
    private var dinero:Int?
    private var exp:Int?
    private var imagen:UIImage?
    private var staff:Staff?
    
    //funcion necesaria para codificar el objeto Coin
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: "nombre")
        aCoder.encode(vida, forKey: "vida")
        aCoder.encode(dinero, forKey: "dinero")
        aCoder.encode(exp, forKey: "exp")
        aCoder.encode(imagen, forKey: "imagen")
        aCoder.encode(staff, forKey: "staff")
    }
    
    //funcion necesaria para descodificar el objeto Coin
    required init?(coder aDecoder: NSCoder) {
        self.nombre = aDecoder.decodeObject(forKey: "nombre") as? String
        self.vida = aDecoder.decodeObject(forKey: "vida") as? Vidas
        self.dinero = aDecoder.decodeObject(forKey: "dinero") as? Int
        self.exp = aDecoder.decodeObject(forKey: "exp") as? Int
        self.imagen = aDecoder.decodeObject(forKey: "imagen") as? UIImage
        self.staff = aDecoder.decodeObject(forKey: "staff") as? Staff
    }
    
    init(vida:Vidas, nombre:String, dinero:Int, exp:Int, imagen:UIImage, staff:Staff) {
        self.vida = vida
        self.nombre = nombre
        self.dinero = dinero
        self.exp = exp
        self.imagen = imagen
        self.staff = staff
    }
    
    func devolverNombre() -> String{
        return self.nombre!
    }
    
    func devolverVida() -> Vidas{
        return self.vida!
    }
    
    func devolverDinero() -> Int{
        return self.dinero!
    }
    
    func devolverExp() -> Int{
        return self.exp!
    }
    
    func devolverImagen() -> UIImage{
        return self.imagen!
    }
    
    func devolverStaff() -> Staff{
        return self.staff!
    }
    
    func restarDinero(res:Int){
        self.dinero! -= res
    }
    
    func sumarDinero(dinero:Int){
        self.dinero! += dinero
    }
    
    func sumarExp(exp:Int){
        self.exp! += exp
    }
    
    func devolverAtaqueBatalla() -> Int{
        return (self.staff!.getStats()["ataque"]!)/4
    }
    
    func devolverViewPersonaje(y:Double) -> UIView{
        let view:UIView = VistaHero(frame: CGRect(x: 17 , y: y, width: 400, height: 200), personaje: self, tipoVista: true)
        
        return view
    }
    
    func devolverViewStats(y:Double) -> UIView{
        let view:UIView = VistaHero(frame: CGRect(x: 17 , y: y, width: 400, height: 200), personaje: self, tipoVista: false)
        
        return view
    }
}
