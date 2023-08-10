Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCE777F33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjHJRcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 13:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjHJRcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:32:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7541270A
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 10:32:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso14565e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691688765; x=1692293565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1OIxnppp2DfOfyksuLKPQkbYAudAqUGDvsFNz7T6KU=;
        b=QyPOlyLb/Nx4AXNfGW0VDnAqQHog0UsH34IbRIIuWtVBqJd8eKgbEBjGuBniPqvMH1
         7J1H8j+YaC+nGhwr6rJngVIjMT9xJpkPP4pNKvAI50L9tJZtch30qwvoyZXFzXI/vBLO
         802rHrAU2QRly0p1zeDICFHOcbc9ri7UtPz54lgw2fu9ZhleP5waLU19JrN/P+xJ+bQF
         +To8pJ9QnFuwEbJizR9o4caCqeBQ0ZYU8ltPhIetFlapFjQV++zZ8AYvwrUK2oUvJFe/
         X0dVG9wIEDzqtUq5lsBUCQQqAPoq3BULb17GwAQsljn4vWdfCDZ8iTHz38Ir+SM0b+/p
         uPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688765; x=1692293565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1OIxnppp2DfOfyksuLKPQkbYAudAqUGDvsFNz7T6KU=;
        b=Q4xpJIhmas+zszAyvjQziF4YO9S1HAdIQVRlXe/yV4IravuIkzI/sbisZjT4Kmxabe
         4akm0XDagq4By2SzFzyjXBVjDnr7Mr7VUxVfd3f+WwQ1zoRnVAf09/JrAIqOyIbKPGXQ
         GMs5H48e5eIGK68x9UGn2iaEbeb4/eRNMSSj5+hwXwAKbdRT7sYNXp6nttDl3Okwcnj9
         KHiMt3lVhxQizy8iDj4yfcqavUhCsOzuIgb96k5gno1xmC8Qvl//0cSPM0b/u1OfTAy2
         yMquVDFaCz9S5dsc9RvF4Fn89NKaP9nVhUhD9ZfH/ne9SvUPqX4APy9iylkGYbxGal8H
         Ndpw==
X-Gm-Message-State: AOJu0YwO55LhunLWOfkkTu/RAHKy1wqohyqASGOGTPbde528MrA9Lt49
        e5u4YIQ+r8L+8biY9o82AmldDnh847X79g+SaX9qbA==
X-Google-Smtp-Source: AGHT+IEbyVUtx8LG2w0tLSzZLkhPnnUbBpSxd+n6pw9f0vggrm7JN+pbUAlrSzxsivod8taXTkl2Zc+Fpi6UbzzFOsk=
X-Received: by 2002:a05:600c:1c0f:b0:3f7:e463:a0d6 with SMTP id
 j15-20020a05600c1c0f00b003f7e463a0d6mr12739wms.0.1691688764903; Thu, 10 Aug
 2023 10:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230809061603.1969154-1-usama.anjum@collabora.com> <20230809061603.1969154-3-usama.anjum@collabora.com>
In-Reply-To: <20230809061603.1969154-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 10 Aug 2023 19:32:33 +0200
Message-ID: <CABb0KFGqDo8hFohqpXewoquyLVZUhG-bRHxpw_PYXzGW9wXofQ@mail.gmail.com>
Subject: Re: [PATCH v28 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Aug 2023 at 08:16, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have Async Write-Protection enabled
>   (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), fi=
le
>   mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
>   (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
> - Find pages which have been written to and/or write protect
>   (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages
>   atomically. The (``PM_SCAN_WP_MATCHING``) is used to WP the matched
>   pages. The (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if
>   non-Async-Write-Protected pages are found. Get is automatically perform=
ed
>   if output buffer is specified.
>
> This IOCTL can be extended to get information about more PTE bits. The
> entire address range passed by user [start, end) is scanned until either
> the user provided buffer is full or max_pages have been found.
>
> Reviewed-by: Andrei Vagin <avagin@gmail.com>
> Reviewed-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Still applies, thanks! Please find some mostly-polishing comments below.

> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> Changes in v28:
> - Fix walk_end one last time after doing through testing
>
> Changes in v27:
> - Add PAGE_IS_HUGE

It seems to be missing from the commitmsg, though. But maybe listing
all the flags there is redundant, since a doc is coming anyway and the
values are listed in the .h?

[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long pagemap_thp_category(pmd_t pmd)
> +{
> +       unsigned long categories =3D PAGE_IS_HUGE;
> +
> +       if (pmd_present(pmd)) {
> +               categories |=3D PAGE_IS_PRESENT;
> +               if (!pmd_uffd_wp(pmd))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +               if (is_zero_pfn(pmd_pfn(pmd)))
> +                       categories |=3D PAGE_IS_PFNZERO;
> +       } else if (is_swap_pmd(pmd)) {
> +               categories |=3D PAGE_IS_SWAPPED;
> +               if (!pmd_swp_uffd_wp(pmd))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +       }
> +
> +       return categories;
> +}

I guess THPs can't be file-backed currently, but can we somehow mark
this assumption so it can be easily found if the capability arrives?

> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static unsigned long pagemap_hugetlb_category(pte_t pte)
> +{
> +       unsigned long categories =3D PAGE_IS_HUGE;
> +
> +       if (pte_present(pte)) {
> +               categories |=3D PAGE_IS_PRESENT;
> +               if (!huge_pte_uffd_wp(pte))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +               if (!PageAnon(pte_page(pte)))
> +                       categories |=3D PAGE_IS_FILE;
> +               if (is_zero_pfn(pte_pfn(pte)))
> +                       categories |=3D PAGE_IS_PFNZERO;
> +       } else if (is_swap_pte(pte)) {
> +               categories |=3D PAGE_IS_SWAPPED;
> +               if (!pte_swp_uffd_wp_any(pte))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +       }

BTW, can a HugeTLB page be file-backed and swapped out?

> +static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
> +                                      unsigned long addr, unsigned long =
end,
> +                                      unsigned long walk_end_addr)
> +{
> +       struct page_region *cur_buf =3D &p->cur_buf;
> +
> +       if (cur_buf->start !=3D addr)
> +               cur_buf->end =3D addr;
> +       else
> +               cur_buf->start =3D cur_buf->end =3D 0;
> +
> +       p->walk_end_addr =3D walk_end_addr;
> +       p->found_pages -=3D (end - addr) / PAGE_SIZE;
> +}

When would `walk_end_addr` be different from `end`? Maybe it would be
easier to understand if the `p->walk_end_addr` update was pushed to
the callers? (Actually: the one that wants to change it.)

> +static int pagemap_scan_output(unsigned long categories,
> +                              struct pagemap_scan_private *p,
> +                              unsigned long addr, unsigned long *end)
> +{
> +       unsigned long n_pages, total_pages;
> +       int ret =3D 0;
> +
> +       if (!p->vec_buf)
> +               return 0;
> +
> +       categories &=3D p->arg.return_mask;
> +
> +       n_pages =3D (*end - addr) / PAGE_SIZE;
> +       if (check_add_overflow(p->found_pages, n_pages, &total_pages) || =
//TODO
> +           total_pages > p->arg.max_pages) {

Re: TODO: Is there anything left to change here?

> +               size_t n_too_much =3D total_pages - p->arg.max_pages;
> +               *end -=3D n_too_much * PAGE_SIZE;
> +               n_pages -=3D n_too_much;
> +               ret =3D -ENOSPC;
> +       }
[...]

> +static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
> +                                 unsigned long end, struct mm_walk *walk=
)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long categories;
> +       spinlock_t *ptl;
> +       int ret =3D 0;
> +
> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> +       if (!ptl)
> +               return -ENOENT;
> +
> +       categories =3D p->cur_vma_category | pagemap_thp_category(*pmd);
> +
> +       if (!pagemap_scan_is_interesting_page(categories, p))
> +               goto out_unlock;
> +
> +       ret =3D pagemap_scan_output(categories, p, start, &end);
> +       if (start =3D=3D end)
> +               goto out_unlock;
> +
> +       if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> +               goto out_unlock;
> +       if (~categories & PAGE_IS_WRITTEN)
> +               goto out_unlock;
> +
> +       /*
> +        * Break huge page into small pages if the WP operation
> +        * need to be performed is on a portion of the huge page.

"needs to be performed on ..."

> +        */
> +       if (end !=3D start + HPAGE_SIZE) {
> +               spin_unlock(ptl);
> +               split_huge_pmd(vma, pmd, start);
> +               pagemap_scan_backout_range(p, start, end, 0);
> +               /* Indicate to caller for processing these as normal page=
s */

Nit: "Report as if there was no THP." ?

> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +                                 unsigned long end, struct mm_walk *walk=
)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       pte_t *pte, *start_pte;
> +       unsigned long addr;
> +       bool flush =3D false;
> +       spinlock_t *ptl;
> +       int ret;
> +
> +       arch_enter_lazy_mmu_mode();
> +
> +       ret =3D pagemap_scan_thp_entry(pmd, start, end, walk);
> +       if (ret !=3D -ENOENT) {
> +               arch_leave_lazy_mmu_mode();
> +               return ret;
> +       }
> +
> +       ret =3D 0;
> +       start_pte =3D pte =3D pte_offset_map_lock(vma->vm_mm, pmd, start,=
 &ptl);
> +       if (!pte) {
> +               arch_leave_lazy_mmu_mode();
> +               walk->action =3D ACTION_AGAIN;
> +               return 0;
> +       }
> +
> +       for (addr =3D start; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
> +               unsigned long categories =3D p->cur_vma_category |
> +                                          pagemap_page_category(p, vma, =
addr, ptep_get(pte));
> +               unsigned long next =3D addr + PAGE_SIZE;
> +
> +               if (!pagemap_scan_is_interesting_page(categories, p))
> +                       continue;
> +
> +               ret =3D pagemap_scan_output(categories, p, addr, &next);
> +               if (next =3D=3D addr)
> +                       break;
> +
> +               if (~p->arg.flags & PM_SCAN_WP_MATCHING)
> +                       continue;
> +               if (~categories & PAGE_IS_WRITTEN)
> +                       continue;
> +
> +               make_uffd_wp_pte(vma, addr, pte);
> +               if (!flush) {
> +                       start =3D addr;
> +                       flush =3D true;
> +               }

A quick improvement:

/* instead of `flush` declaration */ unsigned long flush_end =3D 0;

if (!flush_end)
  start =3D addr;
flush_end =3D next;

> +       }
> +
> +       if (flush)
> +               flush_tlb_range(vma, start, addr);

And here:
if (flush_end)
  flush_tlb_range(vma, start, flush_end);

> +       pte_unmap_unlock(start_pte, ptl);
> +       arch_leave_lazy_mmu_mode();
> +
> +       cond_resched();
> +       return ret;
> +}

[...]
> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> +{
> +       struct mmu_notifier_range range;
> +       struct pagemap_scan_private p;
> +       unsigned long walk_start;
> +       size_t n_ranges_out =3D 0;
> +       int ret;
> +
> +       memset(&p, 0, sizeof(p));
> +       ret =3D pagemap_scan_get_args(&p.arg, uarg);
> +       if (ret)
> +               return ret;
> +
> +       p.masks_of_interest =3D MASKS_OF_INTEREST(p.arg);

Please inline the macro as here is the only use of it.

[...]
> +       walk_start =3D p.arg.start;
> +       for (; walk_start < p.arg.end; walk_start =3D p.arg.walk_end) {

Nit: the initialization statement can now be part of the for().

> +               int n_out;
> +
> +               if (fatal_signal_pending(current)) {
> +                       ret =3D -EINTR;
> +                       break;
> +               }
> +
> +               ret =3D mmap_read_lock_killable(mm);
> +               if (ret)
> +                       break;
> +               ret =3D walk_page_range(mm, walk_start, p.arg.end,
> +                                     &pagemap_scan_ops, &p);
> +               mmap_read_unlock(mm);
> +
> +               n_out =3D pagemap_scan_flush_buffer(&p);
> +               if (n_out < 0)
> +                       ret =3D n_out;
> +               else
> +                       n_ranges_out +=3D n_out;
> +
> +               if (!ret)
> +                       p.walk_end_addr =3D p.arg.end;
> +
> +               if (ret !=3D -ENOSPC || p.arg.vec_len - 1 =3D=3D 0 ||
> +                   p.found_pages =3D=3D p.arg.max_pages)
> +                       break;

The second condition is equivalent to `p.arg.vec_len =3D=3D 1`, but why is
that an ending condition? Isn't the last entry enough to gather one
more range? (The walk could have returned -ENOSPC due to buffer full
and after flushing it could continue with the last free entry.)

[...]
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -259,6 +259,7 @@ long hugetlb_change_protection(struct vm_area_struct =
*vma,
>                 unsigned long cp_flags);
>
>  bool is_hugetlb_entry_migration(pte_t pte);
> +bool is_hugetlb_entry_hwpoisoned(pte_t pte);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
>
>  #else /* !CONFIG_HUGETLB_PAGE */
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c5..1c9d38af1015e 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -305,4 +305,63 @@ typedef int __bitwise __kernel_rwf_t;
>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>                          RWF_APPEND)
>
> +/* Pagemap ioctl */
> +#define PAGEMAP_SCAN   _IOWR('f', 16, struct pm_scan_arg)
> +
> +/* Bits are set in flags of the page_region and masks in pm_scan_args */

"Bitmasks provided in pm_scan_args masks and reported in
page_region.categories."

> +#define PAGE_IS_WPALLOWED      (1 << 0)
> +#define PAGE_IS_WRITTEN                (1 << 1)
> +#define PAGE_IS_FILE           (1 << 2)
> +#define PAGE_IS_PRESENT                (1 << 3)
> +#define PAGE_IS_SWAPPED                (1 << 4)
> +#define PAGE_IS_PFNZERO                (1 << 5)
> +#define PAGE_IS_HUGE           (1 << 6)
> +
> +/*
> + * struct page_region - Page region with flags
> + * @start:     Start of the region
> + * @end:       End of the region (exclusive)
> + * @categories:        PAGE_IS_* category bitmask for the region
> + */
> +struct page_region {
> +       __u64 start;
> +       __u64 end;
> +       __u64 categories;
> +};
> +
> +/* Flags for PAGEMAP_SCAN ioctl */
> +#define PM_SCAN_WP_MATCHING    (1 << 0)        /* Write protect the page=
s matched. */
> +#define PM_SCAN_CHECK_WPASYNC  (1 << 1)        /* Abort the scan when a =
non-WP-enabled page is found. */
> +
> +/*
> + * struct pm_scan_arg - Pagemap ioctl argument
> + * @size:              Size of the structure
> + * @flags:             Flags for the IOCTL
> + * @start:             Starting address of the region
> + * @end:               Ending address of the region
> + * @walk_end           Address where the scan stopped (written by kernel=
).
> + *                     walk_end =3D=3D end informs that the scan complet=
ed on entire range.

Can we ensure this holds also for the tagged pointers?

> + * @vec:               Address of page_region struct array for output
> + * @vec_len:           Length of the page_region struct array
> + * @max_pages:         Optional limit for number of returned pages (0 =
=3D disabled)
> + * @category_inverted: PAGE_IS_* categories which values match if 0 inst=
ead of 1
> + * @category_mask:     Skip pages for which any category doesn't match
> + * @category_anyof_mask: Skip pages for which no category matches
> + * @return_mask:       PAGE_IS_* categories that are to be reported in `=
page_region`s returned
> + */
[...]

Best Regards
Micha=C5=82 Miros=C5=82aw
