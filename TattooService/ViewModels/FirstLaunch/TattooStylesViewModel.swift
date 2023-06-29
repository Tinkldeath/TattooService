import Foundation
import RxSwift


protocol TattooStylesViewModelProtocol {
    
    typealias TattooStyleViewModel = (title: String, imageName: String, selected: Bool)
    
    var tattooStyles: BehaviorSubject<[TattooStyleViewModel]> { get }
    
    func didSelectTattooStyle(_ index: Int)
    
}

class TattooStylesViewModel: TattooStylesViewModelProtocol {
    
    private(set) var tattooStyles: BehaviorSubject<[TattooStyleViewModel]> = BehaviorSubject(value: [])
    
    private var data: [TattooStyleViewModel] = [
        ("Traditional/Old School", "Traditional", false),
        ("New School", "NewSchool", false),
        ("Neo Traditional", "NeoTraditional", false),
        ("Realism", "Realism", false),
        ("Watercolor", "Watercolor", false),
        ("Tribal", "Tribal", false),
        ("Trash Polka", "TrashPolka", false),
        ("Geometric", "Geometric", false),
        ("Japanese Traditional", "JapaneseTraditional", false),
        ("Script", "Script", false),
        ("Black and Grey", "BlackandGrey", false)
    ]
    
    init() {
        self.tattooStyles.onNext(self.data)
    }
    
    func didSelectTattooStyle(_ index: Int) {
        var item = self.data[index]
        item.selected = !item.selected
        self.data.replaceSubrange(index...index, with: [item])
        self.tattooStyles.onNext(self.data)
    }
    
}
