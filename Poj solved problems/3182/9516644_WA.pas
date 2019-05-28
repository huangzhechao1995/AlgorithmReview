program poj3182;
 const dx:array[1..8] of longint=(-1,-1,0,1,1,1,0,-1);
       dy:array[1..8] of longint=(0,1,1,1,0,-1,-1,-1);
    maxn=60; maxm=60;
 var i,j,n,m,p,q,l,r,k:longint;
 a:array[1..maxn] of string;
 f:array[0..1,1..maxn,1..maxn] of longint;
 line:array[1..500000,1..3] of longint;
 sx,sy,x,y:longint;
procedure openfile;
 begin
 assign(input,'poj3182.in');
 assign(output,'poj3182.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure expand(x,y,k:longint);
 var i,j,p,q,nx,ny:longint;
 begin
 for i:=1 to 8 do
  if (x+dx[i]>0)and(x+dx[i]<=n)and(y+dy[i]>0)and(y+dy[i]<=m) then
  begin
  nx:=x+dx[i]; ny:=y+dy[i];
  if a[nx,ny]='X' then continue;
  if a[x,y]='-' then if nx>x then continue;
  if (a[nx,ny]='-')and(k=0) then
   begin
   if f[1,nx,ny]>100000000 then
    begin
    f[1,nx,ny]:=f[0,x,y]+1;
    inc(r); line[r][1]:=nx; line[r][2]:=ny; line[r][3]:=1;
    end;
   continue;
   end;
  if f[k,nx,ny]>100000000 then
   begin
   f[k,nx,ny]:=f[k,x,y]+1;
   inc(r); line[r][1]:=nx; line[r][2]:=ny; line[r][3]:=k;
   end;
  end;
 end;
begin

 readln(n,m);
 for i:=1 to n do
  readln(a[i]);
 for i:=1 to n do
  begin
  for j:=1 to m do
  if a[i][j]='X' then
   begin
   k:=m;
   while a[i][k]<>'X' do begin a[i][k]:='-'; dec(k); end;
   break;
   end;
  if k<>0 then break;
  end;
 for i:=1 to n do
  for j:=1 to m do
  if a[i][j]='*' then begin sx:=i; sy:=j; end;
 fillchar(f,sizeof(f),127);
 l:=1; r:=1; line[1][1]:=sx; line[1][2]:=sy; line[1][3]:=0;
 f[0,sx,sy]:=0;
 while (l<=r)and(f[1][sx,sy]>100000000) do
  begin
  x:=line[l][1]; y:=line[l][2]; k:=line[l][3]; inc(l);
  expand(x,y,k);
  end;
 writeln(f[1][sx,sy]);

end.