Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1629C308AF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhA2RG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA2RGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:06:23 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1EC061573;
        Fri, 29 Jan 2021 09:05:42 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ox12so14106703ejb.2;
        Fri, 29 Jan 2021 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjU1ft3CFBesr8MYGZFVFpiy1HInqyD6mtninlntO/8=;
        b=UNyGZ0gKDZ5PJ0jlRi0rzX54uMKknI6+9o8e1gk8IhssVjwg+I8vBFqp9cJlxpLsQ7
         Fn4t/zjEBE2eSb2hQStKvrS0377E8mqSxoYj6V8h/K474cqAQewOC7pb3SEVdgKcWDqa
         EAtyqtPJibedl0AeVa0vxdrYvQLClvm5ShiEThAywr7jQ25eQ2Q7Y+9Jhevd4nXQuLQo
         zKqk4vT1VOEIoXuQaGWcFj1UNdSFbKfB8lt83r6qj1QvYO1pKyYNJu8c1p+/UAnNWB4S
         8a5djwz21voP7TEEZQt3wyEnD1ov2t/l0PlhobdWmuo2NzPok+WX3Mjyso5HeyF0cR3I
         N3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjU1ft3CFBesr8MYGZFVFpiy1HInqyD6mtninlntO/8=;
        b=T3Z7d6EC/lYCUUT3f8Cenau1GQOVG/G/pQJvqKfbIBTbAeEzGPCWUBj5zT1UAjLKWk
         TYfcyCwQMFFr5LOeZcwrDCcPGwFuBjLNQ+w08JCpt7qBVuA90Pe/yiBTxlBtEXZbw/5V
         LXXzJ+pWlIdVHW+LgpSsSMpS0NZUEw64wUnOtBoaOmHFBK/QLWzLrda68HgGyxtd6sdu
         m83QFmNRBrYK3yH+v6H12tYLCnr4M5aA+c9rdWlRj2LV0cWF/B9Kzdx4VmMcPUpF9uoQ
         2YPcwojAWbeIBAD9INTxc2Hfe1rlbUWX4HsTpE5KJGJE+gkFjw+aQiRdpR7i5aqwKtGq
         o+OQ==
X-Gm-Message-State: AOAM530H12BSBy/FeD8RsoxOp1oYHcjft4ZDObx0eU42EjD1s4DImifA
        y9ycGEq7PhPJiJq4BoZHk1EHHLAYagjMGFGYWM0=
X-Google-Smtp-Source: ABdhPJyPXLfIMUhva87EtUR+iiGiROJdJ7Oao5cqEGU4srnfRxkHnMecVqPEQpyR0TV0+Ld6P+964XMnsC6dwXxtwpQ=
X-Received: by 2002:a17:906:94d3:: with SMTP id d19mr5429345ejy.383.1611939941556;
 Fri, 29 Jan 2021 09:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-5-shy828301@gmail.com>
 <255b9236-3e0b-f6f6-4a72-5e69351a979a@suse.cz> <CAHbLzkrN2aW03TUrC3sOANS7YV6+KMisDtsXDH2W42-1tOJziw@mail.gmail.com>
 <b2f23595-e89c-b125-846e-d8b8dd362a04@suse.cz>
In-Reply-To: <b2f23595-e89c-b125-846e-d8b8dd362a04@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 09:05:30 -0800
Message-ID: <CAHbLzkruSYh8DCBsaDOys0s-hkyi07PAAe1gdKOfGjEh08do4g@mail.gmail.com>
Subject: Re: [v5 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
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

On Fri, Jan 29, 2021 at 3:22 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 10:22 PM, Yang Shi wrote:
> >> > @@ -266,12 +265,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >> >  static int expand_shrinker_maps(int new_id)
> >> >  {
> >> >       int size, old_size, ret = 0;
> >> > +     int new_nr_max = new_id + 1;
> >> >       struct mem_cgroup *memcg;
> >> >
> >> > -     size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> >> > -     old_size = memcg_shrinker_map_size;
> >> > +     size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> >> > +     old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> >>
> >> What's wrong with using DIV_ROUND_UP() here?
> >
> > I don't think there is anything wrong with DIV_ROUND_UP. Should be
> > just different taste and result in shorter statement.
>
> IMHO it's not just taste. DIV_ROUND_UP() says what it does and you don't need to
> guess it from the math expression. Also your expression is shorter as it simply
> adds + 1, so if shrinker_nr_max is a multiple of BITS_PER_LONG, there's an extra
> unsigned long that shouldn't be needed. People reading that code will wonder
> whether there was some non-obvious intention behind that, and possibly send
> cleanup patches.

OK, will replace back to DIV_ROUND_UP(). And, a helper macro is
introduced in patch #6, will add that helper in this patch and use
DIV_ROUND_UP() in the helper.

>
> >>
> >> >       if (size <= old_size)
> >> > -             return 0;
> >> > +             goto out;
> >>
> >> Can this even happen? Seems to me it can't, so just remove this?
> >
> > Yes, it can. The maps use unsigned long value for bitmap, so any
> > shrinker ID < 31 would fall into the same unsigned long, so we may see
> > size <= old_size, but we need increase shrinker_nr_max since
> > expand_shrinker_maps() is called iff id >= shrinker_nr_max.
>
> Ah, good point.
