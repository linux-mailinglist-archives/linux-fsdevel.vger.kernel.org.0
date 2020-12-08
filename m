Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E032D20D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgLHCaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgLHCap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:30:45 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC17C061749
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 18:29:59 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c12so5321670pfo.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 18:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CH7xlBpG5Zzki/I0pNBCcovPXjgp215OcunjJaNzVcc=;
        b=V7atJSCte4bFOWHk0qsCWTfnLuJ+UxQ/uwlkqIATLHBwZoo+PiUsnBOD/Eh8d5fLjb
         fic9D7J2wW7Kfc/uN96HMHD1VaNDk6m8UIHLD5y9sGrwLWk2uvmxbvLOc+pMpAIHp9en
         UZkOvNmBlt7mPlN/HxiVH1/FDjn6Kcjq5ueHMQVzwHAK6DH730S3sPzUFDeOku8m4POh
         4uT1KDIT9Icxs9Cg6+xXE/3D1v/iNGPP7OUKux/LT6sanoaCOsbpxYx6Rv7dr0u+mHcY
         O0g3F8kKAW6PnnhlrhwoPeTuyUEGrPHdo3RTKoNBx+FOfTcMKLNHoU9LrgpGakM5r8hI
         FTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH7xlBpG5Zzki/I0pNBCcovPXjgp215OcunjJaNzVcc=;
        b=Ktv0ZmgYY5YclW12U+9YUcsaOvLKmJpJec2glYYnGFZE6FqumZfJLQD1BE92xeZXv4
         JcrnZuxzskbindTqAD0ZhhL4KfH0yXX1A1rjvMGxZky3IatTliRELillmKW5hteg43cf
         fkFgp1UAG1ApthhyDMTpouBS2QNrrjf1TD7tsisTOtbkcTEB2N1BwRMDqzxWW/rhkfxx
         yi33eBltxZmo/x3xJAMicRthRJHY5RSO/A6hQoH7BdGgb6XNiyNi93nFYeReUBt6QE1r
         T/PzvIRYH9tDbyxxYg6qe+vPguk7Q3sGYG4OJSta1mS/ne15QRs8GGYEgnWW9p9YzEO9
         Gg/g==
X-Gm-Message-State: AOAM533x10O+hBoCB/eMHVlXgGLn/fKxFOzaVlYKQmNxX45NG22Fsr0b
        wIsxsvOEbjJf6gWOeormjIecZuJkuSu/QvCrRRTXFg==
X-Google-Smtp-Source: ABdhPJwI3l3/WB76hY98qBrEl4dHP2d0i5nm9nEZOXM8eR46LqK7k0o9abK6NTHcscRg/YWXx1w38Nu3nHWFGCRaIrA=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr1807265pjr.229.1607394599426;
 Mon, 07 Dec 2020 18:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201207130018.GJ25569@dhcp22.suse.cz> <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
 <20201207150254.GL25569@dhcp22.suse.cz> <30ebae81-86e8-80db-feb6-d7c47dbaccb2@infradead.org>
In-Reply-To: <30ebae81-86e8-80db-feb6-d7c47dbaccb2@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Dec 2020 10:29:23 +0800
Message-ID: <CAMZfGtUumSm5Adoz+XTzZmjxV7krGQKffuh6NaBP0FVgTFtoJg@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat
 counters to pages or bytes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:51 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/7/20 7:02 AM, Michal Hocko wrote:
> > On Mon 07-12-20 22:52:30, Muchun Song wrote:
> >> On Mon, Dec 7, 2020 at 9:00 PM Michal Hocko <mhocko@suse.com> wrote:
> >>>
> >>> On Sun 06-12-20 18:14:39, Muchun Song wrote:
> >>>> Hi,
> >>>>
> >>>> This patch series is aimed to convert all THP vmstat counters to pages
> >>>> and some KiB vmstat counters to bytes.
> >>>>
> >>>> The unit of some vmstat counters are pages, some are bytes, some are
> >>>> HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
> >>>> counters to the userspace, we have to know the unit of the vmstat counters
> >>>> is which one. It makes the code complex. Because there are too many choices,
> >>>> the probability of making a mistake will be greater.
> >>>>
> >>>> For example, the below is some bug fix:
> >>>>   - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
> >>>>   - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")
> >>>>
> >>>> This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
> >>>> And make the unit of the vmstat counters are either pages or bytes. Fewer choices
> >>>> means lower probability of making mistakes :).
> >>>>
> >>>> This was inspired by Johannes and Roman. Thanks to them.
> >>>
> >>> It would be really great if you could summarize the current and after
> >>> the patch state so that exceptions are clear and easier to review. The
> >>
> >> Agree. Will do in the next version. Thanks.
> >>
> >>
> >>> existing situation is rather convoluted but we have at least units part
> >>> of the name so it is not too hard to notice that. Reducing exeptions
> >>> sounds nice but I am not really sure it is such an improvement it is
> >>> worth a lot of code churn. Especially when it comes to KB vs B. Counting
> >>
> >> There are two vmstat counters (NR_KERNEL_STACK_KB and
> >> NR_KERNEL_SCS_KB) whose units are KB. If we do this, all
> >> vmstat counter units are either pages or bytes in the end. When
> >> we expose those counters to userspace, it can be easy. You can
> >> reference to:
> >>
> >>     [RESEND PATCH v2 11/12] mm: memcontrol: make the slab calculation consistent
> >>
> >> From this point of view, I think that it is worth doing this. Right?
> >
> > Well, unless I am missing something, we have two counters in bytes, two
> > in kB, both clearly distinguishable by the B/KB suffix. Changing KB to B
> > will certainly reduce the different classes of units, no question about
> > that, but I am not really sure this is worth all the code churn. Maybe
> > others will think otherwise.
> >
> > As I've said the THP accounting change makes more sense to me because it
> > allows future changes which are already undergoing so there is more
> > merit in those.
> >
>
> Hi,
>
> Are there any documentation changes that go with these patches?
> Or are none needed?
>
> If the patches change the output in /proc/* or /sys/* then I expect
> there would need to be some doc changes.

Oh, we do not change the output. It is transparent to userspace.

Thanks.

>
> And is there any chance of confusing userspace s/w (binary or scripts)
> with these changes?
>
> thanks.
> --
> ~Randy
>


-- 
Yours,
Muchun
