func solution(_ phone_number:String) -> String {
    String(repeatElement("*", count: phone_number.count-4)) + phone_number.suffix(4)
}