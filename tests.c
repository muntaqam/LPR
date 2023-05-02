#include <criterion/criterion.h>
#include "pyramid.h"

Test(pyramid,create_test){

  int max=3;
  create(max);

  for(int i =1; i<=max;i++){
    struct pyramid* p = world[i];
    cr_assert_not_null(p, "Pyramid %d is not created", i);

    cr_assert_eq(p->onTopOf, 0, "Pyramid %d has incorrect onTopOf value", i);
   
  }

}
Test(pyramid,create1){
  int max=3;
  create(max);

  for(int i =1; i<=max;i++){
    struct pyramid* p = world[i];

  cr_assert_eq(p->myNumber, i, "Pyramid %d has incorrect number", i);
  }

}
Test(pyramid,move){
  create(2);
  move(1,2);
  cr_assert_eq(world[1]->onTopOf, 2, "Incorrect onTopOf relationship after move");

}
Test(pyramid,move_open){
  create(2);
  move(1,2);
  move(2,0);
  cr_assert_eq(world[1]->onTopOf, 2, "Incorrect onTopOf relationship for pyramid 1");
}



