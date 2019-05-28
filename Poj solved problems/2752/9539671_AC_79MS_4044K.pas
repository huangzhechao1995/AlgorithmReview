program poj2752;
 const maxn=400000+100;
 var s:ansistring;
 a,b:array[1..maxn] of char;
 next,ans:array[0..maxn] of longint;

 i,j,n,m,p,q,l,r,k:longint;
 len:longint;
procedure openfile;
 begin
 assign(input,'poj2752.in');
 assign(output,'poj2752.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;

begin

 while not seekeof do
  begin
  readln(s);
  len:=length(s);
  for i:=1 to len do
   a[i]:=s[i];
  //--------------------
  next[1]:=0;
  j:=0;
  for i:=2 to len do
   begin
    while (j>0)and(a[j+1]<>a[i]) do j:=next[j];
    if a[j+1]=a[i] then j:=j+1;
    next[i]:=j;
   end;
 // next[1]:=1;
  //--------------------
  // for i:=1 to len do
  //  b[i]:=s[len-i+1];
  j:=next[len];
  ans[0]:=0;
  while j>0 do
   begin
   inc(ans[0]);
   ans[ans[0]]:=j;
   j:=next[j];
   end;
  for i:=ans[0] downto 1 do
   write(ans[i],' ');
  writeln(len);
  end;

end.
