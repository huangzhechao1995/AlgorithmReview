program corral;
 const maxn=600;
       xx=1; yy=2;
 var i,j,n,m,p,q,l,r,k,mid,biggest:longint;
 d:array[1..2,0..10000] of longint;
 w:array[1..2,0..maxn] of longint;
 rar:array[1..2,0..maxn] of longint;
 b:array[1..maxn,1..2] of longint;
 a,s:array[0..maxn,0..maxn] of longint;
 len:array[1..2] of longint;
procedure openfile;
 begin
 assign(input,'poj3179.in');
 assign(output,'poj3179.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure qsort(x,l,r:longint);
 var i,j:longint; t,m:longint;
 begin
 i:=l; j:=r; m:=rar[x][(l+r)div 2];
 repeat
  while rar[x][i]<m do inc(i);
  while rar[x][j]>m do dec(j);
  if i<=j then
   begin
   t:=rar[x][i]; rar[x][i]:=rar[x][j]; rar[x][j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(x,l,j);
 if i<r then qsort(x,i,r);
 end;

procedure number(k:longint);
 var i,j,p:longint;
 begin
 i:=1; j:=0;
 while i<=n do
  begin
  inc(j); d[k][rar[k][i]]:=j; w[k,j]:=rar[k][i];
  while rar[k][i]=rar[k][i+1] do inc(i);
  inc(i);
  end;
 len[k]:=j;
 end;
function judge(limit:longint):boolean;
 var l1,l2,r1,r2,i,j:longint;
   best:longint;
 begin
 l1:=1; r1:=1; best:=0;
 while l1<=len[xx] do
  begin
  while (w[xx,r1+1]-w[xx,l1]+1<=limit)and(r1+1<=len[xx]) do inc(r1);
  l2:=1; r2:=1;
  while l2<=len[yy] do
   begin
   while (w[yy,r2+1]-w[yy,l2]+1<=limit)and(r2+1<=len[yy]) do inc(r2);
   if s[r1,r2]-s[l1-1,r2]-s[r1,l2-1]+s[l1-1,l2-1]>best then
    best:=s[r1,r2]-s[l1-1,r2]-s[r1,l2-1]+s[l1-1,l2-1];
   inc(l2);
   end;
  inc(l1);
  end;
 if best>=m then exit(true) else exit(false);
 end;
begin
 //openfile;
 readln(m,n);
 for i:=1 to n do
  begin
  read(b[i][xx],b[i][yy]);
  rar[xx][i]:=b[i][xx]; if b[i][xx]>biggest then biggest:=b[i][xx];
  rar[yy][i]:=b[i][yy]; if b[i][yy]>biggest then biggest:=b[i][yy];
  end;
//----------prepare------------
 qsort(xx,1,n);
 qsort(yy,1,n);
 number(xx); number(yy);
 for i:=1 to n do
  begin
  p:=d[xx][b[i][xx]]; q:=d[yy][b[i][yy]];
  inc(a[p,q]);
  end;
 for i:=1 to len[xx] do
  for j:=1 to len[yy] do
   s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1]+a[i,j];
//-----------------------------
 l:=0; r:=biggest;
 while l<r do
  begin
  mid:=(l+r) div 2;
  if judge(mid) then r:=mid
   else l:=mid+1;
  end;
 writeln(l);
 //closefile;
end.