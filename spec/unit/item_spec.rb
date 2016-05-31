describe Item do
  it { is_expected.to respond_to :product_code }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :price }
end
