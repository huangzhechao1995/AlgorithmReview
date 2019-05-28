program poj2492;
 const maxn=2000;
 var i,j,n,m,l,p,q,r,k:longint;
 father:array[1..2*maxn] of longint;
 t,time:longint;
 x,kx,y,ky:longint;
procedure openfile;
 begin
  assign(input,'poj2492.in');
  assign(output,'poj2492.out');
  reset(input);
  rewrite(output);
  end;
procedure closefile;
 begin
  close(input); close(output);
 end;
function getfather(x:longint):longint;
 begin
 if father[x]=x then
  exit(x);
 father[x]:=getfather(father[x]);
 exit(father[x]);
 end;
procedure work;
 var flag:boolean;
 begin
 readln(n,m);   flag:=true;
  for i:=1 to n do
   father[i]:=i;
  for i:=maxn+1 to maxn+n do
   father[i]:=i;
  for i:=1 to m do
   begin
   readln(l,r);
   x:=getfather(l); y:=getfather(r);
   kx:=getfather(l+maxn); ky:=getfather(r+maxn);
   if (x=y)or(kx=ky) then
    begin
    writeln('Scenario #',time,':');
    writeln('Suspicious bugs found!');
    writeln;
    flag:=false;
   // exit;
    end;
   father[kx]:=y;
   father[ky]:=x;
   end;
 if flag then
  begin
  writeln('Scenario #',time,':');
  writeln('No Suspicious bugs found!');
  writeln;
  end;
 end;
begin

 readln(t);
 for time:=1 to t do
  begin
  work;
  end;

end.
