//
//  Vista.swift
//  DeepDungeonsOfDoom
//
//  Created by Pol Monleón Vives on 23/11/2018.
//  Copyright © 2018 Pol Monleón Vives. All rights reserved.
//
import UIKit

class VistaHero: UIView{
    
    var personaje:Personaje?
    
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
    
    convenience init(frame:CGRect, personaje:Personaje, tipoVista:Bool) {
        self.init(frame: frame)
        self.personaje = personaje
        setData(tipoVista: tipoVista)
    }
    
    var statsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
        
        let imageView:UIImageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 400, height: 200))
        
        imageView.image = UIImage(named: "back_heroe")
        
        view.addSubview(imageView)
        
        return view
    }()
    
    func setData(tipoVista:Bool){
        if(tipoVista){
            let imagenHero:UIImageView = {
                let heroImage:UIImageView = UIImageView(frame: CGRect(x: 5, y: 65, width: 90, height: 90))
                heroImage.image = self.personaje!.devolverImagen()
                return heroImage
            }()
            statsView.addSubview(imagenHero)
        }else{
            statsView.addSubview(cuadradoView(etiqueta: "MON", imagen: UIImage(named: "money")!, valor: self.personaje!.devolverDinero(), x: 25, y: 65))
            statsView.addSubview(cuadradoView(etiqueta: "EXP", imagen: UIImage(named: "xp")!, valor: self.personaje!.devolverExp(), x: 25, y: 115))
        }
        
        let nombre:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 25, y: 15, width: 150, height: 50))
            lbl.text = self.personaje!.devolverNombre()
            lbl.font = lbl.font.withSize(20)
            lbl.textColor = UIColor.white
            return lbl
        }()
        
        statsView.addSubview(nombre)
        statsView.addSubview(VistaHero.colocarVidas(vidas:self.personaje!.devolverVida(), x:150, y:15, tam:50))
        let stats:[String:Int] = self.personaje!.devolverStaff().getStats()
        statsView.addSubview(cuadradoView(etiqueta: "ATQ", imagen: UIImage(named: "damage")!, valor: stats["ataque"]!, x: 140, y: 65))
        statsView.addSubview(cuadradoView(etiqueta: "MAG", imagen: UIImage(named: "magic")!, valor: stats["magia"]!, x: 260, y: 65))
        statsView.addSubview(cuadradoView(etiqueta: "DEF", imagen: UIImage(named: "defensa")!, valor: stats["defensa"]!, x: 140, y: 115))
        statsView.addSubview(cuadradoView(etiqueta: "LCK", imagen: UIImage(named: "lucky")!, valor: stats["suerte"]!, x: 260, y: 115))
        
        if(tipoVista){
            let button:UIButton = UIButton(frame: CGRect(x: -10, y: 0, width: 400, height: 180))

            button.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
        
            statsView.addSubview(button)
        }
    }
    
    public static func colocarVidas(vidas:Vidas, x:Int, y:Int, tam:Int) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: 200, height: 50))
        
        if (vidas.isDie()){
            let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: tam, height: tam))
            imageView.image = UIImage(named: "calavera")
            
            view.addSubview(imageView)
            
            return view
        }
        
        let corazones = vidas.numVida()/2
        
        for i in 0..<corazones{
            let imageView:UIImageView = UIImageView(frame: CGRect(x: i*50, y: 0, width: tam, height: tam))
            imageView.image = UIImage(named: "heart")
        
            view.addSubview(imageView)
        }
        
        if(vidas.numVida() % 2 != 0){
            let imageView:UIImageView = UIImageView(frame: CGRect(x: corazones*50, y: 0, width: tam, height: tam))
            imageView.image = UIImage(named: "heart_middle")
            
            view.addSubview(imageView)
        }
        
        return view
    }
    
    private func cuadradoView(etiqueta:String, imagen:UIImage, valor:Int, x:Double, y:Double) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: 125, height: 50))
        
        let labelEtiqueta:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
            lbl.text = etiqueta
            lbl.textColor = UIColor.white
            return lbl
        }()
        
        let icono:UIImageView = {
            let ataqueImage:UIImageView = UIImageView(frame: CGRect(x: 40, y: 0, width: 40, height: 50))
            ataqueImage.image = imagen
            return ataqueImage
        }()
        
        let valor:UILabel = {
            let lbl:UILabel = UILabel(frame: CGRect(x: 80, y: 0, width: 40, height: 50))
            lbl.text = String(valor)
            lbl.textColor = UIColor.white
            return lbl
        }()
        
        view.addSubview(labelEtiqueta)
        view.addSubview(icono)
        view.addSubview(valor)
        
        return view
    }
    
    @IBAction func clic(_: UIButton) {
        Dao.getInstance().setHeroSelected(hero: personaje!)
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController as! ViewController
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "menu") as? ViewControllerMain
        
        viewController.present(newViewController!, animated: true, completion: nil)
    }
}
