//
//  ViewController.swift
//  ServiciosApp
//
//  Created by TEO on 15/11/22.
//

import UIKit

    // MARK: - UserModel
 



class ViewController: UIViewController {
    
    struct Model: Codable {
       let user: String
       let age: Int
       let isHappy: Bool
   }
    
    struct Const {
        static let webSite = "https://www.mocky.io/v2/5e2674472f00002800a4f417"
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchService()
        
    }

    private func fetchService(){
        guard let endPoint = URL(string: Const.webSite) else { return }
        
        let urlSession = URLSession.shared
        
        activityIndicator.startAnimating() // Esto es andes de iniciar el consumo de la api
        
        // A partir de este punto ocurre en un segundo hilo a menos que le especifique que estoy en el hilo principal
        urlSession.dataTask(with: endPoint) {data, response, error in
            
                        
            
            if error != nil {
                print("Error de conexion")
            }
            
            guard let data = data else{ return }
            guard let user = try? JSONDecoder().decode(Model.self, from: data) else { return }
            
            // Los cambios deben ocurrir dentro de este método que es el Hilo principal
            DispatchQueue.main.async {
                self.nameLabel.text = user.user
                self.ageLabel.text = "\(user.age)"
                self.activityIndicator.stopAnimating() // Cuando el servicio se complete detenemos el activityIndicator

            }
            
            
            
        }.resume()
        
    }

}

