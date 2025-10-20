//
//  HomeScreen.swift
//  AmazonUIClone
//
//  Created by Onur Zaim on 12.09.2025.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - CategoryItem
    struct Category {
        let image: String
        let title: String
    }
    
    // MARK: - Variables
    @State private var searchText: String = ""
    @FocusState private var isFocused: Bool
    private let images = ["AmazonSlider1", "AmazonSlider2", "AmazonSlider3", "AmazonSlider4", "AmazonSlider5", "AmazonSlider6"]
    private let cardImages = ["card1", "card2", "card3", "card4", "card5", "card6"]
    let categories: [Category] = [
        .init(image: "CategoriaSlider1", title: "Fırsat"),
        .init(image: "CategoriaSlider2", title: "Çok Satan"),
        .init(image: "CategoriaSlider3", title: "Outlet"),
        .init(image: "CategoriaSlider4", title: "Kitap"),
        .init(image: "CategoriaSlider5", title: "Cihaz Sat"),
        .init(image: "CategoriaSlider6", title: "Prime"),
        .init(image: "CategoriaSlider7", title: "Taksit"),
        .init(image: "CategoriaSlider8", title: "Güzel Evim"),
        .init(image: "CategoriaSlider9", title: "ÇokAlAzÖde"),
        .init(image: "CategoriaSlider10", title: "Bebek"),
        .init(image: "CategoriaSlider11", title: "Pazar Yeri"),
        .init(image: "CategoriaSlider12", title: "Favoriler"),
        .init(image: "CategoriaSlider13", title: "İyi Fiyat"),
        .init(image: "CategoriaSlider14", title: "Ofis"),
        .init(image: "CategoriaSlider15", title: "Çoklu al")
    ]

    // MARK: - Computed Views
    private var adressBar: some View {
        HStack {
            Image("mappinicon")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.horizontal, 20)
            Text(Constant.adress)
                .font(.subheadline)
                .padding(.horizontal, -20)
            Spacer()
            Image(systemName: "chevron.down")
                .font(.caption)
                .padding(.horizontal, -180)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(Constant.adressColor))
        .foregroundStyle(.white)
    }
    private var pagedTabView: some View {
        TabView {
            ForEach(images, id:\.self) { name in
                Image(name)
                    .resizable()
                    .frame(width: 800, height: 400)
                    .cornerRadius(12)
            }
        }
        .frame(height: 400)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    private var cardCarousel: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal, showsIndicators : false) {
                HStack(spacing: 8) {
                    ForEach(cardImages, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 165, height: 235)
                            .clipped()
                            .cornerRadius(4)
                    }
                }
                .padding(.horizontal, 30)
                .frame(height: 210)
            }
            .contentMargins(.horizontal, 0)
            .scrollClipDisabled(true)
        }
        .padding(.bottom, 15)
    }
    private var categoriaSlider: some View {
        VStack{
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(categories, id: \.image) { c in
                        VStack(spacing: 6) {
                            Image(c.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                            Text(c.title)
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(width: 70)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .frame(height: 90)
            }
            .contentMargins(.horizontal, 0)
            .scrollClipDisabled(true)
        }
        .padding(.bottom, 0)
        .background(Color.white)
    }
    private var searchBarStyle: some View {
        HStack (spacing : 16) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.black)
            TextField("", text: $searchText)
                .foregroundColor(.black)
                .tint(.blue)
                .textFieldStyle(.plain)
                .submitLabel(.search)
                .focused($isFocused)
            Button { print("camera") } label: { Image(systemName: "camera") .accentColor(.black)
            }
        }
        .padding(5)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
        .overlay(alignment: .leading){
            if searchText.isEmpty {
                Text(Constant.searchBarPlaceholder)
                    .foregroundColor(Color(Constant.searchBarTextColor))
                    .padding(.leading, 46)
                    .allowsHitTesting(false)
            }
        }
    }
    private var navigationBarStyle: some View {
        VStack(spacing: 0) {
            Color(Constant.navigationBarTitleColor)
                .frame(height: 116)
            Divider()
                .background(Color(Constant.dividerColor))
        }
        .ignoresSafeArea(edges: .top)
    }
    
    // MARK: - Function View
    private func dividerView(height: CGFloat = 4) -> some View {
        Divider()
            .frame(height: height)
            .background(Color(Constant.dividerColor))
    }
    private func bannerView(name: String) -> some View {
        Image(name)
            .resizable()
            .frame(width: 450, height: 80)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing : 0){
                    dividerView(height: 16)
                    adressBar
                    dividerView()
                    bannerView(name: "Banner1")
                    dividerView()
                    ZStack{
                        pagedTabView
                        cardCarousel
                    }
                    dividerView()
                    categoriaSlider
                    dividerView()
                    bannerView(name: "Banner2")
                    dividerView()
                }
            }
            //Start Searchbar
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    searchBarStyle
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(Constant.navigationBarTitleColor), for: .navigationBar)
            .overlay(alignment: .top) {
                navigationBarStyle
            }
            //End Searchbar
        }
    }
}

extension HomeScreen{
    enum Constant {
        static let dividerColor = "DividerColor"
        static let navigationBarTitleColor = "Color1"
        static let adressColor = "Color2"
        static let searchBarTextColor = "SearchTextColor"
        static let adress = "Alıcı: Onur – Efeler 09100"
        static let searchBarPlaceholder = "Amazon.com.tr'de ara"
    }
}

// MARK: - Preview
#Preview {
    HomeScreen()
}
