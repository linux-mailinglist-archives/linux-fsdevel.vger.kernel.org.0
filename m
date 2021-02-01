Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03F30AD77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBARKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 12:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBARKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:10:38 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA3C061756;
        Mon,  1 Feb 2021 09:09:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rv9so25496654ejb.13;
        Mon, 01 Feb 2021 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vgOK0RvUyqfEu6HnO0iJIO2aZLK2TMzDkhHoYS2ukk=;
        b=rHT2bxfQfwZ5mWMk3cDrJ0W1k76tdrPy1AjhRMRXzlGdmEZkPZRyGI0/Cc04fgPGKV
         S1yiAre1hIGD25E4/RD85YQB5rRHo7GzgexDIU8MtX8M0aWGchMPtLSkXdlFvnD+8eaQ
         Xwd5jyOvOCav4GCtdW1nIm5u3Dfalt7QjDKwfI8vAJvsG3xVKimYvdYiZzSlnUB+X48k
         FXxEbXxgcoxCfPU3BFO47EKWIIiwqCfIWl7+dA6fQkYeAbjuGikrSjuBJgo2tibO+v8D
         nliHJdH0wNTqaMobFYhCAbsgFyw4JMvZxRQtx4qAM9Vp6iedQT9nu52xfDkx2nX7oWhk
         1lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vgOK0RvUyqfEu6HnO0iJIO2aZLK2TMzDkhHoYS2ukk=;
        b=q1BtuqtA+M3Y5rHiWNq9fW1+to5YcIvrCUCLcVuFjIpuwnV81bAfBEho67nfarvIZt
         QvYC5F2iqDjzFXwIy8C1XWcKFtHyGSIIKSJWsqtJdrxFazylbXuGKhUUKrhukX5tuiGq
         m4PvGffiy7c67wzfo1nlkkq26FphViBKkiNQ+ZIq+ToUVu999am9k57brskfNVTYvXrk
         CnSRfpaJGcpqp6d0Rh+lVGvaCZL4Ky5+wj7MFPDIJr/nlAsyZfRR+T67HRN6ZVIzXZzT
         xXl6mm7ErwwPo5mpkz0b5sVMB5+SyH2K83ga/8KzF0OhtBDTLty2rVfBfzG+EmhUy4as
         3atg==
X-Gm-Message-State: AOAM531AIIUKLfrz3oqCd5ndrh+Mvf/lHQCVDRDoQIirn5XqW7Rnz/4w
        aWJ066gj4pnJ5OlenV2vto2zzfG+ltEHmlU4O4k=
X-Google-Smtp-Source: ABdhPJz6meD3gcE/W4R+mj1RkbAqoBFuOOgqCaC+W8HFvdgeR0IXmG7m/hBapbHz45BHGcRZxk8cai3PHauyIhjFFzQ=
X-Received: by 2002:a17:906:f841:: with SMTP id ks1mr18656870ejb.507.1612199397448;
 Mon, 01 Feb 2021 09:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-8-shy828301@gmail.com>
 <6b0638ba-2513-67f5-8ef1-9e60a7d9ded6@suse.cz> <CAHbLzkpiDBMRRerr7iXtj40p=RVLTmWoWoOQbdkvG7Tsi4iirw@mail.gmail.com>
 <CAHbLzkrg8OYqbKevdV_6qJ5L9P-_8ui=HAgm-0o69yKLtMg8tQ@mail.gmail.com> <0ce8b6e4-5abb-3edb-8423-f6c222420a89@suse.cz>
In-Reply-To: <0ce8b6e4-5abb-3edb-8423-f6c222420a89@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 1 Feb 2021 09:09:45 -0800
Message-ID: <CAHbLzkpCLxzy-whY8jiSw59V-tmq=VgDuxyUcdRkWrgkZnxC2w@mail.gmail.com>
Subject: Re: [v5 PATCH 07/11] mm: vmscan: add per memcg shrinker nr_deferred
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 1, 2021 at 7:17 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/29/21 7:04 PM, Yang Shi wrote:
>
> >> > > @@ -209,9 +214,15 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >> > >               if (!new)
> >> > >                       return -ENOMEM;
> >> > >
> >> > > -             /* Set all old bits, clear all new bits */
> >> > > -             memset(new->map, (int)0xff, old_size);
> >> > > -             memset((void *)new->map + old_size, 0, size - old_size);
> >> > > +             new->map = (unsigned long *)(new + 1);
> >> > > +             new->nr_deferred = (void *)new->map + m_size;
> >> >
> >> > This better be aligned to sizeof(atomic_long_t). Can we be sure about that?
> >>
> >> Good point. No, if unsigned long is 32 bit on some 64 bit machines.
> >
> > I think we could just change map to "u64" and guarantee struct
> > shrinker_info is aligned to 64 bit.
>
> What about changing to order, nr_deferred before map? Then the atomics are at
> the beginning of allocated area, thus aligned.

Yes, it works too. The rcu_head is guaranteed to have aligned at sizeof(void *).

Will fix in v6.
