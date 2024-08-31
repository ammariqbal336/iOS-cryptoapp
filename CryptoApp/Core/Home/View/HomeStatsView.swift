//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by mac on 31/08/2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.stats) { stat in
                StatisticsView(stats: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
        
        
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
}
