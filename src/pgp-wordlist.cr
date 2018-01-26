require "./pgp-wordlist/*"

# A simple library for converting sequences of bytes into unambiguous English words.
#
# Uses the "official" word list: https://philzimmermann.com/docs/PGP_word_list.pdf
#
# ```
# require "pgp-wordlist"
#
# PGP::Wordlist.from_hexstring "0123 cdef" # => "absurd cannonball spindle unravel"
#
# bytes = [0xfe_u8, 0xed_u8, 0xfa_u8, 0xce_u8]
# PGP::Wordlist.from_bytes bytes # => "woodlark unify wallet sardonic"
# ```
module PGP::Wordlist
  # The list of (even, odd) words for each byte.
  WORD_LIST = [
    ["aardvark", "adroitness"],
    ["absurd", "adviser"],
    ["accrue", "aftermath"],
    ["acme", "aggregate"],
    ["adrift", "alkali"],
    ["adult", "almighty"],
    ["afflict", "amulet"],
    ["ahead", "amusement"],
    ["aimless", "antenna"],
    ["Algol", "applicant"],
    ["allow", "Apollo"],
    ["alone", "armistice"],
    ["ammo", "article"],
    ["ancient", "asteroid"],
    ["apple", "Atlantic"],
    ["artist", "atmosphere"],
    ["assume", "autopsy"],
    ["Athens", "Babylon"],
    ["atlas", "backwater"],
    ["Aztec", "barbecue"],
    ["baboon", "belowground"],
    ["backfield", "bifocals"],
    ["backward", "bodyguard"],
    ["banjo", "bookseller"],
    ["beaming", "borderline"],
    ["bedlamp", "bottomless"],
    ["beehive", "Bradbury"],
    ["beeswax", "bravado"],
    ["befriend", "Brazilian"],
    ["Belfast", "breakaway"],
    ["berserk", "Burlington"],
    ["billiard", "businessman"],
    ["bison", "butterfat"],
    ["blackjack", "Camelot"],
    ["blockade", "candidate"],
    ["blowtorch", "cannonball"],
    ["bluebird", "Capricorn"],
    ["bombast", "caravan"],
    ["bookshelf", "caretaker"],
    ["brackish", "celebrate"],
    ["breadline", "cellulose"],
    ["breakup", "certify"],
    ["brickyard", "chambermaid"],
    ["briefcase", "Cherokee"],
    ["Burbank", "Chicago"],
    ["button", "clergyman"],
    ["buzzard", "coherence"],
    ["cement", "combustion"],
    ["chairlift", "commando"],
    ["chatter", "company"],
    ["checkup", "component"],
    ["chisel", "concurrent"],
    ["choking", "confidence"],
    ["chopper", "conformist"],
    ["Christmas", "congregate"],
    ["clamshell", "consensus"],
    ["classic", "consulting"],
    ["classroom", "corporate"],
    ["cleanup", "corrosion"],
    ["clockwork", "councilman"],
    ["cobra", "crossover"],
    ["commence", "crucifix"],
    ["concert", "cumbersome"],
    ["cowbell", "customer"],
    ["crackdown", "Dakota"],
    ["cranky", "decadence"],
    ["crowfoot", "December"],
    ["crucial", "decimal"],
    ["crumpled", "designing"],
    ["crusade", "detector"],
    ["cubic", "detergent"],
    ["dashboard", "determine"],
    ["deadbolt", "dictator"],
    ["deckhand", "dinosaur"],
    ["dogsled", "direction"],
    ["dragnet", "disable"],
    ["drainage", "disbelief"],
    ["dreadful", "disruptive"],
    ["drifter", "distortion"],
    ["dropper", "document"],
    ["drumbeat", "embezzle"],
    ["drunken", "enchanting"],
    ["Dupont", "enrollment"],
    ["dwelling", "enterprise"],
    ["eating", "equation"],
    ["edict", "equipment"],
    ["egghead", "escapade"],
    ["eightball", "Eskimo"],
    ["endorse", "everyday"],
    ["endow", "examine"],
    ["enlist", "existence"],
    ["erase", "exodus"],
    ["escape", "fascinate"],
    ["exceed", "filament"],
    ["eyeglass", "finicky"],
    ["eyetooth", "forever"],
    ["facial", "fortitude"],
    ["fallout", "frequency"],
    ["flagpole", "gadgetry"],
    ["flatfoot", "Galveston"],
    ["flytrap", "getaway"],
    ["fracture", "glossary"],
    ["framework", "gossamer"],
    ["freedom", "graduate"],
    ["frighten", "gravity"],
    ["gazelle", "guitarist"],
    ["Geiger", "hamburger"],
    ["glitter", "Hamilton"],
    ["glucose", "handiwork"],
    ["goggles", "hazardous"],
    ["goldfish", "headwaters"],
    ["gremlin", "hemisphere"],
    ["guidance", "hesitate"],
    ["hamlet", "hideaway"],
    ["highchair", "holiness"],
    ["hockey", "hurricane"],
    ["indoors", "hydraulic"],
    ["indulge", "impartial"],
    ["inverse", "impetus"],
    ["involve", "inception"],
    ["island", "indigo"],
    ["jawbone", "inertia"],
    ["keyboard", "infancy"],
    ["kickoff", "inferno"],
    ["kiwi", "informant"],
    ["klaxon", "insincere"],
    ["locale", "insurgent"],
    ["lockup", "integrate"],
    ["merit", "intention"],
    ["minnow", "inventive"],
    ["miser", "Istanbul"],
    ["Mohawk", "Jamaica"],
    ["mural", "Jupiter"],
    ["music", "leprosy"],
    ["necklace", "letterhead"],
    ["Neptune", "liberty"],
    ["newborn", "maritime"],
    ["nightbird", "matchmaker"],
    ["Oakland", "maverick"],
    ["obtuse", "Medusa"],
    ["offload", "megaton"],
    ["optic", "microscope"],
    ["orca", "microwave"],
    ["payday", "midsummer"],
    ["peachy", "millionaire"],
    ["pheasant", "miracle"],
    ["physique", "misnomer"],
    ["playhouse", "molasses"],
    ["Pluto", "molecule"],
    ["preclude", "Montana"],
    ["prefer", "monument"],
    ["preshrunk", "mosquito"],
    ["printer", "narrative"],
    ["prowler", "nebula"],
    ["pupil", "newsletter"],
    ["puppy", "Norwegian"],
    ["python", "October"],
    ["quadrant", "Ohio"],
    ["quiver", "onlooker"],
    ["quota", "opulent"],
    ["ragtime", "Orlando"],
    ["ratchet", "outfielder"],
    ["rebirth", "Pacific"],
    ["reform", "pandemic"],
    ["regain", "Pandora"],
    ["reindeer", "paperweight"],
    ["rematch", "paragon"],
    ["repay", "paragraph"],
    ["retouch", "paramount"],
    ["revenge", "passenger"],
    ["reward", "pedigree"],
    ["rhythm", "Pegasus"],
    ["ribcage", "penetrate"],
    ["ringbolt", "perceptive"],
    ["robust", "performance"],
    ["rocker", "pharmacy"],
    ["ruffled", "phonetic"],
    ["sailboat", "photograph"],
    ["sawdust", "pioneer"],
    ["scallion", "pocketful"],
    ["scenic", "politeness"],
    ["scorecard", "positive"],
    ["Scotland", "potato"],
    ["seabird", "processor"],
    ["select", "provincial"],
    ["sentence", "proximate"],
    ["shadow", "puberty"],
    ["shamrock", "publisher"],
    ["showgirl", "pyramid"],
    ["skullcap", "quantity"],
    ["skydive", "racketeer"],
    ["slingshot", "rebellion"],
    ["slowdown", "recipe"],
    ["snapline", "recover"],
    ["snapshot", "repellent"],
    ["snowcap", "replica"],
    ["snowslide", "reproduce"],
    ["solo", "resistor"],
    ["southward", "responsive"],
    ["soybean", "retraction"],
    ["spaniel", "retrieval"],
    ["spearhead", "retrospect"],
    ["spellbind", "revenue"],
    ["spheroid", "revival"],
    ["spigot", "revolver"],
    ["spindle", "sandalwood"],
    ["spyglass", "sardonic"],
    ["stagehand", "Saturday"],
    ["stagnate", "savagery"],
    ["stairway", "scavenger"],
    ["standard", "sensation"],
    ["stapler", "sociable"],
    ["steamship", "souvenir"],
    ["sterling", "specialist"],
    ["stockman", "speculate"],
    ["stopwatch", "stethoscope"],
    ["stormy", "stupendous"],
    ["sugar", "supportive"],
    ["surmount", "surrender"],
    ["suspense", "suspicious"],
    ["sweatband", "sympathy"],
    ["swelter", "tambourine"],
    ["tactics", "telephone"],
    ["talon", "therapist"],
    ["tapeworm", "tobacco"],
    ["tempest", "tolerance"],
    ["tiger", "tomorrow"],
    ["tissue", "torpedo"],
    ["tonic", "tradition"],
    ["topmost", "travesty"],
    ["tracker", "trombonist"],
    ["transit", "truncated"],
    ["trauma", "typewriter"],
    ["treadmill", "ultimate"],
    ["Trojan", "undaunted"],
    ["trouble", "underfoot"],
    ["tumor", "unicorn"],
    ["tunnel", "unify"],
    ["tycoon", "universe"],
    ["uncut", "unravel"],
    ["unearth", "upcoming"],
    ["unwind", "vacancy"],
    ["uproot", "vagabond"],
    ["upset", "vertigo"],
    ["upshot", "Virginia"],
    ["vapor", "visitor"],
    ["village", "vocalist"],
    ["virus", "voyager"],
    ["Vulcan", "warranty"],
    ["waffle", "Waterloo"],
    ["wallet", "whimsical"],
    ["watchword", "Wichita"],
    ["wayside", "Wilmington"],
    ["willow", "Wyoming"],
    ["woodlark", "yesteryear"],
    ["Zulu", "Yucatan"],
  ]

  # Returns an English word string corresponding to the given hex bytes in *string*.
  #
  # All whitespace is stripped from the string before processing.
  #
  # ```
  # PGP::Wordlist.from_hexstring <<-MESSAGE
  #  E582 94F2 E9A2 2748 6E8B
  #  061B 31CC 528F D7FA 3F19
  # MESSAGE
  # ```
  def self.from_hexstring(string)
    string = string.delete &.whitespace?
    from_bytes(string.hexbytes)
  end

  # Returns an English word string corresponding to the given enumerable of *bytes*.
  #
  # ```
  # PGP::Wordlist.from_bytes "hello".to_slice
  # PGP::Wordlist.from_bytes [1_u8, 2_u8, 3_u8]
  # ```
  def self.from_bytes(bytes : Enumerable(UInt8))
    # the average word in the word list is 7 bytes (plus a space), so a factor of 8
    # is a reasonable guess.
    String.build(8 * bytes.size) do |str|
      bytes.each_with_index do |byte, i|
        str << WORD_LIST[byte][i % 2]
        str << " " unless i == bytes.size - 1
      end
    end
  end

  # Yields the English word corresponding to each byte in *bytes*.
  #
  # ```
  # PGP::Wordlist.each_word("hello".to_slice) do |word|
  #   puts word
  # end
  # ```
  def self.each_word(bytes : Enumerable(UInt8), &block)
    bytes.each_with_index do |byte, i|
      yield WORD_LIST[byte][i % 2]
    end
  end

  # Yields the English word corresponding to each hex byte in *string*.
  #
  # ```
  # PGP::Wordlist.each_word("feed face") do |word|
  #   puts word
  # end
  # ```
  #
  # NOTE: The difference between this and `.each_word(bytes)` is that this parses hexadecimal digits:
  # `"01"` becomes `0x01`, not `[0x30, 0x31]`.
  def self.each_word(string : String, &block)
    string = string.delete &.whitespace?
    each_word(string.hexbytes) do |word|
      yield word
    end
  end
end
