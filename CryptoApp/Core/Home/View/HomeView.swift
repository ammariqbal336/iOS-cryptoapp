//
//  HomeView.swift
//  CryptoApp
//
//  Created by mac on 26/08/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioView : Bool = false
    
    @State private var selectedCoin : CoinModel? = nil
    @State private var showDetailView : Bool = false
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                columnTitle
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                if !showPortfolio {
                    allCoinList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
            }
            
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin ),
                isActive: $showDetailView,
                label: {
                    EmptyView()
                })
        )
    }
    
    
    
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
        
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
    
}

 

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none,value: 0)
                .onTapGesture {
                    if(showPortfolio) {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            
            Spacer()
            Text(showPortfolio ? "Portfolie" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .animation(.none, value: 0)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                    
                }
        }
        .padding()
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        sogue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        sogue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitle: some View {
        HStack {
            
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption =   vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsreversed) ? 1.0: 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOption =   vm.sortOption == .holdings ? .holdingsreversed : .holdings
                    }
                }
                
            }
            
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption =   vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
                .frame(width: UIScreen.main.bounds.width / 3.5 ,alignment: .trailing)
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
                
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360: 0), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
        
    }
    
    private func sogue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
}

