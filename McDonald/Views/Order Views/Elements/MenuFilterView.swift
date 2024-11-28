//
//  MenuFilterView.swift
//  McDonald
//
//  Created by Agata Przykaza on 19/11/2024.
//

import SwiftUI





struct MenuFilterView: View {
    
    let sections = [
        ("A", ["Apple", "Avocado", "Apricot"]),
        ("B", ["Banana", "Blueberry", "Blackberry"]),
        ("C", ["Cherry", "Cranberry", "Clementine"]),
        ("D", ["Cherry", "Cranberry", "Clementine"]),
        ("e", ["Cherry", "Cranberry", "Clementine"]),
        ("f", ["Cherry", "Cranberry", "Clementine"])
    ]
    
    @State var selectedSection: String?
    @State var loadCategories: Bool = false
    @State private var isVertical = false // Przełącznik między układami
    
    let letters = ["A", "B", "C", "D"]
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) { // Kontener na litery
                    ForEach(0..<letters.count, id: \.self) { index in
                        Text(letters[index])
                            .font(.largeTitle)
                            .fontWeight(selectedSection == letters[index] ? .bold : .regular)
                            .underline(selectedSection == letters[index] ? true : false)
                            .offset(x: isVertical ? 0 : CGFloat(index) * 40, // Poziome przesunięcie
                                    y: isVertical ? CGFloat(index) * 40 : 0) // Pionowe przesunięcie
                            .animation(.easeInOut.delay( 0.2), value: isVertical) // Animacja z opóźnieniem
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    selectedSection = letters[index]
                                }
                            }
                    }
                }
                
            }
            .frame(
                               width: isVertical ? 70 : CGFloat(letters.count) * 40, // Szerokość ramki w zależności od układu
                               height: isVertical ? CGFloat(letters.count) * 40 : 30, // Wysokość ramki w zależności od układu
                               alignment: .topLeading
                           )
            .animation(.easeInOut.delay(1), value: isVertical)
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Button("Transform") {
            withAnimation {
                isVertical.toggle() // Przełącz animację
            }
        }
        
        
        
        VStack {
            
            
            
            // Lista z sekcjami
            ScrollViewReader { proxy in
                List {
                    ForEach(sections, id: \.0) { section in
                        Section(header: Text(section.0).font(.headline)) {
                            ForEach(section.1, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .id(section.0) // Ustawiamy identyfikator dla każdej sekcji
                    }
                    
                }
                .onAppear {
                    self.scrollToSection = { id in
                        proxy.scrollTo(id, anchor: .top) // Skrolowanie do sekcji
                    }
                }
                
                
                
                
            }
        }
    }
    
    // Closure do przewijania do sekcji
    @State private var scrollToSection: (String) -> Void = { _ in }
    
}

#Preview {
    MenuFilterView()
}
