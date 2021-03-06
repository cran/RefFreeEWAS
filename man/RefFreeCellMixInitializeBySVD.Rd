\name{RefFreeCellMixInitializeBySVD}
\alias{RefFreeCellMixInitializeBySVD}
\title{Initialize Reference-Free Cell Mixture Projection by SVD}
\description{Initialize Reference-Free Cell Mixture Projection by SVD}
\usage{RefFreeCellMixInitializeBySVD(Y, type=1)}
\arguments{
  \item{Y}{Matrix (m CpGs x n Subjects) of DNA methylation beta values}
  \item{type}{See details}
}
\details{This method initializes the reference-free cell mixture deconvolution using an ad-hoc method based on singular value decomposition.  Type=1 will attempt to discretize Mu to 0/1, Type=2 will attempt to find a continuous range using column ranks. However, neither of these strategies is guaranteed to result in stable starting values for K larger than the "true" value of K.}
\value{Matrix of starting values for Mu.}
\author{E. Andres Houseman}
\seealso{\code{\link{RefFreeCellMix}},
\code{\link{RefFreeCellMixArrayWithCustomStart}}}
\examples{
data(HNSCC)
Y.shortTest <- Y.HNSCC.averageBetas[1:500,]
mu.start.svd <- RefFreeCellMixInitializeBySVD(Y.shortTest)
testArray2  <- RefFreeCellMixArrayWithCustomStart(Y.shortTest, mu.start=mu.start.svd,
    Klist=1:3,iters=5)
sapply(testArray2,deviance,Y=Y.shortTest)

\dontrun{
testBootDevs <- RefFreeCellMixArrayBySVDDevianceBoots(testArray2,Y.shortTest,R=10)

testBootDevs
apply(testBootDevs[-1,],2,mean,trim=0.25)
which.min(apply(testBootDevs[-1,],2,mean,trim=0.25))
}
}
