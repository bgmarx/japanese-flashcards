module ApplicationHelper

  def get_vocab(card)
    card["kanji"] == "-" ? card["kana"] : card["kanji"]
  end
end
