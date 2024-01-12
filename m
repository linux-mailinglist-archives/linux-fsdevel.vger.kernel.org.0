Return-Path: <linux-fsdevel+bounces-7892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C652F82C702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 23:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2539F1F23988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6617731;
	Fri, 12 Jan 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajy3kdZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30915AE3;
	Fri, 12 Jan 2024 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed5d1ffb0so6603960276.1;
        Fri, 12 Jan 2024 14:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705097593; x=1705702393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvOCHmUc0lLvZimXZvMNfX+hZiconfYp5v7rp8iwL5k=;
        b=ajy3kdZQqsdGajpOkCG+iqOmUD3b8g82YhdeAVbkxZ9hJ8lgbfkGZbFgLC9J5oIERM
         YAH8w76lhWOpGHamx8dWWckhNostOKkewunFtYlB13h05Gz/z9eFqu1A5b7EZ43ahqfe
         gJ3v26sxz2vHRKyxJGg11gWC/8i1VVD3EN+T2X/34Vc7GRtOYwfVJA8GW+C1V+ftrfum
         ZAGfzbR3vlLMm+c+CvCuZDhGaxCiEfaXtgYnK5gSfgqs7Msc/zzADsnp5BnYXLzSpkTQ
         5Ugsuf48nLPYf2n+czc7EjoT6Rz9f94RCajg0B+z5xMDWfrF00C1lrAwhN9hBgxG2IB8
         CZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097593; x=1705702393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvOCHmUc0lLvZimXZvMNfX+hZiconfYp5v7rp8iwL5k=;
        b=drLdyzwYsar8WbC85PIjOKnNWWIoWwW+knNCnoUc+dePj0Z9U8My8a27NwPvEykDmo
         g7ZGXELb8VC3yctQmp8JfvD/V1DkeS4j3aSbDuvXaICHukiNh8RgqZ3Ac1nDwzyKo0YM
         1tWc/RTBY8nzCPniH+D1h26Fj/fqbpxvp6m32cClxlbLhPNbd5xFGDZfMn/uRbiMGuio
         uhdYRXvqGcDakhEie4TXo40nvQ/0dPMNazL4XKJyvsPkd/VuEqwz3Jxb72A6hHq/KSRg
         w+TuYHaXQkFIwZWJ3QsR6cuvQ92OQBiev+mHUS4NKuzw9MJnVqsvyDWVTZ2obVjkr12L
         Pctg==
X-Gm-Message-State: AOJu0Yy1XujfutvVFV6GZJ5R0mZFQcMtm0o/HFAKFQ9OGdIGJnALsI5J
	6ZIi6K7GaTCKabQn9wF6Z9nbwuac/Yh2WSQ+pZU=
X-Google-Smtp-Source: AGHT+IHC3gA4oy6vewLDEr58W+knh0O1swPVnISiPtzYc7c8rvKGBileTPTfqqeAQ/jZ+JosheFztvyAMbu9iudYYE4=
X-Received: by 2002:a25:ef45:0:b0:dbd:5cd8:1a4f with SMTP id
 w5-20020a25ef45000000b00dbd5cd81a4fmr1268714ybm.54.1705097592997; Fri, 12 Jan
 2024 14:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154106.3692206-1-ryan.roberts@arm.com>
 <CAGsJ_4xPgmgt57sw2c5==bPN+YL23zn=hZweu8u2ceWei7+q4g@mail.gmail.com> <654df189-e472-4a75-b2be-6faa8ba18a08@arm.com>
In-Reply-To: <654df189-e472-4a75-b2be-6faa8ba18a08@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 13 Jan 2024 11:13:01 +1300
Message-ID: <CAGsJ_4zyK4kSF4XYWwLTLN8816KL+u=p6WhyEsRu8PMnQTNRUg@mail.gmail.com>
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

On Sat, Jan 13, 2024 at 12:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 12/01/2024 10:13, Barry Song wrote:
> > On Fri, Jan 12, 2024 at 4:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Change the readahead config so that if it is being requested for an
> >> executable mapping, do a synchronous read of an arch-specified size in=
 a
> >> naturally aligned manner.
> >>
> >> On arm64 if memory is physically contiguous and naturally aligned to t=
he
> >> "contpte" size, we can use contpte mappings, which improves utilizatio=
n
> >> of the TLB. When paired with the "multi-size THP" changes, this works
> >> well to reduce dTLB pressure. However iTLB pressure is still high due =
to
> >> executable mappings having a low liklihood of being in the required
> >> folio size and mapping alignment, even when the filesystem supports
> >> readahead into large folios (e.g. XFS).
> >>
> >> The reason for the low liklihood is that the current readahead algorit=
hm
> >> starts with an order-2 folio and increases the folio order by 2 every
> >> time the readahead mark is hit. But most executable memory is faulted =
in
> >> fairly randomly and so the readahead mark is rarely hit and most
> >> executable folios remain order-2. This is observed impirically and
> >> confirmed from discussion with a gnu linker expert; in general, the
> >> linker does nothing to group temporally accessed text together
> >> spacially. Additionally, with the current read-around approach there a=
re
> >> no alignment guarrantees between the file and folio. This is
> >> insufficient for arm64's contpte mapping requirement (order-4 for 4K
> >> base pages).
> >>
> >> So it seems reasonable to special-case the read(ahead) logic for
> >> executable mappings. The trade-off is performance improvement (due to
> >> more efficient storage of the translations in iTLB) vs potential read
> >> amplification (due to reading too much data around the fault which won=
't
> >> be used), and the latter is independent of base page size. I've chosen
> >> 64K folio size for arm64 which benefits both the 4K and 16K base page
> >> size configs and shouldn't lead to any further read-amplification sinc=
e
> >> the old read-around path was (usually) reading blocks of 128K (with th=
e
> >> last 32K being async).
> >>
> >> Performance Benchmarking
> >> ------------------------
> >>
> >> The below shows kernel compilation and speedometer javascript benchmar=
ks
> >> on Ampere Altra arm64 system. (The contpte patch series is applied in
> >> the baseline).
> >>
> >> First, confirmation that this patch causes more memory to be contained
> >> in 64K folios (this is for all file-backed memory so includes
> >> non-executable too):
> >>
> >> | File-backed folios      |   Speedometer   |  Kernel Compile |
> >> | by size as percentage   |-----------------|-----------------|
> >> | of all mapped file mem  | before |  after | before |  after |
> >> |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=
=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D|
> >> |file-thp-aligned-16kB    |    45% |     9% |    46% |     7% |
> >> |file-thp-aligned-32kB    |     2% |     0% |     3% |     1% |
> >> |file-thp-aligned-64kB    |     3% |    63% |     5% |    80% |
> >> |file-thp-aligned-128kB   |    11% |    11% |     0% |     0% |
> >> |file-thp-unaligned-16kB  |     1% |     0% |     3% |     1% |
> >> |file-thp-unaligned-128kB |     1% |     0% |     0% |     0% |
> >> |file-thp-partial         |     0% |     0% |     0% |     0% |
> >> |-------------------------|--------|--------|--------|--------|
> >> |file-cont-aligned-64kB   |    16% |    75% |     5% |    80% |
> >>
> >> The above shows that for both use cases, the amount of file memory
> >> backed by 16K folios reduces and the amount backed by 64K folios
> >> increases significantly. And the amount of memory that is contpte-mapp=
ed
> >> significantly increases (last line).
> >>
> >> And this is reflected in performance improvement:
> >>
> >> Kernel Compilation (smaller is faster):
> >> | kernel   |   real-time |   kern-time |   user-time |   peak memory |
> >> |----------|-------------|-------------|-------------|---------------|
> >> | before   |        0.0% |        0.0% |        0.0% |          0.0% |
> >> | after    |       -1.6% |       -2.1% |       -1.7% |          0.0% |
> >>
> >> Speedometer (bigger is faster):
> >> | kernel   |   runs_per_min |   peak memory |
> >> |----------|----------------|---------------|
> >> | before   |           0.0% |          0.0% |
> >> | after    |           1.3% |          1.0% |
> >>
> >> Both benchmarks show a ~1.5% improvement once the patch is applied.
> >>
> >> Alternatives
> >> ------------
> >>
> >> I considered (and rejected for now - but I anticipate this patch will
> >> stimulate discussion around what the best approach is) alternative
> >> approaches:
> >>
> >>   - Expose a global user-controlled knob to set the preferred folio
> >>     size; this would move policy to user space and allow (e.g.) settin=
g
> >>     it to PMD-size for even better iTLB utilizaiton. But this would ad=
d
> >>     ABI, and I prefer to start with the simplest approach first. It al=
so
> >>     has the downside that a change wouldn't apply to memory already in
> >>     the page cache that is in active use (e.g. libc) so we don't get t=
he
> >>     same level of utilization as for something that is fixed from boot=
.
> >>
> >>   - Add a per-vma attribute to allow user space to specify preferred
> >>     folio size for memory faulted from the range. (we've talked about
> >>     such a control in the context of mTHP). The dynamic loader would
> >>     then be responsible for adding the annotations. Again this feels
> >>     like something that could be added later if value was demonstrated=
.
> >>
> >>   - Enhance MADV_COLLAPSE to collapse to THP sizes less than PMD-size.
> >>     This would still require dynamic linker involvement, but would
> >>     additionally neccessitate a copy and all memory in the range would
> >>     be synchronously faulted in, adding to application load time. It
> >>     would work for filesystems that don't support large folios though.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>
> >> Hi all,
> >>
> >> I originally concocted something similar to this, with Matthew's help,=
 as a
> >> quick proof of concept hack. Since then I've tried a few different app=
roaches
> >> but always came back to this as the simplest solution. I expect this w=
ill raise
> >> a few eyebrows but given it is providing a real performance win, I hop=
e we can
> >> converge to something that can be upstreamed.
> >>
> >> This depends on my contpte series to actually set the contiguous bit i=
n the page
> >> table.
> >>
> >> Thanks,
> >> Ryan
> >>
> >>
> >>  arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
> >>  include/linux/pgtable.h          | 12 ++++++++++++
> >>  mm/filemap.c                     | 19 +++++++++++++++++++
> >>  3 files changed, 43 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm=
/pgtable.h
> >> index f5bf059291c3..8f8f3f7eb8d8 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -1143,6 +1143,18 @@ static inline void update_mmu_cache_range(struc=
t vm_fault *vmf,
> >>   */
> >>  #define arch_wants_old_prefaulted_pte  cpu_has_hw_af
> >>
> >> +/*
> >> + * Request exec memory is read into pagecache in at least 64K folios.=
 The
> >> + * trade-off here is performance improvement due to storing translati=
ons more
> >> + * effciently in the iTLB vs the potential for read amplification due=
 to reading
> >> + * data from disk that won't be used. The latter is independent of ba=
se page
> >> + * size, so we set a page-size independent block size of 64K. This si=
ze can be
> >> + * contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB=
 entry),
> >> + * and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base p=
ages are in
> >> + * use.
> >> + */
> >> +#define arch_wants_exec_folio_order(void) ilog2(SZ_64K >> PAGE_SHIFT)
> >> +
> >>  static inline bool pud_sect_supported(void)
> >>  {
> >>         return PAGE_SIZE =3D=3D SZ_4K;
> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >> index 170925379534..57090616d09c 100644
> >> --- a/include/linux/pgtable.h
> >> +++ b/include/linux/pgtable.h
> >> @@ -428,6 +428,18 @@ static inline bool arch_has_hw_pte_young(void)
> >>  }
> >>  #endif
> >>
> >> +#ifndef arch_wants_exec_folio_order
> >> +/*
> >> + * Returns preferred minimum folio order for executable file-backed m=
emory. Must
> >> + * be in range [0, PMD_ORDER]. Negative value implies that the HW has=
 no
> >> + * preference and mm will not special-case executable memory in the p=
agecache.
> >> + */
> >> +static inline int arch_wants_exec_folio_order(void)
> >> +{
> >> +       return -1;
> >> +}
> >> +#endif
> >> +
> >>  #ifndef arch_check_zapped_pte
> >>  static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
> >>                                          pte_t pte)
> >> diff --git a/mm/filemap.c b/mm/filemap.c
> >> index 67ba56ecdd32..80a76d755534 100644
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -3115,6 +3115,25 @@ static struct file *do_sync_mmap_readahead(stru=
ct vm_fault *vmf)
> >>         }
> >>  #endif
> >>
> >> +       /*
> >> +        * Allow arch to request a preferred minimum folio order for e=
xecutable
> >> +        * memory. This can often be beneficial to performance if (e.g=
.) arm64
> >> +        * can contpte-map the folio. Executable memory rarely benefit=
s from
> >> +        * read-ahead anyway, due to its random access nature.
> >> +        */
> >> +       if (vm_flags & VM_EXEC) {
> >> +               int order =3D arch_wants_exec_folio_order();
> >> +
> >> +               if (order >=3D 0) {
> >> +                       fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
> >> +                       ra->size =3D 1UL << order;
> >> +                       ra->async_size =3D 0;
> >> +                       ractl._index &=3D ~((unsigned long)ra->size - =
1);
> >> +                       page_cache_ra_order(&ractl, ra, order);
> >> +                       return fpin;
> >> +               }
> >> +       }
> >
> > I don't know, but most filesystems don't support large mapping,even iom=
ap.
>
> True, but more are coming. For example ext4 is in the works:
> https://lore.kernel.org/all/20240102123918.799062-1-yi.zhang@huaweicloud.=
com/

right, hopefully more filesystems will join.

>
> > This patch might negatively affect them. i feel we need to check
> > mapping_large_folio_support() at least.
>
> page_cache_ra_order() does this check and falls back to small folios if n=
eeded.
> So correctness-wise it all works out. I guess your concern is performance=
 due to
> effectively removing the async readahead aspect? But if that is a problem=
, then
> it's not just a problem if we are reading small folios, so I don't think =
the
> proposed check is correct.

My point is that this patch is actually changing two things.
1. readahead index/size and async_size=3D0
2. try to use CONT-PTE

for filesystems which support large mapping, we are getting 2 to help
improve performance; for filesystems without large_mapping, 1 has
been changed from losing read-around,
        /*
         * mmap read-around
         */
        fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
        ra->start =3D max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
        ra->size =3D ra->ra_pages;
        ra->async_size =3D ra->ra_pages / 4;
        ractl._index =3D ra->start;
        page_cache_ra_order(&ractl, ra, 0);

We probably need data to prove this makes no regression. otherwise,
it is safer to let the code have no side effects on other file systems if
we haven't data.

>
> Perhaps an alternative would be to double ra->size and set ra->async_size=
 to
> (ra->size / 2)? That would ensure we always have 64K aligned blocks but w=
ould
> give us an async portion so readahead can still happen.

this might be worth to try as PMD is exactly doing this because async
can decrease
the latency of subsequent page faults.

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
        /* Use the readahead code, even if readahead is disabled */
        if (vm_flags & VM_HUGEPAGE) {
                fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
                ractl._index &=3D ~((unsigned long)HPAGE_PMD_NR - 1);
                ra->size =3D HPAGE_PMD_NR;
                /*
                 * Fetch two PMD folios, so we get the chance to actually
                 * readahead, unless we've been told not to.
                 */
                if (!(vm_flags & VM_RAND_READ))
                        ra->size *=3D 2;
                ra->async_size =3D HPAGE_PMD_NR;
                page_cache_ra_order(&ractl, ra, HPAGE_PMD_ORDER);
                return fpin;
        }
#endif

>
> I don't feel very expert with this area of the code so I might be talking
> rubbish - would be great to hear from others.
>
> >
> >> +
> >>         /* If we don't want any read-ahead, don't bother */
> >>         if (vm_flags & VM_RAND_READ)
> >>                 return fpin;
> >> --
> >> 2.25.1
> >

BTW, is it also possible that user space also wants to map some data
as cont-pte hugepage? just like we have a strong VM_HUGEPAGE
flag for PMD THP?

Thanks
Barry

