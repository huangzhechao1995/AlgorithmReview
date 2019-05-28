program poj2406;
 const maxn=1000000+1000;
 var i,j,n,m,p,q,l,r:longint;
 s:ansistring;
 a:array[1..maxn] of char;
 pre:array[1..maxn] of longint;
procedure openfile;
 begin
 assign(input,'poj2406.in');
 assign(output,'poj2406.out');
 reset(input); rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
begin

 readln(s);
 while s<>'.' do
  begin
  l:=length(s);
  for i:=1 to l do
   a[i]:=s[i];
  pre[1]:=0;
  j:=0;
  for i:=2 to l do
   begin
   while (j>0)and(a[j+1]<>a[i]) do j:=pre[j];
   if a[j+1]=a[i] then inc(j);
   pre[i]:=j;
   end;
  if pre[l]mod(l-pre[l])=0 then writeln(l div (l-pre[l]))
   else writeln(1);
  readln(s);
  end;

end.
