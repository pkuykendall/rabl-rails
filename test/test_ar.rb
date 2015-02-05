require 'helper'
require 'support/connection'
require 'models/post'
require 'models/comment'

class TestAR < MINITEST_TEST_CLASS
  def setup
    @comment  = Comment.new(body: 'Super')
    @comment.commentable = Post.new(title: 'First post')
  end

  def test_polymorphic_association
    template = RablRails::Compiler.new(nil).compile_source(%{
      child(:commentable) do
        attribute :title
      end
    })
    context  = RablRails::Renderer::ViewContext.new('comments/base', {})
    visitor  = Visitors::ToHash.new(context)
    visitor.reset_for @comment
    visitor.visit template.nodes

    refute_nil @comment.commentable
    assert_equal({commentable: { title: 'First post'} }, visitor.result)
  end
end
