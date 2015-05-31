require 'minitest/autorun'
require './trinary_tree'

class MyTest < Minitest::Test

  def setup
  end

  def teardown
  end

  def test_insert_values
    assert_insert([], 'empty tree') { |root, msg|
      assert_nil root, msg
    }
  end

  def test_insert_one_value
    assert_insert([5], 'insert single value') { |root, msg|
      assert_equal 5, root.val, msg
    }
  end

  def test_insert_5_3
    assert_insert([5, 3], 'insert 5 3') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 3, root.left.val, msg
    }
  end

  def test_insert_3_5
    assert_insert([3, 5], 'insert 3 5') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 5, root.right.val, msg
    }
  end

  def test_insert_3_3
    assert_insert([3, 3], 'tree with 3 3') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 3, root.middle.val, msg
    }
  end

  def test_insert_5_3_1
    assert_insert([5, 3, 1], 'insert 5 3 1') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 3, root.left.val, msg
      assert_equal 1, root.left.left.val, msg
    }
  end

  def test_insert_5_3_3
    assert_insert([5, 3, 3], 'insert 5 3 3') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 3, root.left.val, msg
      assert_equal 3, root.left.middle.val, msg
    }
  end

  def test_insert_5_3_4
    assert_insert([5, 3, 4], 'insert 5 3 4') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 3, root.left.val, msg
      assert_equal 4, root.left.right.val, msg
    }
  end

  def test_insert_5_3_5
    assert_insert([5, 3, 5], 'insert 5 3 5') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 3, root.left.val, msg
      assert_equal 5, root.middle.val, msg
    }
  end

  def test_insert_5_3_7
    assert_insert([5, 3, 7], 'insert 5 3 7') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 3, root.left.val, msg
      assert_equal 7, root.right.val, msg
    }
  end

  def test_insert_3_5_1
    assert_insert([3, 5, 1], 'insert 3 5 1') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 5, root.right.val, msg
      assert_equal 1, root.left.val, msg
    }
  end

  def test_insert_3_5_5
    assert_insert([3, 5, 5], 'insert 3 5 5') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 5, root.right.val, msg
      assert_equal 5, root.right.middle.val, msg
    }
  end

  def test_insert_3_5_4
    assert_insert([3, 5, 4], 'insert 3 5 4') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 5, root.right.val, msg
      assert_equal 4, root.right.left.val, msg
    }
  end

  def test_insert_3_5_7
    assert_insert([3, 5, 7], 'insert 3 5 7') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 5, root.right.val, msg
      assert_equal 7, root.right.right.val, msg
    }
  end

  def test_insert_3_3_3
    assert_insert([3, 3, 3], 'tree with 3 3 3') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 3, root.middle.val, msg
      assert_equal 3, root.middle.middle.val, msg
    }
  end

  def test_insert_3_3_3_1
    assert_insert([3, 3, 3, 1], 'tree with 3 3 3 1') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 3, root.middle.val, msg
      assert_equal 3, root.middle.middle.val, msg
      assert_equal 1, root.left.val, msg
    }
  end

  def test_insert_3_3_3_5
    assert_insert([3, 3, 3, 5], 'tree with 3 3 3 5') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 3, root.middle.val, msg
      assert_equal 3, root.middle.middle.val, msg
      assert_equal 5, root.right.val, msg
    }
  end

  def test_delete_with_no_values
    assert_insert_and_then_delete([], [5], 'empty tree after delete') { |root, msg|
      assert_nil root, msg
    }
  end

  def test_delete_with_one_value
    assert_insert_and_then_delete([5], [5], 'tree after insert and delete same value') { |root, msg|
      assert_nil root, msg
    }
  end

  def test_insert_5_3_and_delete_5
    assert_insert_and_then_delete([5, 3], [5], 'insert 5 3, delete 5') { |root, msg|
      assert_equal 3, root.val, msg
      assert_nil root.right, msg
    }
  end

  def test_insert_5_3_and_delete_3
    assert_insert_and_then_delete([5, 3], [3], 'insert 5 3, delete 3') { |root, msg|
      assert_equal 5, root.val, msg
      assert_nil root.left, msg
    }
  end

  def test_insert_3_5_1_and_delete_3
    assert_insert_and_then_delete([3, 5, 1], [3], 'insert 3 5 1, delete 3') { |root, msg|
      assert_equal 5, root.val, msg
      assert_equal 1, root.left.val, msg
      assert_nil root.right, msg
    }
  end

  def test_insert_3_5_1_4_7_and_delete_5
    assert_insert_and_then_delete([3, 5, 1, 4, 7], [5], 'insert 3 5 1 4 7, delete 5') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 1, root.left.val, msg
      assert_equal 7, root.right.val, msg
      assert_equal 4, root.right.left.val, msg
      assert_nil root.right.right, msg
    }
  end

  def test_insert_1_3_4_5_7
    assert_insert([1, 3, 4, 5, 7], 'insert 1 3 4 5 7') { |root, msg|
      assert_equal 1, root.val, msg
      assert_equal 3, root.right.val, msg
      assert_equal 4, root.right.right.val, msg
      assert_equal 5, root.right.right.right.val, msg
      assert_equal 7, root.right.right.right.right.val, msg
    }
  end

  def test_insert_1_3_4_5_7_and_delete_4
    assert_insert_and_then_delete([1, 3, 4, 5, 7], [4], 'insert 1 3 4 5 7, delete 4') { |root, msg|
      assert_equal 1, root.val, msg
      assert_equal 3, root.right.val, msg
      assert_equal 5, root.right.right.val, msg
      assert_equal 7, root.right.right.right.val, msg
      assert_nil root.right.right.right.right, msg
    }
  end

  def test_insert_7_5_4_3_2
    assert_insert([7, 5, 4, 3, 2], 'insert 7 5 4 3 2') { |root, msg|
      assert_equal 7, root.val, msg
      assert_equal 5, root.left.val, msg
      assert_equal 4, root.left.left.val, msg
      assert_equal 3, root.left.left.left.val, msg
      assert_equal 2, root.left.left.left.left.val, msg
    }
  end

  def test_insert_7_5_4_3_2_and_delete_5
    assert_insert_and_then_delete([7, 5, 4, 3, 2], [5], 'insert 7 5 4 3 2, delete 5') { |root, msg|
      assert_equal 7, root.val, msg
      assert_equal 4, root.left.val, msg
      assert_equal 3, root.left.left.val, msg
      assert_equal 2, root.left.left.left.val, msg
      assert_nil root.left.left.left.left, msg
    }
  end

  def test_insert_7_5_4
    assert_insert([7, 5, 4], 'insert 7 5 4') { |root, msg|
      assert_equal 7, root.val, msg
      assert_equal 5, root.left.val, msg
      assert_equal 4, root.left.left.val, msg
    }
  end

  def test_insert_7_5_4_and_delete_5
    assert_insert_and_then_delete([7, 5, 4], [5], 'insert 7 5 4, delete 5') { |root, msg|
      assert_equal 7, root.val, msg
      assert_equal 4, root.left.val, msg
      assert_nil root.left.left, msg
    }
  end

  def test_insert_3_3_3_5_and_delete_3
    assert_insert_and_then_delete([3, 3, 3, 5], [3], 'insert 3 3 3 5, delete 3') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 3, root.middle.val, msg
      assert_equal 5, root.right.val, msg
      assert_nil root.middle.middle, msg
    }
  end

  def test_insert_3_3_3_and_delete_3
    assert_insert_and_then_delete([3, 3, 3], [3], 'tree with 3 3 3, delete 3') { |root, msg|
      assert_equal 3, root.val, msg
      assert_equal 3, root.middle.val, msg
      assert_nil root.middle.middle, msg
    }
  end
  private

  def assert_insert(vals, msg)
    tree = TrinaryTree.new

    vals.each do |val|
      tree.insert(val)
    end

    yield tree.root, msg
  end

  def assert_insert_and_then_delete(insert_vals, delete_vals, msg)
    tree = TrinaryTree.new

    insert_vals.each do |val|
      tree.insert(val)
    end

    delete_vals.each do |val|
      tree.delete(val)
    end

    yield tree.root, msg
  end

end
