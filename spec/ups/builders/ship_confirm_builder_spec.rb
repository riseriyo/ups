require 'spec_helper'

class UPS::Builders::TestShipConfirmBuilder < Minitest::Test
  include SchemaPath
  include ShippingOptions

  def setup
    @ship_confirm_builder = UPS::Builders::ShipConfirmBuilder.new do |builder|
      builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
      builder.add_shipper shipper
      builder.add_ship_to ship_to
      builder.add_ship_from shipper
      builder.add_package package
      builder.add_label_specification 'gif', { height: '100', width: '100' }
      builder.add_description 'Los Pollo Hermanos'
    end
  end

  def test_validates_against_xsd
    assert_passes_validation schema_path('ShipConfirmRequest.xsd'), @ship_confirm_builder.to_xml
  end
end
