Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18577B0B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjI0SIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjI0SIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:08:06 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06286E5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 11:08:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59b5484fbe6so145599497b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695838082; x=1696442882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MbbJwVcDVc6ilMgG+HaZre9uVeLJcrMIu8nlaztDFM=;
        b=YvFe6Yh63pwDIYxcCUXG1wOI9NjyInf49ZG/Csu5iwjTiTVfya7E0uMnVHtejzgcwK
         twW6hdGrO4LSWP71tMzc4Aajz/uUsOCldlZ87zpDroqFxtyw5m3jY14MeUvJvTKc6yBd
         mP26sijPsFfCiEagKe/KMfNzPTFoGfb8H1dUx2bfIKViXQ5JjpFPEusvQYpufwi6e4iq
         mLDpADssv32F3qhI4rUyFeN9sy2AKmP/mP6Z1k4qSN6wCwWdG2p8T9Kus6FkdmqbWQM2
         TG6KJjbUR45r9k5XHsFj9TazCgh3bDS4NHes/YmK55lxb9uGpTBLvmoE8coBvhunajeM
         7y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695838082; x=1696442882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MbbJwVcDVc6ilMgG+HaZre9uVeLJcrMIu8nlaztDFM=;
        b=ELKwTWi4la0vXDbabj7YeZdJTG595eUtVS73fEuYDCUl6XQVVA9czbmPrsXELm0Ltz
         6aeZmp9Sohfp94X3bTSDIGPO4gkiMSJ0yYiT3vmdydoXdO/kOhgh4w7K3r1Fc7O7HqSb
         QkH/v+P/D2C57Opm44ssNd8eFy/Na6WXPwtGzNP/L5v4g6qK+IUA2OEkz4xI9Ty4hVgJ
         0RatNLg6I9NvKLl3FYZBnjC0qzZqdIEym/RitsUdkuebMdPJdtu5vx8H2NeyfcX6kflB
         5h03HpoFU1vdF5xbYJf63ttpCHv1DV151o/PyONRYfFPZyj8/62u0ca6Vy90ZB2O+8uw
         69FA==
X-Gm-Message-State: AOJu0YyJQm92hziLESIZjPO08kcxtTQoUje7LvvUzhOEPvWl8c8YOAgv
        EhsUxjlPZGWcjYN2GX4429ZbVIhCqTY5MTvCIVbofg==
X-Google-Smtp-Source: AGHT+IEDzDtmtU4I5mGQOzPAeXdvSgidEo/k8Vc6fZQwvMn/VYLLkYv+U/mGg6INd5Seyp/KvxP+xm5ScvK16M+SCas=
X-Received: by 2002:a81:85c1:0:b0:57a:cf8:5b4 with SMTP id v184-20020a8185c1000000b0057a0cf805b4mr2780885ywf.51.1695838081777;
 Wed, 27 Sep 2023 11:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
In-Reply-To: <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Sep 2023 11:07:48 -0700
Message-ID: <CAJuCfpGb5Amo9Sk0yyruJt9NKaYe9-y+5jmU442NSf3+VT5-dA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Jann Horn <jannh@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Wed, Sep 27, 2023 at 5:47=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > This implements the uABI of UFFDIO_REMAP.
> >
> > Notably one mode bitflag is also forwarded (and in turn known) by the
> > lowlevel remap_pages method.
> >
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> [...]
> > +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *s=
rc_mm,
> > +                        pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdv=
al,
> > +                        struct vm_area_struct *dst_vma,
> > +                        struct vm_area_struct *src_vma,
> > +                        unsigned long dst_addr, unsigned long src_addr=
)
> > +{
> > +       pmd_t _dst_pmd, src_pmdval;
> > +       struct page *src_page;
> > +       struct folio *src_folio;
> > +       struct anon_vma *src_anon_vma, *dst_anon_vma;
> > +       spinlock_t *src_ptl, *dst_ptl;
> > +       pgtable_t src_pgtable, dst_pgtable;
> > +       struct mmu_notifier_range range;
> > +       int err =3D 0;
> > +
> > +       src_pmdval =3D *src_pmd;
> > +       src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> > +
> > +       BUG_ON(!spin_is_locked(src_ptl));
> > +       mmap_assert_locked(src_mm);
> > +       mmap_assert_locked(dst_mm);
> > +
> > +       BUG_ON(!pmd_trans_huge(src_pmdval));
> > +       BUG_ON(!pmd_none(dst_pmdval));
> > +       BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> > +       BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> > +
> > +       src_page =3D pmd_page(src_pmdval);
> > +       if (unlikely(!PageAnonExclusive(src_page))) {
> > +               spin_unlock(src_ptl);
> > +               return -EBUSY;
> > +       }
> > +
> > +       src_folio =3D page_folio(src_page);
> > +       folio_get(src_folio);
> > +       spin_unlock(src_ptl);
> > +
> > +       /* preallocate dst_pgtable if needed */
> > +       if (dst_mm !=3D src_mm) {
> > +               dst_pgtable =3D pte_alloc_one(dst_mm);
> > +               if (unlikely(!dst_pgtable)) {
> > +                       err =3D -ENOMEM;
> > +                       goto put_folio;
> > +               }
> > +       } else {
> > +               dst_pgtable =3D NULL;
> > +       }
> > +
> > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, sr=
c_addr,
> > +                               src_addr + HPAGE_PMD_SIZE);
> > +       mmu_notifier_invalidate_range_start(&range);
> > +
> > +       /* block all concurrent rmap walks */
> > +       folio_lock(src_folio);
> > +
> > +       /*
> > +        * split_huge_page walks the anon_vma chain without the page
> > +        * lock. Serialize against it with the anon_vma lock, the page
> > +        * lock is not enough.
> > +        */
> > +       src_anon_vma =3D folio_get_anon_vma(src_folio);
> > +       if (!src_anon_vma) {
> > +               err =3D -EAGAIN;
> > +               goto unlock_folio;
> > +       }
> > +       anon_vma_lock_write(src_anon_vma);
> > +
> > +       dst_ptl =3D pmd_lockptr(dst_mm, dst_pmd);
> > +       double_pt_lock(src_ptl, dst_ptl);
> > +       if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> > +                    !pmd_same(*dst_pmd, dst_pmdval) ||
> > +                    folio_mapcount(src_folio) !=3D 1)) {
>
> I think this is also supposed to be PageAnonExclusive()?

Yes. Will fix.

>
> > +               double_pt_unlock(src_ptl, dst_ptl);
> > +               err =3D -EAGAIN;
> > +               goto put_anon_vma;
> > +       }
> > +
> > +       BUG_ON(!folio_test_head(src_folio));
> > +       BUG_ON(!folio_test_anon(src_folio));
> > +
> > +       dst_anon_vma =3D (void *)dst_vma->anon_vma + PAGE_MAPPING_ANON;
> > +       WRITE_ONCE(src_folio->mapping, (struct address_space *) dst_ano=
n_vma);
> > +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_add=
r));
> > +
> > +       src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr, src_pmd=
);
> > +       _dst_pmd =3D mk_huge_pmd(&src_folio->page, dst_vma->vm_page_pro=
t);
> > +       _dst_pmd =3D maybe_pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
> > +       set_pmd_at(dst_mm, dst_addr, dst_pmd, _dst_pmd);
> > +
> > +       src_pgtable =3D pgtable_trans_huge_withdraw(src_mm, src_pmd);
> > +       if (dst_pgtable) {
> > +               pgtable_trans_huge_deposit(dst_mm, dst_pmd, dst_pgtable=
);
> > +               pte_free(src_mm, src_pgtable);
> > +               dst_pgtable =3D NULL;
> > +
> > +               mm_inc_nr_ptes(dst_mm);
> > +               mm_dec_nr_ptes(src_mm);
> > +               add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> > +               add_mm_counter(src_mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +       } else {
> > +               pgtable_trans_huge_deposit(dst_mm, dst_pmd, src_pgtable=
);
> > +       }
> > +       double_pt_unlock(src_ptl, dst_ptl);
> > +
> > +put_anon_vma:
> > +       anon_vma_unlock_write(src_anon_vma);
> > +       put_anon_vma(src_anon_vma);
> > +unlock_folio:
> > +       /* unblock rmap walks */
> > +       folio_unlock(src_folio);
> > +       mmu_notifier_invalidate_range_end(&range);
> > +       if (dst_pgtable)
> > +               pte_free(dst_mm, dst_pgtable);
> > +put_folio:
> > +       folio_put(src_folio);
> > +
> > +       return err;
> > +}
> > +#endif /* CONFIG_USERFAULTFD */
> [...]
> > +static int remap_anon_pte(struct mm_struct *dst_mm, struct mm_struct *=
src_mm,
> > +                         struct vm_area_struct *dst_vma,
> > +                         struct vm_area_struct *src_vma,
> > +                         unsigned long dst_addr, unsigned long src_add=
r,
> > +                         pte_t *dst_pte, pte_t *src_pte,
> > +                         pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                         spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                         struct folio *src_folio)
> > +{
> > +       struct anon_vma *dst_anon_vma;
> > +
> > +       double_pt_lock(dst_ptl, src_ptl);
> > +
> > +       if (!pte_same(*src_pte, orig_src_pte) ||
> > +           !pte_same(*dst_pte, orig_dst_pte) ||
> > +           folio_test_large(src_folio) ||
> > +           folio_estimated_sharers(src_folio) !=3D 1) {
> > +               double_pt_unlock(dst_ptl, src_ptl);
> > +               return -EAGAIN;
> > +       }
> > +
> > +       BUG_ON(!folio_test_anon(src_folio));
> > +
> > +       dst_anon_vma =3D (void *)dst_vma->anon_vma + PAGE_MAPPING_ANON;
> > +       WRITE_ONCE(src_folio->mapping,
> > +                  (struct address_space *) dst_anon_vma);
> > +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
> > +                                                     dst_addr));
> > +
> > +       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> > +       orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_prot=
);
> > +       orig_dst_pte =3D maybe_mkwrite(pte_mkdirty(orig_dst_pte),
> > +                                    dst_vma);
>
> I think there's still a theoretical issue here that you could fix by
> checking for the AnonExclusive flag, similar to the huge page case.
>
> Consider the following scenario:
>
> 1. process P1 does a write fault in a private anonymous VMA, creating
> and mapping a new anonymous page A1
> 2. process P1 forks and creates two children P2 and P3. afterwards, A1
> is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
> 3. process P1 removes its mapping of A1, dropping its mapcount to 2.
> 4. process P2 uses vmsplice() to grab a reference to A1 with get_user_pag=
es()
> 5. process P2 removes its mapping of A1, dropping its mapcount to 1.
>
> If at this point P3 does a write fault on its mapping of A1, it will
> still trigger copy-on-write thanks to the AnonExclusive mechanism; and
> this is necessary to avoid P3 mapping A1 as writable and writing data
> into it that will become visible to P2, if P2 and P3 are in different
> security contexts.
>
> But if P3 instead moves its mapping of A1 to another address with
> remap_anon_pte() which only does a page mapcount check, the
> maybe_mkwrite() will directly make the mapping writable, circumventing
> the AnonExclusive mechanism.

I see. Thanks for the detailed explanation! I will add
PageAnonExclusive() check in this path to prevent this scenario.

>
> > +       set_pte_at(dst_mm, dst_addr, dst_pte, orig_dst_pte);
> > +
> > +       if (dst_mm !=3D src_mm) {
> > +               inc_mm_counter(dst_mm, MM_ANONPAGES);
> > +               dec_mm_counter(src_mm, MM_ANONPAGES);
> > +       }
> > +
> > +       double_pt_unlock(dst_ptl, src_ptl);
> > +
> > +       return 0;
> > +}
> > +
> > +static int remap_swap_pte(struct mm_struct *dst_mm, struct mm_struct *=
src_mm,
> > +                         unsigned long dst_addr, unsigned long src_add=
r,
> > +                         pte_t *dst_pte, pte_t *src_pte,
> > +                         pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                         spinlock_t *dst_ptl, spinlock_t *src_ptl)
> > +{
> > +       if (!pte_swp_exclusive(orig_src_pte))
> > +               return -EBUSY;
> > +
> > +       double_pt_lock(dst_ptl, src_ptl);
> > +
> > +       if (!pte_same(*src_pte, orig_src_pte) ||
> > +           !pte_same(*dst_pte, orig_dst_pte)) {
> > +               double_pt_unlock(dst_ptl, src_ptl);
> > +               return -EAGAIN;
> > +       }
> > +
> > +       orig_src_pte =3D ptep_get_and_clear(src_mm, src_addr, src_pte);
> > +       set_pte_at(dst_mm, dst_addr, dst_pte, orig_src_pte);
> > +
> > +       if (dst_mm !=3D src_mm) {
> > +               inc_mm_counter(dst_mm, MM_ANONPAGES);
> > +               dec_mm_counter(src_mm, MM_ANONPAGES);
>
> I think this is the wrong counter. Looking at zap_pte_range(), in the
> "Genuine swap entry" case, we modify the MM_SWAPENTS counter, not
> MM_ANONPAGES.

Oops, my bad. Will fix.

>
> > +       }
> > +
> > +       double_pt_unlock(dst_ptl, src_ptl);
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * The mmap_lock for reading is held by the caller. Just move the page
> > + * from src_pmd to dst_pmd if possible, and return true if succeeded
> > + * in moving the page.
> > + */
> > +static int remap_pages_pte(struct mm_struct *dst_mm,
> > +                          struct mm_struct *src_mm,
> > +                          pmd_t *dst_pmd,
> > +                          pmd_t *src_pmd,
> > +                          struct vm_area_struct *dst_vma,
> > +                          struct vm_area_struct *src_vma,
> > +                          unsigned long dst_addr,
> > +                          unsigned long src_addr,
> > +                          __u64 mode)
> > +{
> > +       swp_entry_t entry;
> > +       pte_t orig_src_pte, orig_dst_pte;
> > +       spinlock_t *src_ptl, *dst_ptl;
> > +       pte_t *src_pte =3D NULL;
> > +       pte_t *dst_pte =3D NULL;
> > +
> > +       struct folio *src_folio =3D NULL;
> > +       struct anon_vma *src_anon_vma =3D NULL;
> > +       struct mmu_notifier_range range;
> > +       int err =3D 0;
> > +
> > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm,
> > +                               src_addr, src_addr + PAGE_SIZE);
> > +       mmu_notifier_invalidate_range_start(&range);
> > +retry:
>
> This retry looks a bit dodgy. On this retry label, we restart almost
> the entire operation, including re-reading the source PTE; the only
> variables that carry state forward from the previous retry loop
> iteration are src_folio and src_anon_vma.
>
> > +       dst_pte =3D pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &d=
st_ptl);
> > +
> > +       /* If an huge pmd materialized from under us fail */
> > +       if (unlikely(!dst_pte)) {
> > +               err =3D -EFAULT;
> > +               goto out;
> > +       }
> [...]
> > +       spin_lock(dst_ptl);
> > +       orig_dst_pte =3D *dst_pte;
> > +       spin_unlock(dst_ptl);
> > +       if (!pte_none(orig_dst_pte)) {
> > +               err =3D -EEXIST;
> > +               goto out;
> > +       }
> > +
> > +       spin_lock(src_ptl);
> > +       orig_src_pte =3D *src_pte;
>
> Here we read an entirely new orig_src_pte value. Something like a
> concurrent MADV_DONTNEED+pagefault could have made the PTE point to a
> different page between loop iterations.
>
> > +       spin_unlock(src_ptl);
>
> I think you have to insert something like the following here:
>
>         if (src_folio && (orig_dst_pte !=3D previous_src_pte)) {
>                 err =3D -EAGAIN;
>                 goto out;
>         }
>         previous_src_pte =3D orig_dst_pte;

Yes, this definitely needs to be rechecked. Will fix.

>
> Otherwise:
>
> > +       if (pte_none(orig_src_pte)) {
> > +               if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES))
> > +                       err =3D -ENOENT;
> > +               else /* nothing to do to remap a hole */
> > +                       err =3D 0;
> > +               goto out;
> > +       }
> > +
> > +       if (pte_present(orig_src_pte)) {
> > +               /*
> > +                * Pin and lock both source folio and anon_vma. Since w=
e are in
> > +                * RCU read section, we can't block, so on contention h=
ave to
> > +                * unmap the ptes, obtain the lock and retry.
> > +                */
> > +               if (!src_folio) {
>
> If we already found a src_folio in the previous iteration (but the
> trylock failed), we keep using the same src_folio without rechecking
> if the current PTE still points to the same folio.
>
> > +                       struct folio *folio;
> > +
> > +                       /*
> > +                        * Pin the page while holding the lock to be su=
re the
> > +                        * page isn't freed under us
> > +                        */
> > +                       spin_lock(src_ptl);
> > +                       if (!pte_same(orig_src_pte, *src_pte)) {
> > +                               spin_unlock(src_ptl);
> > +                               err =3D -EAGAIN;
> > +                               goto out;
> > +                       }
> > +
> > +                       folio =3D vm_normal_folio(src_vma, src_addr, or=
ig_src_pte);
> > +                       if (!folio || !folio_test_anon(folio) ||
> > +                           folio_test_large(folio) ||
> > +                           folio_estimated_sharers(folio) !=3D 1) {
> > +                               spin_unlock(src_ptl);
> > +                               err =3D -EBUSY;
> > +                               goto out;
> > +                       }
> > +
> > +                       folio_get(folio);
> > +                       src_folio =3D folio;
> > +                       spin_unlock(src_ptl);
> > +
> > +                       /* block all concurrent rmap walks */
> > +                       if (!folio_trylock(src_folio)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               /* now we can block and wait */
> > +                               folio_lock(src_folio);
> > +                               goto retry;
> > +                       }
> > +               }
> > +
> > +               if (!src_anon_vma) {
>
> (And here, if we already saw a src_anon_vma but the trylock failed,
> we'll keep using that src_anon_vma.)

Ack. The check for previous_src_pte should handle that as well.

>
> > +                       /*
> > +                        * folio_referenced walks the anon_vma chain
> > +                        * without the folio lock. Serialize against it=
 with
> > +                        * the anon_vma lock, the folio lock is not eno=
ugh.
> > +                        */
> > +                       src_anon_vma =3D folio_get_anon_vma(src_folio);
> > +                       if (!src_anon_vma) {
> > +                               /* page was unmapped from under us */
> > +                               err =3D -EAGAIN;
> > +                               goto out;
> > +                       }
> > +                       if (!anon_vma_trylock_write(src_anon_vma)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               /* now we can block and wait */
> > +                               anon_vma_lock_write(src_anon_vma);
> > +                               goto retry;
> > +                       }
> > +               }
>
> So at this point we have:
>
>  - the current src_pte
>  - some referenced+locked src_folio that used to be mapped exclusively
> at src_addr
>  - (the anon_vma associated with the src_folio)
>
> > +               err =3D remap_anon_pte(dst_mm, src_mm,  dst_vma, src_vm=
a,
> > +                                    dst_addr, src_addr, dst_pte, src_p=
te,
> > +                                    orig_dst_pte, orig_src_pte,
> > +                                    dst_ptl, src_ptl, src_folio);
>
> And then this will, without touching folio mapcounts/refcounts, delete
> the current PTE at src_addr, and create a PTE at dst_addr pointing to
> the old src_folio, leading to incorrect refcounts/mapcounts?

I assume this still points to the missing previous_src_pte check
discussed in the previous comments. Is that correct or is there yet
another issue?

>
> > +       } else {
> [...]
> > +       }
> > +
> > +out:
> > +       if (src_anon_vma) {
> > +               anon_vma_unlock_write(src_anon_vma);
> > +               put_anon_vma(src_anon_vma);
> > +       }
> > +       if (src_folio) {
> > +               folio_unlock(src_folio);
> > +               folio_put(src_folio);
> > +       }
> > +       if (dst_pte)
> > +               pte_unmap(dst_pte);
> > +       if (src_pte)
> > +               pte_unmap(src_pte);
> > +       mmu_notifier_invalidate_range_end(&range);
> > +
> > +       return err;
> > +}
> [...]
> > +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm=
,
> > +                   unsigned long dst_start, unsigned long src_start,
> > +                   unsigned long len, __u64 mode)
> > +{
> > +       struct vm_area_struct *src_vma, *dst_vma;
> > +       unsigned long src_addr, dst_addr;
> > +       pmd_t *src_pmd, *dst_pmd;
> > +       long err =3D -EINVAL;
> > +       ssize_t moved =3D 0;
> > +
> > +       /*
> > +        * Sanitize the command parameters:
> > +        */
> > +       BUG_ON(src_start & ~PAGE_MASK);
> > +       BUG_ON(dst_start & ~PAGE_MASK);
> > +       BUG_ON(len & ~PAGE_MASK);
> > +
> > +       /* Does the address range wrap, or is the span zero-sized? */
> > +       BUG_ON(src_start + len <=3D src_start);
> > +       BUG_ON(dst_start + len <=3D dst_start);
> > +
> > +       /*
> > +        * Because these are read sempahores there's no risk of lock
> > +        * inversion.
> > +        */
> > +       mmap_read_lock(dst_mm);
> > +       if (dst_mm !=3D src_mm)
> > +               mmap_read_lock(src_mm);
> > +
> > +       /*
> > +        * Make sure the vma is not shared, that the src and dst remap
> > +        * ranges are both valid and fully within a single existing
> > +        * vma.
> > +        */
> > +       src_vma =3D find_vma(src_mm, src_start);
> > +       if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> > +               goto out;
> > +       if (src_start < src_vma->vm_start ||
> > +           src_start + len > src_vma->vm_end)
> > +               goto out;
> > +
> > +       dst_vma =3D find_vma(dst_mm, dst_start);
> > +       if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > +               goto out;
> > +       if (dst_start < dst_vma->vm_start ||
> > +           dst_start + len > dst_vma->vm_end)
> > +               goto out;
> > +
> > +       err =3D validate_remap_areas(src_vma, dst_vma);
> > +       if (err)
> > +               goto out;
> > +
> > +       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > +            src_addr < src_start + len;) {
> > +               spinlock_t *ptl;
> > +               pmd_t dst_pmdval;
> > +               unsigned long step_size;
> > +
> > +               BUG_ON(dst_addr >=3D dst_start + len);
> > +               /*
> > +                * Below works because anonymous area would not have a
> > +                * transparent huge PUD. If file-backed support is adde=
d,
> > +                * that case would need to be handled here.
> > +                */
> > +               src_pmd =3D mm_find_pmd(src_mm, src_addr);
> > +               if (unlikely(!src_pmd)) {
> > +                       if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES)=
) {
> > +                               err =3D -ENOENT;
> > +                               break;
> > +                       }
> > +                       src_pmd =3D mm_alloc_pmd(src_mm, src_addr);
> > +                       if (unlikely(!src_pmd)) {
> > +                               err =3D -ENOMEM;
> > +                               break;
> > +                       }
> > +               }
> > +               dst_pmd =3D mm_alloc_pmd(dst_mm, dst_addr);
> > +               if (unlikely(!dst_pmd)) {
> > +                       err =3D -ENOMEM;
> > +                       break;
> > +               }
> > +
> > +               dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > +               /*
> > +                * If the dst_pmd is mapped as THP don't override it an=
d just
> > +                * be strict. If dst_pmd changes into TPH after this ch=
eck, the
> > +                * remap_pages_huge_pmd() will detect the change and re=
try
> > +                * while remap_pages_pte() will detect the change and f=
ail.
> > +                */
> > +               if (unlikely(pmd_trans_huge(dst_pmdval))) {
> > +                       err =3D -EEXIST;
> > +                       break;
> > +               }
> > +
> > +               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > +               if (ptl && !pmd_trans_huge(*src_pmd)) {
> > +                       spin_unlock(ptl);
> > +                       ptl =3D NULL;
> > +               }
>
> This still looks wrong - we do still have to split_huge_pmd()
> somewhere so that remap_pages_pte() works.

Hmm, I guess this extra check is not even needed...

>
> > +               if (ptl) {
> > +                       /*
> > +                        * Check if we can move the pmd without
> > +                        * splitting it. First check the address
> > +                        * alignment to be the same in src/dst.  These
> > +                        * checks don't actually need the PT lock but
> > +                        * it's good to do it here to optimize this
> > +                        * block away at build time if
> > +                        * CONFIG_TRANSPARENT_HUGEPAGE is not set.
> > +                        */
> > +                       if ((src_addr & ~HPAGE_PMD_MASK) || (dst_addr &=
 ~HPAGE_PMD_MASK) ||
> > +                           src_start + len - src_addr < HPAGE_PMD_SIZE=
 || !pmd_none(dst_pmdval)) {
> > +                               spin_unlock(ptl);
> > +                               split_huge_pmd(src_vma, src_pmd, src_ad=
dr);
> > +                               continue;
> > +                       }
> > +
> > +                       err =3D remap_pages_huge_pmd(dst_mm, src_mm,
> > +                                                  dst_pmd, src_pmd,
> > +                                                  dst_pmdval,
> > +                                                  dst_vma, src_vma,
> > +                                                  dst_addr, src_addr);
> > +                       step_size =3D HPAGE_PMD_SIZE;
> > +               } else {
> > +                       if (pmd_none(*src_pmd)) {
> > +                               if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SR=
C_HOLES)) {
> > +                                       err =3D -ENOENT;
> > +                                       break;
> > +                               }
> > +                               if (unlikely(__pte_alloc(src_mm, src_pm=
d))) {
> > +                                       err =3D -ENOMEM;
> > +                                       break;
> > +                               }
> > +                       }
> > +
> > +                       if (unlikely(pte_alloc(dst_mm, dst_pmd))) {
> > +                               err =3D -ENOMEM;
> > +                               break;
> > +                       }
> > +
> > +                       err =3D remap_pages_pte(dst_mm, src_mm,
> > +                                             dst_pmd, src_pmd,
> > +                                             dst_vma, src_vma,
> > +                                             dst_addr, src_addr,
> > +                                             mode);
> > +                       step_size =3D PAGE_SIZE;
> > +               }
> > +
> > +               cond_resched();
> > +
> > +               if (!err) {
> > +                       dst_addr +=3D step_size;
> > +                       src_addr +=3D step_size;
> > +                       moved +=3D step_size;
> > +               }
> > +
> > +               if ((!err || err =3D=3D -EAGAIN) &&
> > +                   fatal_signal_pending(current))
> > +                       err =3D -EINTR;
> > +
> > +               if (err && err !=3D -EAGAIN)
> > +                       break;
> > +       }
> > +
> > +out:
> > +       mmap_read_unlock(dst_mm);
> > +       if (dst_mm !=3D src_mm)
> > +               mmap_read_unlock(src_mm);
> > +       BUG_ON(moved < 0);
> > +       BUG_ON(err > 0);
> > +       BUG_ON(!moved && !err);
> > +       return moved ? moved : err;
> > +}
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
