//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Sathurshan Ramachandran on 2022-05-27.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
                   .progressViewStyle(CircularProgressViewStyle(tint: .white))
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
