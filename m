Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB61C1C78D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgEFR7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgEFR7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 13:59:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B477C061A0F;
        Wed,  6 May 2020 10:59:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so2110920ejb.9;
        Wed, 06 May 2020 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIcdx1T5WyCT7V/lFxKy/W62COVbRr9aZKjJfv7CJIA=;
        b=rpHumZ7cS+nQcUbR/fJyKXseHDb16n9G8VLhbol5mwMi7qgm8Gb5uux8u5QgBD+dSm
         6eaBhBXkNZzSE4tg9mfYthz9+9SxDxAnbOa0Tw0SX0MN7y7r/VcY92z1KBEWD0zdWZ0m
         NVzi9/dB39u6VyDMYjVBJo51NCzog8qTHnKeEuku5Wqg2H23Sui3dUn9grm1kjD56flo
         8dk4vaa8zqiUWThm7e8yGEzutx9Ji0xCtwKJwAPDgmqZPVDHnNYr5dD0A9RtQaBjbn8/
         nelduSzIfy9/0er+m8he6vtSwSZg0xHBBUIXyGA+fRTCcrxSg3ckH49ol9cYluK56Chy
         a+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIcdx1T5WyCT7V/lFxKy/W62COVbRr9aZKjJfv7CJIA=;
        b=dQ9nLiYm2mQDAfM+ZrQjpymOiohNgppaDwom/IDbCgidWKrNjQ+5EWKJE0iasnSmA1
         h+2aCV5QAU5kDkD/kGN69PGwPRbCArI7U9SZXKEtI8gFbIrDXb0dHWcGqy9jpoF5SNPZ
         JKXZSxJjF28i5tnzckARCNjWHa/0TCVtAMcsV3rjYOBPIY7a6zg3f566dEKuW7u7/BgQ
         b6eGiQykjqOLaPugYqBf7p6yB94s2T9ChJn9Buv82AlDmoeifQRzfVO6MshrdQ9mi3RA
         7csA3Dk9eUAdYx5DzspL9xYlyY90h97B1QjuxxACnOOG60YjTN2SZafDRGMXSB2F9AK7
         hp4Q==
X-Gm-Message-State: AGi0Pub2vQ4EMY1DbeAmw/eJ/Q1Rku44TcnQt47u0Cw3RUJgIJNqO3Oz
        ASgSz/TJsHeznvG2zVOU+ZD7BhofrDQ2Ou6ECZsOLE7t
X-Google-Smtp-Source: APiQypIacUEFlDEeMFY3srroim9H6s7tFNfCvT0t0IiKQKoTQJ5A0PL5Y3hrRB7OBYcpRWX4iw+gmRW4IbOkcXvx3R4=
X-Received: by 2002:a17:906:1e47:: with SMTP id i7mr8765974ejj.61.1588787987110;
 Wed, 06 May 2020 10:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200429133657.22632-1-willy@infradead.org> <20200429133657.22632-3-willy@infradead.org>
In-Reply-To: <20200429133657.22632-3-willy@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 May 2020 10:59:23 -0700
Message-ID: <CAHbLzkrd3piOmAL9Wf2G5+xhmOAXkzQXOMLEq31G4WULz=Q9+g@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] mm: Introduce thp_size
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 6:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
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
>         struct btt *btt = bdev->bd_disk->private_data;
>         int rc;
> -       unsigned int len;
>
> -       len = hpage_nr_pages(page) * PAGE_SIZE;
> -       rc = btt_do_bvec(btt, NULL, page, len, 0, op, sector);
> +       rc = btt_do_bvec(btt, NULL, page, thp_size(page), 0, op, sector);
>         if (rc == 0)
>                 page_endio(page, op_is_write(op), 0);
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 2df6994acf83..184c8b516543 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -235,11 +235,9 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>         blk_status_t rc;
>
>         if (op_is_write(op))
> -               rc = pmem_do_write(pmem, page, 0, sector,
> -                                  hpage_nr_pages(page) * PAGE_SIZE);
> +               rc = pmem_do_write(pmem, page, 0, sector, tmp_size(page));

s/tmp_size/thp_size

>         else
> -               rc = pmem_do_read(pmem, page, 0, sector,
> -                                  hpage_nr_pages(page) * PAGE_SIZE);
> +               rc = pmem_do_read(pmem, page, 0, sector, thp_size(page));
>         /*
>          * The ->rw_page interface is subtle and tricky.  The core
>          * retries on any error, so we can only invoke page_endio() in
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 6bec4b5b61e1..e944f9757349 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -271,6 +271,11 @@ static inline int hpage_nr_pages(struct page *page)
>         return compound_nr(page);
>  }
>
> +static inline unsigned long thp_size(struct page *page)
> +{
> +       return page_size(page);
> +}
> +
>  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>                 pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
>  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> @@ -329,6 +334,8 @@ static inline int hpage_nr_pages(struct page *page)
>         return 1;
>  }
>
> +#define thp_size(x)            PAGE_SIZE
> +
>  static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
>         return false;
> diff --git a/mm/internal.h b/mm/internal.h
> index f762a34b0c57..5efb13d5c226 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -386,7 +386,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
>         unsigned long start, end;
>
>         start = __vma_address(page, vma);
> -       end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
> +       end = start + thp_size(page) - PAGE_SIZE;
>
>         /* page should be within @vma mapping range */
>         VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma);
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 76965be1d40e..dd935129e3cb 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -41,7 +41,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>                 bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>                 bio->bi_end_io = end_io;
>
> -               bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
> +               bio_add_page(bio, page, thp_size(page), 0);
>         }
>         return bio;
>  }
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 719c35246cfa..e65629c056e8 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -227,7 +227,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                         if (pvmw->address >= pvmw->vma->vm_end ||
>                             pvmw->address >=
>                                         __vma_address(pvmw->page, pvmw->vma) +
> -                                       hpage_nr_pages(pvmw->page) * PAGE_SIZE)
> +                                       thp_size(pvmw->page))
>                                 return not_found(pvmw);
>                         /* Did we cross page table boundary? */
>                         if (pvmw->address % PMD_SIZE == 0) {
> @@ -268,7 +268,7 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
>         unsigned long start, end;
>
>         start = __vma_address(page, vma);
> -       end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
> +       end = start + thp_size(page) - PAGE_SIZE;
>
>         if (unlikely(end < vma->vm_start || start >= vma->vm_end))
>                 return 0;
> --
> 2.26.2
>
>
