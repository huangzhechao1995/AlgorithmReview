program poj3693;
 const maxn=100000*2+100;
 var s,s1:ansistring;
     h,sa,trk,sum,rk,tsa:array[1..maxn] of longint;
     cir,situation:longint;
     i,j,m,n,p,k,l,r,len,nn:longint;
     f:array[1..maxn,0..20] of longint;
     er:array[0..20] of longint;
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
 if x>nn then exit(0); exit(trk[x]);
 end;
function min(a,b:longint):longint;
 begin
 if a<b then exit(a);
 exit(b);
 end;
procedure ST(n:longint);
 var i,j,p,k,l:longint;
 begin
// fillchar(f,sizeof(f),0);
 for i:=0 to 20 do
  er[i]:=1 shl i;
 for i:=1 to n do
  f[i,0]:=h[i];
 for k:=1 to trunc(ln(n)/ln(2)) do
  for i:=1 to n-er[k]+1 do
   f[i,k]:=min(f[i,k-1],f[i+er[k-1],k-1]);
 end;
function ask(l,r:longint):longint;
 var i,j,p:longint;
 begin
 if l>r then
  begin
  p:=r; r:=l; l:=p;
  end;
 l:=l+1;
 ask:=0;
 p:=trunc(ln(r-l+1)/ln(2));
 ask:=min(f[l,p],f[r+1-er[p],p]);
 end;
procedure suffix;
 begin
 fillchar(sum,sizeof(sum),0);
 m:=255;
 for i:=1 to nn do begin trk[i]:=ord(s[i]); inc(sum[trk[i]]); end;
 for i:=2 to m do inc(sum[i],sum[i-1]);
 for i:=nn downto 1 do
  begin sa[sum[trk[i]]]:=i; dec(sum[trk[i]]); end;
 p:=1; rk[sa[1]]:=1;
 for i:=2 to nn do
  begin
  if trk[sa[i]]<>trk[sa[i-1]] then inc(p);
  rk[sa[i]]:=p;
  end;
//------------
 m:=p; j:=1;
 while m<nn do
  begin
  move(rk,trk,sizeof(rk));
  fillchar(sum,sizeof(sum),0);
  p:=0;
  for i:=nn-j+1 to nn do begin inc(p); tsa[p]:=i; end;
  for i:=1 to nn do if sa[i]>j then
   begin inc(p); tsa[p]:=sa[i]-j; end;
  for i:=1 to nn do
   begin rk[i]:=trk[tsa[i]]; inc(sum[rk[i]]); end;
  for i:=2 to m do inc(sum[i],sum[i-1]);
  for i:=nn downto 1 do
   begin sa[sum[rk[i]]]:=tsa[i]; dec(sum[rk[i]]); end;
  p:=1; rk[sa[1]]:=1;
  for i:=2 to nn do
   begin
   if (trk[sa[i]]<>trk[sa[i-1]])or(rank(sa[i]+j)<>rank(sa[i-1]+j)) then inc(P);
   rk[sa[i]]:=p;
   end;
  m:=p; j:=j*2;
  end;
 end;
procedure workheight;
 begin
 h[1]:=1; p:=0;
 for i:=1 to nn do
  begin
  if rk[i]=1 then continue;
  j:=sa[rk[i]-1];
  while s[i+p]=s[j+p] do inc(p);
  h[rk[i]]:=p;
  if p>0 then dec(p);
  end;
 end;
procedure main;
 var k1,k2,kk,maxkk,maxk,maxj:longint;
 begin
 suffix;
 workheight;
 ST(nn);
 maxj:=sa[nn];
 maxk:=1; maxkk:=1; maxj:=1;
 for i:=1 to n do
  if s[i]<s[maxj] then maxj:=i;
 for len:=1 to n do
 // if n mod len=0 then
  begin
  i:=1;
  j:=i+len;
  while j<=n do
   begin
   k2:=ask(rk[nn-i+1],rk[nn-j+1]) div len;
   k1:=(ask(rk[i],rk[j]));
   if k2<>0 then dec(k1); k1:=k1 div len;
   if k1<0 then k1:=0;
   k:=k1+k2+1;// if kk<0 then kk:=0;
  // k:=kk div len+1;
   kk:=k2*len; if kk=0 then kk:=1;
   if (k>maxk)or(k=maxk)and(rk[i-kk+1]<rk[maxj]) then
    begin
    maxk:=k; maxj:=i-kk+1; maxkk:=k*len;
    end;
   i:=j; j:=i+len;
   end;
  end;
  write('Case ',cir,': ');
  for i:=maxj to maxj+maxkk-1 do
   write(s[i]);
  writeln;
 end;
begin
 //openfile;
 readln(s);
 while s<>'#' do
  begin
  inc(cir);
  n:=length(s);
  s1:='';
  for i:=n downto 1 do
   s1:=s1+s[i];
  s:=s+'#'+s1;
  nn:=n*2+1;
  main;
  readln(s);
  end;
 //closefile;
end.
