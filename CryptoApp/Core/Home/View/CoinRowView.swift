//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by mac on 28/08/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingColumn: Bool
    var body: some View {
        HStack(spacing: 0) {
           
            leftColumn
            Spacer()
            if showHoldingColumn {
               centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview {

        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingColumn: true)
            .previewLayout(.sizeThatFits)
}


extension CoinRowView {
    
    private var leftColumn : some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View {
        
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimal())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.currentHoldings?.asNumberString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.green:
                        Color.theme.red
                )
        }
    }
    
    private var rightColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice?.asCurrencyWith2Decimal() ?? "")
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                        Color.theme.green:
                        Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5 ,alignment: .trailing)
    }
}
