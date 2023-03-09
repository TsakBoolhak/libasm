#include <libasm.h>
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
    // printf("comparing %d and %d\n", *((int *)(data1)) , *((int *)(data2)) );
    return *((int *)(data1)) != *((int *)(data2));
}

int	listPushFrontTester(int argCount, char **argVector) {
    int arr[] = {-2147483648, 42, 2147483647, 42, 0, 42, -42, 42, 1, 42, 101, 42, 101010};
    t_list *myList = NULL;

    for (int i = 1; i < argCount; ++i){
        int *ptr = malloc(sizeof(int));
        if (!ptr)
        {
            puts("malloc failed");
            lstFree(&myList, &free);
            exit(1);
        }
        *ptr = atoi(argVector[i]);
        t_list *node = ft_list_push_front(&myList, ptr);
        if (!node)
        {
            puts("list Push Front failed");
            lstFree(&myList, &free);
            exit(2);
        }
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
        t_list *node = ft_list_push_front(&myList, ptr);
        if (!node)
        {
            puts("list Push Front failed");
            lstFree(&myList, &free);
            exit(4);
        }
    }
    ft_list_sort(&myList, cmpData);
    t_list *node = myList;
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
    data = 101010;
    ft_list_remove_if(&myList, &data, &cmpData, &free);
    printf("after ft_list_remove_if(&myList, &data, &cmpData, &free); (should remove all the data containing 42) : \n");
    node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d (adress = %p) (data adresss = %p) (next address = %p)\n", i, *((int *)(node->data)), (void *)node, node->data, (void *)node->next);
        node = node->next;
    }
    printf("list size = %d\n", ft_list_size(myList));
    lstFree(&myList, &free);
    return 0;
}