#include <stdio.h>
#include <stdlib.h>
#include <fcgiapp.h>

int main() {
    // This function sets up the library's internal data structures and prepares it for use
    FCGX_Init();

    // Open a socket on the local machine at port 8080
    int sockfd = FCGX_OpenSocket("127.0.0.1:8080", 100);

    // Initialize a FCGX_Request struct to handle incoming requests on that socket
    FCGX_Request req;
    FCGX_InitRequest(&req, sockfd, 0);


    while (FCGX_Accept_r(&req) >= 0) {
        // Write an HTTP response header and the message to the output stream associated with the current request
        // This will result in an HTTP response being sent back to the client that made the request
        FCGX_FPrintF(req.out, "Content-Type: text/html\n\n");
        FCGX_FPrintF(req.out, "Hello world!");
    }
    
    return 0;
}
