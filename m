Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8750F615B09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 04:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKBDqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 23:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKBDqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:46:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED1A27175
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 20:46:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 78so15139463pgb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Nov 2022 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngjCxwI50NV8NPGOK2d44HJXxJVX9v33B3O6zMRn5JA=;
        b=eJpD3knnuoN1RI+mnk0L+km945S6U+NZFy70tUArlIlIdazFCgBA8pH98AF4gmcwIB
         UGAS5hmpofQoKmX/0hwDgqTq+Ph6E2T3QU029p4SDYJd1D4RM8jmG10cUHzS3MZSe2t1
         QKtw3odcKYB2K9kqLN9x/IUnRKv1SqoK6wCzZFMgHa5Gm5ySrJPKvxgoBBphGmZV1jnE
         5xZHD3eQrG6gFwbFrHrTM18pBkoq03heJZ+RZ+3gcQ4cNrzWj1/wLF2IM/dTescBzE5Y
         bG2NHWVQcV3HBrEbSrIJGGRLQdEQxd7nCIP9kJlMrFu5N7HivEwpCBNKCHCAexxS2g8C
         e3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngjCxwI50NV8NPGOK2d44HJXxJVX9v33B3O6zMRn5JA=;
        b=MFzLT3DBGgpyidtqW5kicvl8xxr+hAYrWX0YzikAmyHZHfNkCAFTi4LRRLNyxQ67HO
         Y+Zm+LKzOXW9QCgxuBJLuDQJ5bfDWWfFV8OWAvxLsON67PBSN0HsgyUNd3UtJ+BIJYEW
         +gCeNQRn+lbCNFe2EuSqWWRX7vnP7D9BqmtOwtE6Z8K1S2wy6qmRRwy0zu2YHWfkiBpJ
         0taHOwd6MD/o5AJ01p0z92ZMKfjtPqPOuuTN5HQAH+qv8pz52+Flh8UleYRylzz7fZ1y
         o1D1642y/ftNEVEOemKG18TLrhkZ/WJmUXSDKLy1GcCFi3fhLzo/c9snjupFIjfO2pgh
         WIBA==
X-Gm-Message-State: ACrzQf06aa7zxzBbjU5dn3BIiXgiCS3Mm9liqcjMWo8vIivKXuStqr6p
        zbLGk2QgzvF3qzoxZRLU/ww=
X-Google-Smtp-Source: AMsMyM5WcVcn16x9J77fNGo+ZGYfs8AlMI1FYySaXqBVGyy3gqsYd1vg6hBASyFMPbxpL+Pzg7buSg==
X-Received: by 2002:a63:8942:0:b0:46e:c02e:2eb5 with SMTP id v63-20020a638942000000b0046ec02e2eb5mr19955416pgd.141.1667360791412;
        Tue, 01 Nov 2022 20:46:31 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id f27-20020aa7969b000000b0056cea9530b6sm7221952pfk.202.2022.11.01.20.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 20:46:30 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:46:25 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 1/2] vmalloc: Factor vmap_alloc() out of vm_map_ram()
Message-ID: <Y2HoEXopzB3sxMab@hyeyoo>
References: <20221101201828.1170455-1-willy@infradead.org>
 <20221101201828.1170455-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101201828.1170455-2-willy@infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 08:18:27PM +0000, Matthew Wilcox (Oracle) wrote:
> Introduce vmap_alloc() to simply get the address space.  This allows
> for code sharing in the next patch.
> 
> Suggested-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/vmalloc.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..dcab1d3cf185 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2230,6 +2230,27 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
>  
> +static void *vmap_alloc(size_t size, int node)
> +{
> +	void *mem;
> +
> +	if (likely(size <= (VMAP_MAX_ALLOC * PAGE_SIZE))) {
> +		mem = vb_alloc(size, GFP_KERNEL);
> +		if (IS_ERR(mem))
> +			mem = NULL;
> +	} else {
> +		struct vmap_area *va;
> +		va = alloc_vmap_area(size, PAGE_SIZE,
> +				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> +		if (IS_ERR(va))
> +			mem = NULL;
> +		else
> +			mem = (void *)va->va_start;
> +	}
> +
> +	return mem;
> +}
> +
>  /**
>   * vm_map_ram - map pages linearly into kernel virtual address (vmalloc space)
>   * @pages: an array of pointers to the pages to be mapped
> @@ -2247,24 +2268,8 @@ EXPORT_SYMBOL(vm_unmap_ram);
>  void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  {
>  	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> -	unsigned long addr;
> -	void *mem;
> -
> -	if (likely(count <= VMAP_MAX_ALLOC)) {
> -		mem = vb_alloc(size, GFP_KERNEL);
> -		if (IS_ERR(mem))
> -			return NULL;
> -		addr = (unsigned long)mem;
> -	} else {
> -		struct vmap_area *va;
> -		va = alloc_vmap_area(size, PAGE_SIZE,
> -				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
> -		if (IS_ERR(va))
> -			return NULL;
> -
> -		addr = va->va_start;
> -		mem = (void *)addr;
> -	}
> +	void *mem = vmap_alloc(size, node);
> +	unsigned long addr = (unsigned long)mem;
>  
>  	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
>  				pages, PAGE_SHIFT) < 0) {
> -- 
> 2.35.1

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
