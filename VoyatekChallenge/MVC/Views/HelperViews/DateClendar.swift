import SwiftUI

struct CalendarDatePicker: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    var onDatesSelected: ((Date?, Date?) -> Void)?
    
    private let calendar = Calendar.current
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
                    ForEach(0..<24, id: \.self) { offset in
                        let monthDate = calendar.date(byAdding: .month, value: offset, to: Date())!
                        Section(header: monthHeader(for: monthDate)) {
                            monthGrid(for: monthDate)
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    VStack {
                        Text("Start Date")
                        Text(startDate.map { formatDate($0) } ?? "--")
                            .bold()
                    }
                    Spacer()
                    VStack {
                        Text("End Date")
                        Text(endDate.map { formatDate($0) } ?? "--")
                            .bold()
                    }
                }
                .padding()
                
                Button("Choose Date") {
                    onDatesSelected?(startDate, endDate)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
    
    private func monthHeader(for date: Date) -> some View {
        Text(formatMonth(date))
            .font(.custom("Satoshi-Medium", size: 16))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .background(Color.white)
    }
    
    private func monthGrid(for date: Date) -> some View {
        let range = calendar.range(of: .day, in: .month, for: date)!
        let days = range.compactMap { calendar.date(bySetting: .day, value: $0, of: date) }
        
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(days, id: \.self) { day in
                Button(action: { selectDate(day) }) {
                    Text("\(calendar.component(.day, from: day))")
                        .frame(width: 40, height: 40)
                        .font(.custom("Satoshi-Regular", size: 14))
                        .background(isSelected(day) ? Color.blue : Color.blue.opacity(0.02))
                        .foregroundColor(isSelected(day) ? .white : .primary)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 2, height: 2)))
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func selectDate(_ date: Date) {
        if startDate == nil {
            startDate = date
        } else if endDate == nil {
            if date < startDate! {
                endDate = startDate
                startDate = date
            } else {
                endDate = date
            }
        } else {
            startDate = date
            endDate = nil
        }
    }
    
    private func isSelected(_ date: Date) -> Bool {
        if let start = startDate, let end = endDate {
            return date >= start && date <= end
        } else {
            return date == startDate
        }
    }
    
    private func formatMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
    }
}

