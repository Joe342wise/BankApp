from rest_framework import serializers
from .models import tblCustomers

class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = tblCustomers
        fields = ['cust_id', 'cust_name', 'cust_email', 'cust_phone', 'cust_address', 'cust_dob']

    def create(self, validated_data):
        customer = tblCustomers.objects.create(**validated_data)
        return customer
    