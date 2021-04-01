Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464FF35144E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhDALLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhDALLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:11:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D5C0613E6;
        Thu,  1 Apr 2021 04:11:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h8so842644plt.7;
        Thu, 01 Apr 2021 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3T62p65u2S83DXPwAJqrEpWMg9bqfngCOlwnISjfa0=;
        b=eqtNX+K/AXfThYAWzIPSF04zWuglu7DegIYqhI4iy34Pgv9XdqKgK3Ip6LFcfzQPuI
         94U33DHmHTnhkRSXD+k8BHy1RmpBIXCGvZPvnYI3Wv9wgIIv/Abo6TOmEbKpcdr2rCtM
         ipMaDHz7nt/xPuHi30tEAgbmOVpKA+F8IV8j9EL/TOBXKT4pwgEThKLzoIEIm2NFAbmA
         FBfRfgZLE3X6O9hKvkARuSg3inrBlAYTrp/U/qIOTh2crZMRKyDW2/adyv4JEuhx4nAe
         y7xHqJ+vbdyGP8n1vYnbswnY0bfP/FJdEdJHUvRlr8p8/ylVZsGdTG+Cc+Eoeg2DP6Uu
         NMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3T62p65u2S83DXPwAJqrEpWMg9bqfngCOlwnISjfa0=;
        b=DkB/wDjRlXuD93iZymQDfQ7uNa/qkRwlX9W38qHIVXk80Zmb08WgHTzIzvBFFuJiUg
         jzipePlZpYDqNndexAC4e97SaD4YAY56Hl4ET5/NXI954fOxBDJThaHCtBKf8SJmzLTw
         ++Mzj7iqRQ17pqt1yVS6mCjel0DRVm7bZaq3rA2NMRnDVFsIBKE4Pst+1I90m2Ay9tga
         WBQHzNgFwFVEDLiq58wppyXRVOwuf9A07hFkcSwiO2t4pg1jkIqKNxJJ3qGQw/gwY2lI
         /sXIRzr89nLCWyWYlvGK9vo18hlj18+B9HjES2L29i+C65+7D+m9Hpn8tI14OitRMntR
         edjw==
X-Gm-Message-State: AOAM533isdPHGFNyWWwhRFiRoGTVV9Zvxxb0r8qsA3jlPnR1/+xTroE1
        NvkSa1+nZpxqBb9QDVpN3Yw=
X-Google-Smtp-Source: ABdhPJwd87RNzh+BfrCBf8eX/5dIR9xk4EAMKPeLjoBbOazcoZ79gljc2I3DoR3sYnn2r/fomTvxIg==
X-Received: by 2002:a17:90b:38f:: with SMTP id ga15mr8213179pjb.149.1617275482546;
        Thu, 01 Apr 2021 04:11:22 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id y15sm6499629pgi.31.2021.04.01.04.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 04:11:22 -0700 (PDT)
Date:   Thu, 1 Apr 2021 16:41:20 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 08/10] fsdax: Dedup file range to use a compare
 function
Message-ID: <20210401111120.2ukog26aoyvyysyz@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-9-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> With dax we cannot deal with readpage() etc. So, we create a dax
> comparison funciton which is similar with
> vfs_dedupe_file_range_compare().
> And introduce dax_remap_file_range_prep() for filesystem use.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c             | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/remap_range.c     | 45 ++++++++++++++++++++++++++++-------
>  fs/xfs/xfs_reflink.c |  9 +++++--
>  include/linux/dax.h  |  4 ++++
>  include/linux/fs.h   | 15 ++++++++----
>  5 files changed, 115 insertions(+), 14 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 348297b38f76..76f81f1d76ec 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1833,3 +1833,59 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  	return dax_insert_pfn_mkwrite(vmf, pfn, order);
>  }
>  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> +
> +static loff_t dax_range_compare_actor(struct inode *ino1, loff_t pos1,
> +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> +		struct iomap *smap, struct iomap *dmap)
> +{
> +	void *saddr, *daddr;
> +	bool *same = data;
> +	int ret;
> +
> +	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
> +		*same = true;
> +		return len;
> +	}
> +
> +	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
> +		*same = false;
> +		return 0;
> +	}
> +
> +	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
> +				      &saddr, NULL);

shouldn't it take len as the second argument?

> +	if (ret < 0)
> +		return -EIO;
> +
> +	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
> +				      &daddr, NULL);

ditto.
> +	if (ret < 0)
> +		return -EIO;
> +
> +	*same = !memcmp(saddr, daddr, len);
> +	return len;
> +}
> +
> +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +		struct inode *dest, loff_t destoff, loff_t len, bool *is_same,
> +		const struct iomap_ops *ops)
> +{
> +	int id, ret = 0;
> +
> +	id = dax_read_lock();
> +	while (len) {
> +		ret = iomap_apply2(src, srcoff, dest, destoff, len, 0, ops,
> +				   is_same, dax_range_compare_actor);
> +		if (ret < 0 || !*is_same)
> +			goto out;
> +
> +		len -= ret;
> +		srcoff += ret;
> +		destoff += ret;
> +	}
> +	ret = 0;
> +out:
> +	dax_read_unlock(id);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_dedupe_file_range_compare);
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 77dba3a49e65..9079390edaf3 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -14,6 +14,7 @@
>  #include <linux/compat.h>
>  #include <linux/mount.h>
>  #include <linux/fs.h>
> +#include <linux/dax.h>
>  #include "internal.h"
>
>  #include <linux/uaccess.h>
> @@ -199,9 +200,9 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
>   */
> -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> -					 struct inode *dest, loff_t destoff,
> -					 loff_t len, bool *is_same)
> +int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +				  struct inode *dest, loff_t destoff,
> +				  loff_t len, bool *is_same)
>  {
>  	loff_t src_poff;
>  	loff_t dest_poff;
> @@ -280,6 +281,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  out_error:
>  	return error;
>  }
> +EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
>
>  /*
>   * Check that the two inodes are eligible for cloning, the ranges make
> @@ -289,9 +291,11 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>   * If there's an error, then the usual negative error code is returned.
>   * Otherwise returns 0 with *len set to the request length.
>   */
> -int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -				  struct file *file_out, loff_t pos_out,
> -				  loff_t *len, unsigned int remap_flags)
> +static int
> +__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				loff_t *len, unsigned int remap_flags,
> +				const struct iomap_ops *ops)
>  {
>  	struct inode *inode_in = file_inode(file_in);
>  	struct inode *inode_out = file_inode(file_out);
> @@ -351,8 +355,15 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	if (remap_flags & REMAP_FILE_DEDUP) {
>  		bool		is_same = false;
>
> -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> -				inode_out, pos_out, *len, &is_same);
> +		if (!IS_DAX(inode_in) && !IS_DAX(inode_out))
> +			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> +					inode_out, pos_out, *len, &is_same);
> +		else if (IS_DAX(inode_in) && IS_DAX(inode_out) && ops)
> +			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
> +					inode_out, pos_out, *len, &is_same,
> +					ops);
> +		else
> +			return -EINVAL;
>  		if (ret)
>  			return ret;
>  		if (!is_same)

should we consider to check !is_same check b4?
you should maybe relook at this error handling side of code.
we still return len from actor function but is_same is set to false.
So we are essentially returning ret (positive value), instead should be
returning -EBADE because of !memcmp

> @@ -370,6 +381,24 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>
>  	return ret;
>  }
> +
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops)
> +{
> +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> +					       pos_out, len, remap_flags, ops);
> +}
> +EXPORT_SYMBOL(dax_remap_file_range_prep);
> +
> +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  loff_t *len, unsigned int remap_flags)
> +{
> +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> +					       pos_out, len, remap_flags, NULL);
> +}
>  EXPORT_SYMBOL(generic_remap_file_range_prep);
>
>  loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 6fa05fb78189..f5b3a3da36b7 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1308,8 +1308,13 @@ xfs_reflink_remap_prep(
>  	if (IS_DAX(inode_in) || IS_DAX(inode_out))
>  		goto out_unlock;
>
> -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> -			len, remap_flags);
> +	if (IS_DAX(inode_in))

if (!IS_DAX(inode_in)) no?

> +		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> +						    pos_out, len, remap_flags);
> +	else
> +		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> +						pos_out, len, remap_flags,
> +						&xfs_read_iomap_ops);
>  	if (ret || *len == 0)
>  		goto out_unlock;
>
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 3275e01ed33d..32e1c34349f2 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -239,6 +239,10 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
>  		struct iomap *srcmap);
> +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +				  struct inode *dest, loff_t destoff,
> +				  loff_t len, bool *is_same,
> +				  const struct iomap_ops *ops);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd47deea7c17..2e6ec5bdf82a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -68,6 +68,7 @@ struct fsverity_info;
>  struct fsverity_operations;
>  struct fs_context;
>  struct fs_parameter_spec;
> +struct iomap_ops;
>
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -1910,13 +1911,19 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
>  extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
>  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
>  				   loff_t, size_t, unsigned int);
> +typedef int (*compare_range_t)(struct inode *src, loff_t srcpos,
> +			       struct inode *dest, loff_t destpos,
> +			       loff_t len, bool *is_same);

Is this used anywhere?

>  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				       struct file *file_out, loff_t pos_out,
>  				       size_t len, unsigned int flags);
> -extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -					 struct file *file_out, loff_t pos_out,
> -					 loff_t *count,
> -					 unsigned int remap_flags);
> +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +				  struct file *file_out, loff_t pos_out,
> +				  loff_t *count, unsigned int remap_flags);
> +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out,
> +			      loff_t *len, unsigned int remap_flags,
> +			      const struct iomap_ops *ops);
>  extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
>  				  loff_t len, unsigned int remap_flags);
> --
> 2.30.1
>
>
>
