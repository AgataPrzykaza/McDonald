//
//  PrizeView.swift
//  McDonald
//
//  Created by Agata Przykaza on 28/11/2024.
//

import SwiftUI
import FirebaseFirestore



@MainActor
@Observable final class PrizeViewModel{
    
    var historyRecord: HistoryRecord?
    var showError: Bool = false
    var errorMessage: String?
    var prizeTakenToday: Bool = false
    
    func checkIfPrizeTakenToday(for userID: String, prize: MPrize) async {
        let rewards = await RewardManager.shared.getRewards(for: userID) ?? []
        
        let today = Date()
        let calendar = Calendar.current
        
        
        let alreadyTaken = rewards.contains { reward in
            guard reward.prizeId == prize.menuID else {
                return false
            }
            
            return calendar.isDate(reward.lastTaken!, inSameDayAs: today)
        }
        
        prizeTakenToday =  alreadyTaken
    }

    
    func updateRewards(for userID: String, prize: MPrize) async {
        await  RewardManager.shared.setRewardTaken(for: userID, prize: prize)
    }
    
    func updatePoints(for userID: String,prize points: Int) async {
        do {
            guard let historyRecord else { return }
            
            try await validateRules(for: userID, prize: points)
            
            try await PointsManager.shared.updatePoints(for: userID, points: points, historyRecord: historyRecord)
        } catch {
            
            errorMessage = error.localizedDescription
        }
    }
    
    func validateRules(for userID: String, prize: Int) async throws {
        do {
            let points = try await PointsManager.shared.getPoints(for: userID)
            
            if points.currentPoints < prize {
                throw PointsError.notEnoughPoints
            }
        }catch let error as PointsError {
           
            throw PointsError.notEnoughPoints
        }
        catch let error as NSError {
            switch error.code {
            case FirestoreErrorCode.unavailable.rawValue:
                throw PointsError.networkError
            default:
                throw PointsError.unknown
            }
            
            
        }
        
        
    }
}
    
    struct PrizeView: View {
        
        @Environment(MainViewModel.self) var mViewModel
        @State var vmodel: PrizeViewModel = PrizeViewModel()
        
        let prize: MPrize
        @State var imageURL: URL?
        
        @State var rules: [String] = ["Zaloguj się / Załóż konto"]
        
        var body: some View {
            
            VStack{
                ScrollView{
                    VStack(){
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .frame(width: 350, height: 250)
                                .scaledToFit()
                            
                        } placeholder: {
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame( height: 250)
                                .scaledToFit()
                                .overlay {
                                    ProgressView()
                                }
                        }
                        
                        VStack(alignment: .leading){
                            
                            
                            Text("Odbierz \(prize.title)")
                                .font(.title)
                                .bold()
                            
                            
                            Text("\(prize.points) pkt")
                                .bold()
                                .foregroundStyle(.black)
                                .font(.headline)
                                .bold()
                                .padding(5)
                                .padding(.horizontal,5)
                                .background(.white, in: .capsule)
                                .padding(1)
                                .background(LinearGradient(gradient: Gradient(colors: [.red.mix(with: .black, by: 0.4), .yellow.mix(with: .red, by: 0.2)]), startPoint: .leading, endPoint: .trailing), in: .capsule)
                            
                            Text("Zasady")
                                .bold()
                                .font(.headline)
                                .padding(.top)
                            
                            ForEach(rules,id: \.self){ rule in
                                Text(rule)
                                    .font(.subheadline)
                                Divider()
                                    .padding(.horizontal)
                                
                            }
                            .padding(.top,5)
                            
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                        
                    }
                    .padding(5)
                    .overlay(alignment: .topTrailing) {
                        if mViewModel.user == nil {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.gray)
                                .padding()
                        }
                    }
                }
               
                Text("Odbierz")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(mViewModel.user != nil && !vmodel.prizeTakenToday  ? .yellow : .gray, in: .rect)
                    .disabled(mViewModel.user == nil || !vmodel.prizeTakenToday )
                    .alert("Błąd", isPresented: $vmodel.showError, presenting: vmodel.errorMessage) { errorMessage in
                        Button("OK", role: .cancel) {
                            vmodel.showError = false
                        }
                    } message: { errorMessage in
                        Text(errorMessage)
                    }
                    .onTapGesture {
                        if let userId = mViewModel.user?.userId {
                            vmodel.historyRecord = HistoryRecord(gained: false, date: Date(), points: prize.points)
                            Task {
                                await vmodel.updatePoints(for: userId, prize: prize.points)
                                await vmodel.updateRewards(for: userId, prize: prize)
                                if let errorMessage = vmodel.errorMessage {
                                    vmodel.showError = true
                                }
                            }
                        }
                        
                        
                        
                    }
                
            }
            .overlay {
                Color.gray.opacity(vmodel.prizeTakenToday ? 0.3 : 0)
            }
            .task {
                await loadImage()
                
                if let user = mViewModel.user {
                    await vmodel.checkIfPrizeTakenToday(for: user.userId, prize: prize)
                }
              
            }
        }
        
        func loadImage() async {
            do {
                imageURL = try await FirestoreService().fetchImageURL(for: prize.imagePath)
            } catch {
                print("Error fetching image URL: \(error)")
            }
        }
    }
    
    
