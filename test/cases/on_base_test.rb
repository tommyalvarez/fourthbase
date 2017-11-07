require 'test_helper'

class OnBaseTest < FourthBase::TestCase

  setup do
    run_db :create
    run_db :migrate
    establish_connection
  end

  def test_on_base
    refute FourthBase.is_on_base
    FourthBase.on_base do
      assert FourthBase.is_on_base
      assert_equal FourthBase::Base.connection.class, ActiveRecord::Base.connection.class
      assert_equal [FourthBase::Railtie.fullpath('migrate')], ActiveRecord::Tasks::DatabaseTasks.migrations_paths
      assert_equal FourthBase::Railtie.fullpath, ActiveRecord::Tasks::DatabaseTasks.db_dir
    end
    refute FourthBase.is_on_base
  end

  def test_on_base_nested
    refute FourthBase.is_on_base
    FourthBase.on_base do
      assert FourthBase.is_on_base
      FourthBase.on_base do
        assert FourthBase.is_on_base
      end
      assert FourthBase.is_on_base
    end
    refute FourthBase.is_on_base
  end


end
