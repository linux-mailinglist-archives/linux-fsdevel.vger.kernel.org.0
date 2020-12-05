Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7C2CFDC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLESoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 13:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLEQt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:49:57 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C2C02B8F1
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Dec 2020 07:40:01 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so5924301pfg.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Dec 2020 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IX944X6oZl2Mzi0wZiZDHD4FwyqaIDsig5F+iiEk9k=;
        b=opakRlC7cQn4ZWwCZOV7BpaskunmVBhmP/y6bDVxwQnEDw1HsXsTmG7UqEkeEanTg7
         4yFQRNbstV/rae16oZ8vMyaC/8FhDJVXsSrhYShQimL2K7yAKNUxfy/V5FTqN4k8WFDC
         HKSOX5OcgbHSM/Vy8sTi8tPSzCzCURVaS1dkTfItKp5ZblNX6yRd3ajWqemrx/OUiPww
         jWOgbzl8EX/PJP/RUCYMYZQkuKqdQLRPeO49D6iT6kmEEVhHDm8XFwA9PhfZfQqZ+eQT
         nylPadt5IjBaQkx5n0qHVvuB5FfBdP/8dyJOMeY84V9ekjWUn02WrC0cCQ3aXLas8gvC
         DItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IX944X6oZl2Mzi0wZiZDHD4FwyqaIDsig5F+iiEk9k=;
        b=ctjijz3T7syFZxA+CQAUTWpSdmyhgbXOqF/nd8OEjU5EXyBqCNfjl9FZ68SJhCg9WL
         w7yRnJe4PF4TGr5pFdJjbMPdYvTn88pfoBF0Xwec4hkQzGhBN1RL5g1JU8jebzMQQKat
         4RSGT/sRCF8ps3Bzp6/n/o2FQEkiQm5FxdThtpG7ZHt+lRwKzUwf/sPs2WVWM0O0JFyW
         sK+QM9uJdNScoQax5QBRchar+DEO/+NovTz1G+TaRAs41pyghNSejYTpVlzKhTapGQwS
         Ewt2mZ7XVt7HnwekI/3/UeDczOvqcZ9cggt6UOqxQPuxKbVYHAEA8ycBRJd8GLhV6T6/
         Gzqg==
X-Gm-Message-State: AOAM533qHrGHiz0R14Okz4Hpx/wAQwSb4TpKQoAbr+ILmxyd2LpWUcIs
        WkYLf+NUExjzuviLRJCAiBD+LqFDYrlsROs9GtMYlg==
X-Google-Smtp-Source: ABdhPJxMajBcqLFmL9fRt9cb50qxiMQn7k0izPFnayPR+eOm8xMxHvwAqxpRKw2wMjyEt2Q40p/KwQd88huMo0W4kJA=
X-Received: by 2002:aa7:8105:0:b029:18e:c8d9:2c24 with SMTP id
 b5-20020aa781050000b029018ec8d92c24mr8740020pfi.49.1607182800915; Sat, 05 Dec
 2020 07:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-6-songmuchun@bytedance.com> <X8uU6ODzteuBY9pf@kroah.com>
 <CAMZfGtWjumNV4hu-Qv8Z+WoS-EmyhvQd1qsaoS1quvQCyczT=g@mail.gmail.com> <X8uoITGcfvZ/EA74@kroah.com>
In-Reply-To: <X8uoITGcfvZ/EA74@kroah.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Dec 2020 23:39:24 +0800
Message-ID: <CAMZfGtWmoPjuxfwYFUACRBCBgk3q77Sfv0kE2ysoX-9LJ8s2Zw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/9] mm: memcontrol: convert NR_FILE_THPS
 account to pages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

On Sat, Dec 5, 2020 at 11:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 05, 2020 at 11:29:26PM +0800, Muchun Song wrote:
> > On Sat, Dec 5, 2020 at 10:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Dec 05, 2020 at 09:02:20PM +0800, Muchun Song wrote:
> > > > Converrt NR_FILE_THPS account to pages.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  drivers/base/node.c | 3 +--
> > > >  fs/proc/meminfo.c   | 2 +-
> > > >  mm/filemap.c        | 2 +-
> > > >  mm/huge_memory.c    | 3 ++-
> > > >  mm/khugepaged.c     | 2 +-
> > > >  mm/memcontrol.c     | 5 ++---
> > > >  6 files changed, 8 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > index 05c369e93e16..f6a9521bbcf8 100644
> > > > --- a/drivers/base/node.c
> > > > +++ b/drivers/base/node.c
> > > > @@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> > > >                                   HPAGE_PMD_NR),
> > > >                            nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> > > >                                   HPAGE_PMD_NR),
> > > > -                          nid, K(node_page_state(pgdat, NR_FILE_THPS) *
> > > > -                                 HPAGE_PMD_NR),
> > > > +                          nid, K(node_page_state(pgdat, NR_FILE_THPS)),
> > >
> > > Again, is this changing a user-visable value?
> > >
> >
> > Of course not.
> >
> > In the previous, the NR_FILE_THPS account is like below:
> >
> >     __mod_lruvec_page_state(page, NR_FILE_THPS, 1);
> >
> > With this patch, it is:
> >
> >     __mod_lruvec_page_state(page, NR_FILE_THPS, HPAGE_PMD_NR);
> >
> > So the result is not changed from the view of user space.
>
> So you "broke" it on the previous patch and "fixed" it on this one?  Why
> not just do it all in one patch?

Sorry for the confusion. I mean that the "previous" is without all of this patch
series. So this series is aimed to convert the unit of all different THP vmstat
counters from HPAGE_PMD_NR to pages. Thanks.

>
> Confused,
>
> greg k-h



-- 
Yours,
Muchun
