program poj3261;
 const maxn=20000+1000; maxvalue=1000050;
 var sa,tsa,rk,trk,h,sum:array[1..maxn] of longint;
     count:array[0..maxvalue] of longint;
  s:array[1..maxn] of longint;
  flag:boolean;
  mid,i,j,m,n,p,q,l,r,k,re:longint;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function rank(x:longint):longint;
 begin
 if x>n then exit(0);
 exit(trk[x]);
 end;
procedure suffix;
 begin
 m:=20001;
 for i:=1 to n do begin trk[i]:=s[i]; inc(sum[trk[i]]); end;
 for i:=2 to m do inc(sum[i],sum[i-1]);
 for i:=n downto 1 do
  begin sa[sum[trk[i]]]:=i; dec(sum[trk[i]]); end;
 rk[sa[1]]:=1; p:=1;
 for i:=2 to n do
  begin
  if trk[sa[i]]<>trk[sa[i-1]] then inc(p);
  rk[sa[i]]:=p;
  end;
 //-----------------------------
 m:=p; j:=1;
 while m<n do
  begin
  move(rk,trk,sizeof(rk));
  p:=0;
  fillchar(sum,sizeof(sum),0);
  for i:=n-j+1 to n do begin inc(p); tsa[p]:=i; end;
  for i:=1 to n do if sa[i]>j then
   begin inc(p); tsa[p]:=sa[i]-j; end;
{}for i:=1 to n do
   begin rk[i]:=trk[tsa[i]]; inc(sum[rk[i]]); end;
  for i:=2 to m do inc(sum[i],sum[i-1]);
  for i:=n downto 1 do
   begin sa[sum[rk[i]]]:=tsa[i]; dec(sum[rk[i]]); end;
  rk[sa[1]]:=1; p:=1;
  for i:=2 to n do
   begin
   if (trk[sa[i]]<>trk[sa[i-1]])or(rank(sa[i]+j)<>rank(sa[i-1]+j)) then
    inc(p);
   rk[sa[i]]:=p;
   end;
  m:=p; j:=j*2;
  end;
 end;
procedure workheight;
 begin
 h[sa[1]]:=0; p:=0;
 for i:=1 to n do
  begin
  if rk[i]=1 then continue;
  j:=sa[rk[i]-1];
  while s[j+p]=s[i+p] do inc(p);
  h[rk[i]]:=p;
  if p>0 then dec(p);
  end;
 end;
begin
 readln(n,re);
 for i:=1 to n do
  begin
  read(s[i]);
  count[s[i]]:=1;
  end;
 p:=0;
 for i:=0 to maxvalue do
  begin
  if count[i]=1 then inc(p);
  count[i]:=p;
  end;
 p:=0;
 for i:=1 to n do
  s[i]:=count[s[i]];
// for i:=1 to n do writeln(s[i]);
 suffix;
// for i:=1 to n do write(sa[i],' ');
 workheight;
 l:=0; r:=n;
 while l<r do
  begin
  mid:=(l+r+1) div 2;
  i:=1; flag:=false;
  while i<=n do
   begin
   j:=i;
   while h[j+1]>=mid do inc(j);
   if j-i+1>=re then flag:=true;
   i:=j+1;
   end;
  if flag then l:=mid else r:=mid-1;
  end;
 writeln(l);
end.
