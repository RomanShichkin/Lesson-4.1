
//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.
import Foundation

enum Action {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case putInTheTrunk(volume: Decimal)
    case unloadFromTheTrunk(volume: Decimal)
    case roof
    case somethingForTrunk
}

class Car {
    let brandCar: String
    let yearOfIssue: Int
    let trunkVolume: Decimal
    var engineStarted: Bool
    var windowsAreOpen: Bool
    var filledTrunkVolume: Decimal
    
    init (brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal) {
        self.brandCar = brandCar
        self.yearOfIssue = yearOfIssue
        self.trunkVolume = trunkVolume
        self.engineStarted = engineStarted
        self.windowsAreOpen = windowsAreOpen
        if filledTrunkVolume >= self.trunkVolume {
            self.filledTrunkVolume = trunkVolume
        } else {
            self.filledTrunkVolume = filledTrunkVolume
        }
    }
    
    func doAction (action: Action) {
        print("Этот метод ещё ничего делать не умеет")
    }
    func printInfo(){
        print("Этот метод ещё ничего делать не умеет")
    }
}

//-----------------SportCar-----------------

class SportCar: Car {
    let isCabriolet: Bool
    var roofIsOpen: Bool
    let from0To100: Decimal

    //инициализатор для кабриолета
    init(brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal, roofIsOpen: Bool, from0To100: Decimal) {
        self.isCabriolet = true
        self.roofIsOpen = roofIsOpen
        self.from0To100 = from0To100
        super.init(brandCar: brandCar, yearOfIssue: yearOfIssue, trunkVolume: trunkVolume, engineStarted: engineStarted, windowsAreOpen: windowsAreOpen, filledTrunkVolume: filledTrunkVolume)
    }
    
    //инициализатр для некабриолета
    init(brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal, from0To100: Decimal) {
        self.isCabriolet = false
        self.roofIsOpen = false
        self.from0To100 = from0To100
        super.init(brandCar: brandCar, yearOfIssue: yearOfIssue, trunkVolume: trunkVolume, engineStarted: engineStarted, windowsAreOpen: windowsAreOpen, filledTrunkVolume: filledTrunkVolume)
    }
    
    override func doAction(action: Action) {
        switch action {
        case .startEngine:
            engineStarted = true
            print("Двигатель запущен")
        case .stopEngine:
            engineStarted = false
            print("Двигатель остановлен")
        case .openWindows:
            windowsAreOpen = true
            print("Окна открыты")
        case .closeWindows:
            windowsAreOpen = false
            print("Окна закрыты")
        case .putInTheTrunk(volume: let volume):
            if volume <= (trunkVolume - filledTrunkVolume) {
                filledTrunkVolume += volume
                print("В багажнк загружен объём \(volume). Общая загруженность: \(filledTrunkVolume) из \(trunkVolume)")
            } else {
                print("В багажник объём \(volume) не вместится. Доступный свободный объём: \(trunkVolume - filledTrunkVolume)")
            }
        case .unloadFromTheTrunk(volume: let volume):
            if volume > filledTrunkVolume {
                print("Из багажника нельзя выгрузить объём \(volume)! Доступно: \(filledTrunkVolume) из \(trunkVolume)")
            } else {
                filledTrunkVolume -= volume
                print("Объём \(volume) выгружен из багажника. Осталось: \(filledTrunkVolume) из \(trunkVolume)")
            }
        case .roof:
            if isCabriolet == true {
                if roofIsOpen == true {
                    roofIsOpen = false
                    print("Крыша закрывается")
                } else {
                    roofIsOpen = true
                    print("Крыша открывается")
                }
            } else {
                print("Автомобиль не кабриолет. Открыть/закрыть крышу нельзя.")
            }
        default:
            print("Действие для автомобиля невозможно")
        }
    }
    
    override func printInfo(){
        print("""
            =======================================
            Марка авто: \(self.brandCar)
            Год выпуска: \(self.yearOfIssue)
            Загрузка багажника: \(self.filledTrunkVolume) из \(self.trunkVolume)
            Каблиолет: \(self.isCabriolet ? ("Да\nПоложение крыши: \(self.roofIsOpen ? "Открыта" : "Закрыта")") : "Нет")
            Состояние двигателя: \(self.engineStarted ? "Запущен" : "Остановлен")
            Положение окон: \(self.windowsAreOpen ? "Открыты" : "Закрыты")
            Разгон от 0 до 100 км/ч (сек): \(self.from0To100)
            =======================================
            """)
    }
}

var ferrari = SportCar.init(
    brandCar: "Ferrari",
    yearOfIssue: 2018,
    trunkVolume: 50,
    engineStarted: true,
    windowsAreOpen: false,
    filledTrunkVolume: 10,
    roofIsOpen: true,
    from0To100: 4.5
)

ferrari.printInfo()
ferrari.doAction(action: .roof)
ferrari.doAction(action: .stopEngine)
ferrari.doAction(action: .unloadFromTheTrunk(volume: 15))
ferrari.doAction(action: .putInTheTrunk(volume: 40))
ferrari.doAction(action: .putInTheTrunk(volume: 10))
ferrari.doAction(action: .unloadFromTheTrunk(volume: 35.5))
ferrari.doAction(action: .openWindows)
ferrari.printInfo()

var nissan = SportCar.init(
    brandCar: "Nissan",
    yearOfIssue: 2000,
    trunkVolume: 150,
    engineStarted: false,
    windowsAreOpen: false,
    filledTrunkVolume: 170000,
    from0To100: 10
)

nissan.printInfo()
nissan.doAction(action: .roof)

//-----------------TrunkCar-----------------

class TrunkCar: Car {
    var someProperty: Bool

    //инициализатор для кабриолета
    init(brandCar: String, yearOfIssue: Int, trunkVolume: Decimal, engineStarted: Bool, windowsAreOpen: Bool, filledTrunkVolume: Decimal, someProperty: Bool) {
        self.someProperty = someProperty
        super.init(brandCar: brandCar, yearOfIssue: yearOfIssue, trunkVolume: trunkVolume, engineStarted: engineStarted, windowsAreOpen: windowsAreOpen, filledTrunkVolume: filledTrunkVolume)
    }
    
    override func doAction(action: Action) {
        switch action {
        case .startEngine:
            engineStarted = true
            print("Двигатель запущен")
        case .stopEngine:
            engineStarted = false
            print("Двигатель остановлен")
        case .openWindows:
            windowsAreOpen = true
            print("Окна открыты")
        case .closeWindows:
            windowsAreOpen = false
            print("Окна закрыты")
        case .putInTheTrunk(volume: let volume):
            if volume <= (trunkVolume - filledTrunkVolume) {
                filledTrunkVolume += volume
                print("В багажнк загружен объём \(volume). Общая загруженность: \(filledTrunkVolume) из \(trunkVolume)")
            } else {
                print("В багажник объём \(volume) не вместится. Доступный свободный объём: \(trunkVolume - filledTrunkVolume)")
            }
        case .unloadFromTheTrunk(volume: let volume):
            if volume > filledTrunkVolume {
                print("Из багажника нельзя выгрузить объём \(volume)! Доступно: \(filledTrunkVolume) из \(trunkVolume)")
            } else {
                filledTrunkVolume -= volume
                print("Объём \(volume) выгружен из багажника. Осталось: \(filledTrunkVolume) из \(trunkVolume)")
            }
        case .somethingForTrunk:
                if someProperty == true {
                    someProperty = false
                    print("Некоторое свойство выключается")
                } else {
                    someProperty = true
                    print("Некоторое свойство включается")
                }
        default:
            print("Действие для автомобиля невозможно")
        }
    }
    
    override func printInfo(){
        print("""
            =======================================
            Марка авто: \(self.brandCar)
            Год выпуска: \(self.yearOfIssue)
            Загрузка багажника: \(self.filledTrunkVolume) из \(self.trunkVolume)
            Некоторое уникальное свойство для грузовика: \(self.someProperty ? "Включено" : "Выключено")
            Состояние двигателя: \(self.engineStarted ? "Запущен" : "Остановлен")
            Положение окон: \(self.windowsAreOpen ? "Открыты" : "Закрыты")
            =======================================
            """)
    }
}

var truck = TrunkCar.init(
        brandCar: "Volvo",
        yearOfIssue: 2020,
        trunkVolume: 20000,
        engineStarted: false,
        windowsAreOpen: true,
        filledTrunkVolume: 1000,
        someProperty: true
)

truck.printInfo()
truck.doAction(action: .startEngine)
truck.doAction(action: .unloadFromTheTrunk(volume: 15000))
truck.doAction(action: .putInTheTrunk(volume: 17000))
truck.doAction(action: .putInTheTrunk(volume: 150000))
truck.doAction(action: .unloadFromTheTrunk(volume: 3500.5))
truck.doAction(action: .closeWindows)
truck.doAction(action: .somethingForTrunk)
truck.doAction(action: .roof)
truck.printInfo()
