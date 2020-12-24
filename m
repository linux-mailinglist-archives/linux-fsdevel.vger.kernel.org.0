Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6D2E23C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 03:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgLXCrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 21:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgLXCrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:47:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708EC0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 18:46:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so735639pgl.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Dec 2020 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDRfu0M1YLV1uhT7YoKaiH9p9Ye/ITZc1yvaQ4SUQRQ=;
        b=ZJPDaWbo/DIXrpPoj3kbzFZq3ifzLIDVBRcOUeeDau6bNYnMbfXwq+Q3xjq+SqbDy4
         Dim1zSamlWYGDHO7vC5p5k5feoa3IXuVpZaqrm86asSB+klu5vOjmug219Kw/52k8nAo
         eHOfWtYH2gjhQhErEg4GMr3D5/GaUBAn4XQCkV/btHnMMR6M1AEaIiPQpHv9/jr0V9p5
         dPyMkWT6VkJRbkcY3AvB9Eta4zTVQCQmf9DRFylxLwf8Zm98OVmndOXtNERC8HmdkP0F
         kuhZWGA2K7XU/Gz+RkI2T6VYvzo+paOxH/7ud2cUmqITTJde3TZ5DowlQoAvpRH7yspk
         1t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDRfu0M1YLV1uhT7YoKaiH9p9Ye/ITZc1yvaQ4SUQRQ=;
        b=hhpQZaXOyzbRLE1K13bHv5rX/Vah4IYLU4OOs7wfCQ2bpeGuSVG+u6zpWoftMhGb5L
         QjhgjmeFokSu9BsUB6hPNAuFErFhZ8m4TDtE+wmEsf/KMlMCprkEOsDTptFV2YM8KfPH
         9Cxwc5zdAURVMmgTkYrlWVa0QpXZ/FkEs6yE5lOvaDSL6u2SNeT9LwirAGmwMlKj7uTH
         xGgNqD1iQ+mK1cXLSQL74AeQEswOaqr0uFiSzk6UxjV+ONjAuWw/j+E+SOAhs/9SHitz
         RIkDbaCZihPfFWjJz2J7s9LYSvEm6SUDYpFiywG/HccHxX5hRf0Ezg/OXp1i3J1aRkkg
         KToQ==
X-Gm-Message-State: AOAM532AeS/W914M3heqpWHEGFBt90rzx2b9ilJUs+13ov7Q87UUFK2+
        xx5TCBFfspVa23Oy8dAb3MzFVDwUVzM9xgvhQBMSyg==
X-Google-Smtp-Source: ABdhPJwYrW/b7eupKEutfmD9j8Xwe7uZNE+Erred065j6h0pMc4R4dMuAUJfUM4SPXlq+LkRkRNFBEAp1N6bYEuBtHo=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr26008689pfp.49.1608777994836; Wed, 23
 Dec 2020 18:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20201217034356.4708-1-songmuchun@bytedance.com>
 <20201217034356.4708-3-songmuchun@bytedance.com> <CALvZod7kMhb7k6rDZj18JTE=RMji-SinJmfdcPbN9PUL9Off_w@mail.gmail.com>
In-Reply-To: <CALvZod7kMhb7k6rDZj18JTE=RMji-SinJmfdcPbN9PUL9Off_w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Dec 2020 10:45:58 +0800
Message-ID: <CAMZfGtVQvD4o-nVdCqNBjWtjDzxcfqme9xMH9ar=C=_sMyDm+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/7] mm: memcontrol: convert
 NR_ANON_THPS account to pages
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 24, 2020 at 6:08 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Dec 16, 2020 at 7:45 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Currently we use struct per_cpu_nodestat to cache the vmstat
> > counters, which leads to inaccurate statistics expecially THP
>
> *especially

Thanks.

>
> > vmstat counters. In the systems with hundreads of processors
>
> *hundreds

Thanks.

>
> > it can be GBs of memory. For example, for a 96 CPUs system,
> > the threshold is the maximum number of 125. And the per cpu
> > counters can cache 23.4375 GB in total.
> >
> > The THP page is already a form of batched addition (it will
> > add 512 worth of memory in one go) so skipping the batching
> > seems like sensible. Although every THP stats update overflows
> > the per-cpu counter, resorting to atomic global updates. But
> > it can make the statistics more accuracy for the THP vmstat
> > counters.
> >
> > So we convert the NR_ANON_THPS account to pages. This patch
> > is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
> > on compound page arrival"). Doing this also can make the unit
> > of vmstat counters more unified. Finally, the unit of the vmstat
> > counters are pages, kB and bytes. The B/KB suffix can tell us
> > that the unit is bytes or kB. The rest which is without suffix
> > are pages.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> I agree with the motivation behind this patch but I would like to see
> some performance numbers in the commit message. We might agree to pay
> the price but at least we will know what exactly that cost is.

Do you have any recommendations about benchmarks?
I can do a test. Thanks very much.

-- 
Yours,
Muchun
