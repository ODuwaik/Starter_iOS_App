import SwiftUI

struct CalorieTrackerView: View {
    // Day selector data
    let days: [(day: String, date: String)] = [
        ("الأحد", "5"),
        ("الاثنين", "6"),
        ("الثلاثاء", "7"),
        ("الأربعاء", "8"),
        ("الخميس", "9"),
        ("الجمعة", "10"),
        ("السبت", "11")
    ]
    
    // Selected day index (Wednesday - 8)
    @State private var selectedDayIndex = 3
    
    // Nutrition data
    let remainingCalories = 2002
    
    // Macros data
    let macros: [(value: String, name: String, icon: String, color: Color)] = [
        ("66g", "البروتين المتبقي", "circle.fill", .pink),
        ("25g", "الكارب المتبقي", "leaf.fill", .orange),
        ("182g", "الدهون المتبقية", "capsule.fill", .blue)
    ]
    
    // Meals data
    let meals: [(name: String, calories: Int, protein: Int, carbs: Int, fat: Int, icon: String)] = [
        ("الفطور", 0, 0, 0, 0, "sun.max.fill"),
        ("الغداء", 0, 0, 0, 0, "")
    ]
    
    // Tab items
    let tabItems = ["الرئيسية", "لحظاتي", "التحليلات", "الإعدادات"]
    let tabIcons = ["house.fill", "sun.max.fill", "chart.bar.fill", "gearshape.fill"]
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("ميزان")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Streak counter
                ZStack {
                    Circle()
                        .fill(Color(.systemGray6))
                        .frame(width: 60, height: 60)
                    
                    VStack(spacing: 0) {
                        Text("0")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Day selector
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<days.count, id: \.self) { index in
                        VStack(spacing: 5) {
                            Text(days[index].day)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            ZStack {
                                Circle()
                                    .fill(index == selectedDayIndex ? Color(.systemBlue).opacity(0.2) : Color.clear)
                                    .frame(width: 40, height: 40)
                                
                                Text(days[index].date)
                                    .font(.headline)
                                    .fontWeight(index == selectedDayIndex ? .bold : .regular)
                            }
                        }
                        .onTapGesture {
                            selectedDayIndex = index
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            
            // Main content
            ScrollView {
                VStack(spacing: 20) {
                    // Calories remaining card
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                        
                        HStack {
                            // Calories circle
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                                    .frame(width: 80, height: 80)
                                
                                VStack(spacing: 0) {
                                    Text("0")
                                        .font(.headline)
                                    
                                    Image(systemName: "flame.fill")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            // Calories text
                            VStack(alignment: .trailing, spacing: 5) {
                                Text("\(remainingCalories)")
                                    .font(.system(size: 42, weight: .bold))
                                
                                Text("السعرات المتبقية")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing)
                        }
                        .padding(.vertical)
                    }
                    .frame(height: 120)
                    .padding(.horizontal)
                    
                    // Macros cards
                    HStack(spacing: 10) {
                        ForEach(0..<macros.count, id: \.self) { index in
                            MacroCard(
                                value: macros[index].value,
                                name: macros[index].name,
                                icon: macros[index].icon,
                                color: macros[index].color
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Page indicator
                    HStack(spacing: 5) {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color.black)
                            .frame(width: 8, height: 8)
                    }
                    .padding(.vertical, 5)
                    
                    // Meals section
                    VStack(alignment: .trailing, spacing: 15) {
                        Text("الوجبات المسجلة")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        // Meals list
                        VStack(spacing: 15) {
                            ForEach(0..<meals.count, id: \.self) { index in
                                MealCard(
                                    name: meals[index].name,
                                    calories: meals[index].calories,
                                    protein: meals[index].protein,
                                    carbs: meals[index].carbs,
                                    fat: meals[index].fat,
                                    icon: meals[index].icon
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            
            // Tab bar
            HStack {
                ForEach(0..<tabItems.count, id: \.self) { index in
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Image(systemName: tabIcons[index])
                            .font(.system(size: 22))
                            .foregroundColor(selectedTab == index ? .black : .gray)
                        
                        Text(tabItems[index])
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? .black : .gray)
                    }
                    .onTapGesture {
                        selectedTab = index
                    }
                    
                    Spacer()
                }
            }
            .padding(.vertical, 10)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(width: 60, height: 5)
                    .cornerRadius(2.5)
                    .foregroundColor(.black)
                    .padding(.bottom, 5),
                alignment: .bottom
            )
            
            // Add meal button
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 60, height: 60)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .offset(y: -30)
            .overlay(
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 30),
                alignment: .bottom
            )
        }
        .background(Color(.systemGray6))
    }
}

// Macro card component
struct MacroCard: View {
    let value: String
    let name: String
    let icon: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            VStack(spacing: 10) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(color)
                }
                
                Text(name)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
        }
        .frame(height: 170)
    }
}

// Meal card component
struct MealCard: View {
    let name: String
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    let icon: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            HStack {
                // Add button
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Meal details
                VStack(alignment: .trailing, spacing: 5) {
                    HStack {
                        if !icon.isEmpty {
                            Image(systemName: icon)
                                .foregroundColor(.yellow)
                        }
                        
                        Text(name)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    HStack(spacing: 15) {
                        Text("\(calories) سعرة")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 5) {
                            Text("\(protein) بروتين")
                            Text("|\(carbs) كارب")
                            Text("|\(fat) دهون")
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .frame(height: 80)
    }
}

// Preview
struct CalorieTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieTrackerView()
    }
}
