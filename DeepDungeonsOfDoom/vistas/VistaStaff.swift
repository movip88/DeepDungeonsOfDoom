//
//  VistaStaff.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 28/11/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class VistaStaff: UIView {
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
    
    convenience init(frame:CGRect, staff:Staff) {
        self.init(frame: frame)
        setData(staff: staff)
    }
    
    var statsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        return view
    }()
    
    func setData(staff:Staff){
        colocarImagen(x: 150, y: 50, w: 80, h: 80, i: staff.getCabeza().devolverImagen(), v: statsView)
        
        colocarImagen(x: 150, y: 150, w: 80, h: 80, i: staff.getCuerpo().devolverImagen(), v: statsView)
        
        colocarImagen(x: 150, y: 250, w: 80, h: 80, i: staff.getPies().devolverImagen(), v: statsView)
        
        colocarImagen(x: 50, y: 150, w: 80, h: 80, i: staff.getEscudo().devolverImagen(), v: statsView)
        
        colocarImagen(x: 250, y: 150, w: 80, h: 80, i: staff.getArma().devolverImagen(), v: statsView)
        
        colocarImagen(x: 250, y: 70, w: 50, h: 50, i: staff.getEspecial().devolverImagen(), v: statsView)
    }
    
    private func colocarImagen(x:Double,y:Double,w:Double,h:Double,i:UIImage,v:UIView){
        let imagen:UIImageView = {
            let image:UIImageView = UIImageView(frame: CGRect(x: x, y: y, width: w, height: h))
            image.image = i
            return image
        }()
        v.addSubview(imagen)
    }
}
