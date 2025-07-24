import SwiftUI

struct NutritionTrackingView: View {
    // Day selector data
    let days: [(day: String, date: String, month: String)] = [
        ("الجمعة", "8", "مايو"),
        ("السبت", "9", "مايو"),
        ("الأحد", "10", "مايو"),
        ("الاثنين", "11", "مايو"),
        ("الثلاثاء", "12", "مايو"),
        ("الأربعاء", "13", "مايو"),
        ("الخميس", "14", "مايو")
    ]
    
    // Selected day index (Monday)
    @State private var selectedDayIndex = 3
    
    // Nutrition data
    let targetCalories = 2150
    let consumedCalories = 1320
    
    // Macros data
    let macros: [(name: String, consumed: Int, target: Int, unit: String)] = [
        ("البروتين", 123, 150, "g"),
        ("الكربوهيدرات", 56, 100, "g"),
        ("الدهون", 23, 50, "g")
    ]
    
    // Meals data
    let meals: [(name: String, calories: Int, protein: Int, carbs: Int, fat: Int)] = [
        ("الإفطار", 0, 43, 21, 0),
        ("الغداء", 0, 43, 21, 0),
        ("العشاء", 0, 43, 21, 0),
        ("المقرمشات", 0, 43, 21, 0)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Day selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<days.count, id: \.self) { index in
                            DayItem(
                                day: days[index].day,
                                date: days[index].date,
                                month: days[index].month,
                                isSelected: index == selectedDayIndex
                            )
                            .onTapGesture {
                                selectedDayIndex = index
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.vertical, 15)
                .background(Color.white)
                
                // Calories summary
                VStack(spacing: 5) {
                    Text("\(targetCalories) kcal")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("سعرات اليوم")
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .padding(.top, 20)
                
                // Calories circle
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                        .frame(width: 180, height: 180)
                    
                    // Progress circle
                    Circle()
                        .trim(from: 0, to: CGFloat(consumedCalories) / CGFloat(targetCalories))
                        .stroke(Color.green, lineWidth: 15)
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(-90))
                    
                    // Center text
                    VStack {
                        Text("\(consumedCalories)")
                            .font(.system(size: 40, weight: .bold))
                        
                        Text("سعرات")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 20)
                
                // Macros
                VStack(spacing: 15) {
                    ForEach(0..<macros.count, id: \.self) { index in
                        MacroItem(
                            name: macros[index].name,
                            consumed: macros[index].consumed,
                            target: macros[index].target,
                            unit: macros[index].unit,
                            color: .green
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // Meals
                VStack(spacing: 15) {
                    ForEach(0..<meals.count, id: \.self) { index in
                        MealItem(
                            name: meals[index].name,
                            calories: meals[index].calories,
                            protein: meals[index].protein,
                            carbs: meals[index].carbs,
                            fat: meals[index].fat
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGray6))
    }
}

// Day item component
struct DayItem: View {
    let day: String
    let date: String
    let month: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(day)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(date)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(month)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(isSelected ? Color.white : Color.clear)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.black : Color.clear, lineWidth: 1)
        )
    }
}

// Macro item component
struct MacroItem: View {
    let name: String
    let consumed: Int
    let target: Int
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("\(consumed)\(unit)~")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text("\(name) \(consumed)\(unit)")
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                    
                    Rectangle()
                        .frame(width: min(CGFloat(consumed) / CGFloat(target) * geometry.size.width, geometry.size.width), height: 10)
                        .foregroundColor(color)
                        .cornerRadius(5)
                }
            }
            .frame(height: 10)
        }
    }
}

// Meal item component
struct MealItem: View {
    let name: String
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("\(calories) kcal")
                    .font(.subheadline)
                
                Spacer()
                
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            HStack {
                NutrientItem(value: fat, label: "بروتين")
                
                Spacer()
                
                NutrientItem(value: carbs, label: "بروتين")
                
                Spacer()
                
                NutrientItem(value: protein, label: "بروتين")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

// Nutrient item component
struct NutrientItem: View {
    let value: Int
    let label: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// Preview
struct NutritionTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionTrackingView()
            .environment(\.layoutDirection, .rightToLeft) // For Arabic layout
    }
}
