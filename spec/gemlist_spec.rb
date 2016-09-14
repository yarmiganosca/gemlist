describe Gemlist do
  it "can list all the runtime gems for a project" do
    gemlist = Gemlist.new(test_project, without: [:development, :test])
    names   = gemlist.gems.map(&:name)

    expect(names).to eq %w(gemlist vise progress thor mime-types netrc unf_ext unf domain_name http-cookie rest-client anvil-cli hammer)
  end

  it "blows up if given conflicting group lists" do
    expect {
      Gemlist.new(test_project, without: [:development, :test], with: [:development]).gems
    }.to raise_error(Gemlist::GroupConflict, /development/)
  end
end
