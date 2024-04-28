//
//  ContentView.swift
//  Kaspi
//
//  Created by Chingiz on 28.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var startDate = Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 9))!
    @State private var endDate = Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 16))!
    @State private var transferInfo = ""
    @State private var selection = 0
    
    let transfers: [Transfer] = [
        Transfer(bank: "Kaspi Gold", name: "Батыр Ш.", amount: "1 234,00", date: "15 декабря"),
        Transfer(bank: "Kaspi Gold", name: "Жанар М.", amount: "123 456,0", date: "13 декабря"),
        Transfer(bank: "Kaspi Gold", name: "Даниил Л.", amount: "456,00", date: "12 декабря"),
        Transfer(bank: "Kaspi Gold", name: "Маргарита Ш.", amount: "23 456,00", date: "12 декабря")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("menu1")
                    .padding(.leading, -120)
                Text("Переводы")
            }
            
            Picker(selection: $selection, label: Text("")) {
                Text("Мои переводы").tag(0)
                Text("История").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            TextField("Имя, сумма, сообщение", text: $transferInfo)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
            
            DateRangePicker(startDate: $startDate, endDate: $endDate)
            
            Spacer()
            
            ForEach(transfers) { transfer in
                VStack(alignment: .leading) {
                    TransferRowView(transfer: transfer)
                    HStack {
                        Spacer()
                        Text("Клиенту Kaspi")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding()
    }
}

struct Transfer: Identifiable {
    let id = UUID()
    var bank: String
    var name: String
    var amount: String
    var date: String
}

struct TransferRowView: View {
    var transfer: Transfer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(transfer.date)
                
                Spacer()
            }
            HStack {
                Text(transfer.bank)
                Spacer()
                Text(transfer.amount + " тг.")
            }
            Text(transfer.name)
        }
    }
}

struct DateRangePicker: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        return formatter
    }
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .onTapGesture {
                    
                }
            Spacer()
            Text(dateFormatter.string(from: startDate))
            Text(" - ")
            Text(dateFormatter.string(from: endDate))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
