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
   //�����¼���ʱ�䣬ע���Ǳ���ʱ�� -  6Сʱ(��IronFX)
   datetime EventTime = StrToTime("2013.3.15 16:20");

    
   if(StringFind(CurrentSymbol,"EURUSD") != -1)
   {
      //Ϊ��֤���������ҵ���������Ϊ6
      PriceJump = 7;
      stoploss = 5;
      takeprofit = 100;
      Lots = 1;
   }
   
   if(StringFind(CurrentSymbol,"GBPUSD") != -1)
   {
      //Ϊ��֤���������ҵ���������Ϊ6
      PriceJump = 7;
      stoploss = 5;
      takeprofit = 100;
      Lots = 1;
   }   
   
   if(StringFind(CurrentSymbol,"USDJPY") != -1)
   {
      //����֤���ҵ���С��50
      PriceJump = 50;
      stoploss = 50;
      takeprofit = 200;
      Lots = 1;
   }

   if(StringFind(CurrentSymbol,"AUDUSD") != -1)
   {
      //Ϊ��֤������������������Ϊ6
      PriceJump = 7;
      stoploss = 5;
      takeprofit = 50;
      Lots = 1;
   }
   
   if(StringFind(CurrentSymbol,"USDCHF") != -1)
   {
      //Ϊ��֤������������������Ϊ6
      PriceJump = 50;
      stoploss = 50;
      takeprofit = 500;
      Lots = 1;
   }

   if(StringFind(CurrentSymbol,"EURJPY") != -1)
   {
      //Ϊ��֤������������������Ϊ6
      PriceJump = 7;
      stoploss = 5;
      takeprofit = 100;
      Lots = 1;
   }

   if(StringFind(CurrentSymbol,"USDCAD") != -1)
   {
      //Ϊ��֤������������������Ϊ6
      PriceJump = 7;
      stoploss = 5;
      takeprofit = 50;
      Lots = 1;
   }
   
   if(StringFind(CurrentSymbol,"NZDUSD") != -1)
   {
      //Ϊ��֤������������������Ϊ6
      PriceJump = 50;
      stoploss = 50;
      takeprofit = 200;
      Lots = 1;
   }   
   

   if(PriceJump == 0)
   {
      return (0);
   }


   //�¼����г���120��ŷ�����������
   if(EventTime - TimeCurrent() > 120)
   {
      return(0);
   }
      
   //ʱ���Ѿ���ʼ��������60���ڣ�������������ҵ��Ѿ���Ч����������
   if(TimeCurrent() - EventTime > 0 && TimeCurrent() - EventTime <= 60)
   {
      return (0);
   }
   
   
   int i = 0;
/*      
   //�¼��Ѿ�����������60�룬�����йҵ�ɾ��  
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
*/   
   
   //��ʱ��ʱ�䲻��120�룬�ڼ�λ���ϲ����²��ֱ𿪹ҵ�
   
   //Todo: ����Ѿ����˹ҵ��������ϴιҵ��ļ۸����ιҵ��ļ۸����С��5�㣬����Ĺҵ��۸�
   bool BuyStopOpened = false;
   bool SellStopOpened = false;
   
   for(i=0;i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
      {
         //������ǵ�ǰ���Ҷԣ����˳�
         if(StringFind(OrderSymbol(),CurrentSymbol) == -1)
         {
            continue;
         }
         
         if(OrderType() == OP_BUYSTOP)
         {
            BuyStopOpened = true;           
         }
         if(OrderType() == OP_SELLSTOP) 
         {
            SellStopOpened = true;
         }
      }
   }
      
   double price =0;
   
   if(!BuyStopOpened)
   {
      price = Ask + PriceJump*PointScale(CurrentSymbol)*MarketInfo(CurrentSymbol,MODE_POINT);
      buyStop(CurrentSymbol,Lots,price,stoploss,takeprofit,CurrentSymbol + " Catch Event", 2, handle);
   }

   if(!SellStopOpened)
   {
      price = Bid - PriceJump*PointScale(CurrentSymbol)*MarketInfo(CurrentSymbol,MODE_POINT);
      sellStop(CurrentSymbol,Lots,price,stoploss,takeprofit,CurrentSymbol + " Catch Event", 2,handle);
   }      


   return(0);
  }
//+------------------------------------------------------------------+