class PostController < Controller
  def index
    puts "...index"
    if post?
      create
    end
    get_posts
  end

  def new
    puts "...new"
  end

  def show
    puts "...show"
  end

  def create
    puts "...create"
    post = Post.new params["content"]
    @post_source.add post
  end

  def get_posts
    puts "...get_posts"
    posts = @post_source.all
    html = "<html><body><div><h1>Posts:</h1>"
    posts.each do |post|
      html = html + "<p>#{post.content}</p>"
    end
    form = "<form action='/posts' method='post'>
            Post: <input type='text' name='content'>
            <input type='submit' value='Create'>
            </form>"
    html = html + form + "</div></body></html>"
  end
end