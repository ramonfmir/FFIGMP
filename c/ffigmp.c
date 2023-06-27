#include <lean/lean.h>
#include <lean/lean_gmp.h>

lean_obj_res my_fun(lean_obj_arg x) {
    mpz_t y;
    mpz_init(y);
    mpz_set_ui(y, 123);
    return lean_alloc_mpz(y);
} 
