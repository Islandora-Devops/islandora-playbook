# Demo Release (Spring 2020)

This is a release to demonstrate the capabilities of the platform. It 
includes the content types, workflows and derivative-generation 
capabilities.

## Audience

This release is intended for potential implementors to assess the
platform's features and evaluate their use of Islandora 8 for an RDM
platform.

## Features

This platform is built on top of Islandora 8, see the [release notes for 
version 1.0.0](https://islandora.ca/content/islandora-8-now-available)
of Islandora 8 for full details. All of the features of Islandora 8
are directly available in the RDM platform

## Content Types

The following Islandora-compatible content types are provided by
the RDM platform:

### Dataset

Datasets store the metadata associated with an item deposited
in the repository, including contributor information, citation data,
internal and external identifiers, and information about its publication.

A user may then upload any number of files to associate with this 
dataset record via the Media tab.

### Data Management Plan

The Data Management Plan content type guides a user through the
questions that comprise the DMP, with extensive help text.

Once a plan is saved it is then sent through a similar review and curation
workflow to Datasets. Since DMPs are documents, the site platform has
incorporated the ability to export the DMP items directly as PDFs.

### Funding Information

This is a helper type used by Dataset and DMP types to store information
about how the project the item is a part of was funded.

### Media Types

In Islandora, a Media object is a wrapper for an uploaded file that contains
metadata about the file to assist in storing it in the Fedora preservation
back-end as well as offering custom display capabilities for various
types of files.

The RDM platform extends the standard Islandora media types with
the Multifile Media capability developed for this project. Additionally
the Tabular Data media type is available for uploading data such as
CSV files and spreadsheets.

## Multi-file Media

The major architectural innovation included in the RDM platform
over Islandora 8 core is the ability to generate derivative files streams
and attach them to Media objects. Thus original file's are grouped 
along with the derived datastreams such as thumbnails, service files,
 alternate formates and text transcripts. This facilitates site builders'
 ability to easily construct themes to display custom media types.
 
 It is expected that this model will be incorporated in a forthcoming Islandora
 feature release.

## Workflows

The release includes pre-defined publication review and curation
workflow. Site administrators can easily create users with roles
for Research Data User, Data Curator and Metadata Curator.

Metadata Curators are responsible for reviewing Datasets and Data Management
Plans. When a user with this role logs in, they are presented with a 
dashboard overview to quickly access content in the review state.

Data Curator users are similarly tasked with reviewing and publishing
Media items attached to Dataset objects. Administrators can assign
both curation roles to one user if desired.

### Workflow Participants

Besides designating an item as being ready for a curator to review it, users
with the Research Data User role may also make an item viewable by other
users of the system directly via the 'Workflow Participants' tab. They may
grant read-only or edit access to other users to solicit feedback at any time.

## Event Logging
 
All updates to and actions performed on the Dataset and DMP items
and their associated media are logged, so users with the Curator role
can get an overview of all changes made to any item.
 
## Microservices
 
The following microservices were developed for this project and have either
been accepted in to Islandora 8 or may be in the future. They are all
standalone services that any Islandora site may install on their own
or via the RDM platform.
 
### FITS
 
 Extracts useful data out of binary files such as image dimensions.
 
###  RipRap

Performs periodic integrity checks on files in the system and allows
curator users to view reports when problems arise.

### Bagit

This service creates a downloadable archive of an item on the 
site for personal use or future data harvesting and archiving 
applications.

