import Foundation

func solution(_ numbers:[Int], _ k:Int) -> Int { numbers[2 * (k-1) % numbers.count] }