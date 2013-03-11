//+------------------------------------------------------------------+
//|                                                   CatchEvent.mq4 |
//|                        Copyright 2012, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#include <ZhuLing_Lib.mqh>

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {

   int handle = FileOpen("EALog.csv",FILE_CSV|FILE_READ|FILE_WRITE);
   string CurrentSymbol = Symbol();
   double Lots = 0.1;
   double PriceJump = 50;
   double stoploss = 50;
   double takeprofit = 300;

   //�����¼���ʱ�䣬ע���Ǳ���ʱ�� - 6Сʱ(��IronFX)
   datetime EventTime = StrToTime("2013.3.11 10:01");


   //�¼����г���60��ŷ�����������
   if(EventTime - TimeCurrent() > 60)
      return(0);
      
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
   
   
   //��ʱ��ʱ�䲻��60�룬�ڼ�λ���ϲ����²��ֱ𿪹ҵ�
   
   //����Ѿ����˹ҵ��������ϴιҵ��ļ۸����ιҵ��ļ۸����С��5�㣬����Ĺҵ��۸�
   
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