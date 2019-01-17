//
//  EstiloBoton.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 02/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//
import UIKit

class EstiloBoton:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        customize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customize()
    }
    
    convenience init(frame: CGRect,titulo:String) {
        self.init(frame: frame)
        customize()
        setTitle(titulo, for: .normal)
    }
    
    func customize() {
        layer.cornerRadius = self.frame.size.height / 4
        backgroundColor = UIColor.brown
        titleLabel?.textColor = UIColor.white
        self.alpha = 1.0
    }
    
    
}
