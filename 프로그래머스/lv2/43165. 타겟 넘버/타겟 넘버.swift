func solution(_ numbers: [Int], _ target: Int) -> Int {
    var count = 0
    
    func dfs(_ depth: Int, _ sum: Int) {
        if depth == numbers.count {
            if sum == target {
                count += 1
            }
            return
        }
        
        dfs(depth + 1, sum + numbers[depth])
        dfs(depth + 1, sum - numbers[depth])
        return
    }
    
    dfs(0, 0)
    
    return count
}