Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD56B429D37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhJLFij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhJLFii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:38:38 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21238C06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 22:36:37 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id d131so44125430ybd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 22:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XL2OhH3/JP2d1n5i0NoQYVBLyR5b6ih9F8rC7fPaw8=;
        b=YIz7schr62o25Kk8g7+lX0aqEsOX9ha4KRCurs5t8nYWe3ybb0BGYRyTNxOMDQOt4L
         gRMaIvi1d5c020EPGi2iB+KhmmRlH0d6ErcqsmawK4hViPXWSHB8THppCf0yRlDWQsbS
         1eMwwPcHGB5y/XIJhsmmdMZc+YTZntrOYcrGKVIusunJdjDqMyhxNosruNdKybo6Ghla
         I5rPA1ih4GOrBL5FL9LswuwUgRYkdHRsI22iY+KhbSsZxVkOzruQfuAcp6IixjL8uPKU
         4dC/+SScw5mAcuOp40squ2No5UFu3JEoaMnizIyl/RoGHsoQwZwD7NU0S2kEc+cOqUZh
         a1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XL2OhH3/JP2d1n5i0NoQYVBLyR5b6ih9F8rC7fPaw8=;
        b=omjQq+iYTqr5LPImwjC0m8lWc9J7mCg9xGSt186spdmeytULwjSibn1KL23XhnA3h7
         W+wY+OV+36f7jn8WXHZDoih97dmhcEwRbLWre05vNq+mwBwBbD9SUXjjDvHdK+pbyfYX
         nn22t8RGulglJ5Z/6qucjtJvz9oPSmsp3zkyfVdR68GmmwdZt2hj09zd+cMMwKSLbAIa
         71kaz/9+cpaV+cHr+WOmfe4Q8M0uLRePV9YEoQQSQEgL9XGVxRcywSblSgwFY4AGBS2g
         csbm+7oXk58gJX1xozHZWNQtY+9/JpHkAfyrWGaOx8S6q+sIWj6FJp3rw3iriA3L19TO
         qxiA==
X-Gm-Message-State: AOAM530M3vrNQavGKEKE3GfiAiIfH3laF8NQnJgTByOO/iKirNTE3ElY
        xQZTad7Zz8GeefPP+SVXe5NnRgAChyfokmXKASAC0A==
X-Google-Smtp-Source: ABdhPJyTsM4JaN/xPnjTpzxxuo73xadaPUNGih6GtuXol8Vc+QjBmhQFZit4fZr7hGyTs8vyfUE4twxwx2HN6kT73h4=
X-Received: by 2002:a25:3:: with SMTP id 3mr27812738yba.418.1634016995938;
 Mon, 11 Oct 2021 22:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com> <YWT6Ptp/Uo4QGeP4@cmpxchg.org>
In-Reply-To: <YWT6Ptp/Uo4QGeP4@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Oct 2021 22:36:24 -0700
Message-ID: <CAJuCfpERX-nqHkYzx8FAi_DuOU1vkoV5ppCAhLHziOm7o7wj6g@mail.gmail.com>
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

On Mon, Oct 11, 2021 at 8:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Oct 11, 2021 at 06:20:25PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > > > - Strings for "anon" specifically have no required format (this is good)
> > > > >   it's informational like the task_struct::comm and can (roughly)
> > > > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > > > >   is one needed here? That seems like a completely unreasonable
> > > > >   requirement.
> > > >
> > > > I might be misreading the justification for the feature. Patch 2 is
> > > > talking about tools that need to understand memeory usage to make
> > > > further actions. Also Suren was suggesting "numbering convetion" as an
> > > > argument against.
> > > >
> > > > So can we get a clear example how is this being used actually? If this
> > > > is just to be used to debug by humans than I can see an argument for
> > > > human readable form. If this is, however, meant to be used by tools to
> > > > make some actions then the argument for strings is much weaker.
> > >
> > > The simplest usecase is when we notice that a process consumes more
> > > memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> > > check which area is contributing to this growth. The names we assign
> > > to anonymous areas are descriptive enough for a developer to get an
> > > idea where the increased consumption is coming from and how to proceed
> > > with their investigation.
> > > There are of course cases when tools are involved, but the end-user is
> > > always a human and the final report should contain easily
> > > understandable data.
> > >
> > > IIUC, the main argument here is whether the userspace can provide
> > > tools to perform the translations between ids and names, with the
> > > kernel accepting and reporting ids instead of strings. Technically
> > > it's possible, but to be practical that conversion should be fast
> > > because we will need to make name->id conversion potentially for each
> > > mmap. On the consumer side the performance is not as critical, but the
> > > fact that instead of dumping /proc/$pid/maps we will have to parse the
> > > file, do id->name conversion and replace all [anon:id] with
> > > [anon:name] would be an issue when we do that in bulk, for example
> > > when collecting system-wide data for a bugreport.
>
> Is that something you need to do client-side? Or could the bug tool
> upload the userspace-maintained name:ids database alongside the
> /proc/pid/maps dump for external processing?

You can generate a bugreport and analyze it locally or submit it as an
attachment to a bug for further analyzes.
Sure, we can attach the id->name conversion table to the bugreport but
either way, some tool would have to post-process it to resolve the
ids. If we are not analyzing the results immediately then that step
can be postponed and I think that's what you mean? If so, then yes,
that is correct.
