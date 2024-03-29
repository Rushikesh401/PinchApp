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
    @State private var imageOffset : CGSize = .zero
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.clear
                // MARK: Page Image
                Image("enhanced-image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale, anchor: .center)
                //MARK: Tap Gesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }
                        else {
                            resetImageState()
                        }
                    })
                //MARK: Drag Gesture
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation
                                }
                                
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        )
                //MARK: Magnification
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)){
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            .onEnded {_ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear( perform: {
                withAnimation(.linear(duration: 3)) {
                    isAnimating = true
                    
                }
            }
            )
            //MARK: Info Panel
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.bottom, 30),
                alignment: .top
            )
            .overlay(
                Group {
                    HStack {
                        // Scale Down
                        Button {
                            withAnimation(.spring){
                                if imageScale > 1 {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                      
                        //Reset
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                            
                        }
                    
                        //Scale Up
                        Button {
                            withAnimation(.spring){
                                if imageScale <= 5 {
                                    imageScale += 1
                                    
                                    if imageScale >= 5 {
                                        resetImageState()
                                    }
                                }
                            }
                
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                                         }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, -15)
                ,alignment: .bottom
            )
            
        }
        .navigationViewStyle(.stack)
    }
    
    //MARK: Function
    func resetImageState() {
       return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
}

#Preview {
    ContentView()
}
