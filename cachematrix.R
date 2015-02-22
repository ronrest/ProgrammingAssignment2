## =============================================================================
## Calculating the inverse of matrices is computationally expensive. In order to 
## avoid calculating this repeatedly, this collection of functions can be used  
## as a means of caching the calculation.
## =============================================================================


#' =============================================================================
#' Creates a special object that is used to cache the inverse of a matrix
#' 
#' @param x A matrix object to be inverted
#' @return A list of functions (set, get, setInverse, getInverse)
#' @examples
#' m = matrix(rnorm(12), 4,4)
#' makeCacheMatrix(m)
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
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}

