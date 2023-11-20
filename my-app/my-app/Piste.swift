//
//  Piste.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import Foundation

struct PisteStructure: Identifiable{
    
    let id: UUID
    var name: String
    var dateCreation: Date
    var url: URL
    var state: Int
}

struct PisteCollection {
    var pistes: [PisteStructure]
    
    mutating func add(name: String, imageString: String, date: Date, state: Int){
        
        let url = URL(fileURLWithPath: imageString)
        
        let newPiste = PisteStructure(id: UUID(), name: name, dateCreation: date, url: url, state: state)
        
        pistes.append(newPiste)
    }
}
