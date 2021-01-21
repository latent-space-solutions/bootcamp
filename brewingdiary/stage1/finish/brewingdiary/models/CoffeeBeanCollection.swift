//
//  CoffeeBeanCollection.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import Foundation

class CoffeeBeanCollection: ObservableObject {
    // 1. Conform to Observable Protocol to update dependent views
    // 1. Add a coffeeBeans attribute of type [CoffeeBeans], make sure it communicates any updates to dependent Views
    // 2. add a function to add a CoffeeBean to the collection
    // 3. add a function to add remove CoffeeBean 
    //    find a way to conform to the list remove function
    //    remove(at offsets: IndexSet)
    @Published var coffeeBeans = [CoffeeBean]()

    func addBean(_ bean: CoffeeBean) -> Void {
        coffeeBeans.append(bean)
    }
    
    func deleteBean(at offsets: IndexSet) {
        coffeeBeans.remove(atOffsets: offsets)
    }
    
    init() {
        addBean(muhondoBean)
        addBean(joseMayoBean)
        addBean(monCherryBean)
    }
}
