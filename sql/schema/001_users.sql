-- +goose up

CREATE TABLE users (
    id uuid primary key,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null,
    name text not null
);

-- +goose down

DROP TABLE users;