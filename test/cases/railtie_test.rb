require 'test_helper'

class RailtieTest < ThirdBase::TestCase

  def test_config
    expected_path = 'db/secondbase'
    assert_equal expected_path, railtie_inst.config.third_base.path
    assert_equal expected_path, railtie_klass.config.third_base.path
    expected_config_key = 'secondbase'
    assert_equal expected_config_key, railtie_inst.config.third_base.config_key
    assert_equal expected_config_key, railtie_klass.config.third_base.config_key
  end

  def test_fullpath
    expected = dummy_db.join('secondbase').to_s
    assert_equal expected, railtie_inst.fullpath
    assert_equal expected, railtie_klass.fullpath
  end


  private

  def railtie_inst
    dummy_app.railties.grep(railtie_klass).first
  end

  def railtie_klass
    ThirdBase::Railtie
  end

end
