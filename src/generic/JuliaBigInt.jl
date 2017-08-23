###############################################################################
#
#   JuliaBigInt.jl : Additional Nemo functionality for Julia BigInts
#
###############################################################################

###############################################################################
#
#   Data type and parent object methods
#
###############################################################################

JuliaZZ = Integers()

parent(a::BigInt) = JuliaZZ

elem_type(::Type{Integers}) = BigInt
 
parent_type(::Type{BigInt}) = Integers

base_ring(a::BigInt) = Union{}

base_ring(a::Integers) = Union{}

###############################################################################
#
#   Basic manipulation
#
###############################################################################

isone(a::BigInt) = a == 1

###############################################################################
#
#   String I/O
#
###############################################################################

function show(io::IO, R::Integers)
   print(io, "Integers")
end

needs_parentheses(::BigInt) = false

isnegative(a::BigInt) = a < 0

###############################################################################
#
#   Unsafe functions
#
###############################################################################

function zero!(a::BigInt)
   ccall((:__gmpz_set_si, :libgmp), Void, (Ptr{BigInt}, Int), &a, 0)
   return a
end

function mul!(a::BigInt, b::BigInt, c::BigInt)
   ccall((:__gmpz_mul, :libgmp), Void, (Ptr{BigInt}, Ptr{BigInt}, Ptr{BigInt}), &a, &b, &c)
   return a
end

function addeq!(a::BigInt, b::BigInt)
   ccall((:__gmpz_add, :libgmp), Void, (Ptr{BigInt}, Ptr{BigInt}, Ptr{BigInt}), &a, &a, &b)
   return a
end

function add!(a::BigInt, b::BigInt, c::BigInt)
   ccall((:__gmpz_add, :libgmp), Void, (Ptr{BigInt}, Ptr{BigInt}, Ptr{BigInt}), &a, &b, &c)
   return a
end

function addmul!(a::BigInt, b::BigInt, c::BigInt, d::BigInt)
   ccall((:__gmpz_addmul, :libgmp), Void, (Ptr{BigInt}, Ptr{BigInt}, Ptr{BigInt}), &a, &b, &c)
   return a
end

###############################################################################
#
#   Parent object call overload
#
###############################################################################

function (a::Integers)()
   return 0
end

function (a::Integers)(b::Int)
   return BigInt(b)
end

function (a::Integers)(b::BigInt)
   return b
end
