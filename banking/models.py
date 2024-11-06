from django.db import models

# Create your models here.
class tblCustomers(models.Model):
    cust_id = models.AutoField(primary_key=True)
    cust_name = models.CharField(max_length=100)
    cust_email = models.CharField(max_length=100)
    cust_phone = models.CharField(max_length=15, unique=True)
    cust_address = models.TextField(null=True, blank=True)
    cust_dob = models.DateField(null=True, blank=True)
    cust_created_at = models.DateTimeField(auto_now_add=True)
    cust_updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.cust_name
    
    class Meta:
        db_table = 'tblCustomers'
        managed = False
