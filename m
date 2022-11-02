Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A78615B40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 04:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKBD7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 23:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBD7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:59:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333721ADBB
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 20:59:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p21so11548982plr.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Nov 2022 20:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2yPoIWDDzc9PYn0w5vORaR9t4xV3ZtjfUPEHOHIEZUg=;
        b=j43kkGZTfcJiRjGWFJ97v2juhgj1kXKveCEGwbeMMGULnUeQQats118Gz3DtrCLIxh
         Qou8ggREsz/Psa56ARTVxnX5U3KuNVryBxziz0JOPWHU9gaBCIz3HInv6CRLaOqCXqhw
         v/liuqUT+UMmOZBgzhjGWcRjpkesk02+C+/pHo0N8lbZzZzTod0EanqqcdfHaaLnngHe
         V6S/iDXCBTACCbw/RiQQQNmD+oiYshKLieRmd1rKPiLggFd0iVj+Uia0c+QnfOeg3KY/
         Ryrx3H2Tx5iBOaY11/gLWll5jkO6kozs/Ps75cKqY0ggDeMcCFsOf24NrAiW+9dy9hWU
         N5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yPoIWDDzc9PYn0w5vORaR9t4xV3ZtjfUPEHOHIEZUg=;
        b=iTD4iiKPHRhFF7kY2e67O85RRrZ4EVivqpWolKK8fpXZbC5mClBzu4HyArNt3xHOmZ
         t4cA3DofrlC6ucvCxMJTEkcA03TfNCNVnGdIOhLgpIaApIAFv5aYk9XA7LBE6er2VEWN
         CO6PLu7bKrn7jm/JH0deYNE94YUITLpT0qhBP+6zdLsqosVYTCwzGuiR0FP3HYrrobzV
         qJSGo4HUzBA6zMKYVoZgzQ4csXzWPmq2oQD9S/dmiGM5Qd4k31wZzXjQATuOSK7COuKd
         4yuYs+nPZK8+jcHIv7GLfuloBDADZF3rKx2lUBHelXh7mQMlKSU5qdM1YDDPZuUOLUoL
         PvkQ==
X-Gm-Message-State: ACrzQf23FQNUc68MP/SBySE7iqEwjECGsF9evEVFOSpd15AepfajTmKw
        1yWCunVsltVov3nn/e1VMfU=
X-Google-Smtp-Source: AMsMyM6CiqkzyAVi7+b15AEvkHHkYI3AA8d7qFg3UH4G0RbPa644410riYl1ogPjxely26I5oeDQzA==
X-Received: by 2002:a17:902:ea09:b0:186:a604:d7e4 with SMTP id s9-20020a170902ea0900b00186a604d7e4mr22801093plg.120.1667361548975;
        Tue, 01 Nov 2022 20:59:08 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001745662d568sm7080577plh.278.2022.11.01.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 20:59:07 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:59:02 +0900
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
Message-ID: <Y2HrBsf2A5v1ehTr@hyeyoo>
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

I think we need to check mem != NULL.

>  
>  	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
>  				pages, PAGE_SHIFT) < 0) {
> -- 
> 2.35.1
> 
> 

-- 
Thanks,
Hyeonggon
