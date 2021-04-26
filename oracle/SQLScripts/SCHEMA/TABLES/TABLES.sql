-- 3D City Database - The Open Source CityGML Database
-- https://www.3dcitydb.org/
--
-- Copyright 2013 - 2021
-- Chair of Geoinformatics
-- Technical University of Munich, Germany
-- https://www.lrg.tum.de/gis/
--
-- The 3D City Database is jointly developed with the following
-- cooperation partners:
--
-- Virtual City Systems, Berlin <https://vc.systems/>
-- M.O.S.S. Computer Grafik Systeme GmbH, Taufkirchen <http://www.moss.de/>
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

CREATE TABLE ADE 
(
  ID NUMBER NOT NULL 
, ADEID VARCHAR2(256) NOT NULL 
, NAME VARCHAR2(1000) NOT NULL 
, DESCRIPTION VARCHAR2(4000) 
, VERSION VARCHAR2(50) 
, DB_PREFIX VARCHAR2(10) NOT NULL 
, XML_SCHEMAMAPPING_FILE CLOB 
, DROP_DB_SCRIPT CLOB 
, CREATION_DATE TIMESTAMP WITH TIME ZONE 
, CREATION_PERSON VARCHAR2(256) 
, CONSTRAINT ADE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE AGGREGATION_INFO 
(
  CHILD_ID NUMBER NOT NULL 
, PARENT_ID NUMBER NOT NULL 
, JOIN_TABLE_OR_COLUMN_NAME VARCHAR2(30) NOT NULL 
, MIN_OCCURS NUMBER 
, MAX_OCCURS NUMBER 
, IS_COMPOSITE NUMBER(1, 0) 
, CONSTRAINT AGGREGATION_INFO_PK PRIMARY KEY 
  (
    CHILD_ID 
  , PARENT_ID 
  , JOIN_TABLE_OR_COLUMN_NAME 
  )
  ENABLE 
);

CREATE TABLE DATABASE_SRS 
(
  SRID NUMBER(38, 0) NOT NULL 
, GML_SRS_NAME VARCHAR2(1000) 
, CONSTRAINT DATABASE_SRS_PK PRIMARY KEY 
  (
    SRID 
  )
  ENABLE 
);

CREATE TABLE TEX_IMAGE 
(
  ID NUMBER NOT NULL 
, TEX_IMAGE_URI VARCHAR2(4000) 
, TEX_IMAGE_DATA BLOB 
, TEX_MIME_TYPE VARCHAR2(256) 
, TEX_MIME_TYPE_CODESPACE VARCHAR2(4000) 
, CONSTRAINT TEX_IMAGE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE OBJECTCLASS 
(
  ID NUMBER NOT NULL 
, IS_ADE_CLASS NUMBER(1, 0) 
, IS_TOPLEVEL NUMBER(1, 0) 
, CLASSNAME VARCHAR2(256) 
, TABLENAME VARCHAR2(30) 
, SUPERCLASS_ID NUMBER 
, BASECLASS_ID NUMBER 
, ADE_ID NUMBER 
, CONSTRAINT OBJECTCLASS_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE SCHEMA 
(
  ID NUMBER NOT NULL 
, IS_ADE_ROOT NUMBER(1, 0) NOT NULL 
, CITYGML_VERSION VARCHAR2(50) NOT NULL 
, XML_NAMESPACE_URI VARCHAR2(4000) NOT NULL 
, XML_NAMESPACE_PREFIX VARCHAR2(50) NOT NULL 
, XML_SCHEMA_LOCATION VARCHAR2(4000) 
, XML_SCHEMAFILE BLOB 
, XML_SCHEMAFILE_TYPE VARCHAR2(256) 
, ADE_ID NUMBER 
, CONSTRAINT SCHEMA_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE ADDRESS 
(
  ID NUMBER NOT NULL 
, GMLID VARCHAR2(256) 
, GMLID_CODESPACE VARCHAR2(1000) 
, STREET VARCHAR2(1000) 
, HOUSE_NUMBER VARCHAR2(256) 
, PO_BOX VARCHAR2(256) 
, ZIP_CODE VARCHAR2(256) 
, CITY VARCHAR2(256) 
, STATE VARCHAR2(256) 
, COUNTRY VARCHAR2(256) 
, MULTI_POINT MDSYS.SDO_GEOMETRY 
, XAL_SOURCE CLOB 
, CONSTRAINT ADDRESS_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE CITYMODEL 
(
  ID NUMBER NOT NULL 
, GMLID VARCHAR2(256) 
, GMLID_CODESPACE VARCHAR2(1000) 
, NAME VARCHAR2(1000) 
, NAME_CODESPACE VARCHAR2(4000) 
, DESCRIPTION VARCHAR2(4000) 
, ENVELOPE MDSYS.SDO_GEOMETRY 
, CREATION_DATE TIMESTAMP WITH TIME ZONE 
, TERMINATION_DATE TIMESTAMP WITH TIME ZONE 
, LAST_MODIFICATION_DATE TIMESTAMP WITH TIME ZONE 
, UPDATING_PERSON VARCHAR2(256) 
, REASON_FOR_UPDATE VARCHAR2(4000) 
, LINEAGE VARCHAR2(256) 
, CONSTRAINT CITYMODEL_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE CITYOBJECT 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, GMLID VARCHAR2(256) 
, GMLID_CODESPACE VARCHAR2(1000) 
, NAME VARCHAR2(1000) 
, NAME_CODESPACE VARCHAR2(4000) 
, DESCRIPTION VARCHAR2(4000) 
, ENVELOPE MDSYS.SDO_GEOMETRY 
, CREATION_DATE TIMESTAMP WITH TIME ZONE 
, TERMINATION_DATE TIMESTAMP WITH TIME ZONE 
, RELATIVE_TO_TERRAIN VARCHAR2(256) 
, RELATIVE_TO_WATER VARCHAR2(256) 
, LAST_MODIFICATION_DATE TIMESTAMP WITH TIME ZONE 
, UPDATING_PERSON VARCHAR2(256) 
, REASON_FOR_UPDATE VARCHAR2(4000) 
, LINEAGE VARCHAR2(256) 
, XML_SOURCE CLOB 
, CONSTRAINT CITYOBJECT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE SURFACE_DATA 
(
  ID NUMBER NOT NULL 
, GMLID VARCHAR2(256) 
, GMLID_CODESPACE VARCHAR2(1000) 
, NAME VARCHAR2(1000) 
, NAME_CODESPACE VARCHAR2(4000) 
, DESCRIPTION VARCHAR2(4000) 
, IS_FRONT NUMBER(1, 0) 
, OBJECTCLASS_ID NUMBER NOT NULL 
, X3D_SHININESS BINARY_DOUBLE 
, X3D_TRANSPARENCY BINARY_DOUBLE 
, X3D_AMBIENT_INTENSITY BINARY_DOUBLE 
, X3D_SPECULAR_COLOR VARCHAR2(256) 
, X3D_DIFFUSE_COLOR VARCHAR2(256) 
, X3D_EMISSIVE_COLOR VARCHAR2(256) 
, X3D_IS_SMOOTH NUMBER(1, 0) 
, TEX_IMAGE_ID NUMBER 
, TEX_TEXTURE_TYPE VARCHAR2(256) 
, TEX_WRAP_MODE VARCHAR2(256) 
, TEX_BORDER_COLOR VARCHAR2(256) 
, GT_PREFER_WORLDFILE NUMBER(1, 0) 
, GT_ORIENTATION VARCHAR2(256) 
, GT_REFERENCE_POINT MDSYS.SDO_GEOMETRY 
, CONSTRAINT SURFACE_DATA_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE SCHEMA_REFERENCING 
(
  REFERENCING_ID NUMBER NOT NULL 
, REFERENCED_ID NUMBER NOT NULL 
, CONSTRAINT SCHEMA_REFERENCING_PK PRIMARY KEY 
  (
    REFERENCING_ID 
  , REFERENCED_ID 
  )
  ENABLE 
);

CREATE TABLE SCHEMA_TO_OBJECTCLASS 
(
  SCHEMA_ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL  
, CONSTRAINT SCHEMA_TO_OBJECTCLASS_PK PRIMARY KEY 
  (
    SCHEMA_ID 
  , OBJECTCLASS_ID 
  )
  ENABLE 
);

CREATE TABLE APPEARANCE 
(
  ID NUMBER NOT NULL 
, GMLID VARCHAR2(256) 
, GMLID_CODESPACE VARCHAR2(1000) 
, NAME VARCHAR2(1000) 
, NAME_CODESPACE VARCHAR2(4000) 
, DESCRIPTION VARCHAR2(4000) 
, THEME VARCHAR2(256) 
, CITYMODEL_ID NUMBER 
, CITYOBJECT_ID NUMBER 
, CONSTRAINT APPEARANCE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE CITYOBJECT_MEMBER 
(
  CITYMODEL_ID NUMBER NOT NULL 
, CITYOBJECT_ID NUMBER NOT NULL 
, CONSTRAINT CITYOBJECT_MEMBER_PK PRIMARY KEY 
  (
    CITYMODEL_ID 
  , CITYOBJECT_ID 
  )
  ENABLE 
);

CREATE TABLE EXTERNAL_REFERENCE 
(
  ID NUMBER NOT NULL 
, INFOSYS VARCHAR2(4000) 
, NAME VARCHAR2(4000) 
, URI VARCHAR2(4000) 
, CITYOBJECT_ID NUMBER
, CONSTRAINT EXTERNAL_REFERENCE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE GENERALIZATION 
(
  CITYOBJECT_ID NUMBER NOT NULL 
, GENERALIZES_TO_ID NUMBER NOT NULL 
, CONSTRAINT GENERALIZATION_PK PRIMARY KEY 
  (
    CITYOBJECT_ID 
  , GENERALIZES_TO_ID 
  )
  ENABLE 
);

CREATE TABLE RELIEF_COMPONENT 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, LOD NUMBER(1) 
, EXTENT MDSYS.SDO_GEOMETRY 
, CONSTRAINT RELIEF_COMPONENT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE RELIEF_FEATURE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, LOD NUMBER(1) 
, CONSTRAINT RELIEF_FEATURE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE SURFACE_GEOMETRY 
(
  ID NUMBER NOT NULL 
, GMLID VARCHAR2(256) 
, GMLID_CODESPACE VARCHAR2(1000) 
, PARENT_ID NUMBER 
, ROOT_ID NUMBER 
, IS_SOLID NUMBER(1, 0) 
, IS_COMPOSITE NUMBER(1, 0) 
, IS_TRIANGULATED NUMBER(1, 0) 
, IS_XLINK NUMBER(1, 0) 
, IS_REVERSE NUMBER(1, 0) 
, GEOMETRY MDSYS.SDO_GEOMETRY 
, SOLID_GEOMETRY MDSYS.SDO_GEOMETRY 
, IMPLICIT_GEOMETRY MDSYS.SDO_GEOMETRY 
, CITYOBJECT_ID NUMBER 
, CONSTRAINT SURFACE_GEOMETRY_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE APPEAR_TO_SURFACE_DATA 
(
  SURFACE_DATA_ID NUMBER NOT NULL 
, APPEARANCE_ID NUMBER NOT NULL 
, CONSTRAINT APPEAR_TO_SURFACE_DATA_PK PRIMARY KEY 
  (
    SURFACE_DATA_ID 
  , APPEARANCE_ID 
  )
  ENABLE 
);

CREATE TABLE BREAKLINE_RELIEF 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, RIDGE_OR_VALLEY_LINES MDSYS.SDO_GEOMETRY 
, BREAK_LINES MDSYS.SDO_GEOMETRY 
, CONSTRAINT BREAKLINE_RELIEF_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE MASSPOINT_RELIEF 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, RELIEF_POINTS MDSYS.SDO_GEOMETRY 
, CONSTRAINT MASSPOINT_RELIEF_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE RELIEF_FEAT_TO_REL_COMP 
(
  RELIEF_COMPONENT_ID NUMBER NOT NULL 
, RELIEF_FEATURE_ID NUMBER NOT NULL 
, CONSTRAINT RELIEF_FEAT_TO_REL_COMP_PK PRIMARY KEY 
  (
    RELIEF_COMPONENT_ID 
  , RELIEF_FEATURE_ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, BRIDGE_PARENT_ID NUMBER 
, BRIDGE_ROOT_ID NUMBER 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, YEAR_OF_CONSTRUCTION DATE 
, YEAR_OF_DEMOLITION DATE 
, IS_MOVABLE NUMBER(1, 0) 
, LOD1_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD3_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD4_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD3_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD4_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD1_SOLID_ID NUMBER 
, LOD2_SOLID_ID NUMBER 
, LOD3_SOLID_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT BRIDGE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BUILDING 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, BUILDING_PARENT_ID NUMBER 
, BUILDING_ROOT_ID NUMBER 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, YEAR_OF_CONSTRUCTION DATE 
, YEAR_OF_DEMOLITION DATE 
, ROOF_TYPE VARCHAR2(256) 
, ROOF_TYPE_CODESPACE VARCHAR2(4000) 
, MEASURED_HEIGHT BINARY_DOUBLE 
, MEASURED_HEIGHT_UNIT VARCHAR2(4000) 
, STOREYS_ABOVE_GROUND NUMBER(8) 
, STOREYS_BELOW_GROUND NUMBER(8) 
, STOREY_HEIGHTS_ABOVE_GROUND VARCHAR2(4000) 
, STOREY_HEIGHTS_AG_UNIT VARCHAR2(4000) 
, STOREY_HEIGHTS_BELOW_GROUND VARCHAR2(4000) 
, STOREY_HEIGHTS_BG_UNIT VARCHAR2(4000) 
, LOD1_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD3_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD4_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD3_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD4_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD0_FOOTPRINT_ID NUMBER 
, LOD0_ROOFPRINT_ID NUMBER 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD1_SOLID_ID NUMBER 
, LOD2_SOLID_ID NUMBER 
, LOD3_SOLID_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT BUILDING_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE CITYOBJECTGROUP 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BREP_ID NUMBER 
, OTHER_GEOM MDSYS.SDO_GEOMETRY 
, PARENT_CITYOBJECT_ID NUMBER 
, CONSTRAINT CITYOBJECTGROUP_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE CITYOBJECT_GENERICATTRIB 
(
  ID NUMBER NOT NULL 
, PARENT_GENATTRIB_ID NUMBER 
, ROOT_GENATTRIB_ID NUMBER 
, ATTRNAME VARCHAR2(256) NOT NULL 
, DATATYPE NUMBER(1) 
, STRVAL VARCHAR2(4000) 
, INTVAL NUMBER 
, REALVAL NUMBER 
, URIVAL VARCHAR2(4000) 
, DATEVAL TIMESTAMP WITH TIME ZONE 
, UNIT VARCHAR2(4000) 
, GENATTRIBSET_CODESPACE VARCHAR2(4000) 
, BLOBVAL BLOB 
, GEOMVAL MDSYS.SDO_GEOMETRY 
, SURFACE_GEOMETRY_ID NUMBER 
, CITYOBJECT_ID NUMBER
, CONSTRAINT CITYOBJ_GENERICATTRIB_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE IMPLICIT_GEOMETRY 
(
  ID NUMBER NOT NULL 
, MIME_TYPE VARCHAR2(256) 
, REFERENCE_TO_LIBRARY VARCHAR2(4000) 
, LIBRARY_OBJECT BLOB 
, RELATIVE_BREP_ID NUMBER 
, RELATIVE_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, CONSTRAINT IMPLICIT_GEOMETRY_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE LAND_USE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, LOD0_MULTI_SURFACE_ID NUMBER 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, CONSTRAINT LAND_USE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE PLANT_COVER 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, AVERAGE_HEIGHT BINARY_DOUBLE 
, AVERAGE_HEIGHT_UNIT VARCHAR2(4000) 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD1_MULTI_SOLID_ID NUMBER 
, LOD2_MULTI_SOLID_ID NUMBER 
, LOD3_MULTI_SOLID_ID NUMBER 
, LOD4_MULTI_SOLID_ID NUMBER 
, CONSTRAINT PLANT_COVER_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TEXTUREPARAM 
(
  SURFACE_GEOMETRY_ID NUMBER NOT NULL 
, IS_TEXTURE_PARAMETRIZATION NUMBER(1, 0) 
, WORLD_TO_TEXTURE VARCHAR2(1000) 
, TEXTURE_COORDINATES MDSYS.SDO_GEOMETRY 
, SURFACE_DATA_ID NUMBER NOT NULL 
, CONSTRAINT TEXTUREPARAM_PK PRIMARY KEY 
  (
    SURFACE_GEOMETRY_ID 
  , SURFACE_DATA_ID 
  )
  ENABLE 
);

CREATE TABLE TIN_RELIEF 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, MAX_LENGTH BINARY_DOUBLE 
, MAX_LENGTH_UNIT VARCHAR2(4000) 
, STOP_LINES MDSYS.SDO_GEOMETRY 
, BREAK_LINES MDSYS.SDO_GEOMETRY 
, CONTROL_POINTS MDSYS.SDO_GEOMETRY 
, SURFACE_GEOMETRY_ID NUMBER 
, CONSTRAINT TIN_RELIEF_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TRANSPORTATION_COMPLEX 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, LOD0_NETWORK MDSYS.SDO_GEOMETRY 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, CONSTRAINT TRANSPORTATION_COMPLEX_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, TUNNEL_PARENT_ID NUMBER 
, TUNNEL_ROOT_ID NUMBER 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, YEAR_OF_CONSTRUCTION DATE 
, YEAR_OF_DEMOLITION DATE 
, LOD1_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD3_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD4_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD3_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD4_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD1_SOLID_ID NUMBER 
, LOD2_SOLID_ID NUMBER 
, LOD3_SOLID_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT TUNNEL_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE WATERBODY 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, LOD0_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD1_MULTI_CURVE MDSYS.SDO_GEOMETRY 
, LOD0_MULTI_SURFACE_ID NUMBER 
, LOD1_MULTI_SURFACE_ID NUMBER 
, LOD1_SOLID_ID NUMBER 
, LOD2_SOLID_ID NUMBER 
, LOD3_SOLID_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT WATERBODY_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE WATERBOUNDARY_SURFACE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, WATER_LEVEL VARCHAR2(256) 
, WATER_LEVEL_CODESPACE VARCHAR2(4000) 
, LOD2_SURFACE_ID NUMBER 
, LOD3_SURFACE_ID NUMBER 
, LOD4_SURFACE_ID NUMBER 
, CONSTRAINT WATERBOUNDARY_SURFACE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE ADDRESS_TO_BRIDGE 
(
  BRIDGE_ID NUMBER NOT NULL 
, ADDRESS_ID NUMBER NOT NULL 
, CONSTRAINT ADDRESS_TO_BRIDGE_PK PRIMARY KEY 
  (
    BRIDGE_ID 
  , ADDRESS_ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_ROOM 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BRIDGE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT BRIDGE_ROOM_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE ADDRESS_TO_BUILDING 
(
  BUILDING_ID NUMBER NOT NULL 
, ADDRESS_ID NUMBER NOT NULL 
, CONSTRAINT ADDRESS_TO_BUILDING_PK PRIMARY KEY 
  (
    BUILDING_ID 
  , ADDRESS_ID 
  )
  ENABLE 
);

CREATE TABLE ROOM 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BUILDING_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT ROOM_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE GROUP_TO_CITYOBJECT 
(
  CITYOBJECT_ID NUMBER NOT NULL 
, CITYOBJECTGROUP_ID NUMBER NOT NULL 
, ROLE VARCHAR2(256) 
, CONSTRAINT GROUP_TO_CITYOBJECT_PK PRIMARY KEY 
  (
    CITYOBJECT_ID 
  , CITYOBJECTGROUP_ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_CONSTR_ELEMENT 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BRIDGE_ID NUMBER 
, LOD1_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD3_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD4_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD1_BREP_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD1_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD1_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT BRIDGE_CONSTR_ELEMENT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_OPENING 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, ADDRESS_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT BRIDGE_OPENING_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE CITY_FURNITURE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, LOD1_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD3_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD4_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD1_BREP_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD1_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD1_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT CITY_FURNITURE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE GENERIC_CITYOBJECT 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, LOD0_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD1_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD2_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD3_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD4_TERRAIN_INTERSECTION MDSYS.SDO_GEOMETRY 
, LOD0_BREP_ID NUMBER 
, LOD1_BREP_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD0_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD1_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD0_IMPLICIT_REP_ID NUMBER 
, LOD1_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD0_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD0_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD1_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT GENERIC_CITYOBJECT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE OPENING 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, ADDRESS_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT OPENING_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE SOLITARY_VEGETAT_OBJECT 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, SPECIES VARCHAR2(1000) 
, SPECIES_CODESPACE VARCHAR2(4000) 
, HEIGHT BINARY_DOUBLE 
, HEIGHT_UNIT VARCHAR2(4000) 
, TRUNK_DIAMETER BINARY_DOUBLE 
, TRUNK_DIAMETER_UNIT VARCHAR2(4000) 
, CROWN_DIAMETER BINARY_DOUBLE 
, CROWN_DIAMETER_UNIT VARCHAR2(4000) 
, LOD1_BREP_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD1_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD1_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD1_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT SOLITARY_VEG_OBJECT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL_OPENING 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT TUNNEL_OPENING_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TRAFFIC_AREA 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, SURFACE_MATERIAL VARCHAR2(256) 
, SURFACE_MATERIAL_CODESPACE VARCHAR2(4000) 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, TRANSPORTATION_COMPLEX_ID NUMBER 
, CONSTRAINT TRAFFIC_AREA_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL_HOLLOW_SPACE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, TUNNEL_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, LOD4_SOLID_ID NUMBER 
, CONSTRAINT TUNNEL_HOLLOW_SPACE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE WATERBOD_TO_WATERBND_SRF 
(
  WATERBOUNDARY_SURFACE_ID NUMBER NOT NULL 
, WATERBODY_ID NUMBER NOT NULL 
, CONSTRAINT WATERBOD_TO_WATERBND_PK PRIMARY KEY 
  (
    WATERBOUNDARY_SURFACE_ID 
  , WATERBODY_ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_FURNITURE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BRIDGE_ROOM_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT BRIDGE_FURNITURE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_INSTALLATION 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BRIDGE_ID NUMBER 
, BRIDGE_ROOM_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT BRIDGE_INSTALLATION_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BUILDING_FURNITURE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, ROOM_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT BUILDING_FURNITURE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BUILDING_INSTALLATION 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, BUILDING_ID NUMBER 
, ROOM_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT BUILDING_INSTALLATION_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL_FURNITURE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, TUNNEL_HOLLOW_SPACE_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT TUNNEL_FURNITURE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL_INSTALLATION 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, CLASS VARCHAR2(256) 
, CLASS_CODESPACE VARCHAR2(4000) 
, FUNCTION VARCHAR2(1000) 
, FUNCTION_CODESPACE VARCHAR2(4000) 
, USAGE VARCHAR2(1000) 
, USAGE_CODESPACE VARCHAR2(4000) 
, TUNNEL_ID NUMBER 
, TUNNEL_HOLLOW_SPACE_ID NUMBER 
, LOD2_BREP_ID NUMBER 
, LOD3_BREP_ID NUMBER 
, LOD4_BREP_ID NUMBER 
, LOD2_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD3_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD4_OTHER_GEOM MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_REP_ID NUMBER 
, LOD3_IMPLICIT_REP_ID NUMBER 
, LOD4_IMPLICIT_REP_ID NUMBER 
, LOD2_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD3_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD4_IMPLICIT_REF_POINT MDSYS.SDO_GEOMETRY 
, LOD2_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD3_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, LOD4_IMPLICIT_TRANSFORMATION VARCHAR2(1000) 
, CONSTRAINT TUNNEL_INSTALLATION_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_THEMATIC_SURFACE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, BRIDGE_ID NUMBER 
, BRIDGE_ROOM_ID NUMBER 
, BRIDGE_INSTALLATION_ID NUMBER 
, BRIDGE_CONSTR_ELEMENT_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, CONSTRAINT BRIDGE_THEMATIC_SURFACE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE THEMATIC_SURFACE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, BUILDING_ID NUMBER 
, ROOM_ID NUMBER 
, BUILDING_INSTALLATION_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, CONSTRAINT THEMATIC_SURFACE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL_THEMATIC_SURFACE 
(
  ID NUMBER NOT NULL 
, OBJECTCLASS_ID NUMBER NOT NULL 
, TUNNEL_ID NUMBER 
, TUNNEL_HOLLOW_SPACE_ID NUMBER 
, TUNNEL_INSTALLATION_ID NUMBER 
, LOD2_MULTI_SURFACE_ID NUMBER 
, LOD3_MULTI_SURFACE_ID NUMBER 
, LOD4_MULTI_SURFACE_ID NUMBER 
, CONSTRAINT TUNNEL_THEMATIC_SURFACE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE BRIDGE_OPEN_TO_THEM_SRF 
(
  BRIDGE_OPENING_ID NUMBER NOT NULL 
, BRIDGE_THEMATIC_SURFACE_ID NUMBER NOT NULL 
, CONSTRAINT BRIDGE_OPEN_TO_THEM_SRF_PK PRIMARY KEY 
  (
    BRIDGE_OPENING_ID 
  , BRIDGE_THEMATIC_SURFACE_ID 
  )
  ENABLE 
);

CREATE TABLE OPENING_TO_THEM_SURFACE 
(
  OPENING_ID NUMBER NOT NULL 
, THEMATIC_SURFACE_ID NUMBER NOT NULL 
, CONSTRAINT OPENING_TO_THEM_SURFACE_PK PRIMARY KEY 
  (
    OPENING_ID 
  , THEMATIC_SURFACE_ID 
  )
  ENABLE 
);

CREATE TABLE TUNNEL_OPEN_TO_THEM_SRF 
(
  TUNNEL_OPENING_ID NUMBER NOT NULL 
, TUNNEL_THEMATIC_SURFACE_ID NUMBER NOT NULL 
, CONSTRAINT TUNNEL_OPEN_TO_THEM_SRF_PK PRIMARY KEY 
  (
    TUNNEL_OPENING_ID 
  , TUNNEL_THEMATIC_SURFACE_ID 
  )
  ENABLE 
);