-- Run as MySQL Root user

CREATE DATABASE registration;
CREATE DATABASE appointment;

CREATE USER 'vms-user' IDENTIFIED BY 'vms-password';

GRANT ALL PRIVILEGES ON registration.* to 'vms-user';
GRANT ALL PRIVILEGES ON appointment.* to 'vms-user';