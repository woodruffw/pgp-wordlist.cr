require "./spec_helper"

describe PGP::Wordlist do
  it "has a master wordlist" do
    PGP::Wordlist::WORD_LIST.should be_a(Array(Array(String)))
  end

  it "converts a hexstring into a wordlist" do
    input = <<-INPUT
      FEED FACE BEEF
    INPUT
    output = "woodlark unify wallet sardonic skydive unravel"

    PGP::Wordlist.from_hexstring(input).should eq(output)
  end

  it "converts a sequence of bytes into a wordlist" do
    input = [0xfe_u8, 0xed_u8, 0xfa_u8, 0xce_u8, 0xbe_u8, 0xef_u8]
    output = "woodlark unify wallet sardonic skydive unravel"

    PGP::Wordlist.from_bytes(input).should eq(output)
  end

  it "yields each word from a hexstring" do
    input = <<-INPUT
      FEED FACE BEEF
    INPUT

    PGP::Wordlist.each_word(input) do |word|
      word.should be_a(String)
      PGP::Wordlist::WORD_LIST.any? { |g| g.includes?(word) }.should be_true
    end
  end

  it "yields each word from a sequence of bytes" do
    input = [0xfe_u8, 0xed_u8, 0xfa_u8, 0xce_u8, 0xbe_u8, 0xef_u8]

    PGP::Wordlist.each_word(input) do |word|
      word.should be_a(String)
      PGP::Wordlist::WORD_LIST.any? { |g| g.includes?(word) }.should be_true
    end
  end
end
