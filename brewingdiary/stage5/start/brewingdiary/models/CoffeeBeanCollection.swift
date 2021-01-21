//
//  CoffeeBeanCollection.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation

class CoffeeBeanCollection: ObservableObject {
    @Published var coffeeBeans = [CoffeeBean]() {
        didSet {
            saveCoffeeBeans()
        }
    }
    @Published var selectedBean: CoffeeBean = nullBean
    @Published var topBean: CoffeeBean? = nil 
    
    let collectionUrl = URL(fileURLWithPath: "coffeebeans", relativeTo: FileManager.documentsUrl).appendingPathExtension("json")
    
    func addBean(_ bean: CoffeeBean) -> Void {
        coffeeBeans.append(bean)
    }
    
    func deleteBean(at offsets: IndexSet) {
        offsets.forEach { idx in
            let bean = coffeeBeans.remove(at: idx)
            bean.deleteImage()
            
            // 1. if the topBean is the same as the removed bean, set it to nil!
        }
    }
    
    
    func saveCoffeeBeans() {
        let encoder = JSONEncoder()
        do {
            let beansData = try encoder.encode(coffeeBeans)
            try beansData.write(to: collectionUrl, options: .atomicWrite)
        } catch let error {
            print(error)
        }
    }
    
    func loadCoffeeBeans() {
        guard FileManager.default.fileExists(atPath: collectionUrl.path) else {
            return
        }
        let decoder = JSONDecoder()
        
        do {
            let beansData = try Data(contentsOf: collectionUrl)
            coffeeBeans = try decoder.decode([CoffeeBean].self, from: beansData)
        } catch let error {
            print(error)
        }
    }
    
    init() {
        loadCoffeeBeans()
        if coffeeBeans.count > 0 {
            return
        }
        selectedBean = muhondoBean
        addBean(muhondoBean)
        addBean(joseMayoBean)
        addBean(monCherryBean)

    }
    
    
}
