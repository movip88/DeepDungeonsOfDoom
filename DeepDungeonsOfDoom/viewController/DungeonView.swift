//
//  DungeonView.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 02/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class DungeonView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerView:UIPickerView = UIPickerView(frame: CGRect(x: 10, y: 100, width: 400, height: 400))
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Dao.getInstance().devolverMonstruos().count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return Dao.getInstance().devolverMonstruos()[row].devolverView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Dao.getInstance().devolverMonstruos().count > 0){
            let button:EstiloBoton = EstiloBoton(frame: CGRect(x: 20, y: 20, width: 80, height: 40), titulo: "Back")
        
            button.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
        
            self.view.addSubview(button)
        
            self.view.addSubview(pickerView)
        
            pickerView.delegate = self
            pickerView.dataSource = self
        
            let comprar:EstiloBoton = EstiloBoton(frame: CGRect(x: 150, y: 550, width: 80, height: 40), titulo: "Fight")
        
            comprar.addTarget(self, action: #selector(luchar(_:)), for: .touchUpInside)
        
            self.view.addSubview(comprar)
        }else{
            let lossView: UIView = {
                let view = UIView(frame: CGRect(x: 50, y: 150, width: 300, height: 400))
                
                let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
                
                imageView.image = UIImage(named: "back_heroe")
                
                view.addSubview(imageView)
                
                return view
            }()
            
            let etiqueta:UILabel = {
                let lbl:UILabel = UILabel(frame: CGRect(x: 20, y: 100, width: 260, height: 150))
                lbl.lineBreakMode = .byWordWrapping
                lbl.numberOfLines = 0
                lbl.text = "Has matado a todos los monstruos Felicidades!!"
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
        
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "inicio") as? ViewController
        
        self.present(newViewController!, animated: true, completion: nil)
    }
    
    @IBAction func clic(_:UIButton){
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "menu") as? ViewControllerMain
        
        self.present(newViewController!, animated: true, completion: nil)
    }
    
    @IBAction func luchar(_:UIButton){
        Dao.getInstance().setMonstruoSelected(monstruo: Dao.getInstance().devolverMonstruos()[pickerView.selectedRow(inComponent: 0)])
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "battle") as? BattleView
        
        self.present(newViewController!, animated: true, completion: nil)
    }
}
