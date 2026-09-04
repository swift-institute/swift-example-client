import Coder
import Either
import Example
import Example_Client
import Example_Counter
import Example_Counter_Signature
import Example_Greeting
import Example_Greeting_Signature
import Example_HTTP
import Example_Signature
import HTTP
import HTTP_Client
import HTTP_Coder
import Operation
import Tagged
import Tagged_Coder
import Testing

private func responder() -> HTTP.Interpretation<HTTP.Router.Error> {
    .init(
        HTTP.responder(Example.self) { call throws(HTTP.Router.Error) in
            switch call {
            case .greeting(.greet(let application)):
                return try .ok(Example.Greeting.greet(application.input))

            case .counter(.increment(let application)):
                let value: Example.Counter.Value
                do throws(Example.Counter.Error) {
                    value = try Example.Counter.increment(.init(0), limit: application.input)
                } catch {
                    return try .badRequest(error)
                }
                return try .ok(value)
            }
        }
    )
}

@Suite
struct `Example.Client Tests` {

    @Test
    func `a remote client exchanges every operation over an HTTP interpretation`() async throws {
        let example = Example.client(over: responder())

        #expect(try await example.greeting.greet(.init("Ada")) == .init("Hello, Ada!"))
        #expect(try await example.counter.increment(limit: .init(3)) == .init(1))
    }

    @Test
    func `a domain refusal comes back through the client as the counter's own error`() async throws {
        let example = Example.client(over: responder())

        do throws(Either<HTTP.Interpretation<HTTP.Router.Error>.Error, Example.Counter.Error>) {
            _ = try await example.counter.increment(limit: .init(0))
            Issue.record("expected the refusal")
        } catch {
            #expect(error == .right(.limit(reached: .init(0))))
        }
    }
}
