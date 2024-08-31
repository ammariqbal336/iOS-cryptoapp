//
//  StatisticsView.swift
//  CryptoApp
//
//  Created by mac on 31/08/2024.
//

import SwiftUI

struct StatisticsView: View {
    let stats : StatisticsModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stats.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stats.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stats.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                Text(stats.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stats.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red )
            .opacity((stats.percentageChange ==  nil) ? 0.0 : 1.0)
        }
    }
}

#Preview {
    StatisticsView(stats: DeveloperPreview.instance.stat2)
}
