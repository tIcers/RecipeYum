//
//  ImageListViewModel.swift
//  RecipeYum
//
//  Created by Atsuki on 2023-10-16.
//

import Foundation
import Combine

class ImageListViewModel: ObservableObject{
    @Published var images: [ImageModel] = []
    
    func fetchRandomImages() {
           let appId = "f2f45e95"
           let appKey = "b72dc6cc95bcc5c2731e9880f4436877"
           
           let apiEndpoint = "https://api.edamam.com/api/recipes/v2"

           let parameters: [String: String] = [
               "q": "chicken",
               "app_id": appId,
               "app_key": appKey,
               "type": "public",
               "random": "true"
           ]
        
        URLSession.shared.dataTaskPublisher(for: URL(string: apiEndpoint + "?" + parameters.urlEncodedString)!).map(\.data)
                   .decode(type: EdamamAPIResponse.self, decoder: JSONDecoder())
                   .receive(on: DispatchQueue.main)
                   .sink(receiveCompletion: { completion in
                       switch completion {
                       case .finished:
                           break 
                       case .failure(let error):
                           print("Error fetching random images: \(error)")
                       }
                   }, receiveValue: { [weak self] response in
                       let imageURLs = response.hits.map { $0.recipe.image }
                       let randomImages = imageURLs.compactMap {ImageModel(imageURL: URL(string: $0)!) }
                       self?.images = randomImages.shuffled()
                   })
                   .store(in: &cancellables)
           }

           private var cancellables: Set<AnyCancellable> = []
       }
