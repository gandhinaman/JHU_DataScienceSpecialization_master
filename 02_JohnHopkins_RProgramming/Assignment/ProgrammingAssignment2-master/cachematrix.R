## ***************************************************** SCRIPT AUTHOR ****************************************************
## Project - Coursera Data Science Specialization (JHU) - R Programming
## Title - WEEK 3: Peer-graded Assignment: Programming Assignment 2: Lexical Scoping
## Author - Naman Gandhi
## Last Modified Date - 10/31/2016
## Version History - v1.1
## Version Comments - Added a test case at the bottom of the script for easy evaluation
## ************************************************************************************************************************


## **************************************************** SCRIPT PURPOSE ****************************************************
## Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix 
## rather than compute it repeatedly, this assignment is to write a pair of functions that cache the inverse of a matrix.

## Assumption: The matrix supplied is always invertible.
## ************************************************************************************************************************


## ************************************************************************************************************************
## makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.
## This function creates the special list containing four functions allowing to set and get the matrix as well as its stored 
## inverse
## ************************************************************************************************************************

makeCacheMatrix <- function(x = matrix()) {
    ## Initializing the inverse matrix to be NULL at the code beginning
    Inverse <- NULL
    
    ## One alternative way to initialize the matrix would be using NAs using 'matrix' function
    ## Inverse <- matrix(data=NA,nrow=100,ncol=100)
    
    ## If the matrix x is set a new value, then the Inverse is also set to NULL using the 'set' function
    set <- function(y) {
        x <<- y
        Inverse <<- NULL
    }
    
    ## The 'get' funtcion returns our original matrix from the special list of 4 values
    get <- function() x
    
    ## The 'setinv' will replace the stored 'Inverse' matrix with the 'inv' matrix
    ## <<- operator is used to assign a value to an object in an environment that is different from the current environment
    setinv <- function(inv) Inverse <<- inv
    
    ## The 'getinv' will allow us to get the stored inverse matrix from our special list of 4 values
    getinv <- function() Inverse
    
    ## Create the special list having 4 parameters
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## ************************************************************************************************************************
## cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the 
## inverse from the cache.
## ************************************************************************************************************************

cacheSolve <- function(x, ...) {
    ## Use the getinv function of the special list to seek the Inverse matrix
    Inverse <- x$getinv()
    
    ## Check if the returned matrix is NOT NULL, if so that means Inverse exists in cache and we will pick the cached entry
    if(!is.null(Inverse)) {
        message("getting cached data")
        return(Inverse)
    }
    ## (!all(is.na(Inverse))) will test the matrix for being NA if initialized by alternative way
    
    ## Executing the below set of commands will compute the Inverse using the Solve function
    inputMat <- x$get()
    Inverse <- solve(inputMat, ...)
    x$setinv(Inverse)
    
    ## Return a matrix that is the inverse of 'x'
    return(Inverse)
}


## ************************************************************************************************************************
## A quick test case to help check the expected output
## ************************************************************************************************************************

matlist <- makeCacheMatrix(matrix(c(2, 4, 1, 5), nrow=2, ncol=2))
invmat <- cacheSolve(matlist)
## for the first occurence, you will get the matrix computed using the function written above
invmat

invmat <- cacheSolve(matlist)
## for the second iteration, the inverse will be fetched from the cache and you will see "getting cached data" message

## ******************************************************** END ***********************************************************
