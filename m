Return-Path: <linux-fsdevel+bounces-3347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4117F3B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 02:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DE5282AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A11842;
	Wed, 22 Nov 2023 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fH8GNq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3041112A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 17:29:01 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf5ceadfd8so76855ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 17:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700616540; x=1701221340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQTXNqNKjwBGV/F0nq07Eb76dHmbBkOBd/hKqiZRe4I=;
        b=0fH8GNq49/9SN0sFpPa+dFB76Fv3TVjuVjQEK1Z67KYsFUZQ6SmhrUGQAbU0s4JgS6
         AGa5keuizGPR4H3A8s6fa6HJ/lKlaMjF++Suzkvgk08fnaqk0iHuVf1yPpv5Afq90/YV
         9uHhDqy+SRyC/ZG++lUKcNbxPKTyw9vVsi45IdFfECl1upuoURThgJjDPSbfN0p9Oz0V
         ygfO1ISORS4i7J8XYeI2EjGrXmameWqCRhhGHZlKCEPPYQTa/ZbtlgwKD6PcwZ38oKlm
         9mLRHCOsME9wjbkXbKc3AmzvSBcII8Wdau3aR7/3JYdNFgtGywTBOJNt1usXmTvLhOOM
         Y/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700616540; x=1701221340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQTXNqNKjwBGV/F0nq07Eb76dHmbBkOBd/hKqiZRe4I=;
        b=b0pk0mFKmVx6/bbiX5xqidjJ8RpXPM7IsbLY/WD6JDyNLKyVCjMSBWofgWfjX1wldW
         0PzcsMs2HfzLyxYqjOrztdbAO9+CyNOWbadT3Jjs7a93kOGir5t0P/0s7BLQfI+msWVY
         vsMmQa/OnRePbTz/KOcMA4RUDBf4ynoOI8GNpwwDZ21vazl5x2NTaVyfIABrzgFNDu3U
         PBKVnqiSa+mmQ/7H8kIl/xtLPltjyYl0ISn6j/zkpthsOtj2jIJBvvJIiGxKf/UZXcMC
         Kqeguk7b7k8th7vOnrw1Smni5rQue/FHgOY3h/ixWpFv10jiYW94zU2GX10JbvpfO2cM
         MjVw==
X-Gm-Message-State: AOJu0Yy6eKNvboecSsewzXPoOFpnZ0a3EBNueDQcTSGYHu/ddUEYelur
	fHkInn6RX7O8OW1qqKfGUfcau3l33z5OlN/OBE6gcw==
X-Google-Smtp-Source: AGHT+IHTLY6O8nnNjugZgX1idDgXA1sk1KnuEcL73QkrrMzzt0J7bEBMJ67A4b4lOJtIs84dHwwHlsyEGiBHb8A0s/M=
X-Received: by 2002:a17:903:643:b0:1cf:6542:b4c6 with SMTP id
 kh3-20020a170903064300b001cf6542b4c6mr63497plb.13.1700616540267; Tue, 21 Nov
 2023 17:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231119165721.9849-1-alexandru.elisei@arm.com> <20231119165721.9849-21-alexandru.elisei@arm.com>
In-Reply-To: <20231119165721.9849-21-alexandru.elisei@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Tue, 21 Nov 2023 17:28:49 -0800
Message-ID: <CAMn1gO7_UG-T9Vf_7oVOhLD1DFVPc1ceSxdJFsFqkem_vCopog@mail.gmail.com>
Subject: Re: [PATCH RFC v2 20/27] mm: hugepage: Handle huge page fault on access
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, steven.price@arm.com, 
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com, david@redhat.com, 
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 8:59=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Handle PAGE_FAULT_ON_ACCESS faults for huge pages in a similar way to
> regular pages.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/include/asm/mte_tag_storage.h |  1 +
>  arch/arm64/include/asm/pgtable.h         |  7 ++
>  arch/arm64/mm/fault.c                    | 81 ++++++++++++++++++++++++
>  include/linux/huge_mm.h                  |  2 +
>  include/linux/pgtable.h                  |  5 ++
>  mm/huge_memory.c                         |  4 +-
>  mm/memory.c                              |  3 +
>  7 files changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/includ=
e/asm/mte_tag_storage.h
> index c70ced60a0cd..b97406d369ce 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -35,6 +35,7 @@ void free_tag_storage(struct page *page, int order);
>  bool page_tag_storage_reserved(struct page *page);
>
>  vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
> +vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf);
>  #else
>  static inline bool tag_storage_enabled(void)
>  {
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 8cc135f1c112..1704411c096d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -477,6 +477,13 @@ static inline vm_fault_t arch_do_page_fault_on_acces=
s(struct vm_fault *vmf)
>                 return handle_page_missing_tag_storage(vmf);
>         return VM_FAULT_SIGBUS;
>  }
> +
> +static inline vm_fault_t arch_do_huge_page_fault_on_access(struct vm_fau=
lt *vmf)
> +{
> +       if (tag_storage_enabled())
> +               return handle_huge_page_missing_tag_storage(vmf);
> +       return VM_FAULT_SIGBUS;
> +}
>  #endif /* CONFIG_ARCH_HAS_FAULT_ON_ACCESS */
>
>  #define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVA=
LID))
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index f5fa583acf18..6730a0812a24 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -1041,6 +1041,87 @@ vm_fault_t handle_page_missing_tag_storage(struct =
vm_fault *vmf)
>
>         return 0;
>
> +out_retry:
> +       put_page(page);
> +       if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +               vma_end_read(vma);
> +       if (fault_flag_allow_retry_first(vmf->flags)) {
> +               err =3D VM_FAULT_RETRY;
> +       } else {
> +               /* Replay the fault. */
> +               err =3D 0;
> +       }
> +       return err;
> +}
> +
> +vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf)
> +{
> +       unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       pmd_t old_pmd, new_pmd;
> +       bool writable =3D false;
> +       struct page *page;
> +       vm_fault_t err;
> +       int ret;
> +
> +       vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
> +       if (unlikely(!pmd_same(vmf->orig_pmd, *vmf->pmd))) {
> +               spin_unlock(vmf->ptl);
> +               return 0;
> +       }
> +
> +       old_pmd =3D vmf->orig_pmd;
> +       new_pmd =3D pmd_modify(old_pmd, vma->vm_page_prot);
> +
> +       /*
> +        * Detect now whether the PMD could be writable; this information
> +        * is only valid while holding the PT lock.
> +        */
> +       writable =3D pmd_write(new_pmd);
> +       if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
> +           can_change_pmd_writable(vma, vmf->address, new_pmd))
> +               writable =3D true;
> +
> +       page =3D vm_normal_page_pmd(vma, haddr, new_pmd);
> +       if (!page)
> +               goto out_map;
> +
> +       if (!(vma->vm_flags & VM_MTE))
> +               goto out_map;
> +
> +       get_page(page);
> +       vma_set_access_pid_bit(vma);
> +
> +       spin_unlock(vmf->ptl);
> +       writable =3D false;
> +
> +       if (unlikely(is_migrate_isolate_page(page)))
> +               goto out_retry;
> +
> +       ret =3D reserve_tag_storage(page, HPAGE_PMD_ORDER, GFP_HIGHUSER_M=
OVABLE);
> +       if (ret)
> +               goto out_retry;
> +
> +       put_page(page);
> +
> +       vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
> +       if (unlikely(!pmd_same(old_pmd, *vmf->pmd))) {
> +               spin_unlock(vmf->ptl);
> +               return 0;
> +       }
> +
> +out_map:
> +       /* Restore the PMD */
> +       new_pmd =3D pmd_modify(old_pmd, vma->vm_page_prot);
> +       new_pmd =3D pmd_mkyoung(new_pmd);
> +       if (writable)
> +               new_pmd =3D pmd_mkwrite(new_pmd, vma);
> +       set_pmd_at(vma->vm_mm, haddr, vmf->pmd, new_pmd);
> +       update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> +       spin_unlock(vmf->ptl);
> +
> +       return 0;
> +
>  out_retry:
>         put_page(page);
>         if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fa0350b0812a..bb84291f9231 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -36,6 +36,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned=
 long old_addr,
>  int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                     pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>                     unsigned long cp_flags);
> +bool can_change_pmd_writable(struct vm_area_struct *vma, unsigned long a=
ddr,
> +                            pmd_t pmd);
>
>  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool writ=
e);
>  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool writ=
e);
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e2c761dd6c41..de45f475bf8d 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1473,6 +1473,11 @@ static inline vm_fault_t arch_do_page_fault_on_acc=
ess(struct vm_fault *vmf)
>  {
>         return VM_FAULT_SIGBUS;
>  }
> +
> +static inline vm_fault_t arch_do_huge_page_fault_on_access(struct vm_fau=
lt *vmf)
> +{
> +       return VM_FAULT_SIGBUS;
> +}
>  #endif
>
>  #endif /* CONFIG_MMU */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9beead961a65..d1402b43ea39 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1406,8 +1406,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf=
)
>         return VM_FAULT_FALLBACK;
>  }
>
> -static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
> -                                          unsigned long addr, pmd_t pmd)
> +inline bool can_change_pmd_writable(struct vm_area_struct *vma,

Remove inline keyword here.

Peter

> +                                   unsigned long addr, pmd_t pmd)
>  {
>         struct page *page;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index a04a971200b9..46b926625503 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5168,6 +5168,9 @@ static vm_fault_t __handle_mm_fault(struct vm_area_=
struct *vma,
>                         return 0;
>                 }
>                 if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_p=
md)) {
> +                       if (fault_on_access_pmd(vmf.orig_pmd) && vma_is_a=
ccessible(vma))
> +                               return arch_do_huge_page_fault_on_access(=
&vmf);
> +
>                         if (pmd_protnone(vmf.orig_pmd) && vma_is_accessib=
le(vma))
>                                 return do_huge_pmd_numa_page(&vmf);
>
> --
> 2.42.1
>

