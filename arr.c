#include <stdio.h>

extern int sum_array ( int *array , int count);

int main()
{
    FILE *file;
    int array[100];
    int count;
    int i;
    int sum;

    file = fopen("data.txt", "r");

    fscanf(file, "%d", &count);

        for (i = 0; i < count; i++)
    {
        fscanf(file, "%d", &array[i]);
    }

    fclose(file);

    sum = sum_array(array, count);

    printf("Sum = %d\n", sum);

    return 0;







}
