Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297A4726675
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjFGQw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFGQw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:52:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C0713D
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 09:52:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso313a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686156773; x=1688748773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDPu/l1jQkL1v/hJOBAOUnasvA9zu2nCkrjHp2QAgLM=;
        b=iwJUggxmjMfoM27ioWLRFV88/qcJLp1Oygu73i7qkmVtRPdM1GTkdOV0mLDei7dJou
         Tszz7TvhbzC6Jz9+7gHV5V7QAiGdiFnO9+fnSBTwFhURNAJJuLDSDAAZ+adkLbgyuI5V
         JUZLetMRYQNt4iOSw+EUjZvDw3+c3kYqbMM74nOemu+u1R+OUzEKQ7fkMCNzfaLN4z0k
         5KzopE35KJ+BqV0b3RincLl3QesUZZCGe9+dpyv3edUGB+UtXniS/bwJNFFmjVyh3IW9
         pgxm2oNOf16IWersIYGfY62yQfxgwwLwLHKTkOk5bdBm4oDUibP6dV0/sPt7XlsFEBXV
         XyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686156773; x=1688748773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDPu/l1jQkL1v/hJOBAOUnasvA9zu2nCkrjHp2QAgLM=;
        b=QUGoyEmo0CPJ7gxc5LwKFlgOa0PGBPaJjPo1uVrib+0RpWhNStfecOj29TNi2CVGcA
         /tVV7EEjxQnVgBRe2RzLjCw48uPtIwMYVMKl3HON5pTHQjycucBXnD5lA4350ZDACCIW
         Wz/YKtteqpktsA0PXFSXPxq2RmuIbF3BiTkoQIlumMcjy60nD+bM4msfTpgpNFeiiSZ2
         2D5xlRhqNTaxF4erly5EGPeUvizPk+wgMmiixfOLTFi9nusMSCO1cApFhWMZkZIOzD9h
         ZVS45TJgFqT5TCxO0tvNqfoNmjIxnuciPZj6q/qBtD3keBnNcVIEfld/YDvMQrx3CUip
         pn0w==
X-Gm-Message-State: AC+VfDyZSIpAQwXygtkvMXmPL+fRQLmmLL3/KYZ4ze9K90P6ljhBOilI
        A1qmxKWtfXYFHKSwX5y89k5RDLjtm/fG25OujekSVA==
X-Google-Smtp-Source: ACHHUZ6yw6A9LT5KQ0IM2TL4O+4LveUckjZMTIyQKCOBlFMXKIWAT/Vq7U6GCPlCLWZN9p98qgeOkVVJjCH+qSayDa4=
X-Received: by 2002:a50:bb2a:0:b0:502:7e99:a1a7 with SMTP id
 y39-20020a50bb2a000000b005027e99a1a7mr130646ede.1.1686156773093; Wed, 07 Jun
 2023 09:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230606060822.1065182-1-usama.anjum@collabora.com>
 <20230606060822.1065182-3-usama.anjum@collabora.com> <CABb0KFGUSDwbMHQymCbPDwPiDit1+1JHbgTzzxXL04vQMUxo5w@mail.gmail.com>
 <0b8b19e7-fffa-aa1f-8479-e5a338780f7a@collabora.com>
In-Reply-To: <0b8b19e7-fffa-aa1f-8479-e5a338780f7a@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 7 Jun 2023 18:52:41 +0200
Message-ID: <CABb0KFHoYeOz7A6vAUqYDx8PkxjeujPrQRi+Y0YxkqQ_i4tTpA@mail.gmail.com>
Subject: Re: [PATCH v17 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 7 Jun 2023 at 18:13, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Micha=C5=82,
>
> Thank you for taking time to review!
>
> On 6/7/23 7:52=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 6 Jun 2023 at 08:08, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or cle=
ar
> >> the info about page table entries. The following operations are suppor=
ted
> >> in this ioctl:
> >> - Get the information if the pages have been written-to (PAGE_IS_WRITT=
EN),
> >>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
> >>   (PAGE_IS_SWAPPED).
> >> - Find pages which have been written-to and/or write protect the pages
> >>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
> >>
> >> This IOCTL can be extended to get information about more PTE bits.
> > [...]
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
[...]
> >> +static inline bool pagemap_scan_check_page_written(struct pagemap_sca=
n_private *p)
> >> +{
> >> +       return (p->required_mask | p->anyof_mask | p->excluded_mask) &
> >> +              PAGE_IS_WRITTEN;
> >> +}
> >
> > This could be precalculated and put as a flag into
> > pagemap_scan_private - it is kernel-private structure and there are a
> > few spare bits in `flags` if you'd prefer not to add an explicit
> > boolean.
> This inline function is only being used at one spot. I can remove the
> function altogether. I don't like putting it in flags. It'll bring some
> complexity.

The difference at the call site will be function call vs field access.
Do you mean that moving the function to where the struct is
initialized would add complexity? Why is that?

> > [...]
> >> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool sw=
ap,
> >> +                              struct pagemap_scan_private *p,
> >> +                              unsigned long addr, unsigned int n_page=
s)
> >> +{
> >> +       unsigned long bitmap =3D PM_SCAN_BITMAP(wt, file, pres, swap);
> >> +       struct page_region *cur =3D &p->cur;
> >> +
> >> +       if (!n_pages)
> >> +               return -EINVAL;
> >> +
> >> +       if ((p->required_mask & bitmap) !=3D p->required_mask)
> >> +               return 0;
> >> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
> >> +               return 0;
> >> +       if (p->excluded_mask & bitmap)
> >> +               return 0;
> >> +
> >> +       bitmap &=3D p->return_mask;
> >> +       if (!bitmap)
> >> +               return 0;
> >> +
> >> +       if (cur->bitmap =3D=3D bitmap &&
> >> +           cur->start + cur->len * PAGE_SIZE =3D=3D addr) {
> >> +               cur->len +=3D n_pages;
> >> +               p->found_pages +=3D n_pages;
> >> +       } else {
> >> +               /*
> >> +                * All data is copied to cur first. When more data is =
found, we
> >> +                * push cur to vec and copy new data to cur. The vec_i=
ndex
> >> +                * represents the current index of vec array. We add 1=
 to the
> >> +                * vec_index while performing checks to account for da=
ta in cur.
> >> +                */
> >> +               if (cur->len && (p->vec_index + 1) >=3D p->vec_len)
> >> +                       return -ENOSPC;
> >> +
> >> +               if (cur->len) {
> >> +                       memcpy(&p->vec[p->vec_index], cur, sizeof(*p->=
vec));
> >> +                       p->vec_index++;
> >> +               }
> >> +
> >> +               cur->start =3D addr;
> >> +               cur->len =3D n_pages;
> >> +               cur->bitmap =3D bitmap;
> >> +               p->found_pages +=3D n_pages;
> >> +       }
> >> +
> >> +       if (p->max_pages && (p->found_pages =3D=3D p->max_pages))
> >> +               return PM_SCAN_FOUND_MAX_PAGES;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> >> +                                 unsigned long end, struct mm_walk *w=
alk)
> >> +{
> >> +       struct pagemap_scan_private *p =3D walk->private;
> >> +       struct vm_area_struct *vma =3D walk->vma;
> >> +       unsigned long addr =3D end;
> >> +       pte_t *pte, *orig_pte;
> >> +       spinlock_t *ptl;
> >> +       bool is_written;
> >> +       int ret =3D 0;
> >> +
> >> +       arch_enter_lazy_mmu_mode();
> >> +
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> >> +       if (ptl) {
> >> +               unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> >> +
> >> +               if (p->max_pages && n_pages > p->max_pages - p->found_=
pages)
> >> +                       n_pages =3D p->max_pages - p->found_pages;
> >
> > Since p->found_pages is only ever increased in `pagemap_scan_output()`
> > and that function is only called for GET or GET+WP operations, maybe
> > the logic could be folded to pagemap_scan_output() to avoid
> > duplication?
> > In this function the calculation is used only when WP op is done to
> > split the HP if n_pages limit would be hit, but if using plain WP
> > (without GET) it doesn't make sense to use the limit.
> The n_pages is needed to decide if THP need to be broken down and it is
> used in pagemap_scan_output(). I've brought this condition out of
> pagemap_scan_output() to cater this former condition. If I move it to
> pagemap_scan_output(), I'll have to write same condition to find out if I
> need to breakt he THP. This seems like repetition, but we have same use
> case for tlbhuge page.

My point is that you need to split the THP only if doing a GET+WP
operation. If you only do GET, then the worst case would be for the
process to report a spurious WRITTEN bit if an earlier-visited part of
THP was modified and the scan restarted in the middle of a THP.

>> > (pagemap_scan_output() is trivial enough so I think it could be pulled
> > inside the spinlocked region.)
> It is already in spinlocked region. Spin lock is being released after tlb
> flush.

Ah, I was thinking about calling pagemap_scan_output() before checking
split_huge_pmd() case - and at that use the pagemap_scan_output()'s
return value to do the check.

> >> +               is_written =3D !is_pmd_uffd_wp(*pmd);
> >> +
> >> +               /*
> >> +                * Break huge page into small pages if the WP operatio=
n need to
> >> +                * be performed is on a portion of the huge page.
> >> +                */
> >> +               if (is_written && IS_PM_SCAN_WP(p->flags) &&
> >> +                   n_pages < HPAGE_SIZE/PAGE_SIZE) {
> >> +                       spin_unlock(ptl);
> >> +
> >> +                       split_huge_pmd(vma, pmd, start);
> >> +                       goto process_smaller_pages;
> >> +               }
> >> +
> >> +               if (IS_PM_SCAN_GET(p->flags))
> >> +                       ret =3D pagemap_scan_output(is_written, vma->v=
m_file,
> >> +                                                 pmd_present(*pmd),
> >> +                                                 is_swap_pmd(*pmd),
> >> +                                                 p, start, n_pages);
> >> +
> >> +               if (ret >=3D 0 && is_written && IS_PM_SCAN_WP(p->flags=
))
> >> +                       make_uffd_wp_pmd(vma, addr, pmd);
> >> +
> >> +               if (IS_PM_SCAN_WP(p->flags))
> >
> > Why `is_written` is not checked? If is_written is false, then the WP
> > op should be a no-op and so won't need TLB flushing, will it? [Same
> > for the PTE case below.]
> It can be done for THP. But for ptes we cannot trust is_written as
> is_written only represent last pte state.

Ok, so the PTE case could use a flag recording whether any PTE had WP
applied instead of `is_written`.

> >> +                       flush_tlb_range(vma, start, end);
> >> +
> > [...]
> >> +       if (IS_PM_SCAN_WP(p->flags))
> >> +               flush_tlb_range(vma, start, addr);
> >> +
> >> +       pte_unmap_unlock(orig_pte, ptl);
> >> +       arch_leave_lazy_mmu_mode();
> >> +
> >> +       cond_resched();
> >> +       return ret;
> >> +}
> >> +
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
> >> +       struct hstate *h =3D hstate_vma(vma);
> >> +       spinlock_t *ptl;
> >> +       bool is_written;
> >> +       int ret =3D 0;
> >> +       pte_t pte;
> >> +
> >> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> >> +               n_pages =3D p->max_pages - p->found_pages;
> >> +
> >> +       if (IS_PM_SCAN_WP(p->flags)) {
> >> +               i_mmap_lock_write(vma->vm_file->f_mapping);
> >> +               ptl =3D huge_pte_lock(h, vma->vm_mm, ptep);
> >> +       }
> >> +
> >> +       pte =3D huge_ptep_get(ptep);
> >> +       is_written =3D !is_huge_pte_uffd_wp(pte);
> >> +
> >> +       /*
> >> +        * Partial hugetlb page clear isn't supported
> >> +        */
> >> +       if (is_written && IS_PM_SCAN_WP(p->flags) &&
> >> +           n_pages < HPAGE_SIZE/PAGE_SIZE) {
> >> +               ret =3D -EPERM;
> >
> > Shouldn't this be ENOSPC, conveying that the operation would overflow
> > the n_pages limit?
> We are testing here is user has asked us to engage WP on a part of the
> hugetlb or we can only perform WP on a part of the engage as user buffer =
is
> full. We cannot judge this has happened because of the former or later
> condition. So I'm assuming that user's parameters aren't solid enough and
> returning -EPERM. It seemed more suitable to me. But I can return -ENOSPC
> as well, if you say?

Those two cases can be differentiated when checked before truncating
n_pages. If a user requests partial WP for a hugetlb page wouldn't
EINVAL (or other error - as this can't ever work) be more appropriate
(this check could happen only at the start of scan)? If the request is
due to max_pages limit (with found_pages > 0), then I'd return ENOSPC
and expect the user to restart the scan with a new buffer.

Our discussion here makes me wonder: what is the expected return value
for the ioctl WP (without GET) operation? If it would return e.g. the
number of 4K-pages successfully scanned, then the caller would be able
to detect the partial tail hugepage case and act accordingly.

> >> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long en=
d,
> >> +                                int depth, struct mm_walk *walk)
> >> +{
> >> +       unsigned long n_pages =3D (end - addr)/PAGE_SIZE;
> >> +       struct pagemap_scan_private *p =3D walk->private;
> >> +       struct vm_area_struct *vma =3D walk->vma;
> >> +       int ret =3D 0;
> >> +
> >> +       if (!vma || !IS_PM_SCAN_GET(p->flags))
> >> +               return 0;
> >> +
> >> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> >> +               n_pages =3D p->max_pages - p->found_pages;
> >
> > Nit: If the page flags don't match (wouldn't be output), the limit
> > would not be hit and the calculation is unnecessary. But if it was
> > done in pagemap_scan_output() instead after all the flags checks...
> Correct for this use case. But moving to pagemap_scan_output() would make
> me do duplicate calculation for other 2 cases as explained above.

(responded below the cases above)

> >> +       ret =3D pagemap_scan_output(false, vma->vm_file, false, false,=
 p, addr,
> >> +                                 n_pages);
> >> +
> >> +       return ret;
> >> +}
> > [...]
> >> +static long do_pagemap_scan(struct mm_struct *mm,
> >> +                           struct pm_scan_arg __user *uarg)
> >> +{
> >> +       unsigned long start, end, walk_start, walk_end;
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
> >> +       vec =3D (struct page_region *)untagged_addr((unsigned long)arg=
.vec);
> >> +
> >> +       ret =3D pagemap_scan_args_valid(&arg, start, vec);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       end =3D start + arg.len;
> >> +       p.max_pages =3D arg.max_pages;
> >> +       p.found_pages =3D 0;
> >> +       p.flags =3D arg.flags;
> >> +       p.required_mask =3D arg.required_mask;
> >> +       p.anyof_mask =3D arg.anyof_mask;
> >> +       p.excluded_mask =3D arg.excluded_mask;
> >> +       p.return_mask =3D arg.return_mask;
> >> +       p.cur.start =3D p.cur.len =3D p.cur.bitmap =3D 0;
> >> +       p.vec =3D NULL;
> >> +       p.vec_len =3D PAGEMAP_WALK_SIZE >> PAGE_SHIFT;
> >
> > If p.vec_len would not count the entry held in `cur` (IOW: vec_len =3D
> > WALK_SIZE - 1), then pagemap_scan_output() wouldn't need the big
> > comment about adding or subtracting 1 when checking for overflow. The
> > output vector needs to have space for at least one entrry to make GET
> > useful. Maybe `cur` could be renamed or annotated to express that it
> > always holds the last entry?
> Ohhh.. This can be done by doing subtracting 1 from empty_slots. But I've
> explored the idea. I don't see any benefit. If we do this, then I'll have
> to put a comment why subtracting 1 is needed. Seems like same problem:
>
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1909,7 +1909,7 @@ static int pagemap_scan_output(bool wt, bool file,
> bool pres, bool swap,
>                  * represents the current index of vec array. We add 1 to=
 the
>                  * vec_index while performing checks to account for data =
in
> cur.
>                  */
> -               if (cur->len && (p->vec_index + 1) >=3D p->vec_len)
> +               if (cur->len && p->vec_index >=3D p->vec_len)
>                         return -ENOSPC;
>
>                 if (cur->len) {
> @@ -2202,7 +2202,7 @@ static long do_pagemap_scan(struct mm_struct *mm,
>                 if (IS_PM_SCAN_GET(p.flags)) {
>                         p.vec_index =3D 0;
>
> -                       empty_slots =3D arg.vec_len - vec_index;
> +                       empty_slots =3D arg.vec_len - 1 - vec_index;
>                         p.vec_len =3D min(p.vec_len, empty_slots);
>                 }
>
> Lets leave it as it is. I can change `cur` to `last` or any other name.
> Please suggest.

The difference is that you have the subtraction only once per the
outer page_walk loop iteration, but in the current version the
addition has to happen every pagemap_scan_output() call after a hole.

From the readability perspective, "if (next_index >=3D vec_len)" is
short and self-documenting. Also I'd use "p.vec_len =3D min(p.vec_len,
empty_slots - 1)" as it also conveys the intent better (in that `vec`
is holding all but the last entry, but arg.vec_len holds the final
output buffer length).

If we're picking colors, then maybe make `arg.vec_len` have a
different name than `p.vec_len` (same for `vec_index`) so that there
is less confusion possible as to what they refer to. Maybe keep
`arg.vec_len`, but have `p.vec_buf`, `p.vec_buf_len`, and
`p.next_buf_index`?

(Note: you'd also need to decrement p.vec_len where it is first assigned.)

[...]
Best Regards
Micha=C5=82 Miros=C5=82aw
