program poj2774;
 const maxn=200000+100;
 var n,m,i,j,p,q,k,max:longint;
  sum,trk,rk,sa,tsa:array[1..maxn] of longint;
  h:array[1..maxn] of longint;
  s,a,b:ansistring;
 // s:ansistring;
  la,lb:longint;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function rank(x:longint):longint;
 begin
 if x>n then exit(0);
 exit(trk[x]);
 end;
procedure suffix(n:longint);
 begin
 fillchar(sum,sizeof(sum),0);
 m:=255;
 for i:=1 to n do begin trk[i]:=ord(s[i]); inc(sum[trk[i]]); end;
 for i:=2 to m do sum[i]:=sum[i]+sum[i-1];
 for i:=n downto 1 do
  begin sa[sum[trk[i]]]:=i; dec(sum[trk[i]]); end;
 rk[sa[1]]:=1; p:=1;
 for i:=2 to n do
  begin
  if trk[sa[i]]<>trk[sa[i-1]] then inc(p);
  rk[sa[i]]:=p;
  end;
//-------------------------------
 m:=p; j:=1;
 while m<n do
  begin
  move(rk,trk,sizeof(rk));
  fillchar(sum,sizeof(sum),0);  p:=0;
  for i:=n-j+1 to n do
   begin inc(p); tsa[p]:=i; end;
  for i:=1 to n do
   if sa[i]>j then begin inc(p); tsa[p]:=sa[i]-j; end;
{}for i:=1 to n do
   begin rk[i]:=trk[tsa[i]]; inc(sum[rk[i]]); end;
  for i:=2 to m do inc(sum[i],sum[i-1]);
  for i:=n downto 1 do
   begin sa[sum[rk[i]]]:=tsa[i]; dec(sum[rk[i]]); end;
  rk[sa[1]]:=1; p:=1;
  for i:=2 to n do
   begin
   if (trk[sa[i]]<>trk[sa[i-1]])or(rank(sa[i]+j)<>rank(sa[i-1]+j)) then inc(p);
   rk[sa[i]]:=p;
   end;
  m:=p; j:=j shl 1;
  end;
 end;
procedure workheight(n:longint);
 var i,j,p:longint;
 begin
 h[1]:=0; p:=0;
 for i:=1 to n do
  begin
  if rk[i]=1 then continue;
  j:=sa[rk[i]-1];
  while (j+p<=n)and(i+p<=n)and(s[j+p]=s[i+p]) do inc(p);
  h[rk[i]]:=p;
  if p>0 then dec(p);
  end;
 end;

begin
 //openfile;
 readln(a);
 readln(b);
 s:=a+'#'+b;
 la:=length(a); lb:=length(b);
 n:=length(s);
 suffix(n);
 workheight(n);
 max:=0;
 for i:=2 to n do
  begin
  if ((sa[i]>la+1)and(sa[i-1]<=la))or((sa[i]<=la)and(sa[i-1]>la+1))then
   if h[i]>max then max:=h[i];
  end;
 writeln(max);
 //closefile;
end.