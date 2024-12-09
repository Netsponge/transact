       IDENTIFICATION DIVISION.
       PROGRAM-ID. Calcul-Transactions.

                                                                        
                                                                       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT Trans-File ASSIGN TO "transactions.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  Trans-File.
       01  Trans-Record.
           05  Trans-Num     PIC X(4).
           05  Trans-Amount  PIC 9(5).

       WORKING-STORAGE SECTION.
       01  WS-Total           PIC 9(8) VALUE 0.
       01  WS-Display-Line    PIC X(30).
       01  End-Of-File        PIC X VALUE "N".

       PROCEDURE DIVISION.
           PERFORM Main-Logic
           STOP RUN.

       Main-Logic.
           OPEN INPUT Trans-File
           PERFORM UNTIL End-Of-File = "Y"
               READ Trans-File INTO Trans-Record
                   AT END
                       MOVE "Y" TO End-Of-File
                   NOT AT END
                       PERFORM Process-Transaction
               END-READ
           END-PERFORM
           DISPLAY "Total des transactions : " WS-Total
           CLOSE Trans-File.


       Process-Transaction.
           ADD Trans-Amount TO WS-Total
           STRING "Transaction " Trans-Num ": " Trans-Amount
               DELIMITED BY SIZE INTO WS-Display-Line
           DISPLAY WS-Display-Line.
