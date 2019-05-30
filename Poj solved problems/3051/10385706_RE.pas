program poj3051;
 const maxn=80+3; maxm=1000+5;
  dx:array[1..4] of longint=(1,0,-1,0);
  dy:array[1..4] of longint=(0,1,0,-1);
 var i,j,n,m,p,q,l,r,k:longint;
 map:array[1..maxn,1..maxm] of longint;
 ans,max:longint;
 ch:char;
procedure openfile;
 begin
 assign(input,'waff.in');
 assign(output,'waff.out');
 reset(input);rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure ff(x,y:longint);
 var i,j,xx,yy:longint;
 begin
 inc(ans);
 for i:=1 to 4 do
  begin
  xx:=x+dx[i]; yy:=y+dy[i];
  if (xx<=0)or(yy<=0)or(xx>n)or(yy>m) then  continue;
  if map[xx,yy]=0 then
   begin
   map[xx,yy]:=1; ff(xx,yy);
   end;
  end;
 end;
begin
 //openfile;
 readln(m,n);
 for i:=1 to n do
  begin
  for j:=1 to m do
   begin
   read(ch);
   if ch='.' then map[i,j]:=1;
   end;
  readln;
  end;
 for i:=1 to n do
  for j:=1 to m do
  begin
  ans:=0;
  if map[i,j]=0 then
   begin map[i,j]:=1;
   ff(i,j);
   end;
  if ans>max then max:=ans;
  end;
 writeln(max);
// closefile;
end.