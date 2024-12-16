//
//  PointsHistoryView.swift
//  McDonald
//
//  Created by Agata Przykaza on 12/12/2024.
//

import SwiftUI




struct PointsHistoryView: View {
    @Binding var points: Points?
    var body: some View {
        
        ScrollView{
            if let points{
                VStack(alignment: .leading){
                    
                    Text("\(points.currentPoints) punktów")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                    Group{
                        Text("- Każda wydana złotówka to 10 punktów dla Ciebie")
                        Text("- Obieraj nagrody - aktualną listę znajdziesz w sekcji MojeM")
                        Text("- Zebrane punkty są ważne 365 dni")
                    }
                    .font(.subheadline)
                    
                    
                    VStack(alignment: .leading){
                        
                        
                        Text("Historia punktów")
                            .font(.title2)
                            .bold()
                        
                        
                        ForEach(points.history, id: \.self){ record in
                            HistoryRecordView(record: record)
                            
                        }
                        
                        
                    }
                    .padding(.top)
                }
                .padding()
                .frame(maxWidth: .infinity,alignment: .leading)
                .navigationTitle("Na Twoim koncie w MojeM już: \(points.currentPoints) pkt")
                .navigationBarTitleDisplayMode(.inline)
            }
            else{
                Text("Brak Danych, przepraszamy")
                    .font(.title)
                    .bold()
            }
            
        }
       
    }
}




#Preview {
    NavigationStack {
        PointsHistoryView(points: .constant(Points(currentPoints: 231,   history: [
            HistoryRecord(gained: true, date: Date(), points: 100),
            HistoryRecord(gained: false, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, points: 50),
            HistoryRecord(gained: false, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, points: 200),
            HistoryRecord(gained: false, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, points: 50),
            HistoryRecord(gained: true, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, points: 200),
            HistoryRecord(gained: false, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, points: 50),
            HistoryRecord(gained: true, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, points: 200),
            HistoryRecord(gained: false, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, points: 50),
            HistoryRecord(gained: false, date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, points: 200)
        ])))
    }
  
}

