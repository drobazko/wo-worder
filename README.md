Challenge Description
In this code challenge you are required to write a web API with 2 endpoints:

1. A 'word counter' endpoint
Receives a text input and counts the number of appearances for each word in the input.
The endpoint should not return data (but you may return success status, etc).
The endpoint should be able to accept the input in 3 ways:
A simple string sent in the request.
A file path (the contents of the file will be used as input).
A URL (the data returned from the URL will be used as input).
The input may be very large (up to tens of gigabytes).
The results (the number of appearances of each word) should be persisted, to be used by the ‘word statistics’ service.

2. A 'word statistics' endpoint
Receives a word and returns the number of times the word appeared so far (in all previous inputs)

Examples

Word counter endpoint:
Input string: "Hi! My name is (what?), my name is (who?), my name is Slim Shady"
Output: (empty)

Word statistics endpoint:
input: "my"
output: 3

input: "what"
output: 1

input: "hello"
output: 0
