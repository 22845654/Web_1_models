from django.db import models


class Person(models.Model):
    name = models.CharField(max_length=20)
    age = models.IntegerField()
    objects = models.Manager()
    DoesNotExist = models.Manager


class Sotrudnik(models.Model):
    fio = models.CharField(max_length=50)
    email = models.EmailField()
    birthday = models.DateField()
    salary = models.DecimalField(max_digits=10, decimal_places=2)
    staj = models.PositiveSmallIntegerField()
    is_active = models.BooleanField(default=True)
    site = models.URLField(blank=True)
    about = models.TextField(blank=True)


class Company(models.Model):
    name = models.CharField(max_length=30)


class Product(models.Model):
    company = models.ForeignKey(Company, on_delete=models.CASCADE)
    name = models.CharField(max_length=30)
    price = models.IntegerField()


class Course(models.Model):
    name = models.CharField(max_length=30)


class Student(models.Model):
    name = models.CharField(max_length=30)
    courses = models.ManyToManyField(Course)


class User(models.Model):
    name = models.CharField(max_length=20)


class Account(models.Model):
    login = models.CharField(max_length=20)
    password = models.CharField(max_length=20)
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True)


# ---------- Магазин: товары и заказы (три связанные таблицы) ----------

class Tovar(models.Model):
    name = models.CharField(max_length=50)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    objects = models.Manager()
    DoesNotExist = models.Manager


class Zakaz(models.Model):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    tovar = models.ForeignKey(Tovar, on_delete=models.CASCADE)
    kolichestvo = models.PositiveIntegerField(default=1)
    data = models.DateTimeField(auto_now_add=True)
    objects = models.Manager()
    DoesNotExist = models.Manager

    # сумма заказа = цена товара * количество
    @property
    def summa(self):
        return self.tovar.price * self.kolichestvo
