Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E04336F74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhCKKA7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 05:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhCKKAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:00:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52462C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 02:00:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y67so14210791pfb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQYHWAxJkDDd3f+gQZzvbrjXR8K2vgw8ut0GHNgkmoM=;
        b=TGZB56pq53iJrbDY/snWAhnMelGY6QSE+Yv/4rXOZF8ClO6D17/XVaPjgLf/6KmFGv
         UIkQ/2qRLk3cCji7+/COxGOJFB14ZYLUhacmrEXPkr5eL/l43Czfhqly17NuHNj0e+UY
         zuFiR7pojUusz5EVmDAIDRxBRa2JsxlgSqXnwehIg5gen6srHlXbS82ai+U6lhRhjWph
         PpsZQrZfgnFvfxrZsJvi1gFcFi/nEpv7r7rZ/GopaDNqOFb9YbRlV8FyTgFx+YSnJbr/
         ioPbB3tV3Um5t0pJY5uKOyKLo8ACUmzSZrB9NqPQXaY5yKUUM/Ctm8B5HNpv4UmFCvPG
         ycXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQYHWAxJkDDd3f+gQZzvbrjXR8K2vgw8ut0GHNgkmoM=;
        b=EK1TWrphjvTk+MXIfZsN0MsSnOAtdH1MigBxYeuyjm+psq7c97cZOj9vv5rZKvzJgD
         lnn0RJhfy4jgewbxhYsLaPJOb2g8nARoQpXRUC7x1Z06c8tOIs40kstpElaiQzs+OoLt
         u+w84pgjwaxA4gwjbrIYziSRChxlex22pqZy9amaEasctMZMi8HrX87wt9pN5bsR9yb5
         KzV/lEgHn4vYEdB8uc2s8QKITO3Z1/ltS2zY8n8miIwnGmLH9DXYde3DCQmOVLHxVBO7
         CKt8jwjVUuoDewEwA2AeYWzJtRLpLT4w/EBdOOVAXQWd7e+ZzERHjSo25Uuo7hS48h2D
         mlSg==
X-Gm-Message-State: AOAM530sfOsCNg7CT1BSH6142e9h+xPhEjlFyjFd/ZIjntB6BhoSgZf+
        1cYZvupt4cEKdAsrAk8AyuHKpSAi4Anmi4VJFID3hA==
X-Google-Smtp-Source: ABdhPJwqzuj630hhgNm5RpgiIIsq6u5FJpc47tt2JPxPfMHD0qYBylhZFf5FrpayQuz02H1TABPQKpF4NTKHNt6mO7g=
X-Received: by 2002:a63:141e:: with SMTP id u30mr6765052pgl.31.1615456846679;
 Thu, 11 Mar 2021 02:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com> <YEjoozshsvKeMAAu@dhcp22.suse.cz>
 <CAMZfGtV1Fp1RiQ64c9RrMmZ+=EwjGRHjwL8Wx3Q0YRWbbKF6xg@mail.gmail.com>
 <YEnbBPviwU6N2RzK@dhcp22.suse.cz> <CAMZfGtW5uHYiA_1an3W-jEmemsoN3Org7JwieeE2V271wh9X-A@mail.gmail.com>
 <YEnlRlLJD1bK/Dup@dhcp22.suse.cz>
In-Reply-To: <YEnlRlLJD1bK/Dup@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 18:00:09 +0800
Message-ID: <CAMZfGtX3pUmPOY1ieVQubnBKHZoOxfp-ARsPigYZpc=-UiiNjg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 9/9] mm: hugetlb: optimize the code
 with the help of the compiler
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 5:39 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 11-03-21 17:08:34, Muchun Song wrote:
> > On Thu, Mar 11, 2021 at 4:55 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 11-03-21 15:33:20, Muchun Song wrote:
> > > > On Wed, Mar 10, 2021 at 11:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 08-03-21 18:28:07, Muchun Song wrote:
> > > > > > When the "struct page size" crosses page boundaries we cannot
> > > > > > make use of this feature. Let free_vmemmap_pages_per_hpage()
> > > > > > return zero if that is the case, most of the functions can be
> > > > > > optimized away.
> > > > >
> > > > > I am confused. Don't you check for this in early_hugetlb_free_vmemmap_param already?
> > > >
> > > > Right.
> > > >
> > > > > Why do we need any runtime checks?
> > > >
> > > > If the size of the struct page is not power of 2, compiler can think
> > > > is_hugetlb_free_vmemmap_enabled() always return false. So
> > > > the code snippet of this user can be optimized away.
> > > >
> > > > E.g.
> > > >
> > > > if (is_hugetlb_free_vmemmap_enabled())
> > > >         /* do something */
> > > >
> > > > The compiler can drop "/* do something */" directly, because
> > > > it knows is_hugetlb_free_vmemmap_enabled() always returns
> > > > false.
> > >
> > > OK, so this is a micro-optimization to generate a better code?
> >
> > Right.
> >
> > > Is this measurable to warrant more code?
> >
> > I have disassembled the code to confirm this behavior.
> > I know this is not the hot path. But it actually can decrease
> > the code size.
>
> struct page which is not power of 2 is not a common case.

I know this is not a common case. But the check of
is_power_of_2(sizeof(struct page)) does not bring extra
runtime overhead. It just tells the compiler to optimize code
as much as possible.

> Are you sure
> it makes sense to micro optimize for an outliar. If you really want to
> microptimize then do that for a common case - the feature being
> disabled - via static key.

We cannot optimize the code size (vmlinux) even if we use a static
key when the size is not power of 2.

Sorry. I am confused why you disagree with this change.
It does not bring any disadvantages.

> --
> Michal Hocko
> SUSE Labs
