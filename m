Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F5350F46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhDAGpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhDAGpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:45:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E50C0613E6;
        Wed, 31 Mar 2021 23:45:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c204so730964pfc.4;
        Wed, 31 Mar 2021 23:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqVKb6CBj74jNn4PteYvhc8gg791d45MOhfp+Rlng1g=;
        b=qv/Z0X+nfvaFgxMy2FBBb8T3pLXpS4ySkNJjwcEc9yPH6thFDRr7wiFRYyqbgffczK
         HVN/IWOi0lg4iAkrc7uLZXSpzD8GBuMCReSnFcP+bNuTMYWvSlW7bG3w2GUEbAqZCCya
         88rgJama7f4bgWy2v61GjP12ZZFjmX0Uoga6067CEwCJjLGtz5cYsTv/CamTTDPknVno
         vZajEJ3JVnr1ETbtooBYpUmR4GKw3NuqyElz3qcFhcGgeHT7cRaxSNd5aLtxmFgwx+Xz
         00s/M8FlibpPfa2yLxP91oDtL9sV0amp0nlS1Yu6R0NdFcBpsyMWk3J4PTzzS30LNMmp
         T3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqVKb6CBj74jNn4PteYvhc8gg791d45MOhfp+Rlng1g=;
        b=kN1FbHG6LbBD2fIOPk3PEG9Esgee31EtquzP60XINyzo6/plCN3WCFIrEPG/rFrtBz
         wQpgfa7Gk1jfHD5G/xGTvabffV6rIAFw6e0djng6p776euW5UT2QqNz4dZrEHe8RPgZ1
         KipOiRAlAILm5EBz696B/xAoRpAHV6ElwKQZu5hTSlhvI8UDaBOqKfmgJE4nRjWON2LZ
         vXjw7EWUAd7C/GVvfoZQvrW6/zcff9Vgz2nBxzEcAM3ipFAOYjyJpO6kAnEMjZgD+78b
         Jg/DnX0y4K6e/zXU3cD3OWUH6ttBtmzgK0bfnnkjpLsg0/GdfoIuBlqlqT+bGf++Ib+W
         Mtpw==
X-Gm-Message-State: AOAM532nre9ObhAOB1Ue+J2wJvBqGeQhJbIqPiYm0mDLMcqhvLp2mpG1
        8toIGtzj89ayUxVr7ioW4jI=
X-Google-Smtp-Source: ABdhPJxtKqGP3au9ZiwwVN50hiRw8YRBjgdFTyLntXV/t7UtoBMLPEn/8gzMRbVDkZtH1agb/7VUfw==
X-Received: by 2002:a62:e404:0:b029:1f1:5cea:afbd with SMTP id r4-20020a62e4040000b02901f15ceaafbdmr6303168pfh.5.1617259509397;
        Wed, 31 Mar 2021 23:45:09 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id ms21sm4387389pjb.5.2021.03.31.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:45:09 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:15:06 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v3 06/10] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Message-ID: <20210401064506.47pz6u2gegp6s2ky@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> data in not aligned area will be not correct.  So, add the srcmap to
> dax_iomap_zero() and replace memset() as dax_copy_edge().
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c               | 9 +++++++--
>  fs/iomap/buffered-io.c | 2 +-
>  include/linux/dax.h    | 3 ++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index cfe513eb111e..348297b38f76 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1174,7 +1174,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap)

Do we know why does dax_iomap_zero() operates on PAGE_SIZE range?
IIUC, dax_zero_page_range() can take nr_pages as a parameter. But we still
always use one page at a time. Why is that?

>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
> @@ -1204,7 +1205,11 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  	}
>
>  	if (!page_aligned) {
> -		memset(kaddr + offset, 0, size);
> +		if (iomap->addr != srcmap->addr)
> +			dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
> +					   kaddr, true);
> +		else
> +			memset(kaddr + offset, 0, size);
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	}
>  	dax_read_unlock(id);
>

Maybe the above could be simplified to this?

	if (page_aligned) {
		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
	} else {
		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
		if (iomap->addr != srcmap->addr)
			dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
					   kaddr, true);
		else
			memset(kaddr + offset, 0, size);
		dax_flush(iomap->dax_dev, kaddr + offset, size);
	}

	dax_read_unlock(id);
	return rc < 0 ? rc : size;

Other than that looks good.
Feel free to add.
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>


