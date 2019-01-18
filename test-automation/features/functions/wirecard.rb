class Wirecard
    include Capybara::DSL
    def login
        find(:xpath, "//*[@id='login']/main/article/section/div/form/fieldset[1]/input").set('juliof.parra@gmail.com')
        find(:xpath, "//*[@id='login']/main/article/section/div/form/fieldset[2]/input").set('teste123')
        find(:xpath, "//*[@id='login']/main/article/section/div/form/button").click
        sleep(2)
    end

    def return_own_id
        find(:xpath, "//*[@id='entries-rows']/tr[1]/td[1]/a").text
    end

    def return_customer_name
        find(:xpath, "//*[@id='entries-rows']/tr[1]/td[2]/div/div[2]/span").text
    end

    def return_amount
        find(:xpath, "//*[@id='entries-rows']/tr[1]/td[5]/span").text
    end
end
