//
//  CoffeeBeanDetailsView.swift
//  brewingdiary
//
//  Created by Stefan Zapf on 19.01.21.
//

import SwiftUI

struct CoffeeBeanDetailsView: View {
    @ObservedObject var bean: CoffeeBean
    @State private var editTitle = false
    @Binding var showDetails: Bool
    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showDetails = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                    })
                }
                .padding(.horizontal, 22)
                
                HStack(spacing: 22) {
                    bean.displayImage.resizable().frame(width: 60, height: 80).padding(.top, 0)
                    
                    TextField("Name", text: $bean.name).font(.title).frame(alignment: .bottom)
                    Spacer()
                    
                }.padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    
                    
                    Button(action: {
                        let newDiaryEntry =
                            DiaryEntry(date: Date(), grindSize: 15, temperature: 93, quality: 1)
                        let topEntry = bean.diaryEntries.topEntry
                        
                        newDiaryEntry.grindSize = topEntry.grindSize
                        newDiaryEntry.temperature = topEntry.temperature
                    
                        
                        bean.diaryEntries.append(newDiaryEntry)
                        bean.selectedEntry = newDiaryEntry
                    }, label: {
                        HStack{
                            Image(systemName: "plus.square").font(.title)
                            Text("new entry")
                        }
                        
                    })
                    
                    
                    ForEach(bean.diaryEntries.sortedByQuality) { entry in
                        let selected = bean.selectedEntry == entry
                        EntryView(entry: entry, selected: selected).onTapGesture {
                            bean.selectedEntry = entry
                        }
                    }
                }.frame(height: 200).padding(.trailing, 20)
                
                
                SelectedEntryView(selectedEntry: bean.selectedEntry)
                Spacer()
            }
            .padding(.leading, 25)
            .padding(.top, 20)
            
        }.foregroundColor(.white)
    }
    
}

struct CoffeeBeanDetailsView_Previews: PreviewProvider {
    static var previews: some View {
    
        CoffeeBeanDetailsView(bean: muhondoBean, showDetails: Binding.constant(true))
    }
}

struct EntryView: View {
    @ObservedObject var entry: DiaryEntry
    var selected: Bool
    
    var body: some View {
        HStack {
            Rectangle().frame(width: 7).foregroundColor(selected ? .yellow : .gray)
            VStack(alignment: .leading) {
                Text("Grind size \(Int(entry.grindSize))").bold()
                Text("Temperature \(entry.temperatureString)")
            }
            Spacer()
            QualityView(quality: $entry.quality).padding(.trailing, 20)
        }.frame(height: 35)
    }
}


struct SelectedEntryView: View {
    @ObservedObject var selectedEntry: DiaryEntry
    
    var body: some View {
        Group {
            
            HStack {
                Text("Entry from \(selectedEntry.date.short())").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
            }.padding(.bottom, 20)
            
            Group {
                HStack {
                    Text("Grind Settings")
                    Spacer()
                }
                HStack {
                    Text("\(Int(selectedEntry.grindSize))")
                    Slider(value: $selectedEntry.grindSize, in: 10...25, step: 1)
                        .accentColor(.yellow).padding(.trailing, 30)
                        .padding(.leading, 10)
                    
                }
            }
            Group {
                HStack {
                    Text("Temperature")
                    Spacer()
                }
                HStack {
                    Text("\(selectedEntry.temperatureString)")
                    Slider(value: $selectedEntry.temperature, in: 90...100, step: 0.5)
                        .accentColor(.yellow).padding(.trailing, 30)
                        .padding(.leading, 10)
                    
                }
            }
            
            
        }
    }
}
