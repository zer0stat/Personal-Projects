# Example file showing a circle moving on screen
import pygame
import time
import threading
# pygame setup
pygame.init()
screen = pygame.display.set_mode((1920, 1080))
clock = pygame.time.Clock()
running = True
dt = 0
state = 0

categories = {0:"amogus",
              1:"bottom text",
              2:"lorem ipsum",
              3:"meme",
              4:"placeholder",
              5:"cat6"}

hints = {"01":"vsauce michael here, i am inside your home",
         "02":"sus",
         "03":"its red, i saw him vent!!11!1",
         "04":"amogus",
         "05":"The FitnessGram™ Pacer Test is a multistage",
         "11":"top text",
         "12":"made with mematic",
         "13":"crazy? i was crazy once",
         "14":"the jonkler",
         "15":"mikes golf shop",
         "21":"latin",
         "22":"romanium",
         "23":"big",
         "24":"",
         "25":"right behind you",
         "31":"h11",
         "32":"h11",
         "33":"h11",
         "34":"h11",
         "35":"h11",
         "41":"h11",
         "42":"h11",
         "43":"h11",
         "44":"h11",
         "45":"h11",
         "51":"h11",
         "52":"h11",
         "53":"h11",
         "54":"h11",
         "55":"h11"}
player_pos = pygame.Vector2(screen.get_width(), screen.get_height())

def askquestion():
        global decision
        global state
        global hinttext
        while True:
           try:
                decision = input("pick question ")
                hinttext = font.render(hints[decision],True,yellow)
                break
           except KeyError:
                print("invalid coordinate")
        state = 1
        return
askthread = threading.Thread(target=askquestion)

askthread.start()



while running:
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # board rendering
    blue = (3,15,151)
    yellow = (249,173,61)
    screen.fill(blue)

    font = pygame.font.Font("Korinna Regular.ttf",90)
    catfont = pygame.font.Font("Korinna Regular.ttf",50)

    if state == 0:
        #categories
        for i in range(6):
            text = catfont.render(categories[i],True,"white")
            text_rect = text.get_rect(center=(((screen.get_width()/6)*i)+(screen.get_width()/12),screen.get_height()/12))
            screen.blit(text,text_rect)

        #cash
        for i in range(6):
            for ii in range(6):
                sizex = (screen.get_width()/6)*i
                sizey = (screen.get_height()/6)*ii
                rectangle = (sizex,sizey,screen.get_width()/6,screen.get_height()/6)
                pygame.draw.rect(screen, "black", rectangle, 4)
                if ii != 0:
                    if hints[str(i)+str(ii)] != False:
                        #shadow
                        stext = font.render("$"+str(200*ii),True,"black")
                        stext_rect = stext.get_rect(center=(sizex+(screen.get_width()/12+4),sizey+(screen.get_height()/12)+4))
                        screen.blit(stext,stext_rect)
                        #text
                        text = font.render("$"+str(200*ii),True,yellow)
                        text_rect = text.get_rect(center=(sizex+(screen.get_width()/12),sizey+(screen.get_height()/12)))
                        screen.blit(text,text_rect)
                        
        #category seperator line
        catrectangle = (0,screen.get_height()/6,screen.get_width(),20)
        pygame.draw.rect(screen,"black",catrectangle)
    
        # flip() the display to put your work on screen
        pygame.display.flip()

    # limits FPS to 60
    # dt is delta time in seconds since last frame, used for framerate-
    # independent physics.
    dt = clock.tick(60) / 1000

    

    def endquestion():
        input("press enter to continue")
        global qstate
        qstate = 1
        return
        
    endthread = threading.Thread(target=endquestion)
    
    #question render
    if state == 1:
        endthread.start()
        while True:
            qstate = 0
            screen.fill(blue)
            hintrect = hinttext.get_rect(center=(screen.get_width()/2,screen.get_height()/2))
            screen.blit(hinttext,hintrect)
            pygame.display.flip()
            if qstate == 1:
                break
        hints[decision] = False
        state = 0
        askthread2 = threading.Thread(target=askquestion)
        askthread2.start()

pygame.quit()
