type
 re=record
   x, y: char;
   next: longint;
   al: boolean;
   num: longint;
 end;
var
  ii, test: longint;
  i, j, k, n, m, bl, sum, tot: longint;
  g: array[0..300000] of re;
  first, rank: array['a'..'z'] of longint;
  fa: array['a'..'z'] of char;
  s: array[0..1001] of string;
  ch1, ch2: char;
  flag: boolean;
  r, c: array['a'..'z'] of longint;
  f: array['a'..'z'] of boolean;
  ans: array[0..1991] of string;
procedure ins(xx,yy: char;z: longint);
begin
  inc(tot);
  g[tot].x := xx;
  g[tot].y := yy;
  g[tot].num := z;
  g[tot].al := false;
  g[tot].next := first[xx];
  first[xx] := tot;
end;
function get(x: char): char;
begin
  if fa[x]=x then exit(fa[x]);
  fa[x] := get(fa[x]);
  exit(fa[x]);
end;
procedure merge(x,y: char);
var
  xx, yy: char;
begin
  xx := get(x);
  yy := get(y);
  if xx<>yy then begin
    dec(bl);
    if rank[xx]<rank[yy] then begin
      fa[xx] := yy;
      inc(rank[yy],rank[xx]);
    end else begin
      fa[yy] := xx;
      inc(rank[xx],rank[yy]);
    end;
  end;
end;
procedure search(ch: char);
var
  i, j, k: longint;
begin
  j := first[ch];
  while j<>0 do begin
    if not g[j].al then begin
      k := g[j].num;
      g[j].al := true;
      search(g[j].y);
      ans[sum] := s[k];
      dec(sum);
    end;
    j := g[j].next;
  end;
end;
procedure main;
var
  i, j, k: longint;
  tot1, tot2: longint;
  ch: char;
  st, ed: char;
begin
  tot1 := 0;
  tot2 := 0;
  for ch := 'a' to 'z' do if not f[ch] then dec(bl);
  if bl<>1 then exit;
  for ch := 'a' to 'z' do if f[ch] then begin
    if (abs(r[ch]-c[ch])<>1) and (r[ch]<>c[ch]) then exit;
    if r[ch]-c[ch]=1 then inc(tot1);
    if r[ch]-c[ch]=-1 then inc(tot2);
  end;
  //writeln(tot1,' ',tot2);
  if not (((tot1=1) and (tot2=1)) or ((tot1=0) and (tot2=0))) then exit;
  if tot1=1 then for ch := 'a' to 'z' do begin
    //if r[ch]-c[ch]=1 then ed := ch;
    if c[ch]-r[ch]=1 then st := ch;
  end else for ch := 'a' to 'z' do if c[ch]<>0 then begin
    st := ch;
    break;
  end;
  flag := true;
  sum := n;
  search(st);
end;
procedure qsort(l,r: longint);
var
  i, j: longint;
  k, t: string;
begin
  i := l;
  j := r;
  k := s[(l+r) div 2];
  repeat
    while s[i]>k do inc(i);
    while s[j]<k do dec(j);
    if i<=j then begin
      t := s[i];
      s[i] := s[j];
      s[j] := t;
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;
procedure change(ss: char);
var
  i, j, k: longint;
  ch: char;
  tmp: longint;
begin
  j := first[ss];
  while j<>0 do begin
    k := g[j].next;
    while k<>0 do begin
      if s[g[j].num]>s[g[k].num] then begin
        tmp := g[j].num;
        g[j].num := g[k].num;
        g[k].num := tmp;
        ch := g[j].y;
        g[j].y := g[k].y;
        g[k].y := ch;
      end;
      k := g[k].next;
    end;
    j := g[j].next;
  end;
end;
procedure print(ss: char);
var
  i, j, k: longint;
  ch: char;
begin
  writeln(ss);
  j := first[ss];
  while j<>0 do begin
    writeln(s[g[j].num]);
    j := g[j].next;
  end;
end;
begin

  readln(test);
  for ii := 1 to test do begin
    readln(n);
    fillchar(f,sizeof(f),false);
    fillchar(first,sizeof(first),0);
    fillchar(r,sizeof(r),0);
    fillchar(c,sizeof(c),0);
    for ch1 := 'a' to 'z' do begin
      fa[ch1] := ch1;
      rank[ch1] := 1;
    end;
    for i := 1 to n do readln(s[i]);
    qsort(1,n);
    tot := 0;
    bl := 26;
    for i := 1 to n do begin
      //readln(s[i]);
      ch1 := s[i,1];
      ch2 := s[i,length(s[i])];
      f[ch1] := true;
      f[ch2] := true;
      inc(r[ch2]);
      inc(c[ch1]);
      ins(ch1,ch2,i);
      merge(ch1,ch2);
    end;
  {  for ch1 := 'a' to 'z' do if f[ch1] then begin
      change(ch1);
      print(ch1);
    end;
    writeln;  //}
    flag := false;
    //sum := 0;
    main;
    //writeln(bl);
    if not flag then writeln('***') else begin
      for i := 1 to n-1 do write(ans[i],'.');
      writeln(ans[n]);
    end;   //}
  end;
 
end.