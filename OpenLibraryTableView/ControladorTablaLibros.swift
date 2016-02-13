//
//  ControladorTabla.swift
//  OpenLibraryTableView
//
//  Created by Aaron Marquez on 28/01/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit
import CoreData

var libro:Libro!
var libros:[Libro]!
var contexto = NSManagedObjectContext?()

class ControladorTablaLibros: UITableViewController {

    var datoslibro = NSEntityDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
    }
    
    override func viewDidAppear(animated: Bool) {
         self.tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if libros == nil{
            return 0
        }
        else{
            return libros.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celdaNombreLibro", forIndexPath: indexPath)
        cell.textLabel?.text = libros[indexPath.row].titulo
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            eliminarDatos(indexPath.row)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detalleLibro = segue.destinationViewController as? ControladorDetalleLibro {
            detalleLibro.libroDetalle = libros[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
    

    func cargarDatos(){
        contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        datoslibro = NSEntityDescription.entityForName("Libro", inManagedObjectContext: contexto!)!
        let peticion = datoslibro.managedObjectModel.fetchRequestTemplateForName("obtenerListaLibros")
        
        do{
            let datos = try contexto?.executeFetchRequest(peticion!)
            for dato in datos!{
                libro = Libro()
                libro.titulo = dato.valueForKey("titulo") as! String
                libro.isbn  = dato.valueForKey("isbn") as! String
                libro.autores = dato.valueForKey("autores") as! String
                libro.portada = UIImage(data: dato.valueForKey("portada") as! NSData)
                if libros == nil{
                     libros = [libro];
                }else{
                    libros.append(libro)
                }
               
            }
        }catch{
            
        }
    }
    
    func eliminarDatos(index: Int){
        let peticion = datoslibro.managedObjectModel.fetchRequestTemplateForName("obtenerListaLibros")
         do{
            let datos = try contexto?.executeFetchRequest(peticion!)
            contexto?.deleteObject(datos![index] as! NSManagedObject)
            do{
                try contexto?.save()
                libros.removeAtIndex(index)
                self.tableView.reloadData()
            }catch{
                
            }
         }catch{
            
        }
    }
    
    
}
