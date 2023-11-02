Return-Path: <linux-fsdevel+bounces-1846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340987DF6BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546C6B21260
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B71CFB3;
	Thu,  2 Nov 2023 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heZIPH7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B83C16
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:43:55 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98D18E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:43:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so455091f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698939830; x=1699544630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bk3m+S3BVI0YepGe6edj0t+gZ75ElW9O8iuZr4/MBc=;
        b=heZIPH7hfQRWxJ6yGVJNjfEOA9nKYJQCbhfiKxLlTq0bFm50NmzyMTu4Czj1Tn9qrr
         5e/d2yFayEA+e6tvKmPoFXqtkYsp+i01LmWcT1oM5Sd2is9aF2g+6deyqc0Qck8rkWJK
         cAFSpXVUwweHgWT+JIEuGhKLBNxTQFWWmGNeam4iUzEy0ZgjOjoFN3gEZZd+hE4dAzXx
         7K+/jTEIFY0NcNDxEpoepPlBLTUvMnVFFl3qsbLRdEZXLJpsVx/B6HHUpXyr6ndgrGK5
         /a8mgtaEZuGMx8eNNvUh4GoTctqtQ2b5pUwOBE6VAyjus4Q3NJiATmH3Iu6JeTMrRIgc
         dnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939830; x=1699544630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bk3m+S3BVI0YepGe6edj0t+gZ75ElW9O8iuZr4/MBc=;
        b=oy+r34LpcrpWDhanqKd34j+IVvRyztz4Mw/ZCxgvkp2HigDFMFfaN334K5O9p2FLnP
         7dB6tEbPNkIF6la2pRigg2/h/rTMwVaFb0sjv/2RE9hwQ+ZxZf/a4RQsf8QF5xYOIq7P
         +uAqdkqBpkYuJpq9GIzZtzFsO+4TIme5tO7DrgcsEW1uG7MY19PXX1TMvHTv/BukPw3g
         ftU9tGzRJVTxDam8Gis7pxZLsnLe+tJK+QLdYFtkMlZQLuNTg+prwWyBqR5zCjCbl4eI
         uKOBZISiw2rlW0Ufr7nkvf+fllueMOFLMcVb9nk/Or01fZHbLu1AGLVLSFx0bGTU75/y
         IYKw==
X-Gm-Message-State: AOJu0Yxi/I5X14ZEVKiSt9faIW6BtYxTZiO4Yn0heBR/f+xVHSzmp6Tj
	28mB85pdzijnPBag/1N6pxHdima6/2xXlLyF/XfYJA==
X-Google-Smtp-Source: AGHT+IG/sYBWnJMt1Kuj4efk1jcoqqB3t3c8FBk1lPcenDrwEWQJlEVwyv14DKipOL062Y9BQE2tkdzP0kUzCAd0tcA=
X-Received: by 2002:a5d:64e6:0:b0:32f:7734:a0fa with SMTP id
 g6-20020a5d64e6000000b0032f7734a0famr17350579wri.2.1698939830306; Thu, 02 Nov
 2023 08:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
In-Reply-To: <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Thu, 2 Nov 2023 08:43:36 -0700
Message-ID: <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 7:58=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Wed, Nov 1, 2023 at 7:40=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
> >
> > On Wed, Nov 1, 2023 at 4:08=E2=80=AFPM Sourav Panda <souravpanda@google=
.com> wrote:
> > >
> > > Adds a new per-node PageMetadata field to
> > > /sys/devices/system/node/nodeN/meminfo
> > > and a global PageMetadata field to /proc/meminfo. This information ca=
n
> > > be used by users to see how much memory is being used by per-page
> > > metadata, which can vary depending on build configuration, machine
> > > architecture, and system use.
> > >
> > > Per-page metadata is the amount of memory that Linux needs in order t=
o
> > > manage memory at the page granularity. The majority of such memory is
> > > used by "struct page" and "page_ext" data structures. In contrast to
> > > most other memory consumption statistics, per-page metadata might not
> > > be included in MemTotal. For example, MemTotal does not include membl=
ock
> > > allocations but includes buddy allocations. While on the other hand,
> > > per-page metadata would include both memblock and buddy allocations.
> >
> > I expect that the new PageMetadata field in meminfo should help break
> > down the memory usage of a system (MemUsed, or MemTotal - MemFree),
> > similar to the other fields in meminfo.
> >
> > However, given that PageMetadata includes per-page metadata allocated
> > from not only the buddy allocator, but also the memblock allocations,
> > and MemTotal doesn't include memory reserved by memblock allocations,
> > I wonder how a user can actually use this new PageMetadata to break
> > down the system memory usage.  BTW, it is not robust to assume that
> > all memblock allocations are for per-page metadata.
> >
>
> Hi Wei,
>
> > Here are some ideas to address this problem:
> >
> > - Only report the buddy allocations for per-page medata in PageMetadata=
, or
>
> Making PageMetadata not to contain all per-page memory but just some
> is confusing, especially right after boot it would always be 0, as all
> struct pages are all coming from memblock during boot, yet we know we
> have allocated tons of memory for struct pages.
>
> > - Report per-page metadata in two separate fields in meminfo, one for
> > buddy allocations and another for memblock allocations, or
>
> This is also going to be confusing for the users, it is really
> implementation detail which allocator was used to allocate struct
> pages, and having to trackers is not going to improve things.
>
> > - Change MemTotal/MemUsed to include the memblock reserved memory as we=
ll.
>
> I think this is the right solution for an existing bug: MemTotal
> should really include memblock reserved memory.

Adding reserved memory to MemTotal is a cleaner approach IMO as well.
But it changes the semantics of MemTotal, which may have compatibility
issues.

I think the MemTotal change should be part of this patch series, too.
If it doesn't get accepted, then we need to take one of the first two
approaches (reporting only buddy allocations of per-page metadata or
reporting per-page metadata separately for buddy/memblock allocations)
at least for the Google use cases such that we can use the new
PageMetadata to improve the breakdown of runtime kernel memory
overheads (excluding the boot-time memblock allocations).

> Pasha
>
> >
> > Wei Xu
> >
> > > This memory depends on build configurations, machine architectures, a=
nd
> > > the way system is used:
> > >
> > > Build configuration may include extra fields into "struct page",
> > > and enable / disable "page_ext"
> > > Machine architecture defines base page sizes. For example 4K x86,
> > > 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> > > overhead is smaller on machines with larger page sizes.
> > > System use can change per-page overhead by using vmemmap
> > > optimizations with hugetlb pages, and emulated pmem devdax pages.
> > > Also, boot parameters can determine whether page_ext is needed
> > > to be allocated. This memory can be part of MemTotal or be outside
> > > MemTotal depending on whether the memory was hot-plugged, booted with=
,
> > > or hugetlb memory was returned back to the system.
> > >
> > > Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Signed-off-by: Sourav Panda <souravpanda@google.com>
> > > ---
> > >  Documentation/filesystems/proc.rst |  3 +++
> > >  drivers/base/node.c                |  2 ++
> > >  fs/proc/meminfo.c                  |  7 +++++++
> > >  include/linux/mmzone.h             |  3 +++
> > >  include/linux/vmstat.h             |  4 ++++
> > >  mm/hugetlb.c                       | 11 ++++++++--
> > >  mm/hugetlb_vmemmap.c               | 12 +++++++++--
> > >  mm/mm_init.c                       |  3 +++
> > >  mm/page_alloc.c                    |  1 +
> > >  mm/page_ext.c                      | 32 +++++++++++++++++++++-------=
--
> > >  mm/sparse-vmemmap.c                |  3 +++
> > >  mm/sparse.c                        |  7 ++++++-
> > >  mm/vmstat.c                        | 24 ++++++++++++++++++++++
> > >  13 files changed, 98 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/files=
ystems/proc.rst
> > > index 2b59cff8be17..c121f2ef9432 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -987,6 +987,7 @@ Example output. You may not have all of these fie=
lds.
> > >      AnonPages:       4654780 kB
> > >      Mapped:           266244 kB
> > >      Shmem:              9976 kB
> > > +    PageMetadata:     513419 kB
> > >      KReclaimable:     517708 kB
> > >      Slab:             660044 kB
> > >      SReclaimable:     517708 kB
> > > @@ -1089,6 +1090,8 @@ Mapped
> > >                files which have been mmapped, such as libraries
> > >  Shmem
> > >                Total memory used by shared memory (shmem) and tmpfs
> > > +PageMetadata
> > > +              Memory used for per-page metadata
> > >  KReclaimable
> > >                Kernel allocations that the kernel will attempt to rec=
laim
> > >                under memory pressure. Includes SReclaimable (below), =
and other
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index 493d533f8375..da728542265f 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device *d=
ev,
> > >                              "Node %d Mapped:         %8lu kB\n"
> > >                              "Node %d AnonPages:      %8lu kB\n"
> > >                              "Node %d Shmem:          %8lu kB\n"
> > > +                            "Node %d PageMetadata:   %8lu kB\n"
> > >                              "Node %d KernelStack:    %8lu kB\n"
> > >  #ifdef CONFIG_SHADOW_CALL_STACK
> > >                              "Node %d ShadowCallStack:%8lu kB\n"
> > > @@ -458,6 +459,7 @@ static ssize_t node_read_meminfo(struct device *d=
ev,
> > >                              nid, K(node_page_state(pgdat, NR_FILE_MA=
PPED)),
> > >                              nid, K(node_page_state(pgdat, NR_ANON_MA=
PPED)),
> > >                              nid, K(i.sharedram),
> > > +                            nid, K(node_page_state(pgdat, NR_PAGE_ME=
TADATA)),
> > >                              nid, node_page_state(pgdat, NR_KERNEL_ST=
ACK_KB),
> > >  #ifdef CONFIG_SHADOW_CALL_STACK
> > >                              nid, node_page_state(pgdat, NR_KERNEL_SC=
S_KB),
> > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > index 45af9a989d40..f141bb2a550d 100644
> > > --- a/fs/proc/meminfo.c
> > > +++ b/fs/proc/meminfo.c
> > > @@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, vo=
id *v)
> > >         long available;
> > >         unsigned long pages[NR_LRU_LISTS];
> > >         unsigned long sreclaimable, sunreclaim;
> > > +       unsigned long nr_page_metadata;
> > >         int lru;
> > > +       int nid;
> > >
> > >         si_meminfo(&i);
> > >         si_swapinfo(&i);
> > > @@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file *m, v=
oid *v)
> > >         sreclaimable =3D global_node_page_state_pages(NR_SLAB_RECLAIM=
ABLE_B);
> > >         sunreclaim =3D global_node_page_state_pages(NR_SLAB_UNRECLAIM=
ABLE_B);
> > >
> > > +       nr_page_metadata =3D 0;
> > > +       for_each_online_node(nid)
> > > +               nr_page_metadata +=3D node_page_state(NODE_DATA(nid),=
 NR_PAGE_METADATA);
> > > +
> > >         show_val_kb(m, "MemTotal:       ", i.totalram);
> > >         show_val_kb(m, "MemFree:        ", i.freeram);
> > >         show_val_kb(m, "MemAvailable:   ", available);
> > > @@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file *m, =
void *v)
> > >         show_val_kb(m, "Mapped:         ",
> > >                     global_node_page_state(NR_FILE_MAPPED));
> > >         show_val_kb(m, "Shmem:          ", i.sharedram);
> > > +       show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
> > >         show_val_kb(m, "KReclaimable:   ", sreclaimable +
> > >                     global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE=
));
> > >         show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim)=
;
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 4106fbc5b4b3..dda1ad522324 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -207,6 +207,9 @@ enum node_stat_item {
> > >         PGPROMOTE_SUCCESS,      /* promote successfully */
> > >         PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> > >  #endif
> > > +       NR_PAGE_METADATA,       /* Page metadata size (struct page an=
d page_ext)
> > > +                                * in pages
> > > +                                */
> > >         NR_VM_NODE_STAT_ITEMS
> > >  };
> > >
> > > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > > index fed855bae6d8..af096a881f03 100644
> > > --- a/include/linux/vmstat.h
> > > +++ b/include/linux/vmstat.h
> > > @@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct f=
olio *folio,
> > >  {
> > >         lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
> > >  }
> > > +
> > > +void __init mod_node_early_perpage_metadata(int nid, long delta);
> > > +void __init store_early_perpage_metadata(void);
> > > +
> > >  #endif /* _LINUX_VMSTAT_H */
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 1301ba7b2c9a..1778e02ed583 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1790,6 +1790,9 @@ static void __update_and_free_hugetlb_folio(str=
uct hstate *h,
> > >                 destroy_compound_gigantic_folio(folio, huge_page_orde=
r(h));
> > >                 free_gigantic_folio(folio, huge_page_order(h));
> > >         } else {
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > +               __node_stat_sub_folio(folio, NR_PAGE_METADATA);
> > > +#endif
> > >                 __free_pages(&folio->page, huge_page_order(h));
> > >         }
> > >  }
> > > @@ -2125,6 +2128,7 @@ static struct folio *alloc_buddy_hugetlb_folio(=
struct hstate *h,
> > >         struct page *page;
> > >         bool alloc_try_hard =3D true;
> > >         bool retry =3D true;
> > > +       struct folio *folio;
> > >
> > >         /*
> > >          * By default we always try hard to allocate the page with
> > > @@ -2175,9 +2179,12 @@ static struct folio *alloc_buddy_hugetlb_folio=
(struct hstate *h,
> > >                 __count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
> > >                 return NULL;
> > >         }
> > > -
> > > +       folio =3D page_folio(page);
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > +       __node_stat_add_folio(folio, NR_PAGE_METADATA);
> > > +#endif
> > >         __count_vm_event(HTLB_BUDDY_PGALLOC);
> > > -       return page_folio(page);
> > > +       return folio;
> > >  }
> > >
> > >  /*
> > > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > > index 4b9734777f69..f7ca5d4dd583 100644
> > > --- a/mm/hugetlb_vmemmap.c
> > > +++ b/mm/hugetlb_vmemmap.c
> > > @@ -214,6 +214,7 @@ static inline void free_vmemmap_page(struct page =
*page)
> > >                 free_bootmem_page(page);
> > >         else
> > >                 __free_page(page);
> > > +       __mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1)=
;
> > >  }
> > >
> > >  /* Free a list of the vmemmap pages */
> > > @@ -335,6 +336,7 @@ static int vmemmap_remap_free(unsigned long start=
, unsigned long end,
> > >                 copy_page(page_to_virt(walk.reuse_page),
> > >                           (void *)walk.reuse_addr);
> > >                 list_add(&walk.reuse_page->lru, &vmemmap_pages);
> > > +               __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADAT=
A, 1);
> > >         }
> > >
> > >         /*
> > > @@ -384,14 +386,20 @@ static int alloc_vmemmap_page_list(unsigned lon=
g start, unsigned long end,
> > >         unsigned long nr_pages =3D (end - start) >> PAGE_SHIFT;
> > >         int nid =3D page_to_nid((struct page *)start);
> > >         struct page *page, *next;
> > > +       int i;
> > >
> > > -       while (nr_pages--) {
> > > +       for (i =3D 0; i < nr_pages; i++) {
> > >                 page =3D alloc_pages_node(nid, gfp_mask, 0);
> > > -               if (!page)
> > > +               if (!page) {
> > > +                       __mod_node_page_state(NODE_DATA(nid), NR_PAGE=
_METADATA,
> > > +                                             i);
> > >                         goto out;
> > > +               }
> > >                 list_add_tail(&page->lru, list);
> > >         }
> > >
> > > +       __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, nr_pa=
ges);
> > > +
> > >         return 0;
> > >  out:
> > >         list_for_each_entry_safe(page, next, list, lru)
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 50f2f34745af..6997bf00945b 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/pgtable.h>
> > >  #include <linux/swap.h>
> > >  #include <linux/cma.h>
> > > +#include <linux/vmstat.h>
> > >  #include "internal.h"
> > >  #include "slab.h"
> > >  #include "shuffle.h"
> > > @@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pg=
list_data *pgdat)
> > >                         panic("Failed to allocate %ld bytes for node =
%d memory map\n",
> > >                               size, pgdat->node_id);
> > >                 pgdat->node_mem_map =3D map + offset;
> > > +               mod_node_early_perpage_metadata(pgdat->node_id,
> > > +                                               DIV_ROUND_UP(size, PA=
GE_SIZE));
> > >         }
> > >         pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
> > >                                 __func__, pgdat->node_id, (unsigned l=
ong)pgdat,
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 85741403948f..522dc0c52610 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5443,6 +5443,7 @@ void __init setup_per_cpu_pageset(void)
> > >         for_each_online_pgdat(pgdat)
> > >                 pgdat->per_cpu_nodestats =3D
> > >                         alloc_percpu(struct per_cpu_nodestat);
> > > +       store_early_perpage_metadata();
> > >  }
> > >
> > >  __meminit void zone_pcp_init(struct zone *zone)
> > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > index 4548fcc66d74..d8d6db9c3d75 100644
> > > --- a/mm/page_ext.c
> > > +++ b/mm/page_ext.c
> > > @@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
> > >                 return -ENOMEM;
> > >         NODE_DATA(nid)->node_page_ext =3D base;
> > >         total_usage +=3D table_size;
> > > +       __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > > +                             DIV_ROUND_UP(table_size, PAGE_SIZE));
> > >         return 0;
> > >  }
> > >
> > > @@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t si=
ze, int nid)
> > >         void *addr =3D NULL;
> > >
> > >         addr =3D alloc_pages_exact_nid(nid, size, flags);
> > > -       if (addr) {
> > > +       if (addr)
> > >                 kmemleak_alloc(addr, size, 1, flags);
> > > -               return addr;
> > > -       }
> > > +       else
> > > +               addr =3D vzalloc_node(size, nid);
> > >
> > > -       addr =3D vzalloc_node(size, nid);
> > > +       if (addr) {
> > > +               mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > > +                                   DIV_ROUND_UP(size, PAGE_SIZE));
> > > +       }
> > >
> > >         return addr;
> > >  }
> > > @@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsi=
gned long pfn, int nid)
> > >
> > >  static void free_page_ext(void *addr)
> > >  {
> > > +       size_t table_size;
> > > +       struct page *page;
> > > +       struct pglist_data *pgdat;
> > > +
> > > +       table_size =3D page_ext_size * PAGES_PER_SECTION;
> > > +
> > >         if (is_vmalloc_addr(addr)) {
> > > +               page =3D vmalloc_to_page(addr);
> > > +               pgdat =3D page_pgdat(page);
> > >                 vfree(addr);
> > >         } else {
> > > -               struct page *page =3D virt_to_page(addr);
> > > -               size_t table_size;
> > > -
> > > -               table_size =3D page_ext_size * PAGES_PER_SECTION;
> > > -
> > > +               page =3D virt_to_page(addr);
> > > +               pgdat =3D page_pgdat(page);
> > >                 BUG_ON(PageReserved(page));
> > >                 kmemleak_free(addr);
> > >                 free_pages_exact(addr, table_size);
> > >         }
> > > +
> > > +       __mod_node_page_state(pgdat, NR_PAGE_METADATA,
> > > +                             -1L * (DIV_ROUND_UP(table_size, PAGE_SI=
ZE)));
> > > +
> > >  }
> > >
> > >  static void __free_page_ext(unsigned long pfn)
> > > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > > index a2cbe44c48e1..2bc67b2c2aa2 100644
> > > --- a/mm/sparse-vmemmap.c
> > > +++ b/mm/sparse-vmemmap.c
> > > @@ -469,5 +469,8 @@ struct page * __meminit __populate_section_memmap=
(unsigned long pfn,
> > >         if (r < 0)
> > >                 return NULL;
> > >
> > > +       __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > > +                             DIV_ROUND_UP(end - start, PAGE_SIZE));
> > > +
> > >         return pfn_to_page(pfn);
> > >  }
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index 77d91e565045..7f67b5486cd1 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -14,7 +14,7 @@
> > >  #include <linux/swap.h>
> > >  #include <linux/swapops.h>
> > >  #include <linux/bootmem_info.h>
> > > -
> > > +#include <linux/vmstat.h>
> > >  #include "internal.h"
> > >  #include <asm/dma.h>
> > >
> > > @@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned lo=
ng size, int nid)
> > >          */
> > >         sparsemap_buf =3D memmap_alloc(size, section_map_size(), addr=
, nid, true);
> > >         sparsemap_buf_end =3D sparsemap_buf + size;
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > +       mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_=
SIZE));
> > > +#endif
> > >  }
> > >
> > >  static void __init sparse_buffer_fini(void)
> > > @@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned lo=
ng pfn, unsigned long nr_pages,
> > >         unsigned long start =3D (unsigned long) pfn_to_page(pfn);
> > >         unsigned long end =3D start + nr_pages * sizeof(struct page);
> > >
> > > +       __mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_PAGE_M=
ETADATA,
> > > +                             -1L * (DIV_ROUND_UP(end - start, PAGE_S=
IZE)));
> > >         vmemmap_free(start, end, altmap);
> > >  }
> > >  static void free_map_bootmem(struct page *memmap)
> > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > index 00e81e99c6ee..070d2b3d2bcc 100644
> > > --- a/mm/vmstat.c
> > > +++ b/mm/vmstat.c
> > > @@ -1245,6 +1245,7 @@ const char * const vmstat_text[] =3D {
> > >         "pgpromote_success",
> > >         "pgpromote_candidate",
> > >  #endif
> > > +       "nr_page_metadata",
> > >
> > >         /* enum writeback_stat_item counters */
> > >         "nr_dirty_threshold",
> > > @@ -2274,4 +2275,27 @@ static int __init extfrag_debug_init(void)
> > >  }
> > >
> > >  module_init(extfrag_debug_init);
> > > +
> > >  #endif
> > > +
> > > +/*
> > > + * Page metadata size (struct page and page_ext) in pages
> > > + */
> > > +static unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata=
;
> > > +
> > > +void __init mod_node_early_perpage_metadata(int nid, long delta)
> > > +{
> > > +       early_perpage_metadata[nid] +=3D delta;
> > > +}
> > > +
> > > +void __init store_early_perpage_metadata(void)
> > > +{
> > > +       int nid;
> > > +       struct pglist_data *pgdat;
> > > +
> > > +       for_each_online_pgdat(pgdat) {
> > > +               nid =3D pgdat->node_id;
> > > +               __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADAT=
A,
> > > +                                     early_perpage_metadata[nid]);
> > > +       }
> > > +}
> > > --
> > > 2.42.0.820.g83a721a137-goog
> > >

