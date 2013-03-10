//+------------------------------------------------------------------+
//|                                              ZhuLing_Lib_Utl.mq4 |
//|                                                         Zhu Ling |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Zhu Ling"



bool checkPoint5(string symbol)
{
   if(MarketInfo(symbol, MODE_ASK)/MarketInfo(symbol, MODE_POINT) < 100000)
      return (true);
   else
      return (false);
}

int PointScale(string symbol)
{
   if(checkPoint5(symbol))
   {
      return (1);
   }
   else
   {
      return (10);
   }
}

string ErrorDescription(int error_code)
{
   string error_string;
//----
   switch(error_code)//switch ���֧���
     {
      //---- codes returned from trade serverc
      //case:��caseȫ����������Ӧ���ʽֵ���Ĳ�����֮�ڱȽϳ������ʽֵ��
      //ÿһ��case�������������������ʽ�ڱ�ע���������ʽ�����������������á�
      //switch���ʽ��������������������(int )��
      
      //braek��䣺һ��Ƕ�� ��������ֹ����ⲿ������ switch, while�� for ��ִ�С�
      //����ֹ������֮��������������������������Ŀ��֮һ��������ֵָ��Ϊ����ʱ�����������ѭ��ִ�С�
      
      
      case 0:
      case 1:   error_string="nû�д��󷵻�";                                      break;
      case 2:   error_string="һ�����";                                         break;
      case 3:   error_string="��Ч���ײ��� ";                                      break;
      case 4:   error_string="���׷�������æ";                                     break;
      case 5:   error_string="�ͻ��ն˾ɰ汾";                                     break;
      case 6:   error_string="û�����ӷ�����";                                     break;
      case 7:   error_string="û��Ȩ��";                                           break;
      case 8:   error_string="�������Ƶ��";                                       break;
      case 9:   error_string="�������й���";                                       break;
      case 64:  error_string="�˻���ֹ";                                           break;
      case 65:  error_string="��Ч�˻�";                                           break;
      case 128: error_string="���׳�ʱ";                                           break;
      case 129: error_string="��Ч�۸�";                                           break;
      case 130: error_string="��Чֹͣ";                                           break;
      case 131: error_string="��Ч������";                                         break;
      case 132: error_string="�г��ر�";                                           break;
      case 133: error_string="���ױ���ֹ";                                         break;
      case 134: error_string="�ʽ���";                                           break;
      case 135: error_string="�۸�ı�";                                           break;
      case 136: error_string="����";                                               break;
      case 137: error_string="���ͷ�æ";                                           break;
      case 138: error_string="���¿���";                                           break;
      case 139: error_string="����������";                                         break;
      case 140: error_string="ֻ�����ǲ�λ";                                     break;
      case 141: error_string="��������";                                           break;
      case 145: error_string="��Ϊ���ڽӽ��г����޸ķ�";                         break;
      case 146: error_string=" �����ı����� ";                                     break;
      //---- mql4 errors  MQL4 ���д������
      case 4000: error_string="û�д���";                                         break;
      case 4001: error_string="������ָʾ";                                     break;
      case 4002: error_string="��������������Χ";                                 break;
      case 4003: error_string="���ڵ��ö�ջ����������û���㹻�ڴ�";               break;
      case 4004: error_string="ѭ����ջ���������";                               break;
      case 4005: error_string="���ڶ�ջ����������û���ڴ�";                       break;
      case 4006: error_string="�������в���û���㹻�ڴ�";                         break;
      case 4007: error_string="��������û���㹻�ڴ�";                             break;
      case 4008: error_string="û�г�ʼ����";                                     break;
      case 4009: error_string="��������û�г�ʼ�ִ���";                           break;
      case 4010: error_string="��������û���ڴ�";                                 break;
      case 4011: error_string="���й���";                                         break;
      case 4012: error_string="��������Ϊ��";                                     break;
      case 4013: error_string="�㻮��";                                           break;
      case 4014: error_string="��������";                                         break;
      case 4015: error_string="����ת��(û�г������)";                           break;
      case 4016: error_string="û�г�ʼ����";                                     break;
      case 4017: error_string="��ֹ����DLL";                                      break;
      case 4018: error_string="���ݿⲻ������";                                   break;
      case 4019: error_string="���ܵ��ú���";                                     break;
      case 4020: error_string="��ֹ�������ܽ��׺���";                             break;
      case 4021: error_string="�������Ժ���������û���㹻�ڴ�";                   break;
      case 4022: error_string="ϵͳ��æ (û�г������)";                          break;
      case 4050: error_string="��Ч������������";                                 break;
      case 4051: error_string="��Ч����ֵ����";                                   break;
      case 4052: error_string="���к����ڲ�����";                                 break;
      case 4053: error_string="һЩ�������";                                     break;
      case 4054: error_string="Ӧ�ò���ȷ����";                                   break;
      case 4055: error_string="�Զ���ָ�����";                                   break;
      case 4056: error_string="��Э������";                                       break;
      case 4057: error_string="����������̴���";                                 break;
      case 4058: error_string="�������δ�ҵ�";                                   break;
      case 4059: error_string="����ģʽ������ֹ";                                 break;
      case 4060: error_string="û��ȷ�Ϻ���";                                     break;
      case 4061: error_string="�����ʼ�����";                                     break;
      case 4062: error_string="����Ԥ�Ʋ���";                                     break;
      case 4063: error_string="����Ԥ�Ʋ���";                                     break;
      case 4064: error_string="˫Ԥ�Ʋ���";                                       break;
      case 4065: error_string="������ΪԤ�Ʋ���";                                 break;
      case 4066: error_string="ˢ��״̬������ʷ����";                             break;
      case 4099: error_string="�ļ�����";                                         break;
      case 4100: error_string="һЩ�ļ�����";                                     break;
      case 4101: error_string="�����ļ�����";                                     break;
      case 4102: error_string="���ļ�����";                                     break;
      case 4103: error_string="���ܴ��ļ�";                                     break;
      case 4104: error_string="��Э���ļ�";                                       break;
      case 4105: error_string="û��ѡ�񶨵�";                                     break;
      case 4106: error_string="�������Ҷ�";                                       break;
      case 4107: error_string="��Ч�۸�";                                         break;
      case 4108: error_string="��Ч��������";                                     break;
      case 4109: error_string="��������";                                       break;
      case 4110: error_string="��������";                                       break;
      case 4111: error_string="���������";                                       break;
      case 4200: error_string="�����Ѿ�����";                                     break;
      case 4201: error_string="������������";                                     break;
      case 4202: error_string="����������";                                       break;
      case 4203: error_string="������������";                                     break;
      case 4204: error_string="û�ж�������";                                     break;
      case 4205: error_string="�����������";                                     break;
      case 4206: error_string="û��ָ���Ӵ���";                                   break;
      default:   error_string="��֪���Ĵ���";
     }
//----
   return(error_string);
} 