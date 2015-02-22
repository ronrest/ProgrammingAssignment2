## =============================================================================
## Calculating the inverse of matrices is computationally expensive. In order to 
## avoid calculating this repeatedly, this collection of functions can be used  
## as a means of caching the calculation.
## =============================================================================


#' =============================================================================
#' Creates a special object that is used to cache the inverse of a matrix, in 
#' order to avoid constant recalculation, which can be computationally expensive
#' 
#' @param x A matrix object to be inverted
#' @return A list of functions (set, get, setInverse, getInverse)
#' @examples
#' m = matrix(rnorm(12, 1,100), 3,3)
#' mcache = makeCacheMatrix(m)
#' 
#' =============================================================================
makeCacheMatrix <- function(x = matrix()) {
    i <- NULL              # Stores the inverse value
    
    # ------------------------- Create the embeded function to set up the matrix
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    
    # ---------------------------- Create the embeded function to get the matrix
    get <- function() x
    
    # --------------------------- Create the embeded function to set the Inverse
    setInverse <- function(inverse) i <<- inverse
    
    
    # --------------------------- Create the embeded function to get the Inverse
    getInverse <- function() i
    
    # --------------------------------- Return a list of al the nested functions
    return(list(set = set, 
                get = get, 
                setInverse = setInverse, 
                getInverse = getInverse))
}


#' =============================================================================
#' Takes a special matrix object, and returns the inverse of that matrix. 
#' This function is designed to minimize the computational cost usually 
#' assosiated with constantly calculating the inverse of a matrix. It does so
#' by caching the inverse within the special matrix object. 
#' 
#' @param x A special matrix object created using makeCacheMatrix()
#' @return The inverse of the matrix
#' @examples
#' m = matrix(rnorm(12, 1,100), 3,3)
#' mcache = makeCacheMatrix(m)
#' inverse = cacheSolve(mcache)
#' 
#' =============================================================================
cacheSolve <- function(x, ...) {
    # -------------------------------- Retrieve the cached value for the inverse
    i <- x$getInverse()
    
    # ------- Return the cached value for the inverse if it's already calculated
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    
    # ----------------- Otherwise calculate the inverse, cache it, and return it
    data <- x$get()
    i <- solve(data, ...)
    x$setInverse(i)
    return(i)
}
