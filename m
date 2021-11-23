Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579FB45AEF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKWW0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhKWW0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:26:43 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E1C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 14:23:35 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id v23so586005iom.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mH04q1REZQWYt1Q0v2diML2IPmTCGEO05yrWYNlZUvU=;
        b=PAxO8mtkJkocmQUq1tHub6eT9LmXcjz/IyTvDHCbh9IzWi4yYlzEOIgtgsrdFFpvnZ
         O/QyrOTYecCHuQY5xM4PBgsFHrzLK8DeE0QIU0vH3lwtcwj61rdf0NZECADfEkXuLC6J
         E+6eCXt9mffGOH2HD0zewF5G93AlOSyG8bTz2G3jh2X1XhsTRZqCWS47fB/UYovTGjav
         DgNZ/Ww+pZnAQs6i7/vswJ5keQuiJPgWAXrxHCNEZIBDs6HKKf0KDJNpt+u+M30eOsiE
         eJH1UwA4kW9KQYDWDv+YpTbnTfNzD3e4RMdmit+lUoGH7P7PmM5im2RAnov/P9YLffTu
         HL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mH04q1REZQWYt1Q0v2diML2IPmTCGEO05yrWYNlZUvU=;
        b=IVICVODRQCngVoi63PY404fclrQ+MdBmiSx0pMJ+oS5nm2jpsm/UFvUZ1kepK2igAn
         zm6CpxBprOB4RU+lO8neBRUkQMsnXVHMaKtTJ4NufSxSNnVC6qpBUfjr2CX6SiSe3aSW
         NGB7dSnxxViI1jVVw2jxuGcF3qanPAX7IenFg8RZwtSremIoaTr499DH6noecrXkWYkN
         nqreM7TJnFhJxcJOoy8yw3nzEewUiEfEo/nJyKHq09vaetS3xHfkQWB8dDvVGj4k8WyF
         AkV5i6d7pQFux1YagEu2ljx55F+9Av28LMh55DK5fR1GmHyksTFXpRA4rdn5v2DJQgvD
         e5Tg==
X-Gm-Message-State: AOAM5304NrOM4vsEspDdqgyy29e9Wtdgi/riFb6Exp6eEM79wa5QzUip
        F1naNW7VwhvBYWTaGlgBSNJm5OrVKBhAI5F8JdRSYA==
X-Google-Smtp-Source: ABdhPJwOUy/LIWpKCQbwgpf+7ctYVg3vIeHN4QYchB1iSGuZIxAE2HiUz18rhQQdtEdqw9cG1fFRxo9C+gJu9EpFPAI=
X-Received: by 2002:a05:6638:4183:: with SMTP id az3mr10362179jab.56.1637706214522;
 Tue, 23 Nov 2021 14:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YZ1USY+zB1PP24Z1@casper.infradead.org> <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
 <YZ1ddl3FA43NijmX@casper.infradead.org> <CAHS8izMmcbXQ0xCDVYx8JW54sbbLXwNnK6pHgf9Ztn=XPFEsWA@mail.gmail.com>
 <YZ1lOgjv6r+ZOSRX@casper.infradead.org>
In-Reply-To: <YZ1lOgjv6r+ZOSRX@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 23 Nov 2021 14:23:23 -0800
Message-ID: <CAHS8izO0EMRgH8_qt58_O9-MBSwFXLgr1g79gJGrY1N0dTKutg@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 2:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 23, 2021 at 01:47:33PM -0800, Mina Almasry wrote:
> > On Tue, Nov 23, 2021 at 1:30 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > What I've been trying to communicate over the N reviews of this
> > > patch series is that *the same thing is about to happen to THPs*.
> > > Only more so.  THPs are going to be of arbitrary power-of-two size, not
> > > necessarily sizes supported by the hardware.  That means that we need to
> > > be extremely precise about what we mean by "is this a THP?"  Do we just
> > > mean "This is a compound page?"  Do we mean "this is mapped by a PMD?"
> > > Or do we mean something else?  And I feel like I haven't been able to
> > > get that information out of you.
> >
> > Yes, I'm very sorry for the trouble, but I'm also confused what the
> > disconnect is. To allocate hugepages I can do like so:
> >
> > mount -t tmpfs -o huge=always tmpfs /mnt/mytmpfs
> >
> > or
> >
> > madvise(..., MADV_HUGEPAGE)
> >
> > Note I don't ask the kernel for a specific size, or a specific mapping
> > mechanism (PMD/contig PTE/contig PMD/PUD), I just ask the kernel for
> > 'huge' pages. I would like to know whether the kernel was successful
> > in allocating a hugepage or not. Today a THP hugepage AFAICT is PMD
> > mapped + is_transparent_hugepage(), which is the check I have here. In
> > the future, THP may become an arbitrary power of two size, and I think
> > I'll need to update this querying interface once/if that gets merged
> > to the kernel. I.e, if in the future I allocate pages by using:
> >
> > mount -t tmpfs -o huge=2MB tmpfs /mnt/mytmpfs
> >
> > I need the kernel to tell me whether the mapping is 2MB size or not.
> >
> > If I allocate pages by using:
> >
> > mount -t tmpfs -o huge=pmd tmpfs /mnt/mytmps,
> >
> > Then I need the kernel to tell me whether the pages are PMD mapped or
> > not, as I'm doing here.
> >
> > The current implementation is based on what the current THP
> > implementation is in the kernel, and depending on future changes to
> > THP I may need to update it in the future. Does that make sense?
>
> Well, no.  You're adding (or changing, if you like) a userspace API.
> We need to be precise about what that userspace API *means*, so that we
> don't break it in the future when the implementation changes.  You're
> still being fuzzy above.
>
> I have no intention of adding an API like the ones you suggest above to
> allow the user to specify what size pages to use.  That seems very strange
> to me; how should the user (or sysadmin, or application) know what size is
> best for the kernel to use to cache files?  Instead, the kernel observes
> the usage pattern of the file (through the readahead mechanism) and grows
> the allocation size to fit what the kernel thinks will be most effective.
>
> I do honour some of the existing hints that userspace can provide; eg
> VM_HUGEPAGE makes the pagefault path allocate PMD sized pages (if it can).

Right, so since VM_HUGEPAGE makes the kernel allocate PMD mapped THP
if it can, then I want to know if the page is actually a PMD mapped
THP or not. The implementation and documentation that I'm adding seem
consistent with that AFAICT, but sorry if I missed something.

> But there's intentionally no new way to tell the kernel to use pages
> of a particular size.  The current implementation will use (at least)
> 64kB pages if you do reads in 64kB chunks, but that's not guaranteed.
