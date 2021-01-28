Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13953076C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhA1NJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 08:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhA1NJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:09:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240FC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 05:09:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id my11so4748178pjb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wV6oz0k6223jz7bAL5Zk8NtAtXo6+ezaMn2fhP1oIYw=;
        b=LC3TkXKy3vn5GvO4Kf87XAOF7u+IP4qG3NOTmirr40/P/+XPyRG5SDdGc0xFE1cHzH
         x5korc+db7u6Jg0h5ILb8wHVnJPZoRTCcjqqufpBVYaBcu3M97Nxel7VCt5w/FlLY1eW
         HZ6M99/NpP2WRtl2d6UH0ByzCBG86H0E2YucVJ4Q2EXwE3VgBpnDydWwZtoo4c8vWi8/
         RvIlU+znzcboc0Yh8QxfNNH8UbjIWjr1OkTDbxt3PU3UmW2PclQszMys1ZSv8glvYbk6
         OWaYKN3NgoDEUUFpXKZFEoFBIGnGUHi87LSDbF5nBI9fPA1TJ7gs+avJKhwjP02wdMgh
         U//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wV6oz0k6223jz7bAL5Zk8NtAtXo6+ezaMn2fhP1oIYw=;
        b=ph4RLp94NCckIL/WCpTKWj9nELGVRj0DnVh8C5RRIl7NvIX4z/uQ0uXb9W/5vmSH7V
         ciItogUD4Fqgw/I8GN0gOeBe/Hw3PBV0wSg+dtgvp4NKVqtMvHP4RMA4boulIfenFtJs
         2KUT1KtMSs7e/vWH3VvTpvzKpHmPkDSXzAlYR9Eok8pEC//9nWA1We5a3Z94miZErcUk
         gZYXPAAxWkbMa3BBKZvp+yZfpVa9RZgEkMjRI9/6l9QDgzbNypGzZoTf6M0KHC6RpybS
         Xpe+Q97dHDcHvGCJy+l0uPDJ0YnSvR6+Q2zfmXTNI33GrJttxX+ZcRZsLTbyPmxG0pZG
         2irA==
X-Gm-Message-State: AOAM531dvNS9t5PfNAg74DVKeCFfTq6XMS/LU5T4f1eTKDwDp24SFdda
        0roHpctcJ+aqeSIN0XMuctPttQF6ktJZa52ffqAiZQ==
X-Google-Smtp-Source: ABdhPJyufgziyJlqzFS90vCqlwRzjRmjfQIf+qHC8gEyNqlz6n+25WRZktQ7hAQucfD1mMlI+eOC+QOtDcYv/xXSLn8=
X-Received: by 2002:a17:90a:808a:: with SMTP id c10mr11001877pjn.229.1611839351754;
 Thu, 28 Jan 2021 05:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com> <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com> <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com> <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com> <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
 <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com>
In-Reply-To: <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 28 Jan 2021 21:08:35 +0800
Message-ID: <CAMZfGtXXPpvnGotwgYj5G5DkWM1e+McLOLM3pTGuUui54f5TFg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

On Thu, Jan 28, 2021 at 8:37 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Jan 27, 2021 at 6:36 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 26.01.21 16:56, David Hildenbrand wrote:
> > > On 26.01.21 16:34, Oscar Salvador wrote:
> > >> On Tue, Jan 26, 2021 at 04:10:53PM +0100, David Hildenbrand wrote:
> > >>> The real issue seems to be discarding the vmemmap on any memory that has
> > >>> movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, we
> > >>> can reuse parts of the thingy we're freeing for the vmemmap. Not that it
> > >>> would be ideal: that once-a-huge-page thing will never ever be a huge page
> > >>> again - but if it helps with OOM in corner cases, sure.
> > >>
> > >> Yes, that is one way, but I am not sure how hard would it be to implement.
> > >> Plus the fact that as you pointed out, once that memory is used for vmemmap
> > >> array, we cannot use it again.
> > >> Actually, we would fragment the memory eventually?
> > >>
> > >>> Possible simplification: don't perform the optimization for now with free
> > >>> huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: what
> > >>> happens when migrating a huge page from ZONE_NORMAL to (ZONE_MOVABLE|CMA)?
> > >>
> > >> But if we do not allow theose pages to be in ZONE_MOVABLE or CMA, there is no
> > >> point in migrate them, right?
> > >
> > > Well, memory unplug "could" still work and migrate them and
> > > alloc_contig_range() "could in the future" still want to migrate them
> > > (virtio-mem, gigantic pages, powernv memtrace). Especially, the latter
> > > two don't work with ZONE_MOVABLE/CMA. But, I mean, it would be fair
> > > enough to say "there are no guarantees for
> > > alloc_contig_range()/offline_pages() with ZONE_NORMAL, so we can break
> > > these use cases when a magic switch is flipped and make these pages
> > > non-migratable anymore".
> > >
> > > I assume compaction doesn't care about huge pages either way, not sure
> > > about numa balancing etc.
> > >
> > >
> > > However, note that there is a fundamental issue with any approach that
> > > allocates a significant amount of unmovable memory for user-space
> > > purposes (excluding CMA allocations for unmovable stuff, CMA is
> > > special): pairing it with ZONE_MOVABLE becomes very tricky as your user
> > > space might just end up eating all kernel memory, although the system
> > > still looks like there is plenty of free memory residing in
> > > ZONE_MOVABLE. I mentioned that in the context of secretmem in a reduced
> > > form as well.
> > >
> > > We theoretically have that issue with dynamic allocation of gigantic
> > > pages, but it's something a user explicitly/rarely triggers and it can
> > > be documented to cause problems well enough. We'll have the same issue
> > > with GUP+ZONE_MOVABLE that Pavel is fixing right now - but GUP is
> > > already known to be broken in various ways and that it has to be treated
> > > in a special way. I'd like to limit the nasty corner cases.
> > >
> > > Of course, we could have smart rules like "don't online memory to
> > > ZONE_MOVABLE automatically when the magic switch is active". That's just
> > > ugly, but could work.
> > >
> >
> > Extending on that, I just discovered that only x86-64, ppc64, and arm64
> > really support hugepage migration.
> >
> > Maybe one approach with the "magic switch" really would be to disable
> > hugepage migration completely in hugepage_migration_supported(), and
> > consequently making hugepage_movable_supported() always return false.
> >
> > Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be
> > migrated. The problem I describe would apply (careful with using
> > ZONE_MOVABLE), but well, it can at least be documented.
>
> Thanks for your explanation.
>
> All thinking seems to be introduced by encountering OOM. :-(
>
> In order to move forward and free the hugepage. We should add some
> restrictions below.
>
> 1. Only free the hugepage which is allocated from the ZONE_NORMAL.
           ^^
Sorry. Here "free" should be "optimize".

> 2. Disable hugepage migration when this feature is enabled.
> 3. Using GFP_ATOMIC to allocate vmemmap pages firstly (it can reduce
>    memory fragmentation), if it fails, we use part of the hugepage to
>    remap.
>
> Hi Oscar, Mike and David H
>
> What's your opinion about this? Should we take this approach?
>
> Thanks.
>
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
