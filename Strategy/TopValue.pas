unit TopValue;

interface

uses Strategy_Special;

procedure StrategyBegin();

var
  IsSpecial_OrderToday: boolean;
  OrderSpecial_1: String = 'Special_1';
  OrderSpecial_2: String = 'Special_2';
  OrderPreOrder: String = 'PreOrder';
  OrderProfit: String = 'Profit';
  OrderInventAnti: String = 'InventAnti';
  OrderFloat: String = 'OrderFloat';
  OrderInternal: String = 'Internal';
  OrderEngine: String = 'Engine';
  OrderKeepOrder: String = 'KeepOrder';

implementation

procedure StrategyBegin();
begin
  IsSpecial_OrderToday:= IsSpecial_1_Order();
end;

end.
