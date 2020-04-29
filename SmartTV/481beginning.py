import mysql.connector
from tkinter import *
from tkinter.ttk import *
import webbrowser
import calendar 
from datetime import datetime
#cnx = mysql.connector.connect(user='smartfv0_dbuser', password='cstone15',host='localhost',database='smartfv0_test')
cnx = mysql.connector.connect(user='root', password='',host='localhost',database='lexbase')





window = Tk()
window.title("Smarter Smart TV")
frame = Frame(master=window, width=800, height=600)
frame.pack()

bannerlbl = Label(window, text="Smarter SmartTV",font=("Arial Bold",65))
bannerlbl.place(x=0,y=0)

bannerlbl2 = Label(window, text="What are we watching today?",font=("Arial Bold",40))
bannerlbl2.place(x=0,y=100)
new=1
neturl="https://www.netflix.com"
def netclick():
	webbrowser.open(neturl,new=new)

netphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\netflix.png") 
netbtn = Button(window, text="Netflix",image=netphoto,command=netclick)
netbtn.place(x=0,y=200)

amaurl="https://www.primevideo.com"
def amaclick():
	webbrowser.open(amaurl,new=new)
amaphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\amazon.png") 
amabtn = Button(window, text="Amazon Prime",image=amaphoto,command=amaclick)
amabtn.place(x=0,y=400)

hulurl="https://www.hulu.com/"
def hulclick():
	webbrowser.open(hulurl,new=new)
hulphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\hulu.png") 
hulbtn = Button(window, text="Hulu",image=hulphoto,command=hulclick)
hulbtn.place(x=200,y=200)

cabphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\cable.png") 
cabbtn = Button(window, text="Cable",image=cabphoto)
cabbtn.place(x=200,y=400)

hbourl="https://www.hbo.com/"
def hboclick():
	webbrowser.open(hbourl,new=new)
hbophoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\hbo.png") 
hbobtn = Button(window, text="HBO",image=hbophoto,command=hboclick)
hbobtn.place(x=400,y=200)

disurl="https://www.disneyplus.com/"
def disclick():
	webbrowser.open(disurl,new=new)
disphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\disney.png") 
disbtn = Button(window, text="Disney+",image=disphoto,command=disclick)
disbtn.place(x=400,y=400)

appurl="https://www.apple.com/tv/"
def appclick():
	webbrowser.open(appurl,new=new)
appphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\apple.png") 
appbtn = Button(window, text="AppleTV",image=appphoto,command=appclick)
appbtn.place(x=600,y=200)

def cable_click(event):
	cabwindow = Tk()

	cabwindow.title("Cable")

	cabwindow.geometry('800x600')
	
	cabbannerlbl = Label(cabwindow, text="Links to ",font=("Arial Bold",65))
	cabbannerlbl.place(x=0,y=0)
	cabbannerlbl1 = Label(cabwindow, text="Cable",font=("Arial Bold",65))
	cabbannerlbl1.place(x=0,y=100)
	cabbannerlbl2 = Label(cabwindow, text="Provider",font=("Arial Bold",65))
	cabbannerlbl2.place(x=0,y=200)
	
	cabwindow.mainloop()
cabbtn.bind("<Button-1>", cable_click)

cursor=cnx.cursor()

def showCal() : 
	new_gui = Tk() 
	#new_gui.config(background = "white") 
	new_gui.title("CALENDER") 
	new_gui.geometry("1000x700") 
	cal_content = calendar.calendar(2020) 
	cal_year = Label(new_gui, text = cal_content,font="Consolas 10 bold") 
	cal_year.grid(row = 5, column = 1, padx = 20) 
	
	cursor.execute("select * from tvevents order by eventdate")
	result=cursor.fetchall()
	
	event_head = Label(new_gui, text="Upcoming Events",font=("Arial Bold",10))
	event_head.place(x=550,y=0)
	d=40
	for i in result:
		#d+=40		
		evename,eveloc,evetime=i
		#event_instance=Button(new_gui, text=evename, command=eve_internal_press(evename,eveloc,evetime))
		#event_instance.place(x=600,y=d)
		namelab=Label(new_gui,text="Event Name: "+evename, font=("Arial Bold",13))
		loclab=Label(new_gui,text="Event Location: "+eveloc, font=("Arial Bold",10))
		timelab=Label(new_gui,text="Event Time: "+evetime, font=("Arial Bold",10))
		namelab.place(x=550,y=d)
		d+=20
		loclab.place(x=550,y=d)
		d+=20
		timelab.place(x=550,y=d)
		d+=30
	new_gui.mainloop() 

evephoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\calendar.png") 
evebtn = Button(window, text="Events",image=evephoto,command=showCal)
evebtn.place(x=600,y=400)


window.mainloop()
cnx.close()
