//
//  Vidas.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 24/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import Foundation

class Vidas: NSObject, NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    private var numVidas:Int?
    
    //funcion necesaria para codificar el objeto Coin
    func encode(with aCoder: NSCoder) {
        aCoder.encode(numVidas, forKey: "numVidas")
    }
    
    //funcion necesaria para descodificar el objeto Coin
    required init?(coder aDecoder: NSCoder) {
        self.numVidas = aDecoder.decodeObject(forKey: "numVidas") as? Int
    }
    
    init(vida:Int) {
        self.numVidas = vida
    }
    
    func restarVida(){
        self.numVidas! -= 1
    }
    
    func simarVidas(numVidas:Int){
        if((self.numVidas! + numVidas) >= 8){
            self.numVidas! = 8
        }else{
            self.numVidas! += numVidas
        }
    }
    
    func numVida() -> Int{
        return self.numVidas!
    }
    
    func isDie() -> Bool {
        return self.numVidas! > 0 ? false : true
    }
}
