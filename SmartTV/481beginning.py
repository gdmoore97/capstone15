#import mysql.connector
from tkinter import *
from tkinter.ttk import *
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


netphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\netflix.png") 
photoimage = netphoto.subsample(3, 3) 
netbtn = Button(window, text="Netflix",image=photoimage,compound=LEFT)
netbtn.place(x=0,y=180)

amaphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\amazon.png") 
amabtn = Button(window, text="Amazon Prime",image=amaphoto)
amabtn.place(x=0,y=240)

hulphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\hulu.png") 
hulbtn = Button(window, text="Hulu",image=hulphoto)
hulbtn.place(x=0,y=300)

cabphoto = PhotoImage(file = r"C:\Users\mcrus\Desktop\481 Images\cable.png") 
cabbtn = Button(window, text="Cable",image=cabphoto)
cabbtn.place(x=0,y=360)

evebtn = Button(window, text="Events")
evebtn.place(x=0,y=420)

def handle_click(event):
	evewindow = Tk()

	evewindow.title("Events")

	evewindow.geometry('800x800')
	
	createbtn=Button(evewindow,text="Create Event")
	
	createbtn.grid(column=9, row=15)
	
	viewbtn=Button(evewindow,text="View Events")
	
	viewbtn.grid(column=9, row=25)
	
	evewindow.mainloop()


evebtn.bind("<Button-1>", handle_click)

window.mainloop()