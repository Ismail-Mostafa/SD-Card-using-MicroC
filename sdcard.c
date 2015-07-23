sbit Mmc_Chip_Select           at LATC0_bit;  // for writing to output pin always use latch (PIC18 family)
sbit Mmc_Chip_Select_Direction at TRISC0_bit;

char buf[512];
char read[512];


void main() {
    char error,error2;
    uart1_init(9600);
    SPI1_Init();
    buf[0]='E';
    buf[1]='n';
    buf[2]='g';
    buf[3]='S';
    buf[4]='h';
    buf[5]='a';
    buf[6]='d';
    buf[7]='y';
    

    
    trisd=255;
  
     error = MMC_init();
    if(!error){
    uart1_write_text("connected");
    }
    else
    uart1_write_text("not connected");

    
    
    while(1)
    {
    if(rd0_bit==0)
    {
    buf[0]='E';
    buf[1]='n';
    buf[2]='g';
    buf[3]='S';
    buf[4]='h';
    buf[5]='a';
    buf[6]='d';
    buf[7]='y';
     error2 = Mmc_write_Sector(1, buf);
     if(!error2)
     {
     uart1_write_text("write success");
     }
     else
     uart1_write_text("write not success");
     while(rd0_bit==0){}
    }
    
    
        if(rd1_bit==0)
    {
     error2 = Mmc_read_Sector(1, read);
     uart1_write_text(read);
     while(rd1_bit==0){}
    }
      if(rd2_bit==0)
    {
    buf[0]='E';
    buf[1]='n';
    buf[2]='g';
    buf[3]='i';
    buf[4]='s';
    buf[5]='m';
    buf[6]='a';
    buf[7]='i';
    buf[7]='l';
     error2 = Mmc_write_Sector(1, buf);
     if(!error2)
     {
     uart1_write_text("write success");
     }
     else
     uart1_write_text("write not success");
     while(rd2_bit==0){}
    }

    
    
    
    }
    



}