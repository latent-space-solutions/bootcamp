//
//  ContentView.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 18.01.21.
//

import SwiftUI

struct ContentView: View {
    @State var cameraImages = CameraImages()
    @StateObject var coffeeBeanCollection = CoffeeBeanCollection()
    @State var showSelectedBean = false

    
    var body: some View {
        ZStack {
            VStack {
                VStack (spacing: 0) {
                    Image(cameraImages.current())
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2, alignment: .top)
                        .edgesIgnoringSafeArea(.all)
                        .clipped()
                        .onTapGesture {
                            cameraImages.next()
                    }
                    
                    Button(action: {
                        print("add new bag of beans")
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
                // 1. Save on Dismiss
                }.sheet(isPresented: $showSelectedBean) {
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
