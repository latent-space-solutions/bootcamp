//
//  CoffeeBeanCollection.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation

class CoffeeBeanCollection: ObservableObject {
    // 1. Make this conform to Codable protocol
    
    // 2. Add saveCoffeeBeans function to save this class as JSON
    // 3. Add loadCoffeeBeans function to load this class from JSON
    // 4. Trigger saveCoffeeBeans function if coffeeBeans array changes
    @Published var coffeeBeans = [CoffeeBean]()
    @Published var selectedBean: CoffeeBean

    func addBean(_ bean: CoffeeBean) -> Void {
        coffeeBeans.append(bean)
    }
    
    func deleteBean(at offsets: IndexSet) {
        coffeeBeans.remove(atOffsets: offsets)
    }
    
    // 5. if there's no JSON yet or there are no coffee beans, let's populate the coffeeBeanCollection with our current samples
    init() {
        selectedBean = muhondoBean
        addBean(muhondoBean)
        addBean(joseMayoBean)
        addBean(monCherryBean)
    }
}
