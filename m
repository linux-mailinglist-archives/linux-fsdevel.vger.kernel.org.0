Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70A3E1F1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhHEXF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 19:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbhHEXF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:05:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C33C0613D5;
        Thu,  5 Aug 2021 16:05:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x14so10588975edr.12;
        Thu, 05 Aug 2021 16:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/25GrrZpejuaIsrg2FKQps7AX77zIWY/zjbr34VeZ0=;
        b=OYlhiCc5na6+TZoaOjwRrRFLhTpcLTJeyNGhK8pOEL4zEyuSTH4YgDaIsdrmx+DQb9
         qlfFuCKqCN2JzvA9hn8rKEQ5Srl9DCzFZ67n9xuWESh114yqEShY8jDcQSeo+0TG/w/+
         YD8NHEY45e47v6jtKg8hw10hXocR5Ff0J0Hq1IvxTzylYqWMp9QScv71jPdrj+oI8iSj
         9KXZ/EUFM01cKGDaCI2UDgfHaq5I/yapnAjelRcnUJBF6xUsHpwfAqY818gyKedVVX+j
         bKhvldNEpCi321bWaopX3v6uOnXcgMNkVDy+TGPTR/cYb6aMjXX1fptZysEq3lYsIkuA
         mymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/25GrrZpejuaIsrg2FKQps7AX77zIWY/zjbr34VeZ0=;
        b=bgH9gW0EX2OVv2l8vCGhacOs6S0v6+9MPQAn+XNFYHI6nIivR6RUr5lBcWRzWmeQwp
         Cbqpfh8Tc/L34O5GEz5Mwe9AO4Ttd4BlRBe+aixdcW8nZc1MDdMYVh6KnasQhJqBkRt0
         /2Vb1P32FnSoJqTJrpELp/kOhR/C1is9PSZFp18VykEYhALlrXrm3I7wz2D09bpJUgGT
         I+9QZluCfpcZ9VTWI3wYFyomkTukzOJjVNZY6OVedh7ziWkK1j8oBcu40FhkBHRawqxy
         baWE3j1EzdvW29yZypc/FkVN94LSl+0CZOFCd06EVD5fa2jcEv3nfJ6HMULtJtszTLvM
         xOcw==
X-Gm-Message-State: AOAM531W58+hFgfISyu3dnZWpnbH4F2eOpD2MJdFUMTdEVyBpkrrcEGf
        PgVhyBO65DA2RPHG5PLYujtYKqQU7uVZcFOZM+0=
X-Google-Smtp-Source: ABdhPJzeMfslc8W1NBjLr/ckLSALCSK6iusfJgrcH7RgMYHltEpUwoCpdTUtfeDJeKNnj7EiOyZQXgZXq4yscNH+p6g=
X-Received: by 2002:a50:ce45:: with SMTP id k5mr9452189edj.168.1628204708811;
 Thu, 05 Aug 2021 16:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
 <e7374d7e-4773-aba1-763-8fa2c953f917@google.com> <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
In-Reply-To: <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 5 Aug 2021 16:04:56 -0700
Message-ID: <CAHbLzkqKQ_k_aipojZd=UiHyivaweCpCFJJn7WCWVcxhTijqAQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 2, 2021 at 2:14 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Sat, Jul 31, 2021 at 10:22 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > On Fri, 30 Jul 2021, Yang Shi wrote:
> > > On Fri, Jul 30, 2021 at 12:42 AM Hugh Dickins <hughd@google.com> wrote:
> > > >
> > > > Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
> > > > that a consistent set of checks can be applied, even when the inode is
> > > > accessed through read/write syscalls (with NULL vma) instead of mmaps
> > > > (the index argument is seldom of interest, but required by mount option
> > > > "huge=within_size").  Clean up and rearrange the checks a little.
> > > >
> > > > This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
> > > > were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes: while it's
> > > > still true that khugepaged's collapse_file() at that point wants a small
> > > > page, the race that might allocate it a huge page is too unlikely to be
> > > > worth optimizing against (we are there *because* there was at least one
> > > > small page in the way), and handled by a later PageTransCompound check.
> > >
> > > Yes, it seems too unlikely. But if it happens the PageTransCompound
> > > check may be not good enough since the page allocated by
> > > shmem_getpage() may be charged to wrong memcg (root memcg). And it
> > > won't be replaced by a newly allocated huge page so the wrong charge
> > > can't be undone.
> >
> > Good point on the memcg charge: I hadn't thought of that.  Of course
> > it's not specific to SGP_CACHE versus SGP_NOHUGE (this patch), but I
> > admit that a huge mischarge is hugely worse than a small mischarge.
>
> The small page could be collapsed to a huge page sooner or later, so
> the mischarge may be transient. But huge page can't be replaced.
>
> >
> > We could fix it by making shmem_getpage_gfp() non-static, and pointing
> > to the vma (hence its mm, hence its memcg) here, couldn't we?  Easily
> > done, but I don't really want to make shmem_getpage_gfp() public just
> > for this, for two reasons.
> >
> > One is that the huge race it just so unlikely; and a mischarge to root
> > is not the end of the world, so long as it's not reproducible.  It can
> > only happen on the very first page of the huge extent, and the prior
>
> OK, if so the mischarge is not as bad as what I thought in the first place.
>
> > "Stop if extent has been truncated" check makes sure there was one
> > entry in the extent at that point: so the race with hole-punch can only
> > occur after we xas_unlock_irq(&xas) immediately before shmem_getpage()
> > looks up the page in the tree (and I say hole-punch not truncate,
> > because shmem_getpage()'s i_size check will reject when truncated).
> > I don't doubt that it could happen, but stand by not optimizing against.
>
> I agree the race is so unlikely and it may be not worth optimizing
> against it right now, but a note or a comment may be worth.
>
> >
> > Other reason is that doing shmem_getpage() (or shmem_getpage_gfp())
> > there is unhealthy for unrelated reasons, that I cannot afford to get
> > into sending patches for at this time: but some of our users found the
> > worst-case latencies in collapse_file() intolerable - shmem_getpage()
> > may be reading in from swap, while the locked head of the huge page
> > being built is in the page cache keeping other users waiting.  So,
> > I'd say there's something worse than memcg in that shmem_getpage(),
> > but fixing that cannot be a part of this series.
>
> Yeah, that is a different problem.
>
> >
> > >
> > > And, another question is it seems the newly allocated huge page will
> > > just be uncharged instead of being freed until
> > > "khugepaged_pages_to_scan" pages are scanned. The
> > > khugepaged_prealloc_page() is called to free the allocated huge page
> > > before each call to khugepaged_scan_mm_slot(). But
> > > khugepaged_scan_file() -> collapse_fille() -> khugepaged_alloc_page()
> > > may be called multiple times in the loop in khugepaged_scan_mm_slot(),
> > > so khugepaged_alloc_page() may see that page to trigger VM_BUG IIUC.
> > >
> > > The code is quite convoluted, I'm not sure whether I miss something or
> > > not. And this problem seems very hard to trigger in real life
> > > workload.
> >
> > Just to clarify, those two paragraphs are not about this patch, but about
> > what happens to mm/khugepaged.c's newly allocated huge page, when collapse
> > fails for any reason.
> >
> > Yes, the code is convoluted: that's because it takes very different paths
> > when CONFIG_NUMA=y (when it cannot predict which node to allocate from)
> > and when not NUMA (when it can allocate the huge page at a good unlocked
> > moment, and carry it forward from one attempt to the next).
> >
> > I don't like it at all, the two paths are confusing: sometimes I wonder
> > whether we should just remove the !CONFIG_NUMA path entirely; and other
> > times I wonder in the other direction, whether the CONFIG_NUMA=y path
> > ought to go the other way when it finds nr_node_ids is 1.  Undecided.
>
> I'm supposed it is just performance consideration to keep the
> allocated huge page, but I'm not sure how much the difference would be
> if we remove it (remove the !CONFIG_NUMA path) because the pcp could
> cache THP now since Mel's patch 44042b449872 ("mm/page_alloc: allow
> high-order pages to be stored on the per-cpu lists").
>
> It seems to provide the similar optimization but in the buddy
> allocator layer so that khugepaged doesn't have to maintain its own
> implementation.
>
> >
> > I'm confident that if you work through the two cases (thinking about
> > only one of them at once!), you'll find that the failure paths (not
> > to mention the successful paths) do actually work correctly without
> > leaking (well, maybe the !NUMA path can hold on to one huge page
> > indefinitely, I forget, but I wouldn't count that as leaking).
>
> IIUC the NUMA page could hold on to one huge page indefinitely. But
> I've never seen the BUG personally, so maybe you are right.

By rereading the code, I think you are correct. Both cases do work
correctly without leaking. And the !CONFIG_NUMA case may carry the
huge page indefinitely.

I think it is because khugepaged may collapse memory for another NUMA
node in the next loop, so it doesn't make too much sense to carry the
huge page, but it may be an optimization for !CONFIG_NUMA case.

However, as I mentioned in earlier email the new pcp implementation
could cache THP now, so we might not need keep this convoluted logic
anymore. Just free the page if collapse is failed then re-allocate
THP. The carried THP might improve the success rate a little bit but I
doubt how noticeable it would be, may be not worth for the extra
complexity at all.

>
> >
> > Collapse failure is not uncommon and leaking huge pages gets noticed.
> >
> > Hugh
