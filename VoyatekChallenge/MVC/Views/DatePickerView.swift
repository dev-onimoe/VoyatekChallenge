//
//  DatePickerView.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 30/09/2025.
//

import SwiftUI

struct DatePickerView: View {
    
    var onDatesSelected: ((Date?, Date?) -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 65)
            HStack(spacing: 16) {
                Image(systemName: "xmark")
                    .tint(Color.black)
                    .onTapGesture {
                        onDatesSelected?(nil, nil)
                    }
                Text("Date")
                    .font(.custom("Satoshi-Medium", size: 16))
                    .foregroundColor(Color.black)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Spacer()
                .frame(height: 65)
            CalendarDatePicker(onDatesSelected: onDatesSelected)
            Spacer()
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DatePickerView()
}
