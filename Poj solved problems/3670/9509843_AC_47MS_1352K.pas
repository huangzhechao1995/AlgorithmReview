program poj3670;
 const maxn=30000+50;
 var i,j,n,m,t:longint;
 a:array[0..maxn] of longint;
 f:array[0..maxn,1..3] of longint;
 ans1,ans2,ans:longint;
procedure openfile;
 begin
 assign(input,'poj3670.in');
 assign(output,'poj3670.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function compare(x,y:longint):longint;
 begin
 if x<>y then exit(1)
  else exit(0);
 end;
function min(a,b:longint):longint;
 begin
 if a<b then exit(a) else exit(b);
 end;
procedure work;
 var i,j,p,q,l,r,k:longint;
 begin
 for i:=1 to n do
  begin
  {1}
  f[i][1]:=f[i-1][1]+compare(a[i],1);
  {2}
  p:=f[i-1][2]+compare(a[i],2);
  q:=f[i-1][1]+compare(a[i],2);
  f[i][2]:=min(p,q);
  {3}
  p:=f[i-1][2]+compare(a[i],3);
  q:=f[i-1][1]+compare(a[i],3);
  f[i][3]:=f[i-1][3]+compare(a[i],3);
  f[i][3]:=min(min(p,q),f[i,3]);
  end;
 ans1:=min(f[n][1],f[n][2]);
 ans1:=min(ans1,f[n][3]);
 end;
begin
// openfile;
 readln(n);
 for i:=1 to n do
  readln(a[i]);
 work;
 ans:=ans1;
 for i:=1 to n div 2 do
  begin
  t:=a[i];
  a[i]:=a[n-i+1];
  a[n-i+1]:=t;
  end;
 work;
 ans:=min(ans,ans1);
 writeln(ans);
 //closefile;
end.