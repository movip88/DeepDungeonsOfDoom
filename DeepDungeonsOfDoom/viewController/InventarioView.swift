//
//  InventarioView.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 01/12/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//

import UIKit

class InventarioView: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(Dao.getInstance().devolverHeroSelected().devolverStaff().devolverView())
        self.view.addSubview(Dao.getInstance().devolverHeroSelected().devolverViewStats(y: 500))
        
        let button:EstiloBoton = EstiloBoton(frame: CGRect(x: 20, y: 20, width: 80, height: 40), titulo: "Back")
        
        button.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @IBAction func clic(_:UIButton){
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "menu") as? ViewControllerMain
        
        self.present(newViewController!, animated: true, completion: nil)
    }
}
