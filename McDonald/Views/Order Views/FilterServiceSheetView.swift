//
//  FilterServiceSheetView.swift
//  McDonald
//
//  Created by Agata Przykaza on 10/11/2024.
//

import SwiftUI

struct FilterServiceSheetView: View{
    
    @Binding var showFilterServiceSheet: Bool
    @Binding var selectedFilters: [String]
    var filters: [String]
    
    
    func clearFilters() {
        selectedFilters.removeAll()
    }
    
    
    
    
    var body: some View{
        VStack{
            
            HStack{
                Button {
                    showFilterServiceSheet.toggle()
                } label: {
                    Image(systemName: "arrow.left")
                        .tint(.black)
                }
                
                
                
                
                Spacer()
                
                Text("Filtr")
                    .fontWeight(.heavy)
                Spacer()
                
            }
            .padding(.horizontal)
            
            
            List{
                ForEach(filters, id: \.self) { filter in
                    
                    Toggle(isOn:Binding(
                        get: {
                            selectedFilters.contains(filter)
                        },
                        set: { isSelected in
                            if isSelected {
                                selectedFilters.append(filter) // Dodaj filtr do tablicy
                            } else {
                                selectedFilters.removeAll { $0 == filter } // Usuń filtr z tablicy
                            }
                        }
                    ) ){
                        Text(filter)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding()
                    
                    
                    
                }
                
            }
            .listStyle(.plain)
            
            HStack{
                
                Button {
                    clearFilters()
                    showFilterServiceSheet = false
                } label: {
                    ButtonView(title: "Wyczyść", color: .white)
                        .padding()
                        .opacity(selectedFilters.isEmpty ? 0.5 : 1)
                }
                .disabled(selectedFilters.isEmpty)
                
                
                
                
                
                Button {
                    showFilterServiceSheet = false
                } label: {
                    ButtonView(title: "Nałóż filtr", color: .accent)
                        .padding()
                        .opacity(selectedFilters.isEmpty ? 0.5 : 1)
                }
                .disabled(selectedFilters.isEmpty)
                
                
            }
            
            
        }
        
        
    }
}



struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(configuration.isOn ? .accent : .gray)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        configuration.isOn.toggle()
                    }
                    
                }
                .padding(.trailing)
            
            configuration.label
            
            Spacer()
        }
    }
}
