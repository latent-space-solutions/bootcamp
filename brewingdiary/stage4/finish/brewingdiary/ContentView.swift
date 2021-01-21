//
//  ContentView.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import SwiftUI
// Add Camera Access right to app


struct ContentView: View {
    @State var cameraImages = CameraImages()
    @StateObject var coffeeBeanCollection = CoffeeBeanCollection()
    @State var showSelectedBean = false
    // add state property that triggers the adding of a new bag of beans
    @State var addNewBagOfBeans = false

    
    var body: some View {
        ZStack {
            VStack {
                VStack (spacing: 0) {
                    CameraView(coffeeBeans: coffeeBeanCollection, showSelectedBean: $showSelectedBean, addNewBagOfBeans: $addNewBagOfBeans)
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2, alignment: .top)
                        .edgesIgnoringSafeArea(.all)
                        .clipped()
                        .onTapGesture {
                            // use add new bag of beans for capture
                            addNewBagOfBeans = true
                    }
                    
                    Button(action: {
                        print("add new bag of beans")
                        
                        // use addNewBagOfBeans
                        
                        addNewBagOfBeans = true
                    }, label: {
                        //1. Add a new bean to the coffeeBeans 
                        Text("Add New Bag of Beans")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                      
                    })
                    .background(Color.yellow)
                    .cornerRadius(42, corners: [.bottomLeft, .bottomRight])
                    
                    .foregroundColor(.white)
                }
                
                
                List {
                    Section(header: Text("Top Bean")) {
                        CoffeeBeanEntry(bean: coffeeBeanCollection.coffeeBeans[0]).onTapGesture {
                                print("Tapped Top Bean")
                                coffeeBeanCollection.selectedBean = muhondoBean
                                showSelectedBean = true
                        }
                        
                    }
                    
                    Section(header: Text("All Beans")) {
                        ForEach(coffeeBeanCollection.coffeeBeans) { bean in
                            
                            CoffeeBeanEntry(bean: bean).onTapGesture {
                                print("Tapped Coffe Bean")
                                coffeeBeanCollection.selectedBean = bean
                                showSelectedBean = true
                            }
                            
                        }.onDelete(perform: coffeeBeanCollection.deleteBean)
                    }
                    
                }
            }.sheet(isPresented: $showSelectedBean, onDismiss: {
                coffeeBeanCollection.saveCoffeeBeans()
            }){
                    CoffeeBeanDetailsView(bean: coffeeBeanCollection.selectedBean, showDetails: $showSelectedBean)
                    
            }.colorScheme(.dark)
            
            
        }.ignoresSafeArea(.all)
        .background(Color.black)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        // set up a coffee bean collection with test data from samples
    }
}
