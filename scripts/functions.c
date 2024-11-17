#include <stdio.h>

int celcius_to_fahrenheit(int celsius) {
    float fahrenheit = (celsius * 1.8) + 32;
    printf("The temperature in Fahrenheit is: %.1f\n", fahrenheit);
    return 0;
}

int fahrenheit_to_celcius(int fahrenheit) {
    float celsius = (fahrenheit - 32) * 1.8;
    printf("The temperature in Celsius is: %.1f\n", celsius);
    return 0;
}