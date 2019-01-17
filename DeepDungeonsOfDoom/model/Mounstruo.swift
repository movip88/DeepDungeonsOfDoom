//
//  Mounstruo.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 02/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import Foundation
import UIKit

class Mountruo : NSObject, Comparable, NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    static func < (lhs: Mountruo, rhs: Mountruo) -> Bool {
        return false
    }
    
    static func == (lhs: Mountruo, rhs: Mountruo) -> Bool {
        return lhs.devolverNombre() == rhs.devolverNombre()
    }
    
    private var vida:Vidas?
    private var nombre:String?
    private var dinero:Int?
    private var exp:Int?
    private var ataque:Int?
    private var imagen:UIImage?
    
    //funcion necesaria para codificar el objeto Coin
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: "nombre")
        aCoder.encode(vida, forKey: "vida")
        aCoder.encode(dinero, forKey: "dinero")
        aCoder.encode(exp, forKey: "exp")
        aCoder.encode(imagen, forKey: "imagen")
        aCoder.encode(ataque, forKey: "ataque")
    }
    
    //funcion necesaria para descodificar el objeto Coin
    required init?(coder aDecoder: NSCoder) {
        self.nombre = aDecoder.decodeObject(forKey: "nombre") as? String
        self.vida = aDecoder.decodeObject(forKey: "vida") as? Vidas
        self.dinero = aDecoder.decodeObject(forKey: "dinero") as? Int
        self.exp = aDecoder.decodeObject(forKey: "exp") as? Int
        self.imagen = aDecoder.decodeObject(forKey: "imagen") as? UIImage
        self.ataque = aDecoder.decodeObject(forKey: "ataque") as? Int
    }
    
    init(vida:Vidas, nombre:String, dinero:Int, exp:Int, imagen:UIImage, ataque:Int) {
        self.vida = vida
        self.nombre = nombre
        self.dinero = dinero
        self.exp = exp
        self.imagen = imagen
        self.ataque = ataque
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
    
    func devolverAtaque() -> Int{
        return self.ataque!
    }
    
    func devolverView() -> UIView{
        let view:UIView = VistaMounstruo(frame: CGRect(x: 0, y: 0, width: 400, height: 150), mounstruo: self)
        
        return view
    }
}
