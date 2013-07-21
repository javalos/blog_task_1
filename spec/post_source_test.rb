class PostSourceTest < TestJavalos
  SOURCE_NAME = "post_source_test.xml"

  def before_each
    create_posts_file
  end

  def after_each
    delete_posts_file
  end

  def test_initialize
    post_source = PostSource.new("")
    j_assert_not_null post_source.source
    j_assert_not_null post_source
  end

  def test_post_source
    post_source = PostSource.new(SOURCE_NAME)
    j_assert_equals SOURCE_NAME, post_source.source
  end

  def test_post_all
    post_source = PostSource.new(SOURCE_NAME)
    posts = post_source.all
    j_assert_not_null posts
    j_assert_equals 3, posts.length
    posts.each { |post| j_assert_equals true, post.instance_of?(Post)  }
    j_assert_equals 2, posts[1].id
    j_assert_equals "Title 2", posts[1].title
    j_assert_equals "Post 2", posts[1].content
  end

  def test_post_create
    post_source = PostSource.new(SOURCE_NAME)
    posts = post_source.all
    count_before = posts.count
    post_source.add Post.new(({content: "Post 4", title: "Title 4"}))
    posts = post_source.all
    j_assert_equals count_before + 1, posts.count
    j_assert_equals 4, posts.last.id
  end

  def test_post_find
    post_source = PostSource.new(SOURCE_NAME)
    post = post_source.find 2
    j_assert_not_null post
    j_assert_equals 2, post.id
    j_assert_equals "Title 2", post.title
    j_assert_equals "Post 2", post.content
  end

  def test_post_not_found
    post_source = PostSource.new(SOURCE_NAME)
    post = post_source.find 200
    j_assert_equals true, post.nil?
  end

  private

  def create_posts_file
    content =  
      "<posts next_id='4'>
        <post id='1'><title>Title 1</title><content>Post 1</content></post>
        <post id='2'><title>Title 2</title><content>Post 2</content></post>
        <post id='3'><title>Title 3</title><content>Post 3</content></post>
      </posts>"
    test_file = File.new(SOURCE_NAME, "w")
    test_file.write(content)
    test_file.close
  end

  def delete_posts_file
    FileUtils.rm(SOURCE_NAME)
  end
end