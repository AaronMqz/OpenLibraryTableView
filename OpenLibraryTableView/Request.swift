//
//  Request.swift
//  OpenLibraryTableView
//
//  Created by Aaron Marquez on 28/01/16.
//  Copyright © 2016 Aaron Marquez. All rights reserved.
//

import UIKit


class Request{
    
    var configuracion:Configuracion
    
    init(){
        self.configuracion = Configuracion()
    }
    
    func getOpenLibrary(isbnText: String,callback:(NSDictionary) -> ()){
        requestOpenlibrary(configuracion.url + isbnText, callback: callback)
    }
    
    
    func requestOpenlibrary(apiUrl:String, callback:(NSDictionary) -> ()){
        let url = NSURL(string: apiUrl)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) in
                if((response) != nil){
                        do{
                            let jsonDatos = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            callback(jsonDatos)
                        }catch _ {
                            
                        }
                    }else{
                    
                    }
            }
        
        task.resume()
    }
    
}
