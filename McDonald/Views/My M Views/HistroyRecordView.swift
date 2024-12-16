//
//  HistroyRecordView.swift
//  McDonald
//
//  Created by Agata Przykaza on 16/12/2024.
//

import SwiftUI

struct HistoryRecordView: View {
    var record: HistoryRecord
    
    func formatDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter.string(from: date)
       }
    
    var body: some View {
        HStack{
            
            Image(systemName: "triangle.fill")
                .imageScale(.small)
                .rotationEffect(record.gained ? .degrees(0) : .degrees(180))
                .foregroundStyle(record.gained ? .black : .red)
            
            
            VStack(alignment: .leading){
                Text(record.gained ? "Zdobyte" : "Wykorzystane")
                Text(formatDate(record.date))
                
            }.font(.caption)
            
            Spacer()
            Text("\(record.gained ? "" : "-")\(record.points)")
            Image(systemName: "circle.fill")
                .foregroundStyle(.yellow)
                .padding(2)
                .background(Circle().fill(Color.orange))
            
            
        }
        .font(.subheadline)
        
    }
}

