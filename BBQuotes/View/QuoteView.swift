//
//  QuoteView.swift
//  BBQuotes
//
//  Created by Aman Giri on 2024-04-10.
//

import SwiftUI

struct QuoteView: View {
    
    @StateObject var viewModel = ViewModel(controller: FetchController())
    
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack{
                    VStack{
                        Spacer(minLength: 100)
                        
                        switch viewModel.status{
                        case .success(data: let data):
                            Text("\"\(data.quote.quote)\"")
                                .font(.title3)
                                .minimumScaleFactor(0.5)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: (geo.size.width / 1.4), height: 50)
                                .padding(20)
                                .clipShape(.rect(cornerRadius: 20))
                                .background(.black.opacity(0.7))
                            
                            ZStack(alignment: .bottom){
                                AsyncImage(url: data.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                
                                Text(data.character.name)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.black.opacity(0.5))
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 20))
                        case .fetching:
                            ProgressView()
                        default:
                            EmptyView()
                        }
                        
                        Spacer()
                    }
                    Button{
                        Task{
                            await viewModel.getData(for: show)
                        }
                    }label:{
                        Text("Get a Quote")
                            .minimumScaleFactor(0.5)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    Spacer(minLength:120)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear(){
            Task{
                await viewModel.getData(for: show)
            }
        }
    }
}

#Preview {
    QuoteView( show: "Breaking Bad")
}
