Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CDE1D4F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEONiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:38:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42674 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgEONiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589549932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=IrGI0DZbjpPmctsiQFo4Cv0GcRUtJJCYrBz4CvoBjWo=;
        b=jFmypT7vS0cvTQIv044XJgj4Gij8Jyte0URJ+BuMrabCVnxMZDeK1n3k3/SZW2SeRP6rtS
        2dOsALdwfpidonCP7yfqQHlhFjBzBv+nc4Tm0KHx+PlpHR3nrvHve1BtzXGIKraMzNbvyX
        e990N3xH39Hj+pjAIZ0AO/xWJokxWG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Yq-CiclcP8CbpI35jLsV0Q-1; Fri, 15 May 2020 09:38:50 -0400
X-MC-Unique: Yq-CiclcP8CbpI35jLsV0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35D631005510;
        Fri, 15 May 2020 13:38:49 +0000 (UTC)
Received: from [10.36.114.77] (ovpn-114-77.ams2.redhat.com [10.36.114.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C2EC5D9C9;
        Fri, 15 May 2020 13:38:47 +0000 (UTC)
Subject: Re: [PATCH v4 04/36] mm: Introduce thp_size
To:     Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-5-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <d48ec2d8-4335-5628-0189-1ad4b6799a9f@redhat.com>
Date:   Fri, 15 May 2020 15:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515131656.12890-5-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.05.20 15:16, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This is like page_size(), but compiles down to just PAGE_SIZE if THP
> are disabled.  Convert the users of hpage_nr_pages() which would prefer
> this interface.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  drivers/nvdimm/btt.c    | 4 +---
>  drivers/nvdimm/pmem.c   | 6 ++----
>  include/linux/huge_mm.h | 7 +++++++
>  mm/internal.h           | 2 +-
>  mm/page_io.c            | 2 +-
>  mm/page_vma_mapped.c    | 4 ++--
>  6 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 3b09419218d6..78e8d972d45a 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1488,10 +1488,8 @@ static int btt_rw_page(struct block_device *bdev, sector_t sector,
>  {
>  	struct btt *btt = bdev->bd_disk->private_data;
>  	int rc;
> -	unsigned int len;
>  
> -	len = hpage_nr_pages(page) * PAGE_SIZE;
> -	rc = btt_do_bvec(btt, NULL, page, len, 0, op, sector);
> +	rc = btt_do_bvec(btt, NULL, page, thp_size(page), 0, op, sector);
>  	if (rc == 0)
>  		page_endio(page, op_is_write(op), 0);
>  
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 2df6994acf83..d511504d07af 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -235,11 +235,9 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>  	blk_status_t rc;
>  
>  	if (op_is_write(op))
> -		rc = pmem_do_write(pmem, page, 0, sector,
> -				   hpage_nr_pages(page) * PAGE_SIZE);
> +		rc = pmem_do_write(pmem, page, 0, sector, thp_size(page));
>  	else
> -		rc = pmem_do_read(pmem, page, 0, sector,
> -				   hpage_nr_pages(page) * PAGE_SIZE);
> +		rc = pmem_do_read(pmem, page, 0, sector, thp_size(page));
>  	/*
>  	 * The ->rw_page interface is subtle and tricky.  The core
>  	 * retries on any error, so we can only invoke page_endio() in
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 6bec4b5b61e1..e944f9757349 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -271,6 +271,11 @@ static inline int hpage_nr_pages(struct page *page)
>  	return compound_nr(page);
>  }
>  
> +static inline unsigned long thp_size(struct page *page)
> +{
> +	return page_size(page);
> +}
> +
>  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
>  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> @@ -329,6 +334,8 @@ static inline int hpage_nr_pages(struct page *page)
>  	return 1;
>  }
>  
> +#define thp_size(x)		PAGE_SIZE
> +
>  static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
>  	return false;
> diff --git a/mm/internal.h b/mm/internal.h
> index f762a34b0c57..5efb13d5c226 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -386,7 +386,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
>  	unsigned long start, end;
>  
>  	start = __vma_address(page, vma);
> -	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
> +	end = start + thp_size(page) - PAGE_SIZE;
>  
>  	/* page should be within @vma mapping range */
>  	VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma);
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 76965be1d40e..dd935129e3cb 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -41,7 +41,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>  		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>  		bio->bi_end_io = end_io;
>  
> -		bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
> +		bio_add_page(bio, page, thp_size(page), 0);
>  	}
>  	return bio;
>  }
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 719c35246cfa..e65629c056e8 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -227,7 +227,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			if (pvmw->address >= pvmw->vma->vm_end ||
>  			    pvmw->address >=
>  					__vma_address(pvmw->page, pvmw->vma) +
> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
> +					thp_size(pvmw->page))
>  				return not_found(pvmw);
>  			/* Did we cross page table boundary? */
>  			if (pvmw->address % PMD_SIZE == 0) {
> @@ -268,7 +268,7 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
>  	unsigned long start, end;
>  
>  	start = __vma_address(page, vma);
> -	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
> +	end = start + thp_size(page) - PAGE_SIZE;
>  
>  	if (unlikely(end < vma->vm_start || start >= vma->vm_end))
>  		return 0;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

