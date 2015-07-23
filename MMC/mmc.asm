
_main:

;mmc.c,39 :: 		void main() {
;mmc.c,41 :: 		unsigned int c =0 ,i,x,y;
;mmc.c,42 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;mmc.c,43 :: 		Glcd_init();
	CALL        _Glcd_Init+0, 0
;mmc.c,45 :: 		GLCD_fill(255);
	MOVLW       255
	MOVWF       FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,46 :: 		i=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;mmc.c,53 :: 		i = 128*10;
	MOVLW       0
	MOVWF       main_i_L0+0 
	MOVLW       5
	MOVWF       main_i_L0+1 
;mmc.c,54 :: 		for(x=i;x<i+128;x++){
	MOVLW       0
	MOVWF       main_x_L0+0 
	MOVLW       5
	MOVWF       main_x_L0+1 
L_main0:
	MOVLW       128
	ADDWF       main_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      main_i_L0+1, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBWF       main_x_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVF        R1, 0 
	SUBWF       main_x_L0+0, 0 
L__main30:
	BTFSC       STATUS+0, 0 
	GOTO        L_main1
;mmc.c,55 :: 		glcd_dot(x,1,logo[x]);
	MOVF        main_x_L0+0, 0 
	MOVWF       FARG_Glcd_Dot_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Dot_y_pos+0 
	MOVLW       _logo+0
	ADDWF       main_x_L0+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_logo+0)
	ADDWFC      main_x_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Glcd_Dot_color+0 
	CALL        _Glcd_Dot+0, 0
;mmc.c,54 :: 		for(x=i;x<i+128;x++){
	INFSNZ      main_x_L0+0, 1 
	INCF        main_x_L0+1, 1 
;mmc.c,56 :: 		}
	GOTO        L_main0
L_main1:
;mmc.c,58 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;mmc.c,60 :: 		while(1){
L_main4:
;mmc.c,61 :: 		error = MMC_init();
	CALL        _Mmc_Init+0, 0
	MOVF        R0, 0 
	MOVWF       main_error_L0+0 
;mmc.c,62 :: 		if(!error){
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;mmc.c,63 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,64 :: 		glcd_write_text("Connected!",1,1,2);
	MOVLW       ?lstr1_mmc+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr1_mmc+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;mmc.c,65 :: 		while(!error){
L_main7:
	MOVF        main_error_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;mmc.c,66 :: 		error= MMC_init();
	CALL        _Mmc_Init+0, 0
	MOVF        R0, 0 
	MOVWF       main_error_L0+0 
;mmc.c,67 :: 		if(RC2_bit==0){
	BTFSC       RC2_bit+0, 2 
	GOTO        L_main9
;mmc.c,68 :: 		for(i=0;i<512;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main10:
	MOVLW       2
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main31:
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
;mmc.c,69 :: 		xyz[i] = logo[i];
	MOVLW       _xyz+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_xyz+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       _logo+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_logo+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;mmc.c,68 :: 		for(i=0;i<512;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;mmc.c,70 :: 		}
	GOTO        L_main10
L_main11:
;mmc.c,71 :: 		error2 = Mmc_write_Sector(1, xyz);
	MOVLW       1
	MOVWF       FARG_Mmc_Write_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Write_Sector_sector+1 
	MOVWF       FARG_Mmc_Write_Sector_sector+2 
	MOVWF       FARG_Mmc_Write_Sector_sector+3 
	MOVLW       _xyz+0
	MOVWF       FARG_Mmc_Write_Sector_dbuff+0 
	MOVLW       hi_addr(_xyz+0)
	MOVWF       FARG_Mmc_Write_Sector_dbuff+1 
	CALL        _Mmc_Write_Sector+0, 0
	MOVF        R0, 0 
	MOVWF       main_error2_L0+0 
;mmc.c,72 :: 		for(i=0;i<512;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main13:
	MOVLW       2
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main32
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main32:
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
;mmc.c,73 :: 		xyz[i] = logo[512+i];
	MOVLW       _xyz+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_xyz+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       0
	ADDWF       main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       2
	ADDWFC      main_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       _logo+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_logo+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;mmc.c,72 :: 		for(i=0;i<512;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;mmc.c,74 :: 		}
	GOTO        L_main13
L_main14:
;mmc.c,75 :: 		error2 = Mmc_write_Sector(2, xyz);
	MOVLW       2
	MOVWF       FARG_Mmc_Write_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Write_Sector_sector+1 
	MOVWF       FARG_Mmc_Write_Sector_sector+2 
	MOVWF       FARG_Mmc_Write_Sector_sector+3 
	MOVLW       _xyz+0
	MOVWF       FARG_Mmc_Write_Sector_dbuff+0 
	MOVLW       hi_addr(_xyz+0)
	MOVWF       FARG_Mmc_Write_Sector_dbuff+1 
	CALL        _Mmc_Write_Sector+0, 0
	MOVF        R0, 0 
	MOVWF       main_error2_L0+0 
;mmc.c,76 :: 		if(!error2){
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;mmc.c,77 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,78 :: 		glcd_write_text("Write Succ!",1,1,2);
	MOVLW       ?lstr2_mmc+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr2_mmc+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;mmc.c,79 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	DECFSZ      R11, 1, 1
	BRA         L_main17
	NOP
	NOP
;mmc.c,80 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,81 :: 		glcd_write_text("Connected!",1,1,2);
	MOVLW       ?lstr3_mmc+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_mmc+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;mmc.c,82 :: 		}
	GOTO        L_main18
L_main16:
;mmc.c,84 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,85 :: 		glcd_write_text("Error",1,1,2);
	MOVLW       ?lstr4_mmc+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr4_mmc+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;mmc.c,86 :: 		}
L_main18:
;mmc.c,87 :: 		}
L_main9:
;mmc.c,88 :: 		if(RC1_bit==0){
	BTFSC       RC1_bit+0, 1 
	GOTO        L_main19
;mmc.c,89 :: 		error2 = Mmc_read_Sector(1, xyz);
	MOVLW       1
	MOVWF       FARG_Mmc_Read_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Read_Sector_sector+1 
	MOVWF       FARG_Mmc_Read_Sector_sector+2 
	MOVWF       FARG_Mmc_Read_Sector_sector+3 
	MOVLW       _xyz+0
	MOVWF       FARG_Mmc_Read_Sector_dbuff+0 
	MOVLW       hi_addr(_xyz+0)
	MOVWF       FARG_Mmc_Read_Sector_dbuff+1 
	CALL        _Mmc_Read_Sector+0, 0
	MOVF        R0, 0 
	MOVWF       main_error2_L0+0 
;mmc.c,90 :: 		for(i=0;i<512;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main20:
	MOVLW       2
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main33:
	BTFSC       STATUS+0, 0 
	GOTO        L_main21
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;mmc.c,92 :: 		}
	GOTO        L_main20
L_main21:
;mmc.c,93 :: 		error2 = Mmc_write_Sector(2, xyz);
	MOVLW       2
	MOVWF       FARG_Mmc_Write_Sector_sector+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Write_Sector_sector+1 
	MOVWF       FARG_Mmc_Write_Sector_sector+2 
	MOVWF       FARG_Mmc_Write_Sector_sector+3 
	MOVLW       _xyz+0
	MOVWF       FARG_Mmc_Write_Sector_dbuff+0 
	MOVLW       hi_addr(_xyz+0)
	MOVWF       FARG_Mmc_Write_Sector_dbuff+1 
	CALL        _Mmc_Write_Sector+0, 0
	MOVF        R0, 0 
	MOVWF       main_error2_L0+0 
;mmc.c,94 :: 		for(i=0;i<512;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main23:
	MOVLW       2
	SUBWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main34:
	BTFSC       STATUS+0, 0 
	GOTO        L_main24
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;mmc.c,96 :: 		}
	GOTO        L_main23
L_main24:
;mmc.c,97 :: 		if(!error2){
	MOVF        main_error2_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
;mmc.c,98 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,100 :: 		delay_ms(2000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main27:
	DECFSZ      R13, 1, 1
	BRA         L_main27
	DECFSZ      R12, 1, 1
	BRA         L_main27
	DECFSZ      R11, 1, 1
	BRA         L_main27
	NOP
	NOP
;mmc.c,101 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,102 :: 		glcd_write_text("Connected!",1,1,2);
	MOVLW       ?lstr5_mmc+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_mmc+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;mmc.c,103 :: 		}
L_main26:
;mmc.c,104 :: 		}
L_main19:
;mmc.c,105 :: 		}
	GOTO        L_main7
L_main8:
;mmc.c,106 :: 		}
	GOTO        L_main28
L_main6:
;mmc.c,108 :: 		glcd_fill(0);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;mmc.c,109 :: 		glcd_write_text("Not Connected!",1,1,2);
	MOVLW       ?lstr6_mmc+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr6_mmc+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;mmc.c,110 :: 		}
L_main28:
;mmc.c,111 :: 		delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main29:
	DECFSZ      R13, 1, 1
	BRA         L_main29
	DECFSZ      R12, 1, 1
	BRA         L_main29
	DECFSZ      R11, 1, 1
	BRA         L_main29
	NOP
;mmc.c,112 :: 		}
	GOTO        L_main4
;mmc.c,113 :: 		}
	GOTO        $+0
; end of _main
