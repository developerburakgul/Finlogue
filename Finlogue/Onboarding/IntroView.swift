//
//  IntroView.swift
//  Finlogue
//
//  Created by Burak Gül on 12.01.2025.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isShownOnBoarding") private var isShownOnboarding: Bool?
    var body: some View {
        if !(isShownOnboarding ?? false) {
            OnboardingView()
        } else {
            Color.brown
        }
    }
}

#Preview {
    IntroView()
}
