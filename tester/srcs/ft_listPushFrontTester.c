#include <libasm.h>
#include <stdio.h>
#include <stdlib.h>

void    lstFree(t_list **lst) {
    if (lst) {
        while (*lst) {
            t_list *next = (*lst)->next;
            free(*lst);
            *lst = next;
        }
    }
}

int	listPushFrontTester(int argCount, char **argVector) {
    int arr[] = {-2147483648, 42, 2147483647, 42, 0, 42, -42, 42, 1, 42, 101, 42, 101010};
    int *arr2;
    t_list *myList = NULL;

    arr2 = malloc((argCount - 1) * sizeof(int));
    if (!arr2) {
        puts("malloc failed");
        exit(1);
    }
    for (int i = 1; i < argCount; ++i){
        arr2[i - 1] = atoi(argVector[i]);
        t_list *node = ft_list_push_front(&myList, arr2 + i - 1);
        if (!node)
        {
            puts("list Push Front failed");
            lstFree(&myList);
            free(arr2);
            exit(2);
        }
    }
    for (size_t i = 0; i < sizeof(arr) / sizeof(int); ++i) {
        t_list *node = ft_list_push_front(&myList, arr + i);
        if (!node)
        {
            puts("list Push Front failed");
            lstFree(&myList);
            free(arr2);
            exit(3);
        }
    }
    t_list *node = myList;
    for (size_t i = 1; node != NULL; ++i) {
        printf("node #%zu data = %d\n", i, *((int *)(node->data)));
        node = node->next;
    }
    lstFree(&myList);
    free(arr2);
    return 0;
}