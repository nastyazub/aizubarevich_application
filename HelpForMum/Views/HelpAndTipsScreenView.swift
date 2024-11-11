//
//  HelpAndTipsScreenView.swift
//  HelpForMum
//
//  Created by Настя on 10.11.2024.
//

import SwiftUI

struct HelpAndTipsScreenView: View {
    @State var selection: Int = 4
    var body: some View {
        ScrollView {
            Picker(
                selection: $selection,
                label: Text("Picker"),
                content: {
                    Text("Главное").tag(0)
                    Text("Продукты").tag(1)
                    Text("Реакции").tag(2)
                    Text("Аналитика").tag(3)
                    Text("Блюда").tag(4)
                    Text("Связь").tag(5)
                    Text("Советы").tag(6)
                    })
            .pickerStyle(.menu)
            
            switch selection {
            case 0:
                MainView()
            case 1:
                ProductsView()
            case 2:
                ReactionsView()
            case 4:
                MealView()
            default:
                MainView()
            }
        }
    }
    
    // MARK: ГЛАВНОЕ
    
    struct MainView: View {
        var body: some View {
            VStack {
                Text("Здравствуй, уважаемый пользователь!")
                Text("")
                Text("Моё приложение на первый взгляд может показаться сложным, но, уверяю Вас, после этого туториала Вы со всем познакомитесь и разберётесь с приложением, если ещё не до конца разобрались.")
                Text("")
                Text("Сверху вы можете выбрать, про какой из разделов приложения прочесть поподробнее, а здесь расположена информация о самом главном, о том, без чего Вам может быть немного трудно работать с приложением.")
                Text("")
                Text("Чтобы создать приём пищи, нужно нажать на большой сини плюс на начальном экране:")
                
                Text("+")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(20)
                    .frame(width: 80)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
                Text("Потом нужно выбрать тип приёма пищи: 'Завтрак, Обед, Перекус, Ужин'")
                Text("")
                Text("Чтобы удалить приём пищи, нужно нажать на значок мусорки рядом с ним.")
                Text("")
                Text("Чтобы посмотреть продукты и реакции определённого приёма пищи, нужно просто кликнуть на него.")
                Text("")
                Text("")
                Text("Чтобы поменять дату календаря, нужно нажать на значок календаря и выбрать нужную дату.")
                Text("")
                Image(systemName: "calendar")
                    .font(.title)
                    .foregroundStyle(.blue)
                Text("")
                Text("!Внимание")
                    .bold()
                Text("Можно выбрать только этот день или предыдущие, следующий день выбрать нельзя!")
                Text("")
                Text("")
                Text("Чтобы добавить рост ребёнка, Вам нужно нажать на значок с ребёнком:")
                Text("")
                Image(systemName: "figure.arms.open")
                    .font(.title)
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("")
                Text("Также сюда нужно нажать, если Вам нужно изменить рост ребёка или удалить (просто оставьте поле ввода пустым и нажмите 'Готово' для удаления).")
                Text("")
                Text("!Внимание")
                    .bold()
                Text("В значение роста можно добавить только целое число!")
                Text("")
                Text("")
                Text("Чтобы добавить вес ребёнка, нужно нажать на значок гири:")
                Text("")
                Image(systemName: "scalemass.fill")
                    .font(.title2)
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(Circle())
                Text("")
                Text("Также сюда нужно нажать, если Вы хотите изменить вес ребёнка или удалить (просто оставьте поле ввода пустым и нажмите 'Готово' для удаления).")
                Text("")
                Text("!Внимание")
                    .bold()
                Text("В значение веса можно добавить только число. Число будет отображаться только до трёх цифр поле запятой.")
                
            }
            .multilineTextAlignment(.center)
            .padding(8)
        }
    }
    
    // MARK: ПРОДУКТЫ

    struct ProductsView: View {
        var body: some View {
            VStack {
                Text("Чтобы добавить продукт в приём пищи, нужно нажать на кнопку с плюсом:")
                Text("")
                Image(systemName: "plus.app")
                    .foregroundStyle(Color.blue)
                    .font(.title)
                Text("")
                Text("Далее нужно нажать на 'Продукт +'. Откроется список всех продуктов. Можно найти какой-то конкретный продукт и добавить в приём пищи, нажав на него.")
                Text("")
                Text("Если Вы ещё не добавляли продуктов ранее, то нажмите на кнопку 'Добавить' и в появившемся окне напишите название продукта и нажмите 'Готово'. Далее нажмите на него в списке продуктов.")
                Text("")
                Text("Можно изменять продукты и удалять их, для этого, свайпните влево.")
                Text("")
                Text("!Внимание")
                    .bold()
                Text("Можно удалять продукты из списка всех продуктов, но будьте аккуратны, продукт насовсем удалится из приложения, потом его можно будет добавить ещё раз, но в приёмах пищи этого продукта уже не будет.")
                Text("")
                Text("Чтобы посмотреть, какие продукты добавлены в приём пищи, нужно нажать на приём пищи, продукты которого Вы хотите посмотреть.")
                Text("")
                Text("Если хотите удалить продукт из приёма пищи, то откройте этот приём пищи и свайпните влево тот продукт, который хотите удалить.")
            }
            .multilineTextAlignment(.center)
            .padding(8)
        }
    }
    
    // MARK: РЕАКЦИИ
    
    struct ReactionsView: View {
        var body: some View {
            VStack {
                Text("Чтобы добавить реакцию в приём пищи, нужно нажать на кнопку с плюсом:")
                Text("")
                Image(systemName: "plus.app")
                    .foregroundStyle(Color.blue)
                    .font(.title)
                Text("")
                Text("Далее нужно нажать на 'Реакция +'. Откроется список всех реакций. Можно найти какую-то конкретную реакцию и добавить в приём пищи, нажав на неё.")
                Text("")
                Text("Если Вы ещё не добавляли реакций ранее, то нажмите на кнопку 'Добавить' и в появившемся окне напишите название реакции и нажмите 'Готово'. Далее нажмите на него в списке реакций.")
                Text("")
                Text("Можно изменять реакции и удалять их, для этого, свайпните влево.")
                Text("")
                Text("!Внимание")
                    .bold()
                Text("Можно удалять реакции из списка всех реакций, но будьте аккуратны, реакция насовсем удалится из приложения, потом её можно будет добавить ещё раз, но в приёмах пищи этой реакции уже не будет.")
                Text("")
                Text("Чтобы посмотреть, какие реакции добавлены в приём пищи, нужно нажать на приём пищи, реакции которого Вы хотите посмотреть.")
                Text("")
                Text("Если хотите удалить реакцию из приёма пищи, то откройте этот приём пищи и свайпните влево ту реакцию, которую хотите удалить.")
                Text("")
                Text("Важно!")
                    .bold()
                    .font(.headline)
                Text("У реакций есть аналитика. Подробнее - выберете 'Аналитика'.")
            }
            .multilineTextAlignment(.center)
            .padding(8)
        }
    }
    
    // MARK: БЛЮДА
    
    struct MealView: View {
        var body: some View {
            VStack {
                Text("Блюдо - это список некоторых продуктов. Если вы добавите блюдо в приём пищи, то туда добавятся продукты из этого блюда.")
                Text("")
                Text("Все Ваши блюда находятся во вкладке:")
                Text("")
                Image(systemName: "fork.knife")
                    .font(.title2)
                    .foregroundStyle(.blue)
                Text("")
                Text("Если хотите добавить новое блюдо, то нажмите на кнопку 'Добавить' на этой вкладке. Далее напишите название блюда и нажмите кнопку 'Готово'.")
                Text("")
                Text("!Внимание")
                    .bold()
                Text("Изменить название блюда нельзя! Возможно, в будущем такая возможность будет, но не сейчас. Если вы опечатались в названии блюда и уже нажали на кнопку 'Готово', то удалите его из списка блюд (нажать на мусорку) и добавьте блюдо заново.")
                Text("")
                Text("После добавления названия блюда нажмите 'Далее'. Откроется страница, где можно изменить состав блюда. Та же самая страница откроется, если вы нажмёте на блюдо в списке блюд.")
                Text("")
                Text("Если Вы хотите посмотреть состав блюда, то нажмите 'Добавленные продукты'. Продукты из открывшегося списка можно удалять.")
                Text("")
                Text("Если вы хотите добавить продукт в блюдо, то нажмите 'Добавить продукты'. Выберите продукты из списка, нажав на них. Если продукта, которого вы хотите добавить, нет, то напишите его название в поле поиска и нажмите '+'.")
                Text("Чтобы добавить блюдо в приём пищи, нужно нажать на кнопку с плюсом:")
                Text("")
                Image(systemName: "plus.app")
                    .foregroundStyle(Color.blue)
                    .font(.title)
                Text("")
                Text("Далее нужно нажать на 'Блюдо +'. Откроется список всех блюд. Можно найти какое-то конкретное блюдо и добавить в приём пищи, нажав на него.")
                Text("")
                Text("!Внимание")
                    .font(.headline)
                    .bold()
                Text("В приём пищи добавляются продукты из блюда, а не само блюдо.")
            }
            .multilineTextAlignment(.center)
            .padding(8)
        }
    }
}

#Preview {
    HelpAndTipsScreenView()
}
