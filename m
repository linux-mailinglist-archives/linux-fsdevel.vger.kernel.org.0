Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE35164B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSREi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 12:04:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34306 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSREh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:04:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JH3LhL035034;
        Wed, 19 Feb 2020 17:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WNyxaYnjYTbFyAy1OFbJCDSxeKLcmpSXJnZ9vi1Notk=;
 b=lPzw6N0MzdtO3b8O7PL6yv4BCJkTzynawyIjwi+b7jTwcabFHS6aRlOmPMOzUZI1KSTy
 DoEw5c2QOk2qFd3+Mc66yAcUomh6IhlVR/2hUNf0eWkhduyhS8vOv7BptYukoP9fcejU
 8fvp2OewGJM76OGe2h+Wp6qx+s+VXkL7dZsAponjP0LmlKOhkV8Mk+u0klx9iu2V9Ym0
 oPMyv7q0tBTUR0jgVIfMFbF/v7frDZOE89zCunVFyX/JVIK7SfRS2D5PX9saXb7ENHRt
 LbJeCqqVo0CcWk/s7nlsWDYcBO9AbggT7fYDpzTgd7v6Ntp750zTTpgbSGvvGjEzEE4p xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y8udkcgw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 17:04:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JH1sZM060439;
        Wed, 19 Feb 2020 17:04:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y8ud3pk61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 17:04:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JH4Nh9010034;
        Wed, 19 Feb 2020 17:04:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 09:04:22 -0800
Date:   Wed, 19 Feb 2020 09:04:21 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] ext4: Add example fsinfo information [ver #16]
Message-ID: <20200219170421.GD9496@magnolia>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204563445.3299825.13575924510060131783.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158204563445.3299825.13575924510060131783.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:07:14PM +0000, David Howells wrote:
> Add the ability to list some ext4 volume timestamps as an example.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-ext4@vger.kernel.org
> ---
> 
>  fs/ext4/Makefile            |    1 +
>  fs/ext4/ext4.h              |    9 +++++++++
>  fs/ext4/fsinfo.c            |   40 ++++++++++++++++++++++++++++++++++++++++
>  fs/ext4/super.c             |    1 +
>  include/uapi/linux/fsinfo.h |   16 ++++++++++++++++
>  samples/vfs/test-fsinfo.c   |   35 +++++++++++++++++++++++++++++++++++
>  6 files changed, 102 insertions(+)
>  create mode 100644 fs/ext4/fsinfo.c
> 
> diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
> index 4ccb3c9189d8..71d5b460c7c7 100644
> --- a/fs/ext4/Makefile
> +++ b/fs/ext4/Makefile
> @@ -16,3 +16,4 @@ ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
>  ext4-inode-test-objs			+= inode-test.o
>  obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
>  ext4-$(CONFIG_FS_VERITY)		+= verity.o
> +ext4-$(CONFIG_FSINFO)			+= fsinfo.o
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9a2ee2428ecc..d81b04227da7 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -42,6 +42,7 @@
>  
>  #include <linux/fscrypt.h>
>  #include <linux/fsverity.h>
> +#include <linux/fsinfo.h>
>  
>  #include <linux/compiler.h>
>  
> @@ -3166,6 +3167,14 @@ extern const struct inode_operations ext4_file_inode_operations;
>  extern const struct file_operations ext4_file_operations;
>  extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
>  
> +/* fsinfo.c */
> +#ifdef CONFIG_FSINFO
> +struct fsinfo_attribute;
> +extern const struct fsinfo_attribute ext4_fsinfo_attributes[];
> +#else
> +#define ext4_fsinfo_attributes NULL
> +#endif
> +
>  /* inline.c */
>  extern int ext4_get_max_inline_size(struct inode *inode);
>  extern int ext4_find_inline_data_nolock(struct inode *inode);
> diff --git a/fs/ext4/fsinfo.c b/fs/ext4/fsinfo.c
> new file mode 100644
> index 000000000000..545424c410ff
> --- /dev/null
> +++ b/fs/ext4/fsinfo.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information for ext4
> + *
> + * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/mount.h>
> +#include "ext4.h"
> +
> +static int ext4_fsinfo_get_volume_name(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
> +	const struct ext4_super_block *es = sbi->s_es;
> +
> +	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));

Shouldn't this be checking that ctx->buffer is large enough to hold
s_volume_name?

> +	return strlen(ctx->buffer);

s_volume_name is /not/ a null-terminated string if the label is 16
characters long.

> +}
> +
> +static int ext4_fsinfo_get_timestamps(struct path *path, struct fsinfo_context *ctx)
> +{
> +	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
> +	const struct ext4_super_block *es = sbi->s_es;
> +	struct fsinfo_ext4_timestamps *ts = ctx->buffer;
> +
> +#define Z(R,S) R = S | (((u64)S##_hi) << 32)
> +	Z(ts->mkfs_time,	es->s_mkfs_time);
> +	Z(ts->mount_time,	es->s_mtime);
> +	Z(ts->write_time,	es->s_wtime);
> +	Z(ts->last_check_time,	es->s_lastcheck);
> +	Z(ts->first_error_time,	es->s_first_error_time);
> +	Z(ts->last_error_time,	es->s_last_error_time);
> +	return sizeof(*ts);
> +}
> +
> +const struct fsinfo_attribute ext4_fsinfo_attributes[] = {
> +	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	ext4_fsinfo_get_volume_name),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_get_timestamps),
> +	{}
> +};
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8434217549b3..e21c3d99747e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1477,6 +1477,7 @@ static const struct super_operations ext4_sops = {
>  	.freeze_fs	= ext4_freeze,
>  	.unfreeze_fs	= ext4_unfreeze,
>  	.statfs		= ext4_statfs,
> +	.fsinfo_attributes = ext4_fsinfo_attributes,
>  	.remount_fs	= ext4_remount,
>  	.show_options	= ext4_show_options,
>  #ifdef CONFIG_QUOTA
> diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
> index 5467f88ca9b0..da9a6f48ec5b 100644
> --- a/include/uapi/linux/fsinfo.h
> +++ b/include/uapi/linux/fsinfo.h
> @@ -38,6 +38,8 @@
>  #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
>  #define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
>  
> +#define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps */

I guess each filesystem gets ... 256 different attrs, and the third
nibble determines the namespace?

--D

>  /*
>   * Optional fsinfo() parameter structure.
>   *
> @@ -323,4 +325,18 @@ struct fsinfo_afs_server_address {
>  
>  #define FSINFO_ATTR_AFS_SERVER_ADDRESSES__STRUCT struct fsinfo_afs_server_address
>  
> +/*
> + * Information struct for fsinfo(FSINFO_ATTR_EXT4_TIMESTAMPS).
> + */
> +struct fsinfo_ext4_timestamps {
> +	__u64		mkfs_time;
> +	__u64		mount_time;
> +	__u64		write_time;
> +	__u64		last_check_time;
> +	__u64		first_error_time;
> +	__u64		last_error_time;
> +};
> +
> +#define FSINFO_ATTR_EXT4_TIMESTAMPS__STRUCT struct fsinfo_ext4_timestamps
> +
>  #endif /* _UAPI_LINUX_FSINFO_H */
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index fd425c08b00b..53251ee98d1c 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -359,6 +359,40 @@ static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
>  	printf("family=%u\n", ss->ss_family);
>  }
>  
> +static char *dump_ext4_time(char *buffer, time_t tim)
> +{
> +	struct tm tm;
> +	int len;
> +
> +	if (tim == 0)
> +		return "-";
> +
> +	if (!localtime_r(&tim, &tm)) {
> +		perror("localtime_r");
> +		exit(1);
> +	}
> +	len = strftime(buffer, 100, "%F %T", &tm);
> +	if (len == 0) {
> +		perror("strftime");
> +		exit(1);
> +	}
> +	return buffer;
> +}
> +
> +static void dump_ext4_fsinfo_timestamps(void *reply, unsigned int size)
> +{
> +	struct fsinfo_ext4_timestamps *r = reply;
> +	char buffer[100];
> +
> +	printf("\n");
> +	printf("\tmkfs    : %s\n", dump_ext4_time(buffer, r->mkfs_time));
> +	printf("\tmount   : %s\n", dump_ext4_time(buffer, r->mount_time));
> +	printf("\twrite   : %s\n", dump_ext4_time(buffer, r->write_time));
> +	printf("\tfsck    : %s\n", dump_ext4_time(buffer, r->last_check_time));
> +	printf("\t1st-err : %s\n", dump_ext4_time(buffer, r->first_error_time));
> +	printf("\tlast-err: %s\n", dump_ext4_time(buffer, r->last_error_time));
> +}
> +
>  static void dump_string(void *reply, unsigned int size)
>  {
>  	char *s = reply, *p;
> @@ -433,6 +467,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
>  	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	afs_cell_name),
>  	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_server_name),
>  	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
> +	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_timestamps),
>  	{}
>  };
>  
> 
> 
