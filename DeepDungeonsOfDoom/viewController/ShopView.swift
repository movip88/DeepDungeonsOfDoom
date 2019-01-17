//
//  ShopView.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 01/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit
import AVFoundation

class ShopView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    var sonido = AVAudioPlayer()
    let pickerView:UIPickerView = UIPickerView(frame: CGRect(x: 10, y: 100, width: 400, height: 400))
    
    let valor:UILabel = {
        let lbl:UILabel = UILabel(frame: CGRect(x: 350, y: 50, width: 50, height: 50))
        lbl.text = String(Dao.getInstance().devolverHeroSelected().devolverDinero())
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Dao.getInstance().devolverItems().count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return Dao.getInstance().devolverItems()[row].devolverView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            sonido = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "dinero", ofType: "mp3")!))
        }catch{
            print(error)
        }
        let icono:UIImageView = {
            let ataqueImage:UIImageView = UIImageView(frame: CGRect(x: 300, y: 50, width: 50, height: 50))
            ataqueImage.image = UIImage(named: "money")
            return ataqueImage
        }()
        
        self.view.addSubview(icono)
        
        self.view.addSubview(valor)
        
        let button:EstiloBoton = EstiloBoton(frame: CGRect(x: 20, y: 20, width: 80, height: 40), titulo: "Back")
        
        button.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        self.view.addSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let comprar:EstiloBoton = EstiloBoton(frame: CGRect(x: 150, y: 550, width: 80, height: 40), titulo: "Buy Item")
        
        comprar.addTarget(self, action: #selector(comprar(_:)), for: .touchUpInside)
        
        self.view.addSubview(comprar)
        
    }
    
    @IBAction func clic(_:UIButton){
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "menu") as? ViewControllerMain
        
        self.present(newViewController!, animated: true, completion: nil)
    }
    
    @IBAction func comprar(_:UIButton){
        var res:String = ""
        if(Dao.getInstance().devolverHeroSelected().devolverDinero()>=Dao.getInstance().devolverItems()[pickerView.selectedRow(inComponent: 0)].devolverDinero()){
            if (Dao.getInstance().devolverItems()[pickerView.selectedRow(inComponent: 0)].devolverTipo() == "cura"){
                Dao.getInstance().devolverHeroSelected().devolverVida().simarVidas(numVidas: Dao.getInstance().devolverItems()[pickerView.selectedRow(inComponent: 0)].devolverCorazones())
            }else{
                Dao.getInstance().devolverHeroSelected().devolverStaff().setItem(item: Dao.getInstance().devolverItems()[pickerView.selectedRow(inComponent: 0)])
            }
            Dao.getInstance().devolverHeroSelected().restarDinero(res: Dao.getInstance().devolverItems()[pickerView.selectedRow(inComponent: 0)].devolverDinero())
            valor.text = String(Dao.getInstance().devolverHeroSelected().devolverDinero())
            res = "Item Purchased"
            self.sonido.play()
            Dao.getInstance().guardarDatos()
        }else{
            res = "You do not have enough money"
        }
        let alert = UIAlertController(title: "Info", message: res, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "It is understood", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
