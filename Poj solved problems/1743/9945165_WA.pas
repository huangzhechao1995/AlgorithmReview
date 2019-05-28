program poj1743;
 const maxn=20000+100;
 var n,m,i,j,p,q,l,r,k,mid:longint;
  s:array[1..maxn] of longint;
  sum,trk,rk,sa,tsa:array[1..maxn] of longint;
  h:array[1..maxn] of longint;
  max,min:longint;
  flag:boolean;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function rank(x:longint):longint;
 begin
 if x<=n then exit(trk[x]);
 exit(0);
 end;
procedure suffix;
 begin
 fillchar(sum,sizeof(sum),0);
 m:=255;
 for i:=1 to n do begin trk[i]:=s[i]; inc(sum[trk[i]]); end;
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
procedure workheight;
 var i,j,p:longint;
 begin
 h[1]:=0; p:=0;
 for i:=1 to n do
  begin
  if rk[i]=1 then continue;
  j:=sa[rk[i]-1];
  while (j+p<n)and(i+p<n)and(s[j+p]=s[i+p]) do inc(p);
  h[rk[i]]:=p+1;
  if p>0 then dec(p);
  end;
 end;
begin
while not seekeof do
 begin
 readln(n); if n=0 then break;
 read(p);
 for i:=2 to n do
  begin
  read(q); s[i-1]:=q-p+100;
  p:=q;
  end;
 dec(n);
 suffix;
 workheight;
 l:=1; r:=n;
 while l<r do
  begin
  mid:=(l+r+1) shr 1;
  i:=1;
  flag:=false;
  while i<n do
   begin
   max:=sa[i]; min:=sa[i];
   j:=i; while h[j+1]>=mid do
    begin
    inc(j);
    if sa[j]>max then max:=sa[j];
    if sa[j]<min then min:=sa[j];
    end;
   if max-min>mid then begin flag:=true; break; end;
   inc(i);
   end;
  if flag then l:=mid else r:=mid-1;
  end;
 if l>=4 then writeln(l+1) else writeln(0);
 end;
end.