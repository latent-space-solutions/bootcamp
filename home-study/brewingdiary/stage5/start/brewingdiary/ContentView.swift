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
                            addNewBagOfBeans = true
                    }
                    
                    Button(action: {
                        addNewBagOfBeans = true
                    }, label: {
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
                        
                        // 1. add here an if to show top bean if it is defined
                        
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
    }
}
