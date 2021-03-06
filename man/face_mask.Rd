% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/face_mask.R
\name{ct_face_mask}
\alias{ct_face_mask}
\alias{ct_face_mask,mri_face_mask}
\alias{mri_face_mask}
\title{Create Mask of the Face}
\usage{
ct_face_mask(
  file,
  skull_strip = TRUE,
  mask = NULL,
  robust = TRUE,
  template.file = system.file(ifelse(skull_strip, "scct_unsmooth_SS_0.01.nii.gz",
    "scct_unsmooth.nii.gz"), package = "ichseg"),
  template.face_mask = NULL,
  template.face_mask_inds = list(50:130, 170:217, 1:15),
  extend_mask = TRUE,
  typeofTransform = "Affine",
  swapdim = TRUE,
  verbose = TRUE,
  ...
)

mri_face_mask(
  ...,
  skull_strip = TRUE,
  mask = NULL,
  robust = FALSE,
  template.file = mni_fname(brain = skull_strip)
)
}
\arguments{
\item{file}{File for face masking - either filename or class nifti}

\item{skull_strip}{Should the data require skull stripping if
no mask is provided?}

\item{mask}{file or \code{nifti} to mask the \code{file}}

\item{robust}{If \code{mask = NULL}, then \code{robust} is
passed to \code{\link{CT_Skull_Stripper}}}

\item{template.file}{Template to warp to original image space}

\item{template.face_mask}{Mask of template to use as rough face mask.  If
\code{template.file} is not specified, \code{template.face_mask_inds}
must be}

\item{template.face_mask_inds}{List of length 3 for indices of
\code{template.file} to indicate the mask.}

\item{extend_mask}{after transformation, should the mask be extended to the
front of the image to ensure all face has been removed?}

\item{typeofTransform}{Transformation for template to image, passed to
\code{\link{ants_regwrite}}.}

\item{swapdim}{Should the dimensions be swapped before registration,
and then reset after}

\item{verbose}{Print out diagnostic messages}

\item{...}{arguments passed to \code{\link{CT_Skull_Stripper}}}
}
\value{
Object of class nifti
}
\description{
Creates a rough mask of the face from a head scan
}
\examples{
\dontrun{
file = "~/Desktop/Desktop/scratch/100-318_20070723_0957_CT_3_CT_Head-.nii.gz"
mask = NULL
robust = FALSE
face = ct_face_mask(
   file = file,
   robust = FALSE
   )
 img = readnii(file)
 rimg = randomize_mask(img, mask = face)
}

\dontrun{
library(fslr)
library(extrantsr)
mri = "~/Desktop/Desktop/scratch/SUBJ0001-01-MPRAGE.nii.gz"

template.file = mni_fname(brain = TRUE)
tmask = mni_fname(brain = TRUE, mask = TRUE)

template.face_mask_inds = list(50:130, 170:217, 1:15)
brain = fslbet_robust(mri,
remove.neck = TRUE,
remover = "double_remove_neck",
template.file = template.file,
template.mask = tmask)
mask = brain > 0
img = brain
template.face_mask = NULL
verbose = TRUE
face = mri_face_mask(
   file = img,
   mask = mask,
   template.file = template.file
   )
}

}
