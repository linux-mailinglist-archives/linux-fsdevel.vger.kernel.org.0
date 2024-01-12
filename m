Return-Path: <linux-fsdevel+bounces-7894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4982C77C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 23:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3591C21861
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2C18C27;
	Fri, 12 Jan 2024 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl0M3hns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348F14F6D;
	Fri, 12 Jan 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7ce3a5f73bdso1676669241.0;
        Fri, 12 Jan 2024 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705100075; x=1705704875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtP2LHnJF1O9kK9hbuUQ3mxzY0Ws1WTJNPT7PfFdVWU=;
        b=Kl0M3hns29AAhQ3yPZtqEbLOso+FPUIkUmf7XNTiWqQYbKdhUbA5G5j65FSEGGXkiy
         rKwWMZ95f8Bvj+JyiIvDO7E3RE4IhVEopUvQS1bzWAL4ukLnpEvrvGHVZOOUnDRWhCK9
         p0KC9Kwu72WNCQeOvIsBhqDVNdkxPP25QcgiXvY/b2bGTR4TgGg4h7iSwtAjrNsOi7yO
         Pqt5V0yqCnL8kDtuPk0UtYKqyUCVj8qQyQJLmvNF2ZrewHRyIRVRa5qEoHJAwx0l0o9R
         AIz8of9OkqEbt5FOSa82cI7Jq/8b5zmQ/1ShPV819XYu9rMvOIajFkWVIYocT8JJc2XB
         QIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705100075; x=1705704875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtP2LHnJF1O9kK9hbuUQ3mxzY0Ws1WTJNPT7PfFdVWU=;
        b=CO1+8w4DsaRWB6T/mRBO7APK7pqnfOgn2dqiuVZTgRSAF/vBbOi+aGtg5UirAnNBRw
         P/lLchuasl9XW2181P1YH9q4yoPpa7+EVSPkJ2ItnltiGGQUexhLWaGRTf2ZDjbs8hVD
         ir2DV9q8cKRcxMLAdVUtNlTT5nbYxIRvsPaV63dJ9f8yGtgkzTXDjmLIx90qRxyzo5LZ
         n2F2BVVt60uXbBUaouWeAp1aCWmuUMtQUwuZkEOWv5k4H1GqHQQZ0DBt3hI46nY3iTqk
         tb64KYikvNAVfuoDvIMKHkoXGKAVD6zXMrvltEqoM7ZFaIWnbvdC0xOo773WBGUoG1i6
         3MOg==
X-Gm-Message-State: AOJu0YyodhXwdnzlmoBz+10Ij4ON8iEAG6vRXy8q9SOsv5VoOhV6bnP5
	4a9udT0d3Cpsj8lz21YAu6Fq6MHQJlsI69pYx9Q=
X-Google-Smtp-Source: AGHT+IGBCbarPQnLt7QsvgIB0UK8OuKZA5ziCvWY62H3wiYQ8QE3OOEpJ7jX1i7WLz4WMd4SlPpGa4qUibu4uPpMHSU=
X-Received: by 2002:a05:6102:3134:b0:468:9cb6:77ea with SMTP id
 f20-20020a056102313400b004689cb677eamr601961vsh.15.1705100075287; Fri, 12 Jan
 2024 14:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154106.3692206-1-ryan.roberts@arm.com>
 <CAGsJ_4xPgmgt57sw2c5==bPN+YL23zn=hZweu8u2ceWei7+q4g@mail.gmail.com>
 <654df189-e472-4a75-b2be-6faa8ba18a08@arm.com> <CAGsJ_4zyK4kSF4XYWwLTLN8816KL+u=p6WhyEsRu8PMnQTNRUg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zyK4kSF4XYWwLTLN8816KL+u=p6WhyEsRu8PMnQTNRUg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 13 Jan 2024 11:54:23 +1300
Message-ID: <CAGsJ_4y8ovLPp51NcrhTXTAE0DZvSPYTJs8nu6-ny_ierLx-pw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm/filemap: Allow arch to request folio size for
 exec memory
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 11:13=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Sat, Jan 13, 2024 at 12:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >
> > On 12/01/2024 10:13, Barry Song wrote:
> > > On Fri, Jan 12, 2024 at 4:41=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> > >>
> > >> Change the readahead config so that if it is being requested for an
> > >> executable mapping, do a synchronous read of an arch-specified size =
in a
> > >> naturally aligned manner.
> > >>
> > >> On arm64 if memory is physically contiguous and naturally aligned to=
 the
> > >> "contpte" size, we can use contpte mappings, which improves utilizat=
ion
> > >> of the TLB. When paired with the "multi-size THP" changes, this work=
s
> > >> well to reduce dTLB pressure. However iTLB pressure is still high du=
e to
> > >> executable mappings having a low liklihood of being in the required
> > >> folio size and mapping alignment, even when the filesystem supports
> > >> readahead into large folios (e.g. XFS).
> > >>
> > >> The reason for the low liklihood is that the current readahead algor=
ithm
> > >> starts with an order-2 folio and increases the folio order by 2 ever=
y
> > >> time the readahead mark is hit. But most executable memory is faulte=
d in
> > >> fairly randomly and so the readahead mark is rarely hit and most
> > >> executable folios remain order-2. This is observed impirically and
> > >> confirmed from discussion with a gnu linker expert; in general, the
> > >> linker does nothing to group temporally accessed text together
> > >> spacially. Additionally, with the current read-around approach there=
 are
> > >> no alignment guarrantees between the file and folio. This is
> > >> insufficient for arm64's contpte mapping requirement (order-4 for 4K
> > >> base pages).
> > >>
> > >> So it seems reasonable to special-case the read(ahead) logic for
> > >> executable mappings. The trade-off is performance improvement (due t=
o
> > >> more efficient storage of the translations in iTLB) vs potential rea=
d
> > >> amplification (due to reading too much data around the fault which w=
on't
> > >> be used), and the latter is independent of base page size. I've chos=
en
> > >> 64K folio size for arm64 which benefits both the 4K and 16K base pag=
e
> > >> size configs and shouldn't lead to any further read-amplification si=
nce
> > >> the old read-around path was (usually) reading blocks of 128K (with =
the
> > >> last 32K being async).
> > >>
> > >> Performance Benchmarking
> > >> ------------------------
> > >>
> > >> The below shows kernel compilation and speedometer javascript benchm=
arks
> > >> on Ampere Altra arm64 system. (The contpte patch series is applied i=
n
> > >> the baseline).
> > >>
> > >> First, confirmation that this patch causes more memory to be contain=
ed
> > >> in 64K folios (this is for all file-backed memory so includes
> > >> non-executable too):
> > >>
> > >> | File-backed folios      |   Speedometer   |  Kernel Compile |
> > >> | by size as percentage   |-----------------|-----------------|
> > >> | of all mapped file mem  | before |  after | before |  after |
> > >> |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=
=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|
> > >> |file-thp-aligned-16kB    |    45% |     9% |    46% |     7% |
> > >> |file-thp-aligned-32kB    |     2% |     0% |     3% |     1% |
> > >> |file-thp-aligned-64kB    |     3% |    63% |     5% |    80% |
> > >> |file-thp-aligned-128kB   |    11% |    11% |     0% |     0% |
> > >> |file-thp-unaligned-16kB  |     1% |     0% |     3% |     1% |
> > >> |file-thp-unaligned-128kB |     1% |     0% |     0% |     0% |
> > >> |file-thp-partial         |     0% |     0% |     0% |     0% |
> > >> |-------------------------|--------|--------|--------|--------|
> > >> |file-cont-aligned-64kB   |    16% |    75% |     5% |    80% |
> > >>
> > >> The above shows that for both use cases, the amount of file memory
> > >> backed by 16K folios reduces and the amount backed by 64K folios
> > >> increases significantly. And the amount of memory that is contpte-ma=
pped
> > >> significantly increases (last line).
> > >>
> > >> And this is reflected in performance improvement:
> > >>
> > >> Kernel Compilation (smaller is faster):
> > >> | kernel   |   real-time |   kern-time |   user-time |   peak memory=
 |
> > >> |----------|-------------|-------------|-------------|--------------=
-|
> > >> | before   |        0.0% |        0.0% |        0.0% |          0.0%=
 |
> > >> | after    |       -1.6% |       -2.1% |       -1.7% |          0.0%=
 |
> > >>
> > >> Speedometer (bigger is faster):
> > >> | kernel   |   runs_per_min |   peak memory |
> > >> |----------|----------------|---------------|
> > >> | before   |           0.0% |          0.0% |
> > >> | after    |           1.3% |          1.0% |
> > >>
> > >> Both benchmarks show a ~1.5% improvement once the patch is applied.
> > >>
> > >> Alternatives
> > >> ------------
> > >>
> > >> I considered (and rejected for now - but I anticipate this patch wil=
l
> > >> stimulate discussion around what the best approach is) alternative
> > >> approaches:
> > >>
> > >>   - Expose a global user-controlled knob to set the preferred folio
> > >>     size; this would move policy to user space and allow (e.g.) sett=
ing
> > >>     it to PMD-size for even better iTLB utilizaiton. But this would =
add
> > >>     ABI, and I prefer to start with the simplest approach first. It =
also
> > >>     has the downside that a change wouldn't apply to memory already =
in
> > >>     the page cache that is in active use (e.g. libc) so we don't get=
 the
> > >>     same level of utilization as for something that is fixed from bo=
ot.
> > >>
> > >>   - Add a per-vma attribute to allow user space to specify preferred
> > >>     folio size for memory faulted from the range. (we've talked abou=
t
> > >>     such a control in the context of mTHP). The dynamic loader would
> > >>     then be responsible for adding the annotations. Again this feels
> > >>     like something that could be added later if value was demonstrat=
ed.
> > >>
> > >>   - Enhance MADV_COLLAPSE to collapse to THP sizes less than PMD-siz=
e.
> > >>     This would still require dynamic linker involvement, but would
> > >>     additionally neccessitate a copy and all memory in the range wou=
ld
> > >>     be synchronously faulted in, adding to application load time. It
> > >>     would work for filesystems that don't support large folios thoug=
h.
> > >>
> > >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > >> ---
> > >>
> > >> Hi all,
> > >>
> > >> I originally concocted something similar to this, with Matthew's hel=
p, as a
> > >> quick proof of concept hack. Since then I've tried a few different a=
pproaches
> > >> but always came back to this as the simplest solution. I expect this=
 will raise
> > >> a few eyebrows but given it is providing a real performance win, I h=
ope we can
> > >> converge to something that can be upstreamed.
> > >>
> > >> This depends on my contpte series to actually set the contiguous bit=
 in the page
> > >> table.
> > >>
> > >> Thanks,
> > >> Ryan
> > >>
> > >>
> > >>  arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
> > >>  include/linux/pgtable.h          | 12 ++++++++++++
> > >>  mm/filemap.c                     | 19 +++++++++++++++++++
> > >>  3 files changed, 43 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/a=
sm/pgtable.h
> > >> index f5bf059291c3..8f8f3f7eb8d8 100644
> > >> --- a/arch/arm64/include/asm/pgtable.h
> > >> +++ b/arch/arm64/include/asm/pgtable.h
> > >> @@ -1143,6 +1143,18 @@ static inline void update_mmu_cache_range(str=
uct vm_fault *vmf,
> > >>   */
> > >>  #define arch_wants_old_prefaulted_pte  cpu_has_hw_af
> > >>
> > >> +/*
> > >> + * Request exec memory is read into pagecache in at least 64K folio=
s. The
> > >> + * trade-off here is performance improvement due to storing transla=
tions more
> > >> + * effciently in the iTLB vs the potential for read amplification d=
ue to reading
> > >> + * data from disk that won't be used. The latter is independent of =
base page
> > >> + * size, so we set a page-size independent block size of 64K. This =
size can be
> > >> + * contpte-mapped when 4K base pages are in use (16 pages into 1 iT=
LB entry),
> > >> + * and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base=
 pages are in
> > >> + * use.
> > >> + */
> > >> +#define arch_wants_exec_folio_order(void) ilog2(SZ_64K >> PAGE_SHIF=
T)
> > >> +
> > >>  static inline bool pud_sect_supported(void)
> > >>  {
> > >>         return PAGE_SIZE =3D=3D SZ_4K;
> > >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > >> index 170925379534..57090616d09c 100644
> > >> --- a/include/linux/pgtable.h
> > >> +++ b/include/linux/pgtable.h
> > >> @@ -428,6 +428,18 @@ static inline bool arch_has_hw_pte_young(void)
> > >>  }
> > >>  #endif
> > >>
> > >> +#ifndef arch_wants_exec_folio_order
> > >> +/*
> > >> + * Returns preferred minimum folio order for executable file-backed=
 memory. Must
> > >> + * be in range [0, PMD_ORDER]. Negative value implies that the HW h=
as no
> > >> + * preference and mm will not special-case executable memory in the=
 pagecache.
> > >> + */
> > >> +static inline int arch_wants_exec_folio_order(void)
> > >> +{
> > >> +       return -1;
> > >> +}
> > >> +#endif
> > >> +
> > >>  #ifndef arch_check_zapped_pte
> > >>  static inline void arch_check_zapped_pte(struct vm_area_struct *vma=
,
> > >>                                          pte_t pte)
> > >> diff --git a/mm/filemap.c b/mm/filemap.c
> > >> index 67ba56ecdd32..80a76d755534 100644
> > >> --- a/mm/filemap.c
> > >> +++ b/mm/filemap.c
> > >> @@ -3115,6 +3115,25 @@ static struct file *do_sync_mmap_readahead(st=
ruct vm_fault *vmf)
> > >>         }
> > >>  #endif
> > >>
> > >> +       /*
> > >> +        * Allow arch to request a preferred minimum folio order for=
 executable
> > >> +        * memory. This can often be beneficial to performance if (e=
.g.) arm64
> > >> +        * can contpte-map the folio. Executable memory rarely benef=
its from
> > >> +        * read-ahead anyway, due to its random access nature.
> > >> +        */
> > >> +       if (vm_flags & VM_EXEC) {
> > >> +               int order =3D arch_wants_exec_folio_order();
> > >> +
> > >> +               if (order >=3D 0) {
> > >> +                       fpin =3D maybe_unlock_mmap_for_io(vmf, fpin)=
;
> > >> +                       ra->size =3D 1UL << order;
> > >> +                       ra->async_size =3D 0;
> > >> +                       ractl._index &=3D ~((unsigned long)ra->size =
- 1);
> > >> +                       page_cache_ra_order(&ractl, ra, order);
> > >> +                       return fpin;
> > >> +               }
> > >> +       }
> > >
> > > I don't know, but most filesystems don't support large mapping,even i=
omap.
> >
> > True, but more are coming. For example ext4 is in the works:
> > https://lore.kernel.org/all/20240102123918.799062-1-yi.zhang@huaweiclou=
d.com/
>
> right, hopefully more filesystems will join.
>
> >
> > > This patch might negatively affect them. i feel we need to check
> > > mapping_large_folio_support() at least.
> >
> > page_cache_ra_order() does this check and falls back to small folios if=
 needed.
> > So correctness-wise it all works out. I guess your concern is performan=
ce due to
> > effectively removing the async readahead aspect? But if that is a probl=
em, then
> > it's not just a problem if we are reading small folios, so I don't thin=
k the
> > proposed check is correct.
>
> My point is that this patch is actually changing two things.
> 1. readahead index/size and async_size=3D0
> 2. try to use CONT-PTE
>
> for filesystems which support large mapping, we are getting 2 to help
> improve performance; for filesystems without large_mapping, 1 has
> been changed from losing read-around,
>         /*
>          * mmap read-around
>          */
>         fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
>         ra->start =3D max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>         ra->size =3D ra->ra_pages;
>         ra->async_size =3D ra->ra_pages / 4;
>         ractl._index =3D ra->start;
>         page_cache_ra_order(&ractl, ra, 0);
>
> We probably need data to prove this makes no regression. otherwise,
> it is safer to let the code have no side effects on other file systems if
> we haven't data.
>
> >
> > Perhaps an alternative would be to double ra->size and set ra->async_si=
ze to
> > (ra->size / 2)? That would ensure we always have 64K aligned blocks but=
 would
> > give us an async portion so readahead can still happen.
>
> this might be worth to try as PMD is exactly doing this because async
> can decrease
> the latency of subsequent page faults.
>
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         /* Use the readahead code, even if readahead is disabled */
>         if (vm_flags & VM_HUGEPAGE) {
>                 fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
>                 ractl._index &=3D ~((unsigned long)HPAGE_PMD_NR - 1);
>                 ra->size =3D HPAGE_PMD_NR;
>                 /*
>                  * Fetch two PMD folios, so we get the chance to actually
>                  * readahead, unless we've been told not to.
>                  */
>                 if (!(vm_flags & VM_RAND_READ))
>                         ra->size *=3D 2;
>                 ra->async_size =3D HPAGE_PMD_NR;
>                 page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
>                 return fpin;
>         }
> #endif
>

BTW, rather than simply always reading backwards,  we did something very
"ugly" to simulate "read-around" for CONT-PTE exec before[1]

if page faults happen in the first half of cont-pte, we read this 64KiB
and its previous 64KiB. otherwise, we read it and its next 64KiB.

struct file *do_cont_pte_sync_mmap_readahead(struct vm_fault *vmf)
{
        ...
        unsigned long haddr =3D vmf->address & HPAGE_CONT_PTE_MASK;
        ...

        if (vmf->address <=3D haddr + HPAGE_CONT_PTE_SIZE / 2) {
                /* Readahead a hugepage forward */
                if (haddr - HPAGE_CONT_PTE_SIZE < vmf->vma->vm_start)
                        goto no_readahead;
                ra->start =3D ALIGN_DOWN(vmf->pgoff, HPAGE_CONT_PTE_NR)
- HPAGE_CONT_PTE_NR;
        } else {
                /* Readahead a hugepage backwards */
                if (haddr + 2 * HPAGE_CONT_PTE_SIZE > vmf->vma->vm_end)
                        goto no_readahead;
                ra->start =3D ALIGN_DOWN(vmf->pgoff, HPAGE_CONT_PTE_NR);
        }
        ra->size =3D 2 * HPAGE_CONT_PTE_NR;
         ...
}

the reason is if we are faulting in the 0nd and 1st subpage at address X,
it seems more sensible to read
aligned(X)- 64KiB           ~                 aligned(X) + 64KiB
than
aligned(X)         ~                 aligned(X) + 128KiB
?

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplu=
s/sm8550_u_14.0.0_oneplus11/mm/cont_pte_hugepage.c#L2338

Thanks
Barry

