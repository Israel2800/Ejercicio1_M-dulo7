//
//  ViewController.swift
//  Ejercicio1
//
//  Created by Paola Delgadillo on 10/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Validar si ya tiene iniciada la sesión
        let ud = UserDefaults.standard
        if ud.string(forKey: "login") == "OK" {
            performSegue(withIdentifier: "loginOK", sender: self)
        }
    }

    @IBAction func btnEntrarTouch(_ sender: Any) {
        // Validar si los cuadros de texto no están vacíos
        var mensaje = ""
        
        /*
        if txtCorreo.text == "" {
            mensaje = "Por favor indique su correo"
        }
        else if txtContraseña.text == ""{
            mensaje = "Debe indicar su contraseña"
        }
        
        // Otras validaciones
        if mensaje == "" {
            // Todo OK, hacer el login
        }
        else {
            
        }
         */
        
        // Desempaquetamos los strings en los opcionales
        let correo = txtCorreo.text ?? ""
        let contraseña = txtContraseña.text ?? ""
        
        if correo.isEmpty {
            mensaje = "Por favor indique su correo"
        } 
        else if contraseña.isEmpty {
            mensaje = "Debe indicar su contraseña"
        }
        else{ // Validar que parezca un correo válido
            // Otras validaciones...
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let correoValido = NSPredicate(format: "SELF MATCHES %@", regex)
            if !correoValido.evaluate(with: correo) {
                mensaje = "No es un correo válido"
            }
        }
        if mensaje.isEmpty {
            // Todo ok hacer el login
            print("Todo ok, hacer el login")
            // TODO: buscar el correo, y comparar el password
            // Guardar la bandera de login Y navegar a HOME
            let ud = UserDefaults.standard
            ud.setValue("OK", forKey: "login")
            performSegue(withIdentifier: "loginOK", sender: self)
        }
        else {
            let ac = UIAlertController(title: "Hola", message: mensaje, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
        
    }
    
}

