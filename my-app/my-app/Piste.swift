//
//  Piste.swift
//  my-app
//
//  Created by LUCAS Arthur on 20/11/2023.
//

import Foundation

class PisteStructure: Identifiable, ObservableObject {
    
    let id: UUID = UUID()
    @Published var name: String
    @Published var dateCreation: Date
    @Published var url: URL
    @Published var state: Int
    
    init(name: String, dateCreation: Date, url: URL, state: Int) {
        self.name = name
        self.dateCreation = dateCreation
        self.url = url
        self.state = state
    }
}

class PisteCollection: ObservableObject {
    
    
//    @Published
    @Published var pistes: [PisteStructure]
    
    init(pistes: [PisteStructure]) {
        self.pistes = pistes
    }
    
     func add(name: String, imageString: String, date: Date, state: Int){
        
        let url: URL = URL(string: imageString)!
        
        let newPiste = PisteStructure(name: name, dateCreation: date, url: url, state: state)
        
        pistes.append(newPiste)
        
        print(pistes)
    }
    
     func remove(id: UUID){
        
        pistes.removeAll { PisteStructure in
            PisteStructure.id == id
        }
    }
}
