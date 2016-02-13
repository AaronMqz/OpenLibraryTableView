//
//  ControladorDetalleLibroViewController.swift
//  OpenLibraryTableView
//
//  Created by Aaron Marquez on 28/01/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit

class ControladorDetalleLibro: UIViewController {

    var libroDetalle:Libro = Libro()
    
    @IBOutlet var isbn: UILabel!
    @IBOutlet var titulo: UILabel!
    @IBOutlet var autores: UILabel!
    @IBOutlet var portada: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbn.text = libroDetalle.isbn
        titulo.text = libroDetalle.titulo
        autores.text = libroDetalle.autores
        portada.image = libroDetalle.portada
    }
    
}
