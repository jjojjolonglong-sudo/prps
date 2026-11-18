-- prps(단편 소설 기획서) 테이블. 2026-11-18 Claude가 커넥터로 실행(다시 실행해도 안전해요).
-- 기획서 한 장 = 한 줄. 로그인한 본인 줄만 읽고 쓸 수 있어요(user_id = auth.uid()).
create table if not exists prps_doc (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null default '',      -- 제목
  genre text not null default '',      -- 장르
  intent text not null default '',     -- 기획의도
  keywords text not null default '',   -- 키워드
  logline text not null default '',    -- 로그라인
  intro text not null default '',      -- 소개글
  c1_name text not null default '', c1 text not null default '',   -- 등장인물 1 (이름 / 설명)
  c2_name text not null default '', c2 text not null default '',   -- 등장인물 2
  c3_name text not null default '', c3 text not null default '',   -- 등장인물 3
  ki text not null default '',         -- 시놉시스 기
  seung text not null default '',      -- 승
  jeon text not null default '',       -- 전
  gyeol text not null default '',      -- 결
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
comment on table prps_doc is 'prps 단편 소설 기획서: 한 줄 = 기획서 한 장';
create index if not exists prps_doc_user_updated on prps_doc (user_id, updated_at desc);
alter table prps_doc enable row level security;
drop policy if exists "own rows" on prps_doc;
create policy "own rows" on prps_doc for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
