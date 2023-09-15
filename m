Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4D7A2B08
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 01:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjIOXj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjIOXjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:39:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC72119
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:39:33 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8195078f69so2218558276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694821173; x=1695425973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIoexKJI5mki8/YY4uzqb/z4xddoHD7Hr4J9Yv8A8c8=;
        b=siH3a8M3m3dKW9kxsieQqqJxA+JHmNtZOBUphGvMA/ZWNCCYmqVU1mJz5wff+T5PGN
         Jcp74TqnoY6Dltpp9gXZR/fl50RZgz4ibXl/oRfT3/BRmIZBdDnkkt2EL6YLaBytiAdl
         bU06yKBkLE0u0lERgcYXa1LqhfHKIjW065NDd28Z2lSSv+JH6p4YlQoemiVpfkx5kVDB
         +w6ddLlc2pbG+SE9aV3t4Z3HiKrbGlSmltcA3X+vGcwXnbCW925xuaUpLP5zviAQsrM2
         sF66mh3mtsPyEJytDbbnG9XjQoa/HvfB9I0tqDtKmewJGn4KbKIy6Qv/V7ER7o0ivFUy
         broA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821173; x=1695425973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIoexKJI5mki8/YY4uzqb/z4xddoHD7Hr4J9Yv8A8c8=;
        b=f58Zn6/3Ax4otcW3ID+CGGR8ChLDoWazMu/8DCKyE4eV2B0wpSA8/NsEEhkLDNIehn
         fZJVsMVaOi2HcF0nm+3Avjt6ETQPvPQfGV/eAM3X8TIqj3wRkXsvvmQJInbZsNida/Tk
         /83TzosOkSgTtQk8vBZ2JvtVFX2ADFPbPht7KfcfX4Qd1yhQtZBi7sAPE6dj7E/N9jej
         P/Pyaxq5FgNEKKYxN20k+dVNBuHcd9hSZvAIoN03lE5jRxhfxC5QPGsjC6OI3iKRw3br
         mX0A/ysvMy0jJkE6fkfdlYds5QTdy8+vEAUDzvFoILiKeaEnsrQa373Qv4lFyjTILU5T
         mSkw==
X-Gm-Message-State: AOJu0YxpC8XLCp/Uv3fNpdiwNYEm2z9ECIHLrT96iWoBanQ7VeI03vvm
        0uEmxsnT8oZvJylt+K2LCgBAljvFG5S+5GJpfALZwg==
X-Google-Smtp-Source: AGHT+IHiXwWiHCwKKmsHQwQOpvubqqvhxn4yTdFTKnM4qna33woioG+Sdo/FdmuWdGQj+/9nM2wovo/NUoEXhRAJlVU=
X-Received: by 2002:a25:6b12:0:b0:d81:89e9:9f48 with SMTP id
 g18-20020a256b12000000b00d8189e99f48mr3043473ybc.63.1694821172852; Fri, 15
 Sep 2023 16:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <CAG48ez3E1t=equPeL5doT+RPaPZ1BmkFi8zkZRKqhOZHbXVkzg@mail.gmail.com>
In-Reply-To: <CAG48ez3E1t=equPeL5doT+RPaPZ1BmkFi8zkZRKqhOZHbXVkzg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 15 Sep 2023 16:39:18 -0700
Message-ID: <CAJuCfpF3Hz9p6zQotM0aMG3WLT=FtYCu31jpFbU_VqE6BAP8NA@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:34=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Sep 14, 2023 at 5:26=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
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
> > +       struct anon_vma *dst_anon_vma;
> > +       struct mmu_notifier_range range;
> > +       int err =3D 0;
> > +
> > +retry:
> > +       dst_pte =3D pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &d=
st_ptl);
> > +
> > +       /* If an huge pmd materialized from under us fail */
> > +       if (unlikely(!dst_pte)) {
> > +               err =3D -EFAULT;
> > +               goto out;
> > +       }
> > +
> > +       src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, src_addr, &s=
rc_ptl);
> > +
> > +       /*
> > +        * We held the mmap_lock for reading so MADV_DONTNEED
> > +        * can zap transparent huge pages under us, or the
> > +        * transparent huge page fault can establish new
> > +        * transparent huge pages under us.
> > +        */
> > +       if (unlikely(!src_pte)) {
> > +               err =3D -EFAULT;
> > +               goto out;
> > +       }
> > +
> > +       BUG_ON(pmd_none(*dst_pmd));
> > +       BUG_ON(pmd_none(*src_pmd));
> > +       BUG_ON(pmd_trans_huge(*dst_pmd));
> > +       BUG_ON(pmd_trans_huge(*src_pmd));
> > +
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
> > +       spin_unlock(src_ptl);
> > +       if (pte_none(orig_src_pte)) {
> > +               if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES))
> > +                       err =3D -ENOENT;
> > +               else /* nothing to do to remap a hole */
> > +                       err =3D 0;
> > +               goto out;
> > +       }
> > +
> > +       if (pte_present(orig_src_pte)) {
> > +               if (!src_folio) {
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
> > +                           folio_estimated_sharers(folio) !=3D 1) {
> > +                               spin_unlock(src_ptl);
> > +                               err =3D -EBUSY;
> > +                               goto out;
> > +                       }
> > +
> > +                       src_folio =3D folio;
> > +                       folio_get(src_folio);
> > +                       spin_unlock(src_ptl);
> > +
> > +                       /* try to block all concurrent rmap walks */
> > +                       if (!folio_trylock(src_folio)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               folio_lock(src_folio);
> > +                               goto retry;
> > +                       }
> > +               }
> > +
> > +               if (!src_anon_vma) {
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
> > +                               anon_vma_lock_write(src_anon_vma);
> > +                               goto retry;
> > +                       }
> > +               }
> > +
> > +               mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, sr=
c_mm,
> > +                                       src_addr, src_addr + PAGE_SIZE)=
;
> > +               mmu_notifier_invalidate_range_start_nonblock(&range);
>
> I'm pretty sure you're not allowed to use
> mmu_notifier_invalidate_range_start_nonblock(). Use
> mmu_notifier_invalidate_range_start() at a point where it's fine to
> block; perhaps all the way up in remap_pages() around the whole loop
> or something like that. mmu_notifier_invalidate_range_start_nonblock()
> is special magic sauce for OOM reaping (with deceptively inviting
> naming and no documentation that explains that this is evil hazmat
> code), and if you chase down what various users of MMU notifiers do
> when you just hand them a random notification where
> mmu_notifier_range_blockable() is false, you end up in fun paths like
> in KVM's kvm_mmu_notifier_invalidate_range_start(), which calls
> gfn_to_pfn_cache_invalidate_start(), which does this:
>
>     /*
>      * If the OOM reaper is active, then all vCPUs should have
>      * been stopped already, so perform the request without
>      * KVM_REQUEST_WAIT and be sad if any needed to be IPI'd.
>      */
>     if (!may_block)
>        req &=3D ~KVM_REQUEST_WAIT;
>
>     called =3D kvm_make_vcpus_request_mask(kvm, req, vcpu_bitmap);
>
>     WARN_ON_ONCE(called && !may_block);
>
> Which means if you hit this codepath from a place like userfaultfd
> where the process is probably still running (and not being OOM reaped
> in a context where it's guaranteed to have been killed and stopped),
> you could probably get KVM into a situation where it needs to wait for
> vCPUs to acknowledge that they've processed a message before it's safe
> to continue, but it can't wait because we're in nonsleepable context,
> and then it just continues without waiting and presumably the KVM TLB
> gets out of sync or something?

Yeah, I was sceptical about this function too but it was very tempting :)
Thanks for the warning, I'll move
mmu_notifier_invalidate_range_start() to before we map the ptes
because that's where we start the RCU read section.

>
>
>
> > +
> > +               double_pt_lock(dst_ptl, src_ptl);
> > +
> > +               if (!pte_same(*src_pte, orig_src_pte) ||
> > +                   !pte_same(*dst_pte, orig_dst_pte) ||
> > +                   folio_estimated_sharers(src_folio) !=3D 1) {
> > +                       double_pt_unlock(dst_ptl, src_ptl);
> > +                       err =3D -EAGAIN;
> > +                       goto out;
> > +               }
> > +
> > +               BUG_ON(!folio_test_anon(src_folio));
> > +               /* the PT lock is enough to keep the page pinned now */
> > +               folio_put(src_folio);
> > +
> > +               dst_anon_vma =3D (void *) dst_vma->anon_vma + PAGE_MAPP=
ING_ANON;
> > +               WRITE_ONCE(src_folio->mapping,
> > +                          (struct address_space *) dst_anon_vma);
> > +               WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
> > +                                                             dst_addr)=
);
> > +
> > +               if (!pte_same(ptep_clear_flush(src_vma, src_addr, src_p=
te),
> > +                             orig_src_pte))
> > +                       BUG_ON(1);
> > +
> > +               orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_p=
age_prot);
> > +               orig_dst_pte =3D maybe_mkwrite(pte_mkdirty(orig_dst_pte=
),
> > +                                            dst_vma);
> > +
> > +               set_pte_at(dst_mm, dst_addr, dst_pte, orig_dst_pte);
> > +
> > +               if (dst_mm !=3D src_mm) {
> > +                       inc_mm_counter(dst_mm, MM_ANONPAGES);
> > +                       dec_mm_counter(src_mm, MM_ANONPAGES);
> > +               }
> > +
> > +               double_pt_unlock(dst_ptl, src_ptl);
> > +
> > +               anon_vma_unlock_write(src_anon_vma);
> > +               mmu_notifier_invalidate_range_end(&range);
> > +               put_anon_vma(src_anon_vma);
> > +               src_anon_vma =3D NULL;
> > +
> > +               /* unblock rmap walks */
> > +               folio_unlock(src_folio);
> > +               src_folio =3D NULL;
> > +
> > +       } else {
> > +               struct swap_info_struct *si;
> > +               int swap_count;
> > +
> > +               entry =3D pte_to_swp_entry(orig_src_pte);
> > +               if (non_swap_entry(entry)) {
> > +                       if (is_migration_entry(entry)) {
> > +                               pte_unmap(&orig_src_pte);
> > +                               pte_unmap(&orig_dst_pte);
> > +                               src_pte =3D dst_pte =3D NULL;
> > +                               migration_entry_wait(src_mm, src_pmd,
> > +                                                    src_addr);
> > +                               err =3D -EAGAIN;
> > +                       } else
> > +                               err =3D -EFAULT;
> > +                       goto out;
> > +               }
> > +
> > +               /*
> > +                * COUNT_CONTINUE to be returned is fine here, no need
> > +                * of follow all swap continuation to check against
> > +                * number 1.
> > +                */
> > +               si =3D get_swap_device(entry);
> > +               if (!si) {
> > +                       err =3D -EBUSY;
> > +                       goto out;
> > +               }
> > +
> > +               swap_count =3D swap_swapcount(si, entry);
> > +               put_swap_device(si);
> > +               if (swap_count !=3D 1) {
> > +                       err =3D -EBUSY;
> > +                       goto out;
> > +               }
> > +
> > +               double_pt_lock(dst_ptl, src_ptl);
> > +
> > +               if (!pte_same(*src_pte, orig_src_pte) ||
> > +                   !pte_same(*dst_pte, orig_dst_pte) ||
> > +                   swp_swapcount(entry) !=3D 1) {
> > +                       double_pt_unlock(dst_ptl, src_ptl);
> > +                       err =3D -EAGAIN;
> > +                       goto out;
> > +               }
> > +
> > +               if (pte_val(ptep_get_and_clear(src_mm, src_addr, src_pt=
e)) !=3D
> > +                   pte_val(orig_src_pte))
> > +                       BUG_ON(1);
> > +               set_pte_at(dst_mm, dst_addr, dst_pte, orig_src_pte);
> > +
> > +               if (dst_mm !=3D src_mm) {
> > +                       inc_mm_counter(dst_mm, MM_ANONPAGES);
> > +                       dec_mm_counter(src_mm, MM_ANONPAGES);
> > +               }
> > +
> > +               double_pt_unlock(dst_ptl, src_ptl);
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
> > +
> > +       return err;
> > +}
