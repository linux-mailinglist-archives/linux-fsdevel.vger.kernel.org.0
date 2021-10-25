Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360AC439896
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhJYOdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhJYOdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:33:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D7C061746;
        Mon, 25 Oct 2021 07:30:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u13so237719edy.10;
        Mon, 25 Oct 2021 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmXQJiEvyexYZAONYS1YO/YN6HE7AsF0Zix0o2xmTTs=;
        b=YmjZEhwNJ2zDDKg7PLfT6QNaOw4P3QVEVGpEa2VRRtXHHIKks3DTI2BvjyglKfUxuk
         0mlJ9CyhXZL91zeGmZlYEy1v7KcEouS/uUKkvHWzW4/xttXtoHXvS+yztHbugX+PQz20
         zYaKRLql3hMtyMt0/Jq1/kvC2my1hyAcMvIUXfgOwhxsTd7grf5UXfZKshUxHrcF/xel
         wG82/s7mKbbUlGYrZvde4MyDDb5LN12zm8HHYgwRSEiFy50sBapcBt+quOjvtr8DO9tP
         ez2wHieQ+AefXVUT9mBA9y2UHnhM3zaeoHusYa/ZqPwFRkOj/4Vb34dGPgLTNqG3y8Ja
         aUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmXQJiEvyexYZAONYS1YO/YN6HE7AsF0Zix0o2xmTTs=;
        b=2vvklblGBCez9UPMwCuVDcr60Oz8Nu470ut3ylccdaRPhyt8zN8QTx46vCqPRqzBCv
         u06/nv614kaBSLsPD52HFwdZn3kHFswnAoC6v363nXp61y/cOIxnTXASIY5q56/5OG9P
         9M7ys7VuxSi/BwHwz2k4//CYirvXZk1BxDuFPKDNemcxtEbOEM1Y22SRbcdcn70+JJw4
         zxufi3JSw99Sjqku1gd7+YMck+eGc7uMOfn7whgtycgGH3t3m14TmPHTFu+vsBY+h5XR
         85tCyTdtgZhi5UKgP1GjfHmfD1gjw9qWm9fRtmsOJ+HbvaN0LhhrcBsGEyn1mSLxVD5j
         nuTQ==
X-Gm-Message-State: AOAM5311PUIVLzL6IUiT7PEYHJ7eTJRiXtI492gy3tcbPg408+WmTizq
        A/YK7QuI8a8RSCEkh8jw7ENv20f4YkquO0knoW4=
X-Google-Smtp-Source: ABdhPJzmdRna3K6azm05c9x9j7TXfHuxwBtu0a80+n+XCgX3jLVIB8JKvIGWBLQfKYgJJaRmcJPVmLRTVJTqIQ5YRhk=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr27220376edb.209.1635172235120;
 Mon, 25 Oct 2021 07:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <YXAiZdvk8CGvZCIM@dhcp22.suse.cz> <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz> <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan> <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz> <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
 <20211025094841.GA1945@pc638.lan> <YXaTBrhEqTZhTJYX@dhcp22.suse.cz>
In-Reply-To: <YXaTBrhEqTZhTJYX@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 25 Oct 2021 16:30:23 +0200
Message-ID: <CA+KHdyWeQ77uWg5GxJGYiNeG_2ZuKu62-i=L7kqhw__g--XGYg@mail.gmail.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     NeilBrown <neilb@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> I would really prefer if this was not the main point of arguing here.
> Unless you feel strongly about msleep I would go with schedule_timeout
> here because this is a more widely used interface in the mm code and
> also because I feel like that relying on the rounding behavior is just
> subtle. Here is what I have staged now.
>
I have a preference but do not have a strong opinion here. You can go
either way you want.

>
> Are there any other concerns you see with this or other patches in the
> series?
>
it is better if you could send a new vX version because it is hard to
combine every "folded"
into one solid commit. One comment below:

> ---
> commit c1a7e40e6b56fed5b9e716de7055b77ea29d89d0
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Wed Oct 20 10:12:45 2021 +0200
>
>     fold me "mm/vmalloc: add support for __GFP_NOFAIL"
>
>     Add a short sleep before retrying. 1 jiffy is a completely random
>     timeout. Ideally the retry would wait for an explicit event - e.g.
>     a change to the vmalloc space change if the failure was caused by
>     the space fragmentation or depletion. But there are multiple different
>     reasons to retry and this could become much more complex. Keep the retry
>     simple for now and just sleep to prevent from hogging CPUs.
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0fb5413d9239..a866db0c9c31 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2944,6 +2944,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>         do {
>                 ret = vmap_pages_range(addr, addr + size, prot, area->pages,
>                         page_shift);
> +               schedule_timeout_uninterruptible(1);
>
We do not want to schedule_timeout_uninterruptible(1); every time.
Only when an error is detected.

-- 
Uladzislau Rezki
