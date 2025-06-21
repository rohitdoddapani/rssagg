-- +goose up

CREATE TABLE feed_follows (
    id uuid primary key,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null,
    user_id uuid not null references users(id) on delete cascade,
    feed_id uuid not null references feeds(id) on delete cascade,
    UNIQUE (user_id, feed_id)
);

-- +goose down

DROP TABLE feed_follows;