//
//  VistaBatalla.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 06/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit
import AVFoundation

class VistaBatalla: UIView{
    
    var sonido = AVAudioPlayer()
    var imagenPersonaje:UIImage?
    var vidas:Vidas?
    var imagen:UIImageView?
    
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
    
    convenience init(frame:CGRect, imagenPersonaje:UIImage, vidas:Vidas) {
        self.init(frame: frame)
        self.imagenPersonaje = imagenPersonaje
        self.vidas = vidas
        setData()
        do{
            sonido = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ataque", ofType: "mp3")!))
        }catch{
            print(error)
        }
    }

    var statsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        
        return view
    }()
    
    func setData(){
        updateVidas()
        imagen = {
            let image:UIImageView = UIImageView(frame: CGRect(x: 5, y: 50, width: 90, height: 90))
            image.image = self.imagenPersonaje!
            return image
        }()
        statsView.addSubview(imagen!)
        setGolpe(golpe: 0)
    }
    
    func updateVidas() {
        let viewVidas:UIView = VistaHero.colocarVidas(vidas:self.vidas!, x:100, y:15, tam: 30)
        viewVidas.tag = 50
        if let viewWithTag = statsView.viewWithTag(50){
            viewWithTag.removeFromSuperview()
        }
        statsView.addSubview(viewVidas)
    }
    
    func setGolpe(golpe:Int){
        let labelEtiqueta:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
            lbl.text = "Golpe \(golpe)"
            lbl.textColor = UIColor.white
            return lbl
        }()
        labelEtiqueta.tag = 100
        
        if let viewWithTag = statsView.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        statsView.addSubview(labelEtiqueta)
    }
    
    func atacar(dirrecion:Bool){
        BattleView.fihgt.isHidden = true
        UIView.animate(withDuration: 1, animations: {
            if dirrecion{
                self.imagen!.frame.origin.y -= 450
            }else{
                self.imagen!.frame.origin.y += 450
            }
            self.sonido.play()
        }, completion: { finished in
            self.imagen!.frame.origin.y = 0
            BattleView.fihgt.isHidden = false
        })
    }
}
