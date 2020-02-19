Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA92164B15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSQxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:53:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSQxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:53:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGm2SI120335;
        Wed, 19 Feb 2020 16:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=i5uLS39JyANlwDurEgFWEIXEf4v2bZHjgkeJi7OBk8w=;
 b=c11GXc6dFK9wuGBOzrxfkhyWfF/10Z5pKESRd0Cr6qi4ve4W/bX3uRklwCCd+3dL8z7W
 gw1nVr7wu5p7ZYTSgm5zzSAfODacWnXsv97VJg5fe0QBFUBAm1B4SiF/2oMN7PxyQ55D
 j2PTLMgp157PFTt2RNO06ZIrtrtLHFEkF/4DjTFlZzKQhP5kjCWWUuOA3jVnkCNjkV7m
 OYipxUz+fyTrSMchdsr4uhVdxp9uoMlmYHzAxWmQ0Hl/bRtpnwtMDhRVbq9EeSDwxKyY
 IrDpje7cvp4Oo2oUli8tfSEXFOcVESpy86Skcdt29cvmxh3RQ47659dfcE7XMoKked4T 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y8ud14e71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:53:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JGqH7e045746;
        Wed, 19 Feb 2020 16:53:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y8udaun07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 16:53:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JGrDMC013093;
        Wed, 19 Feb 2020 16:53:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 08:53:13 -0800
Date:   Wed, 19 Feb 2020 08:53:12 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] vfs: Introduce a non-repeating system-unique
 superblock ID [ver #16]
Message-ID: <20200219165312.GD9504@magnolia>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204553565.3299825.3864357054582488949.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158204553565.3299825.3864357054582488949.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190127
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:05:35PM +0000, David Howells wrote:
> Introduce an (effectively) non-repeating system-unique superblock ID that
> can be used to determine that two object are in the same superblock without
> risking reuse of the ID in the meantime (as is possible with device IDs).
> 
> The ID is time-based to make it harder to use it as a covert communications
> channel.
> 
> Also make it so that this ID can be fetched by the fsinfo() system call.
> The ID added so that superblock notification messages will also be able to
> be tagged with it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/fsinfo.c               |    1 +
>  fs/super.c                |   24 ++++++++++++++++++++++++
>  include/linux/fs.h        |    3 +++
>  samples/vfs/test-fsinfo.c |    1 +
>  4 files changed, 29 insertions(+)
> 
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> index 55710d6da327..f8e85762fc47 100644
> --- a/fs/fsinfo.c
> +++ b/fs/fsinfo.c
> @@ -92,6 +92,7 @@ static int fsinfo_generic_ids(struct path *path, struct fsinfo_context *ctx)
>  	p->f_fstype	= sb->s_magic;
>  	p->f_dev_major	= MAJOR(sb->s_dev);
>  	p->f_dev_minor	= MINOR(sb->s_dev);
> +	p->f_sb_id	= sb->s_unique_id;

Ahah, this is what the f_sb_id field is for.  I noticed a few patches
ago that it was in a header file but was never set.

I'm losing track of which IDs do what...

* f_fsid is that old int[2] thing that we used for statfs.  It sucks but
  we can't remove it because it's been in statfs since the beginning of
  time.

* f_fs_name is a string coming from s_type, which is the name of the fs
  (e.g. "XFS")?

* f_fstype comes from s_magic, which (for XFS) is 0x58465342.

* f_sb_id is basically an incore u64 cookie that one can use with the
  mount events thing that comes later in this patchset?

* FSINFO_ATTR_VOLUME_ID comes from s_id, which tends to be the block
  device name (at least for local filesystems)

* FSINFO_ATTR_VOLUME_UUID comes from s_uuid, which some filesystems fill
  in at mount time.

* FSINFO_ATTR_VOLUME_NAME is ... left to individual filesystems to
  implement, and (AFAICT) can be the label that one uses for things
  like: "mount LABEL=foo /home" ?

Assuming I got all of that right, can we please capture what all of
these "IDs" mean in the documentation?

(Assuming I got all that right, the code looks ok.)

--D

>  
>  	memcpy(&p->f_fsid, &buf.f_fsid, sizeof(p->f_fsid));
>  	strlcpy(p->f_fs_name, path->dentry->d_sb->s_type->name,
> diff --git a/fs/super.c b/fs/super.c
> index cd352530eca9..a63073e6127e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -44,6 +44,8 @@ static int thaw_super_locked(struct super_block *sb);
>  
>  static LIST_HEAD(super_blocks);
>  static DEFINE_SPINLOCK(sb_lock);
> +static u64 sb_last_identifier;
> +static u64 sb_identifier_offset;
>  
>  static char *sb_writers_name[SB_FREEZE_LEVELS] = {
>  	"sb_writers",
> @@ -188,6 +190,27 @@ static void destroy_unused_super(struct super_block *s)
>  	destroy_super_work(&s->destroy_work);
>  }
>  
> +/*
> + * Generate a unique identifier for a superblock.
> + */
> +static void generate_super_id(struct super_block *s)
> +{
> +	u64 id = ktime_to_ns(ktime_get());
> +
> +	spin_lock(&sb_lock);
> +
> +	id += sb_identifier_offset;
> +	if (id <= sb_last_identifier) {
> +		id = sb_last_identifier + 1;
> +		sb_identifier_offset = sb_last_identifier - id;
> +	}
> +
> +	sb_last_identifier = id;
> +	spin_unlock(&sb_lock);
> +
> +	s->s_unique_id = id;
> +}
> +
>  /**
>   *	alloc_super	-	create new superblock
>   *	@type:	filesystem type superblock should belong to
> @@ -273,6 +296,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  		goto fail;
>  	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
>  		goto fail;
> +	generate_super_id(s);
>  	return s;
>  
>  fail:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f74a4ee36eb3..e5db22d536a3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1550,6 +1550,9 @@ struct super_block {
>  
>  	spinlock_t		s_inode_wblist_lock;
>  	struct list_head	s_inodes_wb;	/* writeback inodes */
> +
> +	/* Superblock event notifications */
> +	u64			s_unique_id;
>  } __randomize_layout;
>  
>  /* Helper functions so that in most cases filesystems will
> diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
> index 6fbf0ce099b2..d6ec5713364f 100644
> --- a/samples/vfs/test-fsinfo.c
> +++ b/samples/vfs/test-fsinfo.c
> @@ -140,6 +140,7 @@ static void dump_fsinfo_generic_ids(void *reply, unsigned int size)
>  	printf("\tdev          : %02x:%02x\n", f->f_dev_major, f->f_dev_minor);
>  	printf("\tfs           : type=%x name=%s\n", f->f_fstype, f->f_fs_name);
>  	printf("\tfsid         : %llx\n", (unsigned long long)f->f_fsid);
> +	printf("\tsbid         : %llx\n", (unsigned long long)f->f_sb_id);
>  }
>  
>  static void dump_fsinfo_generic_limits(void *reply, unsigned int size)
> 
> 
