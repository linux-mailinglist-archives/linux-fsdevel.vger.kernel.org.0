Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04D2D6495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392418AbgLJRHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 12:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403961AbgLJRHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:14 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1EC061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 09:06:34 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o4so4798648pgj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfRhTAas1NcetqsYHCdhKdRkmhDx/6FtHvtSU75aAas=;
        b=Mb7SoDls4nifj95yys/nowAqBSY/LC+BoX0EAbTxa/y37i1DCYf4rw1bYQJ4mH4vYL
         /1ttdgE5mTdf5ZZpBvmUxqILY8drb6/plJX6BwO2W8VE3YlkIQfaf51ZC2x1kQT0g3KR
         CIcHoj27fgpFrnmV3MYI9byhT8ZNtQzXErfG0CToemZtuHzIKA8WsjG+A5ykxbFi2KnZ
         yeCY2mGPMAlz+HrKB3/d/fc5YUhKBSIF4Yxg1cn0R7pweYEYK1VMPizYW8ntZY9wTL4Q
         3UU9CuW31tWbcEDJ3/7Br6bxpfYVuEwjWp3JbOBj+6c/hfa3Fo4hoT+tfeHOuOoUXtyT
         mpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfRhTAas1NcetqsYHCdhKdRkmhDx/6FtHvtSU75aAas=;
        b=Ue6sZRo/Jtu8mB50TkG+2iCLMCCyqgQKW5kdyz2f/kFnZ8ULPHwQFUAMetOLFWKGH2
         pPxoPrxD6asaKKL5rGUICf0P0R7ZLLAIJv9DjUkxFdnWiqZ7K7/DfPXcOBBMkQidA34y
         rdVn220kk0jHyR/Xzeo9ApY1e7EYN7ZJHtowU41lS5vI7iH7fBkH9dNKj55YcZaWzxgZ
         6qKK6Z6lMJ8WiAr4v4grsg6Ac+WsGdGJclhGVwC/NGCXwyZXvmZxoq4EeYp1BST/lpRS
         DqULnnZv+IFPUr+r6O5AHge+vXp8Xzj70gBJWGJbDtC3CyczlMFl/TC88c2mDylko9vA
         hXxQ==
X-Gm-Message-State: AOAM533Lx0e+WZz5tMt13ifB9BUl9IaFsWNqxBWo/bvVPc3tVSszdr6p
        Otq1LIybrr6TiEk9LXufGFgjyR5J/tos43cjTLhkTQ==
X-Google-Smtp-Source: ABdhPJwzwDINb3ns3Cp832HhOjuUTFM1ozT9iHLW2N0EKRAzFHGslaUcpij+yIP4IAk6go9O4lzqaBQwKLO9C1yk9vE=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr7623323pfi.49.1607619993694; Thu, 10 Dec
 2020 09:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-3-songmuchun@bytedance.com> <20201210161029.GI264602@cmpxchg.org>
In-Reply-To: <20201210161029.GI264602@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 01:05:57 +0800
Message-ID: <CAMZfGtWBqR=__CLL_nsXUAOirT8mrgCjh8BTipNH_H2qUijixA@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 02/12] mm: memcontrol: convert
 NR_ANON_THPS account to pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Dec 06, 2020 at 06:14:41PM +0800, Muchun Song wrote:
> > @@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
> >                * disabled.
> >                */
> >               if (compound)
> > -                     __inc_lruvec_page_state(page, NR_ANON_THPS);
> > +                     __mod_lruvec_page_state(page, NR_ANON_THPS,
> > +                                             HPAGE_PMD_NR);
> >               __mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>
> What I mistakenly wrote about the previous patch applies to this and
> the following patches, though:
>
> /proc/vmstat currently prints number of anon, file and shmem THPs; you
> are changing it to print number of 4k pages in those THPs.
>
> That's an ABI change we cannot really do.

Agree. Sorry. I forgot to fix the /proc/vmstat. Thanks for your
reminder.


-- 
Yours,
Muchun
