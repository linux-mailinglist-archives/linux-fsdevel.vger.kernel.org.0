Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5221A7581B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjGRQIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjGRQIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:08:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744CEE;
        Tue, 18 Jul 2023 09:08:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso54498635e9.1;
        Tue, 18 Jul 2023 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689696510; x=1690301310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fI3tX3/6gY3OaD7M7m70A/zRULJw/Q3Ke9ZUvuxGPs=;
        b=r1i2jYA/7qrYX7dZgBc5ZMQMq7I79Q9T3vRGoVMKYazNOReS9k7qo+BefbwNBT+ZPG
         N5u+pNA18+dZASxRcDnTNmZ3FmIlgKETN7hGXjcPvqVSVc3IB4/a+8POaO1c3y2dqigz
         flprATDyQc+lhfXRayOLRERRTh3UQuxPDHTcOTnZNEQBRGm0owqENgn8dqxjmLc5vHhK
         /c8MHLL2kRXcHiL7ipTlE/k4pcELodoN4Jqycs13wB6oYXrMCFA9/0b5Ey9zGyVPIcrl
         S1nGAQEdp70bxhCjKKtzuYAgnd0R+GP4ZTQNKN03i0CumsrPCsFAbTLBDoT6WeI7faDT
         qWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696510; x=1690301310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fI3tX3/6gY3OaD7M7m70A/zRULJw/Q3Ke9ZUvuxGPs=;
        b=TQLkj5VyBJ3Qnmu4gXGyi6qwTLOq215CHAvfzzemOKwYFgNz9PtYoKK7Xnz7IznH8o
         x9f11yjDuuK5GJ6S2Z8KbwMJsl9G7kFiIPu6w35S5egmFfbhbOnMHLtuhs+GNKbr4dlI
         PhD/viNn6tf0dbUFlB9wwyMbQ1ed6w6eeShX1rL86xiMnoSGI2JcQjl6BjGBaEeuzKkg
         OaLM1wtBp0fZZBRkyCZ6Dff5IFLJ+GAVwkvS2n2nyN/u5olEaoVaQXgejXq14QHuJwne
         kChIS221rPzTqi5O8qnTuEc7xuYSF4HLCcEJjTWSLPoPEAmVH72nqmgGVJXuA5jT04L1
         MnFA==
X-Gm-Message-State: ABy/qLaDH6mddeU8tnqfJnj07BElg6Dw+RrRnQWMhLAfSkg+hb7V8hGx
        7+X27boS5CYRxEvw1W3aMp1zz6B4AzmqsxEpxGs=
X-Google-Smtp-Source: APBJJlF3/wCmPIjfM+yq0aWOzc//envD1XP+gj9211VYN2qqwWTXp8RXoiqfBPWwPGDDJekxbQhbMN1Mle2n+ULzpec=
X-Received: by 2002:a7b:c7da:0:b0:3fa:97ad:2ba5 with SMTP id
 z26-20020a7bc7da000000b003fa97ad2ba5mr2434117wmk.31.1689696509367; Tue, 18
 Jul 2023 09:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230713101415.108875-1-usama.anjum@collabora.com>
 <20230713101415.108875-3-usama.anjum@collabora.com> <CANaxB-zMhhi+kHZ+3w9yzogo6fKjR=swBkuA-s88Qs5oeLRAYQ@mail.gmail.com>
 <c379c99f-2466-6056-4dd6-90d0a202c13c@collabora.com>
In-Reply-To: <c379c99f-2466-6056-4dd6-90d0a202c13c@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 18 Jul 2023 09:08:17 -0700
Message-ID: <CANaxB-y2C+gu9Z5MyKQEZATU6dscd04+PeJNNgvhYLp+31_Nrw@mail.gmail.com>
Subject: Re: [PATCH v25 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 1:18=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 7/17/23 10:26=E2=80=AFPM, Andrei Vagin wrote:
> > On Thu, Jul 13, 2023 at 3:14=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or cle=
ar
> >> the info about page table entries. The following operations are suppor=
ted
> >> in this ioctl:
> >> - Get the information if the pages have been written-to (PAGE_IS_WRITT=
EN),
> >>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT), swapped
> >>   (PAGE_IS_SWAPPED) or page has pfn zero (PAGE_IS_PFNZERO).
> >> - Find pages which have been written-to and/or write protect the pages
> >>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
> >>
> >> This IOCTL can be extended to get information about more PTE bits. The
> >> entire address range passed by user [start, end) is scanned until eith=
er
> >> the user provided buffer is full or max_pages have been found.
> >>
> >
> > Reviewed-by: Andrei Vagin <avagin@gmail.com>
> Thank you.
>

<snip>

> >> +#ifdef CONFIG_HUGETLB_PAGE
> >> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmas=
k,
> >> +                                     unsigned long start, unsigned lo=
ng end,
> >> +                                     struct mm_walk *walk)
> >> +{
> >> +       unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> >> +       struct pagemap_scan_private *p =3D walk->private;
> >> +       struct vm_area_struct *vma =3D walk->vma;
> >> +       bool is_written, interesting =3D true;
> >> +       struct hstate *h =3D hstate_vma(vma);
> >> +       unsigned long bitmap;
> >> +       spinlock_t *ptl;
> >> +       int ret =3D 0;
> >> +       pte_t ptent;
> >> +
> >> +       if (IS_PM_SCAN_WP(p->flags) && n_pages < HPAGE_SIZE/PAGE_SIZE)=
 {
> >> +               p->end_addr =3D start;
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (n_pages > p->max_pages - p->found_pages)
> >> +               n_pages =3D p->max_pages - p->found_pages;
> >> +
> >> +       if (IS_PM_SCAN_WP(p->flags)) {
> >> +               i_mmap_lock_write(vma->vm_file->f_mapping);
> >> +               ptl =3D huge_pte_lock(h, vma->vm_mm, ptep);
> >> +       }
> >> +
> >> +       ptent =3D huge_ptep_get(ptep);
> >> +       is_written =3D !is_huge_pte_uffd_wp(ptent);
> >> +
> >> +       bitmap =3D PM_SCAN_FLAGS(is_written, pagemap_scan_is_huge_file=
(ptent),
> >> +                              pte_present(ptent), is_swap_pte(ptent),
> >> +                              pte_present(ptent) && is_zero_pfn(pte_p=
fn(ptent)));
> >> +
> >> +       if (IS_PM_SCAN_GET(p->flags))
> >> +               interesting =3D pagemap_scan_is_interesting_page(bitma=
p, p);
> >> +
> >> +       if (interesting) {
> >> +               /*
> >> +                * Partial hugetlb page clear isn't supported
> >> +                */
> >> +               if (is_written && IS_PM_SCAN_WP(p->flags) &&
> >> +                   n_pages < HPAGE_SIZE/PAGE_SIZE) {
> >> +                       ret =3D PM_SCAN_END_WALK;
> >> +                       p->end_addr =3D start;
> >> +                       goto unlock_and_return;
> >> +               }
> >> +
> >> +               if (IS_PM_SCAN_GET(p->flags))
> >> +                       ret =3D pagemap_scan_output(bitmap, p, start, =
n_pages);
> >> +
> >> +               if (IS_PM_SCAN_WP(p->flags) && is_written && ret >=3D =
0) {
> >> +                       make_uffd_wp_huge_pte(vma, start, ptep, ptent)=
;
> >> +                       flush_hugetlb_tlb_range(vma, start, end);
> >> +               }
> >> +       }
> >> +
> >> +unlock_and_return:
> >> +       if (IS_PM_SCAN_WP(p->flags)) {
> >> +               spin_unlock(ptl);
> >> +               i_mmap_unlock_write(vma->vm_file->f_mapping);
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +#else
> >> +#define pagemap_scan_hugetlb_entry NULL
> >> +#endif
> >> +
> >> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long en=
d,
> >> +                                int depth, struct mm_walk *walk)
> >> +{
> >> +       unsigned long n_pages =3D (end - addr)/PAGE_SIZE;
> >> +       struct pagemap_scan_private *p =3D walk->private;
> >> +       struct vm_area_struct *vma =3D walk->vma;
> >> +       bool interesting =3D true;
> >> +       unsigned long bitmap;
> >> +       int ret =3D 0;
> >> +
> >> +       if (!vma)
> >> +               return 0;
> >> +
> >> +       bitmap =3D PM_SCAN_FLAGS(false, false, false, false, false);
> >> +
> >> +       if (IS_PM_SCAN_GET(p->flags))
> >> +               interesting =3D pagemap_scan_is_interesting_page(bitma=
p, p);
> >> +
> >> +       if (interesting) {
> >> +               if (IS_PM_SCAN_GET(p->flags)) {
> >> +                       if (n_pages > p->max_pages - p->found_pages)
> >> +                               n_pages =3D p->max_pages - p->found_pa=
ges;
> >> +
> >> +                       ret =3D pagemap_scan_output(bitmap, p, addr, n=
_pages);
> >> +               }
> >> +
> >> +               if (IS_PM_SCAN_WP(p->flags) && !ret &&
> >> +                   uffd_wp_range(vma, addr, end - addr, true) < 0)
> >
> > Why do we need to call uffd_wp_range for holes? Should we call
> > flush_tlb_range after it?

Did you skip this question?

> >
> >> +                       ret =3D -EINVAL;
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static const struct mm_walk_ops pagemap_scan_ops =3D {
> >> +       .test_walk =3D pagemap_scan_test_walk,
> >> +       .pmd_entry =3D pagemap_scan_pmd_entry,
> >> +       .pte_hole =3D pagemap_scan_pte_hole,
> >> +       .hugetlb_entry =3D pagemap_scan_hugetlb_entry,
> >> +};
> >> +
> >> +static int pagemap_scan_args_valid(struct pm_scan_arg *arg, unsigned =
long start,
> >> +                                  unsigned long end, struct page_regi=
on __user *vec)
> >> +{
> >> +       /* Detect illegal size, flags, len and masks */
> >> +       if (arg->size !=3D sizeof(struct pm_scan_arg))
> >> +               return -EINVAL;
> >> +       if (!arg->flags)
> >> +               return -EINVAL;
> >> +       if (arg->flags & ~PM_SCAN_OPS)
> >> +               return -EINVAL;
> >> +       if (!(end - start))
> >> +               return -EINVAL;
> >> +       if ((arg->required_mask | arg->anyof_mask | arg->excluded_mask=
 |
> >> +            arg->return_mask) & ~PM_SCAN_BITS_ALL)
> >> +               return -EINVAL;
> >> +       if (!arg->required_mask && !arg->anyof_mask &&
> >> +           !arg->excluded_mask)
> >> +               return -EINVAL;
> >> +       if (!arg->return_mask)
> >> +               return -EINVAL;
> >> +
> >> +       /* Validate memory range */
> >> +       if (!IS_ALIGNED(start, PAGE_SIZE))
> >> +               return -EINVAL;
> >> +       if (!access_ok((void __user *)start, end - start))
> >> +               return -EFAULT;
> >> +
> >> +       if (IS_PM_SCAN_GET(arg->flags)) {
> >> +               if (arg->vec_len =3D=3D 0)
> >> +                       return -EINVAL;
> >> +               if (!vec)
> >> +                       return -EFAULT;
> >> +               if (!access_ok((void __user *)vec,
> >> +                              arg->vec_len * sizeof(struct page_regio=
n)))
> >> +                       return -EFAULT;
> >> +       }
> >> +
> >> +       if (IS_PM_SCAN_WP(arg->flags) && !IS_PM_SCAN_GET(arg->flags) &=
&
> >> +           arg->max_pages)
> >> +               return -EINVAL;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long __arg=
)
> >> +{
> >> +       struct pm_scan_arg __user *uarg =3D (struct pm_scan_arg __user=
 *)__arg;
> >> +       unsigned long long start, end, walk_start, walk_end;
> >> +       unsigned long empty_slots, vec_index =3D 0;
> >> +       struct mmu_notifier_range range;
> >> +       struct page_region __user *vec;
> >> +       struct pagemap_scan_private p;
> >> +       struct pm_scan_arg arg;
> >> +       int ret =3D 0;
> >> +
> >> +       if (copy_from_user(&arg, uarg, sizeof(arg)))
> >> +               return -EFAULT;
> >> +
> >> +       start =3D untagged_addr((unsigned long)arg.start);
> >> +       end =3D untagged_addr((unsigned long)arg.end);
> >> +       vec =3D (struct page_region __user *)untagged_addr((unsigned l=
ong)arg.vec);
> >> +
> >> +       ret =3D pagemap_scan_args_valid(&arg, start, end, vec);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       p.max_pages =3D (arg.max_pages) ? arg.max_pages : ULONG_MAX;
> >> +       p.found_pages =3D 0;
> >> +       p.required_mask =3D arg.required_mask;
> >> +       p.anyof_mask =3D arg.anyof_mask;
> >> +       p.excluded_mask =3D arg.excluded_mask;
> >> +       p.return_mask =3D arg.return_mask;
> >> +       p.flags =3D arg.flags;
> >> +       p.flags |=3D ((p.required_mask | p.anyof_mask | p.excluded_mas=
k) &
> >> +                   PAGE_IS_WRITTEN) ? PM_SCAN_REQUIRE_UFFD : 0;
> >> +       p.cur_buf.start =3D p.cur_buf.len =3D p.cur_buf.flags =3D 0;
> >> +       p.vec_buf =3D NULL;
> >> +       p.vec_buf_len =3D PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
> >> +       p.vec_buf_index =3D 0;
> >> +       p.end_addr =3D 0;
> >> +
> >> +       /*
> >> +        * Allocate smaller buffer to get output from inside the page =
walk
> >> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chu=
nks. As
> >> +        * we want to return output to user in compact form where no t=
wo
> >> +        * consecutive regions should be continuous and have the same =
flags.
> >> +        * So store the latest element in p.cur_buf between different =
walks and
> >> +        * store the p.cur_buf at the end of the walk to the user buff=
er.
> >> +        */
> >> +       if (IS_PM_SCAN_GET(p.flags)) {
> >> +               p.vec_buf =3D kmalloc_array(p.vec_buf_len, sizeof(*p.v=
ec_buf),
> >> +                                         GFP_KERNEL);
> >> +               if (!p.vec_buf)
> >> +                       return -ENOMEM;
> >> +       }
> >> +
> >> +       /*
> >> +        * Protection change for the range is going to happen.
> >> +        */
> >> +       if (IS_PM_SCAN_WP(p.flags)) {
> >> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_=
VMA, 0,
> >> +                                       mm, start, end);
> >> +               mmu_notifier_invalidate_range_start(&range);
> >> +       }
> >> +
> >> +       walk_start =3D walk_end =3D start;
> >> +       while (walk_end < end && !ret) {
> >> +               if (IS_PM_SCAN_GET(p.flags)) {
> >> +                       /*
> >> +                        * All data is copied to cur_buf first. When m=
ore data
> >> +                        * is found, we push cur_buf to vec_buf and co=
py new
> >> +                        * data to cur_buf. Subtract 1 from length as =
the
> >> +                        * index of cur_buf isn't counted in length.
> >> +                        */
> >> +                       empty_slots =3D arg.vec_len - vec_index;
> >> +                       p.vec_buf_len =3D min(p.vec_buf_len, empty_slo=
ts - 1);
> >> +               }
> >> +
> >
> > I still don't understand why we don't want/need to check for pending si=
gnals.
> We haven't added it as other existing code such as mincore() and

It doesn't convince me. There should be reasons to do or not to do
certain things.
We can't say how long this loop can be running, so it is the reason
why we can want
to check pending signals.

> pagemap_read() don't have it either.

I already explained that this case is different, because the size of
the output buffer is
limited for pagemap_read.

> Also mmap_read_lock_killable would return error if there is some critical=
 single pending.\

It isn't completely true. It doesn't return errors in the fast path
when it takes the lock right
away. It checks signals only when it needs to wait for the lock.

>
> >
> >> +               ret =3D mmap_read_lock_killable(mm);
> >> +               if (ret)
> >> +                       goto out;
> >> +
> >> +               walk_end =3D min((walk_start + PAGEMAP_WALK_SIZE) & PA=
GEMAP_WALK_MASK, end);
> >> +
> >> +               ret =3D walk_page_range(mm, walk_start, walk_end,
> >> +                                     &pagemap_scan_ops, &p);
> >> +               mmap_read_unlock(mm);
> >> +
> >> +               if (ret =3D=3D PM_SCAN_FOUND_MAX_PAGES || ret =3D=3D P=
M_SCAN_END_WALK)
> >> +                       arg.start =3D p.end_addr;
> >
> > nit: this check can be moved out of the loop.
> No, ret could get replaced by error if copy_to_user() fails. So we have t=
o
> do this before that.

If we fail to copy a vector, it is a fatal error and it probably doesn't ma=
tter
what end address has been there. It is up to you to leave it here or not.

>
> >
> >> +
> >> +               if (ret && ret !=3D PM_SCAN_FOUND_MAX_PAGES &&
> >> +                   ret !=3D PM_SCAN_END_WALK)
> >> +                       goto out;
> >> +
> >> +               if (p.vec_buf_index) {
> >> +                       if (copy_to_user(&vec[vec_index], p.vec_buf,
> >> +                                        p.vec_buf_index * sizeof(*p.v=
ec_buf))) {
> >> +                               /*
> >> +                                * Return error even though the OP suc=
ceeded
> >> +                                */
> >> +                               ret =3D -EFAULT;
> >> +                               goto out;
> >> +                       }
> >> +                       vec_index +=3D p.vec_buf_index;
> >> +                       p.vec_buf_index =3D 0;
> >> +               }
> >> +               walk_start =3D walk_end;
> >> +       }
> >> +
> >> +       if (p.cur_buf.len) {
> >> +               if (copy_to_user(&vec[vec_index], &p.cur_buf, sizeof(p=
.cur_buf))) {
> >> +                       ret =3D -EFAULT;
> >> +                       goto out;
> >> +               }
> >> +               vec_index++;
> >> +       }
> >> +
> >> +       ret =3D vec_index;
> >> +
> >> +out:
> >> +       if (!p.end_addr)
> >> +               arg.start =3D walk_start;
> >> +       if (copy_to_user(&uarg->start, &arg.start, sizeof(arg.start)))
> >> +               ret =3D -EFAULT;
> >> +
> >> +       if (IS_PM_SCAN_WP(p.flags))
> >> +               mmu_notifier_invalidate_range_end(&range);
> >> +
> >> +       kfree(p.vec_buf);
> >> +       return ret;
> >> +}
> >> +

Thanks,
Andrei
