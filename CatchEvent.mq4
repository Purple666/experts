//+------------------------------------------------------------------+
//|                                                   CatchEvent.mq4 |
//|                        Copyright 2012, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#include <ZhuLing_Lib.mqh>


int handle = 0;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   handle = FileOpen("Catch Event Log.csv",FILE_CSV|FILE_READ|FILE_WRITE);
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   if(handle > 0)
   {
      FileClose(handle);
   }
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {

   string CurrentSymbol = Symbol();
   double Lots = 0.2;
   double PriceJump = 0;
   double stoploss = 0;
   double takeprofit = 0;
   //定义事件的时间，注意是北京时间 -  6小时(对IronFX)
   datetime EventTime = StrToTime("2013.3.12 11:30");

    
   if(StringFind(CurrentSymbol,"EURUSD") != -1)
   {
      PriceJump = 5;
      stoploss = 7;
      takeprofit = 100;
   }
   
   if(StringFind(CurrentSymbol,"GBPUSD") != -1)
   {
      PriceJump = 6;
      stoploss = 7;
      takeprofit = 100;
   }   
   
   if(StringFind(CurrentSymbol,"USDJPY") != -1)
   {
      PriceJump = 60;
      stoploss = 70;
      takeprofit = 500;
   }

   if(PriceJump == 0)
   {
      return (0);
   }



   //事件还有超过120秒才发生，不开单
   if(EventTime - TimeCurrent() > 120)
      return(0);
      
   //事件已经发生超过了60秒，将所有挂单删除  
   if(TimeCurrent() - EventTime > 60)
   {
      for(int i=0;i<OrdersTotal();i++)
      {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         {
            if((OrderType()==OP_BUYSTOP ) || (OrderType()==OP_SELLSTOP))    
            {
               int ticket = OrderTicket();
               OrderDelete(ticket);
            } 
         }
      }
      return(0);
   }
   
   
   //此时离时间不到120秒，在价位的上部和下部分别开挂单
   
   //如果已经开了挂单，并且上次挂单的价格和这次挂单的价格相差小于5点，则更改挂单价格
   
   for(i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
      {
         if(OrderType()==OP_BUYSTOP  ||    OrderType()==OP_SELLSTOP)
         {
            return (0);           
         } 
      }
   }
      
   double price = Ask + PriceJump*PointScale(CurrentSymbol)*MarketInfo(CurrentSymbol,MODE_POINT);
   buyStop(CurrentSymbol,Lots,price,stoploss,takeprofit,CurrentSymbol + " Catch Event", 2, handle);


   price = Bid - PriceJump*PointScale(CurrentSymbol)*MarketInfo(CurrentSymbol,MODE_POINT);
   sellStop(CurrentSymbol,Lots,price,stoploss,takeprofit,CurrentSymbol + " Catch Event", 2,handle);

   return(0);
  }
//+------------------------------------------------------------------+