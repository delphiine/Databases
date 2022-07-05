TRUNCATE TABLE books RESTART IDENTITY;

INSERT INTO books (id, title, author_name) VALUES (1, 'Nineteen Eighty-Four', 'George Orwell');
INSERT INTO books (id, title, author_name) VALUES (2, 'Mrs Dalloway', 'Virginia Woolf');