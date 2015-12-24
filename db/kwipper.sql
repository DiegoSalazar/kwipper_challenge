-- When deployed to Heroku, the database owner must be changed here.
-- Change all instances of text "OWNER TO x" to reflect the heroku
-- database username.
-- To find the heroku db user, run bash, load kwipper and run:
-- SELECT u.usename
-- FROM pg_database d
-- JOIN pg_user u ON (d.datdba = u.usesysid)
-- WHERE d.datname = (SELECT current_database());

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

-- CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE comments OWNER TO tmcedmfitfrprp;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    parent_id integer,
    body text NOT NULL,
    "position" integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    raw_body text
);


ALTER TABLE pages OWNER TO tmcedmfitfrprp;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pages_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: post_favorites; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE post_favorites (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE post_favorites OWNER TO tmcedmfitfrprp;

--
-- Name: post_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE post_favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_favorites_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: post_favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE post_favorites_id_seq OWNED BY post_favorites.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE posts OWNER TO tmcedmfitfrprp;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE sessions OWNER TO tmcedmfitfrprp;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sessions_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE submissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    repo character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE submissions OWNER TO tmcedmfitfrprp;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE submissions_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE submissions_id_seq OWNED BY submissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: diego; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(355) NOT NULL,
    hashed_password character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    last_login timestamp without time zone,
    is_admin boolean
);


ALTER TABLE users OWNER TO tmcedmfitfrprp;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: diego
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO tmcedmfitfrprp;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: diego
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY post_favorites ALTER COLUMN id SET DEFAULT nextval('post_favorites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY submissions ALTER COLUMN id SET DEFAULT nextval('submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: diego
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: diego
--

INSERT INTO comments VALUES (1, 2, 2, 'oh hai', '2015-11-13 16:51:30');


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('comments_id_seq', 1, true);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: diego
--

INSERT INTO pages VALUES (5, 'Socket Basics', 'socket-basics', 3, '&lt;h2&gt;What Are Sockets&lt;/h2&gt;

&lt;p&gt;Sockets are how processes talk to each other, be it on the same machine or across a network. There are many types of &lt;a href=&quot;http://en.wikipedia.org/wiki/Network_socket&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Network Sockets&lt;/a&gt; but we&amp;#39;ll be discussing only &lt;a href=&quot;http://www.cs.rutgers.edu/~pxk/rutgers/notes/sockets/&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;TCP Sockets&lt;/a&gt;. The main point of &lt;a href=&quot;http://en.wikipedia.org/wiki/Transmission_Control_Protocol&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;TCP&lt;/a&gt; is to send packets of data through a network while ensuring they get to their destination and without contributing to &lt;a href=&quot;http://en.wikipedia.org/wiki/TCP_congestion-avoidance_algorithm&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;network congestion&lt;/a&gt;. Let&amp;#39;s experiment with a TCP Socket. We&amp;#39;ll start by creating a script that will act as a &lt;a href=&quot;http://ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/TCPServer.html&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;simple pong server&lt;/a&gt; - just a Main Loop that waits for connections on a socket object.&lt;/p&gt;

&lt;p&gt;Open an IRB session with &lt;code&gt;irb -r socket&lt;/code&gt; and then type in:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;server&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;TCPServer&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt; &lt;span class=&quot;mi&quot;&gt;9000&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# bind to port 9000&lt;/span&gt;

&lt;span class=&quot;c1&quot;&gt;# Start the main program loop&lt;/span&gt;
&lt;span class=&quot;kp&quot;&gt;loop&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;client&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;server&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;accept&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# Wait for a client to connect. The accept method will block until this happens&lt;/span&gt;
  &lt;span class=&quot;nb&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;client&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;gets&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# Get the first line of text the client sent&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;client&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;Pong&amp;quot;&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# Write text back through the socket to the client&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;client&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;close&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# Close the socket so the client can stop waiting for more text&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Once you have that running in a terminal window switch to a new one and open a new IRB session with &lt;code&gt;irb -r socket&lt;/code&gt; and type in:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;client&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;TCPSocket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;localhost&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;mi&quot;&gt;9000&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# Connect to that TCP server&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;What we&amp;#39;ve done in these two steps is set up the simplest client/server program ever (almost). Using the &lt;code&gt;client&lt;/code&gt; object you can &lt;code&gt;puts&lt;/code&gt; to the server and &lt;code&gt;gets&lt;/code&gt; the response back. So far, it&amp;#39;s all text and we have it printing out to the console when each byte stream line gets delivered. To see that, do this in your client socket terminal:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;client&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;Ping&amp;quot;&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Now look back at your server terminal and see that it printed out &lt;code&gt;Ping&lt;/code&gt;. Now, back at the client terminal do this: &lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;nb&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;client&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;gets&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;That will print out &lt;code&gt;Pong&lt;/code&gt;. That&amp;#39;s the server&amp;#39;s response! This, at a very low level, is how processes primarily talk to each other over the internet. There are a great many things you can build with sockets such as chat apps - &lt;a href=&quot;http://www.sitepoint.com/ruby-tcp-chat/&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Build a chat application in the terminal&lt;/a&gt;. If you want to learn more about sockets, the ruby docs on &lt;a href=&quot;http://ruby-doc.com/docs/ProgrammingRuby/html/lib_network.html&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Network and Web Libraries&lt;/a&gt; provide greater detail as well as the book &lt;a href=&quot;http://www.jstorimer.com/products/working-with-tcp-sockets&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Working With TCP Sockets&lt;/a&gt;.&lt;/p&gt;

&lt;p&gt;Now, let&amp;#39;s leave the gritty, low-level details of sockets behind and move on to see how &lt;a href=&quot;/tutorials/the-http-protocol&quot; title=&quot;&quot;&gt;HTTP builds on top of TCP&lt;/a&gt;.&lt;/p&gt;', 1, '2015-05-13 01:31:53', '## What Are Sockets

Sockets are how processes talk to each other, be it on the same machine or across a network. There are many types of [Network Sockets](http://en.wikipedia.org/wiki/Network_socket) but we''ll be discussing only [TCP Sockets](http://www.cs.rutgers.edu/~pxk/rutgers/notes/sockets/). The main point of [TCP](http://en.wikipedia.org/wiki/Transmission_Control_Protocol) is to send packets of data through a network while ensuring they get to their destination and without contributing to [network congestion](http://en.wikipedia.org/wiki/TCP_congestion-avoidance_algorithm). Let''s experiment with a TCP Socket. We''ll start by creating a script that will act as a [simple pong server](http://ruby-doc.org/stdlib-1.9.3/libdoc/socket/rdoc/TCPServer.html) - just a Main Loop that waits for connections on a socket object.

Open an IRB session with `irb -r socket` and then type in:

```ruby
server = TCPServer.new 9000 # bind to port 9000

# Start the main program loop
loop do
  client = server.accept # Wait for a client to connect. The accept method will block until this happens
  puts client.gets # Get the first line of text the client sent
  client.puts "Pong" # Write text back through the socket to the client
  client.close # Close the socket so the client can stop waiting for more text
end
```

Once you have that running in a terminal window switch to a new one and open a new IRB session with `irb -r socket` and type in:

```ruby
client = TCPSocket.new "localhost", 9000 # Connect to that TCP server
```

What we''ve done in these two steps is set up the simplest client/server program ever (almost). Using the `client` object you can `puts` to the server and `gets` the response back. So far, it''s all text and we have it printing out to the console when each byte stream line gets delivered. To see that, do this in your client socket terminal:

```ruby
client.puts "Ping"
```

Now look back at your server terminal and see that it printed out `Ping`. Now, back at the client terminal do this: 

```ruby
puts client.gets
```

That will print out `Pong`. That''s the server''s response! This, at a very low level, is how processes primarily talk to each other over the internet. There are a great many things you can build with sockets such as chat apps - [Build a chat application in the terminal](http://www.sitepoint.com/ruby-tcp-chat/). If you want to learn more about sockets, the ruby docs on [Network and Web Libraries](http://ruby-doc.com/docs/ProgrammingRuby/html/lib_network.html) provide greater detail as well as the book [Working With TCP Sockets](http://www.jstorimer.com/products/working-with-tcp-sockets).

Now, let''s leave the gritty, low-level details of sockets behind and move on to see how [HTTP builds on top of TCP](/tutorials/the-http-protocol).');
INSERT INTO pages VALUES (11, 'The Application Object', 'the-application-object', 2, 'The Application Object', 0, '2015-05-13 01:34:42', NULL);
INSERT INTO pages VALUES (12, 'The Controller', 'the-controller', 2, '        The Controller
        ', 1, '2015-05-13 01:35:21', NULL);
INSERT INTO pages VALUES (13, 'Database Interaction', 'database-interaction', 2, 'Database Interaction', 2, '2015-05-13 01:36:06', NULL);
INSERT INTO pages VALUES (14, 'The Model', 'the-model', 2, 'The Model', 3, '2015-05-13 01:36:24', NULL);
INSERT INTO pages VALUES (15, 'Rendering Views', 'rendering-views', 2, 'Rendering Views', 4, '2015-05-13 01:36:43', NULL);
INSERT INTO pages VALUES (16, 'Managing Sessions', 'managing-sessions', 2, 'Managing Sessions', 5, '2015-05-13 01:37:01', NULL);
INSERT INTO pages VALUES (17, 'Authentication', 'authentication', 2, 'Authentication', 6, '2015-05-13 01:37:19', NULL);
INSERT INTO pages VALUES (18, 'Sign Up And Log In/Out', 'sign-up-and-log-in-out', 1, 'Sign Up And Log In/Out', 0, '2015-05-13 01:37:58', NULL);
INSERT INTO pages VALUES (19, 'Managing Users', 'managing-users', 1, 'Managing Users', 1, '2015-05-13 01:38:20', NULL);
INSERT INTO pages VALUES (20, 'Posting Comments', 'posting-comments', 1, 'Posting Comments', 2, '2015-05-13 01:38:38', NULL);
INSERT INTO pages VALUES (21, 'Liking Comments', 'liking-comments', 1, 'Liking Comments', 3, '2015-05-13 01:39:16', NULL);
INSERT INTO pages VALUES (22, 'Comment Replies', 'comment-replies', 1, 'Comment Replies', 4, '2015-05-13 01:39:33', NULL);
INSERT INTO pages VALUES (23, 'Pagination', 'pagination', 1, 'Pagination', 5, '2015-05-13 01:39:57', NULL);
INSERT INTO pages VALUES (2, 'Writing An App Framework', 'writing-an-app-framework', 0, '&lt;div class=&quot;jumbotron&quot;&gt;
  &lt;h1&gt;Writing An App Framework&lt;/h1&gt;

  &lt;p&gt;Coming Soon!&lt;/p&gt;
&lt;/div&gt;', 2, '2015-05-13 00:04:26', NULL);
INSERT INTO pages VALUES (1, 'Implementing App Features', 'implementing-app-features', 0, '&lt;div class=&quot;jumbotron&quot;&gt;
  &lt;h1&gt;Implementing App Features&lt;/h1&gt;

  &lt;p&gt;Coming Soon!&lt;/p&gt;
&lt;/div&gt;', 3, '2015-05-12 23:42:02', NULL);
INSERT INTO pages VALUES (9, 'The HTTP Response', 'the-http-response', 3, '&lt;h1&gt;You Are Looking At The HTTP Response&lt;/h1&gt;

&lt;p&gt;&lt;img src=&quot;http://i.imgur.com/PGed8yK.gif&quot; alt=&quot;Hi&quot; title=&quot;Hii&quot;&gt;&lt;/p&gt;

&lt;p&gt;We&amp;#39;re seeing the rendered representation of it, of course. So let&amp;#39;s open the hood and see the text the server writes to the socket, the same text that will eventually arrive at the browser:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;HTTP&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;1.1&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;200&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;OK&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Content&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;type:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;text&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;plain&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Content&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;length:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;5&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Hello&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;That&amp;#39;s the most basic &lt;a href=&quot;http://www.ntu.edu.sg/home/ehchua/programming/webprogramming/HTTP_Basics.html#http_mesages&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;response&lt;/a&gt; you can send to a browser and have it display &amp;quot;Hello&amp;quot;.  There are &lt;a href=&quot;http://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;many more headers&lt;/a&gt; that can be used to control the interaction between the server and browsers. We might want to &lt;a href=&quot;https://robots.thoughtbot.com/content-compression-with-rack-deflater&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;compress&lt;/a&gt; the HTML document to save bandwidth so we tell the browser what the body is compressed with by setting the header &lt;code&gt;Content-Encoding: gzip\r\n&lt;/code&gt;. A common action to perform is &lt;a href=&quot;http://www.httpwatch.com/httpgallery/redirection/&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;redirection&lt;/a&gt;, we just set the header &lt;code&gt;Location: /new/path\r\n&lt;/code&gt; and the browser will then fire a new GET request to &lt;code&gt;/new/path&lt;/code&gt;. &lt;em&gt;This means redirects incur another round trip across the internets.&lt;/em&gt; &lt;/p&gt;

&lt;p&gt;Redirects are becoming less common though. They were used for telling the browser that a document has moved and what its new location is. This is meaningless in the context of an AJAX call since it&amp;#39;s being issued by a script running in the context of the HTML document, the one which would be replaced by the document at the new location. So there aren&amp;#39;t redirects in &lt;a href=&quot;https://en.wikipedia.org/wiki/Single-page_application&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;SPA&lt;/a&gt;s and server&amp;#39;s &lt;a href=&quot;https://blog.codeship.com/building-a-json-api-with-rails-5/&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;only speak JSON&lt;/a&gt;. What a world.&lt;/p&gt;

&lt;p&gt;Another important header is the almighty &lt;code&gt;Set-Cookie&lt;/code&gt; header. We&amp;#39;ll use this to set the session id and implement Authentication. When we set the header &lt;code&gt;Set-Cookie: session_id=THE_ID; expires=Sat, 16 May 2015 09:43:41 GMT; httponly\r\n&lt;/code&gt; the browser will store that cookie and send it with every subsequent request until the expiration date. Then the browser &lt;a href=&quot;https://media.giphy.com/media/whNK1SAMSQjwQ/giphy.gif&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;eats the cookie&lt;/a&gt;. The &lt;code&gt;httponly&lt;/code&gt; part means that javascript on the browser can&amp;#39;t &lt;a href=&quot;https://www.owasp.org/index.php/HttpOnly#What_is_HttpOnly.3F&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;read its value&lt;/a&gt;. On to the code!&lt;/p&gt;

&lt;p&gt;&lt;div class=&quot;row&quot;&gt;
  &lt;div class=&quot;col-sm-9&quot;&gt;
    &lt;h3&gt;The Response Class&lt;/h3&gt;
  &lt;/div&gt;
  &lt;div class=&quot;col-sm-3&quot;&gt;
    &lt;div class=&quot;alert alert-info pull-right&quot;&gt;
      &lt;span class=&quot;fa fa-github&quot;&gt;&lt;/span&gt;
      See the
      &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/response.rb&quot; target=&quot;_blank&quot;&gt;
        code
        &lt;span class=&quot;fa fa-external-link&quot;&gt;&lt;/span&gt;
      &lt;/a&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
&lt;/p&gt;

&lt;p&gt;This spec is quite a bit bigger than the parser spec. It has more public methods to cover because the &lt;code&gt;Response&lt;/code&gt; class is handling a little more than just the response headers and body. It&amp;#39;s also doing some session related stuff. If this class gets any bigger I&amp;#39;d refactor the session management out into its own object. But for now it&amp;#39;s at a manageable size.&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;describe&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;Response&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#info&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns a string of the HTTP status code and message&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#headers&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns a hash and memoizes it&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;sets the session cookie if it doesn&amp;#39;t exist in the request&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;doesn&amp;#39;t change the session cookie if there&amp;#39;s one in the request&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#set_status&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;takes a symbol and sets the HTTP status code and message&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#current_user&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns a user instance when there&amp;#39;s a user_id in the session&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns nil if there&amp;#39;s no session&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#current_session&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns a session instance when there&amp;#39;s a session cookie in the request&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns nil when theres no session cookie in the request&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#to_http_response&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;outputs the HTTP response string with headers and a nice body&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#session_cookie_value&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;gets the session cookie from the request&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;generates a random session cookie if there&amp;#39;s none in the request&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#remove_session_cookie&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;sets a session cookie destroyer in the response headers&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;&lt;em&gt;Check out the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/response_spec.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;spec implementation here.&lt;/a&gt;&lt;/em&gt;&lt;/p&gt;

&lt;h3&gt;The HTTP Response Text&lt;/h3&gt;

&lt;p&gt;The &lt;code&gt;Response&lt;/code&gt; instance&amp;#39;s primary method is &lt;code&gt;to_http_response&lt;/code&gt;. This is what the server calls to get the text it writes to the socket. This method serializes the headers and appends them to the status line &lt;code&gt;HTTP/1.1 200 OK\r\n&lt;/code&gt;. The Application will have set a body on the Response and that too will be appended to the string returned by this method.&lt;/p&gt;

&lt;p&gt;So, it basically returns the result of &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/response.rb#L24-L31&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;this string interpolation&lt;/a&gt;:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;o&quot;&gt;&amp;lt;&amp;lt;-&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;HTTP&lt;/span&gt;
&lt;span class=&quot;sh&quot;&gt;HTTP/1.1 #{status_code} #{status_message}\r\n&lt;/span&gt;
&lt;span class=&quot;sh&quot;&gt;#{serialize_headers}\r\n&lt;/span&gt;
&lt;span class=&quot;sh&quot;&gt;\r\n&lt;/span&gt;
&lt;span class=&quot;sh&quot;&gt;#{body}&lt;/span&gt;
&lt;span class=&quot;no&quot;&gt;HTTP&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;The &lt;code&gt;&amp;lt;&amp;lt;-HTTP&lt;/code&gt; part is a Ruby &lt;a href=&quot;http://en.wikipedia.org/wiki/Here_document&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;heredoc&lt;/a&gt;, a string that we&amp;#39;re interpolating some values into: the &lt;code&gt;status_code&lt;/code&gt; and &lt;code&gt;status_message&lt;/code&gt; e.g. &amp;quot;200 OK&amp;quot;. Then we serialize the headers, each on it&amp;#39;s own line with header keys separated from their values by a semi-colon space &amp;quot;; &amp;quot;. Finally, after a &lt;code&gt;\r\n&lt;/code&gt;, we append the body which can be anything from an HTML or JSON document to the file data that makes up a JPG or PDF.&lt;/p&gt;

&lt;p&gt;Here&amp;#39;s a concrete example of what the response text may look like:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;HTTP&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;1.1&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;200&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;OK&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Content&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;Length:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;20084&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Content&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;Type:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;text&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;html&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;o&quot;&gt;&amp;lt;!&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;DOCTYPE&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;html&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;&amp;gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;o&quot;&gt;&amp;lt;&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;html&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;lang&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;=\&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;en\&amp;quot;&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;&amp;gt;\&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;n&lt;/span&gt;
&lt;span class=&quot;o&quot;&gt;...&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;more&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;html&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;...&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;&lt;em&gt;Note: inspecting that string in the code won&amp;#39;t actually show the &lt;code&gt;\r\n&lt;/code&gt; characters, they are just displayed here for clarity.&lt;/em&gt;&lt;/p&gt;

&lt;h3&gt;Response Headers&lt;/h3&gt;

&lt;p&gt;We&amp;#39;ll initialize a hash to keep our headers in. The Application will need access to this object to set headers as it does its work. &lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;headers&lt;/span&gt;
  &lt;span class=&quot;vi&quot;&gt;@headers&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;||=&lt;/span&gt; &lt;span class=&quot;p&quot;&gt;{}&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;tap&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;h&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;h&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;[&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;Set-Cookie&amp;quot;&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;]&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;session_cookie&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;unless&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;has_session?&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Since we&amp;#39;re stuffing session management stuff in this class, we&amp;#39;ll add the &lt;code&gt;Set-Cookie&lt;/code&gt; header by default unless there&amp;#39;s a session cookie already present in the request headers. If that cookie is in the request, that means we&amp;#39;ve previously issued the &lt;code&gt;Set-Cookie&lt;/code&gt; header with a new session id in it. &lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;serialize_headers&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;headers&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;merge&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;({&lt;/span&gt;
    &lt;span class=&quot;s2&quot;&gt;&amp;quot;Content-Length&amp;quot;&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&amp;gt;&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;body&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;size&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt;
    &lt;span class=&quot;s2&quot;&gt;&amp;quot;Content-Type&amp;quot;&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&amp;gt;&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;content_type&lt;/span&gt;
  &lt;span class=&quot;p&quot;&gt;})&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;tap&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;h&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;add_location_header&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;h&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;if&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;redirect&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;map&lt;/span&gt; &lt;span class=&quot;p&quot;&gt;{&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;k&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;v&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;|&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;k&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;: &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;v&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt; &lt;span class=&quot;p&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;join&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;se&quot;&gt;\r\n&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;When we serialize the headers we automatically set the &lt;code&gt;Content-Length&lt;/code&gt; header to the &lt;code&gt;body.size&lt;/code&gt; as well as set the &lt;code&gt;Content-Type&lt;/code&gt; header, which was set by the Application. It&amp;#39;s also a good time to check if the Application wants to issue a redirect. If the &lt;code&gt;redirect&lt;/code&gt; value was set we add the &lt;code&gt;Location&lt;/code&gt; header to its value. Finally, we format the headers string to conform to the &lt;a href=&quot;http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;HTTP Header Field Definition&lt;/a&gt;.&lt;/p&gt;

&lt;h3&gt;The Session Cookie&lt;/h3&gt;

&lt;p&gt;It is the &lt;code&gt;Response&lt;/code&gt; object&amp;#39;s... response-ability... to set headers and since setting cookies happens via the &lt;code&gt;Set-Cookie&lt;/code&gt; response header, this is where we&amp;#39;ll do  the session cookie related stuff we just mentioned. The life cycle of a session goes like this:&lt;/p&gt;

&lt;ul&gt;
&lt;li&gt;The user makes their first request (no cookie &lt;code&gt;kwipper_session&lt;/code&gt; in the request header&amp;#39;s &lt;code&gt;COOKIE&lt;/code&gt; field)&lt;/li&gt;
&lt;li&gt;The &lt;code&gt;Response&lt;/code&gt; sees that there is no &lt;code&gt;kwipper_session&lt;/code&gt; in the &lt;code&gt;COOKIE&lt;/code&gt; request header so it adds the &lt;code&gt;Set-Cookie&lt;/code&gt; header in the response as &lt;code&gt;Set-Cookie: kwipper_session=THE_ID; expires=Sat, 16 May 2015 09:43:41 GMT; httponly\r\n&lt;/code&gt;&lt;/li&gt;
&lt;li&gt;The browser receives that header and writes it to a local cookie&lt;/li&gt;
&lt;li&gt;The user makes a subsequent request (now there is a &lt;code&gt;kwipper_session&lt;/code&gt; cookie in the request headers)&lt;/li&gt;
&lt;li&gt;The &lt;code&gt;Application&lt;/code&gt; can now use this session id to query for information pertaining to this session. e.g. save the session id and user id to a persistent data store and retrieve it on each request to see who&amp;#39;s logged in.&lt;/li&gt;
&lt;/ul&gt;

&lt;p&gt;We&amp;#39;ll talk about session data and persistence later in &lt;a href=&quot;/tutorials/managing-sessions&quot; title=&quot;&quot;&gt;Managing Sessions&lt;/a&gt;. Next up we&amp;#39;ll talk about how to &lt;a href=&quot;/tutorials/the-server-log&quot; title=&quot;&quot;&gt;log request data and why it&amp;#39;s important.&lt;/a&gt;&lt;/p&gt;', 4, '2015-05-13 01:33:44', '# You Are Looking At The HTTP Response

![Hi](http://i.imgur.com/PGed8yK.gif "Hii")

We''re seeing the rendered representation of it, of course. So let''s open the hood and see the text the server writes to the socket, the same text that will eventually arrive at the browser:

```
HTTP/1.1 200 OK
Content-type: text/plain\r\n
Content-length: 5\r\n
\r\n
Hello
```

That''s the most basic [response](http://www.ntu.edu.sg/home/ehchua/programming/webprogramming/HTTP_Basics.html#http_mesages) you can send to a browser and have it display "Hello".  There are [many more headers](http://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields) that can be used to control the interaction between the server and browsers. We might want to [compress](https://robots.thoughtbot.com/content-compression-with-rack-deflater) the HTML document to save bandwidth so we tell the browser what the body is compressed with by setting the header `Content-Encoding: gzip\r\n`. A common action to perform is [redirection](http://www.httpwatch.com/httpgallery/redirection/), we just set the header `Location: /new/path\r\n` and the browser will then fire a new GET request to `/new/path`. _This means redirects incur another round trip across the internets._ 

Redirects are becoming less common though. They were used for telling the browser that a document has moved and what its new location is. This is meaningless in the context of an AJAX call since it''s being issued by a script running in the context of the HTML document, the one which would be replaced by the document at the new location. So there aren''t redirects in [SPA](https://en.wikipedia.org/wiki/Single-page_application)s and server''s [only speak JSON](https://blog.codeship.com/building-a-json-api-with-rails-5/). What a world.

Another important header is the almighty `Set-Cookie` header. We''ll use this to set the session id and implement Authentication. When we set the header `Set-Cookie: session_id=THE_ID; expires=Sat, 16 May 2015 09:43:41 GMT; httponly\r\n` the browser will store that cookie and send it with every subsequent request until the expiration date. Then the browser [eats the cookie](https://media.giphy.com/media/whNK1SAMSQjwQ/giphy.gif). The `httponly` part means that javascript on the browser can''t [read its value](https://www.owasp.org/index.php/HttpOnly#What_is_HttpOnly.3F). On to the code!

[github-link](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/response.rb "The Response Class")

This spec is quite a bit bigger than the parser spec. It has more public methods to cover because the `Response` class is handling a little more than just the response headers and body. It''s also doing some session related stuff. If this class gets any bigger I''d refactor the session management out into its own object. But for now it''s at a manageable size.

```ruby
describe Kwipper::Response do
  context "#info" do
    it "returns a string of the HTTP status code and message"
  end

  context "#headers" do
    it "returns a hash and memoizes it"
    it "sets the session cookie if it doesn''t exist in the request"
    it "doesn''t change the session cookie if there''s one in the request"
  end

  context "#set_status" do
    it "takes a symbol and sets the HTTP status code and message"
  end

  context "#current_user" do
    it "returns a user instance when there''s a user_id in the session"
    it "returns nil if there''s no session"
  end

  context "#current_session" do
    it "returns a session instance when there''s a session cookie in the request"
    it "returns nil when theres no session cookie in the request"
  end

  context "#to_http_response" do
    it "outputs the HTTP response string with headers and a nice body"
  end

  context "#session_cookie_value" do
    it "gets the session cookie from the request"
    it "generates a random session cookie if there''s none in the request"
  end

  context "#remove_session_cookie" do
    it "sets a session cookie destroyer in the response headers"
  end
end
```

_Check out the [spec implementation here.](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/response_spec.rb)_

### The HTTP Response Text

The `Response` instance''s primary method is `to_http_response`. This is what the server calls to get the text it writes to the socket. This method serializes the headers and appends them to the status line `HTTP/1.1 200 OK\r\n`. The Application will have set a body on the Response and that too will be appended to the string returned by this method.

So, it basically returns the result of [this string interpolation](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/response.rb#L24-L31):

```ruby
<<-HTTP
HTTP/1.1 #{status_code} #{status_message}\r\n
#{serialize_headers}\r\n
\r\n
#{body}
HTTP
```

The `<<-HTTP` part is a Ruby [heredoc](http://en.wikipedia.org/wiki/Here_document), a string that we''re interpolating some values into: the `status_code` and `status_message` e.g. "200 OK". Then we serialize the headers, each on it''s own line with header keys separated from their values by a semi-colon space "; ". Finally, after a `\r\n`, we append the body which can be anything from an HTML or JSON document to the file data that makes up a JPG or PDF.

Here''s a concrete example of what the response text may look like:

```
HTTP/1.1 200 OK\r\n
Content-Length: 20084\r\n
Content-Type: text/html\r\n
\r\n
<!DOCTYPE html>\n
<html lang=\"en\">\n
...more html...
```
_Note: inspecting that string in the code won''t actually show the `\r\n` characters, they are just displayed here for clarity._

### Response Headers

We''ll initialize a hash to keep our headers in. The Application will need access to this object to set headers as it does its work. 

```ruby
def headers
  @headers ||= {}.tap do |h|
    h["Set-Cookie"] = session_cookie unless has_session?
  end
end
```

Since we''re stuffing session management stuff in this class, we''ll add the `Set-Cookie` header by default unless there''s a session cookie already present in the request headers. If that cookie is in the request, that means we''ve previously issued the `Set-Cookie` header with a new session id in it. 

```ruby
def serialize_headers
  headers.merge({
    "Content-Length" => body.size,
    "Content-Type" => content_type
  }).tap do |h|
    add_location_header h if redirect
  end.map { |k, v| "#{k}: #{v}" }.join "\r\n"
end
```

When we serialize the headers we automatically set the `Content-Length` header to the `body.size` as well as set the `Content-Type` header, which was set by the Application. It''s also a good time to check if the Application wants to issue a redirect. If the `redirect` value was set we add the `Location` header to its value. Finally, we format the headers string to conform to the [HTTP Header Field Definition](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html).

### The Session Cookie

It is the `Response` object''s... response-ability... to set headers and since setting cookies happens via the `Set-Cookie` response header, this is where we''ll do  the session cookie related stuff we just mentioned. The life cycle of a session goes like this:

 - The user makes their first request (no cookie `kwipper_session` in the request header''s `COOKIE` field)
 - The `Response` sees that there is no `kwipper_session` in the `COOKIE` request header so it adds the `Set-Cookie` header in the response as `Set-Cookie: kwipper_session=THE_ID; expires=Sat, 16 May 2015 09:43:41 GMT; httponly\r\n`
 - The browser receives that header and writes it to a local cookie
 - The user makes a subsequent request (now there is a `kwipper_session` cookie in the request headers)
 - The `Application` can now use this session id to query for information pertaining to this session. e.g. save the session id and user id to a persistent data store and retrieve it on each request to see who''s logged in.

We''ll talk about session data and persistence later in [Managing Sessions](/tutorials/managing-sessions). Next up we''ll talk about how to [log request data and why it''s important.](/tutorials/the-server-log)');
INSERT INTO pages VALUES (24, 'Introduction', 'introduction', 0, '&lt;div class=&quot;jumbotron&quot;&gt;
  &lt;h1&gt;Introduction&lt;/h1&gt;

&lt;blockquote class=&quot;imgur-embed-pub&quot; lang=&quot;en&quot; data-id=&quot;noTX0Jl&quot;&gt;&lt;a href=&quot;//imgur.com/noTX0Jl&quot;&gt;View post on imgur.com&lt;/a&gt;&lt;/blockquote&gt;&lt;script async src=&quot;//s.imgur.com/min/embed.js&quot; charset=&quot;utf-8&quot;&gt;&lt;/script&gt;

  &lt;p&gt;
    This tutorial explains in great detail how I built my solution. It&#39;s split up into three levels. In the first, I dive into the Web Server code and describe sockets and the HTTP protocol. The second level is about building a minimal MVC framework from which we can build our web app including database interaction. Finally, I&#39;ll explain my process of implementing features such as commenting, liking, pagination and more.
  &lt;/p&gt;
&lt;/div&gt;

&lt;h2&gt;Who is this tutorial for?&lt;/h2&gt;

&lt;p&gt;Junior web developers from beginning to intermediate who want to gain a foundational understanding of how web servers and apps work and how frameworks are built. We&amp;#39;ll dive deep into common web technologies and peel back the &amp;quot;magic&amp;quot; that frameworks like Rails offer us. We&amp;#39;ll learn how to talk to TCP sockets, the database, and render dynamic views via a simple routing mechanism.&lt;/p&gt;

&lt;p&gt;I&amp;#39;ll describe object by object and each line of code how and why I implemented this web app from scratch including all the user facing features you see here. From the minimal CMS used to author each tutorial page to the full text search at the top. I&amp;#39;ll assume you have some knowledge of Ruby or at least some programming experience and want to learn about the underpinnings of a web application. The code examples will be mostly Ruby with some Bash and Javascript mixed in, though the backend concepts will be common to other languages.&lt;/p&gt;

&lt;h2&gt;Who are you?&lt;/h2&gt;

&lt;p&gt;Good question. I&amp;#39;m &lt;a href=&quot;https://github.com/DiegoSalazar&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Diego Salazar&lt;/a&gt;. I&amp;#39;m a software engineer and I work at &lt;a href=&quot;http://kipusystems.com&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Kipu Systems&lt;/a&gt;. I&amp;#39;ve been writing code since 2006 and designing APIs and web service architecture since 2011. I have a passion for beautiful code and well built systems. I also love teaching, making useful analogies, and cheesy puns. Feel free to massage me and if you have questions or comments about this project. My email is on &lt;a href=&quot;https://github.com/DiegoSalazar&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Github&lt;/a&gt;.&lt;/p&gt;

&lt;h2&gt;Why this tutorial &lt;em&gt;is&lt;/em&gt;&lt;/h2&gt;

&lt;p&gt;I feel that there a lot of beginning and junior web developers that are learning through the codeacademies of the web and bootcamps that teach how to use frameworks to quickly build apps and MVPs. Often, with this approach, developers don&amp;#39;t gain a solid understanding of the building blocks of our framework-built apps and how important it is to master this area so that we may debug, improve, scale and optimize our apps beyond the high level comfort of our controllers, models and &lt;code&gt;rake db:migrate&lt;/code&gt;s. /rant&lt;/p&gt;

&lt;h2&gt;What this tutorial isn&amp;#39;t&lt;/h2&gt;

&lt;p&gt;I don&amp;#39;t intend to cover all the intricacies of TCP, HTTP and production grade Web Servers. The simple implementation in this tutorial is meant only as a demonstration of the basic structure and workings of an overly simplified server. It will be implemented only to adequately serve web pages to your local browser only. DON&amp;#39;T USE THIS SERVER IN PRODUCTION. Ahem, anyway, everything else though, is pretty legit. &lt;/p&gt;

&lt;p&gt;When I get into the Application level details, these are indeed ways to implement real life features in Web Apps. I&amp;#39;ll include the specs I wrote when I implemented each feature and talk about the decisions I made when designing the micro framework. I will also discuss why it&amp;#39;s quite often a better choice to use existing mature frameworks to build real apps. *&lt;em&gt;cough&lt;/em&gt;* Security *&lt;em&gt;cough&lt;/em&gt;*.&lt;/p&gt;

&lt;p&gt;I hope I did this dauntingly complex subject justice. Most of the material I wrote comes from memory but I do my research when it feels hazy. I&amp;#39;ll also provide links to other resources as we go along. Please leave comments (I also implemented the commenting system from scratch!) if you have questions, clarifications and/or corrections. Most sections are fairly independent of each other so you can jump in anywhere you&amp;#39;d like or otherwise start at &lt;a href=&quot;/tutorials/writing-a-web-server&quot; title=&quot;&quot;&gt;the beginning&lt;/a&gt;.&lt;/p&gt;', 0, '2015-05-13 11:32:16', '<div class="jumbotron">
  <h1>Introduction</h1>

<blockquote class="imgur-embed-pub" lang="en" data-id="noTX0Jl"><a href="//imgur.com/noTX0Jl">View post on imgur.com</a></blockquote><script async src="//s.imgur.com/min/embed.js" charset="utf-8"></script>

  <p>
    This tutorial explains in great detail how I built my solution. It''s split up into three levels. In the first, I dive into the Web Server code and describe sockets and the HTTP protocol. The second level is about building a minimal MVC framework from which we can build our web app including database interaction. Finally, I''ll explain my process of implementing features such as commenting, liking, pagination and more.
  </p>
</div>

## Who is this tutorial for?

Junior web developers from beginning to intermediate who want to gain a foundational understanding of how web servers and apps work and how frameworks are built. We''ll dive deep into common web technologies and peel back the "magic" that frameworks like Rails offer us. We''ll learn how to talk to TCP sockets, the database, and render dynamic views via a simple routing mechanism.

I''ll describe object by object and each line of code how and why I implemented this web app from scratch including all the user facing features you see here. From the minimal CMS used to author each tutorial page to the full text search at the top. I''ll assume you have some knowledge of Ruby or at least some programming experience and want to learn about the underpinnings of a web application. The code examples will be mostly Ruby with some Bash and Javascript mixed in, though the backend concepts will be common to other languages.

## Who are you?

Good question. I''m [Diego Salazar](https://github.com/DiegoSalazar). I''m a software engineer and I work at [Kipu Systems](http://kipusystems.com). I''ve been writing code since 2006 and designing APIs and web service architecture since 2011. I have a passion for beautiful code and well built systems. I also love teaching, making useful analogies, and cheesy puns. Feel free to massage me and if you have questions or comments about this project. My email is on [Github](https://github.com/DiegoSalazar).
## Why this tutorial _is_

I feel that there a lot of beginning and junior web developers that are learning through the codeacademies of the web and bootcamps that teach how to use frameworks to quickly build apps and MVPs. Often, with this approach, developers don''t gain a solid understanding of the building blocks of our framework-built apps and how important it is to master this area so that we may debug, improve, scale and optimize our apps beyond the high level comfort of our controllers, models and `rake db:migrate`s. /rant

## What this tutorial isn''t

I don''t intend to cover all the intricacies of TCP, HTTP and production grade Web Servers. The simple implementation in this tutorial is meant only as a demonstration of the basic structure and workings of an overly simplified server. It will be implemented only to adequately serve web pages to your local browser only. DON''T USE THIS SERVER IN PRODUCTION. Ahem, anyway, everything else though, is pretty legit. 

When I get into the Application level details, these are indeed ways to implement real life features in Web Apps. I''ll include the specs I wrote when I implemented each feature and talk about the decisions I made when designing the micro framework. I will also discuss why it''s quite often a better choice to use existing mature frameworks to build real apps. \*_cough_\* Security \*_cough_\*.

I hope I did this dauntingly complex subject justice. Most of the material I wrote comes from memory but I do my research when it feels hazy. I''ll also provide links to other resources as we go along. Please leave comments (I also implemented the commenting system from scratch!) if you have questions, clarifications and/or corrections. Most sections are fairly independent of each other so you can jump in anywhere you''d like or otherwise start at [the beginning](/tutorials/writing-a-web-server).');
INSERT INTO pages VALUES (32, 'The HTTP Request', 'the-http-request', 3, '&lt;h1&gt;The HTTP Request&lt;/h1&gt;

&lt;p&gt;Once parsing is complete we can store all that data in an object we can easily use across our App. Here make make a baby &lt;code&gt;request&lt;/code&gt; object similar to the one you have access to in Rails controllers. Its main responsibility is to store the parsed data and provide helpful methods to provide information about the request to the controllers. Every request that comes into your server - through the TCP socket - will be parsed and a new &lt;code&gt;Request&lt;/code&gt; object will be created and passed to the &lt;code&gt;Application&lt;/code&gt; instance.&lt;/p&gt;

&lt;p&gt;&lt;div class=&quot;row&quot;&gt;
  &lt;div class=&quot;col-sm-9&quot;&gt;
    &lt;h3&gt;The HTTP Parser Class&lt;/h3&gt;
  &lt;/div&gt;
  &lt;div class=&quot;col-sm-3&quot;&gt;
    &lt;div class=&quot;alert alert-info pull-right&quot;&gt;
      &lt;span class=&quot;fa fa-github&quot;&gt;&lt;/span&gt;
      See the
      &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/request.rb&quot; target=&quot;_blank&quot;&gt;
        code
        &lt;span class=&quot;fa fa-external-link&quot;&gt;&lt;/span&gt;
      &lt;/a&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
&lt;/p&gt;

&lt;p&gt;This class will be simple to implement, as you can see from the spec summary:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;nb&quot;&gt;require&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;spec_helper&amp;quot;&lt;/span&gt;

&lt;span class=&quot;n&quot;&gt;describe&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;Request&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#initialize&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;defaults post_data to an empty hash&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;accepts a block yielding itself&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#headers&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# see request_headers_spec for more info&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;is a Hash&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#info&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns a string of the HTTP method and path&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#params&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;merges the query hash and post_data hash and memoizes it&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#cookies&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns a hash&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#content_length&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns an integer&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;&lt;em&gt;Here&amp;#39;s the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/request_spec.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;spec implementation&lt;/a&gt;.&lt;/em&gt;&lt;/p&gt;

&lt;h3&gt;When is a new Request instantiated and populated with the parsed request data?&lt;/h3&gt;

&lt;p&gt;That&amp;#39;s the &lt;a href=&quot;/tutorials/the-http-protocol&quot; title=&quot;&quot;&gt;parser&amp;#39;s job&lt;/a&gt;. It will be instantiating and using &lt;code&gt;Request&lt;/code&gt;&amp;#39;s setter methods as it does its parsing. Go back and check out the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_parser.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;parser source&lt;/a&gt; to see how it does this.&lt;/p&gt;

&lt;p&gt;Once the parser is done, and its &lt;code&gt;parse&lt;/code&gt; method returns the new &lt;code&gt;Request&lt;/code&gt; object with all of the request data in it, the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_server.rb#L25-L29&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;server will pass&lt;/a&gt; that &lt;code&gt;Request&lt;/code&gt; object instance to the &lt;code&gt;Application&lt;/code&gt; to do its job of responding.&lt;/p&gt;', 3, '2015-05-26 15:44:10', '# The HTTP Request

Once parsing is complete we can store all that data in an object we can easily use across our App. Here make make a baby `request` object similar to the one you have access to in Rails controllers. Its main responsibility is to store the parsed data and provide helpful methods to provide information about the request to the controllers. Every request that comes into your server - through the TCP socket - will be parsed and a new `Request` object will be created and passed to the `Application` instance.

[github-link](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/request.rb "The HTTP Parser Class")

This class will be simple to implement, as you can see from the spec summary:

```ruby
require "spec_helper"

describe Kwipper::Request do
  context "#initialize" do
    it "defaults post_data to an empty hash"
    it "accepts a block yielding itself"
  end
  context "#headers" do # see request_headers_spec for more info
    it "is a Hash"
  end
  context "#info" do
    it "returns a string of the HTTP method and path"
  end
  context "#params" do
    it "merges the query hash and post_data hash and memoizes it"
  end
  context "#cookies" do
    it "returns a hash"
  end
  context "#content_length" do
    it "returns an integer"
  end
end
```
_Here''s the [spec implementation](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/request_spec.rb)._
### When is a new Request instantiated and populated with the parsed request data? 

That''s the [parser''s job](/tutorials/the-http-protocol). It will be instantiating and using `Request`''s setter methods as it does its parsing. Go back and check out the [parser source](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_parser.rb) to see how it does this.

Once the parser is done, and its `parse` method returns the new `Request` object with all of the request data in it, the [server will pass](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_server.rb#L25-L29) that `Request` object instance to the `Application` to do its job of responding.');
INSERT INTO pages VALUES (4, 'What A Web Server Does', 'what-a-web-server-does', 3, '&lt;h2&gt;What A Web Server Does&lt;/h2&gt;

&lt;p&gt;The fundamental purpose of a Web Server is to parse byte streams that come in from a TCP Socket into a &lt;code&gt;Request&lt;/code&gt; object. The parsed &lt;code&gt;Request&lt;/code&gt; essentially contains:&lt;/p&gt;

&lt;ul&gt;
&lt;li&gt;the HTTP method (GET, POST, etc.)&lt;/li&gt;
&lt;li&gt;the request path (e.g. /home)&lt;/li&gt;
&lt;li&gt;a hash of all the headers (Content-type, Content-length, etc.)&lt;/li&gt;
&lt;/ul&gt;

&lt;p&gt;This &lt;code&gt;Request&lt;/code&gt; object is given to the &lt;code&gt;Application&lt;/code&gt;, which returns a &lt;code&gt;Response&lt;/code&gt; object. The &lt;code&gt;Response&lt;/code&gt; object is similar to the &lt;code&gt;Request&lt;/code&gt; in that it also contains a header hash but most importantly it has &lt;em&gt;the  body&lt;/em&gt;. This body is the HTML your &lt;code&gt;Application&lt;/code&gt; put together and rendered. The Server will then take this &lt;code&gt;Response&lt;/code&gt; and write it back to the Socket. It then closes the Socket at which point the little loading animation in your browser will stop spinning.&lt;/p&gt;

&lt;h3&gt;Whoa hold on. What&amp;#39;s this &amp;quot;byte streams&amp;quot; and TCP Socket business?&lt;/h3&gt;

&lt;p&gt;Glad you asked. Luckily, in this case, the byte stream we&amp;#39;ll be dealing with is just plain old text characters. See, the HTTP protocol was designed as a human readable text protocol. That means the commands and meta data are all structured text that we can read. When we &amp;quot;talk&amp;quot; to a socket we&amp;#39;re just calling a method on an object and returning a string result. Sockets though, those are pretty awesome. They power everything from the super fast connections MMORPGs use to keep our games fast and interactive to the networks of nodes feeding torrent downloads. Sockets are a fundamental organ of the system through which disparate processes communicate with one another.&lt;/p&gt;

&lt;h3&gt;The Take Away&lt;/h3&gt;

&lt;p&gt;A Web Server&amp;#39;s primary responsibility is to accept a TCP Socket connection, parse the text stream into a Request object the Application can use. Then gets the Response from the Application, adds appropriate response headers, and serializes it before writing it back to the socket.&lt;/p&gt;

&lt;p&gt;So far, we&amp;#39;re only skimming the surface, so don&amp;#39;t worry if you don&amp;#39;t get it yet. We&amp;#39;ll go into more details in the following pages.&lt;/p&gt;

&lt;p&gt;We&amp;#39;ll talk more about HTTP after some &lt;a href=&quot;/tutorials/socket-basics&quot; title=&quot;&quot;&gt;Socket Basics&lt;/a&gt;.&lt;/p&gt;', 0, '2015-05-13 01:31:23', '## What A Web Server Does

The fundamental purpose of a Web Server is to parse byte streams that come in from a TCP Socket into a `Request` object. The parsed `Request` essentially contains:

 - the HTTP method (GET, POST, etc.)
 - the request path (e.g. /home)
 - a hash of all the headers (Content-type, Content-length, etc.)

This `Request` object is given to the `Application`, which returns a `Response` object. The `Response` object is similar to the `Request` in that it also contains a header hash but most importantly it has _the  body_. This body is the HTML your `Application` put together and rendered. The Server will then take this `Response` and write it back to the Socket. It then closes the Socket at which point the little loading animation in your browser will stop spinning.

### Whoa hold on. What''s this "byte streams" and TCP Socket business?

Glad you asked. Luckily, in this case, the byte stream we''ll be dealing with is just plain old text characters. See, the HTTP protocol was designed as a human readable text protocol. That means the commands and meta data are all structured text that we can read. When we "talk" to a socket we''re just calling a method on an object and returning a string result. Sockets though, those are pretty awesome. They power everything from the super fast connections MMORPGs use to keep our games fast and interactive to the networks of nodes feeding torrent downloads. Sockets are a fundamental organ of the system through which disparate processes communicate with one another.

### The Take Away

A Web Server''s primary responsibility is to accept a TCP Socket connection, parse the text stream into a Request object the Application can use. Then gets the Response from the Application, adds appropriate response headers, and serializes it before writing it back to the socket.

So far, we''re only skimming the surface, so don''t worry if you don''t get it yet. We''ll go into more details in the following pages.

We''ll talk more about HTTP after some [Socket Basics](/tutorials/socket-basics).');
INSERT INTO pages VALUES (3, 'The Server', 'writing-a-web-server', 0, '&lt;div class=&quot;jumbotron&quot;&gt;
&lt;h1&gt;Writing A Web Server&lt;h1&gt;
&lt;p&gt;Through implementing a basic Web Server we&#39;ll learn exactly how they talk to the internet, what sockets are, and what the HTTP protocol actually looks like - it&#39;s surprisingly simple! We&#39;ll cover the Main (Event) Loop, Sockets, HTTP parsing, logging and more.&lt;/p&gt;
&lt;/div&gt;

&lt;h2&gt;A Web Server is a Translator&lt;/h2&gt;

&lt;p&gt;Web Servers speak two languages: TCP and HTTP. They act as the translator between these two languages (protocols). The network speaks TCP and the Server (including our &lt;code&gt;Application&lt;/code&gt;) speak HTTP. Our &lt;code&gt;Application&lt;/code&gt; will provide the &lt;code&gt;HT&lt;/code&gt; (HyperText) side of the protocol, while the Server will take care of the gritty details of the &lt;code&gt;TP&lt;/code&gt; (Transport Protocol) side of things. More specifically, our &lt;code&gt;Application&lt;/code&gt; will take the parsed &lt;code&gt;Request&lt;/code&gt; from the socket as a parameter and return a &lt;code&gt;Response&lt;/code&gt; as the result. The Server will then serialize the response into an HTTP representation when it writes it back to the Socket.&lt;/p&gt;

&lt;h2&gt;But how does it do that, exactly?&lt;/h2&gt;

&lt;p&gt;Good, let&amp;#39;s get technical. But, before we see some code I&amp;#39;d like to talk about what Web Servers do. I won&amp;#39;t go into too much detail, just enough to get an overview. Go on to the &lt;a href=&quot;/tutorials/what-a-web-server-does&quot; title=&quot;&quot;&gt;next section&lt;/a&gt;.&lt;/p&gt;', 1, '2015-05-13 01:17:50', '<div class="jumbotron">
<h1>Writing A Web Server<h1>
<p>Through implementing a basic Web Server we''ll learn exactly how they talk to the internet, what sockets are, and what the HTTP protocol actually looks like - it''s surprisingly simple! We''ll cover the Main (Event) Loop, Sockets, HTTP parsing, logging and more.</p>
</div>

## A Web Server is a Translator

Web Servers speak two languages: TCP and HTTP. They act as the translator between these two languages (protocols). The network speaks TCP and the Server (including our `Application`) speak HTTP. Our `Application` will provide the `HT` (HyperText) side of the protocol, while the Server will take care of the gritty details of the `TP` (Transport Protocol) side of things. More specifically, our `Application` will take the parsed `Request` from the socket as a parameter and return a `Response` as the result. The Server will then serialize the response into an HTTP representation when it writes it back to the Socket.

## But how does it do that, exactly?

Good, let''s get technical. But, before we see some code I''d like to talk about what Web Servers do. I won''t go into too much detail, just enough to get an overview. Go on to the [next section](/tutorials/what-a-web-server-does).');
INSERT INTO pages VALUES (10, 'Exiting Gracefully', 'exiting-gracefully', 3, '&lt;h1&gt;Exiting Gracefully&lt;/h1&gt;

&lt;p&gt;&lt;img src=&quot;http://i.imgur.com/ute55ia.gif&quot; alt=&quot;Interrupt&quot; title=&quot;Sorry to Interrupt&quot;&gt;&lt;/p&gt;

&lt;p&gt;In the event that our server process is unexpectedly terminated, such as when we CTL-C in the terminal, or more specifically, when the operating system sends our server process a &lt;a href=&quot;https://en.wikipedia.org/wiki/Unix_signal&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Signal&lt;/a&gt; such as SIGINT (the interrupt signal), SIGKILL, or SIGABRT to name a few. We need a way to safely exit rather than error out to the screen. There are many exceptions that could cause the server process to fail, but we&amp;#39;ll only focus on a few for simplicity. Let&amp;#39;s examine the &lt;code&gt;HttpServer&lt;/code&gt;&amp;#39;s &lt;code&gt;serve&lt;/code&gt; method.&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;serve&lt;/span&gt;
  &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;log_startup_time&lt;/span&gt;

  &lt;span class=&quot;k&quot;&gt;while&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;accept&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;begin&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;request&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;vi&quot;&gt;@http_parser&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;parse&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;

      &lt;span class=&quot;n&quot;&gt;log&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;info&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;info&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt; &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;params&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;inspect&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;unless&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;params&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;empty?&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;strip&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;green&lt;/span&gt;

      &lt;span class=&quot;n&quot;&gt;response&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Application&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;respond_to&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;write&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;response&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;to_http_response&lt;/span&gt;

    &lt;span class=&quot;k&quot;&gt;rescue&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Errno&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;ECONNRESET&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Errno&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;EPIPE&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&amp;gt;&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;e&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;log&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;info&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;e&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;class&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt; &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;e&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;message&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;yellow&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;rescue&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;EmptyRequestError&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&amp;gt;&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;e&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;log&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;warn&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;e&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;class&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt; &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;e&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;message&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;yellow&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;ensure&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;close&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;unless&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;closed?&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

&lt;span class=&quot;k&quot;&gt;rescue&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Interrupt&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;close&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;if&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;&amp;amp;&amp;amp;&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;!&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;closed?&lt;/span&gt;
  &lt;span class=&quot;no&quot;&gt;Model&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;db&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;close&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;log&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;debug&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;Ok bye.&amp;quot;&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;There are two levels where we rescue exceptions. The first is inside the &lt;code&gt;while&lt;/code&gt; loop. This protects against exceptions from the socket or our &lt;code&gt;Application&lt;/code&gt; itself. Here, we rescue just a few exceptions, though in a real life server there would be more. The first two we rescue are &lt;code&gt;Errno::ECONNRESET&lt;/code&gt; and  &lt;code&gt;Errno::EPIPE&lt;/code&gt;. The first means that the connection was reset and the latter means that the pipe is broken or disconnected. I won&amp;#39;t go into what these mean in detail, there are many &lt;a href=&quot;http://stackoverflow.com/questions/4208004/how-do-signals-work&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;resources&lt;/a&gt; to &lt;a href=&quot;http://www.usna.edu/Users/cs/aviv/classes/ic221/s14/lec/16/lec.html&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;read&lt;/a&gt; about &lt;a href=&quot;https://en.wikipedia.org/wiki/Unix_signal&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;process signals&lt;/a&gt;. Rescuing within the while loop is how our servers don&amp;#39;t always crash because of a web developer&amp;#39;s crappy code ;-) Any exception that happens within the while loop won&amp;#39;t effect the loop from continuing on to accept the next socket connection.&lt;/p&gt;

&lt;p&gt;The second level - outside of the while loop - is rescuing signals from the OS. We&amp;#39;re rescuing one such signal here: &lt;code&gt;Interrupt&lt;/code&gt;. This is what CTL-C does. Pressing CTL-C in the terminal causes the OS to send &lt;a href=&quot;https://en.wikipedia.org/wiki/Unix_signal#SIGINT&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;SIGINT&lt;/a&gt; to our Ruby process where it gets raised as an exception. At this outer level we close any connections and say Bye.&lt;/p&gt;', 7, '2015-05-13 01:34:10', '# Exiting Gracefully

![Interrupt](http://i.imgur.com/ute55ia.gif "Sorry to Interrupt")

In the event that our server process is unexpectedly terminated, such as when we CTL-C in the terminal, or more specifically, when the operating system sends our server process a [Signal](https://en.wikipedia.org/wiki/Unix_signal) such as SIGINT (the interrupt signal), SIGKILL, or SIGABRT to name a few. We need a way to safely exit rather than error out to the screen. There are many exceptions that could cause the server process to fail, but we''ll only focus on a few for simplicity. Let''s examine the `HttpServer`''s `serve` method.

```ruby
def serve
  Kwipper.log_startup_time

  while socket = accept
    begin
      request = @http_parser.parse socket

      log.info "#{request.info} #{request.params.inspect unless request.params.empty?}".strip.green

      response = Application.new.respond_to request
      socket.write response.to_http_response

    rescue Errno::ECONNRESET, Errno::EPIPE => e
      log.info "#{e.class} #{e.message}".yellow
    rescue Kwipper::EmptyRequestError => e
      log.warn "#{e.class} #{e.message}".yellow
    ensure
      socket.close unless socket.closed?
    end
  end

rescue Interrupt
  socket.close if socket && !socket.closed?
  Model.db.close
  log.debug "Ok bye."
end
```

There are two levels where we rescue exceptions. The first is inside the `while` loop. This protects against exceptions from the socket or our `Application` itself. Here, we rescue just a few exceptions, though in a real life server there would be more. The first two we rescue are `Errno::ECONNRESET` and  `Errno::EPIPE`. The first means that the connection was reset and the latter means that the pipe is broken or disconnected. I won''t go into what these mean in detail, there are many [resources](http://stackoverflow.com/questions/4208004/how-do-signals-work) to [read](http://www.usna.edu/Users/cs/aviv/classes/ic221/s14/lec/16/lec.html) about [process signals](https://en.wikipedia.org/wiki/Unix_signal). Rescuing within the while loop is how our servers don''t always crash because of a web developer''s crappy code ;-) Any exception that happens within the while loop won''t effect the loop from continuing on to accept the next socket connection.

The second level - outside of the while loop - is rescuing signals from the OS. We''re rescuing one such signal here: `Interrupt`. This is what CTL-C does. Pressing CTL-C in the terminal causes the OS to send [SIGINT](https://en.wikipedia.org/wiki/Unix_signal#SIGINT) to our Ruby process where it gets raised as an exception. At this outer level we close any connections and say Bye.');
INSERT INTO pages VALUES (31, 'The Server Log', 'the-server-log', 3, '&lt;h1&gt;The Server Log&lt;/h1&gt;

&lt;p&gt;&lt;img src=&quot;http://i.imgur.com/utfiLDH.jpeg&quot; alt=&quot;Logs!&quot; title=&quot;Log!&quot;&gt;&lt;/p&gt;

&lt;p&gt;Logs are exciting! Ok, maybe not that much. Well, they&amp;#39;re kind of boring really. And, there&amp;#39;s so much of them! Who really reads them?&lt;/p&gt;

&lt;p&gt;Well, for starters, you&amp;#39;re gonna be reading them. No, &lt;em&gt;for real&lt;/em&gt;. Before you post a stackoverflow question about something that &amp;quot;doesn&amp;#39;t work&amp;quot;, read your logs. Look for errors, warnings, things that are unexpected. Get familiar with them so that you know something is unexpected when you see it.. or &lt;em&gt;don&amp;#39;t&lt;/em&gt; see it. Learn to &lt;a href=&quot;http://www.loggly.com/ultimate-guide/analyzing-linux-logs/&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;grep your logs&lt;/a&gt; to be able to filter out the noise and get to the important stuff. &lt;/p&gt;

&lt;p&gt;Logging is very important because developers need to know what their applications are doing and who&amp;#39;s doing it to them. We&amp;#39;ll want to log such information as the request path and parameters, the logged in user if any, what the application rendered, the database queries it fired, and how long it took to do all these different steps. We&amp;#39;ll want to log a lot more during development (to help us develop) than we do in production (to help us save storage space).&lt;/p&gt;

&lt;p&gt;The most basic things a good logging system can do is:&lt;/p&gt;

&lt;ul&gt;
&lt;li&gt;Save logs to a file&lt;/li&gt;
&lt;li&gt;Change the severity level of logging (development to production)&lt;/li&gt;
&lt;li&gt;Roll over logs after a period of time (delete/archive old ones)&lt;/li&gt;
&lt;/ul&gt;

&lt;p&gt;This means we need a single method we can use all throughout our server and application code that we can use to send log messages to. This method should worry about all the intricacies of log levels, log files, and rolling old logs over.&lt;/p&gt;

&lt;h3&gt;The Logger class&lt;/h3&gt;

&lt;p&gt;Ruby has a built in &lt;a href=&quot;http://ruby-doc.org/stdlib-2.1.0/libdoc/logger/rdoc/Logger.html&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Logger class&lt;/a&gt; we&amp;#39;ll use to abstract these underlying concerns for us. Here&amp;#39;s a simple method that will instantiate a &lt;code&gt;Logger&lt;/code&gt; object, set some defaults and memoize the value using the &lt;code&gt;||=&lt;/code&gt; operator:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;log&lt;/span&gt;
  &lt;span class=&quot;vi&quot;&gt;@logger&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;||=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;STDOUT&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;tap&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;|&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;datetime_format&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;%Y-%m-%d %H:%M:%S &amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;level&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;ENV&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;fetch&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;LOG_LEVEL&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;DEBUG&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;to_i&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;A few things to notice about the above code: we instantiate the &lt;code&gt;Logger&lt;/code&gt; object with the argument &lt;code&gt;STDOUT&lt;/code&gt;, which means all log messages will be streamed to this file descriptor. &lt;code&gt;STDOUT&lt;/code&gt; is most commonly the output stream you see in the terminal, in other words, the server log will simply display in the same terminal window where you start the server up. This simple setup won&amp;#39;t save to a file, and that&amp;#39;s fine at first when we&amp;#39;re beginning to develop a new project.&lt;/p&gt;

&lt;p&gt;We also set the date format (I don&amp;#39;t like the default format) and then set the log level by fetching the &lt;code&gt;LOG_LEVEL&lt;/code&gt; environment variable or defaulting to &lt;code&gt;Logger::DEBUG&lt;/code&gt; when its not found. This will set the severity to the lowest level, meaning all of our log messages will be output. In production, we&amp;#39;ll set it to &lt;code&gt;Logger::INFO&lt;/code&gt;or &lt;code&gt;Logger::WARN&lt;/code&gt; so that only those log messages or above will be written.&lt;/p&gt;

&lt;h3&gt;Log Severities&lt;/h3&gt;

&lt;p&gt;I&amp;#39;ve defined this method in the global scope, that is, outside of any module or class definitions. This way, it&amp;#39;s available to the rest of my code. By calling the &lt;code&gt;log&lt;/code&gt; method we&amp;#39;ll get access to the &lt;code&gt;@logger&lt;/code&gt; instance, which exposes a few methods dealing with logging information at different levels. These levels are referred to as the log &lt;code&gt;Severity&lt;/code&gt;. Here they are from least to most:&lt;/p&gt;

&lt;ul&gt;
&lt;li&gt;&lt;code&gt;DEBUG&lt;/code&gt;&lt;/li&gt;
&lt;li&gt;&lt;code&gt;INFO&lt;/code&gt;&lt;/li&gt;
&lt;li&gt;&lt;code&gt;WARN&lt;/code&gt;&lt;/li&gt;
&lt;li&gt;&lt;code&gt;ERROR&lt;/code&gt;&lt;/li&gt;
&lt;li&gt;&lt;code&gt;FATAL&lt;/code&gt;&lt;/li&gt;
&lt;/ul&gt;

&lt;p&gt;We can issue log messages at each severity by calling their corresponding methods on the &lt;code&gt;@logger&lt;/code&gt; instance returned by the &lt;code&gt;log&lt;/code&gt; method. We simply call &lt;code&gt;log.debug(&amp;quot;stuff&amp;quot;)&lt;/code&gt; to log a low severity debug message. These kinds of logs are useful during development to get insight into what our app is doing. General messages about the state of things can go through &lt;code&gt;log.info&lt;/code&gt;. If something absolutely needs to get logged, we issue a severe log message with &lt;code&gt;log.fatal&lt;/code&gt;, this is typically for logging uncaught exceptions or other failures. &lt;/p&gt;

&lt;p&gt;The whole point is to be able to turn off most logging when we deploy to production so that we can save storage space by logging less. During development we&amp;#39;ll set the log level at the lowest severity &lt;code&gt;DEBUG&lt;/code&gt;, so that all messages from &lt;code&gt;DEBUG&lt;/code&gt; and up get logged. In production we&amp;#39;ll set the level to something like &lt;code&gt;WARN&lt;/code&gt; to only write log entries from &lt;code&gt;WARN&lt;/code&gt; and up.&lt;/p&gt;

&lt;h3&gt;Saving Logs to a File&lt;/h3&gt;

&lt;p&gt;I&amp;#39;ve added some calls to &lt;code&gt;log.debug&lt;/code&gt; in the &lt;code&gt;http_server.rb&lt;/code&gt; file. See the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/http_server.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;code here&lt;/a&gt;. When I run &lt;code&gt;ruby ./lib/kwipper.rb&lt;/code&gt; we&amp;#39;ll see the log output in the terminal:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;I&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;p&quot;&gt;[&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;2015-05-23&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;16&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;30&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;25&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;err&quot;&gt;#&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;81185&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;]&lt;/span&gt;&lt;span class=&quot;w&quot;&gt;  &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;INFO&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;--&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;Starting&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;server&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;on&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;127.0.0.1&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;7335&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;I&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;p&quot;&gt;[&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;2015-05-23&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;16&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;30&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;25&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;err&quot;&gt;#&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;81185&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;]&lt;/span&gt;&lt;span class=&quot;w&quot;&gt;  &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;INFO&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;--&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;Started&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;in&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;1.21&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;s&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;A few things to note about each log line: the first character in the line is the initial of the log level, in this case &lt;code&gt;INFO&lt;/code&gt;. Then, in brackets, we have the date and timestamp followed by the process ID. Finally, we have the log level&amp;#39;s name in full followed by the actual log message we passed: &lt;code&gt;log.info(&amp;quot;Starting server on #{@host}&amp;quot;)&lt;/code&gt;.&lt;/p&gt;

&lt;p&gt;One small tweak to the above command can instead save the output to a log file:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;touch&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;server&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;log&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;ruby&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;./&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;lib&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;kwipper&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;&amp;gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;server&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;log&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;In the shell, &lt;code&gt;touch&lt;/code&gt; creates the file &lt;code&gt;server.log&lt;/code&gt;. We want to make sure this file exists before writing to it. The &lt;code&gt;&amp;gt;&amp;gt;&lt;/code&gt; operator means append to the file &lt;code&gt;server.log&lt;/code&gt;. All of the output we were seeing in the terminal is now being written to the log file. Only problem with this approach is that we&amp;#39;ll no longer be able to see the log output in the terminal. This will be fine in production but we want to see the logs while developing. Easy fix, we can just &lt;code&gt;tail&lt;/code&gt; the log. In a new terminal window run: &lt;code&gt;tail -f server.log&lt;/code&gt;. This will continually output the most recent lines appended to the log file as they are written.&lt;/p&gt;

&lt;p&gt;And with that, we have a fully functioning logging system. All there is left to do is place &lt;code&gt;log.debug&lt;/code&gt;, &lt;code&gt;log.info&lt;/code&gt;, etc. in interesting places in our code. For example, when the request is parsed we want to &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/http_server.rb#L26&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;see the request path and parameters&lt;/a&gt;, after all views are rendered we want to see &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/application.rb#L14&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;what files were rendered and how long they took&lt;/a&gt;. If any database queries are fired we want to &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/model.rb#L24&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;see the query and how long it took&lt;/a&gt;. One last thing though, pretty soon our log file will get big and take up space. We need to roll it over.&lt;/p&gt;

&lt;h3&gt;Log and Roll&lt;/h3&gt;

&lt;p&gt;With just one small tweak to our &lt;code&gt;log&lt;/code&gt; method, we can specify a limit to how big our log files can get or how often to roll them over. The first option is limiting the size:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;no&quot;&gt;Logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;server.log&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;mi&quot;&gt;10&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;mi&quot;&gt;1024000&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;The above code is different in that we are no longer logging to &lt;code&gt;STDOUT&lt;/code&gt;. Here, we&amp;#39;ve specified the log file directly, so we won&amp;#39;t need to do the appendy thing in the terminal anymore. The second argument &lt;code&gt;10&lt;/code&gt; means to keep 10 old log files around while the third argument &lt;code&gt;1024000&lt;/code&gt; says to limit the file size to 1 Megabyte.&lt;/p&gt;

&lt;p&gt;The next option is to roll the logs over periodically:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;no&quot;&gt;Logger&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;server.log&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;weekly&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# or &amp;quot;daily&amp;quot;, &amp;quot;monthly&amp;quot;&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;This will create log files with the date appended to the file name. Then it&amp;#39;s up to you to archive old logs. More &lt;a href=&quot;http://ruby-doc.org/stdlib-2.1.0/libdoc/logger/rdoc/Logger.html#class-Logger-label-HOWTOs&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;info on logging here&lt;/a&gt; and a good &lt;a href=&quot;http://stackoverflow.com/questions/14927418/creating-only-one-log-every-day-using-ruby-standard-logger&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;stackoverflow answer here&lt;/a&gt;.&lt;/p&gt;', 5, '2015-05-16 04:53:08', '# The Server Log

![Logs!](http://i.imgur.com/utfiLDH.jpeg "Log!")

Logs are exciting! Ok, maybe not that much. Well, they''re kind of boring really. And, there''s so much of them! Who really reads them?

Well, for starters, you''re gonna be reading them. No, _for real_. Before you post a stackoverflow question about something that "doesn''t work", read your logs. Look for errors, warnings, things that are unexpected. Get familiar with them so that you know something is unexpected when you see it.. or _don''t_ see it. Learn to [grep your logs](http://www.loggly.com/ultimate-guide/analyzing-linux-logs/) to be able to filter out the noise and get to the important stuff. 

Logging is very important because developers need to know what their applications are doing and who''s doing it to them. We''ll want to log such information as the request path and parameters, the logged in user if any, what the application rendered, the database queries it fired, and how long it took to do all these different steps. We''ll want to log a lot more during development (to help us develop) than we do in production (to help us save storage space).

The most basic things a good logging system can do is:

 - Save logs to a file
 - Change the severity level of logging (development to production)
 - Roll over logs after a period of time (delete/archive old ones)

This means we need a single method we can use all throughout our server and application code that we can use to send log messages to. This method should worry about all the intricacies of log levels, log files, and rolling old logs over.

### The Logger class

Ruby has a built in [Logger class](http://ruby-doc.org/stdlib-2.1.0/libdoc/logger/rdoc/Logger.html) we''ll use to abstract these underlying concerns for us. Here''s a simple method that will instantiate a `Logger` object, set some defaults and memoize the value using the `||=` operator:

```ruby
def log
  @logger ||= Logger.new(STDOUT).tap do |logger|
    logger.datetime_format = "%Y-%m-%d %H:%M:%S "
    logger.level = ENV.fetch("LOG_LEVEL", Logger::DEBUG).to_i
  end
end
```

A few things to notice about the above code: we instantiate the `Logger` object with the argument `STDOUT`, which means all log messages will be streamed to this file descriptor. `STDOUT` is most commonly the output stream you see in the terminal, in other words, the server log will simply display in the same terminal window where you start the server up. This simple setup won''t save to a file, and that''s fine at first when we''re beginning to develop a new project.

We also set the date format (I don''t like the default format) and then set the log level by fetching the `LOG_LEVEL` environment variable or defaulting to `Logger::DEBUG` when its not found. This will set the severity to the lowest level, meaning all of our log messages will be output. In production, we''ll set it to `Logger::INFO`or `Logger::WARN` so that only those log messages or above will be written.

### Log Severities

I''ve defined this method in the global scope, that is, outside of any module or class definitions. This way, it''s available to the rest of my code. By calling the `log` method we''ll get access to the `@logger` instance, which exposes a few methods dealing with logging information at different levels. These levels are referred to as the log `Severity`. Here they are from least to most:

 - `DEBUG`
 - `INFO`
 - `WARN`
 - `ERROR`
 - `FATAL`

We can issue log messages at each severity by calling their corresponding methods on the `@logger` instance returned by the `log` method. We simply call `log.debug("stuff")` to log a low severity debug message. These kinds of logs are useful during development to get insight into what our app is doing. General messages about the state of things can go through `log.info`. If something absolutely needs to get logged, we issue a severe log message with `log.fatal`, this is typically for logging uncaught exceptions or other failures. 

The whole point is to be able to turn off most logging when we deploy to production so that we can save storage space by logging less. During development we''ll set the log level at the lowest severity `DEBUG`, so that all messages from `DEBUG` and up get logged. In production we''ll set the level to something like `WARN` to only write log entries from `WARN` and up.

### Saving Logs to a File

I''ve added some calls to `log.debug` in the `http_server.rb` file. See the [code here](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/http_server.rb). When I run `ruby ./lib/kwipper.rb` we''ll see the log output in the terminal:

```
I, [2015-05-23 16:30:25 #81185]  INFO -- : Starting server on 127.0.0.1:7335
I, [2015-05-23 16:30:25 #81185]  INFO -- : Started in 1.21s
```

A few things to note about each log line: the first character in the line is the initial of the log level, in this case `INFO`. Then, in brackets, we have the date and timestamp followed by the process ID. Finally, we have the log level''s name in full followed by the actual log message we passed: `log.info("Starting server on #{@host}")`.

One small tweak to the above command can instead save the output to a log file:

```
touch server.log
ruby ./lib/kwipper >> server.log
```

In the shell, `touch` creates the file `server.log`. We want to make sure this file exists before writing to it. The `>>` operator means append to the file `server.log`. All of the output we were seeing in the terminal is now being written to the log file. Only problem with this approach is that we''ll no longer be able to see the log output in the terminal. This will be fine in production but we want to see the logs while developing. Easy fix, we can just `tail` the log. In a new terminal window run: `tail -f server.log`. This will continually output the most recent lines appended to the log file as they are written.

And with that, we have a fully functioning logging system. All there is left to do is place `log.debug`, `log.info`, etc. in interesting places in our code. For example, when the request is parsed we want to [see the request path and parameters](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/http_server.rb#L26), after all views are rendered we want to see [what files were rendered and how long they took](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/application.rb#L14). If any database queries are fired we want to [see the query and how long it took](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper/model.rb#L24). One last thing though, pretty soon our log file will get big and take up space. We need to roll it over.

### Log and Roll

With just one small tweak to our `log` method, we can specify a limit to how big our log files can get or how often to roll them over. The first option is limiting the size:

```ruby
Logger.new("server.log", 10, 1024000)
```

The above code is different in that we are no longer logging to `STDOUT`. Here, we''ve specified the log file directly, so we won''t need to do the appendy thing in the terminal anymore. The second argument `10` means to keep 10 old log files around while the third argument `1024000` says to limit the file size to 1 Megabyte.

The next option is to roll the logs over periodically:

```ruby
Logger.new("server.log", "weekly") # or "daily", "monthly"
```

This will create log files with the date appended to the file name. Then it''s up to you to archive old logs. More [info on logging here](http://ruby-doc.org/stdlib-2.1.0/libdoc/logger/rdoc/Logger.html#class-Logger-label-HOWTOs) and a good [stackoverflow answer here](http://stackoverflow.com/questions/14927418/creating-only-one-log-every-day-using-ruby-standard-logger).');
INSERT INTO pages VALUES (7, 'The Main Loop', 'the-main-loop', 3, '&lt;h1&gt;The Main Loop&lt;/h1&gt;

&lt;p&gt;&lt;img src=&quot;http://i.imgur.com/W6vRubS.jpeg&quot; alt=&quot;Loop forever&quot; title=&quot;Loop forever&quot;&gt;&lt;/p&gt;

&lt;p&gt;We need a way for our server to run forever and always accept connections. This is quite a different way of thinking than the familiar request/response pattern we&amp;#39;re used to in web programming - our script or action runs once and returns a view and that&amp;#39;s it, the world starts all over the next time a request comes in. The server is quite different, it has to continue to execute code, keep memory around for the session, connections to the database, configuration variables that may change occasionally among other responsibilities of an event based application. &lt;/p&gt;

&lt;p&gt;We&amp;#39;ll need to execute code in a loop, aka an &lt;a href=&quot;http://en.wikipedia.org/wiki/Event_loop&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;Event Loop&lt;/a&gt;, waiting for socket connections to come in. These connections are the events our server will be handling. This makes testing a little awkward since we&amp;#39;re no longer dealing with code that executes once and returns an answer. We have to deal with a live process and see how its state is changing. &lt;/p&gt;

&lt;p&gt;Let&amp;#39;s start with an overview of the spec:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;describe&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;HttpServer&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s1&quot;&gt;&amp;#39;#serve&amp;#39;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;loads the app code&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;accepts connections&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;writes an HTTP response to the socket&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;closes the socket after an accept&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;&lt;em&gt;Here&amp;#39;s the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_server_spec.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;spec implementation&lt;/a&gt;.&lt;/em&gt;&lt;/p&gt;

&lt;p&gt;The tricky bit is that whole &amp;quot;accepts connections&amp;quot; business. Thankfully, all of the intricacies of actually accepting connections from the network is handled for us by the Socket library so all we have to do is make sure the server receives the &lt;code&gt;accept&lt;/code&gt; method. Hah, so easy! We can count on the TCP Server&amp;#39;s &lt;code&gt;accept&lt;/code&gt; method to do the work for us of calling out to our OS&amp;#39;s network layer and eventually giving us an open socket object. &lt;/p&gt;

&lt;p&gt;We then just need to know the few other things the server does, most important of which are the last two &lt;code&gt;it&lt;/code&gt;&amp;#39;s on the test. We check that the server wrote something to the socket that looks like HTTP before closing the socket connection.&lt;/p&gt;

&lt;p&gt;Running that spec is blazing fast:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;rspec&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;spec&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;units&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;http_server_spec&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;rb&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Finished&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;in&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;0.11327&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;seconds&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;files&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;took&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;0.73066&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;seconds&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;to&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;load&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
&lt;span class=&quot;nl&quot;&gt;5&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;examples&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;il&quot;&gt;0&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;failures&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Definitely makes TDDing new features, algorithms and refactoring much less painful to be able to test quickly. I&amp;#39;ll run the single spec very often while changing bits and pieces of code when I&amp;#39;m implementing methods or refactoring a class. The server we&amp;#39;ll build is very simple, so the spec was simple. The only complicated part about it was dealing with the &lt;code&gt;serve&lt;/code&gt; method&amp;#39;s &lt;code&gt;while&lt;/code&gt; loop. It&amp;#39;s a &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_server_spec.rb#L51-L55&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;bit of a hack&lt;/a&gt;, but quite elegant if I do say so myself. Here&amp;#39;s what happens:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;c1&quot;&gt;# start a thread that will initially sleep for zero seconds allowing the next line to execute&lt;/span&gt;
&lt;span class=&quot;n&quot;&gt;switch_off_socket&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;server&lt;/span&gt;
&lt;span class=&quot;c1&quot;&gt;# the while loop will begin but block on the `accept` call returning control to the above thread&lt;/span&gt;
&lt;span class=&quot;n&quot;&gt;server&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;serve&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;The &lt;code&gt;switch_off_socket&lt;/code&gt; method has now mocked the server&amp;#39;s &lt;code&gt;accept&lt;/code&gt; method to return false which causes the while loop to exit allowing our test suite to move on. Enough testing, let&amp;#39;s check out...&lt;/p&gt;

&lt;p&gt;&lt;div class=&quot;row&quot;&gt;
  &lt;div class=&quot;col-sm-9&quot;&gt;
    &lt;h3&gt;The HttpServer Class&lt;/h3&gt;
  &lt;/div&gt;
  &lt;div class=&quot;col-sm-3&quot;&gt;
    &lt;div class=&quot;alert alert-info pull-right&quot;&gt;
      &lt;span class=&quot;fa fa-github&quot;&gt;&lt;/span&gt;
      See the
      &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_server.rb&quot; target=&quot;_blank&quot;&gt;
        code
        &lt;span class=&quot;fa fa-external-link&quot;&gt;&lt;/span&gt;
      &lt;/a&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
&lt;/p&gt;

&lt;p&gt;To write the least amount of code possible to make this work I decided to subclass from Ruby&amp;#39;s built in &lt;a href=&quot;http://ruby-doc.org/stdlib-2.0/libdoc/socket/rdoc/TCPServer.html&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;TCP Server class&lt;/a&gt;. I&amp;#39;m only going to build a simple single threaded server that loops on accepting socket connections and writes the response to them. A real production server would be much more complex in that it has to handle concurrent connections, compression, caching, exceptions and more. &lt;/p&gt;

&lt;p&gt;Subclassing from TCP Server and initializing the parser and application code:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;class&lt;/span&gt; &lt;span class=&quot;nc&quot;&gt;HttpServer&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;&amp;lt;&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;TCPServer&lt;/span&gt;
  &lt;span class=&quot;no&quot;&gt;DEFAULT_PORT&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;mi&quot;&gt;80&lt;/span&gt;

  &lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;initialize&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;bind&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;port&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
    &lt;span class=&quot;vi&quot;&gt;@bind&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;vi&quot;&gt;@port&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;bind&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;port&lt;/span&gt;
    &lt;span class=&quot;vi&quot;&gt;@host&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#@bind#{&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;:&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#@port&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;unless&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;port&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;to_i&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;==&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;DEFAULT_PORT&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;nb&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;Starting server on &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#@host&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;vi&quot;&gt;@http_parser&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;HttpParser&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt;
    &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;load_app&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;super&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;The TCP Server only needs a host name and port to bind to. Additionally, I initialize our &lt;code&gt;HttpParser&lt;/code&gt; and load the app code - the controllers and models in our &lt;code&gt;/app&lt;/code&gt; directory. Take a look at the &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper.rb#L27-L49&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;main lib file&lt;/a&gt; to see how that&amp;#39;s done. I load the app code this way because when I run tests I don&amp;#39;t want to require all of it, only the files I need. This way, running a single test while working on a class is much faster since it only requires the code it needs. Next, we call &lt;code&gt;super&lt;/code&gt; which implicitly passes in the &lt;code&gt;bind&lt;/code&gt; and &lt;code&gt;port&lt;/code&gt; arguments on up to the TCPServer class. Now we&amp;#39;re ready to start accepting connections.&lt;/p&gt;

&lt;p&gt;We&amp;#39;ll write a &lt;code&gt;serve&lt;/code&gt; method that implements the Main Loop and accepts connections from the socket. Let&amp;#39;s experiment first:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;serve&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;while&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;accept&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# The Main Loop™&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;text&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;gets&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;write&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;I&amp;#39;ma &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;text&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;close&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;That&amp;#39;s just enough code to let us experiment in the terminal. The &lt;code&gt;serve&lt;/code&gt; method is what we call to boot up the server. Let&amp;#39;s go to the terminal and run:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;ruby&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;r&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;./&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;lib&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;http_server&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;e&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;Kwipper::HttpServer.new(&amp;#39;localhost&amp;#39;, 9000).serve&amp;quot;&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;Starting&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;server&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;on&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;localhost:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;9000&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Our server has booted and printed out that status message we &lt;code&gt;puts&lt;/code&gt;&amp;#39;ed from its &lt;code&gt;initialize&lt;/code&gt; method. This Ruby process is now waiting for connections. The code is currently &amp;quot;stuck&amp;quot; on the &lt;code&gt;while socket = accept&lt;/code&gt; line. The &lt;a href=&quot;http://ruby-doc.org/stdlib-2.0/libdoc/socket/rdoc/TCPServer.html#method-i-accept&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;accept&lt;/a&gt; method will block until a connection comes in, then the code inside the &lt;code&gt;while&lt;/code&gt; loop runs. It &lt;code&gt;gets&lt;/code&gt; a single line of text from the socket then writes back a snarky remark and closes the connection. In real life an optimized server wouldn&amp;#39;t close the connection because it&amp;#39;s better to keep it alive so the client can download as much data as it can without having to go through the overhead of opening a new connection for each document it downloads.&lt;/p&gt;

&lt;h3&gt;Talking to the Server&lt;/h3&gt;

&lt;p&gt;With our server running in one terminal window let&amp;#39;s open a new one and use &lt;code&gt;curl&lt;/code&gt; to make a request:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;vg&quot;&gt;curl&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;http://localhost:9000/you&amp;quot;&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;I&lt;/span&gt;&lt;span class=&quot;c1&quot;&gt;&amp;#39;ma GET /you HTTP/1.1&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Spunky little server isn&amp;#39;t it? What&amp;#39;s happened is that &lt;code&gt;curl&lt;/code&gt; has made an HTTP GET request. It took the argument passed to it &lt;code&gt;http://localhost:9000/you&lt;/code&gt; and parsed out the protocol, host, port and request path. It determined it needed to open a socket connection at that host and port, then formatted the request as HTTP and wrote it to the socket. That&amp;#39;s when our server&amp;#39;s &lt;code&gt;while socket = accept&lt;/code&gt; finally returns a value and our code runs through to the bottom of the &lt;code&gt;while&lt;/code&gt; loop, then goes back up to the &lt;code&gt;while&lt;/code&gt; line and does it all over again. &lt;/p&gt;

&lt;p&gt;In the above example we only called &lt;code&gt;socket.gets&lt;/code&gt; once which returned the single line &lt;code&gt;GET /you HTTP/1.1&lt;/code&gt;. &lt;a href=&quot;/tutorials/the-http-protocol&quot; title=&quot;&quot;&gt;We know that the HttpParser will be reading more&lt;/a&gt; from the socket by calling &lt;code&gt;gets&lt;/code&gt; multiple times and optionally using &lt;code&gt;read&lt;/code&gt; to obtain a POST body. Let&amp;#39;s modify the Server&amp;#39;s &lt;code&gt;serve&lt;/code&gt; method to include parsing the request and writing a response:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;serve&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;while&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;accept&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;request&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;vi&quot;&gt;@http_parser&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;parse&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;
    &lt;span class=&quot;nb&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;http_method&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt; &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;path&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;

    &lt;span class=&quot;n&quot;&gt;response&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Application&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;new&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;respond_to&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;socket&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;write&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;response&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;to_http_response&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;With the &lt;code&gt;request&lt;/code&gt; parsed we can print out information about it:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;nb&quot;&gt;puts&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;http_method&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt; &lt;/span&gt;&lt;span class=&quot;si&quot;&gt;#{&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;path&lt;/span&gt;&lt;span class=&quot;si&quot;&gt;}&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;&lt;/span&gt;
&lt;span class=&quot;c1&quot;&gt;# GET /you&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;This is the critical piece of information we need to route the request to correct place. But, before we get to routing and the &lt;code&gt;Application&lt;/code&gt; class, let&amp;#39;s wrap up the web server discussion and go to &lt;a href=&quot;/tutorials/exiting-gracefully&quot; title=&quot;&quot;&gt;Exiting Gracefully&lt;/a&gt;.&lt;/p&gt;', 6, '2015-05-13 01:32:51', '# The Main Loop

![Loop forever](http://i.imgur.com/W6vRubS.jpeg "Loop forever")

We need a way for our server to run forever and always accept connections. This is quite a different way of thinking than the familiar request/response pattern we''re used to in web programming - our script or action runs once and returns a view and that''s it, the world starts all over the next time a request comes in. The server is quite different, it has to continue to execute code, keep memory around for the session, connections to the database, configuration variables that may change occasionally among other responsibilities of an event based application. 

We''ll need to execute code in a loop, aka an [Event Loop](http://en.wikipedia.org/wiki/Event_loop), waiting for socket connections to come in. These connections are the events our server will be handling. This makes testing a little awkward since we''re no longer dealing with code that executes once and returns an answer. We have to deal with a live process and see how its state is changing. 

Let''s start with an overview of the spec:

```ruby
describe Kwipper::HttpServer do
  context ''#serve'' do
    it "loads the app code"
    it "accepts connections"
    it "writes an HTTP response to the socket"
    it "closes the socket after an accept"
  end
end
```

_Here''s the [spec implementation](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_server_spec.rb)._

The tricky bit is that whole "accepts connections" business. Thankfully, all of the intricacies of actually accepting connections from the network is handled for us by the Socket library so all we have to do is make sure the server receives the `accept` method. Hah, so easy! We can count on the TCP Server''s `accept` method to do the work for us of calling out to our OS''s network layer and eventually giving us an open socket object. 

We then just need to know the few other things the server does, most important of which are the last two `it`''s on the test. We check that the server wrote something to the socket that looks like HTTP before closing the socket connection.

Running that spec is blazing fast:

    rspec spec/units/http_server_spec.rb
    Finished in 0.11327 seconds (files took 0.73066 seconds to load)
    5 examples, 0 failures

Definitely makes TDDing new features, algorithms and refactoring much less painful to be able to test quickly. I''ll run the single spec very often while changing bits and pieces of code when I''m implementing methods or refactoring a class. The server we''ll build is very simple, so the spec was simple. The only complicated part about it was dealing with the `serve` method''s `while` loop. It''s a [bit of a hack](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_server_spec.rb#L51-L55), but quite elegant if I do say so myself. Here''s what happens:

```ruby
# start a thread that will initially sleep for zero seconds allowing the next line to execute
switch_off_socket server
# the while loop will begin but block on the `accept` call returning control to the above thread
server.serve
```

The `switch_off_socket` method has now mocked the server''s `accept` method to return false which causes the while loop to exit allowing our test suite to move on. Enough testing, let''s check out...

[github-link](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_server.rb "The HttpServer Class")

To write the least amount of code possible to make this work I decided to subclass from Ruby''s built in [TCP Server class](http://ruby-doc.org/stdlib-2.0/libdoc/socket/rdoc/TCPServer.html). I''m only going to build a simple single threaded server that loops on accepting socket connections and writes the response to them. A real production server would be much more complex in that it has to handle concurrent connections, compression, caching, exceptions and more. 

Subclassing from TCP Server and initializing the parser and application code:

```ruby
class HttpServer < TCPServer
  DEFAULT_PORT = 80

  def initialize(bind, port)
    @bind, @port = bind, port
    @host = "#@bind#{":#@port" unless port.to_i == DEFAULT_PORT}"
    puts "Starting server on #@host"
    @http_parser = HttpParser.new
    Kwipper.load_app
    super
  end
end
```

The TCP Server only needs a host name and port to bind to. Additionally, I initialize our `HttpParser` and load the app code - the controllers and models in our `/app` directory. Take a look at the [main lib file](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/lib/kwipper.rb#L27-L49) to see how that''s done. I load the app code this way because when I run tests I don''t want to require all of it, only the files I need. This way, running a single test while working on a class is much faster since it only requires the code it needs. Next, we call `super` which implicitly passes in the `bind` and `port` arguments on up to the TCPServer class. Now we''re ready to start accepting connections.

We''ll write a `serve` method that implements the Main Loop and accepts connections from the socket. Let''s experiment first:

```ruby
def serve
  while socket = accept # The Main Loop™
    text = socket.gets
    socket.write "I''ma #{text}"
    socket.close
  end
end
```

That''s just enough code to let us experiment in the terminal. The `serve` method is what we call to boot up the server. Let''s go to the terminal and run:

    ruby -r socket -r ./lib/kwipper/http_server -e "Kwipper::HttpServer.new(''localhost'', 9000).serve"
    Starting server on localhost:9000

Our server has booted and printed out that status message we `puts`''ed from its `initialize` method. This Ruby process is now waiting for connections. The code is currently "stuck" on the `while socket = accept` line. The [accept](http://ruby-doc.org/stdlib-2.0/libdoc/socket/rdoc/TCPServer.html#method-i-accept) method will block until a connection comes in, then the code inside the `while` loop runs. It `gets` a single line of text from the socket then writes back a snarky remark and closes the connection. In real life an optimized server wouldn''t close the connection because it''s better to keep it alive so the client can download as much data as it can without having to go through the overhead of opening a new connection for each document it downloads.

### Talking to the Server

With our server running in one terminal window let''s open a new one and use `curl` to make a request:

    curl "http://localhost:9000/you"
    I''ma GET /you HTTP/1.1

Spunky little server isn''t it? What''s happened is that `curl` has made an HTTP GET request. It took the argument passed to it `http://localhost:9000/you` and parsed out the protocol, host, port and request path. It determined it needed to open a socket connection at that host and port, then formatted the request as HTTP and wrote it to the socket. That''s when our server''s `while socket = accept` finally returns a value and our code runs through to the bottom of the `while` loop, then goes back up to the `while` line and does it all over again. 

In the above example we only called `socket.gets` once which returned the single line `GET /you HTTP/1.1`. [We know that the HttpParser will be reading more](/tutorials/the-http-protocol) from the socket by calling `gets` multiple times and optionally using `read` to obtain a POST body. Let''s modify the Server''s `serve` method to include parsing the request and writing a response:

```ruby
def serve
  while socket = accept
    request = @http_parser.parse socket
    puts "#{request.http_method} #{request.path}"

    response = Application.new.respond_to request
    socket.write response.to_http_response
  end
end
```

With the `request` parsed we can print out information about it:

```ruby
puts "#{request.http_method} #{request.path}"
# GET /you
```

This is the critical piece of information we need to route the request to correct place. But, before we get to routing and the `Application` class, let''s wrap up the web server discussion and go to [Exiting Gracefully](/tutorials/exiting-gracefully).');
INSERT INTO pages VALUES (6, 'The HTTP Protocol', 'the-http-protocol', 3, '&lt;h1&gt;The HTTP and TCP Protocols&lt;/h1&gt;

&lt;p&gt;&lt;a href=&quot;http://lmgtfy.com/?q=tcp&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;TCP&lt;/a&gt; is a binary protocol that machines speak in order to reliably communicate with each other. All this is abstracted from us by our OS&amp;#39;s network layer and we, the web developers, use a higher level Socket library to build the &lt;a href=&quot;http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;HTTP&lt;/a&gt; layer on top of it. TCP turns its bytes into text we can build HTTP with. So let&amp;#39;s say we start a TCP Server like we did back in &lt;a href=&quot;/tutorials/socket-basics&quot; title=&quot;&quot;&gt;Socket Basics&lt;/a&gt; but instead type the URL of our Server into the address bar of our web browser &lt;code&gt;http://localhost:9000/index.html&lt;/code&gt;:&lt;/p&gt;

&lt;p&gt;The incoming request at our server will look like:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;kr&quot;&gt;GET&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;index&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;html&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;HTTP&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;1.1&lt;/span&gt;
&lt;span class=&quot;nl&quot;&gt;Host:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;localhost:&lt;/span&gt;&lt;span class=&quot;il&quot;&gt;9000&lt;/span&gt;
&lt;span class=&quot;nl&quot;&gt;Accept:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;text&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;html&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;o&quot;&gt;*/*&lt;/span&gt;
&lt;span class=&quot;vg&quot;&gt;User&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;-&lt;/span&gt;&lt;span class=&quot;nl&quot;&gt;Agent:&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;Mozilla&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;/&lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;4.0&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;compatible&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;;&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;MSIE&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;6.0&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;;&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;Windows&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;NT&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;mf&quot;&gt;5.1&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;blank&lt;/span&gt;&lt;span class=&quot;w&quot;&gt; &lt;/span&gt;&lt;span class=&quot;vg&quot;&gt;line&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;This basic &lt;code&gt;GET&lt;/code&gt; request contains all the information the Server needs to respond with an HTML document, which in this case is &lt;code&gt;index.html&lt;/code&gt;.  When the Server reads this byte stream from the socket it will do so a line at a time. HTTP dictates that each line is separated by a carriage return and line break &lt;code&gt;\r\n&lt;/code&gt;. The end of the request &lt;code&gt;(blank line)&lt;/code&gt; is just another &lt;code&gt;\r\n&lt;/code&gt;. With &lt;a href=&quot;http://www.ntu.edu.sg/home/ehchua/programming/webprogramming/HTTP_Basics.html#http_mesages&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;this information&lt;/a&gt; we can build an &lt;code&gt;HttpParser&lt;/code&gt; class that will take the accepted socket connection, read the byte stream, and parse these lines of text into a hash our &lt;code&gt;Application&lt;/code&gt; can use more easily to build the response.&lt;/p&gt;

&lt;p&gt;&lt;div class=&quot;row&quot;&gt;
  &lt;div class=&quot;col-sm-9&quot;&gt;
    &lt;h3&gt;The HTTP Parser Class&lt;/h3&gt;
  &lt;/div&gt;
  &lt;div class=&quot;col-sm-3&quot;&gt;
    &lt;div class=&quot;alert alert-info pull-right&quot;&gt;
      &lt;span class=&quot;fa fa-github&quot;&gt;&lt;/span&gt;
      See the
      &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_parser.rb&quot; target=&quot;_blank&quot;&gt;
        code
        &lt;span class=&quot;fa fa-external-link&quot;&gt;&lt;/span&gt;
      &lt;/a&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
&lt;/p&gt;

&lt;p&gt;For our simplified purposes we will write a Plain Old Ruby Object to do our bidding. Let&amp;#39;s take a high level look at &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_parser_spec.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;the spec&lt;/a&gt; I wrote to help implement my simple &lt;code&gt;HttpParser&lt;/code&gt;: &lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;describe&lt;/span&gt; &lt;span class=&quot;no&quot;&gt;Kwipper&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;HttpParser&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s1&quot;&gt;&amp;#39;#parse&amp;#39;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;gets the first line of the request&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;builds and returns a request object&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;raises empty request error when request is nil&amp;quot;&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

  &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;got first line&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
    &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#parse_path&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns the path of the request&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

    &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#parse_query&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;converts the query string into a hash and returns it&amp;quot;&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns an empty hash if there was no query string&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

    &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#parse_headers&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;converts the headers of the request into a hash and returns it&amp;quot;&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;returns an empty hash when there were no headers&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;

    &lt;span class=&quot;n&quot;&gt;context&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;#read_body&amp;quot;&lt;/span&gt; &lt;span class=&quot;k&quot;&gt;do&lt;/span&gt;
      &lt;span class=&quot;n&quot;&gt;it&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;reads the request body and parses it into a hash&amp;quot;&lt;/span&gt;
    &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
  &lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;&lt;em&gt;Note: I left out the spec implementation on purpose. You can see the actual &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_parser_spec.rb&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;spec code here.&lt;/a&gt;&lt;/em&gt;&lt;/p&gt;

&lt;p&gt;This unit test written in Rspec is structured so as to describe the important methods of the object. Normally I wouldn&amp;#39;t write tests for all the methods of an object - just the public ones - but I did so this time to help describe how to perform basic HTTP parsing. Each &lt;code&gt;context&lt;/code&gt; is a method of my &lt;code&gt;HttpParser&lt;/code&gt; object. Only the &lt;code&gt;parse&lt;/code&gt; method is public, the rest are the private implementation that &lt;code&gt;parse&lt;/code&gt; uses to build the &lt;code&gt;Request&lt;/code&gt; object it returns.&lt;/p&gt;

&lt;h3&gt;Parts of the Raw Request (The Socket Connection)&lt;/h3&gt;

&lt;p&gt;We&amp;#39;ll be parsing in three steps:&lt;/p&gt;

&lt;ul&gt;
&lt;li&gt;Read the first line up to the &lt;code&gt;\r\n&lt;/code&gt; (&lt;code&gt;gets&lt;/code&gt; does this for us, it will return one line at a time each time it&amp;#39;s called)&lt;/li&gt;
&lt;li&gt;Read each following line (the headers) up to the lone &lt;code&gt;\r\n&lt;/code&gt; marking the end of the headers.&lt;/li&gt;
&lt;li&gt;Optionally keep reading from the request (if it was a POST, PUT, or PATCH request) and parse this text based on the &lt;code&gt;Content-type&lt;/code&gt; header, more on that later.&lt;/li&gt;
&lt;/ul&gt;

&lt;p&gt;The &lt;code&gt;HttpParser#parse&lt;/code&gt; method receives the raw request (socket connection) as its only argument. The socket is the object we call &lt;code&gt;gets&lt;/code&gt; on to get each line. When we get the first line we save it to an instance variable for later use.&lt;/p&gt;

&lt;h3&gt;Parsing the HTTP Method and Request URI&lt;/h3&gt;

&lt;p&gt;With this first line, we use simple string splitting to get each space-separated part of the first line &lt;code&gt;GET /home HTTP/1.1&lt;/code&gt;. The first part &lt;code&gt;GET&lt;/code&gt; is the HTTP method. The second &lt;code&gt;/home&lt;/code&gt; is the Request URI. I&amp;#39;ll ignore the &lt;code&gt;HTTP/1.1&lt;/code&gt; part for now. These two values will be essential in the simple routing system we&amp;#39;ll build later in &lt;a href=&quot;/tutorials/writing-an-app-framework&quot; title=&quot;&quot;&gt;Writing An App Framework&lt;/a&gt;.&lt;/p&gt;

&lt;h3&gt;Parsing the Query String&lt;/h3&gt;

&lt;p&gt;Since the query string is part of the path in that first line we just parsed, we previously would&amp;#39;ve had to split the path by the &lt;code&gt;&amp;quot;?&amp;quot;&lt;/code&gt; and save the first part to the path variable. Now we just do the same but get the second part:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;n&quot;&gt;raw_path&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;/home?q=1&amp;amp;p=2&amp;quot;&lt;/span&gt;
&lt;span class=&quot;n&quot;&gt;path&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;raw_path&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;split&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;?&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;first&lt;/span&gt;
&lt;span class=&quot;n&quot;&gt;query_string&lt;/span&gt; &lt;span class=&quot;o&quot;&gt;=&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;raw_path&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;split&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;s2&quot;&gt;&amp;quot;?&amp;quot;&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;last&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;Now we can parse the &lt;code&gt;query_string&lt;/code&gt; into a hash:&lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;nb&quot;&gt;require&lt;/span&gt; &lt;span class=&quot;s2&quot;&gt;&amp;quot;rack/utils&amp;quot;&lt;/span&gt; &lt;span class=&quot;c1&quot;&gt;# by cheating&lt;/span&gt;
&lt;span class=&quot;no&quot;&gt;Rack&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;::&lt;/span&gt;&lt;span class=&quot;no&quot;&gt;Utils&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;parse_query&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;query_string&lt;/span&gt;
&lt;span class=&quot;c1&quot;&gt;# =&amp;gt; { &amp;quot;q&amp;quot; =&amp;gt; &amp;quot;1&amp;quot;, &amp;quot;p&amp;quot; =&amp;gt; &amp;quot;2&amp;quot; }&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;That was so easy! Now our App can use the query string as it would the familiar &lt;code&gt;params&lt;/code&gt; object we&amp;#39;re used to in Rails. I won&amp;#39;t go into the details of how the string &lt;code&gt;&amp;quot;q=1&amp;amp;p=2&amp;quot;&lt;/code&gt; is parsed into the hash &lt;code&gt;{ &amp;quot;q&amp;quot; =&amp;gt; &amp;quot;1&amp;quot;, &amp;quot;p&amp;quot; =&amp;gt; &amp;quot;2&amp;quot; }&lt;/code&gt; but I&amp;#39;ll at least offer hint: split on the ampersand, split on the equals sign then zip those tuples into a hash.&lt;/p&gt;

&lt;p&gt;The reason I didn&amp;#39;t implement query parsing is because I wanted to use &lt;code&gt;Rack::Utils.parse_nested_query&lt;/code&gt; which is quite a bit more complicated to do from scratch. You might see why when you try to parse an arbitrarily nested query string &lt;code&gt;&amp;quot;user[posts][0][name]=test&amp;quot;&lt;/code&gt; into a nested hash &lt;code&gt;{ &amp;quot;user&amp;quot; =&amp;gt; { &amp;quot;posts&amp;quot; =&amp;gt; [{ &amp;quot;name&amp;quot; =&amp;gt; &amp;quot;test&amp;quot; }] }&lt;/code&gt;.&lt;/p&gt;

&lt;h3&gt;Parsing the Headers&lt;/h3&gt;

&lt;p&gt;The next part is simple, we keep calling &lt;code&gt;gets&lt;/code&gt; on the socket (raw_request) until one of the lines is only the delimiter &lt;code&gt;\r\n&lt;/code&gt; then we stop and parse all the lines we read into a hash. Each header line looks like &lt;code&gt;&amp;quot;Header-name: value\r\n&amp;quot;&lt;/code&gt; so we need only split on the colon and space and make the first item the key and second the value. &lt;a href=&quot;https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_parser.rb#L36-L43&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;See the code&lt;/a&gt;.&lt;/p&gt;

&lt;h3&gt;Reading the Body&lt;/h3&gt;

&lt;p&gt;We only need to read the body when the request has a payload. Only POST, PUT, and PATCH requests have a payload. This will typically be a string that is &lt;code&gt;www-form-urlencoded&lt;/code&gt; which is another word for query string. Both query string and typical request bodies will be encoded in this way: key values joined by equals signs and delimited by ampersands. Nested query strings use a notation similar to hash/array access: &lt;code&gt;&amp;quot;user[posts][0][name]=test&amp;quot;&lt;/code&gt;. This represents a &lt;code&gt;user&lt;/code&gt; hash with a &lt;code&gt;posts&lt;/code&gt; array containing hashes, the first of which has a &lt;code&gt;name&lt;/code&gt; member with the value of &lt;code&gt;&amp;quot;test&amp;quot;&lt;/code&gt;. Other ways request payloads may be encoded include JSON, XML, plain text, etc.&lt;/p&gt;

&lt;p&gt;It&amp;#39;s a &lt;a href=&quot;https://github.com/defunkt/unicorn/blob/master/lib/unicorn/http_request.rb#L55-L99&quot; title=&quot;&quot; target=&quot;_blank&quot;&gt;bit complicated&lt;/a&gt; exactly how to read the rest of the request body from the socket. If we call &lt;code&gt;gets&lt;/code&gt; too many times on the socket the method will hang waiting for more bytes to come from the the client, only the client has finished sending bytes. We need to know how much of the remainder of the body to read. &lt;/p&gt;

&lt;p&gt;Here&amp;#39;s the naive approach: &lt;/p&gt;
&lt;div class=&quot;highlight&quot;&gt;&lt;pre&gt;&lt;span class=&quot;k&quot;&gt;def&lt;/span&gt; &lt;span class=&quot;nf&quot;&gt;read_body&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;raw_request&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;,&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;content_length&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
  &lt;span class=&quot;n&quot;&gt;parse_query_string&lt;/span&gt; &lt;span class=&quot;n&quot;&gt;raw_request&lt;/span&gt;&lt;span class=&quot;o&quot;&gt;.&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;read&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;(&lt;/span&gt;&lt;span class=&quot;n&quot;&gt;content_length&lt;/span&gt;&lt;span class=&quot;p&quot;&gt;)&lt;/span&gt;
&lt;span class=&quot;k&quot;&gt;end&lt;/span&gt;
&lt;/pre&gt;&lt;/div&gt;
&lt;p&gt;the request will have included a &lt;code&gt;Content-length&lt;/code&gt; header with an integer value. Let&amp;#39;s use that value to read that many bytes from the socket with &lt;code&gt;socket.read content_length&lt;/code&gt; (remember, the raw_request &lt;em&gt;is&lt;/em&gt; the open socket). The &lt;code&gt;read&lt;/code&gt; method of the socket takes an integer argument representing the number of bytes left to read from it. With that we have our payload and we can parse it into a hash with the same method we did our query string.&lt;/p&gt;

&lt;p&gt;Now that we have a high level view of low level details of HTTP let&amp;#39;s take a quick look at the object that the parser builds: &lt;a href=&quot;/tutorials/the-http-request&quot; title=&quot;&quot;&gt;The HTTP Request&lt;/a&gt;.&lt;/p&gt;', 2, '2015-05-13 01:32:28', '# The HTTP and TCP Protocols

[TCP](http://lmgtfy.com/?q=tcp) is a binary protocol that machines speak in order to reliably communicate with each other. All this is abstracted from us by our OS''s network layer and we, the web developers, use a higher level Socket library to build the [HTTP](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) layer on top of it. TCP turns its bytes into text we can build HTTP with. So let''s say we start a TCP Server like we did back in [Socket Basics](/tutorials/socket-basics) but instead type the URL of our Server into the address bar of our web browser `http://localhost:9000/index.html`:

The incoming request at our server will look like:

```
GET /index.html HTTP/1.1
Host: localhost:9000
Accept: text/html, */*
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
(blank line)
```

This basic `GET` request contains all the information the Server needs to respond with an HTML document, which in this case is `index.html`.  When the Server reads this byte stream from the socket it will do so a line at a time. HTTP dictates that each line is separated by a carriage return and line break `\r\n`. The end of the request `(blank line)` is just another `\r\n`. With [this information](http://www.ntu.edu.sg/home/ehchua/programming/webprogramming/HTTP_Basics.html#http_mesages) we can build an `HttpParser` class that will take the accepted socket connection, read the byte stream, and parse these lines of text into a hash our `Application` can use more easily to build the response.

[github-link](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_parser.rb "The HTTP Parser Class")

For our simplified purposes we will write a Plain Old Ruby Object to do our bidding. Let''s take a high level look at [the spec](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_parser_spec.rb) I wrote to help implement my simple `HttpParser`: 

```ruby
describe Kwipper::HttpParser do
  context ''#parse'' do
    it "gets the first line of the request"
    it "builds and returns a request object"
    it "raises empty request error when request is nil"
  end

  context "got first line" do
    context "#parse_path" do
      it "returns the path of the request"
    end

    context "#parse_query" do
      it "converts the query string into a hash and returns it"
      it "returns an empty hash if there was no query string"
    end

    context "#parse_headers" do
      it "converts the headers of the request into a hash and returns it"
      it "returns an empty hash when there were no headers"
    end

    context "#read_body" do
      it "reads the request body and parses it into a hash"
    end
  end
end
```

_Note: I left out the spec implementation on purpose. You can see the actual [spec code here.](https://github.com/DiegoSalazar/kwipper_challenge/blob/tutorials/spec/units/http_parser_spec.rb)_

This unit test written in Rspec is structured so as to describe the important methods of the object. Normally I wouldn''t write tests for all the methods of an object - just the public ones - but I did so this time to help describe how to perform basic HTTP parsing. Each `context` is a method of my `HttpParser` object. Only the `parse` method is public, the rest are the private implementation that `parse` uses to build the `Request` object it returns.

### Parts of the Raw Request (The Socket Connection)

We''ll be parsing in three steps:

 - Read the first line up to the `\r\n` (`gets` does this for us, it will return one line at a time each time it''s called)
 - Read each following line (the headers) up to the lone `\r\n` marking the end of the headers.
 - Optionally keep reading from the request (if it was a POST, PUT, or PATCH request) and parse this text based on the `Content-type` header, more on that later.

The `HttpParser#parse` method receives the raw request (socket connection) as its only argument. The socket is the object we call `gets` on to get each line. When we get the first line we save it to an instance variable for later use.

### Parsing the HTTP Method and Request URI

With this first line, we use simple string splitting to get each space-separated part of the first line `GET /home HTTP/1.1`. The first part `GET` is the HTTP method. The second `/home` is the Request URI. I''ll ignore the `HTTP/1.1` part for now. These two values will be essential in the simple routing system we''ll build later in [Writing An App Framework](/tutorials/writing-an-app-framework).

### Parsing the Query String

Since the query string is part of the path in that first line we just parsed, we previously would''ve had to split the path by the `"?"` and save the first part to the path variable. Now we just do the same but get the second part:

```ruby
raw_path = "/home?q=1&p=2"
path = raw_path.split("?").first
query_string = raw_path.split("?").last
```

Now we can parse the `query_string` into a hash:

```ruby
require "rack/utils" # by cheating
Rack::Utils.parse_query query_string
# => { "q" => "1", "p" => "2" }
```

That was so easy! Now our App can use the query string as it would the familiar `params` object we''re used to in Rails. I won''t go into the details of how the string `"q=1&p=2"` is parsed into the hash `{ "q" => "1", "p" => "2" }` but I''ll at least offer hint: split on the ampersand, split on the equals sign then zip those tuples into a hash.

The reason I didn''t implement query parsing is because I wanted to use `Rack::Utils.parse_nested_query` which is quite a bit more complicated to do from scratch. You might see why when you try to parse an arbitrarily nested query string `"user[posts][0][name]=test"` into a nested hash `{ "user" => { "posts" => [{ "name" => "test" }] }`.

### Parsing the Headers

The next part is simple, we keep calling `gets` on the socket (raw_request) until one of the lines is only the delimiter `\r\n` then we stop and parse all the lines we read into a hash. Each header line looks like `"Header-name: value\r\n"` so we need only split on the colon and space and make the first item the key and second the value. [See the code](https://github.com/DiegoSalazar/kwipper_challenge/blob/master/lib/kwipper/http_parser.rb#L36-L43).

### Reading the Body

We only need to read the body when the request has a payload. Only POST, PUT, and PATCH requests have a payload. This will typically be a string that is `www-form-urlencoded` which is another word for query string. Both query string and typical request bodies will be encoded in this way: key values joined by equals signs and delimited by ampersands. Nested query strings use a notation similar to hash/array access: `"user[posts][0][name]=test"`. This represents a `user` hash with a `posts` array containing hashes, the first of which has a `name` member with the value of `"test"`. Other ways request payloads may be encoded include JSON, XML, plain text, etc.

It''s a [bit complicated](https://github.com/defunkt/unicorn/blob/master/lib/unicorn/http_request.rb#L55-L99) exactly how to read the rest of the request body from the socket. If we call `gets` too many times on the socket the method will hang waiting for more bytes to come from the the client, only the client has finished sending bytes. We need to know how much of the remainder of the body to read. 

Here''s the naive approach: 

```ruby
def read_body(raw_request, content_length)
  parse_query_string raw_request.read(content_length)
end
```

the request will have included a `Content-length` header with an integer value. Let''s use that value to read that many bytes from the socket with `socket.read content_length` (remember, the raw\_request _is_ the open socket). The `read` method of the socket takes an integer argument representing the number of bytes left to read from it. With that we have our payload and we can parse it into a hash with the same method we did our query string.

Now that we have a high level view of low level details of HTTP let''s take a quick look at the object that the parser builds: [The HTTP Request](/tutorials/the-http-request).');
INSERT INTO pages VALUES (30, 'Markdown Support', 'markdown-support', 1, '<h2>Coming Soon</h2>', 6, '2015-05-15 11:44:02', '## Coming Soon');


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('pages_id_seq', 32, true);


--
-- Data for Name: post_favorites; Type: TABLE DATA; Schema: public; Owner: diego
--

INSERT INTO post_favorites VALUES (1, 2, 1, '2015-05-14 01:33:04');


--
-- Name: post_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('post_favorites_id_seq', 1, true);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: diego
--

INSERT INTO posts VALUES (1, 2, 'test kwip please ignore', '2015-05-08 02:27:55');
INSERT INTO posts VALUES (2, 2, 'hewo der', '2015-11-13 16:51:21');


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('posts_id_seq', 2, true);


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: diego
--

INSERT INTO sessions VALUES (1, 'Srs0qt8EPcIU43QypJp1Gg', 2, '2015-05-07 21:46:30');
INSERT INTO sessions VALUES (2, '22vH4gA9NUSTxeWpABig2A', 2, '2015-05-07 21:49:03');
INSERT INTO sessions VALUES (3, 'qUD7s1DG4S8d5OdLQHte4g', 2, '2015-05-07 21:50:03');
INSERT INTO sessions VALUES (4, 'DUYoIJx8WUxCPKPElvfSRA', 2, '2015-05-07 21:52:51');
INSERT INTO sessions VALUES (5, 'GDq5GdMCq4TGjkyjVidpAw', 2, '2015-05-07 21:57:14');
INSERT INTO sessions VALUES (6, 'YONea7UHdu8dFNyw9Ixiag', 2, '2015-05-07 22:00:27');
INSERT INTO sessions VALUES (7, 'CSlLbY9h4UZnpfpBVHQ4WQ', 2, '2015-05-07 22:01:32');
INSERT INTO sessions VALUES (8, 'tJjHmIN1V5ZkL9GH2JBYVA', 2, '2015-05-07 22:15:27');
INSERT INTO sessions VALUES (9, 'EHB0UKnW55AWxk2xwYcp9Q', 2, '2015-05-07 22:15:53');
INSERT INTO sessions VALUES (10, '-w51snH_Ug2rKAyCFejzEQ', 2, '2015-05-07 22:17:56');
INSERT INTO sessions VALUES (11, 'vU2DTJRfTLVQgefRnfOWxQ', 2, '2015-05-07 22:19:11');
INSERT INTO sessions VALUES (12, 'r1LSMLF5-OPdFPgDDJPAHQ', 2, '2015-05-07 22:20:31');
INSERT INTO sessions VALUES (13, 'mFQ1hLaGEHxfJJjQvFaZYA', 2, '2015-05-07 22:22:02');
INSERT INTO sessions VALUES (14, 'y4oFhfgT_noFfnRkkO0_Hw', 2, '2015-05-07 22:24:05');
INSERT INTO sessions VALUES (16, 'uxVR3eKnG0UsOIlMPpPX-w', 2, '2015-05-07 22:27:29');
INSERT INTO sessions VALUES (17, '__SSExY9wGGsbje7CzX_EQ', 2, '2015-11-05 13:22:50');


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('sessions_id_seq', 17, true);


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: diego
--



--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('submissions_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: diego
--

INSERT INTO users VALUES (5, 'user-1430881374', 'test-1430881374@.com', '123', '2015-05-05 23:02:54', NULL, NULL);
INSERT INTO users VALUES (6, 'user-1430881424', 'test-1430881424@.com', '123', '2015-05-05 23:03:44', NULL, NULL);
INSERT INTO users VALUES (7, 'user-1430881531', 'test-1430881531@.com', '123', '2015-05-05 23:05:31', NULL, NULL);
INSERT INTO users VALUES (2, 'diego', 'me@diegosalazar.co', '123', '2015-05-05 22:58:10', '2015-05-13 17:38:40', true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: diego
--

SELECT pg_catalog.setval('users_id_seq', 7, true);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: post_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY post_favorites
    ADD CONSTRAINT post_favorites_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions_session_id_key; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_session_id_key UNIQUE (session_id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: diego; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: public; Type: ACL; Schema: -; Owner: diego
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM diego;
GRANT ALL ON SCHEMA public TO diego;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

