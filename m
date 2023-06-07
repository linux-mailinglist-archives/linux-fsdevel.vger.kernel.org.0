Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC40E72635A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjFGOxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbjFGOxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:53:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC21BDD
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 07:53:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so9513a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686149585; x=1688741585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a7arGbwRESChqwYt5SMynjhqmAQ0Pvl0NJIjD6VxSs=;
        b=bXgIViNBJeQbkH5t3badUy+1tgMHK2q2IDtIVnB9eEA7Hz7CSiRLfmqMVjtg0ZLUTS
         HlB/0lUMHmj9epZEtccnOw84i61Rz2CUsaxXZygxAi4CtZj/LNH8Fr6btJtipxgY25SW
         ZFuQ5A1ofJMkN8ToWlgSqp4mHRf6l8908xDWDVbuyjeAAW89Otb0bDPk0075GZC2Dhc8
         5MzAXVOGqngopxxTWVqvDGVfa17mUJgKUIo50OE9kloR/qd6DmM3r4JYsHMrK0itmLMV
         08s0KjfuCiGYtZ3oSRbAwSDWL3bL1BesfO9wmSKnCgE58iHhn9JDaxsre/mdq2JDc05c
         sN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149585; x=1688741585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a7arGbwRESChqwYt5SMynjhqmAQ0Pvl0NJIjD6VxSs=;
        b=OEIMfa7bNE94e7615zelWW0iHRlIQuJQmBziVIe50JQJUeJBz/w1v9fUihX3W8GXHL
         EqTJVPkxmKosv1vJK8IZsqOZdQupk2TgSj/5hmdSWw4DcgjnAZ9pXW2XkdB8U7K1mAAk
         Uqzfbcy2xOHrX6FIPXGZr4nXaTCQLDNww3YXzLWPmMzD7384Yc2c2tdmh7u34MrWOlBx
         WXpaIB+Pl07+QWvxEsh87mFvIFltAb1BeUiH6D8NG/zzbatfV1OF9MDPkEJ87nwMIhQs
         Bvy8YxW25rMzchy+2kjdF65oelKh8oJT0d8xm/RaRpkSUXDeuM6FpqkJXY2Er/x+aDhh
         rr3A==
X-Gm-Message-State: AC+VfDwtoXGai64Y9YxImZgjPFKvczRfwOjglCtcC9EERLhjpbmgm595
        4Cxq+Nfk4jCLdQK8PxizttPhE0PgeVjZ0gjAFlsdFA==
X-Google-Smtp-Source: ACHHUZ4VkU4pTZ74qRZpgUZgIm2LZXRRMWlJHqKisze2T0S3N9eI4j4Cpqj2awqGey+GxLJlZduOpnmyE0BOCWbET9I=
X-Received: by 2002:a50:d6cf:0:b0:514:95d4:c2bb with SMTP id
 l15-20020a50d6cf000000b0051495d4c2bbmr136575edj.2.1686149584902; Wed, 07 Jun
 2023 07:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230606060822.1065182-1-usama.anjum@collabora.com> <20230606060822.1065182-3-usama.anjum@collabora.com>
In-Reply-To: <20230606060822.1065182-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 7 Jun 2023 16:52:53 +0200
Message-ID: <CABb0KFGUSDwbMHQymCbPDwPiDit1+1JHbgTzzxXL04vQMUxo5w@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 6 Jun 2023 at 08:08, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have been written-to (PAGE_IS_WRITTEN)=
,
>   file mapped (PAGE_IS_FILE), present (PAGE_IS_PRESENT) or swapped
>   (PAGE_IS_SWAPPED).
> - Find pages which have been written-to and/or write protect the pages
>   (atomic PM_SCAN_OP_GET + PM_SCAN_OP_WP)
>
> This IOCTL can be extended to get information about more PTE bits.
[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline bool is_pmd_uffd_wp(pmd_t pmd)
> +{
> +       return (pmd_present(pmd) && pmd_uffd_wp(pmd)) ||
> +              (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd));
> +}
[...]
> +#ifdef CONFIG_HUGETLB_PAGE
> +static inline bool is_huge_pte_uffd_wp(pte_t pte)
> +{
> +       return ((pte_present(pte) && huge_pte_uffd_wp(pte)) ||
> +              pte_swp_uffd_wp_any(pte));

Nit: please remove the outer parentheses (it is already done for
similar finctuons above).

> +}

> +static inline bool pagemap_scan_check_page_written(struct pagemap_scan_p=
rivate *p)
> +{
> +       return (p->required_mask | p->anyof_mask | p->excluded_mask) &
> +              PAGE_IS_WRITTEN;
> +}

This could be precalculated and put as a flag into
pagemap_scan_private - it is kernel-private structure and there are a
few spare bits in `flags` if you'd prefer not to add an explicit
boolean.

[...]
> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
> +                              struct pagemap_scan_private *p,
> +                              unsigned long addr, unsigned int n_pages)
> +{
> +       unsigned long bitmap =3D PM_SCAN_BITMAP(wt, file, pres, swap);
> +       struct page_region *cur =3D &p->cur;
> +
> +       if (!n_pages)
> +               return -EINVAL;
> +
> +       if ((p->required_mask & bitmap) !=3D p->required_mask)
> +               return 0;
> +       if (p->anyof_mask && !(p->anyof_mask & bitmap))
> +               return 0;
> +       if (p->excluded_mask & bitmap)
> +               return 0;
> +
> +       bitmap &=3D p->return_mask;
> +       if (!bitmap)
> +               return 0;
> +
> +       if (cur->bitmap =3D=3D bitmap &&
> +           cur->start + cur->len * PAGE_SIZE =3D=3D addr) {
> +               cur->len +=3D n_pages;
> +               p->found_pages +=3D n_pages;
> +       } else {
> +               /*
> +                * All data is copied to cur first. When more data is fou=
nd, we
> +                * push cur to vec and copy new data to cur. The vec_inde=
x
> +                * represents the current index of vec array. We add 1 to=
 the
> +                * vec_index while performing checks to account for data =
in cur.
> +                */
> +               if (cur->len && (p->vec_index + 1) >=3D p->vec_len)
> +                       return -ENOSPC;
> +
> +               if (cur->len) {
> +                       memcpy(&p->vec[p->vec_index], cur, sizeof(*p->vec=
));
> +                       p->vec_index++;
> +               }
> +
> +               cur->start =3D addr;
> +               cur->len =3D n_pages;
> +               cur->bitmap =3D bitmap;
> +               p->found_pages +=3D n_pages;
> +       }
> +
> +       if (p->max_pages && (p->found_pages =3D=3D p->max_pages))
> +               return PM_SCAN_FOUND_MAX_PAGES;
> +
> +       return 0;
> +}
> +
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +                                 unsigned long end, struct mm_walk *walk=
)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long addr =3D end;
> +       pte_t *pte, *orig_pte;
> +       spinlock_t *ptl;
> +       bool is_written;
> +       int ret =3D 0;
> +
> +       arch_enter_lazy_mmu_mode();
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> +       if (ptl) {
> +               unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> +
> +               if (p->max_pages && n_pages > p->max_pages - p->found_pag=
es)
> +                       n_pages =3D p->max_pages - p->found_pages;

Since p->found_pages is only ever increased in `pagemap_scan_output()`
and that function is only called for GET or GET+WP operations, maybe
the logic could be folded to pagemap_scan_output() to avoid
duplication?
In this function the calculation is used only when WP op is done to
split the HP if n_pages limit would be hit, but if using plain WP
(without GET) it doesn't make sense to use the limit.
(pagemap_scan_output() is trivial enough so I think it could be pulled
inside the spinlocked region.)

> +
> +               is_written =3D !is_pmd_uffd_wp(*pmd);
> +
> +               /*
> +                * Break huge page into small pages if the WP operation n=
eed to
> +                * be performed is on a portion of the huge page.
> +                */
> +               if (is_written && IS_PM_SCAN_WP(p->flags) &&
> +                   n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +                       spin_unlock(ptl);
> +
> +                       split_huge_pmd(vma, pmd, start);
> +                       goto process_smaller_pages;
> +               }
> +
> +               if (IS_PM_SCAN_GET(p->flags))
> +                       ret =3D pagemap_scan_output(is_written, vma->vm_f=
ile,
> +                                                 pmd_present(*pmd),
> +                                                 is_swap_pmd(*pmd),
> +                                                 p, start, n_pages);
> +
> +               if (ret >=3D 0 && is_written && IS_PM_SCAN_WP(p->flags))
> +                       make_uffd_wp_pmd(vma, addr, pmd);
> +
> +               if (IS_PM_SCAN_WP(p->flags))

Why `is_written` is not checked? If is_written is false, then the WP
op should be a no-op and so won't need TLB flushing, will it? [Same
for the PTE case below.]

> +                       flush_tlb_range(vma, start, end);
> +
[...]
> +       if (IS_PM_SCAN_WP(p->flags))
> +               flush_tlb_range(vma, start, addr);
> +
> +       pte_unmap_unlock(orig_pte, ptl);
> +       arch_leave_lazy_mmu_mode();
> +
> +       cond_resched();
> +       return ret;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
> +                                     unsigned long start, unsigned long =
end,
> +                                     struct mm_walk *walk)
> +{
> +       unsigned long n_pages =3D (end - start)/PAGE_SIZE;
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       struct hstate *h =3D hstate_vma(vma);
> +       spinlock_t *ptl;
> +       bool is_written;
> +       int ret =3D 0;
> +       pte_t pte;
> +
> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> +               n_pages =3D p->max_pages - p->found_pages;
> +
> +       if (IS_PM_SCAN_WP(p->flags)) {
> +               i_mmap_lock_write(vma->vm_file->f_mapping);
> +               ptl =3D huge_pte_lock(h, vma->vm_mm, ptep);
> +       }
> +
> +       pte =3D huge_ptep_get(ptep);
> +       is_written =3D !is_huge_pte_uffd_wp(pte);
> +
> +       /*
> +        * Partial hugetlb page clear isn't supported
> +        */
> +       if (is_written && IS_PM_SCAN_WP(p->flags) &&
> +           n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +               ret =3D -EPERM;

Shouldn't this be ENOSPC, conveying that the operation would overflow
the n_pages limit?

> +               goto unlock_and_return;
> +       }
> +
> +       if (IS_PM_SCAN_GET(p->flags)) {
> +               ret =3D pagemap_scan_output(is_written, vma->vm_file,
> +                                         pte_present(pte), is_swap_pte(p=
te),
> +                                         p, start, n_pages);
> +               if (ret < 0)
> +                       goto unlock_and_return;
> +       }
> +
> +       if (is_written && IS_PM_SCAN_WP(p->flags)) {

Oh, this case does check `is_written` before flushing TLB, contrary to
what the cases above do.

> +               make_uffd_wp_huge_pte(vma, start, ptep, pte);
> +               flush_hugetlb_tlb_range(vma, start, end);
> +       }
> +
> +unlock_and_return:
> +       if (IS_PM_SCAN_WP(p->flags)) {
> +               spin_unlock(ptl);
> +               i_mmap_unlock_write(vma->vm_file->f_mapping);
> +       }
> +
> +       return ret;
> +}
> +#else
> +#define pagemap_scan_hugetlb_entry NULL
> +#endif
> +
> +static int pagemap_scan_pte_hole(unsigned long addr, unsigned long end,
> +                                int depth, struct mm_walk *walk)
> +{
> +       unsigned long n_pages =3D (end - addr)/PAGE_SIZE;
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       int ret =3D 0;
> +
> +       if (!vma || !IS_PM_SCAN_GET(p->flags))
> +               return 0;
> +
> +       if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> +               n_pages =3D p->max_pages - p->found_pages;

Nit: If the page flags don't match (wouldn't be output), the limit
would not be hit and the calculation is unnecessary. But if it was
done in pagemap_scan_output() instead after all the flags checks...

> +       ret =3D pagemap_scan_output(false, vma->vm_file, false, false, p,=
 addr,
> +                                 n_pages);
> +
> +       return ret;
> +}
[...]
> +static long do_pagemap_scan(struct mm_struct *mm,
> +                           struct pm_scan_arg __user *uarg)
> +{
> +       unsigned long start, end, walk_start, walk_end;
> +       unsigned long empty_slots, vec_index =3D 0;
> +       struct mmu_notifier_range range;
> +       struct page_region __user *vec;
> +       struct pagemap_scan_private p;
> +       struct pm_scan_arg arg;
> +       int ret =3D 0;
> +
> +       if (copy_from_user(&arg, uarg, sizeof(arg)))
> +               return -EFAULT;
> +
> +       start =3D untagged_addr((unsigned long)arg.start);
> +       vec =3D (struct page_region *)untagged_addr((unsigned long)arg.ve=
c);
> +
> +       ret =3D pagemap_scan_args_valid(&arg, start, vec);
> +       if (ret)
> +               return ret;
> +
> +       end =3D start + arg.len;
> +       p.max_pages =3D arg.max_pages;
> +       p.found_pages =3D 0;
> +       p.flags =3D arg.flags;
> +       p.required_mask =3D arg.required_mask;
> +       p.anyof_mask =3D arg.anyof_mask;
> +       p.excluded_mask =3D arg.excluded_mask;
> +       p.return_mask =3D arg.return_mask;
> +       p.cur.start =3D p.cur.len =3D p.cur.bitmap =3D 0;
> +       p.vec =3D NULL;
> +       p.vec_len =3D PAGEMAP_WALK_SIZE >> PAGE_SHIFT;

If p.vec_len would not count the entry held in `cur` (IOW: vec_len =3D
WALK_SIZE - 1), then pagemap_scan_output() wouldn't need the big
comment about adding or subtracting 1 when checking for overflow. The
output vector needs to have space for at least one entrry to make GET
useful. Maybe `cur` could be renamed or annotated to express that it
always holds the last entry?

> +
> +       /*
> +        * Allocate smaller buffer to get output from inside the page wal=
k
> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks=
. As
> +        * we want to return output to user in compact form where no two
> +        * consecutive regions should be continuous and have the same fla=
gs.
> +        * So store the latest element in p.cur between different walks a=
nd
> +        * store the p.cur at the end of the walk to the user buffer.
> +        */
> +       if (IS_PM_SCAN_GET(p.flags)) {
> +               p.vec =3D kmalloc_array(p.vec_len, sizeof(*p.vec), GFP_KE=
RNEL);
> +               if (!p.vec)
> +                       return -ENOMEM;
> +       }
> +
> +       if (IS_PM_SCAN_WP(p.flags)) {
> +               mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_VMA=
, 0,
> +                                       mm, start, end);
> +               mmu_notifier_invalidate_range_start(&range);
> +       }
> +
> +       walk_start =3D walk_end =3D start;
> +       while (walk_end < end && !ret) {
> +               if (IS_PM_SCAN_GET(p.flags)) {
> +                       p.vec_index =3D 0;
> +
> +                       empty_slots =3D arg.vec_len - vec_index;

Can `empty_slots` be zero here? I don't see anything prohibiting this case.

> +                       p.vec_len =3D min(p.vec_len, empty_slots);

( If not counting `cur`, it would be min(p.vec_len, empty_slots - 1); )

> +               }
> +
> +               walk_end =3D (walk_start + PAGEMAP_WALK_SIZE) & PAGEMAP_W=
ALK_MASK;
> +               if (walk_end > end)
> +                       walk_end =3D end;
> +
> +               ret =3D mmap_read_lock_killable(mm);
> +               if (ret)
> +                       goto free_data;
> +               ret =3D walk_page_range(mm, walk_start, walk_end,
> +                                     &pagemap_scan_ops, &p);
> +               mmap_read_unlock(mm);
> +
> +               if (ret && ret !=3D -ENOSPC && ret !=3D PM_SCAN_FOUND_MAX=
_PAGES)
> +                       goto free_data;
> +
> +               walk_start =3D walk_end;
> +               if (IS_PM_SCAN_GET(p.flags) && p.vec_index) {
> +                       if (copy_to_user(&vec[vec_index], p.vec,
> +                                        p.vec_index * sizeof(*p.vec))) {
> +                               /*
> +                                * Return error even though the OP succee=
ded
> +                                */
> +                               ret =3D -EFAULT;
> +                               goto free_data;
> +                       }
> +                       vec_index +=3D p.vec_index;
> +               }
> +       }
> +
> +       if (IS_PM_SCAN_GET(p.flags) && p.cur.len) {

Nit: p.cur.len can be non-zero only if we do a GET (or GET+WP) operation.

> +               if (copy_to_user(&vec[vec_index], &p.cur, sizeof(*p.vec))=
) {

Nit: sizeof(*p.cur); (even though this is the same type)

> +                       ret =3D -EFAULT;
> +                       goto free_data;
> +               }
> +               vec_index++;
> +       }
> +
> +       ret =3D vec_index;
> +
> +free_data:
> +       if (IS_PM_SCAN_WP(p.flags))
> +               mmu_notifier_invalidate_range_end(&range);
> +
> +       kfree(p.vec);
> +       return ret;
> +}
> +
> +static long do_pagemap_cmd(struct file *file, unsigned int cmd,
> +                          unsigned long arg)
> +{
> +       struct pm_scan_arg __user *uarg =3D (struct pm_scan_arg __user *)=
arg;

The cast should be in do_pagemap_scan() as if there comes another
`cmd`, then it might use a different argument type.

> +       struct mm_struct *mm =3D file->private_data;
> +
> +       switch (cmd) {
> +       case PAGEMAP_SCAN:
> +               return do_pagemap_scan(mm, uarg);
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}

Best Regards
Micha=C5=82 Miros=C5=82aw
