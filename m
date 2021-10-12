Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF52F42AE5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhJLVB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 17:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhJLVBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:01:55 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6800CC061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 13:59:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v195so1549848ybb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FM46KTu0fl8cFqAAvga2i5cJZtMLiEZlRnNB5JincE=;
        b=Wh5JIU1bBIUxbXwo4tp7JMR0cu8a0lDIJia6OgZEgEx72jrSvyydXbNV/+rad2r42T
         hah7gUOQnYJDVsXVLrHL2P7RzyBcSKTODkVABWXWtjZmFMWcW5EmtRQ8vpl4Gc+ae7Ff
         pRvMzQJ1iLMkito1wcmawmuKld81XX+yckDiInbDA897OlXQwkXl8+HD6s6+R/r4omMi
         vO7yrbR9yqS+gW2kbDXz1X/LoLPSdojSS5UTz6i7glen7IZbhAcdFLm3F3TNrEYeJKx/
         vd2K8RTUnROyejv3lCt/DagoM5MqcIta4pck8EI7wV/sDdUN0r7jbA5aCI2GezvUwclT
         kO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FM46KTu0fl8cFqAAvga2i5cJZtMLiEZlRnNB5JincE=;
        b=6jPgzbwaMq7U3bU5ta9eZEM0bwrhcBZcxpkmmy4GOtfGky+MLTVksofTB5xmUvq8n0
         mMYyYZiuVa0oyu8tnbk/w1Zh6hHF3Wlmfsq9yKiE1nCzEbuvPrw2GBB+/pfHZyzqsgIF
         VNnqYgoIh4vjpMAsDmqlre8BJ7fUO/NJ1hnCg6Za+QdvQMV9DslGQJFCV2WTH+Pnnrnm
         vbl3ILqkBWz9mYCkZ3DAVHZSvpS3IV3mh3+TpOHSC23SNJ4tU2zoyWPTlOxtn9g2VAiF
         aUyXgbqEuXRjH8UI9ptjzVbwTzjfrVGNdaFDdWgMhDNQ9zopVxQULV7RDrxayHG5/d+R
         829w==
X-Gm-Message-State: AOAM5339Q9FwperenTV2yCL5pARUzwfGSIjnMjfSSFEh/P7sX0kP0RKH
        iJgx7kDS1gAtwsICE2geLmu7OnwllqNxvzAuO6ULjQ==
X-Google-Smtp-Source: ABdhPJwPNZ6xWEmHEHVKkMupYSbDAuthuGJ5ScdlxlrBrVVwxeuK3amfjJdR6EAfnsJsKwxGWohMOB2pI59rlY2kN8g=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr34368157ybu.161.1634072392293;
 Tue, 12 Oct 2021 13:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
 <YWT6Ptp/Uo4QGeP4@cmpxchg.org> <CAJuCfpERX-nqHkYzx8FAi_DuOU1vkoV5ppCAhLHziOm7o7wj6g@mail.gmail.com>
 <YWXTZOXQ/NpoDJFI@cmpxchg.org> <CAJuCfpEnad5RhhYS8Z6RXjnrpbUZs4nd99KybUFO34BcTH658w@mail.gmail.com>
 <YWXy4zEGOggb8Nzw@cmpxchg.org>
In-Reply-To: <YWXy4zEGOggb8Nzw@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Oct 2021 13:59:40 -0700
Message-ID: <CAJuCfpEV9ZkF9LeRXUvBP0MVrgg9BQRxN3KiC0QDsY++KzUrOg@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 1:41 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Oct 12, 2021 at 11:52:42AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Oct 12, 2021 at 11:26 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 10:36:24PM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Oct 11, 2021 at 8:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > On Mon, Oct 11, 2021 at 06:20:25PM -0700, Suren Baghdasaryan wrote:
> > > > > > On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > >
> > > > > > > > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > > > > > > > - Strings for "anon" specifically have no required format (this is good)
> > > > > > > > >   it's informational like the task_struct::comm and can (roughly)
> > > > > > > > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > > > > > > > >   is one needed here? That seems like a completely unreasonable
> > > > > > > > >   requirement.
> > > > > > > >
> > > > > > > > I might be misreading the justification for the feature. Patch 2 is
> > > > > > > > talking about tools that need to understand memeory usage to make
> > > > > > > > further actions. Also Suren was suggesting "numbering convetion" as an
> > > > > > > > argument against.
> > > > > > > >
> > > > > > > > So can we get a clear example how is this being used actually? If this
> > > > > > > > is just to be used to debug by humans than I can see an argument for
> > > > > > > > human readable form. If this is, however, meant to be used by tools to
> > > > > > > > make some actions then the argument for strings is much weaker.
> > > > > > >
> > > > > > > The simplest usecase is when we notice that a process consumes more
> > > > > > > memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> > > > > > > check which area is contributing to this growth. The names we assign
> > > > > > > to anonymous areas are descriptive enough for a developer to get an
> > > > > > > idea where the increased consumption is coming from and how to proceed
> > > > > > > with their investigation.
> > > > > > > There are of course cases when tools are involved, but the end-user is
> > > > > > > always a human and the final report should contain easily
> > > > > > > understandable data.
> > > > > > >
> > > > > > > IIUC, the main argument here is whether the userspace can provide
> > > > > > > tools to perform the translations between ids and names, with the
> > > > > > > kernel accepting and reporting ids instead of strings. Technically
> > > > > > > it's possible, but to be practical that conversion should be fast
> > > > > > > because we will need to make name->id conversion potentially for each
> > > > > > > mmap. On the consumer side the performance is not as critical, but the
> > > > > > > fact that instead of dumping /proc/$pid/maps we will have to parse the
> > > > > > > file, do id->name conversion and replace all [anon:id] with
> > > > > > > [anon:name] would be an issue when we do that in bulk, for example
> > > > > > > when collecting system-wide data for a bugreport.
> > > > >
> > > > > Is that something you need to do client-side? Or could the bug tool
> > > > > upload the userspace-maintained name:ids database alongside the
> > > > > /proc/pid/maps dump for external processing?
> > > >
> > > > You can generate a bugreport and analyze it locally or submit it as an
> > > > attachment to a bug for further analyzes.
> > > > Sure, we can attach the id->name conversion table to the bugreport but
> > > > either way, some tool would have to post-process it to resolve the
> > > > ids. If we are not analyzing the results immediately then that step
> > > > can be postponed and I think that's what you mean? If so, then yes,
> > > > that is correct.
> > >
> > > Right, somebody needs to do it at some point, but I suppose it's less
> > > of a problem if a developer machine does it than a mobile device.
> >
> > True, and that's why I mentioned that it's not as critical as the
> > efficiency at mmap() time. In any case, if we could avoid translations
> > at all that would be ideal.
> >
> > >
> > > One advantage of an ID over a string - besides not having to maintain
> > > a deduplicating arbitrary string storage in the kernel - is that we
> > > may be able to auto-assign unique IDs to VMAs in the kernel, in a way
> > > that we could not with strings. You'd still have to do IPC calls to
> > > write new name mappings into your db, but you wouldn't have to do the
> > > prctl() to assign stuff in the kernel at all.
> >
> > You still have to retrieve that tag from the kernel to record it in
> > your db, so this would still require some syscall, no?
>
> Don't you have to do this with the string setting interface as well?
> How do you know the vma address to pass into the prctl()? Is this
> somehow coordinated with the mmap()?

Sure. The sequence is:

ptr = mmap(NULL, size, ...);
prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, size, name);

>
> > > (We'd have to think of a solution of how IDs work with vma merging and
> > > splitting, but I think to a certain degree that's policy and we should
> > > be able to find something workable - a MAP_ID flag, using anon_vma as
> > > identity, assigning IDs at mmap time and do merges only for protection
> > > changes etc. etc.)
> >
> > Overall, I think keeping the kernel out of this and letting it treat
> > this tag as a cookie which only userspace cares about is simpler.
> > Unless you see other uses where kernel's involvement is needed.
>
> It depends on what you consider keeping the kernel out of it. A small
> extension to assign unique IDs to mappings automatically in an
> intuitive way (with a compat option to disable) is a much smaller ABI
> commitment than a prctl()-controlled string storage.

I'm not saying it's hard or complex. I just don't see the advantage of
generating these IDs in the kernel vs passing them from userspace.
Maybe I'm missing some usecase?

> When I say policy on how to assign the ID, I didn't mean that it
> should be a free for all. Rather that we should pick one reasonable
> way to do it, comparable to picking the parameters for how long the
> stored strings could be, which characters to allow etc.
