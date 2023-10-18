import Foundation

protocol HabbitsViewModelLogic: AnyObject {
    func fetchHabbits()
    func rebootHabbit(id: Int)
    
    var habbits: Observable<[HabbitModel]> {get}
    var habbit: Observable<HabbitModel?> {get}

}

final class HabbitsViewModel: HabbitsViewModelLogic {

    //MARK: - Binding Values
    var habbits: Observable<[HabbitModel]>  = Observable([])
    var habbit: Observable<HabbitModel?> = Observable(nil)

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
    internal func rebootHabbit(id: Int) {
        Router.shared.showLoader()
        ParseManager.shared.postRequest(
            url: API.rebootHabbit(id: id),
            parameters: [:]) {
                (result: HabbitModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.habbit.value = result
                }
            }
    }
}
