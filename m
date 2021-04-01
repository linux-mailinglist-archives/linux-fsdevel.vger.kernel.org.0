Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE6350F2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhDAGjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhDAGjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:39:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BFEC0613E6;
        Wed, 31 Mar 2021 23:39:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so2539876pjq.5;
        Wed, 31 Mar 2021 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cdhn3hlT1LofiWiq9NSsZXRFtnuTmpkFOIZBKIG5BiA=;
        b=UTL5B1kymvtzLNP/91qrZli7L9K/RRc+t3YUJywMQyXnYDuvkYCGKiqHl2oJcMHHoy
         UGaOiavWcQuvbtsY1AjPK18htFJRFjqk3J5JdwTUPpjlDB0xyn5dXDyWUmP05ep0zZd3
         /PasjavPWANRdOiP9OF2XgmhE9kIQIp8A01zzEzf9Th+GbR4RZ3V8I8HEFY87DA13dkG
         txGDPNpeNWXZC+RFFqxjEarVoUhbMJnYh/2oHqJq6Qh6NIAaDiKc9Or3dcxwhb/yJSfj
         VqvUFcWPRWPOFWq4prpgIgVuKKW4b/yRynE+dhn2QPX62tiJcvfvYUdyKCX/c2u8m8US
         VzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cdhn3hlT1LofiWiq9NSsZXRFtnuTmpkFOIZBKIG5BiA=;
        b=NCUJqBFOLVLXGD0CS/MEPMCNlHc+jL7GWR2/74fQYIaiTMVx/vz1xJzpHBbVHFR6f1
         /FCsxTqB41Y/1fIrLVPno+W73BLI8NZjyFqtPdWRCIDOAULaQ9cfbQM8iLddz0bVLTud
         vSz5a035FeULYXbGFCk8XsmhjsTD8DD1cOTJ4KFmidJse0A40RwutMhL53uVdi6p2Oq1
         6kKhednRO9BFV+35zuTAzgPsAW4cIMpK7x0amtQXD95FttQSzHlx3iicjfe8/zMEddjO
         +P+5clRlXNAK1tJpp9kl+MQqtBThuMYmwd/Vm+oRsZ/weI8U/ETJLp0clcT9//1DEZsn
         4Lcw==
X-Gm-Message-State: AOAM533F1GzGaQBAdm2ue4cCwYi+dhdBkxh5nhJIER87VEZC/wIY+KY/
        +FlJXt+I7IuFo8gcJzfXDnQ=
X-Google-Smtp-Source: ABdhPJxV7qnJmiKTK7vMsVhFFpLWa9nVg5l0P/yHHXGvs45jJWGW4/3YJNYe6mcpuHqq0YLrqeBnjw==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr7368818pjp.178.1617259175255;
        Wed, 31 Mar 2021 23:39:35 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id w26sm4326195pfj.58.2021.03.31.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:39:34 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:09:32 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210401063932.tro7a4hhy25zdmho@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> We replace the existing entry to the newly allocated one in case of CoW.
> Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
> entry as writeprotected.  This helps us snapshots so new write
> pagefaults after snapshots trigger a CoW.
>

Please correct me here. So the flow is like this.
1. In case of CoW or a reflinked file, on an mmaped file if write is attempted,
   Then in DAX fault handler code, ->iomap_begin() on a given filesystem will
   populate iomap and srcmap. srcmap being from where the read needs to be
   attempted from and iomap on where the new write should go to.
2. So the dax_insert_entry() code as part of the fault handling will take care
   of removing the old entry and inserting the new pfn entry to xas and mark
   it with PAGECACHE_TAG_TOWRITE so that dax writeback can mark the entry as
   write protected.
Is my above understanding correct?

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 181aad97136a..cfe513eb111e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  	return 0;
>  }
>
> +#define DAX_IF_DIRTY		(1 << 0)
> +#define DAX_IF_COW		(1 << 1)
> +
>
small comment expalining this means DAX insert flags used in dax_insert_entry()

>
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -729,16 +732,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>   * already in the tree, we will skip the insertion and just dirty the PMD as
>   * appropriate.
>   */
> -static void *dax_insert_entry(struct xa_state *xas,
> -		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +		void *entry, pfn_t pfn, unsigned long flags,
> +		unsigned int insert_flags)
>  {
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = insert_flags & DAX_IF_DIRTY;
> +	bool cow = insert_flags & DAX_IF_COW;
>
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>
> -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -750,7 +756,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		void *old;
>
>  		dax_disassociate_entry(entry, mapping, false);
> @@ -774,6 +780,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>
> +	if (cow)
> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
>  	xas_unlock_irq(xas);
>  	return entry;
>  }
> @@ -1098,8 +1107,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
>  	vm_fault_t ret;
>
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_ZERO_PAGE, false);
> +	*entry = dax_insert_entry(xas, vmf, *entry, pfn, DAX_ZERO_PAGE, 0);
>
>  	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>  	trace_dax_load_hole(inode, vmf, ret);
> @@ -1126,8 +1134,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  		goto fallback;
>
>  	pfn = page_to_pfn_t(zero_page);
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_PMD | DAX_ZERO_PAGE, false);
> +	*entry = dax_insert_entry(xas, vmf, *entry, pfn,
> +				  DAX_PMD | DAX_ZERO_PAGE, 0);
>
>  	if (arch_needs_pgtable_deposit()) {
>  		pgtable = pte_alloc_one(vma->vm_mm);
> @@ -1431,6 +1439,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	loff_t pos = (loff_t)xas->xa_offset << PAGE_SHIFT;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
> +	unsigned int insert_flags = 0;
>  	int err = 0;
>  	pfn_t pfn;
>  	void *kaddr;
> @@ -1453,8 +1462,14 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  	if (err)
>  		return dax_fault_return(err);
>
> -	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
> -				 write && !sync);
> +	if (write) {
> +		if (!sync)
> +			insert_flags |= DAX_IF_DIRTY;
> +		if (iomap->flags & IOMAP_F_SHARED)
> +			insert_flags |= DAX_IF_COW;
> +	}
> +
> +	entry = dax_insert_entry(xas, vmf, entry, pfn, 0, insert_flags);
>
>  	if (write && srcmap->addr != iomap->addr) {
>  		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr, false);
>

Rest looks good to me. Please feel free to add
Reviewed-by: Ritesh Harjani <riteshh@gmail.com>

sorry about changing my email in between of this code review.
I am planning to use above gmail id as primary account for all upstream work
from now.

> --
> 2.30.1
>
>
>
