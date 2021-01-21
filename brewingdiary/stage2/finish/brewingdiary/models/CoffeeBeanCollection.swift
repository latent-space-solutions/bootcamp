//
//  CoffeeBeanCollection.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation

class CoffeeBeanCollection: ObservableObject {
    @Published var coffeeBeans = [CoffeeBean]()
    @Published var selectedBean: CoffeeBean

    func addBean(_ bean: CoffeeBean) -> Void {
        coffeeBeans.append(bean)
    }
    
    func deleteBean(at offsets: IndexSet) {
        coffeeBeans.remove(atOffsets: offsets)
    }
    
    init() {
        selectedBean = muhondoBean
        addBean(muhondoBean)
        addBean(joseMayoBean)
        addBean(monCherryBean)
    }
}
