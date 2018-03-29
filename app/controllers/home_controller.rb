class HomeController < ApplicationController
  def index
    
    #라이브러리 불러오기
    require 'open-uri'
    require 'json'
    
    #페이지 열기
    @page = open ('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=')
    @page = @page.read #.read 페이지 읽기
    
    @page_info = JSON.parse(@page) #.parse 분석하다.
    
    @draw_numbers = []
    
    @page_info.each do |k, v|
    @draw_numbers << v if k.include? ('drwtNo')
    
  end
  
    @draw_numbers.sort!
    
    @bonus_number = @page_info["bnusNo"]
    
    @lotto = [*1..45].sample(6).sort
    
    @match_numbers = @lotto & @draw_numbers
    
    @match_count = @match_numbers.count
    
    if @match_count == 6
      @result = '1등'
      elsif (@match_count == 5) && (@lotto.include?(@bonus_number))
      @result = '2등'
      elsif @match_count == 5
      @result = '3등'
      elsif @match_count == 4
      @result = '4등'
      elsif @match_count == 3
      @result = '5등'
      else
      @result = '꽝!'
    end
    
    
    
    
    
  end
end
