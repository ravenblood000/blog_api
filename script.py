#! /home/levink000/anaconda3/bin/python

import requests
import json
import sys

def makeReq(reqType, url, params):
    err = "ERROR: No API response."
    if reqType == "GET":
        res = requests.get(url)
    elif reqType == "POST":
        res = requests.post(url, data=params)
    elif reqType == "PUT":
        res = requests.put(url, data=params)
    elif reqType == "DELETE":
        res = requests.delete(url)
    else:
        print("ERROR: Invalid server request.")
        return False, None
    if res.ok:
        if res.status_code == 204:
            return True, None
        print(json.dumps(res.json(), indent=4))
        return True, res.json()
    else:
        print(err)
        return False, None
        
ERROR = "Invalid command."
URL = "http://localhost:3000/articles"
command = ""
argc = 0
argv = []

while (True):
    command = input("What is your query?\n'read [id] [comment] [comment id]'," + 
                    "'create [id] [comment]', 'update [id]'," +
                    "'delete [id] [comment] [comment id]', 'quit'\n")
    argv = command.split()
    argc = len(argv)
    if command.startswith("read"):
        if argc == 1:
            makeReq("GET", URL, [])
        elif argc == 2: #prints specific article if specified
            makeReq("GET", URL + "/" + argv[1], [])
        elif argc == 3 and argv[2] == "comment":
            makeReq("GET", URL + "/" + argv[1] + "/comments", [])
        elif argc == 4:
            makeReq("GET", URL + "/" + argv[1] + "/comments/" + argv[3], [])
        else:
            print(ERROR)

    elif command.startswith("create"):
        if argc == 1: #creating article
            title = input("Title: ")
            body = input("Body: ")
            status = input("Status: ")
            makeReq("POST", URL, {"title": title, "body": body, "status": status})
        elif argc == 3 and argv[2] == "comment": #creating a comment
            commenter = input("Commenter: ")
            body = input("Body: ")
            status = input("Status: ")
            makeReq("POST", URL + "/" + argv[1] + "/comments", {"commenter": commenter, "body": body, "status": status})
        else:
            print(ERROR)
    
    elif command.startswith("update") and argc == 2: #article id to update must be specified
        boolean, jsonObj = makeReq("GET", URL + "/" + argv[1], [])
        print("Current title:", jsonObj["title"])
        title = input("New Title: ")
        print("Current body:", jsonObj["body"])
        body = input("New Body: ")
        print("Current status", jsonObj["status"])
        status = input("New Status: ")
        views = input("Views: ")
        floater = input("Floater: ")
        deci = input("Deci: ")
        bool = input("Bool: ")
        image = input("Encode to binary: ")
        diction = {"title": jsonObj["title"], "body": jsonObj["body"], "status": jsonObj["status"], "views": views, "floater": floater, "deci": deci, "bool": bool, "image": image}
        if title != "":
            diction["title"] = title
        if body != "":
            diction["body"] = body
        if status != "":
            diction["status"] = status
        makeReq("PUT", URL + "/" + argv[1], diction)
    
    elif command.startswith("delete"):
        if argc == 2:
            success, obj = makeReq("DELETE", URL + "/" + argv[1], [])
            if success:
                print("Article", argv[1], "has been successfully deleted.")
            else:
                print("Article", argv[1], "could not be deleted.")
        elif argc == 4:
            success, obj = makeReq("DELETE", URL + "/" + argv[1] + "/comments/" + argv[3], [])
            if success:
                print("Comment", argv[3], "on Article", argv[1], "has been successfully deleted.")
            else:
                print("Comment", argv[3], "on Article", argv[3], "could not be deleted.")
        else:
            print(ERROR)
    elif command == "quit":
        sys.exit("Thank you!")
    else:
        print(ERROR)
