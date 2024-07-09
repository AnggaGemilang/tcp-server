#include <iostream>
#include <boost/asio.hpp>
#include <thread>
#include <vector>
#include <random>
#include <cstdlib>

using boost::asio::ip::tcp;

class TcpServer {
public:
    TcpServer(boost::asio::io_context& io_context, short port)
        : io_context_(io_context), acceptor_(io_context, tcp::endpoint(tcp::v4(), port)) {
        start_accept();
    }

private:
    void start_accept() {
        auto socket = std::make_shared<tcp::socket>(io_context_);
        acceptor_.async_accept(*socket, 
            [this, socket](const boost::system::error_code& error) {
                if (!error) {

                    std::random_device rd;
                    std::mt19937 gen(rd());
                    std::uniform_int_distribution<> distrib(0, 2);

                    std::vector<const char*> list_message = {
                        "\xA0\x08\x00\x17\x2B\x31\x43\x32\x6B",
                        "\xCE\x08\x00\x59\x00\x31\x43\x00\x21\x54\x23\x00\x00\x43\x32\x21\x00\x00\x00\x00\x00\x00\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x1C\x22\x33\x00\x00\x66\x00\x56",
                        "\xFC\x08\x00\x1C\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x54\x23\x54\x23\x3C",
                        "\xEE\x08\x00\x1C\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x32\x00\x00\x00\x00\x00\x00\x00\x00\x11"
                    };

                    std::vector<size_t> list_message_length = {9, 53, 44, 27};

                    // 9
                    const char* request_heartbeat_sea_eagle = "\xA0\x08\x00\x17\x2B\x31\x43\x32\x6B";
                    // 28
                    const char* request_fcs = "\xB1\x08\x00\x17\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x23\x23\x3C";
                    // 53
                    const char* request_bite = "\xCE\x08\x00\x59\x00\x31\x43\x00\x21\x54\x23\x00\x00\x43\x32\x21\x00\x00\x00\x00\x00\x00\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x1C\x22\x33\x00\x00\x66\x00\x56";
                    // 44 (\x21 = 00100001 For Perform Wash And Wipe)
                    const char* request_director = "\xFC\x08\x00\x1C\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x23\x54\x23\x54\x23\x3C";
                    // 27
                    const char* request_eod = "\xEE\x08\x00\x1C\x2A\x31\x43\x32\x21\x54\x23\x2A\x31\x43\x32\x21\x54\x32\x00\x00\x00\x00\x00\x00\x00\x00\x11";

                    while(true){
                        int counter = distrib(gen);

                        socket->write_some(boost::asio::buffer(list_message.at(counter), list_message_length.at(counter)));
                        for (std::size_t i = 0; i < list_message_length.at(counter); ++i) {
                            std::cout << std::hex << (static_cast<int>(list_message.at(counter)[i]) & 0xff) << " ";
                        }

                        // socket->write_some(boost::asio::buffer(request_director, 44));
                        // for (std::size_t i = 0; i < 44; ++i) {
                        //     std::cout << std::hex << (static_cast<int>(request_director[i]) & 0xff) << " ";
                        // }

                        std::cout << std::endl << "==========================================" << std::endl;
                        std::this_thread::sleep_for(std::chrono::seconds(3));
                    }

                    // start_read(socket);
                } else {
                    std::cerr << "Accept error: " << error.message() << std::endl;
                }
                start_accept();
            });
    }

    void start_read(std::shared_ptr<tcp::socket> socket) {
        std::memset(this->buffer_, 0, sizeof(this->buffer_));
        socket->async_read_some(boost::asio::buffer(this->buffer_, sizeof(this->buffer_)),
            [this, socket](const boost::system::error_code& error, std::size_t bytes_transferred) {
                if (!error) {
                    // buffer->commit(bytes_transferred);
                    // std::istream is(buffer.get());
                    // std::string data((std::istreambuf_iterator<char>(is)), std::istreambuf_iterator<char>());

                    for (std::size_t i = 0; i < bytes_transferred; ++i) {
                        std::cout << std::hex << (static_cast<int>(this->buffer_[i]) & 0xff) << " ";
                    }

                    std::cout << "=============================================" << std::endl;

                    start_read(socket);
                } else {
                    std::cerr << "Error on receive: " << error.message() << std::endl;
                }
            });
    }
    boost::asio::io_context& io_context_;
    tcp::acceptor acceptor_;
    char buffer_[12288];
};

int main(int argc, char* argv[]) {
    try {
        boost::asio::io_context io_context;
        TcpServer server(io_context, static_cast<short>(std::stoi(std::getenv("TCP_SERVER_PORT"))));
        io_context.run();
    } catch (std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
    }

    return 0;
}
