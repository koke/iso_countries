require 'test/unit'
require "iso_countries"

class IsoCountriesTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_this_plugin
    assert_equal("Spain", ISO::Countries.get_country("es"))
    assert(ISO::Countries.set_language("es"), "Should set language.")
    assert_equal("España", ISO::Countries.get_country("es"))
  end
end
