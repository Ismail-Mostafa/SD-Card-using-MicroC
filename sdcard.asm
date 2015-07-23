
_main:

;sdcard.c,8 :: 		void main() {
;sdcard.c,10 :: 		uart1_init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;sdcard.c,11 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;sdcard.c,12 :: 		buf[0]='E';
	MOVLW       69
	MOVWF       _buf+0 
;sdcard.c,13 :: 		buf[1]='n';
	MOVLW       110
	MOVWF       _buf+1 
;sdcard.c,14 :: 		buf[2]='g';
	MOVLW       103
	MOVWF       _buf+2 
;sdcard.c,15 :: 		buf[3]='S';
	MOVLW       83
	MOVWF       _buf+3 
;sdcard.c,16 :: 		buf[4]='h';
	MOVLW       104
	MOVWF       _buf+4 
;sdcard.c,17 :: 		buf[5]='a';
	MOVLW       97
	MOVWF       _buf+5 
;sdcard.c,18 :: 		buf[6]='d';
	MOVLW       100
	MOVWF       _buf+6 
;sdcard.c,19 :: 		buf[7]='y';
	MOVLW       121
	MOVWF       _buf+7 
;sdcard.c,23 :: 		trisd=255;
	MOVLW       255
	MOVWF       TRISD+0 
;sdcard.c,25 :: 		error = MMC_init();
	CALL        _Mmc_Init+0, 0
;sdcard.c,26 :: 		if(!error){
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main0
;sdcard.c,27 :: 		uart1_write_text("connected");
	MOVLW       ?lstr1_sdcard+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_sdcard+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;sdcard.c,28 :: 		}
	GOTO        L_main1
L_main0:
;sdcard.c,30 :: 		uart1_write_text("not connected");
	MOVLW       ?lstr2_sdcard+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_sdcard+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_main1:
;sdcard.c,34 :: 		while(1)
L_main2:
;sdcard.c,36 :: 		if(rd0_bit==0)
	BTFSC       RD0_bit+0, 0 
	GOTO        L_main4
;sdcard.c,38 :: 		buf[0]='E';
	MOVLW       69
	MOVWF       _buf+0 
;sdcard.c,39 :: 		buf[1]='n';
	MOVLW       110
	MOVWF       _buf+1 
;sdcard.c,40 :: 		buf[2]='g';
	MOVLW       103
	MOVWF       _buf+2 
;sdcard.c,41 :: 		buf[3]='S';
	MOVLW       83
	MOVWF       _buf+3 
;sdcard.c,42 :: 		buf[4]='h';
	MOVLW       104
	MOVWF       _buf+4 
;sdcard.c,43 :: 		buf[5]='a';
	MOVLW       97
	MOVWF       _buf+5 
;sdcard.c,44 :: 		buf[6]='d';
	MOVLW       100
	MOVWF       _buf+6 
;sdcard.c,45 :: 		buf[7]='y';
	MOVLW       121
	MOVWF       _buf+7 
;sdcard.c,46 :: 		error2 = Mmc_write_Sector(1, buf);
	MOVLW       1
	MOVWF       FARG_Mmc_Write_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Write_Sector_sector+1 
	MOVWF       FARG_Mmc_Write_Sector_sector+2 
	MOVWF       FARG_Mmc_Write_Sector_sector+3 
	MOVLW       _buf+0
	MOVWF       FARG_Mmc_Write_Sector_dbuff+0 
	MOVLW       hi_addr(_buf+0)
	MOVWF       FARG_Mmc_Write_Sector_dbuff+1 
	CALL        _Mmc_Write_Sector+0, 0
;sdcard.c,47 :: 		if(!error2)
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;sdcard.c,49 :: 		uart1_write_text("write success");
	MOVLW       ?lstr3_sdcard+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_sdcard+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;sdcard.c,50 :: 		}
	GOTO        L_main6
L_main5:
;sdcard.c,52 :: 		uart1_write_text("write not success");
	MOVLW       ?lstr4_sdcard+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_sdcard+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_main6:
;sdcard.c,53 :: 		while(rd0_bit==0){}
L_main7:
	BTFSC       RD0_bit+0, 0 
	GOTO        L_main8
	GOTO        L_main7
L_main8:
;sdcard.c,54 :: 		}
L_main4:
;sdcard.c,57 :: 		if(rd1_bit==0)
	BTFSC       RD1_bit+0, 1 
	GOTO        L_main9
;sdcard.c,59 :: 		error2 = Mmc_read_Sector(1, read);
	MOVLW       1
	MOVWF       FARG_Mmc_Read_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Read_Sector_sector+1 
	MOVWF       FARG_Mmc_Read_Sector_sector+2 
	MOVWF       FARG_Mmc_Read_Sector_sector+3 
	MOVLW       _read+0
	MOVWF       FARG_Mmc_Read_Sector_dbuff+0 
	MOVLW       hi_addr(_read+0)
	MOVWF       FARG_Mmc_Read_Sector_dbuff+1 
	CALL        _Mmc_Read_Sector+0, 0
;sdcard.c,60 :: 		uart1_write_text(read);
	MOVLW       _read+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_read+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;sdcard.c,61 :: 		while(rd1_bit==0){}
L_main10:
	BTFSC       RD1_bit+0, 1 
	GOTO        L_main11
	GOTO        L_main10
L_main11:
;sdcard.c,62 :: 		}
L_main9:
;sdcard.c,63 :: 		if(rd2_bit==0)
	BTFSC       RD2_bit+0, 2 
	GOTO        L_main12
;sdcard.c,65 :: 		buf[0]='E';
	MOVLW       69
	MOVWF       _buf+0 
;sdcard.c,66 :: 		buf[1]='n';
	MOVLW       110
	MOVWF       _buf+1 
;sdcard.c,67 :: 		buf[2]='g';
	MOVLW       103
	MOVWF       _buf+2 
;sdcard.c,68 :: 		buf[3]='i';
	MOVLW       105
	MOVWF       _buf+3 
;sdcard.c,69 :: 		buf[4]='s';
	MOVLW       115
	MOVWF       _buf+4 
;sdcard.c,70 :: 		buf[5]='m';
	MOVLW       109
	MOVWF       _buf+5 
;sdcard.c,71 :: 		buf[6]='a';
	MOVLW       97
	MOVWF       _buf+6 
;sdcard.c,72 :: 		buf[7]='i';
	MOVLW       105
	MOVWF       _buf+7 
;sdcard.c,73 :: 		buf[7]='l';
	MOVLW       108
	MOVWF       _buf+7 
;sdcard.c,74 :: 		error2 = Mmc_write_Sector(1, buf);
	MOVLW       1
	MOVWF       FARG_Mmc_Write_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Write_Sector_sector+1 
	MOVWF       FARG_Mmc_Write_Sector_sector+2 
	MOVWF       FARG_Mmc_Write_Sector_sector+3 
	MOVLW       _buf+0
	MOVWF       FARG_Mmc_Write_Sector_dbuff+0 
	MOVLW       hi_addr(_buf+0)
	MOVWF       FARG_Mmc_Write_Sector_dbuff+1 
	CALL        _Mmc_Write_Sector+0, 0
;sdcard.c,75 :: 		if(!error2)
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;sdcard.c,77 :: 		uart1_write_text("write success");
	MOVLW       ?lstr5_sdcard+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_sdcard+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;sdcard.c,78 :: 		}
	GOTO        L_main14
L_main13:
;sdcard.c,80 :: 		uart1_write_text("write not success");
	MOVLW       ?lstr6_sdcard+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_sdcard+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_main14:
;sdcard.c,81 :: 		while(rd2_bit==0){}
L_main15:
	BTFSC       RD2_bit+0, 2 
	GOTO        L_main16
	GOTO        L_main15
L_main16:
;sdcard.c,82 :: 		}
L_main12:
;sdcard.c,87 :: 		}
	GOTO        L_main2
;sdcard.c,92 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
