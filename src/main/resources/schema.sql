CREATE TABLE IF NOT EXISTS users
(
    id       BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    fullname VARCHAR(128)                            NOT NULL,
    username VARCHAR(64)                             NOT NULL,
    email    VARCHAR(128)                            NOT NULL,
    password varchar(256)                            NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (id),
    CONSTRAINT UQ_USER_USERNAME UNIQUE (username),
    CONSTRAINT UQ_USER_EMAIL UNIQUE (email),
    CONSTRAINT UQ_USER_PASSWORD UNIQUE (password)
);

CREATE TABLE IF NOT EXISTS roles
(
    id   INTEGER GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    role VARCHAR(64)                              NOT NULL,
    CONSTRAINT pk_roles PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users_roles
(
    user_id BIGINT  NOT NULL,
    role_id INTEGER NOT NULL,
    CONSTRAINT fk_users_roles_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_users_roles_role_id FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE,
    CONSTRAINT pk_users_roles PRIMARY KEY (user_id, role_id)
);

CREATE INDEX IF NOT EXISTS fk_users_roles_index_user_id ON users_roles (user_id);
CREATE INDEX IF NOT EXISTS fk_users_roles_index_role_id ON users_roles (role_id);

CREATE TABLE IF NOT EXISTS tasks
(
    id           BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    heading      VARCHAR(128)                            NOT NULL,
    description  VARCHAR(1024)                           NOT NULL,
    created_date TIMESTAMP,
    deadline     TIMESTAMP,
    status       VARCHAR(64)                             NOT NULL,
    priority     VARCHAR(64)                             NOT NULL,
    author_id    BIGINT                                  NOT NULL,
    CONSTRAINT pk_tasks PRIMARY KEY (id),
    CONSTRAINT fk_tasks_author_id FOREIGN KEY (author_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS fk_tasks_index_author_id ON tasks (author_id);

CREATE TABLE IF NOT EXISTS tasks_users
(
    task_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    CONSTRAINT fk_tasks_users_task_id FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE,
    CONSTRAINT fk_tasks_users_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT pk_tasks_users PRIMARY KEY (task_id, user_id)
);

CREATE INDEX IF NOT EXISTS fk_tasks_users_index_task_id ON tasks_users (task_id);
CREATE INDEX IF NOT EXISTS fk_tasks_users_index_user_id ON tasks_users (user_id);