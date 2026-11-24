from django.urls import path
from firstapp import views

urlpatterns = [
    # клиенты
    path('', views.index),
    path('create/', views.create),
    path('edit/<int:id>/', views.edit),
    path('delete/<int:id>/', views.delete),
    # товары
    path('tovary/', views.tovary),
    path('tovary/create/', views.tovar_create),
    path('tovary/edit/<int:id>/', views.tovar_edit),
    path('tovary/delete/<int:id>/', views.tovar_delete),
    # заказы
    path('zakazy/', views.zakazy),
    path('zakazy/create/', views.zakaz_create),
    path('zakazy/edit/<int:id>/', views.zakaz_edit),
    path('zakazy/delete/<int:id>/', views.zakaz_delete),
]
