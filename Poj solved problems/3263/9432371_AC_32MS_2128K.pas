program poj3253;
 type arr=record
 l,r:longint;
 end;
 const maxn=10000; modd=217621;
 var i,j,n,m,p,q,l,r,k:longint;
 si,sh:longint;
 a,s:array[0..maxn+1000] of longint;
 hash:array[0..modd+100000] of longint;
procedure openfile;
 begin
 assign(input,'poj3263.in');
 assign(output,'poj3263.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure add(x:longint);
 var i:longint;
 begin
 i:=x mod modd;
 while (hash[i]<>0)and(hash[i]<>x) do
  inc(i);
 if hash[i]=0 then hash[i]:=x;
 end;
begin
// openfile;
 readln(n,si,sh,m);
 for i:=1 to m do
  begin
  readln(l,r);
  if l>r then begin l:=l+r; r:=l-r; l:=l-r; end;
  p:=l*maxn+r;
  add(p);
  end;
 for i:=0 to modd+100000 do
  if hash[i]<>0 then
  begin
  l:=hash[i] div 10000; r:=hash[i] mod 10000;
  dec(a[l+1]); inc(a[r]);
  end;
 for i:=1 to n do
  s[i]:=s[i-1]+a[i];
 for i:=1 to n do
  writeln(s[i]-s[si]+sh);

end.