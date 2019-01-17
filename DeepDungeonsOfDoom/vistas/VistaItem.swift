//
//  VistaItem.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 01/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class VistaItem: UIView {
    var item:Item?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){
        self.addSubview(statsView)
    }
    
    convenience init(frame:CGRect, item:Item) {
        self.init(frame: frame)
        self.item = item
        setData()
    }
    
    var statsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 150))
        return view
    }()
    
    func setData(){
        let imagenItem:UIImageView = {
            let image:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            image.image = self.item!.devolverImagen()
            return image
        }()
        statsView.addSubview(imagenItem)
        if(self.item!.devolverTipo() == "cura"){
            statsView.addSubview(etiqueta(etiqueta: "Vidas: ", valor: self.item!.devolverCorazones(), x: 155, y: 54))
        }else{
            statsView.addSubview(etiqueta(etiqueta: "Ataque: ", valor: self.item!.devolverAtaque(), x: 155, y: 0))
            statsView.addSubview(etiqueta(etiqueta: "Defensa: ", valor: self.item!.devolverDefensa(), x: 155, y: 36))
            statsView.addSubview(etiqueta(etiqueta: "Magia: ", valor: self.item!.devolverMagia(), x: 155, y: 72))
            statsView.addSubview(etiqueta(etiqueta: "Suerte: ", valor: self.item!.devolverSuerte(), x: 155, y: 108))
        }
        statsView.addSubview(etiqueta(etiqueta: "Dinero: ", valor: self.item!.devolverDinero(), x: 280, y: 54))
    }
    
    private func etiqueta(etiqueta:String, valor:Int, x:Double, y:Double) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: 120, height: 36))
        
        let labelEtiqueta:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 36))
            lbl.text = etiqueta
            lbl.textColor = UIColor.white
            return lbl
        }()
        let valor:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 80, y: 0, width: 40, height: 36))
            lbl.text = String(valor)
            lbl.textColor = UIColor.white
            return lbl
        }()
        
        view.addSubview(labelEtiqueta)
        view.addSubview(valor)
        
        return view
    }
}
