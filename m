Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3194258AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbhJGRA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbhJGRAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:00:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0FC0617AD
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 09:58:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id w10so14877473ybt.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2roo7N2Af5V9MyzmKYbaAyLkAjMNad5Lcx6Zw/2fkDw=;
        b=BF0V/P/RYBknF8eb0/OEKCvyMrXtCN7yOB7aYUc4Q3DSSVccbU6hU/Vp3GE1apQlPk
         yCJ8FILh3vBMaV6UMR98Yk3R4LESqkJXOfzMJaNq0J0xcwQGKjybrHz82zAE8253QF5U
         UrA5n5kz5BEOAOfEt3IxCgvGcTkEactWfmwFQmOlC7i/x7fr1gPnCZ7mMOkUCHBS1wKq
         yGHPEL/dsN/yQHOPLxhwKxMAycOQ+wJsUwhCYd69xxjg/5jpc96uh6B5AzXr6x1nAaGb
         4rMpmaLh9nnsuLiqWx8SDbHEao2TjWbvV54xGDaNALD9X/dQX8cczg3tkrOzgwrRUkVc
         BbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2roo7N2Af5V9MyzmKYbaAyLkAjMNad5Lcx6Zw/2fkDw=;
        b=jiwdG+B0kNDMDPk67tz0Z82g0sB1d+rQxyL9ktmPx0XwxqwmNCVEUi0qVSSEFCACjH
         dLhyUaY68HZUNBfY/Qvb9F9S+/2wqKfmrS3zWdauQqpOuPZ7ZKNun3m5Cs6cNQP45yuC
         f1fM9nnsYL42jahN69FQpiiAgImrtlk+qDpwK5MvuzpQIJ+MfcAJ2jzKJqL5GcFZGYXS
         YU25xBlLgvj0sZYu4jd5Olk1diuktZtj+Kg4DrjXkFu6owe/rOOziu05QxWhf3L6Yl50
         GeZEow2HLSZIjXf45u+fEzUGfe8xi14LJa6zwjB5KB0wBRmycuPLqo92caxQCmyRRB8p
         b+lw==
X-Gm-Message-State: AOAM5323AjpI3fr7SHOuNG25HhASJMfln6eNrbWhTp3ffrpJ9CetCIY/
        SCmEV/Sxn6LWu0wN8g0nfuxof6B6DuYNJ3H44FvE6g==
X-Google-Smtp-Source: ABdhPJym4VvtqHVKv+9+eKS28MNi7rcedM8+dLIhB+DoihLZf7xpYPXypfIrigb2ZhFzcnC3Vpr6i8o5c+Pf4K2R0w0=
X-Received: by 2002:a25:d1d3:: with SMTP id i202mr6456843ybg.487.1633625893118;
 Thu, 07 Oct 2021 09:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz> <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz> <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz> <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
In-Reply-To: <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 09:58:02 -0700
Message-ID: <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 7, 2021 at 9:40 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> > On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > >> Hmm, so the suggestion is to have some directory which contains files
> > > > >> representing IDs, each containing the string name of the associated
> > > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > > >> would have to scan that directory, check all files and see if any of
> > > > >> them contain the name we want to reuse the same ID.
> > > > >
> > > > > I believe Pavel meant something as simple as
> > > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > > $ touch $YOUR_FILE
> > > > > $ stat -c %i $YOUR_FILE
> >
> > Ah, ok, now I understand the proposal. Thanks for the clarification!
> > So, this would use filesystem as a directory for inode->name mappings.
> > One rough edge for me is that the consumer would still need to parse
> > /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> > just dumping the content for the user. Would it be acceptable if we
> > require the ID provided by prctl() to always be a valid inode and
> > show_map_vma() would do the inode-to-filename conversion when
> > generating maps/smaps files? I know that inode->dentry is not
> > one-to-one mapping but we can simply output the first dentry name.
> > WDYT?
>
> No. You do not want to dictate any particular way of the mapping. The
> above is just one way to do that without developing any actual mapping
> yourself. You just use a filesystem for that. Kernel doesn't and
> shouldn't understand the meaning of those numbers. It has no business in
> that.
>
> In a way this would be pushing policy into the kernel.

I can see your point. Any other ideas on how to prevent tools from
doing this id-to-name conversion themselves?
Aside from the obvious inefficiency of requiring tools to parse
maps/smaps and convert ids to names it also creates a tool->system
dependency. Tools would have to know how the system interprets these
IDs and on the systems where the ID is an inode they would have to
know where the soflinks proposed by Rasmus reside and convert them. If
I'm a tool developer who wants the tool to work on multiple systems
this becomes quite messy.

>
> --
> Michal Hocko
> SUSE Labs
