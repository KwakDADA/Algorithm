/** 
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return 	     -1 if num is higher than the picked number
 *			      1 if num is lower than the picked number
 *               otherwise return 0 
 * func guess(_ num: Int) -> Int 
 */

class Solution : GuessGame {
    func guessNumber(_ n: Int) -> Int {
        var low = 1
        var high = n

        while low < high {
            let mid = (low + high) / 2
            let ans = guess(mid)

            if ans == 0 {
                return mid
            } else if ans == -1 {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }

        return low
    }
}