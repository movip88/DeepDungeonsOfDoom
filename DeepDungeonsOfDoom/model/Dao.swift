//
//  Dao.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 25/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import Foundation
import UIKit

class Dao{
    private static var instance:Dao?
    
    private var heroSelectet:Personaje?
    private var mounstruoSelectet:Mountruo?
    
    private var items:[Item]?
    
    private let staffGuerrero:Staff?
    private let staffArquero:Staff?
    private let staffMago:Staff?
    
    var moustruos:[Mountruo]?
    
    private let personajes:[Personaje]?
    
    public static func getInstance() -> Dao {
        if instance == nil{
            instance = Dao()
        }
        return instance!
    }
    
    private init(){
        self.items = [Item(ataque: 0, defensa: 10, magia: 0, suerte: 1, imagen: UIImage(named: "armour")!, tipo:"cuerpo", dinero:20),Item(ataque: 0, defensa: 20, magia: 2, suerte: 2, imagen: UIImage(named: "armour3")!, tipo:"cuerpo", dinero:60),Item(ataque: 0, defensa: 50, magia: 5, suerte: 5, imagen: UIImage(named: "armour2")!, tipo:"cuerpo", dinero:150),Item(ataque: 10, defensa: 0, magia: 0, suerte: 0, imagen: UIImage(named: "arrow")!, tipo:"arma", dinero:20),Item(ataque: 20, defensa: 0, magia: 5, suerte: 2, imagen: UIImage(named: "arrow2")!, tipo:"arma", dinero:65),Item(ataque: 50, defensa: 0, magia: 10, suerte: 5, imagen: UIImage(named: "arrow3")!, tipo:"arma", dinero:180),Item(ataque: 0, defensa: 0, magia: 0, suerte: 20, imagen: UIImage(named: "boots")!, tipo:"pies", dinero:20),Item(ataque: 0, defensa: 0, magia: 0, suerte: 50, imagen: UIImage(named: "boots2")!, tipo:"pies", dinero:200),Item(ataque: 0, defensa: 5, magia: 20, suerte: 10, imagen: UIImage(named: "cap")!, tipo:"cuerpo", dinero:60),Item(ataque: 0, defensa: 20, magia: 35, suerte: 10, imagen: UIImage(named: "cap3")!, tipo:"cuerpo", dinero:120),Item(ataque: 0, defensa: 20, magia: 60, suerte: 30, imagen: UIImage(named: "cap2")!, tipo:"cuerpo", dinero:300),Item(ataque: 5, defensa: 20, magia: 0, suerte: 0, imagen: UIImage(named: "helmet1")!, tipo:"cabeza", dinero:20),Item(ataque: 10, defensa: 30, magia: 5, suerte: 5, imagen: UIImage(named: "helmet2")!, tipo:"cabeza", dinero:100),Item(ataque: 0, defensa: 15, magia: 30, suerte: 20, imagen: UIImage(named: "helmet3")!, tipo:"cabeza", dinero:100),Item(ataque: 20, defensa: 20, magia: 10, suerte: 20, imagen: UIImage(named: "helmet4")!, tipo:"cabeza", dinero:180),Item(ataque: 0, defensa: 20, magia: 0, suerte: 0, imagen: UIImage(named: "helmet5")!, tipo:"cabeza", dinero:20),Item(ataque: 30, defensa: 0, magia: 0, suerte: 0, imagen: UIImage(named: "sword4")!, tipo:"arma", dinero:20),Item(ataque: 50, defensa: 10, magia: 5, suerte: 2, imagen: UIImage(named: "sword1")!, tipo:"arma", dinero:50),Item(ataque: 50, defensa: 20, magia: 20, suerte: 10, imagen: UIImage(named: "sword2")!, tipo:"arma", dinero:100),Item(ataque: 60, defensa: 30, magia: 30, suerte: 30, imagen: UIImage(named: "sword3")!, tipo:"arma", dinero:200),Item(ataque: 5, defensa: 15, magia: 0, suerte: 0, imagen: UIImage(named: "shield4")!, tipo:"escudo", dinero:20),Item(ataque: 10, defensa: 25, magia: 0, suerte: 0, imagen: UIImage(named: "shield")!, tipo:"escudo", dinero:50),Item(ataque: 15, defensa: 40, magia: 2, suerte: 10, imagen: UIImage(named: "shield2")!, tipo:"escudo", dinero:90),Item(ataque: 20, defensa: 60, magia: 5, suerte: 10, imagen: UIImage(named: "shield3")!, tipo:"escudo", dinero:150),Item(ataque: 10, defensa: 10, magia: 20, suerte: 10, imagen: UIImage(named: "scepter3")!, tipo:"arma", dinero:20),Item(ataque: 15, defensa: 15, magia: 50, suerte: 25, imagen: UIImage(named: "scepter")!, tipo:"arma", dinero:70),Item(ataque: 20, defensa: 20, magia: 60, suerte: 30, imagen: UIImage(named: "scepter2")!, tipo:"arma", dinero:300),Item(ataque: 20, defensa: 20, magia: 20, suerte: 20, imagen: UIImage(named: "ring")!, tipo:"especial", dinero:20),Item(ataque: 50, defensa: 50, magia: 50, suerte: 50, imagen: UIImage(named: "ring2")!, tipo:"especial", dinero:500),Item(ataque: 100, defensa: 100, magia: 100, suerte: 100, imagen: UIImage(named: "necklace")!, tipo:"especial", dinero:1000),Item(imagen: UIImage(named: "potion2")!, tipo: "cura", dinero: 200, corazones: 1),Item(imagen: UIImage(named: "potion")!, tipo: "cura", dinero: 400, corazones: 3)]
        
        self.staffGuerrero = Staff(items: ["arma": self.items![16],"pies": self.items![6],"cabeza": self.items![15],"cuerpo": self.items![0], "escudo": self.items![21], "especial": self.items![27]])
        self.staffArquero = Staff(items: ["arma": self.items![3],"pies": self.items![6],"cabeza": self.items![15],"cuerpo": self.items![0], "escudo": self.items![21], "especial": self.items![27]])
        self.staffMago = Staff(items: ["arma": self.items![24],"pies": self.items![6],"cabeza": self.items![13],"cuerpo": self.items![9], "escudo": self.items![21], "especial": self.items![27]])
        
        if let dataHero = UserDefaults.standard.data(forKey: "heroes"),
            let datos = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataHero) as? NSArray {
            self.personajes = datos as? [Personaje]
        } else {
            self.personajes = [Personaje(vida: Vidas(vida: 7), nombre: "movip88", dinero: 50, exp: 0, imagen: UIImage(named: "heroe1")!, staff: self.staffGuerrero!.copy() as! Staff), Personaje(vida: Vidas(vida: 5), nombre: "iscaporumba", dinero: 50, exp: 0, imagen: UIImage(named: "heroe2")!, staff: self.staffArquero!.copy() as! Staff), Personaje(vida: Vidas(vida: 3), nombre: "cris7iank", dinero: 50, exp: 0, imagen: UIImage(named: "heroe3")!, staff: self.staffMago!.copy() as! Staff)]
        }
        if let dataMons = UserDefaults.standard.data(forKey: "mounstruos"),
            let datos = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataMons) as? NSArray {
            self.moustruos = datos as? [Mountruo]
        } else {
            self.moustruos = [Mountruo(vida: Vidas(vida: 4), nombre: "La Cosa", dinero: 60, exp: 20, imagen: UIImage(named: "monster1")!, ataque: 2),Mountruo(vida: Vidas(vida: 4), nombre: "El hierbas", dinero: 50, exp: 30, imagen: UIImage(named: "monster2")!, ataque: 5),Mountruo(vida: Vidas(vida: 5), nombre: "La rata", dinero: 100, exp: 30, imagen: UIImage(named: "monster3")!, ataque: 9),Mountruo(vida: Vidas(vida: 3), nombre: "La mariscada", dinero: 120, exp: 50, imagen: UIImage(named: "monster4")!, ataque: 11),Mountruo(vida: Vidas(vida: 6), nombre: "El arañas", dinero: 150, exp: 60, imagen: UIImage(named: "monster5")!, ataque: 13),Mountruo(vida: Vidas(vida: 2), nombre: "El cuchillos", dinero: 60, exp: 3, imagen: UIImage(named: "monster6")!, ataque: 3),Mountruo(vida: Vidas(vida: 2), nombre: "La chupadora", dinero: 160, exp: 2, imagen: UIImage(named: "monster7")!, ataque: 22),Mountruo(vida: Vidas(vida: 6), nombre: "El dildos", dinero: 150, exp: 50, imagen: UIImage(named: "monster8")!, ataque: 7),Mountruo(vida: Vidas(vida: 3), nombre: "El setas", dinero: 220, exp: 100, imagen: UIImage(named: "monster9")!, ataque: 30),Mountruo(vida: Vidas(vida: 3), nombre: "El trompeta", dinero: 280, exp: 140, imagen: UIImage(named: "monster10")!, ataque: 33),Mountruo(vida: Vidas(vida: 5), nombre: "INDEFINIDO", dinero: 150, exp: 60, imagen: UIImage(named: "monster11")!, ataque: 24),Mountruo(vida: Vidas(vida: 6), nombre: "El pocimas", dinero: 190, exp: 130, imagen: UIImage(named: "monster12")!, ataque: 35),Mountruo(vida: Vidas(vida: 8), nombre: "Caperucita", dinero: 540, exp: 160, imagen: UIImage(named: "monster13")!, ataque: 35),Mountruo(vida: Vidas(vida: 8), nombre: "Ojalata", dinero: 640, exp: 160, imagen: UIImage(named: "monster14")!, ataque: 37),Mountruo(vida: Vidas(vida: 10), nombre: "El dios del mal", dinero: 1000, exp: 500, imagen: UIImage(named: "monster15")!, ataque: 40)]
        }
    }
    
    func devolverItems() -> [Item]{
        return self.items!
    }
    
    func devolverMonstruos() -> [Mountruo]{
        return self.moustruos!
    }
    
    func eliminarMounstruo(mons:Mountruo){
        for i in 0..<self.moustruos!.count{
            if self.moustruos![i] == mons{
                self.moustruos!.remove(at: i)
                break
            }
        }
        self.guardarDatos()
    }
    
    func devolverPersonajes() -> [Personaje]{
        return self.personajes!
    }
    
    func devolverHeroSelected() -> Personaje{
        return self.heroSelectet!
    }
    
    func devolverMounstrupSelected() -> Mountruo{
        return self.mounstruoSelectet!
    }
    
    func setHeroSelected(hero:Personaje){
        self.heroSelectet = hero
    }
    
    func setMonstruoSelected(monstruo:Mountruo){
        self.mounstruoSelectet = monstruo
    }
    
    func guardarDatos(){
        do {
            let heroesData = try NSKeyedArchiver.archivedData(withRootObject: self.personajes!, requiringSecureCoding: true)
            UserDefaults.standard.set(heroesData, forKey: "heroes")
            let monstersData = try NSKeyedArchiver.archivedData(withRootObject: self.moustruos!, requiringSecureCoding: true)
            UserDefaults.standard.set(monstersData, forKey: "mounstruos")
            UserDefaults.standard.synchronize()
        } catch{
            print("Error grabando")
        }
    }
    
    public static func reiniciarJuego(){
        UserDefaults.standard.removeObject(forKey: "heroes")
        UserDefaults.standard.removeObject(forKey: "mounstruos")
        UserDefaults.standard.synchronize()
        instance = nil
    }
}
