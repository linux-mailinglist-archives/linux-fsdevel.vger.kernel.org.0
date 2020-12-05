Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671452CFD66
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgLESce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgLES2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:28:55 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE4BC094240
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Dec 2020 08:53:11 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so6019672pfu.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Dec 2020 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TjBWxHeiYLGN2gLQ9wB5wlqIelnuKaJ3NWlRad2iWo=;
        b=lHercq+HFs9Uw4tBCUBPVfm4XBHEjObQ2+zuVWYecpGDyqFLGynsD/AS+5i0AyeHq/
         K6ze34AxmCpza061G3nwgZIiUh0OmEOpNFMg+6zIIGochjQhJZMMclJbcnWaQjNFl4jH
         FHmt9G4qXYxRcmaDVviFYXWC40swpwKncRblXHFOMLT/bPiCU6AjbLED5NF2oKlJJBoV
         jkVuZmlzv7QfSJNzrIohVAVf6pxyKeWq6LyIcowmbgYTxrkUjlB7EThoh9ahUzcwn5um
         OgPX+0xIn0N6nmIBXwGoSm3purEI2y21/BPelFRc0s9F5r0ZH9z63jHb+Tu4eBj/mOre
         eBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TjBWxHeiYLGN2gLQ9wB5wlqIelnuKaJ3NWlRad2iWo=;
        b=kFb3kbFNx6REJiSAVoclIEIrpp/rORJHMXdkuf6JAdmPaxLaVVYLn21vpJWGJPZQZY
         1sLhKxgE0EFLPjyluxCVdmwmMgRxY01nBTsUH36Z42GN5z8GgnVY/vj/B87ABPOjbhjo
         S4F9aaFSQyO+5EmA+O25IP/Ib+o87D1PaFPTPzCW7Zu4Fajl/NhXONw3E2K8U0kRXB4u
         9UaYyOIkbYwPGMHqMfmWLypxyKSdCrUfDit3ZQzZqsQu01p/N6UFE5ljoT079sRgHK0g
         ao2hD3GYR4pZTRvC4utfL0BIq/+e0FcXV5oxCmsjGAcJ16MiEoujkQS4LDsgcUoq3fXB
         S/HQ==
X-Gm-Message-State: AOAM532x5gtzscqvKzVgWIZKf/aujw52dQOwLbYf90Iqi4yeStlHXyBr
        V/GS/BA6izSw5KX3U8NVesN4kl5zb3WRU1Aq97td7A==
X-Google-Smtp-Source: ABdhPJzev4SOyNkd0pIPjnjQ1qaDF4+LzMeAeeaiv9OetFzM0zk1Ry1aFRwDmwtFpgLA7fSbZT5Ksai4SYr2hR54uZU=
X-Received: by 2002:a63:c15:: with SMTP id b21mr12035007pgl.341.1607187190737;
 Sat, 05 Dec 2020 08:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20201205130224.81607-1-songmuchun@bytedance.com>
 <20201205130224.81607-6-songmuchun@bytedance.com> <X8uU6ODzteuBY9pf@kroah.com>
 <CAMZfGtWjumNV4hu-Qv8Z+WoS-EmyhvQd1qsaoS1quvQCyczT=g@mail.gmail.com>
 <X8uoITGcfvZ/EA74@kroah.com> <CAMZfGtWmoPjuxfwYFUACRBCBgk3q77Sfv0kE2ysoX-9LJ8s2Zw@mail.gmail.com>
 <X8u2TavrUAnnhq+M@kroah.com>
In-Reply-To: <X8u2TavrUAnnhq+M@kroah.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 6 Dec 2020 00:52:34 +0800
Message-ID: <CAMZfGtUTotdRbGEE85SD_6B7_X=L1hU_8JAWbwPN7ztWCTD-Sg@mail.gmail.com>
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

On Sun, Dec 6, 2020 at 12:32 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 05, 2020 at 11:39:24PM +0800, Muchun Song wrote:
> > On Sat, Dec 5, 2020 at 11:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Dec 05, 2020 at 11:29:26PM +0800, Muchun Song wrote:
> > > > On Sat, Dec 5, 2020 at 10:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sat, Dec 05, 2020 at 09:02:20PM +0800, Muchun Song wrote:
> > > > > > Converrt NR_FILE_THPS account to pages.
> > > > > >
> > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > ---
> > > > > >  drivers/base/node.c | 3 +--
> > > > > >  fs/proc/meminfo.c   | 2 +-
> > > > > >  mm/filemap.c        | 2 +-
> > > > > >  mm/huge_memory.c    | 3 ++-
> > > > > >  mm/khugepaged.c     | 2 +-
> > > > > >  mm/memcontrol.c     | 5 ++---
> > > > > >  6 files changed, 8 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > > > index 05c369e93e16..f6a9521bbcf8 100644
> > > > > > --- a/drivers/base/node.c
> > > > > > +++ b/drivers/base/node.c
> > > > > > @@ -466,8 +466,7 @@ static ssize_t node_read_meminfo(struct device *dev,
> > > > > >                                   HPAGE_PMD_NR),
> > > > > >                            nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
> > > > > >                                   HPAGE_PMD_NR),
> > > > > > -                          nid, K(node_page_state(pgdat, NR_FILE_THPS) *
> > > > > > -                                 HPAGE_PMD_NR),
> > > > > > +                          nid, K(node_page_state(pgdat, NR_FILE_THPS)),
> > > > >
> > > > > Again, is this changing a user-visable value?
> > > > >
> > > >
> > > > Of course not.
> > > >
> > > > In the previous, the NR_FILE_THPS account is like below:
> > > >
> > > >     __mod_lruvec_page_state(page, NR_FILE_THPS, 1);
> > > >
> > > > With this patch, it is:
> > > >
> > > >     __mod_lruvec_page_state(page, NR_FILE_THPS, HPAGE_PMD_NR);
> > > >
> > > > So the result is not changed from the view of user space.
> > >
> > > So you "broke" it on the previous patch and "fixed" it on this one?  Why
> > > not just do it all in one patch?
> >
> > Sorry for the confusion. I mean that the "previous" is without all of this patch
> > series. So this series is aimed to convert the unit of all different THP vmstat
> > counters from HPAGE_PMD_NR to pages. Thanks.
>
> I'm sorry, I still do not understand.  It looks to me that you are
> changing the number printed to userspace here.  Where is the
> corrisponding change that changed the units for this function?  Is it in
> this patch?  If so, sorry, I did not see that at all...

Sorry, actually, this patch does not change the number printed to
userspace. It only changes the unit of the vmstat counter.

Without this patch, every counter of NR_FILE_THPS represents
NR_FILE_THPS pages. However, with this patch, every counter
represents only one page. And why do I want to do this? Can
reference to the cover letter. Thanks very much.

>
> thanks,
>
> greg k-h



-- 
Yours,
Muchun
