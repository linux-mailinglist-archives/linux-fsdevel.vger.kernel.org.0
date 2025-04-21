Return-Path: <linux-fsdevel+bounces-46780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77F3A94BBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 05:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE90A3B1CC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25072257431;
	Mon, 21 Apr 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YVvdIjTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF321D9663;
	Mon, 21 Apr 2025 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745207084; cv=none; b=X0Fer/5pOV+DNzQA1mzTfGlD1RRBdIt27LxKtRFjrUL4n9RChNXiAqMadXBFmC4aOyLKfGXT/1sDHcJRRduByzaYKEbUGQSeqcRjDsuLweBbSvhPxlFysRn40hCe4/pNfY8qmSeEm4X5sHgq5+RiS84+92waY8co/mm3HeC5wfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745207084; c=relaxed/simple;
	bh=Vk9mGmL9IsAUqA/oXjfCayLUnInY+Q/PqQ7/iMS1l+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/gbDa48ih5FZr/eeYMlj6XOMU2JST2AxILgHph1E9cMu7mKPbmwG8EkZY2CB42qbxCFcnH2IetIazywmHHFjjlFtx1pSbXetc3HOGajs+5diEPeICPQ9FjmTvEGsELySbc0xXUwkZa828pi2rqui01WI4FV+fDIU4qDeNwTZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YVvdIjTo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Z4K+jIg+L3LCIQY6Eue5D5sCOZa5FZYsmgXBF5TTSsE=; b=YVvdIjToakECrvZdydbjwcWymR
	52wZBBMIBCJoOUY2C0ZF1vpsuvi6EntkdbSNpEiVuWDJbTR3TS4V7gsXZtrTUDF2nlSl2Q6adbLBq
	T1GLSn1Why0QDns8Y9z8kZfUEy2adQn4KSoC5PhA+qeCK9U2dQwipUDALjMVZT1pGXf2Y2fRmlbUw
	02tcOg9iYE4k97Auw1r5TcVGJrRu5DkTzy5knntXg1a7WlPj4999RG0DL473oJ77x0rom9c8GKs+g
	iP54peT9O46GYtpgsF/F7nMlmVqRsRjFVm1NErsoA32NhcWMehpv0Hw1fQv9+duPI03TuN/r8NIZa
	UR6t0d2A==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u6i4j-0000000AzsH-0ZeD;
	Mon, 21 Apr 2025 03:44:06 +0000
Message-ID: <bed14737-9432-4871-a86f-09c6ce59206b@infradead.org>
Date: Sun, 20 Apr 2025 20:43:56 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/19] famfs_fuse: GET_DAXDEV message and daxdev_table
To: John Groves <John@Groves.net>, Dan Williams <dan.j.williams@intel.com>,
 Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Luis Henriques <luis@igalia.com>,
 Jeff Layton <jlayton@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>,
 Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-15-john@groves.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250421013346.32530-15-john@groves.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/20/25 6:33 PM, John Groves wrote:
> * The new GET_DAXDEV message/response is enabled
> * The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_dable yet.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/famfs.c           | 281 ++++++++++++++++++++++++++++++++++++--
>  fs/fuse/famfs_kfmap.h     |  23 ++++
>  fs/fuse/fuse_i.h          |   4 +
>  fs/fuse/inode.c           |   2 +
>  fs/namei.c                |   1 +
>  include/uapi/linux/fuse.h |  15 ++
>  6 files changed, 316 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index e62c047d0950..2e182cb7d7c9 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -20,6 +20,250 @@
>  #include "famfs_kfmap.h"
>  #include "fuse_i.h"
>  
> +/*
> + * famfs_teardown()
> + *
> + * Deallocate famfs metadata for a fuse_conn
> + */
> +void
> +famfs_teardown(struct fuse_conn *fc)

Is this function formatting prevalent in fuse?
It's a bit different from most Linux.
(many locations throughout the patch set)

> +{
> +	struct famfs_dax_devlist *devlist = fc->dax_devlist;
> +	int i;
> +
> +	fc->dax_devlist = NULL;
> +
> +	if (!devlist)
> +		return;
> +
> +	if (!devlist->devlist)
> +		goto out;
> +
> +	/* Close & release all the daxdevs in our table */
> +	for (i = 0; i < devlist->nslots; i++) {
> +		if (devlist->devlist[i].valid && devlist->devlist[i].devp)
> +			fs_put_dax(devlist->devlist[i].devp, fc);
> +	}
> +	kfree(devlist->devlist);
> +
> +out:
> +	kfree(devlist);
> +}
> +
> +static int
> +famfs_verify_daxdev(const char *pathname, dev_t *devno)
> +{
> +	struct inode *inode;
> +	struct path path;
> +	int err;
> +
> +	if (!pathname || !*pathname)
> +		return -EINVAL;
> +
> +	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
> +	if (err)
> +		return err;
> +
> +	inode = d_backing_inode(path.dentry);
> +	if (!S_ISCHR(inode->i_mode)) {
> +		err = -EINVAL;
> +		goto out_path_put;
> +	}
> +
> +	if (!may_open_dev(&path)) { /* had to export this */
> +		err = -EACCES;
> +		goto out_path_put;
> +	}
> +
> +	*devno = inode->i_rdev;
> +
> +out_path_put:
> +	path_put(&path);
> +	return err;
> +}
> +
> +/**
> + * famfs_fuse_get_daxdev()

Missing " - <short function description>"
but then it's a static function, so kernel-doc is not required.
It's up to you, but please use full kernel-doc notation if using kernel-doc.

> + *
> + * Send a GET_DAXDEV message to the fuse server to retrieve info on a
> + * dax device.
> + *
> + * @fm    - fuse_mount
> + * @index - the index of the dax device; daxdevs are referred to by index
> + *          in fmaps, and the server resolves the index to a particular daxdev

Parameter names in kernel-doc notation should be followed by a ':', not '-'.

> + *
> + * Returns: 0=success
> + *          -errno=failure
> + */
> +static int
> +famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
> +{
> +	struct fuse_daxdev_out daxdev_out = { 0 };
> +	struct fuse_conn *fc = fm->fc;
> +	struct famfs_daxdev *daxdev;
> +	int err = 0;
> +
> +	FUSE_ARGS(args);
> +
> +	pr_notice("%s: index=%lld\n", __func__, index);
> +
> +	/* Store the daxdev in our table */
> +	if (index >= fc->dax_devlist->nslots) {
> +		pr_err("%s: index(%lld) > nslots(%d)\n",
> +		       __func__, index, fc->dax_devlist->nslots);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	args.opcode = FUSE_GET_DAXDEV;
> +	args.nodeid = index;
> +
> +	args.in_numargs = 0;
> +
> +	args.out_numargs = 1;
> +	args.out_args[0].size = sizeof(daxdev_out);
> +	args.out_args[0].value = &daxdev_out;
> +
> +	/* Send GET_DAXDEV command */
> +	err = fuse_simple_request(fm, &args);
> +	if (err) {
> +		pr_err("%s: err=%d from fuse_simple_request()\n",
> +		       __func__, err);
> +		/* Error will be that the payload is smaller than FMAP_BUFSIZE,
> +		 * which is the max we can handle. Empty payload handled below.
> +		 */

Usual multi-line comment format is
		/*
		 * line1
		 * line2
		 */
unless fuse is all different (like netdev is).

> +		goto out;
> +	}
> +
> +	down_write(&fc->famfs_devlist_sem);
> +
> +	daxdev = &fc->dax_devlist->devlist[index];
> +	pr_debug("%s: dax_devlist %llx daxdev[%lld]=%llx\n", __func__,
> +		 (u64)fc->dax_devlist, index, (u64)daxdev);
> +
> +	/* Abort if daxdev is now valid */
> +	if (daxdev->valid) {
> +		up_write(&fc->famfs_devlist_sem);
> +		/* We already have a valid entry at this index */
> +		err = -EALREADY;
> +		goto out;
> +	}
> +
> +	/* This verifies that the dev is valid and can be opened and gets the devno */
> +	pr_debug("%s: famfs_verify_daxdev(%s)\n", __func__, daxdev_out.name);
> +	err = famfs_verify_daxdev(daxdev_out.name, &daxdev->devno);
> +	if (err) {
> +		up_write(&fc->famfs_devlist_sem);
> +		pr_err("%s: err=%d from famfs_verify_daxdev()\n", __func__, err);
> +		goto out;
> +	}
> +
> +	/* This will fail if it's not a dax device */
> +	pr_debug("%s: dax_dev_get(%x)\n", __func__, daxdev->devno);
> +	daxdev->devp = dax_dev_get(daxdev->devno);
> +	if (!daxdev->devp) {
> +		up_write(&fc->famfs_devlist_sem);
> +		pr_warn("%s: device %s not found or not dax\n",
> +			__func__, daxdev_out.name);
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
> +	wmb(); /* all daxdev fields must be visible before marking it valid */
> +	daxdev->valid = 1;
> +
> +	up_write(&fc->famfs_devlist_sem);
> +
> +	pr_debug("%s: daxdev(%lld, %s)=%llx opened and marked valid\n",
> +		 __func__, index, daxdev->name, (u64)daxdev);
> +
> +out:
> +	return err;
> +}
> +
> +/**
> + * famfs_update_daxdev_table()

Missing short function description above or don't use kernel-doc notation.

> + *
> + * This function is called for each new file fmap, to verify whether all
> + * referenced daxdevs are already known (i.e. in the table). Any daxdev
> + * indices that are not in the table will be retrieved via
> + * famfs_fuse_get_daxdev()
> + * @fm   - fuse_mount
> + * @meta - famfs_file_meta, in-memory format, built from a GET_FMAP response
> + *
> + * Returns: 0=success
> + *          -errno=failure
> + */
> +static int
> +famfs_update_daxdev_table(
> +	struct fuse_mount *fm,
> +	const struct famfs_file_meta *meta)
> +{
> +	struct famfs_dax_devlist *local_devlist;
> +	struct fuse_conn *fc = fm->fc;
> +	int err;
> +	int i;
> +
> +	pr_debug("%s: dev_bitmap=0x%llx\n", __func__, meta->dev_bitmap);
> +
> +	/* First time through we will need to allocate the dax_devlist */
> +	if (!fc->dax_devlist) {
> +		local_devlist = kcalloc(1, sizeof(*fc->dax_devlist), GFP_KERNEL);
> +		if (!local_devlist)
> +			return -ENOMEM;
> +
> +		local_devlist->nslots = MAX_DAXDEVS;
> +		pr_debug("%s: allocate dax_devlist=%llx\n", __func__,
> +			 (u64)local_devlist);
> +
> +		local_devlist->devlist = kcalloc(MAX_DAXDEVS,
> +						 sizeof(struct famfs_daxdev),
> +						 GFP_KERNEL);
> +		if (!local_devlist->devlist) {
> +			kfree(local_devlist);
> +			return -ENOMEM;
> +		}
> +
> +		/* We don't need the famfs_devlist_sem here because we use cmpxchg... */
> +		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
> +			pr_debug("%s: aborting new devlist\n", __func__);
> +			kfree(local_devlist->devlist);
> +			kfree(local_devlist); /* another thread beat us to it */
> +		} else {
> +			pr_debug("%s: published new dax_devlist %llx / %llx\n",
> +				 __func__, (u64)local_devlist,
> +				 (u64)local_devlist->devlist);
> +		}
> +	}
> +
> +	down_read(&fc->famfs_devlist_sem);
> +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> +		if (meta->dev_bitmap & (1ULL << i)) {
> +			/* This file meta struct references devindex i
> +			 * if devindex i isn't in the table; get it...
> +			 */
> +			if (!(fc->dax_devlist->devlist[i].valid)) {
> +				up_read(&fc->famfs_devlist_sem);
> +
> +				pr_notice("%s: daxdev=%d (%llx) invalid...getting\n",
> +					  __func__, i,
> +					  (u64)(&fc->dax_devlist->devlist[i]));
> +				err = famfs_fuse_get_daxdev(fm, i);
> +				if (err)
> +					pr_err("%s: failed to get daxdev=%d\n",
> +					       __func__, i);
> +
> +				down_read(&fc->famfs_devlist_sem);
> +			}
> +		}
> +	}
> +	up_read(&fc->famfs_devlist_sem);
> +
> +	return 0;
> +}
> +
> +/***************************************************************************/
>  
>  void
>  __famfs_meta_free(void *famfs_meta)
> @@ -67,12 +311,15 @@ famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)
>  }
>  
>  /**
> - * famfs_meta_alloc() - Allocate famfs file metadata
> + * famfs_fuse_meta_alloc() - Allocate famfs file metadata
>   * @metap:       Pointer to an mcache_map_meta pointer
>   * @ext_count:  The number of extents needed
> + *
> + * Returns: 0=success
> + *          -errno=failure
>   */
>  static int
> -famfs_meta_alloc_v3(
> +famfs_fuse_meta_alloc(
>  	void *fmap_buf,
>  	size_t fmap_buf_size,
>  	struct famfs_file_meta **metap)
> @@ -92,28 +339,25 @@ famfs_meta_alloc_v3(
>  	if (next_offset > fmap_buf_size) {
>  		pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
>  		       __func__, __LINE__, next_offset, fmap_buf_size);
> -		rc = -EINVAL;
> -		goto errout;
> +		return -EINVAL;
>  	}
>  
>  	if (fmh->nextents < 1) {
>  		pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
> -		rc = -EINVAL;
> -		goto errout;
> +		return -EINVAL;
>  	}
>  
>  	if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
>  		pr_err("%s: nextents %d > max (%d) 1\n",
>  		       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
> -		rc = -E2BIG;
> -		goto errout;
> +		return -E2BIG;
>  	}
>  
>  	meta = kzalloc(sizeof(*meta), GFP_KERNEL);
>  	if (!meta)
>  		return -ENOMEM;
> -	meta->error = false;
>  
> +	meta->error = false;
>  	meta->file_type = fmh->file_type;
>  	meta->file_size = fmh->file_size;
>  	meta->fm_extent_type = fmh->ext_type;
> @@ -298,6 +542,20 @@ famfs_meta_alloc_v3(
>  	return rc;
>  }
>  
> +/**
> + * famfs_file_init_dax()

Missing kernel-doc notation above.

> + *
> + * Initialize famfs metadata for a file, based on the contents of the GET_FMAP
> + * response
> + *
> + * @fm        - fuse_mount
> + * @inode     - the inode
> + * @fmap_buf  - fmap response message
> + * @fmap_size - Size of the fmap message

Use
 * @parameter: description
instead of '-'.

> + *
> + * Returns: 0=success
> + *          -errno=failure
> + */
>  int
>  famfs_file_init_dax(
>  	struct fuse_mount *fm,
> @@ -316,10 +574,13 @@ famfs_file_init_dax(
>  		return -EEXIST;
>  	}
>  
> -	rc = famfs_meta_alloc_v3(fmap_buf, fmap_size, &meta);
> +	rc = famfs_fuse_meta_alloc(fmap_buf, fmap_size, &meta);
>  	if (rc)
>  		goto errout;
>  
> +	/* Make sure this fmap doesn't reference any unknown daxdevs */
> +	famfs_update_daxdev_table(fm, meta);
> +
>  	/* Publish the famfs metadata on fi->famfs_meta */
>  	inode_lock(inode);
>  	if (fi->famfs_meta) {
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> index ce785d76719c..325adb8b99c5 100644
> --- a/fs/fuse/famfs_kfmap.h
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -60,4 +60,27 @@ struct famfs_file_meta {
>  	};
>  };
>  
> +/*
> + * dax_devlist

Missing struct short description above?
It apparently should be

/*
 * struct famfs_daxdev - <short description>
instead of dax_devlist.

> + *
> + * This is the in-memory daxdev metadata that is populated by
> + * the responses to GET_FMAP messages
> + */
> +struct famfs_daxdev {
> +	/* Include dev uuid? */
> +	bool valid;
> +	bool error;
> +	dev_t devno;
> +	struct dax_device *devp;
> +	char *name;
> +};
> +
> +#define MAX_DAXDEVS 24
> +
> +struct famfs_dax_devlist {
> +	int nslots;
> +	int ndevs;
> +	struct famfs_daxdev *devlist; /* XXX: make this an xarray! */
> +};
> +
>  #endif /* FAMFS_KFMAP_H */



-- 
~Randy


