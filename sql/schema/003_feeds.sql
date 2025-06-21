-- +goose up

CREATE TABLE feeds (
    id uuid primary key,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null,
    user_id uuid not null references users(id) on delete cascade,
    title text not null,
    url text not null unique,
    description text,
    image_url text,
    last_updated timestamptz
);

-- +goose down

DROP TABLE feeds;