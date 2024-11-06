from django.urls import path
from .views import RegisterCustomer

urlpatterns = [
    path('register-customer/', RegisterCustomer.as_view(), name='register_customer'),
]