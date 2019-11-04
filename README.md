# RO-Crate-Example
An example of a Tale serialize under the RO-Crate draft specification




## Background

Whole Tale currently serializes Tale information and research artifacts according to the BagIt-RO and RO Bundle specifications, which can be found [here](https://github.com/ResearchObject/bagit-ro ) and [here](https://researchobject.github.io/specifications/bundle/). To see an example of this format in action, visit https://dashboard.wholetale.org/ and [export a Tale as bag](https://wholetale.readthedocs.io/en/stable/users_guide/export_run.html). You'll find the metadata descriptions in the `metadata/` folder.

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

Note that the Tale comes with a README, which has been renamed to README copy.md so that it doesn't conflict with this readme (the one you're currently reading).

## Things Missing

1. It looks like RO-Crate describes external data from http sources and repositories differently (there are only mentions of repository objects). This example only includes external data from a repository

## Resources

1. [RO-Crate 2.0 Spec](https://researchobject.github.io/ro-crate/0.2/)

1. [RO-Crate GitHub](https://github.com/ResearchObject/ro-crate)

1. [RO-Crate for Python](https://github.com/researchobject/ro-crate-py)

1. [RO-Crate Meeting Notes](https://docs.google.com/document/d/1vg805CJ4QXY6CCBNR-8ETgkbOCAMqSKJPCKOTNxrIbk)

## File Diretory Changes

Adopting RO-Crate will change the directory of exported Tales, minimally.

Key elements from the spec include

`Payload files may appear directly in the RO-Crate Root alongside the RO-Crate Metadata File, and/or appear in sub-directories of the RO-Crate Root.`

This allows us to place the Crate payload in the same directory as the RO-Crate Root or within a subdirectory. This is further supported with the blurb below.

```
<RO-Crate root directory>/
|   ro-crate-metadata.jsonld  # _RO-Crate Metadata File_ MUST be present
|   ro-crate-preview.html     # _RO-Crate Website_ homepage MAY be present
|   ro-crate-preview_files/   # MAY be present
|    | [_RO-Crate Website_ files]
|   [payload files and directories]  # 1 or more SHOULD be present
```


The _only_ requirement as far as additional files go is the inclusion of `ro-crate-metadata.jsonld` which is present in this repository. I have not added support for the additional files that MAY be present, outlined below (taken from the spec). Note that the RO-Crate Root is determined by the location of `ro-crate-metadata.jsonld`.

`RO-Crate Root: The top-level directory of the RO-Crate, indicated by the presence of the RO-Crate Metadata File ro-crate-metadata.jsonld`

One key question that remains is where we should place the RO-Crate Root. This is explored below.

### Invariants

Some things don't change between formats. 

1. `run-local.sh` is a tag file
1. `README.MD` is a tag file
1. `fetch.txt` is a tag file


### RO-Crate Root at Bag Root

This first example shows what a Tale looks like when the RO-Crate Root is in the same location as the Bag Root

Legend:

(1) File from BagIt

(2) File from RO-Crate

(3) File from Whole Tale

```
bag-info.txt (1)
bagit.txt (1)
data/ (1)
    LICENSE (3)
    workspace/ (3)
        analysis.R (3)
fetch.txt (1)
manifest-md5.txt (1)
manifest-sha256.txt (1)
README.MD (3)
ro-crate-metadata.jsonld (2)
run-local.sh (3)
tagmanifest-md5.txt (1)
tagmanifest-sha256.txt (1)
```

#### Advantages

1. It's minimally invasive. We've gotten rid of the `metadata/` directory and keep the exact same `data/` structure.
2. Defines the bag _as_ a Research Object (rather than a bag that contains a Research Object)

#### Disadvantages

1. More `stuff` in the root directory which is an eye sore and confusing (opinion)


### RO-Crate Root in Bag Payload

We can also place the RO-Crate Root in the bag payload.

```
bag-info.txt (1)
bagit.txt (1)
data/ (1)
    ro-crate-metadata.jsonld (2)
    LICENSE (3)
    workspace/ (3)
        analysis.R (3)
fetch.txt (1)
manifest-md5.txt (1)
manifest-sha256.txt (1)
README.MD (3)
run-local.sh (3)
tagmanifest-md5.txt (1)
tagmanifest-sha256.txt (1)
```

#### Advantages

1. Less `stuff` in the bag root.
2. Defines a bag that _contains_ a Research Object (rather than a bag that _is_)
3. Minimally invasive. We still get to throw WT things into the `data/` directory

#### Disadvantages

1. More `stuff` in the data directory


### Summary

It doesn't make much of a difference where we decide to place `ro-crate-metadata.jsonld`. Peter Sefton on the RO-Crate team gave his opinion on the two, and seemed to be impartial.

```
The DataCrate format which informed RO-Crate explicitly stated that the
metadata should be in the root directory, but RO-Crate is agnostic on this
point - you can do either.

The first approach means that:
Metadata (including the ro-crate-preview.html file you have not shown) is
more discoverable when someone opens the bagit archive
You can change the metadata without changing the payload / checksums

The second gives you more assurance that the files are as expected as the
metadata and preview files have checksums.
```

## Metadata Changes

The snippets below are pieces from `ro-crate-metadata.jsonld`.

- [Tale Creator](#Tale-Creator)
  * [Current](#Current)
  * [RO-Crate](#RO-Crate)
- [Tale Authors](#Tale-Authors)
  * [Current](#Current)
  * [RO-Crate](#RO-Crate)
- [External Data](#External-Data)
  * [Current](#Current)
  * [RO-Crate](#RO-Crate)
- [Physical Data](#Physical-Data)
  * [Current](#Current)
  * [RO-Crate](#RO-Crate)
- [Datasets](#Datasets)
  * [Current](#Current)
  * [RO-Crate](#RO-Crate)
- [Misc Tale Properties](#Misc-Tale-Properties)
  * [Current](#Current)
  * [RO-Crate](#RO-Crate)
    
    


### Tale-Creator

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

The RO-Crate spec states the the type of the object pointed to by @id for the `contactPoint` _SHOULD_ be  [ContactPoint](https://schema.org/ContactPoint). This may get confusing when the same entity fulfills multiple roles. For example, this Tale has an author that's also the `contactPoint`. The spec requires the person to be listed as type `ContactPoint`, but should also be listed as type `Person`. This is a required field to be considered a valid RO. 
```
{
    "@id": "http://orcid.org/0000-0002-1756-2128",
    "@type": ContactPoint,
    "email": "tommythelen@gmail.com",
}
```


### Tale-Authors

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
        },
        {
            "@id": "http://orcid.org/0000-0002-1756-2128",
            "@type": "schema:Person",
            "schema:familyName": "Thelen",
            "schema:givenName": "Thomas"
        }
    ],
}
```

#### RO-Crate

The Author descriptions are done in a similar fashion to the contactPoint.

```
{
    {
        "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
        "createdOn": "2019-10-29 18:23:54.476000",
        "author": [
            {"@id": "https://orcid.org/0000-0003-3911-3304"},
            {"@id": "http://orcid.org/0000-0002-1756-2128"},
        ],
    },

    {
        "@id": "https://orcid.org/0000-0003-3911-3304",
        "@type": "Person",
        "familyName": "Harrington",
        "givenName": "Erin"
    },

    {
        "@id": "http://orcid.org/0000-0002-1756-2128",
        "@type": "Person",
        "familyName": "Thelen",
        "givenName": "Thomas"
    },
}
```

#### Further Discussion

In Whole Tale, we may want to 

1. Merge the Author and Creator (point `contactPoint` and `author` to the Tale Creator)
2. Make current Authors [schema:contributor](https://schema.org/contributor)
3. I need to confirm we can have multiple authors/contributors

### External-Data

#### Current:

We currently use RO-Bundle to describe files that exist remotely, and where they should exist locally when downloaded. We also document/link the file to the larger dataset that the file belongs to.


```
{
    "uri": "https://cn.dataone.org/cn/v2/resolve/urn:uuid:9d00544e-c206-47be-a875-2822821d2a94",
    "bundledAs": {
        "filename": "2015_Benchmark_Verbatims_Feb_2015.xlsx",
        "folder": "../data/data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/"
    },
    "size": 260096,
    "schema:isPartOf": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093"
},

{
    "uri": "https://cn.dataone.org/cn/v2/resolve/urn:uuid:cfc3c111-155b-4ab9-958b-5f3bba6d3dde",
    "bundledAs": {
        "filename": "2014_Benchmark_FINAL_Survey_Report.pdf",
        "folder": "../data/data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/"
    },
    "size": 754952,
    "schema:isPartOf": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093"
},

"Datasets": [
    {
        "@id": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093",
        "name": "Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences",
        "@type": "Dataset",
        "identifier": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093"
    }
]
```

#### RO-Crate

Desribing external data with RO-Crate is quite cumbersome. Instead of listing files and pointing them to a repository, we now define the repository and list all of the assosiated files within it with `hasMember` (using the web URI as the @id). Next, we loop over each element in `hasMemeber` and create a new metadata structure that has type `RepositoryObject`. Within this structure we can define the license, title, etc. The important part is that we can define the local location of where this file should go with `hasFile`. Finally, once we have these structures built, we create a new entry for each local file that we defined. See below.  

```
{
    "@id":https://cn.dataone.org/cn/v2/resolve/urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093",
    "@type":["RepositoryCollection"],
    "title": ["Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences"],
    "hasMember":[
        {"@id":"https://cn.dataone.org/cn/v2/resolve/urn:uuid:9d00544e-c206-47be-a875-2822821d2a94"},
        {"@id":"https://cn.dataone.org/cn/v2/resolve/urn:uuid:cfc3c111-155b-4ab9-958b-5f3bba6d3dde"},
    ]
},

{
    "@id": "https://cn.dataone.org/cn/v2/resolve/urn:uuid:9d00544e-c206-47be-a875-2822821d2a94",
    "@type": "RepositoryObject",
    "title":["2015_Benchmark_Verbatims_Feb_2015.xlsx"],
    "identifier":"urn:uuid:9d00544e-c206-47be-a875-2822821d2a94",
    "hasFile": [
        {"@id": "./data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/2015_Benchmark_Verbatims_Feb_2015.xlsx"
    ]}
}

{
    "@id": "https://cn.dataone.org/cn/v2/resolve/urn:uuid:cfc3c111-155b-4ab9-958b-5f3bba6d3dde",
    "@type": "RepositoryObject",
    "title":["2014_Benchmark_FINAL_Survey_Report.pdf"],
    "identifier":"urn:uuid:cfc3c111-155b-4ab9-958b-5f3bba6d3dde",
    "hasFile": [
        {"@id": "./data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/2014_Benchmark_FINAL_Survey_Report.pdf"
    ]}
}

{
    "@type: "File",
    "@id": "./data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/2015_Benchmark_Verbatims_Feb_2015.xlsx",
    "size": 260096,
}

{
    "@type: "File",
    "@id": "./data/Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences/2014_Benchmark_FINAL_Survey_Report.pdf",
    "size": 754952,
}

```


### Physical-Data

#### Current

```
{
    "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
    "createdOn": "2019-10-29 18:23:54.476000",
    "aggregates" [
        {
            "uri": "../data/workspace/analysis.R",
            "size": 0,
            "mimeType": "application/octet-stream",
            "md5": "d41d8cd98f00b204e9800998ecf8427e"
        },
    ]
}
```

#### RO-Crate

One difference is that RO-Crate includes a record for directories. Note that the file/directory descriptions are inside the graph.

```
{
    "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
    "createdOn": "2019-10-29 18:23:54.476000",
    "@graph": [
     {
       "@id": "./data",
       "@type": [
         "Dataset"
       ],
       "hasPart" [
        {
            "@id": "./data/workspace"
        },
        {
            "@id": "./data/workspace/analysis.R"
        },
    ]

    {
        "@id": "data/workspace/analysis.R",
        "@type": "File",
        "contentSize": "0",
        "encodingFormat": "application/octet-stream"
    },
    {
        "uri": "../data/workspace",
        "@type": "Dataset",
    },
    ]
}
```




### Datasets

#### Current

As shown in the External-Data section above, we currently describe external datasets with

```
"Datasets": [
{
    "@id": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093",
    "name": "Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska, including Values, Tradeoffs and Preferences",
    "@type": "Dataset",
    "identifier": "urn:uuid:c781356d-5306-4aa2-b633-7f8bc768c093"
}
```

#### RO-Crate

To see how a dataset is described in RO-Crate, refer to the External-Data section.

### Misc-Tale-Properties

We have a number of miscellaneous Tale properties that already use schema. We should make sure these make sense and are used properly within an RO-Crate.

#### Current

```
 "schema:name": "Quantitative and Qualitative Longitudinal Public Opinion Survey Research on Salmon and Alaska",
 "schema:description": "#### Markdown Editor",
 "schema:identifier": "5db883ba7bf5ca3bf549cab3",
 "schema:image": "https://raw.githubusercontent.com/whole-tale/dashboard/master/public/images/demo-graph2.jpg",
 "schema:version": 7,
 "schema:category": "science",
 "@id": "https://data.wholetale.org/api/v1/tale/5db883ba7bf5ca3bf549cab3",
 "createdOn": "2019-10-29 18:23:54.476000",
```



#### RO-Crate




## To-Do

1. Resolve where we put the RO-Crate Root
1. Should we turn the author into a contributor, and then merge the author and creator?
1. Resolve `contactPoint` weirdness
1. Do we _really_ need to include entries for directories?
