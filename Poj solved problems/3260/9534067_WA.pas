program poj3260;
 const maxn=100+10;
 var i,j,n,m,p,q,l,r,k,t:longint;
 v,c:array[1..maxn] of longint;
 f,a,b:array[0..2000000] of int64;
 d:longint;
 maxvalue:longint;
 ans:int64;
procedure openfile;
 begin
 assign(input,'poj3260.in');
 assign(output,'poj3260.out');
 reset(input); rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
begin
 readln(n,t);
 for i:=1 to n do
  read(v[i]);
 for i:=1 to n do
  read(c[i]);
 for i:=1 to n do
  maxvalue:=maxvalue+v[i]*c[i];
 maxvalue:=200000;
 for i:=1 to maxvalue do
  f[i]:=10000000000;
 f[0]:=0;
 for i:=1 to n do
  begin
   q:=c[i];
   if maxvalue div v[i]<q then q:=maxvalue div v[i];
   for d:=0 to v[i]-1 do
    begin
     l:=1; r:=0; a[1]:=0; b[1]:=0;
     for j:=0 to (maxvalue-d)div v[i] do
      begin
      while (l<=r)and(a[r]>=f[d+j*v[i]]-j) do dec(r);
      inc(r); a[r]:=f[d+j*v[i]]-j; b[r]:=j;
      while (l<=r)and(j-b[l]>q) do  inc(l);
      f[j*v[i]+d]:=a[l]+j;
      end;
    end;
  end;
 ans:=maxlongint;
 for i:=t to maxvalue do
  begin
  if f[i]+f[i-t]<=ans then ans:=f[i]+f[i-t];
  end;
 writeln(ans);

end.