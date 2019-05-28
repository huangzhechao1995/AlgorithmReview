const a:array['A'..'Z'] of char=('2','2','2','3','3','3','4','4','4','5','5','5','6','6','6','7','7','7','7','8','8','8','9','9','9','9');
var dic,dic1:array[1..100] of string;
    s,fs:string;
    i,j,k,l,m,n,p,q:longint;
    ch:char;
function count(s1,s2:string):longint;
var i:longint;
    fus:string;
begin
 count:=0;
 fus:=copy(s1,1,length(s2));
 for i:=1 to length(s2) do
  if s2[i]<>fus[i] then
   inc(count);
end;
function min(x,y:string):boolean;
var i,len:longint;
begin
 len:=length(x);
 if len>length(y) then
  len:=length(y);
 for i:=1 to len do
  if x[i]>y[i] then
   exit(false)
   else
    if x[i]<y[i] then exit(true);
 if length(x)<length(y) then exit(true)
 else exit(false);
end;
procedure qsort(l,r:longint);
var i,j:longint;
    mid,temp:string;
begin
 i:=l;
 j:=r;
 mid:=dic[(i+j) div 2];
 repeat
  while min(dic[i],mid) do inc(i);
  while min(mid,dic[j]) do dec(j);
  if i<=j then
   begin
    temp:=dic[i];
    dic[i]:=dic[j];
    dic[j]:=temp;
    inc(i);
    dec(j);
   end;
 until i>j;
 if i<r then qsort(i,r);
 if l<j then qsort(l,j);
end;
begin
 readln(n);
 for i:=1 to n do
  readln(dic[i]);
 readln(s);
 qsort(1,n);
 dic1:=dic;
 for i:=1 to n do
  begin
   l:=length(dic[i]);
   for j:=1 to l do
    dic[i][j]:=a[dic[i][j]];
  end;
 for i:=1 to n do
  if s=dic[i] then
   writeln(dic1[i]);
 for i:=1 to n do
  if (s<>dic[i]) and (pos(s,dic[i])=1) then
   writeln(dic1[i]);
 l:=length(s);
 for i:=1 to n do
  begin
   if (dic[i]<>s) and (length(dic[i])=length(s)) then
    if count(dic[i],s)=1 then
     writeln(dic1[i]);
  end;
 for i:=1 to n do
  begin
   if (dic[i]<>s) and (length(dic[i])>length(s)) then
    if count(dic[i],s)=1 then
     writeln(dic1[i]);
  end;
end.
