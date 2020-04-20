#import mysql.connector
from tkinter import *
from tkinter.ttk import *
import webbrowser
#cnx = mysql.connector.connect(user='smartfv0_dbuser', password='cstone15',
#                              host='localhost',
#                              database='smartfv0_test')
#cursor=cnx.cursor()

#cnx.close()


window = Tk()
window.title("Smarter Smart TV")
frame = Frame(master=window, width=800, height=800)
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
netbtn.place(x=0,y=180)

amaurl="https://www.primevideo.com"
def amaclick():
	webbrowser.open(amaurl,new=new)
amaphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\amazon.png") 
amabtn = Button(window, text="Amazon Prime",image=amaphoto,command=amaclick)
amabtn.place(x=0,y=240)

hulurl="https://www.hulu.com/"
def hulclick():
	webbrowser.open(hulurl,new=new)
hulphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\hulu.png") 
hulbtn = Button(window, text="Hulu",image=hulphoto,command=hulclick)
hulbtn.place(x=0,y=300)

cabphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\cable.png") 
cabbtn = Button(window, text="Cable",image=cabphoto)
cabbtn.place(x=0,y=360)

def cable_click(event):
	cabwindow = Tk()

	cabwindow.title("Cable")

	cabwindow.geometry('800x800')
	
	cabbannerlbl = Label(cabwindow, text="Links to ",font=("Arial Bold",65))
	cabbannerlbl.place(x=0,y=0)
	cabbannerlbl1 = Label(cabwindow, text="Cable",font=("Arial Bold",65))
	cabbannerlbl1.place(x=0,y=100)
	cabbannerlbl2 = Label(cabwindow, text="Provider",font=("Arial Bold",65))
	cabbannerlbl2.place(x=0,y=200)
	
	cabwindow.mainloop()
cabbtn.bind("<Button-1>", cable_click)

evebtn = Button(window, text="Events")
evebtn.place(x=0,y=420)

def handle_click(event):
	evewindow = Tk()

	evewindow.title("Events")

	evewindow.geometry('400x400')
	
	createbtn=Button(evewindow,text="Create Event")
	
	createbtn.grid(column=9, row=15)
	
	viewbtn=Button(evewindow,text="View Events")
	
	viewbtn.grid(column=9, row=25)
	
	evewindow.mainloop()


evebtn.bind("<Button-1>", handle_click)

window.mainloop()