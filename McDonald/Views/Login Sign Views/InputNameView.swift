//
//  InputNameView.swift
//  McDonald
//
//  Created by Agata Przykaza on 11/12/2024.
//

import SwiftUI





@Observable final class InputNameViewModel {
    
    var name: String = ""
    var showAlert: Bool = false
    var continueButtonEnabled: Bool  = false
    
    func validate() -> Bool {
        name.count > 0
    }
    
}

struct InputNameView: View {
    
    @State var vmodel: InputNameViewModel = InputNameViewModel()
    @Binding var showSheet: Bool
    
    var body: some View {
      
        VStack{
            ScrollView{
                VStack(alignment: .leading){
                    
                    Image("myMLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                    
                    Group{
                        Text("Twoje dane")
                            .font(.title)
                            .fontWeight(.heavy)
                        
                        Text("Daj nam znać jak się do Ciebie zwracać :)")
                        
                        VStack(alignment: .leading){
                            
                            HStack(spacing: 5){
                              
                                Text("Imię")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .requiredField()
                            }
                          
                               
                            
                            TextField("Imię", text: $vmodel.name)
                                .padding()
                                .frame(height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                    
                                )
                               
                            HStack{
                                
                                Text("Te dane są niezbędne do założenia konta")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .requiredField()
                                
                              
                                
                            }.alert("Błąd", isPresented: $vmodel.showAlert) {
                                Button("Ok"){
                                    vmodel.showAlert = false
                                }
                            } message: {
                                Text("Nie poprawne imię.")
                            }

                            
                        }
                        
                           
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            }
            
           
                ButtonView(title: "Dalej", color: .yellow)
                    .onTapGesture {
                        if vmodel.validate(){
                            vmodel.continueButtonEnabled = true
                        }
                        else{
                            vmodel.showAlert = true
                        }
                    }
                    .padding(.bottom,10)
                    .navigationDestination(isPresented: $vmodel.continueButtonEnabled) {
                        
                             RegisterView(showSheet: $showSheet,name: vmodel.name)
                        
                    }
            

         
            
        }
    }
}

#Preview {
    InputNameView(showSheet: .constant(true))
}
