let n = Int(readLine()!)!

for i in 1...n {
print(String(repeating: "*", count: i) + String(repeating: " ", count: 2*(n-i)) + String(repeating: "*", count: i))
}
for i in 1..<n {
print(String(repeating: "*", count: n-i) + String(repeating: " ", count: 2*i) + String(repeating: "*", count: n-i))
}