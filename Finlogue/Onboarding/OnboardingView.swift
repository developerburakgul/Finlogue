//
//  OnboardingView.swift
//  Finlogue
//
//  Created by Burak Gül on 12.01.2025.
//

import SwiftUI

enum OnboardingSection: Int, CaseIterable, Hashable {
    case welcome = 0, dollarSign, wallet
    
    /// not circle, if you are an last state this func doesnt return other OnboardingSection
    func next() -> OnboardingSection{
        let allSections = OnboardingSection.allCases
        guard let currentIndex = allSections.firstIndex(of: self),
              currentIndex < allSections.count - 1 else {
            return self // Son bölümdeysek, kendisini döndür.
        }
        return allSections[currentIndex + 1] // Bir sonraki bölümü döndür.
    }
}


struct OnboardingView: View {
    
    @State var currentOnboardingSection: OnboardingSection = .welcome
    
    
    var body: some View {
        TabView(selection: $currentOnboardingSection) {
            firstBoard
                .tag(OnboardingSection.welcome)
            
            secondBoard
                .tag(OnboardingSection.dollarSign)
            
            thirdBoard
                .tag(OnboardingSection.wallet)
        }
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
    
    //MARK: - ONBOARDİNG SECTİONS
    
    private var firstBoard: some View {
        OnboardingPageView(
            imageName: "figure",
            title: "Welcome to Finlogue",
            description: "Give me a huge",
            buttonTitle: "Start") {
                nextOnboardingSection()
            }
        
    }
    
    private var secondBoard: some View {
        OnboardingPageView(
            imageName: "dollarsign",
            title: "Manage Your Income",
            description: "Every one needs a finance app",
            buttonTitle: "Next") {
                nextOnboardingSection()
            }
    }
    
    private var thirdBoard: some View {
        OnboardingPageView(
            imageName: "chart.line.uptrend.xyaxis.circle",
            title: "Show your income",
            description: "Every one needs a finance app",
            buttonTitle: "Next") {
                nextOnboardingSection()
            }
    }
    
    private func nextOnboardingSection()  {
        withAnimation(.spring) {
            currentOnboardingSection = currentOnboardingSection.next()
        }
    }
}

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let description: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center,spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
                .foregroundColor(.green)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(description)
                .font(.title3)
                .fontWeight(.light)
                .padding(.vertical)
            
            if let buttonTitle = buttonTitle, let buttonAction = buttonAction {
                
                Button {
                    buttonAction()
                } label: {
                    Text(buttonTitle)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.vertical, 32)
                }
                
            }
            
        }
        .padding()
    }
}

#Preview {
    //    OnboardingPageView(imageName: "figure", title: "Welcome", description: "Welcome to your personal Finlogue", buttonTitle: nil, buttonAction: nil)
    OnboardingView()
}
