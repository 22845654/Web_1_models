from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponseNotFound
from .models import Person, Tovar, Zakaz


# ===================== КЛИЕНТЫ =====================

# получение данных из БД и загрузка index.html
def index(request):
    people = Person.objects.all()
    return render(request, "index.html", {"people": people})


# сохранение данных в БД
def create(request):
    if request.method == "POST":
        klient = Person()
        klient.name = request.POST.get("name")
        klient.age = request.POST.get("age")
        klient.save()
    return HttpResponseRedirect("/")


# изменение данных в БД
def edit(request, id):
    try:
        person = Person.objects.get(id=id)
        if request.method == "POST":
            person.name = request.POST.get("name")
            person.age = request.POST.get("age")
            person.save()
            return HttpResponseRedirect("/")
        else:
            return render(request, "edit.html", {"person": person})
    except Person.DoesNotExist:
        return HttpResponseNotFound("<h2>Клиент не найден</h2>")


# удаление данных из БД
def delete(request, id):
    try:
        person = Person.objects.get(id=id)
        person.delete()
        return HttpResponseRedirect("/")
    except Person.DoesNotExist:
        return HttpResponseNotFound("<h2>Клиент не найден</h2>")


# ===================== ТОВАРЫ =====================

def tovary(request):
    tovary = Tovar.objects.all()
    return render(request, "tovary.html", {"tovary": tovary})


def tovar_create(request):
    if request.method == "POST":
        tovar = Tovar()
        tovar.name = request.POST.get("name")
        tovar.price = request.POST.get("price")
        tovar.save()
    return HttpResponseRedirect("/tovary/")


def tovar_edit(request, id):
    try:
        tovar = Tovar.objects.get(id=id)
        if request.method == "POST":
            tovar.name = request.POST.get("name")
            tovar.price = request.POST.get("price")
            tovar.save()
            return HttpResponseRedirect("/tovary/")
        else:
            return render(request, "tovar_edit.html", {"tovar": tovar})
    except Tovar.DoesNotExist:
        return HttpResponseNotFound("<h2>Товар не найден</h2>")


def tovar_delete(request, id):
    try:
        tovar = Tovar.objects.get(id=id)
        tovar.delete()
        return HttpResponseRedirect("/tovary/")
    except Tovar.DoesNotExist:
        return HttpResponseNotFound("<h2>Товар не найден</h2>")


# ===================== ЗАКАЗЫ =====================

def zakazy(request):
    zakazy = Zakaz.objects.select_related("person", "tovar").all()
    return render(request, "zakazy.html", {
        "zakazy": zakazy,
        "people": Person.objects.all(),
        "tovary": Tovar.objects.all(),
    })


def zakaz_create(request):
    if request.method == "POST":
        zakaz = Zakaz()
        zakaz.person_id = request.POST.get("person")
        zakaz.tovar_id = request.POST.get("tovar")
        zakaz.kolichestvo = request.POST.get("kolichestvo")
        zakaz.save()
    return HttpResponseRedirect("/zakazy/")


def zakaz_edit(request, id):
    try:
        zakaz = Zakaz.objects.get(id=id)
        if request.method == "POST":
            zakaz.person_id = request.POST.get("person")
            zakaz.tovar_id = request.POST.get("tovar")
            zakaz.kolichestvo = request.POST.get("kolichestvo")
            zakaz.save()
            return HttpResponseRedirect("/zakazy/")
        else:
            return render(request, "zakaz_edit.html", {
                "zakaz": zakaz,
                "people": Person.objects.all(),
                "tovary": Tovar.objects.all(),
            })
    except Zakaz.DoesNotExist:
        return HttpResponseNotFound("<h2>Заказ не найден</h2>")


def zakaz_delete(request, id):
    try:
        zakaz = Zakaz.objects.get(id=id)
        zakaz.delete()
        return HttpResponseRedirect("/zakazy/")
    except Zakaz.DoesNotExist:
        return HttpResponseNotFound("<h2>Заказ не найден</h2>")
