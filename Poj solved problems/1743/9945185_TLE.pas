var n,t,i,j,p,l,r,mid:longint;
    sum:array [0..80005] of longint;
    a,sa,rank,h:array [0..80000] of longint;
    s,ss:array[0..80000,0..4] of longint;
procedure init;
var i,last,now,p:longint;
begin
  fillchar(sum,sizeof(sum),0);
  read(last);
  dec(n);
  for i:=1 to n do
    begin
      read(now);
      a[i]:=now-last;
      last:=now;
    end;
  for i:=1 to n do
    begin
      a[i]:=a[i]+100;
      inc(sum[a[i]]);
    end;
  for i:=1 to 300 do sum[i]:=sum[i]+sum[i-1];
  for i:=1 to n do
    begin
      sa[sum[a[i]]]:=i;
      dec(sum[a[i]]);
    end;
  p:=0;
  for i:=1 to n do
    begin
      if a[sa[i]]<>a[sa[i-1]] then inc(p);
      rank[sa[i]]:=p;
    end;
end;
procedure sort(x:longint);
var i:longint;
begin
  fillchar(sum,sizeof(sum),0);
  for i:=1 to n do inc(sum[s[i,x]]);
  for i:=1 to n do sum[i]:=sum[i-1]+sum[i];
  for i:=n downto 1 do
    begin
      ss[sum[s[i,x]]]:=s[i];
      dec(sum[s[i,x]]);
    end;
  s:=ss;
end;
procedure height;
var i,j,k,t:longint;
begin
  t:=0;
  for i:=1 to n do
    begin
      j:=rank[i];
      if j=1 then continue;
      k:=sa[j-1];
      while (a[i+t]=a[k+t]) and (a[i+t]<>0) and (a[k+t]<>0) do inc(t);
      h[j]:=t;
      if t>0 then dec(t);
    end;
end;
function check(mid:longint):boolean;
var i,max,min:longint;
begin
  check:=false;
  max:=-maxlongint;min:=maxlongint;
  for i:=1 to n do
    begin
      if h[i]>=mid then
        begin
          if sa[i-1]>=max then max:=sa[i-1];
          if sa[i-1]<=min then min:=sa[i-1];
          if sa[i]>=max then max:=sa[i];
          if sa[i]<=min then min:=sa[i];
          if max-min>=mid then exit(true);
        end else
        begin max:=-maxlongint;min:=maxlongint; end;
    end;
end;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'waff.out');
 reset(input);rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
begin
  readln(n);
  while n<>0 do
    begin
      fillchar(sa,sizeof(sa),0);
      fillchar(rank,sizeof(rank),0);
      init;
      t:=1;
      while t<n do
        begin
          for j:=1 to n do
            begin
              s[j,1]:=rank[j];
              s[j,2]:=rank[j+t];
              s[j,3]:=j;
            end;
          sort(2);
          sort(1);
          p:=0;
          for j:=1 to n do
            begin
              if (s[j,1]<>s[j-1,1]) or (s[j,2]<>s[j-1,2]) then inc(p);
              rank[s[j,3]]:=p;
            end;
          t:=t*2;
        end;
      for i:=1 to n do sa[rank[i]]:=i;
      height;
      l:=0;r:=n+1;
      while l+1<r do
        begin
          mid:=(l+r) div 2;
          if check(mid) then l:=mid else r:=mid;
        end;
      if (l+1)>=5 then writeln(l+1) else writeln(0);
      readln(n);
    end;
end.
