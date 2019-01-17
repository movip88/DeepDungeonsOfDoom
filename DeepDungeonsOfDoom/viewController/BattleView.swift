import UIKit
import AVFoundation

class BattleView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sonido = AVAudioPlayer()
    
    let button:EstiloBoton = EstiloBoton(frame: CGRect(x: 20, y: 20, width: 80, height: 40), titulo: "Back")
    
    let pickerViewMonster:UIPickerView = UIPickerView(frame: CGRect(x: 10, y: 225, width: 400, height: 100))
    let pickerViewHero:UIPickerView = UIPickerView(frame: CGRect(x: 10, y: 400, width: 400, height: 100))
    
    static var fihgt:EstiloBoton = EstiloBoton()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView == pickerViewHero ? devolverDados(ataque: Dao.getInstance().devolverHeroSelected().devolverAtaqueBatalla()) : Dao.getInstance().devolverMounstrupSelected().devolverAtaque() / 10 == 0 ? 1 : Dao.getInstance().devolverMounstrupSelected().devolverAtaque() / 10
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        let imagen:UIImageView = {
            let image:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
            image.image = UIImage(named: pickerView == pickerViewHero ? "dice\(row+1)U" : "dice\(row+1)" )
            return image
        }()
        view.addSubview(imagen)
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 90
    }
    
    var monstruoView:VistaBatalla = VistaBatalla()
    
    var heroView:VistaBatalla  = VistaBatalla()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            sonido = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "empate", ofType: "mp3")!))
        }catch{
            print(error)
        }
        
        monstruoView = VistaBatalla(frame: CGRect(x: 50 , y: 50 , width: 300, height: 150), imagenPersonaje:Dao.getInstance().devolverMounstrupSelected().devolverImagen(), vidas:Dao.getInstance().devolverMounstrupSelected().devolverVida())
        
        heroView = VistaBatalla(frame: CGRect(x: 50 , y: 550, width: 300, height: 150), imagenPersonaje:Dao.getInstance().devolverHeroSelected().devolverImagen(), vidas:Dao.getInstance().devolverHeroSelected().devolverVida())
        
        button.addTarget(self, action: #selector(clic(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        self.view.addSubview(monstruoView)
        
        self.view.addSubview(heroView)
        
        pickerViewHero.delegate = self
        pickerViewHero.dataSource = self
        
        self.view.addSubview(pickerViewHero)
        
        pickerViewMonster.delegate = self
        pickerViewMonster.dataSource = self
        
        self.view.addSubview(pickerViewMonster)
        
        BattleView.fihgt = EstiloBoton(frame: CGRect(x: 170, y: 340, width: 80, height: 40), titulo: "Atacar")
        
        BattleView.fihgt.addTarget(self, action: #selector(atacar(_:)), for: .touchUpInside)
        
        self.view.addSubview(BattleView.fihgt)
    }
    
    private func devolverDados(ataque:Int) -> Int{
        if ataque < 20{
            return 1
        }else if ataque < 30{
            return 2
        }else{
            return 3
        }
    }
    
    @IBAction func clic(_:UIButton){
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "dungeon") as? DungeonView
        
        self.present(newViewController!, animated: true, completion: nil)
    }
    
    func menu(){
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "inicio") as? ViewController
        
        self.present(newViewController!, animated: true, completion: nil)
    }
    
    func darPremios(){
        Dao.getInstance().eliminarMounstruo(mons: Dao.getInstance().devolverMounstrupSelected())
        let newViewController = storyboard!.instantiateViewController(withIdentifier: "menu") as? ViewControllerMain
        
        self.present(newViewController!, animated: true, completion: nil)
    }
    
    @IBAction func atacar(_:UIButton){
        if(Dao.getInstance().devolverHeroSelected().devolverVida().isDie()){
            let alert = UIAlertController(title: "Info battle", message: "Has muerto", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Volver", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.menu()}))
            self.present(alert, animated: true, completion: nil)
        }else if(Dao.getInstance().devolverMounstrupSelected().devolverVida().isDie()){
            Dao.getInstance().devolverHeroSelected().sumarDinero(dinero: Dao.getInstance().devolverMounstrupSelected().devolverDinero())
            Dao.getInstance().devolverHeroSelected().sumarExp(exp: Dao.getInstance().devolverMounstrupSelected().devolverExp())
            Dao.getInstance().devolverHeroSelected().devolverVida().simarVidas(numVidas: 2)
            let alert = UIAlertController(title: "Info battle", message: "Has ganado, ahora tendrás \(Dao.getInstance().devolverMounstrupSelected().devolverDinero()) monedas más y \(Dao.getInstance().devolverMounstrupSelected().devolverExp()) más de experiencia", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Volver", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.darPremios()}))
            self.present(alert, animated: true, completion: nil)
        }else{
            UIView.animate(withDuration: 1, animations: {
                for i in 0..<(self.pickerViewMonster.numberOfComponents){
                    self.pickerViewMonster.selectRow(0, inComponent: i, animated: true)
                    self.pickerViewMonster.selectRow(Int.random(in: 0 ..< 12), inComponent: i, animated: true)
                }
                for i in 0..<(self.pickerViewHero.numberOfComponents){
                    self.pickerViewHero.selectRow(0, inComponent: i, animated: true)
                    self.pickerViewHero.selectRow(Int.random(in: 0 ..< 12), inComponent: i, animated: true)
                }
            }, completion: { finished in
                self.resolverBatalla()
            })
        }
    }
    
    func resolverBatalla(){
        var ataqueHero:Int = 0
        var ataqueMountruo:Int = 0
            
        for i in 0..<(self.pickerViewMonster.numberOfComponents){
            ataqueMountruo += pickerViewMonster.selectedRow(inComponent: i) + 1
        }
            
        for i in 0..<(self.pickerViewHero.numberOfComponents){
            ataqueHero += pickerViewHero.selectedRow(inComponent: i) + 1
        }
            
        monstruoView.setGolpe(golpe: ataqueMountruo)
        heroView.setGolpe(golpe: ataqueHero)
            
        if ataqueMountruo > ataqueHero {
            Dao.getInstance().devolverHeroSelected().devolverVida().restarVida()
            heroView.updateVidas()
            monstruoView.atacar(dirrecion: false)
        }else if ataqueHero > ataqueMountruo{
            Dao.getInstance().devolverMounstrupSelected().devolverVida().restarVida()
            monstruoView.updateVidas()
            heroView.atacar(dirrecion: true)
        }else{
            sonido.play()
        }
        Dao.getInstance().guardarDatos()
    }
}
