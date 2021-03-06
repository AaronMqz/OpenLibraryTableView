//
//  ControladorBuscarLibro.swift
//  OpenLibraryTableView
//
//  Created by Aaron Marquez on 28/01/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit
import CoreData

class ControladorBuscarLibro: UIViewController {

    @IBOutlet var isbn: UITextField!
    @IBOutlet var titulo: UILabel!
    @IBOutlet var autor: UILabel!
    @IBOutlet var portada: UIImageView!
    
    var proxy:Datos!
    var isbnGlobal:String = ""
    var libro:Libro!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func isbnBuscar(sender: UITextField) {
        isbnGlobal = sender.text!
       
        sender.resignFirstResponder()
        
            self.proxy = Datos(isbn: self.isbn.text!){
                (callback) in
                    dispatch_async(dispatch_get_main_queue()){
                        
                        if callback.isbn == nil{
                             self.alert("No se econtraron resultados del ISBN introducido")
                        }else{
                            self.titulo.text = callback.titulo
                            self.autor.text = callback.autores
                            self.portada.image = callback.portada
                            self.libro = Libro()
                            self.libro.titulo = self.titulo.text!
                            self.libro.isbn = self.isbn.text!
                            self.libro.autores = self.autor.text!
                            self.libro.portada = self.portada.image
                        }
                }
            }
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
    
        if parent == nil{
            if libros == nil{
                if libro != nil{
                    libros = [libro];
                }
            }else{
                libros.append(self.libro)

            }
            insertarDatos()
        }
    }
    
    
    func insertarDatos(){
        let nuevoLibro = NSEntityDescription.insertNewObjectForEntityForName("Libro", inManagedObjectContext: contexto!)
        nuevoLibro.setValue(self.libro.isbn, forKey: "isbn")
        nuevoLibro.setValue(self.libro.titulo, forKey: "titulo")
        nuevoLibro.setValue(self.libro.autores, forKey: "autores")
        nuevoLibro.setValue(UIImagePNGRepresentation(self.libro.portada), forKey: "portada")
        do{
            try contexto?.save()
        }catch{
            
        }
    }
    
    func alert(message : String){
        let alertController = UIAlertController(title: "Openlibrary Alert", message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(ok)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}
