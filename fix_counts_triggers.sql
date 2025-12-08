-- Trigger to update likes_count in perpustakaan_cerita
create or replace function public.handle_new_like()
returns trigger as $$
begin
  update public.perpustakaan_cerita
  set likes_count = likes_count + 1
  where id = new.story_id;
  return new;
end;
$$ language plpgsql security definer;

create or replace function public.handle_unlike()
returns trigger as $$
begin
  update public.perpustakaan_cerita
  set likes_count = greatest(0, likes_count - 1)
  where id = old.story_id;
  return old;
end;
$$ language plpgsql security definer;

create trigger on_like_created
  after insert on public.perpustakaan_cerita_likes
  for each row execute procedure public.handle_new_like();

create trigger on_like_deleted
  after delete on public.perpustakaan_cerita_likes
  for each row execute procedure public.handle_unlike();


-- Trigger to update comments_count in perpustakaan_cerita
create or replace function public.handle_new_comment()
returns trigger as $$
begin
  update public.perpustakaan_cerita
  set comments_count = comments_count + 1
  where id = new.story_id;
  return new;
end;
$$ language plpgsql security definer;

create or replace function public.handle_deleted_comment()
returns trigger as $$
begin
  update public.perpustakaan_cerita
  set comments_count = greatest(0, comments_count - 1)
  where id = old.story_id;
  return old;
end;
$$ language plpgsql security definer;

create trigger on_comment_created
  after insert on public.perpustakaan_cerita_comments
  for each row execute procedure public.handle_new_comment();

create trigger on_comment_deleted
  after delete on public.perpustakaan_cerita_comments
  for each row execute procedure public.handle_deleted_comment();
