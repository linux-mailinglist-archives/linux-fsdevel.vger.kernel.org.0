Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7345AFF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhKWXTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhKWXTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:19:48 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA452C061714
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 15:16:39 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z26so736492iod.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kM7gnTny43QDnYFYBUsykzKb/YIDf6V4JPjjkny8Fbs=;
        b=HUEdP7dL6RvpMRAWRK31o46crI1NcKJ5Kj1jT0kaYbbM9c5dVCR7RZ9Qgd9jcm43AY
         HtwBwSJZkEsD3opdhNfK1f9FQ4g1wiPy+nYo8j6yN3AV/p4hXM81mVH1h6+wyk5eznRl
         LqR78t6Si+RsE5nVyfu6wlDIenfPqTXThBMeNxBFuhTr7S4cHkTH6idM9eFTtsWiDTCs
         QDdeXV5+pIJJeAd2By0mmZTB0veqRUuezOAkZ6AzzRmh+s3pLdsv++E9lyLiw6INnbXx
         q1HcKxZ0hCXgZ76NmHn5tYCEoXUixiOziEFw44+sHXy6Q4cwBbj+JeuKyiaOegwwKhmp
         VvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kM7gnTny43QDnYFYBUsykzKb/YIDf6V4JPjjkny8Fbs=;
        b=WV//Ad6PFDzI2fxOcjDBX/v3jXM0zdEQo03dnZSz709GR7+IkTo4PtfYp2e5QQcdu6
         ARSRjSq7K++yMK6L3iB6XCmvbFbOf5sQgD7ikmwObOVRuNv9CcNYV93HljkipE2u2JgG
         zTwv6WPj10QDA/3mJk8Jj/KEjJgFdr2Lix9dOiGx6OBveRZzNmpCUH07ODFaawZ5WK1B
         ilBcSCgCXSsQ6kKd2yvie40II40/AEp/Q/Omro38aK4f4JvJs6sVAUvZsqqA+bxi31qi
         7t/7zo6yC3fpXXA+eNkGOrs402DgjToXxC/7fnxTrvCEhV6QM5yr6vV6QhmiVeun+zpc
         EBFQ==
X-Gm-Message-State: AOAM531H/lIKRDXE/WWyP76hkay26qnWP7Wdqc2dK8DKshys34kc40b3
        qJNftGK7FW8+0s4U402XzxK0VaZPnGyt7akHBVkMEQ==
X-Google-Smtp-Source: ABdhPJy0JvkGEkbgZd3LhBD7aoiqSzR1lSBUaqfr5jk23IXyeyriLpIRI4TsLxjKV6oOvM0nh9GgzPPSX5zCwMWICAQ=
X-Received: by 2002:a05:6602:2c85:: with SMTP id i5mr9498544iow.89.1637709398903;
 Tue, 23 Nov 2021 15:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YZ1USY+zB1PP24Z1@casper.infradead.org> <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
 <YZ1ddl3FA43NijmX@casper.infradead.org> <CAHS8izMmcbXQ0xCDVYx8JW54sbbLXwNnK6pHgf9Ztn=XPFEsWA@mail.gmail.com>
 <YZ1lOgjv6r+ZOSRX@casper.infradead.org> <CAHS8izO0EMRgH8_qt58_O9-MBSwFXLgr1g79gJGrY1N0dTKutg@mail.gmail.com>
 <YZ1yapOMZOXdFHG9@casper.infradead.org>
In-Reply-To: <YZ1yapOMZOXdFHG9@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 23 Nov 2021 15:16:27 -0800
Message-ID: <CAHS8izMcxQeC_r+EbFOxXLiz7CctEg=Nckz+k=y8vAojJtva7A@mail.gmail.com>
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 23, 2021 at 02:23:23PM -0800, Mina Almasry wrote:
> > On Tue, Nov 23, 2021 at 2:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Nov 23, 2021 at 01:47:33PM -0800, Mina Almasry wrote:
> > > > On Tue, Nov 23, 2021 at 1:30 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > What I've been trying to communicate over the N reviews of this
> > > > > patch series is that *the same thing is about to happen to THPs*.
> > > > > Only more so.  THPs are going to be of arbitrary power-of-two size, not
> > > > > necessarily sizes supported by the hardware.  That means that we need to
> > > > > be extremely precise about what we mean by "is this a THP?"  Do we just
> > > > > mean "This is a compound page?"  Do we mean "this is mapped by a PMD?"
> > > > > Or do we mean something else?  And I feel like I haven't been able to
> > > > > get that information out of you.
> > > >
> > > > Yes, I'm very sorry for the trouble, but I'm also confused what the
> > > > disconnect is. To allocate hugepages I can do like so:
> > > >
> > > > mount -t tmpfs -o huge=always tmpfs /mnt/mytmpfs
> > > >
> > > > or
> > > >
> > > > madvise(..., MADV_HUGEPAGE)
> > > >
> > > > Note I don't ask the kernel for a specific size, or a specific mapping
> > > > mechanism (PMD/contig PTE/contig PMD/PUD), I just ask the kernel for
> > > > 'huge' pages. I would like to know whether the kernel was successful
> > > > in allocating a hugepage or not. Today a THP hugepage AFAICT is PMD
> > > > mapped + is_transparent_hugepage(), which is the check I have here. In
> > > > the future, THP may become an arbitrary power of two size, and I think
> > > > I'll need to update this querying interface once/if that gets merged
> > > > to the kernel. I.e, if in the future I allocate pages by using:
> > > >
> > > > mount -t tmpfs -o huge=2MB tmpfs /mnt/mytmpfs
> > > >
> > > > I need the kernel to tell me whether the mapping is 2MB size or not.
> > > >
> > > > If I allocate pages by using:
> > > >
> > > > mount -t tmpfs -o huge=pmd tmpfs /mnt/mytmps,
> > > >
> > > > Then I need the kernel to tell me whether the pages are PMD mapped or
> > > > not, as I'm doing here.
> > > >
> > > > The current implementation is based on what the current THP
> > > > implementation is in the kernel, and depending on future changes to
> > > > THP I may need to update it in the future. Does that make sense?
> > >
> > > Well, no.  You're adding (or changing, if you like) a userspace API.
> > > We need to be precise about what that userspace API *means*, so that we
> > > don't break it in the future when the implementation changes.  You're
> > > still being fuzzy above.
> > >
> > > I have no intention of adding an API like the ones you suggest above to
> > > allow the user to specify what size pages to use.  That seems very strange
> > > to me; how should the user (or sysadmin, or application) know what size is
> > > best for the kernel to use to cache files?  Instead, the kernel observes
> > > the usage pattern of the file (through the readahead mechanism) and grows
> > > the allocation size to fit what the kernel thinks will be most effective.
> > >
> > > I do honour some of the existing hints that userspace can provide; eg
> > > VM_HUGEPAGE makes the pagefault path allocate PMD sized pages (if it can).
> >
> > Right, so since VM_HUGEPAGE makes the kernel allocate PMD mapped THP
> > if it can, then I want to know if the page is actually a PMD mapped
> > THP or not. The implementation and documentation that I'm adding seem
> > consistent with that AFAICT, but sorry if I missed something.
>
> So what userspace cares about is that the kernel is mapping the
> memory with a PMD entry; it doesn't care whether the file is
> being cached in 2MB (or larger) chunks.  So we can drop the 'THP'
> from all of this, and just call the bit the PMD mapping bit?

I've thought about this a bit, but I have a couple of problems:

1. It's a bit difficult to implement this for hugetlb pages, or at
least I haven't found a reasonably simple way to implement this for
hugetlb pages. hugetlb ranges are handled by
pagemap_hugetlb_range(ptep, hmask, ...). I can't find a way to uncover
whether ptep points to a pmd_t or pud_t or even pte_t with contig PTE
bit set. I can also easily surmise the size of the page from the
hmask, but I need to know what's the native page size and what arch
I'm running on to convert a page size to "is PMD mapped or not''
information. Very sorry if I missed an easy way to do this.

2. Semantically I'm not sure it makes sense to tell the user if a page
is PMD hugetlb or not. For THP I think it makes somewhat sense because
the userspace asks for hugepages via MADV_HUGEPAGE or huge=always, and
'huge' roughly here means 'PMD mapped', per your statement that for
VM_HUGEPAGE makes the kernel try to allocate PMD size pages. For
hugetlb, the userspace never asks for 'huge' pages or PMD mappings per
say, they ask for a specific size, and it's considered an
implementation detail how the mapping is achieved, and may not even be
backwards compatible.
