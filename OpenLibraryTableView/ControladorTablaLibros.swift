//
//  ControladorTabla.swift
//  OpenLibraryTableView
//
//  Created by Aaron Marquez on 28/01/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit

var libros:[Libro]!


class ControladorTablaLibros: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
         self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if libros == nil{
            return 0
        }
        else{
            return libros.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celdaNombreLibro", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = libros[indexPath.row].titulo
        return cell
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let detalleLibro = segue.destinationViewController as? ControladorDetalleLibro {
            detalleLibro.libroDetalle = libros[(self.tableView.indexPathForSelectedRow?.row)!]
        }

    }
    
}
