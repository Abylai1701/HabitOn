import Foundation

protocol HabbitsViewModelLogic: AnyObject {
    func fetchHabbits()

    var habbits: Observable<[HabbitModel]> {get}
}

final class HabbitsViewModel: HabbitsViewModelLogic {

    //MARK: - Binding Values
    var habbits: Observable<[HabbitModel]>  = Observable([])

    //MARK: - Functions
    internal func fetchHabbits() {
        Router.shared.showLoader()
        ParseManager.shared.getRequest(
            url: API.habits,
            parameters: [:]) {
            (result: [HabbitModel]?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.habbits.value = result
                }
        }
    }
}
