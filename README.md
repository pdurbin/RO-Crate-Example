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

This allows us to place RO-Crate artifacts along side the babgit artifacts, shown in the structure below. Note that the metadata directory will be depreciated/ merged into the ro-crate-metadata.jsonld file

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



