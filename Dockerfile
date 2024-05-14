# Use the official Golang image to create a build artifact.
FROM golang:1.19 as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Set environment variables for cross-compilation
ENV GOOS=linux
ENV GOARCH=amd64

# Copy the Go Modules manifests
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY src/ .

# Build the Go app
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o main .

# Start a new stage from scratch
FROM alpine:latest  

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/main .

# Command to run the executable
CMD ["./main"]
