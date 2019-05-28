program poj1017;
 var i,j,n,m,p,q,l,r,k:longint;
 a:array[1..6] of longint;
 ans:longint;
function min(a,b:longint):longint;
 begin
 if a<b then exit(a) else exit(b);
 end;
begin

 for i:=1 to 6 do
  read(A[i]);
 while a[1]+a[2]+a[3]+a[4]+a[5]+a[6]<>0 do
  begin
  ans:=0;
  {6}
   inc(ans,a[6]);
   a[6]:=0;
  {5}
   inc(ans,a[5]);
   if a[1]>=a[5]*11 then a[1]:=a[1]-a[5]*1
   else
    a[1]:=0;
   a[5]:=0;
  {4}
   inc(ans,a[4]);
   if a[2]>=a[4]*5 then a[2]:=a[2]-a[4]*5
   else
    a[1]:=a[1]-min(a[4]*(6*6-4*4)-a[2]*2*2,a[1]);
   a[4]:=0;
  {3}
   inc(ans,a[3] div 4);
   a[3]:=a[3] mod 4;
   inc(ans);
   case a[3] of
   1:begin
     p:=min(a[2],a[3]*5);
     a[2]:=a[2]-p;
     a[1]:=a[1]-min(a[1],6*6-3*3-p*2*2);
     end;
   2:begin
     p:=min(a[2],a[3]*3);
     a[2]:=a[2]-p;
     a[1]:=a[1]-min(a[1],6*6-3*3*2-p*2*2);
     end;
   3:begin
     p:=min(a[2],a[3]);
     a[2]:=a[2]-p;
     a[1]:=a[1]-min(a[1],6*6-3*3*3-p*2*2);
     end;
   end;
  a[3]:=0;
  {2}
  inc(ans,a[2] div 9);
  a[2]:=a[2] mod 9;
  if a[2]>0 then
   begin
   inc(ans);
   a[1]:=a[1]-min(a[1],6*6-a[2]*4);
   a[2]:=0;
   end;
  {1}
  inc(ans,a[1] div 36);
  a[1]:=a[1] mod 36;
  if a[1]>0 then
   begin
   a[1]:=0;
   inc(ans);
   end;
  writeln(ans);
  for i:=1 to 6 do
   read(a[i]);
 end;

end.