class Solution {
    func numberOfSteps(_ num: Int) -> Int {
        var num = num
        var ans = 0

        while num > 0 {
            if num % 2 == 0 {
                num /= 2
            } else {
                num -= 1
            }
            ans += 1
        }

        return ans
    }
}