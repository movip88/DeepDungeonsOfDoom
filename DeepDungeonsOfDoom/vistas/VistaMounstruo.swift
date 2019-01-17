//
//  VistaMounstruo.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 02/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class VistaMounstruo: UIView {

    var mounstruo:Mountruo?
    
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
    
    convenience init(frame:CGRect, mounstruo:Mountruo) {
        self.init(frame: frame)
        self.mounstruo = mounstruo
        setData()
    }
    
    var statsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 150))
        return view
    }()
    
    func setData(){
        let imagenItem:UIImageView = {
            let image:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            image.image = self.mounstruo!.devolverImagen()
            return image
        }()
        statsView.addSubview(imagenItem)
        statsView.addSubview(etiqueta(etiqueta: "Nombre: ", valor: self.mounstruo!.devolverNombre(), x: 155, y: 0))
        statsView.addSubview(etiqueta(etiqueta: "Ataque: ", valor: String(self.mounstruo!.devolverAtaque()), x: 155, y: 36))
        statsView.addSubview(etiqueta(etiqueta: "Exp: ", valor: String(self.mounstruo!.devolverExp()), x: 155, y: 72))
        statsView.addSubview(etiqueta(etiqueta: "Dinero: ", valor: String(self.mounstruo!.devolverDinero()), x: 155, y: 108))
    }
    
    private func etiqueta(etiqueta:String, valor:String, x:Double, y:Double) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: 350, height: 36))
        
        let labelEtiqueta:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 36))
            lbl.text = etiqueta
            lbl.textColor = UIColor.white
            return lbl
        }()
        let valor:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 80, y: 0, width: 200, height: 36))
            lbl.text = String(valor)
            lbl.textColor = UIColor.white
            return lbl
        }()
        
        view.addSubview(labelEtiqueta)
        view.addSubview(valor)
        
        return view
    }
    
}
