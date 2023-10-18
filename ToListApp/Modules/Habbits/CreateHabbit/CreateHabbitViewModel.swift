import Foundation

protocol CreateHabbitViewModelLogic: AnyObject {
    func createHabbit(name: String, color: String)
    var habbit: Observable<CreateHabbitModel?> {get}

}

final class CreateHabbitViewModel: CreateHabbitViewModelLogic {
    
    //MARK: - Functions
    var habbit: Observable<CreateHabbitModel?> = Observable(nil)

    internal func createHabbit(name: String, color: String) {
        
        let parameters: Parameters = ["name": name,
                                      "color": color]
        
        Router.shared.showLoader()
        ParseManager.shared.postRequest(
            url: API.habits,
            parameters: parameters) {
                (result: CreateHabbitModel?, error) in
                Router.shared.hideLoader()
                if let result = result {
                    self.habbit.value = result
                }
            }
    }
}
