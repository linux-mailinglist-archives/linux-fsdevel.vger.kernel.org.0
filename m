Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D3164A99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBSQhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:37:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58746 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBSQhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:37:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGYGCP172521;
        Wed, 19 Feb 2020 16:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/FQV+W9XsOvrfr+awM0KmGV2YDtP9tcTimbixnG6koo=;
 b=Ua/vVoRfMpbmUmpbmf99dZNqxRRfkaxHhXid8+cvyyapHzFuIQF8Le+SOu4mmlax3rFL
 0DZwNsW+jRCJnf6My1TBD7vDjaL4pYG8rnUbh7Vj0h4wmKV/Tn5ajh+h8UVl3Izww0Nc
 IbCIuBzhMsqImiN4jlIOCt9NbK2J/2qqn670EM52qHoN5xzMYwnwdGlnNho2NZ0IcNjx
 eEFmgMnFMgFP1LYlw0x1ix6LdqKnVP6x2Tr9BkJnGaSmdd14F+rq/vTiCAo9pIjCFDON
 59OznSxIg8oJtZyOfOkzobYolLSyxSPvJcGDrTmZ9G/THRjrrfWpZ+9Nv8ZpmuvG7M8Q 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud14ar3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:37:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGVoJU100319;
        Wed, 19 Feb 2020 16:37:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y8ud68xfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:37:10 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JGb8xR023299;
        Wed, 19 Feb 2020 16:37:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 08:37:08 -0800
Date:   Wed, 19 Feb 2020 08:37:05 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] fsinfo: Provide a bitmap of supported features
 [ver #16]
Message-ID: <20200219163705.GC9496@magnolia>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204552063.3299825.17824500635078230412.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158204552063.3299825.17824500635078230412.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:05:20PM +0000, David Howells wrote:
> Provide a bitmap of features that a filesystem may provide for the path
> being queried.  Features include such things as:
> 
>  (1) The general class of filesystem, such as kernel-interface,
>      block-based, flash-based, network-based.
> 
>  (2) Supported inode features, such as which timestamps are supported,
>      whether simple numeric user, group or project IDs are supported and
>      whether user identification is actually more complex behind the
>      scenes.
> 
>  (3) Supported volume features, such as it having a UUID, a name or a
>      filesystem ID.
> 
>  (4) Supported filesystem features, such as what types of file are
>      supported, whether sparse files, extended attributes and quotas are
>      supported.
> 
>  (5) Supported interface features, such as whether locking and leases are
>      supported, what open flags are honoured and how i_version is managed.
> 
> For some filesystems, this may be an immutable set and can just be memcpy'd
> into the reply buffer.
> ---
> 
>  fs/fsinfo.c                 |   41 +++++++++++++++++++
>  include/linux/fsinfo.h      |   32 +++++++++++++++
>  include/uapi/linux/fsinfo.h |   78 ++++++++++++++++++++++++++++++++++++
>  samples/vfs/test-fsinfo.c   |   93 ++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 242 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index 3bc35b91f20b..55710d6da327 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -36,6 +36,17 @@ int fsinfo_string(const char *s, struct fsinfo_context *ctx)
>  }
>  EXPORT_SYMBOL(fsinfo_string);
>  
> +/*
> + * Get information about fsinfo() itself.
> + */
> +static int fsinfo_generic_fsinfo(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_fsinfo *info = ctx->buffer;
> +
> +	info->max_features = FSINFO_FEAT__NR;
> +	return sizeof(*info);
> +}
> +
>  /*
>   * Get basic filesystem stats from statfs.
>   */
> @@ -121,6 +132,33 @@ static int fsinfo_generic_supports(struct path *path, struct fsinfo_context *ctx
>  	return sizeof(*c);
>  }
>  
> +static int fsinfo_generic_features(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_features *ft = ctx->buffer;
> +	struct super_block *sb = path->dentry->d_sb;
> +
> +	if (sb->s_mtd)
> +		fsinfo_set_feature(ft, FSINFO_FEAT_IS_FLASH_FS);
> +	else if (sb->s_bdev)
> +		fsinfo_set_feature(ft, FSINFO_FEAT_IS_BLOCK_FS);
> +
> +	if (sb->s_quota_types & QTYPE_MASK_USR)
> +		fsinfo_set_feature(ft, FSINFO_FEAT_USER_QUOTAS);
> +	if (sb->s_quota_types & QTYPE_MASK_GRP)
> +		fsinfo_set_feature(ft, FSINFO_FEAT_GROUP_QUOTAS);
> +	if (sb->s_quota_types & QTYPE_MASK_PRJ)
> +		fsinfo_set_feature(ft, FSINFO_FEAT_PROJECT_QUOTAS);
> +	if (sb->s_d_op && sb->s_d_op->d_automount)
> +		fsinfo_set_feature(ft, FSINFO_FEAT_AUTOMOUNTS);
> +	if (sb->s_id[0])
> +		fsinfo_set_feature(ft, FSINFO_FEAT_VOLUME_ID);
> +
> +	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_ATIME);
> +	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_CTIME);
> +	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_MTIME);
> +	return sizeof(*ft);
> +}
> +
>  static const struct fsinfo_timestamp_info fsinfo_default_timestamp_info = {
>  	.atime = {
>  		.minimum	= S64_MIN,
> @@ -252,6 +290,9 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
>  	FSINFO_STRING 	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
> +
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_FSINFO,		fsinfo_generic_fsinfo),
>  	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_attribute_info),
>  	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_attributes),
>  	{}
> diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
> index dcd55dbb02fa..564765c70659 100644
> --- a/include/linux/fsinfo.h
> +++ b/include/linux/fsinfo.h
> @@ -65,6 +65,38 @@ struct fsinfo_attribute {
>  
>  extern int fsinfo_string(const char *, struct fsinfo_context *);
>  
> +static inline void fsinfo_set_feature(struct fsinfo_features *f,
> +				      enum fsinfo_feature feature)
> +{
> +	f->features[feature / 8] |= 1 << (feature % 8);
> +}
> +
> +static inline void fsinfo_clear_feature(struct fsinfo_features *f,
> +					enum fsinfo_feature feature)
> +{
> +	f->features[feature / 8] &= ~(1 << (feature % 8));
> +}
> +
> +/**
> + * fsinfo_set_unix_features - Set standard UNIX features.
> + * @f: The features mask to alter
> + */
> +static inline void fsinfo_set_unix_features(struct fsinfo_features *f)
> +{
> +	fsinfo_set_feature(f, FSINFO_FEAT_UIDS);
> +	fsinfo_set_feature(f, FSINFO_FEAT_GIDS);
> +	fsinfo_set_feature(f, FSINFO_FEAT_DIRECTORIES);
> +	fsinfo_set_feature(f, FSINFO_FEAT_SYMLINKS);
> +	fsinfo_set_feature(f, FSINFO_FEAT_HARD_LINKS);
> +	fsinfo_set_feature(f, FSINFO_FEAT_DEVICE_FILES);
> +	fsinfo_set_feature(f, FSINFO_FEAT_UNIX_SPECIALS);
> +	fsinfo_set_feature(f, FSINFO_FEAT_SPARSE);
> +	fsinfo_set_feature(f, FSINFO_FEAT_HAS_ATIME);
> +	fsinfo_set_feature(f, FSINFO_FEAT_HAS_CTIME);
> +	fsinfo_set_feature(f, FSINFO_FEAT_HAS_MTIME);
> +	fsinfo_set_feature(f, FSINFO_FEAT_HAS_INODE_NUMBERS);
> +}
> +
>  #endif /* CONFIG_FSINFO */
>  
>  #endif /* _LINUX_FSINFO_H */
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index 365d54fe9290..f40b5c0b5516 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -22,9 +22,11 @@
>  #define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
>  #define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
>  #define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
> +#define FSINFO_ATTR_FEATURES		0x08	/* Filesystem features (bits) */
>  
>  #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
>  #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
> +#define FSINFO_ATTR_FSINFO		0x102	/* Information about fsinfo() as a whole */
>  
>  /*
>   * Optional fsinfo() parameter structure.
> @@ -45,6 +47,17 @@ struct fsinfo_params {
>  	__u64	__reserved[3];
>  };
>  
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_FSINFO).
> + *
> + * This gives information about fsinfo() itself.
> + */
> +struct fsinfo_fsinfo {
> +	__u32	max_features;	/* Number of supported features (fsinfo_features__nr) */
> +};
> +
> +#define FSINFO_ATTR_FSINFO__STRUCT struct fsinfo_fsinfo
> +
>  enum fsinfo_value_type {
>  	FSINFO_TYPE_VSTRUCT	= 0,	/* Version-lengthed struct (up to 4096 bytes) */
>  	FSINFO_TYPE_STRING	= 1,	/* NUL-term var-length string (up to 4095 chars) */
> @@ -154,6 +167,71 @@ struct fsinfo_supports {
>  
>  #define FSINFO_ATTR_SUPPORTS__STRUCT struct fsinfo_supports
>  
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_FEATURES).
> + *
> + * Bitmask indicating filesystem features where renderable as single bits.
> + */
> +enum fsinfo_feature {
> +	FSINFO_FEAT_IS_KERNEL_FS	= 0,	/* fs is kernel-special filesystem */
> +	FSINFO_FEAT_IS_BLOCK_FS		= 1,	/* fs is block-based filesystem */
> +	FSINFO_FEAT_IS_FLASH_FS		= 2,	/* fs is flash filesystem */
> +	FSINFO_FEAT_IS_NETWORK_FS	= 3,	/* fs is network filesystem */
> +	FSINFO_FEAT_IS_AUTOMOUNTER_FS	= 4,	/* fs is automounter special filesystem */
> +	FSINFO_FEAT_IS_MEMORY_FS	= 5,	/* fs is memory-based filesystem */
> +	FSINFO_FEAT_AUTOMOUNTS		= 6,	/* fs supports automounts */
> +	FSINFO_FEAT_ADV_LOCKS		= 7,	/* fs supports advisory file locking */
> +	FSINFO_FEAT_MAND_LOCKS		= 8,	/* fs supports mandatory file locking */
> +	FSINFO_FEAT_LEASES		= 9,	/* fs supports file leases */
> +	FSINFO_FEAT_UIDS		= 10,	/* fs supports numeric uids */
> +	FSINFO_FEAT_GIDS		= 11,	/* fs supports numeric gids */
> +	FSINFO_FEAT_PROJIDS		= 12,	/* fs supports numeric project ids */
> +	FSINFO_FEAT_STRING_USER_IDS	= 13,	/* fs supports string user identifiers */
> +	FSINFO_FEAT_GUID_USER_IDS	= 14,	/* fs supports GUID user identifiers */
> +	FSINFO_FEAT_WINDOWS_ATTRS	= 15,	/* fs has windows attributes */
> +	FSINFO_FEAT_USER_QUOTAS		= 16,	/* fs has per-user quotas */
> +	FSINFO_FEAT_GROUP_QUOTAS	= 17,	/* fs has per-group quotas */
> +	FSINFO_FEAT_PROJECT_QUOTAS	= 18,	/* fs has per-project quotas */
> +	FSINFO_FEAT_XATTRS		= 19,	/* fs has xattrs */
> +	FSINFO_FEAT_JOURNAL		= 20,	/* fs has a journal */
> +	FSINFO_FEAT_DATA_IS_JOURNALLED	= 21,	/* fs is using data journalling */
> +	FSINFO_FEAT_O_SYNC		= 22,	/* fs supports O_SYNC */
> +	FSINFO_FEAT_O_DIRECT		= 23,	/* fs supports O_DIRECT */
> +	FSINFO_FEAT_VOLUME_ID		= 24,	/* fs has a volume ID */
> +	FSINFO_FEAT_VOLUME_UUID		= 25,	/* fs has a volume UUID */
> +	FSINFO_FEAT_VOLUME_NAME		= 26,	/* fs has a volume name */
> +	FSINFO_FEAT_VOLUME_FSID		= 27,	/* fs has a volume FSID */
> +	FSINFO_FEAT_IVER_ALL_CHANGE	= 28,	/* i_version represents data + meta changes */
> +	FSINFO_FEAT_IVER_DATA_CHANGE	= 29,	/* i_version represents data changes only */
> +	FSINFO_FEAT_IVER_MONO_INCR	= 30,	/* i_version incremented monotonically */
> +	FSINFO_FEAT_DIRECTORIES		= 31,	/* fs supports (sub)directories */
> +	FSINFO_FEAT_SYMLINKS		= 32,	/* fs supports symlinks */
> +	FSINFO_FEAT_HARD_LINKS		= 33,	/* fs supports hard links */
> +	FSINFO_FEAT_HARD_LINKS_1DIR	= 34,	/* fs supports hard links in same dir only */
> +	FSINFO_FEAT_DEVICE_FILES	= 35,	/* fs supports bdev, cdev */
> +	FSINFO_FEAT_UNIX_SPECIALS	= 36,	/* fs supports pipe, fifo, socket */
> +	FSINFO_FEAT_RESOURCE_FORKS	= 37,	/* fs supports resource forks/streams */
> +	FSINFO_FEAT_NAME_CASE_INDEP	= 38,	/* Filename case independence is mandatory */
> +	FSINFO_FEAT_NAME_NON_UTF8	= 39,	/* fs has non-utf8 names */
> +	FSINFO_FEAT_NAME_HAS_CODEPAGE	= 40,	/* fs has a filename codepage */
> +	FSINFO_FEAT_SPARSE		= 41,	/* fs supports sparse files */
> +	FSINFO_FEAT_NOT_PERSISTENT	= 42,	/* fs is not persistent */
> +	FSINFO_FEAT_NO_UNIX_MODE	= 43,	/* fs does not support unix mode bits */
> +	FSINFO_FEAT_HAS_ATIME		= 44,	/* fs supports access time */
> +	FSINFO_FEAT_HAS_BTIME		= 45,	/* fs supports birth/creation time */
> +	FSINFO_FEAT_HAS_CTIME		= 46,	/* fs supports change time */
> +	FSINFO_FEAT_HAS_MTIME		= 47,	/* fs supports modification time */
> +	FSINFO_FEAT_HAS_ACL		= 48,	/* fs supports ACLs of some sort */
> +	FSINFO_FEAT_HAS_INODE_NUMBERS	= 49,	/* fs has inode numbers */
> +	FSINFO_FEAT__NR
> +};
> +
> +struct fsinfo_features {
> +	__u8	features[(FSINFO_FEAT__NR + 7) / 8];

Hm...the structure size is pretty small (56 bytes) and will expand as we
add new _FEAT flags.  Is this ok because the fsinfo code will truncate
its response to userspace to whatever buffer size userspace tells it?

--D

> +};
> +
> +#define FSINFO_ATTR_FEATURES__STRUCT struct fsinfo_features
> +
>  struct fsinfo_timestamp_one {
>  	__s64	minimum;	/* Minimum timestamp value in seconds */
>  	__u64	maximum;	/* Maximum timestamp value in seconds */
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index 9a4d49db2996..6fbf0ce099b2 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -107,6 +107,13 @@ static void dump_attribute_info(void *reply, unsigned int size)
>  	       attr->name ? attr->name : "");
>  }
>  
> +static void dump_fsinfo_info(void *reply, unsigned int size)
> +{
> +	struct fsinfo_fsinfo *f = reply;
> +
> +	printf("Number of feature bits: %u\n", f->max_features);
> +}
> +
>  static void dump_fsinfo_generic_statfs(void *reply, unsigned int size)
>  {
>  	struct fsinfo_statfs *f = reply;
> @@ -172,6 +179,74 @@ static void dump_fsinfo_generic_supports(void *reply, unsigned int size)
>  	printf("\twin_fattrs   : %x\n", f->win_file_attrs);
>  }
>  
> +#define FSINFO_FEATURE_NAME(C) [FSINFO_FEAT_##C] = #C
> +static const char *fsinfo_feature_names[FSINFO_FEAT__NR] = {
> +	FSINFO_FEATURE_NAME(IS_KERNEL_FS),
> +	FSINFO_FEATURE_NAME(IS_BLOCK_FS),
> +	FSINFO_FEATURE_NAME(IS_FLASH_FS),
> +	FSINFO_FEATURE_NAME(IS_NETWORK_FS),
> +	FSINFO_FEATURE_NAME(IS_AUTOMOUNTER_FS),
> +	FSINFO_FEATURE_NAME(IS_MEMORY_FS),
> +	FSINFO_FEATURE_NAME(AUTOMOUNTS),
> +	FSINFO_FEATURE_NAME(ADV_LOCKS),
> +	FSINFO_FEATURE_NAME(MAND_LOCKS),
> +	FSINFO_FEATURE_NAME(LEASES),
> +	FSINFO_FEATURE_NAME(UIDS),
> +	FSINFO_FEATURE_NAME(GIDS),
> +	FSINFO_FEATURE_NAME(PROJIDS),
> +	FSINFO_FEATURE_NAME(STRING_USER_IDS),
> +	FSINFO_FEATURE_NAME(GUID_USER_IDS),
> +	FSINFO_FEATURE_NAME(WINDOWS_ATTRS),
> +	FSINFO_FEATURE_NAME(USER_QUOTAS),
> +	FSINFO_FEATURE_NAME(GROUP_QUOTAS),
> +	FSINFO_FEATURE_NAME(PROJECT_QUOTAS),
> +	FSINFO_FEATURE_NAME(XATTRS),
> +	FSINFO_FEATURE_NAME(JOURNAL),
> +	FSINFO_FEATURE_NAME(DATA_IS_JOURNALLED),
> +	FSINFO_FEATURE_NAME(O_SYNC),
> +	FSINFO_FEATURE_NAME(O_DIRECT),
> +	FSINFO_FEATURE_NAME(VOLUME_ID),
> +	FSINFO_FEATURE_NAME(VOLUME_UUID),
> +	FSINFO_FEATURE_NAME(VOLUME_NAME),
> +	FSINFO_FEATURE_NAME(VOLUME_FSID),
> +	FSINFO_FEATURE_NAME(IVER_ALL_CHANGE),
> +	FSINFO_FEATURE_NAME(IVER_DATA_CHANGE),
> +	FSINFO_FEATURE_NAME(IVER_MONO_INCR),
> +	FSINFO_FEATURE_NAME(DIRECTORIES),
> +	FSINFO_FEATURE_NAME(SYMLINKS),
> +	FSINFO_FEATURE_NAME(HARD_LINKS),
> +	FSINFO_FEATURE_NAME(HARD_LINKS_1DIR),
> +	FSINFO_FEATURE_NAME(DEVICE_FILES),
> +	FSINFO_FEATURE_NAME(UNIX_SPECIALS),
> +	FSINFO_FEATURE_NAME(RESOURCE_FORKS),
> +	FSINFO_FEATURE_NAME(NAME_CASE_INDEP),
> +	FSINFO_FEATURE_NAME(NAME_NON_UTF8),
> +	FSINFO_FEATURE_NAME(NAME_HAS_CODEPAGE),
> +	FSINFO_FEATURE_NAME(SPARSE),
> +	FSINFO_FEATURE_NAME(NOT_PERSISTENT),
> +	FSINFO_FEATURE_NAME(NO_UNIX_MODE),
> +	FSINFO_FEATURE_NAME(HAS_ATIME),
> +	FSINFO_FEATURE_NAME(HAS_BTIME),
> +	FSINFO_FEATURE_NAME(HAS_CTIME),
> +	FSINFO_FEATURE_NAME(HAS_MTIME),
> +	FSINFO_FEATURE_NAME(HAS_ACL),
> +	FSINFO_FEATURE_NAME(HAS_INODE_NUMBERS),
> +};
> +
> +static void dump_fsinfo_generic_features(void *reply, unsigned int size)
> +{
> +	struct fsinfo_features *f = reply;
> +	int i;
> +
> +	printf("\n\t");
> +	for (i = 0; i < sizeof(f->features); i++)
> +		printf("%02x", f->features[i]);
> +	printf("\n");
> +	for (i = 0; i < FSINFO_FEAT__NR; i++)
> +		if (f->features[i / 8] & (1 << (i % 8)))
> +			printf("\t- %s\n", fsinfo_feature_names[i]);
> +}
> +
>  static void print_time(struct fsinfo_timestamp_one *t, char stamp)
>  {
>  	printf("\t%ctime       : gran=%gs range=%llx-%llx\n",
> @@ -235,7 +310,6 @@ static void dump_string(void *reply, unsigned int size)
>  
>  #define dump_fsinfo_generic_volume_id		dump_string
>  #define dump_fsinfo_generic_volume_name		dump_string
> -#define dump_fsinfo_generic_name_encoding	dump_string
>  
>  /*
>   *
> @@ -266,6 +340,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
>  	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
>  	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
> @@ -475,6 +550,7 @@ static int cmp_u32(const void *a, const void *b)
>  int main(int argc, char **argv)
>  {
>  	struct fsinfo_attribute_info attr_info;
> +	struct fsinfo_fsinfo fsinfo_info;
>  	struct fsinfo_params params = {
>  		.at_flags	= AT_SYMLINK_NOFOLLOW,
>  		.flags		= FSINFO_FLAGS_QUERY_PATH,
> @@ -531,6 +607,18 @@ int main(int argc, char **argv)
>  	qsort(attrs, nr, sizeof(attrs[0]), cmp_u32);
>  
>  	if (meta) {
> +		params.request = FSINFO_ATTR_FSINFO;
> +		params.Nth = 0;
> +		params.Mth = 0;
> +		ret = fsinfo(AT_FDCWD, argv[0], &params, &fsinfo_info, sizeof(fsinfo_info));
> +		if (ret == -1) {
> +			fprintf(stderr, "Unable to get fsinfo information: %m\n");
> +			exit(1);
> +		}
> +
> +		dump_fsinfo_info(&fsinfo_info, ret);
> +		printf("\n");
> +
>  		printf("ATTR ID  TYPE         FLAGS    SIZE  ESIZE NAME\n");
>  		printf("======== ============ ======== ===== ===== =========\n");
>  		for (i = 0; i < nr; i++) {
> @@ -558,7 +646,8 @@ int main(int argc, char **argv)
>  			exit(1);
>  		}
>  
> -		if (attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO ||
> +		if (attrs[i] == FSINFO_ATTR_FSINFO ||
> +		    attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO ||
>  		    attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTES)
>  			continue;
>  
> 
> 
