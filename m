Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEEC30861E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 08:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhA2G6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhA2G5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:57:54 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57DFC061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 22:57:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so5629335pfg.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 22:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbuleYwe5NvwJojz+4aOt8A66WvfcU/0PeNJr1ClLeM=;
        b=nBYq60FCybEbi705MaQVQBD560R6is7L09GfIIAOZ+XUgkuhtMr6vpKMGJYfpcP2/C
         /tR+5bo1yUoVQkm/j3lecucbC/OOaG9/7VyuZcnzUSASJZXIsekF0oBlwGjtkJCVu2yg
         zDnk/cm8mY41bA/lgcnAYb7WTgQ1pfvIUwwPI420UqWXkgit7AgWRG5v31gzxqf+ymtC
         mN6WlsCyTyxgtc+HIY32Ty1o0RZYFpc43VTnLarPU94L3cdanP4M6ktWN/nc4CSr981d
         DSkx0viJASulvmpQu++VsZtNqzNhJy2AQFQ1I0A7dMHtmAdv3Sbs9a7xNmorN+E46fUC
         LJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbuleYwe5NvwJojz+4aOt8A66WvfcU/0PeNJr1ClLeM=;
        b=eBuo25XwDrt61UIxGc8D4G34KSi3MVVc40ux1IHcXrhBIytjcc9vZNcbj7L+C4EJnP
         itjtewR0+VXLFJV8qUfbC+DXTF3mDGnUWyP9f2EdFIYGmEIv8QP3aeFShDtkxjKgC9Ow
         LSWXM1nlYPMalxzMckJycj5LBlyseCH46BYnjYjh7JF8n0jOXotK1Ob3Id4IzcAOAHdt
         rsOCZ3gjfZxDwRn6Vn45o7gmyMbmKEUZUyBQqz4bNddzh53e8/Aw4CsdXBduX2sPNGQ5
         eJK33GJwgr9AEJKk9NjGNW551gC/INQJye66KBjlX4b+LnlpJiqYxe+BM8apxsOWm2EH
         dQLg==
X-Gm-Message-State: AOAM530xDUIHRlDkM+7hJkuM2e2Wrg5iwSSUN/p5i26uc7/rgoMUdgir
        aqGVpJNPYsFbWCiu/Ki6rugPsYmf7ab+SaM6Yz57jQ==
X-Google-Smtp-Source: ABdhPJzDbWkHuF3yE1SwKxbTcZlixSLpsO95Cov3oCPm9dJ66DrTvWGCs6cK7qWQRkEcJATRiILuvPSB1lQ5oFobVFE=
X-Received: by 2002:a63:50a:: with SMTP id 10mr3283849pgf.273.1611903434093;
 Thu, 28 Jan 2021 22:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com> <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com> <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com> <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com> <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
 <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com> <e200c17e-5c95-025e-37a7-af7cfbb05b18@oracle.com>
In-Reply-To: <e200c17e-5c95-025e-37a7-af7cfbb05b18@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 29 Jan 2021 14:56:35 +0800
Message-ID: <CAMZfGtWvDCaN7M9CHNx3O_OQvH8+HN_xg=uc3aUOUeqqB_--ZQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 29, 2021 at 9:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/28/21 4:37 AM, Muchun Song wrote:
> > On Wed, Jan 27, 2021 at 6:36 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 26.01.21 16:56, David Hildenbrand wrote:
> >>> On 26.01.21 16:34, Oscar Salvador wrote:
> >>>> On Tue, Jan 26, 2021 at 04:10:53PM +0100, David Hildenbrand wrote:
> >>>>> The real issue seems to be discarding the vmemmap on any memory that has
> >>>>> movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, we
> >>>>> can reuse parts of the thingy we're freeing for the vmemmap. Not that it
> >>>>> would be ideal: that once-a-huge-page thing will never ever be a huge page
> >>>>> again - but if it helps with OOM in corner cases, sure.
> >>>>
> >>>> Yes, that is one way, but I am not sure how hard would it be to implement.
> >>>> Plus the fact that as you pointed out, once that memory is used for vmemmap
> >>>> array, we cannot use it again.
> >>>> Actually, we would fragment the memory eventually?
> >>>>
> >>>>> Possible simplification: don't perform the optimization for now with free
> >>>>> huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: what
> >>>>> happens when migrating a huge page from ZONE_NORMAL to (ZONE_MOVABLE|CMA)?
> >>>>
> >>>> But if we do not allow theose pages to be in ZONE_MOVABLE or CMA, there is no
> >>>> point in migrate them, right?
> >>>
> >>> Well, memory unplug "could" still work and migrate them and
> >>> alloc_contig_range() "could in the future" still want to migrate them
> >>> (virtio-mem, gigantic pages, powernv memtrace). Especially, the latter
> >>> two don't work with ZONE_MOVABLE/CMA. But, I mean, it would be fair
> >>> enough to say "there are no guarantees for
> >>> alloc_contig_range()/offline_pages() with ZONE_NORMAL, so we can break
> >>> these use cases when a magic switch is flipped and make these pages
> >>> non-migratable anymore".
> >>>
> >>> I assume compaction doesn't care about huge pages either way, not sure
> >>> about numa balancing etc.
> >>>
> >>>
> >>> However, note that there is a fundamental issue with any approach that
> >>> allocates a significant amount of unmovable memory for user-space
> >>> purposes (excluding CMA allocations for unmovable stuff, CMA is
> >>> special): pairing it with ZONE_MOVABLE becomes very tricky as your user
> >>> space might just end up eating all kernel memory, although the system
> >>> still looks like there is plenty of free memory residing in
> >>> ZONE_MOVABLE. I mentioned that in the context of secretmem in a reduced
> >>> form as well.
> >>>
> >>> We theoretically have that issue with dynamic allocation of gigantic
> >>> pages, but it's something a user explicitly/rarely triggers and it can
> >>> be documented to cause problems well enough. We'll have the same issue
> >>> with GUP+ZONE_MOVABLE that Pavel is fixing right now - but GUP is
> >>> already known to be broken in various ways and that it has to be treated
> >>> in a special way. I'd like to limit the nasty corner cases.
> >>>
> >>> Of course, we could have smart rules like "don't online memory to
> >>> ZONE_MOVABLE automatically when the magic switch is active". That's just
> >>> ugly, but could work.
> >>>
> >>
> >> Extending on that, I just discovered that only x86-64, ppc64, and arm64
> >> really support hugepage migration.
> >>
> >> Maybe one approach with the "magic switch" really would be to disable
> >> hugepage migration completely in hugepage_migration_supported(), and
> >> consequently making hugepage_movable_supported() always return false.
> >>
> >> Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
> >> migrated. The problem I describe would apply (careful with using
> >> ZONE_MOVABLE), but well, it can at least be documented.
> >
> > Thanks for your explanation.
> >
> > All thinking seems to be introduced by encountering OOM. :-(
>
> Yes.  Or, I think about it as the problem of not being able to dissolve (free
> to buddy) a hugetlb page.  We can not dissolve because we can not allocate
> vmemmap for all sumpages.
>
> > In order to move forward and free the hugepage. We should add some
> > restrictions below.
> >
> > 1. Only free the hugepage which is allocated from the ZONE_NORMAL.
> Corrected: Only vmemmap optimize hugepages in ZONE_NORMAL
>
> > 2. Disable hugepage migration when this feature is enabled.
>
> I am not sure if we want to fully disable migration.  I may be misunderstanding
> but the thought was to prevent migration between some movability types.  It
> seems we should be able to migrate form ZONE_NORMAL to ZONE_NORMAL.
>
> Also, if we do allow huge pages without vmemmap optimization in MOVABLE or CMA
> then we should allow those to be migrated to NORMAL?  Or is there a reason why
> we should prevent that.
>
> > 3. Using GFP_ATOMIC to allocate vmemmap pages firstly (it can reduce
> >    memory fragmentation), if it fails, we use part of the hugepage to
> >    remap.
>
> I honestly am not sure about this.  This would only happen for pages in
> NORMAL.  The only time using part of the huge page for vmemmap would help is
> if we are trying to dissolve huge pages to free up memory for other uses.
>
> > What's your opinion about this? Should we take this approach?
>
> I think trying to solve all the issues that could happen as the result of
> not being able to dissolve a hugetlb page has made this extremely complex.
> I know this is something we need to address/solve.  We do not want to add
> more unexpected behavior in corner cases.  However, I can not help but think
> about similar issues today.  For example, if a huge page is in use in
> ZONE_MOVABLE or CMA there is no guarantee that it can be migrated today.
> Correct?  We may need to allocate another huge page for the target of the
> migration, and there is no guarantee we can do that.

Yeah. Adding more restrictions makes things more complex. As you
and Oscar said, refusing to free hugepage when allocating
vmemmap pages fail may be an easy way now.

> --
> Mike Kravetz
