package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	transmission_object "github.com/example/project/proto/transmission_object"
    "google.golang.org/protobuf/proto"
)
func main() {
    log.Println("Spinning up the Echo Server in Go...")
    listen, error := net.Listen("tcp", ":1234")
    if error != nil {
        log.Panicln("Unable to listen: " + error.Error())
    }
    defer listen.Close()
    connection, error := listen.Accept()
    if error != nil {
        log.Panicln("Cannot accept a connection! Error: " + error.Error())
    }
    log.Println("Receiving on a new connection")
    defer connection.Close()
    defer log.Println("Connection now closed.")
    buffer := make([]byte, 2048)
    size, error := connection.Read(buffer)
    if error != nil {
        log.Println("Cannot read from the buffer! Error: " + error.Error())
    }
    data := buffer[:size]

    transmissionObject := &transmission_object.TransmissionObject{}
    error = proto.Unmarshal(data, transmissionObject)
    if error != nil {
        log.Println("Cannot unmarshal the buffer! Error: " + error.Error())
    }
    log.Println("Message = " + transmissionObject.Message)
    log.Println("Value = " + fmt.Sprintf("%f", transmissionObject.Value))
    transmissionObject.Message =
        "Echoed from Go: " + transmissionObject.Message
    transmissionObject.Value = transmissionObject.Value
    message, error := json.Marshal(transmissionObject)
    if error != nil {
        log.Panicln(
            "Unable to marshall the object! Error: " + error.Error())
    }
    connection.Write(message)
}
