#include <libasm_bonus.h>
#include <stdio.h>
#include <stdlib.h>

void    lstFree(t_list **lst, void (*free_fct)(void *)) {
    if (lst) {
        while (*lst) {
            t_list *next = (*lst)->next;
            free_fct((*lst)->data);
            free(*lst);
            *lst = next;
        }
    }
}

int cmpData(void *data1, void *data2) {
    int nb1 = *((int *)(data1));
    int nb2 = *((int *)(data2));
    if (nb1 < nb2)
        return -1;
    else if (nb1 == nb2)
        return 0;
    return 1;
}

int	listTester(int argCount, char **argVector) {
    int arr[] = {-2147483648, 42, 2147483647, 42, 0, 42, -42, 42, 1, 42, 101, 42, 101010};
    t_list *myList = NULL;
    char	buffer[4096] = {0};
    ssize_t ret;

    puts("ENTERING LIST TESTER");
    for (int i = 1; i < argCount; ++i){
        int *ptr = malloc(sizeof(int));
        if (!ptr)
        {
            puts("malloc failed");
            lstFree(&myList, &free);
            exit(1);
        }
        *ptr = atoi(argVector[i]);
        ft_list_push_front(&myList, ptr);
    }
    for (size_t i = 0; i < sizeof(arr) / sizeof(int); ++i) {
        int *ptr = malloc(sizeof(int));
        if (!ptr)
        {
            puts("malloc failed");
            lstFree(&myList, &free);
            exit(3);
        }
        *ptr = arr[i];
        ft_list_push_front(&myList, ptr);
    }
    t_list *node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }

    do
	{
		printf("Input Element to push front: ");
		fflush(stdout);
		ret = read(0, buffer, 4095);
	    if (ret >= 0)
		{
			buffer[ret] = '\0';
			if (ret > 0 && buffer[ret - 1] == '\n')
			{
				buffer[ret - 1] = '\0';
			}
            if (ret > 0)
            {
			    int *ptr = malloc(sizeof(int));
                if (!ptr)
                {
                    puts("malloc failed");
                    lstFree(&myList, &free);
                    exit(3);
                }
                *ptr = atoi(buffer);
                ft_list_push_front(&myList, ptr);
            }
		}	
	} while (ret > 0);
    puts("");
    node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }
    printf("list size = %d\n", ft_list_size(myList));
    puts("NOW LET'S SORT!!");
    ft_list_sort(&myList, &cmpData);
    node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }
    printf("list size = %d\n", ft_list_size(myList));
    int data = 42;
    ft_list_remove_if(&myList, &data, &cmpData, &free);
    printf("after ft_list_remove_if(&myList, &data, &cmpData, &free); (should remove all the data containing 42) : \n");
    node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }
    printf("list size = %d\n", ft_list_size(myList));
    data = -2147483648;
    ft_list_remove_if(&myList, &data, &cmpData, &free);
    printf("after ft_list_remove_if(&myList, &data, &cmpData, &free); (should remove all the data containing -2147483648) : \n");
    node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }
    printf("list size = %d\n", ft_list_size(myList));
    do
	{
		printf("Input Element to remove: ");
		fflush(stdout);
		ret = read(0, buffer, 4095);
	       	if (ret >= 0)
		{
			buffer[ret] = '\0';
			if (ret > 0 && buffer[ret - 1] == '\n')
			{
				buffer[ret - 1] = '\0';
			}
            if (ret > 0)
            {
	    		data = atoi(buffer);
                ft_list_remove_if(&myList, &data, &cmpData, &free);
            }
		}	
	} while (ret > 0);
    node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }
    printf("list size = %d\n", ft_list_size(myList));
    lstFree(&myList, &free);
    return 0;
}