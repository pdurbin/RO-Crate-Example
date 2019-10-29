# RO-Crate-Example
An example of a Tale serialize under the RO-Crate draft specification




## Background

Whole Tale currently serializes Tale information and research artifacts according to the BagIt-RO specification, which can be found [here](https://github.com/ResearchObject/bagit-ro). To see an example of this format in action, visit dashboard.wholetale.org and [export a Tale as bag](https://wholetale.readthedocs.io/en/stable/users_guide/export_run.html). You'll find the metadata descriptions in the `metadata` folder.

The Research Object team has come out with a new specification, RO-Crate, and the Whole Tale project is interested in
1. What a Tale serialized in this format would look like
1. Key differences between the current implementation and RO-Crate
1. Advantages of using RO-Crate over the currently used specification
1. The scope of changes that need to be made to adopt it


## Tale Used

This repository uses the Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska Tale, which can be found [here](https://dashboard.wholetale.org/run/5db883ba7bf5ca3bf549cab3).

Some key characteristics of this Tale are
1. The use of an external dataset
1. The use of manually uploaded files (ie use of the Tale workspace)
1. Attribution to multiple authors (entities that deserve credit for code + data)
1. A single creator (The person that actually created the Tale)

Note that the Tale comes with a README, which has been renamed to README copy.md so that it doesn't conflict with this readme.

## Serialization

Whole Tale supports exporting to the bagit specification, which is compatible with RO-Crate.

From the RO-Crate spec,

```
Payload files may appear directly in the RO-Crate Root alongside the RO-Crate Metadata File, and/or appear in sub-directories of the RO-Crate Root.
```

This allows us to place RO-Crate artifacts along side the bagit artifacts, shown in the structure below. Note that the metadata directory will be depreciated/ merged into the ro-crate-metadata.jsonld file

Legend:

(1) File from BagIt

(2) File from RO-Crate

(3) File from Whole Tale

```
bag-info.txt (1)
bagit.txt (1)
data/ (3)
    LICENSE (3)
    workspace/ (3)
        analysis.R (3)
fetch.txt (1)
manifest-md5.txt (1)
manifest-sha256.txt (1)
metadata/
    environment.json
    manifest.json
README.MD
ro-crate-metadata.jsonld (2)
run-local.sh (3)
tagmanifest-md5.txt (1)
tagmanifest-sha256.txt (1)
```

Note that the RO-Crate artifacts at the top level _should_ be classified as tag files with respect to bagit.


The _only_ requirement as far as additional files go is the inclusion of `ro-crate-metadata.jsonld` which is present in this repository. I have not added support for the additional files that MAY be present, outlined below (taken from the spec)

```
<RO-Crate root directory>/
|   ro-crate-metadata.jsonld  # _RO-Crate Metadata File_ MUST be present
|   ro-crate-preview.html     # _RO-Crate Website_ homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [_RO-Crate Website_ files]
|   [payload files and directories]  # 1 or more SHOULD be present
```





## Changes

### Tale Creator

The Tale creator is the entity that physically created the Tale. It's possible that this person created the Tale for another person that has done the actual analysis work. 

#### Current

We currently describe the author with `createdBy`, which is an attribute to to the core Tale metadata object.
```
{
"@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
"createdOn": "2019-10-29 18:23:54.476000",
"createdBy": {
    "@id": "tommythelen@gmail.com",
    "@type": "schema:Person",
    "schema:email": "tommythelen@gmail.com",
    "schema:familyName": "T",
    "schema:givenName": "Thomas"
    }
}
```

#### RO-Crate

With RO-Crate, the Tale Creator is listed as the `contactPoint`, which is assigned to the chuck of metadata describing the overall Tale. Note that this _doesn't have to be an ORCID_. An email will suffice (see example in RO-Crate spec). After specifying the `contactPoint`, we go even further to describe that entity outside of the Tale context. 

```
{
   "@id": "./",
   "identifier": "5db883ba7bf5ca3bf549cab3",
   "@type": "Dataset",
   "datePublished": "2019",
   "name": "Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska",
   "distribution": {
       "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3"
   },
   
   "contactPoint": {
       "@id": "http://orcid.org/0000-0002-1756-2128"
     }
},

{
    "@id": "http://orcid.org/0000-0002-1756-2128",
    "@type": Person,
    "email": "tommythelen@gmail.com",
    "familyName": "Thelen",
    "givenName": "Thomas"
}
```

### Tale Authors

Tale Authors are entities that should be given credit to the code or to the data used in the Tale. Note that we can have multiple authors, which isn't shown here.

#### Current

We currently describe Tale authors using schema.

```
{
    "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
    "createdOn": "2019-10-29 18:23:54.476000",
    "schema:author": [
        {
            "@id": "https://orcid.org/0000-0003-3911-3304",
            "@type": "schema:Person",
            "schema:familyName": "Harrington",
            "schema:givenName": "Erin"
        }
    ],
}
```

#### RO-Crate

Note that the RO-Crate author isn't an array. I need to confirm that this can be done.
```
{
    "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
    "createdOn": "2019-10-29 18:23:54.476000",
    "author": {"@id": "https://orcid.org/0000-0003-3911-3304"},
}

{
    "@id": "https://orcid.org/0000-0003-3911-3304",
    "@type": "Person",
    "familyName": "Harrington",
    "givenName": "Erin"
}
```

#### Further Discussion

In Whole Tale, we may want to 

1. Make the Tale Creator the Author & `contactPoint`
2. Make current Authors [schema:contributor](https://schema.org/contributor) 


### External Data

#### Current:

We currently use RO-Bundle to describe files that exist remotely, and where they should exist locally when downloaded.

```
{
    "uri": "https://cn.dataone.org/cn/v2/resolve/urn:uuid:9d00544e-c206-47be-a875-2822821d2a94",
    "bundledAs": {
        "filename": "2015_Benchmark_Verbatims_Feb_2015.xlsx",
        "folder": "../data/data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/"
    },
    "size": 260096,
    "schema:isPartOf": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093"
}
```

#### RO-Crate


