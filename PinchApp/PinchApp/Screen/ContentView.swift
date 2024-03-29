//
//  ContentView.swift
//  PinchApp
//
//  Created by Rushikesh Suradkar on 29/03/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: PROPERTY
    
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    
    var body: some View {
        NavigationView{
            ZStack {
                // MARK: Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale, anchor: .center)
                    //MARK: Tap Gesture to scale image
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }
                        else {
                            withAnimation(.spring()){
                                imageScale = 1
                            }
                        }
                    })
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear( perform: {
                withAnimation(.linear(duration: 3)) {
                    isAnimating = true
                    
                }
             }
            )
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
