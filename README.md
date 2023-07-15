# ConnectREST

ConnectREST is a Swift class used for making HTTP requests and handling responses. It allows you to make simple HTTP requests and receive the response.

## Usage

The `Connect` class can be used to make HTTP requests. Here is the basic usage of the class:

```swift
// Create an instance of the class
let connect = Connect(Path: "/api/data", Method: .get)

// Send the request and handle the response
connect.connect { data, response, error in
    if let data = data {
        // Handle the data for successful request
    } else if let error = error {
        // Handle the error for failed request
    }
}
```

In the above example, we create an instance of the `Connect` class and send a `GET` request to the `/api/data` path. The response of the request can be accessed through the `data`, `response`, and `error` parameters. In the case of a successful request, you can process the received data in the `data` parameter. In the case of a failed request, you can handle the error in the `error` parameter.

## Features

The `Connect` class provides the following features:

- `baseUrl`: Can be used to set the base URL where requests will be sent.
- `jsonBody`: Can be used to set and retrieve the JSON data to be used in the request body.

## Customization

You can customize the `Connect` class using the following methods:

- `configure()`: By overriding this method, you can customize your request. For example, you can add custom headers or set authentication settings.
- `printForDebug(_: _: _: _)`: By overriding this method, you can print the request and response information to the console for debugging purposes.

## License

This project is licensed under the MIT License.

---
