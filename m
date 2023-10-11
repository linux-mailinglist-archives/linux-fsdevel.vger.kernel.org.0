Return-Path: <linux-fsdevel+bounces-39-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12857C4B09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5204A281D21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FD9171B1;
	Wed, 11 Oct 2023 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIxB5r+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230D12B91
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:58:26 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7DB7;
	Tue, 10 Oct 2023 23:58:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-327be5fe4beso5874113f8f.3;
        Tue, 10 Oct 2023 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697007502; x=1697612302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94Aupc/WoctqDp8xqPo3RjM/d0ECIJ8ZPHye9gY433w=;
        b=KIxB5r+jsya9wKwRiOtdw3I/3ZxD82m8uL4DwQRBz/PS8KGJ4FyFsufmprI6OBVu9K
         pR4Iay02IcbgkeHLid+mfNrQN84FFpOgclACZwjIwJMkSuxnV9UfV5q5hXYnhhp5uye1
         Hg26/vz5dROysidFxa1WVBO7kZHgoM/TdDtCW8Zgkg90YQ2rcmqYC/XwKPSuMH3q7VDf
         rVB2MuSxhufs2u2iLpFASzPsG6x8SZfm07Abv9qTQ7TVQAcHWF/HVYbazydoRY8izVvC
         rDk67qq5LM/9AAHrvar2tNg9eeWiC9x3MUeqw+ziY66Xq5iyGjIILJg48ZCvtGcbqiA9
         FfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697007502; x=1697612302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94Aupc/WoctqDp8xqPo3RjM/d0ECIJ8ZPHye9gY433w=;
        b=l0VQtUiyaHVKsoKC7Ng9LS/ABqcWfu+7DGIbyIpIcz0roNOVNkbwObt4mt37RszTEd
         Pk18jlJdYndTYxzj+wEPysgczdW5LTbf0OnSwydqy3iSMzcEBKsxwMDIz7Tdr0qCxaQS
         t9qw1wP6vQrKZL5ErpXBHro+1oqGD7cVlwdvonrEk7Ps4ztAfeT7LGgqNNOkH9WXNsyP
         RkRzfYZsteFMeK+lmZEheQhO+L5OzwaJrPHLQpg1GE3Qio1Bk6ZzbctBh1DZMGb2RXs/
         VtCZ2Sx7yZ/YSG8IdrYtGD5wVERS7sRGQ82cb7yQtRPCYA6qaYSucJwgfyQgVHo5XWS6
         GP6Q==
X-Gm-Message-State: AOJu0Yx19uMRGv5IbmRvjXexba0g0Ha6VoorgolkUPr5yvfglAtf5gPs
	MkR3kW11J53IgumzZOgb7jgJkvDTGLI=
X-Google-Smtp-Source: AGHT+IHLJYkdW/fjT6jzHgUoZyb7XD0MWnrvSt2FIGvXP4SKbU60fDv2wfSA0vlHElTRAdHzqaci8Q==
X-Received: by 2002:a5d:5304:0:b0:319:6d03:13ae with SMTP id e4-20020a5d5304000000b003196d0313aemr16290191wrv.55.1697007502350;
        Tue, 10 Oct 2023 23:58:22 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm14469751wrw.103.2023.10.10.23.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:58:20 -0700 (PDT)
Date: Wed, 11 Oct 2023 07:58:20 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm: abstract merge for new VMAs into
 vma_merge_new_vma()
Message-ID: <e2c8fb0e-e5dc-454e-aad7-93a85fefaa9a@lucifer.local>
References: <cover.1696929425.git.lstoakes@gmail.com>
 <fe658ae961de1206f1557001f4d41d6e931d3919.1696929425.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe658ae961de1206f1557001f4d41d6e931d3919.1696929425.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 07:23:07PM +0100, Lorenzo Stoakes wrote:
> Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
> occupy entirely new regions of virtual memory.
>
> We can abstract this logic and make the intent of this invocations of it
> completely explicit, rather than invoking vma_merge() with an inscrutable
> wall of parameters.
>
> This also paves the way for a simplification of the core vma_merge()
> implementation, as we seek to make it entirely an implementation detail.
>
> Note that on mmap_region(), VMA fields are initialised to zero, so we can
> simply reference these rather than explicitly specifying NULL.

Andrew - based on feedback from Liam on the v2 version of this patch, could
we change this commit message to:-


Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
occupy entirely new regions of virtual memory.

We can abstract this logic and make the intent of this invocations of it
completely explicit, rather than invoking vma_merge() with an inscrutable
 wall of parameters.

This also paves the way for a simplification of the core vma_merge()
implementation, as we seek to make it entirely an implementation detail.

The VMA merge call in mmap_region() occurs only for file-backed mappings,
where each of the parameters previously specified as NULL are defaulted to
NULL in vma_init() (called by vm_area_alloc()).

This matches the previous behaviour of specifying NULL for a number of
fields, however note that prior to this call we pass the VMA to the file
system driver via call_mmap(), which may in theory adjust fields that we
pass in to vma_merge_new_vma().

Therefore we actually resolve an oversight here by allowing for the fact
that the driver may have done this.


>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>

Thanks!

> diff --git a/mm/mmap.c b/mm/mmap.c
> index a516f2412f79..db3842601a88 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2485,6 +2485,22 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
>  	return vma;
>  }
>
> +/*
> + * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> + * must ensure that [start, end) does not overlap any existing VMA.
> + */
> +static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
> +						struct vm_area_struct *prev,
> +						struct vm_area_struct *vma,
> +						unsigned long start,
> +						unsigned long end,
> +						pgoff_t pgoff)
> +{
> +	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
> +			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> +			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> @@ -2840,10 +2856,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> -			merge = vma_merge(&vmi, mm, prev, vma->vm_start,
> -				    vma->vm_end, vma->vm_flags, NULL,
> -				    vma->vm_file, vma->vm_pgoff, NULL,
> -				    NULL_VM_UFFD_CTX, NULL);
> +			merge = vma_merge_new_vma(&vmi, prev, vma,
> +						  vma->vm_start, vma->vm_end,
> +						  pgoff);
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> @@ -3385,9 +3400,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
>
> -	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
> -			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma
> --
> 2.42.0
>

