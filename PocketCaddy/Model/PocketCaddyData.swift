//
//  PocketCaddyData.swift
//  PocketCaddy
//
//  Created by Chase Allen on 2/27/18.
//  Copyright © 2018 Chase Allen. All rights reserved.
//

import Foundation
import Alamofire

//parsing and searching class

class PocketCaddyData{
    
    enum Method{
        case get
        case put
        case post
    }
    
    enum Table{
        case clubs
        case courses
        case games
        case golfers
        case holes
        case scores
        case swings
        case comments
    }
    
    static let decoder = JSONDecoder()
    static var baseURL = "https://www.pocketcaddyservice.com/api/"
    static let allowedCharacterSet = (CharacterSet(charactersIn: "%"))
    
    /*
     POST FUNCTION: PARAMATERS
     table:
        list of all of our tables in enum form, choose an enum
     paramaters:
        parameters must be in a dict of for <String: String> (example let usr:Parameter = ['key1': 'value1', 'key2': 'value2']
        it must be this way to conform to the parameter call we are doing and must be in the form of a JSON. look at Loginviewcontroller or signupviewcontroller if necessary
     login:
        if you are working on some kind of login feature, set to true else leave is as false. Should always be false since the login is the only time it will be needed
     completionHandler:
        this runs asyncronously with your call. it will give you NSDictionary and String to mess with. I also included the status code in case you get errors
        look up completion handlers, ask me or look at my code if theres any confusion
     
     This function will give you an NSDictionary with the JSON object returned and a string that says 'Success' if the JSON was grabbed succesfully.
     It will give you a blank dictionary and 'Error' if it does not.
    */
    
    class func post(table: Table, newTable: Table?, userId: String?, tokenId: String?, parameters: Parameters, login: Bool, completionHandler: @escaping  (NSDictionary?, String, Int?) -> Void) {
        var url = baseURL + "\(table)"
        if(login){
            url.append("/login")
        }
        if let userId = userId {
            url.append("/\(userId)")
        }
        if let newTable = newTable{
            url.append("/\(newTable)")
        }
        if let tokenId = tokenId{
            url.append("?access_token=\(tokenId)")
        }
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            if response.result.value != nil {
                if response.response?.statusCode == 200 {
                    let value = response.result.value as? NSDictionary
                    completionHandler(value, "Success", 200)
                    return
                }
                completionHandler([:], "Error", response.response?.statusCode)
                return
            }
            completionHandler([:], "Error", response.response?.statusCode)
            return
        }).resume()
        return
    }
    
    //NEED
    static func updateGame(parameters: Parameters, tokenId: String){
        if let gameId = parameters["gameId"] as? String{
            let url = "https://www.pocketcaddyservice.com/api/Games/update?where=%7B%22gameId%22%3A%20\(gameId)%7D&access_token=\(tokenId)"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: {response in
                if response.result.value != nil {
                    
                }
            })
        }
    }
    
    /*
     GET FUNCTION: PARAMETERS
     table:
        same as above
     id:
        if you are getting data for a specific person, pass the id of them into the parameter list. if not just leave nil
     exists:
        this is for checking whether something is in our database or not already. leave false unless trying to hit an /exists endpoint
     completionHandler:
        same as above. returns the same three things. This one returns status code because in some cases you will not get a NSDictionary back from your call, just a status code to confirm it worked.
    */
    static func get(table: Table, tokenId: String?, id: String?, exists: Bool, completionHandler: @escaping (NSDictionary?, String, Int?) -> Void){
        var url = baseURL + "\(table)"
        if let id = id {
            url.append("/\(id)")
        }
        if let tokenId = tokenId{
            url.append("?access_token=\(tokenId)")
        }
        if(exists){
            url.append("/exists")
        }
        
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            if response.result.value != nil{
                if response.response?.statusCode == 200 {
                    let value = response.result.value as? NSDictionary
                    completionHandler(value, "Success", 200)
                    return
                }
                completionHandler([:], "Error", response.response?.statusCode)
                return
            }
            completionHandler([:], "Error", response.response?.statusCode)
            return
        })
    }
    
    static func getComments(tokenId: String, userId: String, courseId: String, completionHandler: @escaping ([Comments])->Void){
        let url = baseURL + "Golfers/\(userId)/comments?filter[where][courseId]=\(courseId)&access_token=\(tokenId)"
        print("URL: \(url)")
        var comments = [Comments]()
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any]{
                    for results in array{
                        if let obj = results as? NSDictionary {
                            let userId = "\(obj["userId"]!)"
                            let courseId = "\(obj["courseId"]!)"
                            let comment = "\(obj["content"]!)"
                            comments.append(Comments(userId: userId, courseId: courseId, content: comment))
                        }
                    }
                }
            }
        })
    }
    
    static func getScores(gameId: String, tokenId: String, completionHandler: @escaping ([Scores]) -> Void){
        let url = baseURL + "Scores?filter[where][gameId]=\(gameId)&access_token=\(tokenId)"
        var scores = [Scores]()
        
        Alamofire.request(url).responseJSON { response in
            if response.result.value != nil, let data = response.data{
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let array = json as? [Any]{
                        for results in array{
                            if let obj = results as? NSDictionary{
                                let gameId = "\(obj["gameId"]!)"
                                let holeId =  obj["holeId"] as! Int
                                let score = "\(obj["score"]!)"
                                scores.append(Scores(holeId: holeId, gameId: gameId, scores: score))
                            }
                        }
                        completionHandler(scores)
                        return
                    }
            }
            completionHandler([])
        }
    }
    
    static func delete(table: Table, tokenId: String, id: String) -> Void {
        let url = baseURL + "\(table)/\(id)?access_token=\(tokenId)"

        Alamofire.request(url, method: .delete).responseJSON(completionHandler: { response in
            return
        })
    }
    
    static func update(gameId: String, tokenId:String, holeId: String, parameters: Parameters, completionHandler: @escaping (Bool) ->Void){
        let url = "https://www.pocketcaddyservice.com/api/Scores/update?where=%7b%22holeId%22%3a\(holeId)%2c%22gameId%22%3a\(gameId)%7d&access_token=\(tokenId)"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.value != nil, let dict = response.result.value as? NSDictionary, let count = dict["count"] as? Int{
                if count == 1 {
                    completionHandler(true)
                    return
                }
                completionHandler(false)
            }
        }
    }
    
    static func getUserInfo(table: Table, tokenId: String?, userId: String, completionHandler: @escaping ([Any]?) -> Void){
        var url = baseURL
        if let tokenId = tokenId{
            url.append("/golfers/\(userId)/\(table)?access_token=\(tokenId)")
        }else{
            url.append("\(table)?filter[where][userId]=\(userId)")
        }
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any]{
                    completionHandler(array)
                }
                completionHandler(nil)
            }
            completionHandler(nil)
        })
    }
    
    static func getSwings(table: Table, tokenId: String, clubId: String, completionHandler: @escaping ([Swings]?) -> Void){
        var url = baseURL
        url.append("\(table)?filter[where][clubId]=\(clubId)&access_token=\(tokenId)")
        var swings = [Swings]()
        Alamofire.request(url).responseJSON(completionHandler: { response in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any]{
                        for results in array {
                            if let obj = results as? NSDictionary{
                                let swingId = "\(obj["swingId"]!)"
                                let distance = obj["distance"]! as! Int
                                let clubId = "\(obj["clubId"]!)"
                                swings.append(Swings(swingId: swingId, distance: distance, clubId: clubId, date: nil))
                            }
                        }
                        completionHandler(swings)
                }
                completionHandler(nil)
            }
            completionHandler(nil)
        })
    }
    
    static func getWeather(zip: String, completionHandler: @escaping ([Double])->Void){
        let url = "http://api.openweathermap.org/data/2.5/weather?zip=\(zip),us&appid=14e3c11ef3f7e8c7fbaecae6510889f2"
        
        Alamofire.request(url, method: .get).responseJSON(completionHandler: {response in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? NSDictionary, let wind = array["wind"] as? NSDictionary{
                    if let windDouble = wind["deg"] as? Double, let speedDouble = wind["speed"] as? Double{
                        let rounded = speedDouble.rounded()
                        let doubleArray = [windDouble, rounded]
                        completionHandler(doubleArray)
                        
                        return
                    }
                    completionHandler([])
                }
                completionHandler([])
            }
        }).resume()
    }
    
    //Only used for realtime update of search bar in play
    static func search(searchText: String, completionHandler: @escaping ([Course]? )-> Void){
        var course = [Course]()
        var url = baseURL
        url.append("Courses?filter[where][courseName][like]=\(searchText)")
        if(searchText != ""){
            url.append("%25")
        }
        url = url.replacingOccurrences(of: " ", with: "+")
        
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any]{
                    for results in array{
                        if let obj = results as? NSDictionary{
                            let id = "\(obj["courseId"]!)"
                            let address = "\(obj["addressLine1"]!)"
                            let city = "\(obj["city"]!)"
                            let name = "\(obj["courseName"]!)"
                            let state = "\(obj["state"]!)"
                            let zip = "\(obj["zipCode"]!)"
                            course.append((Course(id: id, name: name, address1: address, address2: nil, city: city, state: state, zipCode: zip)))
                        }
                    }
                    completionHandler(course)
                }
                

            }
        }).resume()
        
    }
    
    static func getHoles(courseId: String, completionHandler: @escaping ([Holes])->Void) {
        var holes = [Holes]()
        var url = "https://www.pocketcaddyservice.com/api/Holes?filter[where][courseId]="
        url.append(courseId)
        
        Alamofire.request(url, method: .get).responseJSON(completionHandler: {response in
            if response.result.value != nil, let data = response.data{
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any]{
                    for results in array{
                        if let obj = results as? NSDictionary{
                            let holeId = "\(obj["holeId"]!)"
                            let courseId = "\(obj["courseId"]!)"
                            let holeNum = obj["holeNum"] as! Int
                            let par = obj["par"] as! Int
                            let greenX = obj["greenX"] as! Double
                            let greenY = obj["greenY"] as! Double
                            let teeX = obj["teeX"] as! Double
                            let teeY = obj["teeY"] as! Double
                            var middleX = obj["middleX"] as? Double
                            var middleY = obj["middleX"] as? Double
                            
                            if(middleX == nil || middleY == nil){
                                middleX = 0.0
                                middleY = 0.0
                            }
                            
                            holes.append(Holes(holeID: holeId, courseID: courseId, holeNum: holeNum, par: par, greenX: greenX, greenY: greenY, teeX: teeX, teeY: teeY, middleX: middleX, middleY: middleY))
                        }
                    }
                    completionHandler(holes)
                }
            }
        })
    }
}
