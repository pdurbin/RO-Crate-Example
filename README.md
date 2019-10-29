# RO-Crate-Example
An example of a Tale serialize under the RO-Crate draft specification




## Background

Whole Tale currently serializes Tale information and research artifacts according to the ____ specification, which can be found [here](). To see an example of this format in action, visit dashboard.wholetale.org and [export a Tale as bag](). You'll find the metadata descriptions in the `metadata` folder.

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

This allows us to place RO-Crate artifacts along side the babgit artifacts, shown in the directory structure below.


Note that the RO-Crate artifacts at the top level _should_ be classified as tag files with respect to bagit.

