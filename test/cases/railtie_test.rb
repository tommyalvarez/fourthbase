require 'test_helper'

class RailtieTest < FourthBase::TestCase

  def test_config
    expected_path = 'db/fourthbase'
    assert_equal expected_path, railtie_inst.config.fourth_base.path
    assert_equal expected_path, railtie_klass.config.fourth_base.path
    expected_config_key = 'fourthbase'
    assert_equal expected_config_key, railtie_inst.config.fourth_base.config_key
    assert_equal expected_config_key, railtie_klass.config.fourth_base.config_key
  end

  def test_fullpath
    expected = dummy_db.join('fourthbase').to_s
    assert_equal expected, railtie_inst.fullpath
    assert_equal expected, railtie_klass.fullpath
  end


  private

  def railtie_inst
    dummy_app.railties.grep(railtie_klass).first
  end

  def railtie_klass
    FourthBase::Railtie
  end

end
