//
//  SplashView.swift
//  StocksMoneybase
//
//  Created by Muhammed Musthafa on 27/03/2026.
//


import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    
    var body: some View {
        if isActive {
            MarketSummaryDIContainer.makeMarketSummaryListView()
        } else {
            VStack {
                Image("images")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .scaleEffect(scale)
                
                Text("Stocks Moneybase")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                withAnimation(.easeIn(duration: 0.8)) {
                    scale = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
