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
    //1.  add state property that triggers the adding of a new bag of beans
    
    
    var body: some View {
        ZStack {
            VStack {
                VStack (spacing: 0) {
                    
                        // 2. Add CameraView
                        Text("change things here")
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2, alignment: .top)
                        .edgesIgnoringSafeArea(.all)
                        .clipped()
                        .onTapGesture {
                            // 3. set addNewBagOfBeans to true
                            
                    }
                    
                    Button(action: {
                        print("add new bag of beans")
                        
                        // 3. use addNewBagOfBeans to tell CameraView to add a new bag of beans
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
    }
}
