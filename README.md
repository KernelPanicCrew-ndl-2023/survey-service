# Description

The idea was to have a system for the main website where the user could answer a survey about his habits so we could evaluate his carbon footprint and then compare it to the other users.

## Models 

This represents a question of the survey
```sql
CREATE TABLE public.questions (
	id uuid NOT NULL,
	"text" text NOT NULL,
	previous varchar(36) NULL,
	"next" varchar(36) NULL,
	inserted_at timestamp(0) NOT NULL,
	updated_at timestamp(0) NOT NULL,
	CONSTRAINT questions_pkey PRIMARY KEY (id)
);
```

This is the model for a possible response to a question. `value` is it's actual text, it has a carbon value that represents the number of Kilograms of CO2 of the choice, and it has a total_answers field to prompt status such as "X% of people chose the same answer as you".
 

```SQL
CREATE TABLE public.answers (
	id uuid NOT NULL,
	carbon_value int4 NOT NULL DEFAULT 0,
	total_answers int4 NULL DEFAULT 0,
	value text NOT NULL,
	question_id uuid NULL,
	inserted_at timestamp(0) NOT NULL,
	updated_at timestamp(0) NOT NULL,
	CONSTRAINT answers_pkey PRIMARY KEY (id)
);
ALTER TABLE public.answers ADD CONSTRAINT answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);
```

This associates an email address with their total carbon footprint. The score is calculated by summing the carbon values of the answers they chose. 
```sql
CREATE TABLE public.users (
	id uuid NOT NULL,
	email varchar(255) NULL,
	score int4 NULL,
	inserted_at timestamp(0) NOT NULL,
	updated_at timestamp(0) NOT NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX index_for_unique_emails ON public.users USING btree (email);
```

## API routes 

```shell
  GET     /api/questions
  GET     /api/questions/:id
  POST    /api/questions
  PATCH   /api/questions/:id
  PUT     /api/questions/:id
  DELETE  /api/questions/:id
  GET     /api/answers
  GET     /api/answers/:id
  POST    /api/answers
  PATCH   /api/answers/:id
  PUT     /api/answers/:id
  DELETE  /api/answers/:id
  GET     /api/answer/:id/choose # to choose an answer
  GET     /api/users
  GET     /api/users/:id
  POST    /api/users
  PATCH   /api/users/:id
  PUT     /api/users/:id
  DELETE  /api/users/:id
  POST    /api/users/compare # to compare the user's score to the average
```



## Retrospective

### Tools used

- Elixir was the language of choice for this project as we were brand new to FP for the most part, from what we saw Elixir was a good language since it has a reputation to be easy to learn, on top of his good ecosystem.

- Phoenix was the framework of choice for this project, because it allowed us to generate redundant code and focus on the logic of the application.

- Ecto was the ORM of choice for this project, because it was the one that came with Phoenix and it was easy to use.

### Techniques

We did not used many FP-specific techniques for this project, indeed because of many unexpected issues (especially because of windows) we had to focus on the logic of the application and not on the FP techniques, plus the code is simple overall and would not benefit many of these patterns, too bad :(.
We used a lot of elixir features such as the piping operator, pattern matching, and the `with` macro.

### Feelings about the experience 

Even though we could not experience the whole FP experience, we still had a lot of fun working on this project, the FP paradigm felt very natural to us as we just could just focus on the logic of the application and not on the implementation details. This, coupled to Elixir and Phoenix, made the development of this project very enjoyable and hassle-free.

# How to run

To start your Phoenix server:

  * Run `docker-compose up` to start the database
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
