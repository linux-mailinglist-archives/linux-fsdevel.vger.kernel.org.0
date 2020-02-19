Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2451B164A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBSQbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:31:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33224 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgBSQby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:31:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGUtfi069333;
        Wed, 19 Feb 2020 16:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Xx0X/kyq5Ne7e0aQxEQpLxcL/eCsWoy/h2H/+IxxgKw=;
 b=PHDzIjmBYowtreapLse3e26EWqgk9f3b86b7+6ZqhhAAjq0Sw10nLRlGEBpcTV6bXtxt
 uN1nBC0KMQvLj+BihjNcppshTu4wTv//NG/wVVwB3nK7mHQnn2eukSdZN0TiaB9dgHaE
 PqMdvcULSYmfwobL0zWQSe4a0O8h1bj0wDVshFy7T+7os/Et92v/roWiA+z1Gx6i/5bI
 3Eye4OPQ+BzpcANSHgvwStXO52UyxPOkj3RZs6uHl5Nrqyh94LS4RVEkZlBi53QbadkD
 +dMDtj3FCu1P1e+avdD4p0dSTcQADJzyUN3HXnERdWMQGzV2F7xzjsh2lvNiJg4FAByt 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y8udd4a6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:31:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGVasf074282;
        Wed, 19 Feb 2020 16:31:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y8ud1gmnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:31:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JGVUBZ018067;
        Wed, 19 Feb 2020 16:31:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 08:31:30 -0800
Date:   Wed, 19 Feb 2020 08:31:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #16]
Message-ID: <20200219163128.GB9496@magnolia>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=2 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=2
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:05:02PM +0000, David Howells wrote:
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
> 
> ===============
> NEW SYSTEM CALL
> ===============
> 
> The new system call looks like:
> 
> 	int ret = fsinfo(int dfd,
> 			 const char *filename,
> 			 const struct fsinfo_params *params,
> 			 void *buffer,
> 			 size_t buf_size);
> 
> The params parameter optionally points to a block of parameters:
> 
> 	struct fsinfo_params {
> 		__u32	at_flags;
> 		__u32	request;
> 		__u32	Nth;
> 		__u32	Mth;
> 		__u64	__reserved[3];
> 	};
> 
> If params is NULL, it is assumed params->request should be
> fsinfo_attr_statfs, params->Nth should be 0, params->Mth should be 0 and
> params->at_flags should be 0.
> 
> If params is given, all of params->__reserved[] must be 0.
> 
> dfd, filename and params->at_flags indicate the file to query.  There is no
> equivalent of lstat() as that can be emulated with fsinfo() by setting
> AT_SYMLINK_NOFOLLOW in params->at_flags.  There is also no equivalent of
> fstat() as that can be emulated by passing a NULL filename to fsinfo() with
> the fd of interest in dfd.  AT_NO_AUTOMOUNT can also be used to an allow
> automount point to be queried without triggering it.
> 
> params->request indicates the attribute/attributes to be queried.  This can
> be one of:
> 
> 	FSINFO_ATTR_STATFS		- statfs-style info
> 	FSINFO_ATTR_IDS			- Filesystem IDs
> 	FSINFO_ATTR_LIMITS		- Filesystem limits
> 	FSINFO_ATTR_SUPPORTS		- What's supported in statx(), IOC flags
> 	FSINFO_ATTR_TIMESTAMP_INFO	- Inode timestamp info
> 	FSINFO_ATTR_VOLUME_ID		- Volume ID (string)
> 	FSINFO_ATTR_VOLUME_UUID		- Volume UUID
> 	FSINFO_ATTR_VOLUME_NAME		- Volume name (string)
> 	FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO - Information about attr Nth
> 	FSINFO_ATTR_FSINFO_ATTRIBUTES	- List of supported attrs
> 
> Some attributes (such as the servers backing a network filesystem) can have
> multiple values.  These can be enumerated by setting params->Nth and
> params->Mth to 0, 1, ... until ENODATA is returned.
> 
> buffer and buf_size point to the reply buffer.  The buffer is filled up to
> the specified size, even if this means truncating the reply.  The full size
> of the reply is returned.  In future versions, this will allow extra fields
> to be tacked on to the end of the reply, but anyone not expecting them will
> only get the subset they're expecting.  If either buffer of buf_size are 0,
> no copy will take place and the data size will be returned.
> 
> At the moment, this will only work on x86_64 and i386 as it requires the
> system call to be wired up.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> ---
> 
>  arch/x86/entry/syscalls/syscall_32.tbl |    1 
>  arch/x86/entry/syscalls/syscall_64.tbl |    1 
>  fs/Kconfig                             |    7 
>  fs/Makefile                            |    1 
>  fs/fsinfo.c                            |  525 ++++++++++++++++++++++++++++
>  include/linux/fs.h                     |    5 
>  include/linux/fsinfo.h                 |   70 ++++
>  include/linux/syscalls.h               |    4 
>  include/uapi/asm-generic/unistd.h      |    4 
>  include/uapi/linux/fsinfo.h            |  186 ++++++++++
>  kernel/sys_ni.c                        |    1 
>  samples/vfs/Makefile                   |    5 
>  samples/vfs/test-fsinfo.c              |  599 ++++++++++++++++++++++++++++++++
>  13 files changed, 1408 insertions(+), 1 deletion(-)
>  create mode 100644 fs/fsinfo.c
>  create mode 100644 include/linux/fsinfo.h
>  create mode 100644 include/uapi/linux/fsinfo.h
>  create mode 100644 samples/vfs/test-fsinfo.c
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index c17cb77eb150..b7817acb154b 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -442,3 +442,4 @@
>  435	i386	clone3			sys_clone3			__ia32_sys_clone3
>  437	i386	openat2			sys_openat2			__ia32_sys_openat2
>  438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
> +439	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 44d510bc9b78..3a45ed6d28cb 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -359,6 +359,7 @@
>  435	common	clone3			__x64_sys_clone3/ptregs
>  437	common	openat2			__x64_sys_openat2
>  438	common	pidfd_getfd		__x64_sys_pidfd_getfd
> +439	common	fsinfo			__x64_sys_fsinfo
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 708ba336e689..1d1b48059ec9 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -15,6 +15,13 @@ config VALIDATE_FS_PARSER
>  	  Enable this to perform validation of the parameter description for a
>  	  filesystem when it is registered.
>  
> +config FSINFO
> +	bool "Enable the fsinfo() system call"
> +	help
> +	  Enable the file system information querying system call to allow
> +	  comprehensive information to be retrieved about a filesystem,
> +	  superblock or mount object.
> +
>  if BLOCK
>  
>  config FS_IOMAP
> diff --git a/fs/Makefile b/fs/Makefile
> index 505e51166973..b5cc9bcd17a4 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_COREDUMP)		+= coredump.o
>  obj-$(CONFIG_SYSCTL)		+= drop_caches.o
>  
>  obj-$(CONFIG_FHANDLE)		+= fhandle.o
> +obj-$(CONFIG_FSINFO)		+= fsinfo.o
>  obj-y				+= iomap/
>  
>  obj-y				+= quota/
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> new file mode 100644
> index 000000000000..3bc35b91f20b
> --- /dev/null
> +++ b/fs/fsinfo.c
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information query.
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +#include <linux/syscalls.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/mount.h>
> +#include <linux/namei.h>
> +#include <linux/statfs.h>
> +#include <linux/security.h>
> +#include <linux/uaccess.h>
> +#include <linux/fsinfo.h>
> +#include <uapi/linux/mount.h>
> +#include "internal.h"
> +
> +static const struct fsinfo_attribute fsinfo_common_attributes[];
> +
> +/**
> + * fsinfo_string - Store a string as an fsinfo attribute value.
> + * @s: The string to store (may be NULL)
> + * @ctx: The parameter context
> + */
> +int fsinfo_string(const char *s, struct fsinfo_context *ctx)
> +{
> +	int ret = 0;
> +
> +	if (s) {
> +		ret = strlen(s);
> +		memcpy(ctx->buffer, s, ret);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(fsinfo_string);
> +
> +/*
> + * Get basic filesystem stats from statfs.
> + */
> +static int fsinfo_generic_statfs(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_statfs *p = ctx->buffer;
> +	struct kstatfs buf;
> +	int ret;
> +
> +	ret = vfs_statfs(path, &buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	p->f_blocks.hi	= 0;
> +	p->f_blocks.lo	= buf.f_blocks;

Er... are there filesystems (besides that (xfs++)++ one) that require
u128 counters?  I suspect that the Very Large Fields are for future
expandability, but I also wonder about the whether it's worth the
complexity of doing this, since the structures can always be
version-revved later.

(I'm not opposed to u128, I'm just curious about it. :))

> +	p->f_bfree.hi	= 0;
> +	p->f_bfree.lo	= buf.f_bfree;
> +	p->f_bavail.hi	= 0;
> +	p->f_bavail.lo	= buf.f_bavail;
> +	p->f_files.hi	= 0;
> +	p->f_files.lo	= buf.f_files;
> +	p->f_ffree.hi	= 0;
> +	p->f_ffree.lo	= buf.f_ffree;
> +	p->f_favail.hi	= 0;
> +	p->f_favail.lo	= buf.f_ffree;
> +	p->f_bsize	= buf.f_bsize;
> +	p->f_frsize	= buf.f_frsize;
> +	return sizeof(*p);
> +}
> +
> +static int fsinfo_generic_ids(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_ids *p = ctx->buffer;
> +	struct super_block *sb;
> +	struct kstatfs buf;
> +	int ret;
> +
> +	ret = vfs_statfs(path, &buf);
> +	if (ret < 0 && ret != -ENOSYS)
> +		return ret;
> +
> +	sb = path->dentry->d_sb;
> +	p->f_fstype	= sb->s_magic;
> +	p->f_dev_major	= MAJOR(sb->s_dev);
> +	p->f_dev_minor	= MINOR(sb->s_dev);
> +
> +	memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
> +	strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
> +		sizeof(p->f_fs_name));
> +	return sizeof(*p);
> +}
> +
> +static int fsinfo_generic_limits(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_limits *lim = ctx->buffer;
> +	struct super_block *sb = path->dentry->d_sb;
> +
> +	lim->max_file_size.hi	= 0;
> +	lim->max_file_size.lo	= sb->s_maxbytes;
> +	lim->max_ino.hi		= 0;
> +	lim->max_ino.lo		= UINT_MAX;

XFS inodes are u64 values...

> +	lim->max_hard_links	= sb->s_max_links;
> +	lim->max_uid		= UINT_MAX;
> +	lim->max_gid		= UINT_MAX;
> +	lim->max_projid		= UINT_MAX;
> +	lim->max_filename_len	= NAME_MAX;
> +	lim->max_symlink_len	= PAGE_SIZE;

...and the max symlink target length is 1k, not PAGE_SIZE...

> +	lim->max_xattr_name_len	= XATTR_NAME_MAX;
> +	lim->max_xattr_body_len	= XATTR_SIZE_MAX;

...so is the usage model here that XFS should call fsinfo_generic_limits
to fill out the fsinfo_limits structure, modify the values in
ctx->buffer as appropriate for XFS, and then return the structure size?

> +	lim->max_dev_major	= 0xffffff;
> +	lim->max_dev_minor	= 0xff;
> +	return sizeof(*lim);
> +}
> +
> +static int fsinfo_generic_supports(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_supports *c = ctx->buffer;
> +	struct super_block *sb = path->dentry->d_sb;
> +
> +	c->stx_mask = STATX_BASIC_STATS;
> +	if (sb->s_d_op && sb->s_d_op->d_automount)
> +		c->stx_attributes |= STATX_ATTR_AUTOMOUNT;
> +	return sizeof(*c);
> +}
> +
> +static const struct fsinfo_timestamp_info fsinfo_default_timestamp_info = {
> +	.atime = {
> +		.minimum	= S64_MIN,
> +		.maximum	= S64_MAX,
> +		.gran_mantissa	= 1,
> +		.gran_exponent	= 0,
> +	},
> +	.mtime = {
> +		.minimum	= S64_MIN,
> +		.maximum	= S64_MAX,
> +		.gran_mantissa	= 1,
> +		.gran_exponent	= 0,
> +	},
> +	.ctime = {
> +		.minimum	= S64_MIN,
> +		.maximum	= S64_MAX,
> +		.gran_mantissa	= 1,
> +		.gran_exponent	= 0,
> +	},
> +	.btime = {
> +		.minimum	= S64_MIN,
> +		.maximum	= S64_MAX,
> +		.gran_mantissa	= 1,
> +		.gran_exponent	= 0,
> +	},
> +};
> +
> +static int fsinfo_generic_timestamp_info(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_timestamp_info *ts = ctx->buffer;
> +	struct super_block *sb = path->dentry->d_sb;
> +	s8 exponent;
> +
> +	*ts = fsinfo_default_timestamp_info;
> +
> +	if (sb->s_time_gran < 1000000000) {
> +		if (sb->s_time_gran < 1000)
> +			exponent = -9;
> +		else if (sb->s_time_gran < 1000000)
> +			exponent = -6;
> +		else
> +			exponent = -3;
> +
> +		ts->atime.gran_exponent = exponent;
> +		ts->mtime.gran_exponent = exponent;
> +		ts->ctime.gran_exponent = exponent;
> +		ts->btime.gran_exponent = exponent;
> +	}
> +
> +	return sizeof(*ts);
> +}
> +
> +static int fsinfo_generic_volume_uuid(struct path *path, struct fsinfo_context *ctx)
> +{
> +	struct fsinfo_volume_uuid *vu = ctx->buffer;
> +	struct super_block *sb = path->dentry->d_sb;
> +
> +	memcpy(vu, &sb->s_uuid, sizeof(*vu));
> +	return sizeof(*vu);
> +}
> +
> +static int fsinfo_generic_volume_id(struct path *path, struct fsinfo_context *ctx)
> +{
> +	return fsinfo_string(path->dentry->d_sb->s_id, ctx);
> +}
> +
> +static int fsinfo_attribute_info(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct fsinfo_attribute *attr;
> +	struct fsinfo_attribute_info *info = ctx->buffer;
> +	struct dentry *dentry = path->dentry;
> +
> +	if (dentry->d_sb->s_op->fsinfo_attributes)
> +		for (attr = dentry->d_sb->s_op->fsinfo_attributes; attr->get; attr++)
> +			if (attr->attr_id == ctx->Nth)
> +				goto found;
> +	for (attr = fsinfo_common_attributes; attr->get; attr++)
> +		if (attr->attr_id == ctx->Nth)
> +			goto found;
> +	return -ENODATA;
> +
> +found:
> +	info->attr_id		= attr->attr_id;
> +	info->type		= attr->type;
> +	info->flags		= attr->flags;
> +	info->size		= attr->size;
> +	info->element_size	= attr->element_size;
> +	return sizeof(*attr);
> +}
> +
> +static void fsinfo_attributes_insert(struct fsinfo_context *ctx,
> +				     const struct fsinfo_attribute *attr)
> +{
> +	__u32 *buffer = ctx->buffer;
> +	unsigned int i;
> +
> +	if (ctx->usage > ctx->buf_size ||
> +	    ctx->buf_size - ctx->usage < sizeof(__u32)) {
> +		ctx->usage += sizeof(__u32);
> +		return;
> +	}
> +
> +	for (i = 0; i < ctx->usage / sizeof(__u32); i++)
> +		if (buffer[i] == attr->attr_id)
> +			return;
> +
> +	buffer[i] = attr->attr_id;
> +	ctx->usage += sizeof(__u32);
> +}
> +
> +static int fsinfo_attributes(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct fsinfo_attribute *attr;
> +	struct super_block *sb = path->dentry->d_sb;
> +
> +	if (sb->s_op->fsinfo_attributes)
> +		for (attr = sb->s_op->fsinfo_attributes; attr->get; attr++)
> +			fsinfo_attributes_insert(ctx, attr);
> +	for (attr = fsinfo_common_attributes; attr->get; attr++)
> +		fsinfo_attributes_insert(ctx, attr);
> +	return ctx->usage;
> +}
> +
> +static const struct fsinfo_attribute fsinfo_common_attributes[] = {
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
> +	FSINFO_STRING 	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),

There's a space      ^ before the tab here.

> +	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
> +	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_attribute_info),
> +	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_attributes),
> +	{}
> +};
> +
> +/*
> + * Retrieve large filesystem information, such as an opaque blob or array of
> + * struct elements where the value isn't limited to the size of a page.
> + */
> +static int vfs_fsinfo_large(struct path *path, struct fsinfo_context *ctx,
> +			    const struct fsinfo_attribute *attr)
> +{
> +	int ret;
> +
> +	while (!signal_pending(current)) {
> +		ctx->usage = 0;
> +		ret = attr->get(path, ctx);
> +		if (IS_ERR_VALUE((long)ret))
> +			return ret; /* Error */
> +		if ((unsigned int)ret <= ctx->buf_size)
> +			return ret; /* It fitted */
> +
> +		/* We need to resize the buffer */
> +		kvfree(ctx->buffer);
> +		ctx->buffer = NULL;
> +		ctx->buf_size = roundup(ret, PAGE_SIZE);
> +		if (ctx->buf_size > INT_MAX)
> +			return -EMSGSIZE;
> +		ctx->buffer = kvmalloc(ctx->buf_size, GFP_KERNEL);
> +		if (!ctx->buffer)
> +			return -ENOMEM;
> +	}
> +
> +	return -ERESTARTSYS;
> +}
> +
> +static int vfs_do_fsinfo(struct path *path, struct fsinfo_context *ctx,
> +			 const struct fsinfo_attribute *attr)
> +{
> +	if (ctx->Nth != 0 && !(attr->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_NM)))
> +		return -ENODATA;
> +	if (ctx->Mth != 0 && !(attr->flags & FSINFO_FLAGS_NM))
> +		return -ENODATA;
> +
> +	ctx->buf_size = attr->size;
> +	if (ctx->want_size_only && attr->type == FSINFO_TYPE_VSTRUCT)
> +		return attr->size;
> +
> +	ctx->buffer = kvzalloc(ctx->buf_size, GFP_KERNEL);
> +	if (!ctx->buffer)
> +		return -ENOMEM;
> +
> +	switch (attr->type) {
> +	case FSINFO_TYPE_VSTRUCT:
> +		ctx->clear_tail = true;
> +		/* Fall through */
> +	case FSINFO_TYPE_STRING:
> +		return attr->get(path, ctx);
> +
> +	case FSINFO_TYPE_OPAQUE:
> +	case FSINFO_TYPE_LIST:
> +		return vfs_fsinfo_large(path, ctx, attr);
> +
> +	default:
> +		return -ENOPKG;
> +	}
> +}
> +
> +/**
> + * vfs_fsinfo - Retrieve filesystem information
> + * @path: The object to query
> + * @params: Parameters to define a request and place to store result
> + *
> + * Get an attribute on a filesystem or an object within a filesystem.  The
> + * filesystem attribute to be queried is indicated by @ctx->requested_attr, and
> + * if it's a multi-valued attribute, the particular value is selected by
> + * @ctx->Nth and then @ctx->Mth.
> + *
> + * For common attributes, a value may be fabricated if it is not supported by
> + * the filesystem.
> + *
> + * On success, the size of the attribute's value is returned (0 is a valid
> + * size).  A buffer will have been allocated and will be pointed to by
> + * @ctx->buffer.  The caller must free this with kvfree().
> + *
> + * Errors can also be returned: -ENOMEM if a buffer cannot be allocated, -EPERM
> + * or -EACCES if permission is denied by the LSM, -EOPNOTSUPP if an attribute
> + * doesn't exist for the specified object or -ENODATA if the attribute exists,
> + * but the Nth,Mth value does not exist.  -EMSGSIZE indicates that the value is
> + * unmanageable internally and -ENOPKG indicates other internal failure.
> + *
> + * Errors such as -EIO may also come from attempts to access media or servers
> + * to obtain the requested information if it's not immediately to hand.
> + *
> + * [*] Note that the caller may set @ctx->want_size_only if it only wants the
> + *     size of the value and not the data.  If this is set, a buffer may not be
> + *     allocated under some circumstances.  This is intended for size query by
> + *     userspace.
> + *
> + * [*] Note that @ctx->clear_tail will be returned set if the data should be
> + *     padded out with zeros when writing it to userspace.
> + */
> +static int vfs_fsinfo(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct fsinfo_attribute *attr;
> +	struct dentry *dentry = path->dentry;
> +	int ret;
> +
> +	if (dentry->d_sb->s_op->fsinfo_attributes)
> +		for (attr = dentry->d_sb->s_op->fsinfo_attributes; attr->get; attr++)
> +			if (attr->attr_id == ctx->requested_attr)
> +				goto found;
> +	for (attr = fsinfo_common_attributes; attr->get; attr++)
> +		if (attr->attr_id == ctx->requested_attr)
> +			goto found;
> +	return -EOPNOTSUPP;
> +
> +found:
> +	ret = security_sb_statfs(dentry);
> +	if (ret)
> +		return ret;
> +
> +	return vfs_do_fsinfo(path, ctx, attr);
> +}
> +
> +static int vfs_fsinfo_path(int dfd, const char __user *pathname,
> +			   unsigned int at_flags, struct fsinfo_context *ctx)
> +{
> +	struct path path;
> +	unsigned lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
> +	int ret = -EINVAL;
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
> +			  AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_NOFOLLOW)
> +		lookup_flags &= ~LOOKUP_FOLLOW;
> +	if (at_flags & AT_NO_AUTOMOUNT)
> +		lookup_flags &= ~LOOKUP_AUTOMOUNT;
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +retry:
> +	ret = user_path_at(dfd, pathname, lookup_flags, &path);
> +	if (ret)
> +		goto out;
> +
> +	ret = vfs_fsinfo(&path, ctx);
> +	path_put(&path);
> +	if (retry_estale(ret, lookup_flags)) {
> +		lookup_flags |= LOOKUP_REVAL;
> +		goto retry;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_context *ctx)
> +{
> +	struct fd f = fdget_raw(fd);
> +	int ret = -EBADF;
> +
> +	if (f.file) {
> +		ret = vfs_fsinfo(&f.file->f_path, ctx);
> +		fdput(f);
> +	}
> +	return ret;
> +}
> +
> +/**
> + * sys_fsinfo - System call to get filesystem information
> + * @dfd: Base directory to pathwalk from or fd referring to filesystem.
> + * @pathname: Filesystem to query or NULL.
> + * @_params: Parameters to define request (or NULL for enhanced statfs).
> + * @user_buffer: Result buffer.
> + * @user_buf_size: Size of result buffer.
> + *
> + * Get information on a filesystem.  The filesystem attribute to be queried is
> + * indicated by @_params->request, and some of the attributes can have multiple
> + * values, indexed by @_params->Nth and @_params->Mth.  If @_params is NULL,
> + * then the 0th fsinfo_attr_statfs attribute is queried.  If an attribute does
> + * not exist, EOPNOTSUPP is returned; if the Nth,Mth value does not exist,
> + * ENODATA is returned.
> + *
> + * On success, the size of the attribute's value is returned.  If
> + * @user_buf_size is 0 or @user_buffer is NULL, only the size is returned.  If
> + * the size of the value is larger than @user_buf_size, it will be truncated by
> + * the copy.  If the size of the value is smaller than @user_buf_size then the
> + * excess buffer space will be cleared.  The full size of the value will be
> + * returned, irrespective of how much data is actually placed in the buffer.
> + */
> +SYSCALL_DEFINE5(fsinfo,
> +		int, dfd, const char __user *, pathname,
> +		struct fsinfo_params __user *, params,
> +		void __user *, user_buffer, size_t, user_buf_size)
> +{
> +	struct fsinfo_context ctx;
> +	struct fsinfo_params user_params;
> +	unsigned int at_flags = 0, result_size;
> +	int ret;
> +
> +	if (!user_buffer && user_buf_size)
> +		return -EINVAL;
> +	if (user_buffer && !user_buf_size)
> +		return -EINVAL;
> +	if (user_buf_size > UINT_MAX)
> +		return -EOVERFLOW;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	ctx.requested_attr = FSINFO_ATTR_STATFS;
> +	if (user_buf_size == 0)
> +		ctx.want_size_only = true;
> +
> +	if (params) {
> +		if (copy_from_user(&user_params, params, sizeof(user_params)))
> +			return -EFAULT;
> +		if (user_params.__reserved32[0] ||
> +		    user_params.__reserved[0] ||
> +		    user_params.__reserved[1] ||
> +		    user_params.__reserved[2] ||
> +		    user_params.flags & ~FSINFO_FLAGS_QUERY_TYPE)
> +			return -EINVAL;
> +		at_flags = user_params.at_flags;
> +		ctx.flags = user_params.flags;
> +		ctx.requested_attr = user_params.request;
> +		ctx.Nth = user_params.Nth;
> +		ctx.Mth = user_params.Mth;
> +	}
> +
> +	switch (ctx.flags & FSINFO_FLAGS_QUERY_TYPE) {
> +	case FSINFO_FLAGS_QUERY_PATH:
> +		ret = vfs_fsinfo_path(dfd, pathname, at_flags, &ctx);
> +		break;
> +	case FSINFO_FLAGS_QUERY_FD:
> +		if (pathname)
> +			return -EINVAL;
> +		ret = vfs_fsinfo_fd(dfd, &ctx);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret < 0)
> +		goto error;
> +
> +	result_size = ret;
> +	if (result_size > user_buf_size)
> +		result_size = user_buf_size;
> +
> +	if (result_size > 0 &&
> +	    copy_to_user(user_buffer, ctx.buffer, result_size) != 0) {
> +		ret = -EFAULT;
> +		goto error;
> +	}
> +
> +	/* Clear any part of the buffer that we won't fill if we're putting a
> +	 * struct in there.  Strings, opaque objects and arrays are expected to
> +	 * be variable length.
> +	 */
> +	if (ctx.clear_tail &&
> +	    user_buf_size > result_size &&
> +	    clear_user(user_buffer + result_size, user_buf_size - result_size) != 0) {
> +		ret = -EFAULT;
> +		goto error;
> +	}
> +
> +error:
> +	kvfree(ctx.buffer);
> +	return ret;
> +}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..f74a4ee36eb3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -68,6 +68,8 @@ struct fsverity_info;
>  struct fsverity_operations;
>  struct fs_context;
>  struct fs_parameter_spec;
> +struct fsinfo_kparams;
> +struct fsinfo_attribute;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -1954,6 +1956,9 @@ struct super_operations {
>  	int (*thaw_super) (struct super_block *);
>  	int (*unfreeze_fs) (struct super_block *);
>  	int (*statfs) (struct dentry *, struct kstatfs *);
> +#ifdef CONFIG_FSINFO
> +	const struct fsinfo_attribute *fsinfo_attributes;
> +#endif
>  	int (*remount_fs) (struct super_block *, int *, char *);
>  	void (*umount_begin) (struct super_block *);
>  
> diff --git a/include/linux/fsinfo.h b/include/linux/fsinfo.h
> new file mode 100644
> index 000000000000..dcd55dbb02fa
> --- /dev/null
> +++ b/include/linux/fsinfo.h
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information query
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#ifndef _LINUX_FSINFO_H
> +#define _LINUX_FSINFO_H
> +
> +#ifdef CONFIG_FSINFO
> +
> +#include <uapi/linux/fsinfo.h>
> +
> +struct path;
> +
> +#define FSINFO_NORMAL_ATTR_MAX_SIZE 4096
> +
> +struct fsinfo_context {
> +	__u32		flags;		/* [in] FSINFO_FLAGS_* */
> +	__u32		requested_attr;	/* [in] What is being asking for */
> +	__u32		Nth;		/* [in] Instance of it (some may have multiple) */
> +	__u32		Mth;		/* [in] Subinstance */
> +	bool		want_size_only;	/* [in] Just want to know the size, not the data */
> +	bool		clear_tail;	/* [out] T if tail of buffer should be cleared */
> +	unsigned int	usage;		/* [tmp] Amount of buffer used (if large) */
> +	unsigned int	buf_size;	/* [tmp] Size of ->buffer[] */
> +	void		*buffer;	/* [out] The reply buffer */
> +};
> +
> +/*
> + * A filesystem information attribute definition.
> + */
> +struct fsinfo_attribute {
> +	unsigned int		attr_id;	/* The ID of the attribute */
> +	enum fsinfo_value_type	type:8;		/* The type of the attribute's value(s) */
> +	unsigned int		flags:8;
> +	unsigned int		size:16;	/* - Value size (FSINFO_STRUCT) */
> +	unsigned int		element_size:16; /* - Element size (FSINFO_LIST) */
> +	int (*get)(struct path *path, struct fsinfo_context *params);
> +};
> +
> +#define __FSINFO(A, T, S, E, G, F) \
> +	{ .attr_id = A, .type = T, .flags = F, .size = S, .element_size = E, .get = G }
> +
> +#define _FSINFO(A, T, S, E, G)	  __FSINFO(A, T, S, E, G, 0)
> +#define _FSINFO_N(A, T, S, E, G)  __FSINFO(A, T, S, E, G, FSINFO_FLAGS_N)
> +#define _FSINFO_NM(A, T, S, E, G) __FSINFO(A, T, S, E, G, FSINFO_FLAGS_NM)
> +
> +#define _FSINFO_VSTRUCT(A,S,G)	  _FSINFO   (A, FSINFO_TYPE_VSTRUCT, sizeof(S), 0, G)
> +#define _FSINFO_VSTRUCT_N(A,S,G)  _FSINFO_N (A, FSINFO_TYPE_VSTRUCT, sizeof(S), 0, G)
> +#define _FSINFO_VSTRUCT_NM(A,S,G) _FSINFO_NM(A, FSINFO_TYPE_VSTRUCT, sizeof(S), 0, G)
> +
> +#define FSINFO_VSTRUCT(A,G)	_FSINFO_VSTRUCT   (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_N(A,G)	_FSINFO_VSTRUCT_N (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_NM(A,G)	_FSINFO_VSTRUCT_NM(A, A##__STRUCT, G)
> +#define FSINFO_STRING(A,G)	_FSINFO   (A, FSINFO_TYPE_STRING, FSINFO_NORMAL_ATTR_MAX_SIZE, 0, G)
> +#define FSINFO_STRING_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_STRING, FSINFO_NORMAL_ATTR_MAX_SIZE, 0, G)
> +#define FSINFO_STRING_NM(A,G)	_FSINFO_NM(A, FSINFO_TYPE_STRING, FSINFO_NORMAL_ATTR_MAX_SIZE, 0, G)
> +#define FSINFO_OPAQUE(A,G)	_FSINFO   (A, FSINFO_TYPE_OPAQUE, FSINFO_NORMAL_ATTR_MAX_SIZE, 0, G)
> +#define FSINFO_LIST(A,G)	_FSINFO   (A, FSINFO_TYPE_LIST, FSINFO_NORMAL_ATTR_MAX_SIZE, \
> +					   sizeof(A##__STRUCT), G)
> +#define FSINFO_LIST_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_LIST, FSINFO_NORMAL_ATTR_MAX_SIZE, \
> +					   sizeof(A##__STRUCT), G)
> +
> +extern int fsinfo_string(const char *, struct fsinfo_context *);
> +
> +#endif /* CONFIG_FSINFO */
> +
> +#endif /* _LINUX_FSINFO_H */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1815065d52f3..6c3157e46e7c 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -47,6 +47,7 @@ struct stat64;
>  struct statfs;
>  struct statfs64;
>  struct statx;
> +struct fsinfo_params;
>  struct __sysctl_args;
>  struct sysinfo;
>  struct timespec;
> @@ -1003,6 +1004,9 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
>  				       siginfo_t __user *info,
>  				       unsigned int flags);
>  asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
> +asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
> +			   struct fsinfo_params __user *params,
> +			   void __user *buffer, size_t buf_size);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 3a3201e4618e..9d00098a3f1b 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
>  __SYSCALL(__NR_openat2, sys_openat2)
>  #define __NR_pidfd_getfd 438
>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
> +#define __NR_fsinfo 439
> +__SYSCALL(__NR_fsinfo, sys_fsinfo)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 439
> +#define __NR_syscalls 440
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> new file mode 100644
> index 000000000000..365d54fe9290
> --- /dev/null
> +++ b/include/uapi/linux/fsinfo.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* fsinfo() definitions.
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +#ifndef _UAPI_LINUX_FSINFO_H
> +#define _UAPI_LINUX_FSINFO_H
> +
> +#include <linux/types.h>
> +#include <linux/socket.h>
> +
> +/*
> + * The filesystem attributes that can be requested.  Note that some attributes
> + * may have multiple instances which can be switched in the parameter block.
> + */
> +#define FSINFO_ATTR_STATFS		0x00	/* statfs()-style state */
> +#define FSINFO_ATTR_IDS			0x01	/* Filesystem IDs */
> +#define FSINFO_ATTR_LIMITS		0x02	/* Filesystem limits */
> +#define FSINFO_ATTR_SUPPORTS		0x03	/* What's supported in statx, iocflags, ... */
> +#define FSINFO_ATTR_TIMESTAMP_INFO	0x04	/* Inode timestamp info */
> +#define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
> +#define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
> +#define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */

I think I've muttered about the distinction between volume id and
volume name before, but I'm still wondering how confusing that will be
for users?  Let me check my assumptions, though:

Volume ID is whatever's in super_block.s_id, which (at least for xfs and
ext4) is the device name (e.g. "sda1").  I guess that's useful for
correlating a thing you can call fsinfo() on against strings that were
logged in dmesg.

Volume name I think is the fs label (e.g. "home"), which I think will
have to be implemented separately by each filesystem, and that's why
there's no generic vfs implementation.

Do I have that correct?

> +
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
> +
> +/*
> + * Optional fsinfo() parameter structure.
> + *
> + * If this is not given, it is assumed that fsinfo_attr_statfs instance 0,0 is
> + * desired.
> + */
> +struct fsinfo_params {
> +	__u32	at_flags;	/* AT_SYMLINK_NOFOLLOW and similar flags */
> +	__u32	flags;		/* Flags controlling fsinfo() specifically */
> +#define FSINFO_FLAGS_QUERY_TYPE	0x0007 /* What object should fsinfo() query? */
> +#define FSINFO_FLAGS_QUERY_PATH	0x0000 /* - path, specified by dirfd,pathname,AT_EMPTY_PATH */
> +#define FSINFO_FLAGS_QUERY_FD	0x0001 /* - fd specified by dirfd */

The 7 -> 0 -> 1 sequence here confused me until I figured out that
QUERY_TYPE is the mask for QUERY_{PATH,FD}.

> +	__u32	request;	/* ID of requested attribute */
> +	__u32	Nth;		/* Instance of it (some may have multiple) */
> +	__u32	Mth;		/* Subinstance of Nth instance */
> +	__u32	__reserved32[1]; /* Reserved params; all must be 0 */
> +	__u64	__reserved[3];
> +};
> +
> +enum fsinfo_value_type {
> +	FSINFO_TYPE_VSTRUCT	= 0,	/* Version-lengthed struct (up to 4096 bytes) */
> +	FSINFO_TYPE_STRING	= 1,	/* NUL-term var-length string (up to 4095 chars) */
> +	FSINFO_TYPE_OPAQUE	= 2,	/* Opaque blob (unlimited size) */
> +	FSINFO_TYPE_LIST	= 3,	/* List of ints/structs (unlimited size) */
> +};
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO).
> + *
> + * This gives information about the attributes supported by fsinfo for the
> + * given path.
> + */
> +struct fsinfo_attribute_info {
> +	unsigned int		attr_id;	/* The ID of the attribute */
> +	enum fsinfo_value_type	type;		/* The type of the attribute's value(s) */
> +	unsigned int		flags;
> +#define FSINFO_FLAGS_N		0x01		/* - Attr has a set of values */
> +#define FSINFO_FLAGS_NM		0x02		/* - Attr has a set of sets of values */
> +	unsigned int		size;		/* - Value size (FSINFO_STRUCT) */
> +	unsigned int		element_size;	/* - Element size (FSINFO_LIST) */
> +};
> +
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO__STRUCT struct fsinfo_attribute_info
> +#define FSINFO_ATTR_FSINFO_ATTRIBUTES__STRUCT __u32
> +
> +struct fsinfo_u128 {
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
> +	__u64	hi;
> +	__u64	lo;
> +#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
> +	__u64	lo;
> +	__u64	hi;
> +#endif
> +};
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_STATFS).
> + * - This gives extended filesystem information.
> + */
> +struct fsinfo_statfs {
> +	struct fsinfo_u128 f_blocks;	/* Total number of blocks in fs */
> +	struct fsinfo_u128 f_bfree;	/* Total number of free blocks */
> +	struct fsinfo_u128 f_bavail;	/* Number of free blocks available to ordinary user */
> +	struct fsinfo_u128 f_files;	/* Total number of file nodes in fs */
> +	struct fsinfo_u128 f_ffree;	/* Number of free file nodes */
> +	struct fsinfo_u128 f_favail;	/* Number of file nodes available to ordinary user */
> +	__u64	f_bsize;		/* Optimal block size */
> +	__u64	f_frsize;		/* Fragment size */
> +};
> +
> +#define FSINFO_ATTR_STATFS__STRUCT struct fsinfo_statfs
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_IDS).
> + *
> + * List of basic identifiers as is normally found in statfs().
> + */
> +struct fsinfo_ids {
> +	char	f_fs_name[15 + 1];	/* Filesystem name */
> +	__u64	f_fsid;			/* Short 64-bit Filesystem ID (as statfs) */
> +	__u64	f_sb_id;		/* Internal superblock ID for sbnotify()/mntnotify() */
> +	__u32	f_fstype;		/* Filesystem type from linux/magic.h [uncond] */
> +	__u32	f_dev_major;		/* As st_dev_* from struct statx [uncond] */
> +	__u32	f_dev_minor;
> +	__u32	__reserved[1];
> +};
> +
> +#define FSINFO_ATTR_IDS__STRUCT struct fsinfo_ids
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_LIMITS).
> + *
> + * List of supported filesystem limits.
> + */
> +struct fsinfo_limits {
> +	struct fsinfo_u128 max_file_size;	/* Maximum file size */
> +	struct fsinfo_u128 max_ino;		/* Maximum inode number */
> +	__u64	max_uid;			/* Maximum UID supported */
> +	__u64	max_gid;			/* Maximum GID supported */
> +	__u64	max_projid;			/* Maximum project ID supported */
> +	__u64	max_hard_links;			/* Maximum number of hard links on a file */
> +	__u64	max_xattr_body_len;		/* Maximum xattr content length */
> +	__u32	max_xattr_name_len;		/* Maximum xattr name length */
> +	__u32	max_filename_len;		/* Maximum filename length */
> +	__u32	max_symlink_len;		/* Maximum symlink content length */
> +	__u32	max_dev_major;			/* Maximum device major representable */
> +	__u32	max_dev_minor;			/* Maximum device minor representable */
> +	__u32	__reserved[1];

I wonder if these structures ought to reserve more space than a single u32...

> +};
> +
> +#define FSINFO_ATTR_LIMITS__STRUCT struct fsinfo_limits
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_SUPPORTS).
> + *
> + * What's supported in various masks, such as statx() attribute and mask bits
> + * and IOC flags.
> + */
> +struct fsinfo_supports {
> +	__u64	stx_attributes;		/* What statx::stx_attributes are supported */
> +	__u32	stx_mask;		/* What statx::stx_mask bits are supported */
> +	__u32	ioc_flags;		/* What FS_IOC_* flags are supported */

"IOC"?  That just means 'ioctl'.  Is this field supposed to return the
supported FS_IOC_GETFLAGS flags, or the supported FS_IOC_FSGETXATTR
flags?

I suspect it would also be a big help to be able to tell userspace which
of the flags can be set, and which can be cleared.

> +	__u32	win_file_attrs;		/* What DOS/Windows FILE_* attributes are supported */
> +	__u32	__reserved[1];
> +};
> +
> +#define FSINFO_ATTR_SUPPORTS__STRUCT struct fsinfo_supports
> +
> +struct fsinfo_timestamp_one {
> +	__s64	minimum;	/* Minimum timestamp value in seconds */
> +	__u64	maximum;	/* Maximum timestamp value in seconds */

Given that time64_t is s64, why is the maximum here u64?

> +	__u16	gran_mantissa;	/* Granularity(secs) = mant * 10^exp */
> +	__s8	gran_exponent;
> +	__u8	reserved[5];
> +};
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_TIMESTAMP_INFO).
> + */
> +struct fsinfo_timestamp_info {
> +	struct fsinfo_timestamp_one	atime;	/* Access time */
> +	struct fsinfo_timestamp_one	mtime;	/* Modification time */
> +	struct fsinfo_timestamp_one	ctime;	/* Change time */
> +	struct fsinfo_timestamp_one	btime;	/* Birth/creation time */
> +};
> +
> +#define FSINFO_ATTR_TIMESTAMP_INFO__STRUCT struct fsinfo_timestamp_info
> +
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_VOLUME_UUID).
> + */
> +struct fsinfo_volume_uuid {
> +	__u8	uuid[16];
> +};
> +
> +#define FSINFO_ATTR_VOLUME_UUID__STRUCT struct fsinfo_volume_uuid
> +
> +#endif /* _UAPI_LINUX_FSINFO_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 3b69a560a7ac..58246e6b5603 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -51,6 +51,7 @@ COND_SYSCALL_COMPAT(io_pgetevents);
>  COND_SYSCALL(io_uring_setup);
>  COND_SYSCALL(io_uring_enter);
>  COND_SYSCALL(io_uring_register);
> +COND_SYSCALL(fsinfo);
>  
>  /* fs/xattr.c */
>  
> diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
> index 65acdde5c117..9159ad1d7fc5 100644
> --- a/samples/vfs/Makefile
> +++ b/samples/vfs/Makefile
> @@ -1,10 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # List of programs to build
> +
>  hostprogs := \
> +	test-fsinfo \
>  	test-fsmount \
>  	test-statx
>  
>  always-y := $(hostprogs)
>  
> +HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
> +HOSTLDLIBS_test-fsinfo += -static -lm
> +
>  HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
>  HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> new file mode 100644
> index 000000000000..9a4d49db2996
> --- /dev/null
> +++ b/samples/vfs/test-fsinfo.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Test the fsinfo() system call
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define _GNU_SOURCE
> +#define _ATFILE_SOURCE
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +#include <errno.h>
> +#include <time.h>
> +#include <math.h>
> +#include <fcntl.h>
> +#include <sys/syscall.h>
> +#include <linux/fsinfo.h>
> +#include <linux/socket.h>
> +#include <sys/stat.h>
> +#include <arpa/inet.h>
> +
> +#ifndef __NR_fsinfo
> +#define __NR_fsinfo -1
> +#endif
> +
> +static bool debug = 0;
> +
> +static __attribute__((unused))
> +ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *params,
> +	       void *buffer, size_t buf_size)
> +{
> +	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
> +}
> +
> +struct fsinfo_attribute {
> +	unsigned int		attr_id;
> +	enum fsinfo_value_type	type;
> +	unsigned int		size;
> +	const char		*name;
> +	void (*dump)(void *reply, unsigned int size);
> +};
> +
> +static const struct fsinfo_attribute fsinfo_attributes[];
> +
> +static void dump_hex(unsigned int *data, int from, int to)
> +{
> +	unsigned offset, print_offset = 1, col = 0;
> +
> +	from /= 4;
> +	to = (to + 3) / 4;
> +
> +	for (offset = from; offset < to; offset++) {
> +		if (print_offset) {
> +			printf("%04x: ", offset * 8);
> +			print_offset = 0;
> +		}
> +		printf("%08x", data[offset]);
> +		col++;
> +		if ((col & 3) == 0) {
> +			printf("\n");
> +			print_offset = 1;
> +		} else {
> +			printf(" ");
> +		}
> +	}
> +
> +	if (!print_offset)
> +		printf("\n");
> +}
> +
> +static void dump_attribute_info(void *reply, unsigned int size)
> +{
> +	struct fsinfo_attribute_info *attr_info = reply;
> +	const struct fsinfo_attribute *attr;
> +	char type[32];
> +
> +	switch (attr_info->type) {
> +	case FSINFO_TYPE_VSTRUCT:	strcpy(type, "V-STRUCT");	break;
> +	case FSINFO_TYPE_STRING:	strcpy(type, "STRING");		break;
> +	case FSINFO_TYPE_OPAQUE:	strcpy(type, "OPAQUE");		break;
> +	case FSINFO_TYPE_LIST:		strcpy(type, "LIST");		break;
> +	default:
> +		sprintf(type, "type-%x", attr_info->type);
> +		break;
> +	}
> +
> +	if (attr_info->flags & FSINFO_FLAGS_N)
> +		strcat(type, " x N");
> +	else if (attr_info->flags & FSINFO_FLAGS_NM)
> +		strcat(type, " x NM");
> +
> +	for (attr = fsinfo_attributes; attr->name; attr++)
> +		if (attr->attr_id == attr_info->attr_id)
> +			break;
> +
> +	printf("%8x %-12s %08x %5u %5u %s\n",
> +	       attr_info->attr_id,
> +	       type,
> +	       attr_info->flags,
> +	       attr_info->size,
> +	       attr_info->element_size,
> +	       attr->name ? attr->name : "");
> +}
> +
> +static void dump_fsinfo_generic_statfs(void *reply, unsigned int size)
> +{
> +	struct fsinfo_statfs *f = reply;
> +
> +	printf("\n");
> +	printf("\tblocks       : n=%llu fr=%llu av=%llu\n",
> +	       (unsigned long long)f->f_blocks.lo,
> +	       (unsigned long long)f->f_bfree.lo,
> +	       (unsigned long long)f->f_bavail.lo);
> +
> +	printf("\tfiles        : n=%llu fr=%llu av=%llu\n",
> +	       (unsigned long long)f->f_files.lo,
> +	       (unsigned long long)f->f_ffree.lo,
> +	       (unsigned long long)f->f_favail.lo);
> +	printf("\tbsize        : %llu\n", f->f_bsize);
> +	printf("\tfrsize       : %llu\n", f->f_frsize);
> +}
> +
> +static void dump_fsinfo_generic_ids(void *reply, unsigned int size)
> +{
> +	struct fsinfo_ids *f = reply;
> +
> +	printf("\n");
> +	printf("\tdev          : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
> +	printf("\tfs           : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
> +	printf("\tfsid         : %llx\n", (unsigned long long)f->f_fsid);
> +}
> +
> +static void dump_fsinfo_generic_limits(void *reply, unsigned int size)
> +{
> +	struct fsinfo_limits *f = reply;
> +
> +	printf("\n");
> +	printf("\tmax file size: %llx%016llx\n",
> +	       (unsigned long long)f->max_file_size.hi,
> +	       (unsigned long long)f->max_file_size.lo);
> +	printf("\tmax ino      : %llx%016llx\n",
> +	       (unsigned long long)f->max_ino.hi,
> +	       (unsigned long long)f->max_ino.lo);
> +	printf("\tmax ids      : u=%llx g=%llx p=%llx\n",
> +	       (unsigned long long)f->max_uid,
> +	       (unsigned long long)f->max_gid,
> +	       (unsigned long long)f->max_projid);
> +	printf("\tmax dev      : maj=%x min=%x\n",
> +	       f->max_dev_major, f->max_dev_minor);
> +	printf("\tmax links    : %llx\n",
> +	       (unsigned long long)f->max_hard_links);
> +	printf("\tmax xattr    : n=%x b=%llx\n",
> +	       f->max_xattr_name_len,
> +	       (unsigned long long)f->max_xattr_body_len);
> +	printf("\tmax len      : file=%x sym=%x\n",
> +	       f->max_filename_len, f->max_symlink_len);
> +}
> +
> +static void dump_fsinfo_generic_supports(void *reply, unsigned int size)
> +{
> +	struct fsinfo_supports *f = reply;
> +
> +	printf("\n");
> +	printf("\tstx_attr     : %llx\n", (unsigned long long)f->stx_attributes);
> +	printf("\tstx_mask     : %x\n", f->stx_mask);
> +	printf("\tioc_flags    : %x\n", f->ioc_flags);
> +	printf("\twin_fattrs   : %x\n", f->win_file_attrs);
> +}
> +
> +static void print_time(struct fsinfo_timestamp_one *t, char stamp)
> +{
> +	printf("\t%ctime       : gran=%gs range=%llx-%llx\n",
> +	       stamp,
> +	       t->gran_mantissa * pow(10., t->gran_exponent),
> +	       (long long)t->minimum,
> +	       (long long)t->maximum);
> +}
> +
> +static void dump_fsinfo_generic_timestamp_info(void *reply, unsigned int size)
> +{
> +	struct fsinfo_timestamp_info *f = reply;
> +
> +	printf("\n");
> +	print_time(&f->atime, 'a');
> +	print_time(&f->mtime, 'm');
> +	print_time(&f->ctime, 'c');
> +	print_time(&f->btime, 'b');
> +}
> +
> +static void dump_fsinfo_generic_volume_uuid(void *reply, unsigned int size)
> +{
> +	struct fsinfo_volume_uuid *f = reply;
> +
> +	printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x"
> +	       "-%02x%02x%02x%02x%02x%02x\n",
> +	       f->uuid[ 0], f->uuid[ 1],
> +	       f->uuid[ 2], f->uuid[ 3],
> +	       f->uuid[ 4], f->uuid[ 5],
> +	       f->uuid[ 6], f->uuid[ 7],
> +	       f->uuid[ 8], f->uuid[ 9],
> +	       f->uuid[10], f->uuid[11],
> +	       f->uuid[12], f->uuid[13],
> +	       f->uuid[14], f->uuid[15]);
> +}
> +
> +static void dump_string(void *reply, unsigned int size)
> +{
> +	char *s = reply, *p;
> +
> +	p = s;
> +	if (size >= 4096) {
> +		size = 4096;
> +		p[4092] = '.';
> +		p[4093] = '.';
> +		p[4094] = '.';
> +		p[4095] = 0;
> +	} else {
> +		p[size] = 0;
> +	}
> +
> +	for (p = s; *p; p++) {
> +		if (!isprint(*p)) {
> +			printf("<non-printable>\n");
> +			continue;
> +		}
> +	}
> +
> +	printf("%s\n", s);
> +}
> +
> +#define dump_fsinfo_generic_volume_id		dump_string
> +#define dump_fsinfo_generic_volume_name		dump_string
> +#define dump_fsinfo_generic_name_encoding	dump_string
> +
> +/*
> + *
> + */
> +#define __FSINFO(A, T, S, U, G, F) \
> +	{ .attr_id = A, .type = T, .size = S, .name = #G, .dump = dump_##G }
> +
> +#define _FSINFO(A, T, S, U, G)	  __FSINFO(A, T, S, U, G, 0)
> +#define _FSINFO_N(A, T, S, U, G)  __FSINFO(A, T, S, U, G, FSINFO_FLAGS_N)
> +#define _FSINFO_NM(A, T, S, U, G) __FSINFO(A, T, S, U, G, FSINFO_FLAGS_NM)
> +
> +#define _FSINFO_VSTRUCT(A,S,G)	 _FSINFO    (A, FSINFO_TYPE_VSTRUCT, sizeof(S), 0, G)
> +#define _FSINFO_VSTRUCT_N(A,S,G) _FSINFO_N  (A, FSINFO_TYPE_VSTRUCT, sizeof(S), 0, G)
> +#define _FSINFO_VSTRUCT_NM(A,S,G) _FSINFO_NM(A, FSINFO_TYPE_VSTRUCT, sizeof(S), 0, G)
> +
> +#define FSINFO_VSTRUCT(A,G)	_FSINFO_VSTRUCT   (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_N(A,G)	_FSINFO_VSTRUCT_N (A, A##__STRUCT, G)
> +#define FSINFO_VSTRUCT_NM(A,G)	_FSINFO_VSTRUCT_NM(A, A##__STRUCT, G)
> +#define FSINFO_STRING(A,G)	_FSINFO   (A, FSINFO_TYPE_STRING, 0, 0, G)
> +#define FSINFO_STRING_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_STRING, 0, 0, G)
> +#define FSINFO_STRING_NM(A,G)	_FSINFO_NM(A, FSINFO_TYPE_STRING, 0, 0, G)
> +#define FSINFO_OPAQUE(A,G)	_FSINFO   (A, FSINFO_TYPE_OPAQUE, 0, 0, G)
> +#define FSINFO_LIST(A,G)	_FSINFO   (A, FSINFO_TYPE_LIST, 0, sizeof(A##__STRUCT), G)
> +#define FSINFO_LIST_N(A,G)	_FSINFO_N (A, FSINFO_TYPE_LIST, 0, sizeof(A##__STRUCT), G)
> +
> +static const struct fsinfo_attribute fsinfo_attributes[] = {
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		fsinfo_generic_limits),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		fsinfo_generic_supports),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	fsinfo_generic_timestamp_info),
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	fsinfo_generic_volume_name),
> +	{}
> +};
> +
> +static void dump_value(unsigned int attr_id,
> +		       const struct fsinfo_attribute *attr,
> +		       const struct fsinfo_attribute_info *attr_info,
> +		       void *reply, unsigned int size)
> +{
> +	if (!attr || !attr->dump) {
> +		printf("<no dumper>\n");
> +		return;
> +	}
> +
> +	if (attr->type == FSINFO_TYPE_VSTRUCT && size < attr->size) {
> +		printf("<short data %u/%u>\n", size, attr->size);
> +		return;
> +	}
> +
> +	attr->dump(reply, size);
> +}
> +
> +static void dump_list(unsigned int attr_id,
> +		      const struct fsinfo_attribute *attr,
> +		      const struct fsinfo_attribute_info *attr_info,
> +		      void *reply, unsigned int size)
> +{
> +	size_t elem_size = attr_info->element_size;
> +	unsigned int ix = 0;
> +
> +	printf("\n");
> +	if (!attr || !attr->dump) {
> +		printf("<no dumper>\n");
> +		return;
> +	}
> +
> +	if (attr->type == FSINFO_TYPE_VSTRUCT && size < attr->size) {
> +		printf("<short data %u/%u>\n", size, attr->size);
> +		return;
> +	}
> +
> +	while (size >= elem_size) {
> +		printf("\t[%02x] ", ix);
> +		attr->dump(reply, size);
> +		reply += elem_size;
> +		size -= elem_size;
> +		ix++;
> +	}
> +}
> +
> +/*
> + * Call fsinfo, expanding the buffer as necessary.
> + */
> +static ssize_t get_fsinfo(const char *file, const char *name,
> +			  struct fsinfo_params *params, void **_r)
> +{
> +	ssize_t ret;
> +	size_t buf_size = 4096;
> +	void *r;
> +
> +	for (;;) {
> +		r = malloc(buf_size);
> +		if (!r) {
> +			perror("malloc");
> +			exit(1);
> +		}
> +		memset(r, 0xbd, buf_size);
> +
> +		errno = 0;
> +		ret = fsinfo(AT_FDCWD, file, params, r, buf_size);
> +		if (ret == -1) {
> +			free(r);
> +			*_r = NULL;
> +			return ret;
> +		}
> +
> +		if (ret <= buf_size)
> +			break;
> +		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
> +	}
> +
> +	if (debug) {
> +		if (ret == -1)
> +			printf("fsinfo(%s,%s,%u,%u) = %m\n",
> +			       file, name, params->Nth, params->Mth);
> +		else
> +			printf("fsinfo(%s,%s,%u,%u) = %zd\n",
> +			       file, name, params->Nth, params->Mth, ret);
> +	}
> +
> +	*_r = r;
> +	return ret;
> +}
> +
> +/*
> + * Try one subinstance of an attribute.
> + */
> +static int try_one(const char *file, struct fsinfo_params *params,
> +		   const struct fsinfo_attribute_info *attr_info, bool raw)
> +{
> +	const struct fsinfo_attribute *attr;
> +	const char *name;
> +	size_t size = 4096;
> +	char namebuf[32];
> +	void *r;
> +
> +	//printf("try %03x[%u][%u]\n", params->request, params->Nth, params->Mth);

Stray debugging statement?

--D

> +
> +	for (attr = fsinfo_attributes; attr->name; attr++) {
> +		if (attr->attr_id == params->request) {
> +			name = attr->name;
> +			if (strncmp(name, "fsinfo_generic_", 15) == 0)
> +				name += 15;
> +			goto found;
> +		}
> +	}
> +
> +	sprintf(namebuf, "<unknown-%x>", params->request);
> +	name = namebuf;
> +	attr = NULL;
> +
> +found:
> +	size = get_fsinfo(file, name, params, &r);
> +
> +	if (size == -1) {
> +		if (errno == ENODATA) {
> +			if (!(attr_info->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_NM)) &&
> +			    params->Nth == 0 && params->Mth == 0) {
> +				fprintf(stderr,
> +					"Unexpected ENODATA (0x%x{%u}{%u})\n",
> +					params->request, params->Nth, params->Mth);
> +				exit(1);
> +			}
> +			free(r);
> +			return (params->Mth == 0) ? 2 : 1;
> +		}
> +		if (errno == EOPNOTSUPP) {
> +			if (params->Nth > 0 || params->Mth > 0) {
> +				fprintf(stderr,
> +					"Should return -ENODATA (0x%x{%u}{%u})\n",
> +					params->request, params->Nth, params->Mth);
> +				exit(1);
> +			}
> +			//printf("\e[33m%s\e[m: <not supported>\n",
> +			//       fsinfo_attr_names[attr]);
> +			free(r);
> +			return 2;
> +		}
> +		perror(file);
> +		exit(1);
> +	}
> +
> +	if (raw) {
> +		if (size > 4096)
> +			size = 4096;
> +		dump_hex(r, 0, size);
> +		free(r);
> +		return 0;
> +	}
> +
> +	switch (attr_info->flags & (FSINFO_FLAGS_N | FSINFO_FLAGS_NM)) {
> +	case 0:
> +		printf("\e[33m%s\e[m: ", name);
> +		break;
> +	case FSINFO_FLAGS_N:
> +		printf("\e[33m%s{%u}\e[m: ", name, params->Nth);
> +		break;
> +	case FSINFO_FLAGS_NM:
> +		printf("\e[33m%s{%u,%u}\e[m: ", name, params->Nth, params->Mth);
> +		break;
> +	}
> +
> +	switch (attr_info->type) {
> +	case FSINFO_TYPE_VSTRUCT:
> +	case FSINFO_TYPE_STRING:
> +		dump_value(params->request, attr, attr_info, r, size);
> +		free(r);
> +		return 0;
> +
> +	case FSINFO_TYPE_LIST:
> +		dump_list(params->request, attr, attr_info, r, size);
> +		free(r);
> +		return 0;
> +
> +	case FSINFO_TYPE_OPAQUE:
> +		free(r);
> +		return 0;
> +
> +	default:
> +		fprintf(stderr, "Fishy about %u 0x%x,%x,%x\n",
> +			params->request, attr_info->type, attr_info->flags, attr_info->size);
> +		exit(1);
> +	}
> +}
> +
> +static int cmp_u32(const void *a, const void *b)
> +{
> +	return *(const int *)a - *(const int *)b;
> +}
> +
> +/*
> + *
> + */
> +int main(int argc, char **argv)
> +{
> +	struct fsinfo_attribute_info attr_info;
> +	struct fsinfo_params params = {
> +		.at_flags	= AT_SYMLINK_NOFOLLOW,
> +		.flags		= FSINFO_FLAGS_QUERY_PATH,
> +	};
> +	unsigned int *attrs, ret, nr, i;
> +	bool meta = false;
> +	int raw = 0, opt, Nth, Mth;
> +
> +	while ((opt = getopt(argc, argv, "adlmr"))) {
> +		switch (opt) {
> +		case 'a':
> +			params.at_flags |= AT_NO_AUTOMOUNT;
> +			continue;
> +		case 'd':
> +			debug = true;
> +			continue;
> +		case 'l':
> +			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
> +			continue;
> +		case 'm':
> +			meta = true;
> +			continue;
> +		case 'r':
> +			raw = 1;
> +			continue;
> +		}
> +		break;
> +	}
> +
> +	argc -= optind;
> +	argv += optind;
> +
> +	if (argc != 1) {
> +		printf("Format: test-fsinfo [-alr] <file>\n");
> +		exit(2);
> +	}
> +
> +	/* Retrieve a list of supported attribute IDs */
> +	params.request = FSINFO_ATTR_FSINFO_ATTRIBUTES;
> +	params.Nth = 0;
> +	params.Mth = 0;
> +	ret = get_fsinfo(argv[0], "attributes", &params, (void **)&attrs);
> +	if (ret == -1) {
> +		fprintf(stderr, "Unable to get attribute list: %m\n");
> +		exit(1);
> +	}
> +
> +	if (ret % sizeof(attrs[0])) {
> +		fprintf(stderr, "Bad length of attribute list (0x%x)\n", ret);
> +		exit(2);
> +	}
> +
> +	nr = ret / sizeof(attrs[0]);
> +	qsort(attrs, nr, sizeof(attrs[0]), cmp_u32);
> +
> +	if (meta) {
> +		printf("ATTR ID  TYPE         FLAGS    SIZE  ESIZE NAME\n");
> +		printf("======== ============ ======== ===== ===== =========\n");
> +		for (i = 0; i < nr; i++) {
> +			params.request = FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO;
> +			params.Nth = attrs[i];
> +			params.Mth = 0;
> +			ret = fsinfo(AT_FDCWD, argv[0], &params, &attr_info, sizeof(attr_info));
> +			if (ret == -1) {
> +				fprintf(stderr, "Can't get info for attribute %x: %m\n", attrs[i]);
> +				exit(1);
> +			}
> +
> +			dump_attribute_info(&attr_info, ret);
> +		}
> +		exit(0);
> +	}
> +
> +	for (i = 0; i < nr; i++) {
> +		params.request = FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO;
> +		params.Nth = attrs[i];
> +		params.Mth = 0;
> +		ret = fsinfo(AT_FDCWD, argv[0], &params, &attr_info, sizeof(attr_info));
> +		if (ret == -1) {
> +			fprintf(stderr, "Can't get info for attribute %x: %m\n", attrs[i]);
> +			exit(1);
> +		}
> +
> +		if (attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO ||
> +		    attrs[i] == FSINFO_ATTR_FSINFO_ATTRIBUTES)
> +			continue;
> +
> +		Nth = 0;
> +		do {
> +			Mth = 0;
> +			do {
> +				params.request = attrs[i];
> +				params.Nth = Nth;
> +				params.Mth = Mth;
> +
> +				switch (try_one(argv[0], &params, &attr_info, raw)) {
> +				case 0:
> +					continue;
> +				case 1:
> +					goto done_M;
> +				case 2:
> +					goto done_N;
> +				}
> +			} while (++Mth < 100);
> +
> +		done_M:
> +			if (Mth >= 100) {
> +				fprintf(stderr, "Fishy: Mth %x[%u][%u]\n", attrs[i], Nth, Mth);
> +				break;
> +			}
> +
> +		} while (++Nth < 100);
> +
> +	done_N:
> +		if (Nth >= 100) {
> +			fprintf(stderr, "Fishy: Nth %x[%u]\n", attrs[i], Nth);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> 
> 
