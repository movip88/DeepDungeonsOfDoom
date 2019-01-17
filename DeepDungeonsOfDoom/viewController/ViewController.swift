//
//  ViewController.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 23/11/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController  = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var count:Int = 0
        
        for p in Dao.getInstance().devolverPersonajes(){
            if (!p.devolverVida().isDie()){
                self.view.addSubview(p.devolverViewPersonaje(y: Double(200*count)+30))
                count += 1
            }
        }
        
        if (count == 0){
            let lossView: UIView = {
                let view = UIView(frame: CGRect(x: 50, y: 150, width: 300, height: 400))
                
                let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
                
                imageView.image = UIImage(named: "back_heroe")
                
                view.addSubview(imageView)
                
                return view
            }()
            
            let etiqueta:UILabel = {
                let lbl:UILabel = UILabel(frame: CGRect(x: 20, y: 100, width: 260, height: 50))
                lbl.text = String("Te han matado a todos los heroes")
                lbl.textColor = UIColor.white
                return lbl
            }()
            
            let button:EstiloBoton = EstiloBoton(frame: CGRect(x: 50, y: 250, width: 200, height: 50), titulo: "Restart Game")
            
            button.addTarget(self, action: #selector(reiniciarJuego(_:)), for: .touchUpInside)
            
            lossView.addSubview(button)
            
            lossView.addSubview(etiqueta)
            
            lossView.tag = 100
            
            self.view.addSubview(lossView)
        }
    }
    
    @IBAction func reiniciarJuego(_:UIButton){
        Dao.reiniciarJuego()
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        self.viewDidLoad()
    }
}

