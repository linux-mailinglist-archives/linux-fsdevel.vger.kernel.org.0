Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE1425B23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbhJGSwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbhJGSwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:52:15 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACBBC061570
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 11:50:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a7so15588645yba.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0+5wT+wrdMqcXbNJTk/9zibrUNlQPSrWQVNSFGRH0Q=;
        b=f+jqxJIJSLt5FZwMq8HxqaGUYxnqZd2XHM9BdnYqSOU2kuqNgIW8wdNJ+eIspkoDj7
         Y9gcKeC/pYYgB7yyLLyYx+RB+VVGInIY8fY+l7ByRtsBh75EzVZLLHUx0s/JgAaUxjSx
         hGIwnJa6ufRLm2694PKbR8PkW8ggrSVSF19tXiQkNxjdPHqzGQENgGZtovh4JP3nyBmm
         km/ahg3AYuRK3xJ3BxULxSYwkGBP+AaFviZfQCvWKnwo6U4m7pnW6dL83ihp8vhP+OEn
         KjczJIjrhAJYXJHrPGk4lt9lhphV4v8E1sVoy0rsM5C4FRJOlgdvGR8HGAR7WauUTcVs
         gaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0+5wT+wrdMqcXbNJTk/9zibrUNlQPSrWQVNSFGRH0Q=;
        b=8PK2S2w4TCak9foa3MHHOyXfImL09wmNGGwY1U1JcG0CE9HE7C+yvIHjYl+Rmu4p3s
         IOXnCAKglTVmgKG2jI9dS4ZVgD7L1lxLl9n4j5kzXOX6cubgPQEHNMVHIIsS7LRqBRfl
         nS7r+ogtuuojO2Ur+opmWfwRDL1zUzCvYjdQ9MZoK/wPLH7IXJVgb8EzGJUiAjEHT+LK
         Oysihjrds7MvvHgkIdaYbCE2XWbZOCNIVcOdnSz2oitRey1dxHY7zohiQHR0J/58CVuj
         6tcwOd8/SlbfBy/c80tFJFS30WUotaSE9mYclXbybFsKF+e8HrLe8XdifGSE0cEjspSO
         e2nw==
X-Gm-Message-State: AOAM5305tj87WlKXXgLWTLq9A7eOKjiq3XhiuaHJOG5BoBKBtLq4kWUH
        Y5sXzbvDhU8ew0VnFLtiKz0Ws6axw3Ef3MymdJNaSA==
X-Google-Smtp-Source: ABdhPJwX3MSlqHYl/15/mb53bQi9n5NdlsFOxC7cfpcgUkjWDcfJbTPgeVDqsBWb3sDjKC8m87AdHD4J0DwOcD30v/I=
X-Received: by 2002:a25:5b04:: with SMTP id p4mr6402702ybb.34.1633632620440;
 Thu, 07 Oct 2021 11:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211006175821.GA1941@duo.ucw.cz> <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz> <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
In-Reply-To: <202110071111.DF87B4EE3@keescook>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 7 Oct 2021 11:50:09 -0700
Message-ID: <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
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

On Thu, Oct 7, 2021 at 11:13 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 07, 2021 at 10:50:24AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Oct 7, 2021 at 10:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-10-21 09:58:02, Suren Baghdasaryan wrote:
> > > > On Thu, Oct 7, 2021 at 9:40 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 07-10-21 09:04:09, Suren Baghdasaryan wrote:
> > > > > > On Thu, Oct 7, 2021 at 3:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > > > >
> > > > > > > Hi!
> > > > > > >
> > > > > > > > >> Hmm, so the suggestion is to have some directory which contains files
> > > > > > > > >> representing IDs, each containing the string name of the associated
> > > > > > > > >> vma? Then let's say we are creating a new VMA and want to name it. We
> > > > > > > > >> would have to scan that directory, check all files and see if any of
> > > > > > > > >> them contain the name we want to reuse the same ID.
> > > > > > > > >
> > > > > > > > > I believe Pavel meant something as simple as
> > > > > > > > > $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
> > > > > > > > > $ touch $YOUR_FILE
> > > > > > > > > $ stat -c %i $YOUR_FILE
> > > > > >
> > > > > > Ah, ok, now I understand the proposal. Thanks for the clarification!
> > > > > > So, this would use filesystem as a directory for inode->name mappings.
> > > > > > One rough edge for me is that the consumer would still need to parse
> > > > > > /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
> > > > > > just dumping the content for the user. Would it be acceptable if we
> > > > > > require the ID provided by prctl() to always be a valid inode and
> > > > > > show_map_vma() would do the inode-to-filename conversion when
> > > > > > generating maps/smaps files? I know that inode->dentry is not
> > > > > > one-to-one mapping but we can simply output the first dentry name.
> > > > > > WDYT?
> > > > >
> > > > > No. You do not want to dictate any particular way of the mapping. The
> > > > > above is just one way to do that without developing any actual mapping
> > > > > yourself. You just use a filesystem for that. Kernel doesn't and
> > > > > shouldn't understand the meaning of those numbers. It has no business in
> > > > > that.
> > > > >
> > > > > In a way this would be pushing policy into the kernel.
> > > >
> > > > I can see your point. Any other ideas on how to prevent tools from
> > > > doing this id-to-name conversion themselves?
> > >
> > > I really fail to understand why you really want to prevent them from that.
> > > Really, the whole thing is just a cookie that kernel maintains for memory
> > > mappings so that two parties can understand what the meaning of that
> > > mapping is from a higher level. They both have to agree on the naming
> > > but the kernel shouldn't dictate any specific convention because the
> > > kernel _doesn't_ _care_. These things are not really anything actionable
> > > for the kernel. It is just a metadata.
> >
> > The desire is for one of these two parties to be a human who can get
> > the data and use it as is without additional conversions.
> > /proc/$pid/maps could report FD numbers instead of pathnames, which
> > could be converted to pathnames in userspace. However we do not do
> > that because pathnames are more convenient for humans to identify a
> > specific resource. Same logic applies here IMHO.
>
> Yes, please. It really seems like the folks that are interested in this
> feature want strings. (I certainly do.) For those not interested in the
> feature, it sounds like a CONFIG to keep it away would be sufficient.
> Can we just move forward with that?

Would love to if others are ok with this.

>
> --
> Kees Cook
