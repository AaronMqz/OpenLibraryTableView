//
//  Logica.swift
//  OpenLibraryTableView
//
//  Created by Aaron Marquez on 29/01/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit


class Datos {
    
    var libro:Libro!
    var request:Request!
    var isbn:String!
    
    init(isbn:String, callback:(Libro) ->()){
        self.request = Request()
        self.libro = Libro()
        self.isbn = isbn
        request.getOpenLibrary(isbn){
            (response) in
            self.datosLibro(response)
            callback(self.libro)
        }

    }
    
    
    func getOpenLibrary(isbn:String){
        request.getOpenLibrary(isbn){
            (response) in
            self.datosLibro(response)
        }
    }
    
    
    func datosLibro(jsonDatos:NSDictionary){
        let keyJsonData : String = "ISBN:" + self.isbn
        
        if let datos = jsonDatos[keyJsonData] as? NSDictionary{
            
            self.libro.isbn = self.isbn
            
            if let nombreTitulo = datos["title"] as? String{
                self.libro.titulo  = nombreTitulo
            }else{
                self.libro.titulo = "Sin Título"
            }
            
            if let nombreAutores = datos["authors"] as? NSArray{
                var index: Int = 0
                self.libro.autores = ""
                for nombreAutor in nombreAutores {
                    if index == nombreAutores.count - 1 {
                        self.libro.autores = self.libro.autores + (nombreAutor["name"] as! String)
                    }else{
                        self.libro.autores = self.libro.autores + (nombreAutor["name"] as! String) + ", "
                    }
                    ++index
                }
            }else{
                self.libro.autores = "Sin Autores"
            }
            
            if let imagen = datos["cover"] as? NSDictionary{
                    let url = NSURL(string: imagen["large"] as! String)
                    let data = NSData(contentsOfURL: url!)
                    self.libro.portada = UIImage(data: data!)!
            }else{
                 self.libro.portada = UIImage(named: "sin imagen")
            }
            
        }
    }

    
}