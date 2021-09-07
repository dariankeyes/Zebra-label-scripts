import socket
from datetime import date

today = date.today()
today = today.strftime("%m/%d/%Y")

mysocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

techbar_printer = {'ip': "172.19.69.188", 'port': 9100}
onsite_printer = {'ip': "172.19.69.60", 'port': 9100}

printers = {'techbar_printer': techbar_printer, 'onsite_printer': onsite_printer}


def print_label():
    # printer = input('Choose printer: ')
    name = input('Name: ')
    ticket_number = input('Ticket Number: ')
    user_id = input('UserID: ')
    call = input('Call user - (Y/N): ')

    # must be three spaces between the userid and ^FD for the QR Code to print each time
    x = "^XA" \
        "^FO300,100^BQ,2,6^FD   " + user_id + "^FS" \
         "^CFE,40^FO12,50^FD" + name + "^FS" \
        "^FO12,90^FD" + user_id + "^FS" \
        "^FO12,130^FD" + ticket_number + "^FS" \
        "^FO12,170^FDCall: " + call + "^FS" \
        "^FO12,210^FD" + today + "^FS" \
        "^XZ"

    x = x.encode()

    try:
        mysocket.connect((techbar_printer['ip'], techbar_printer['port']))  # connecting to host
        mysocket.send(x)  # using bytes
        mysocket.close()  # closing connection
    except:
        print("Error with the connection")


def main():
    print_label()


if __name__ == "__main__":
    main()

