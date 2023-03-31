Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6B6D1897
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCaHaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:30:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1CEFF1A
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:30:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so85971105edd.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680247847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3XUuqj7bKq4sqEKBJ9kOUJxwFH8O9yCA3hlxqudGM0=;
        b=ZJ2LTdKfP/dAFMQDQkpdCGFmdqEJnIPuRIEmPgNneqWjwxu56d8a9f1xM1kEqG53C8
         hKtc3aFtSKmXBq7xMndGMx9yInLTGifW7IFhF+y/nsdiPAkwH79Li1rdyvUunm6K+kIF
         fuVosgq7RsPqtx+KDgnV80nxZckDEMDTGGRehphSIv5SOMiHFn2+nN88e7YhKNn6UXdK
         xPl8SyLKrQhrDzWqFEQGW9Ur+LD8P6Jp6MeBDz1jTUBit3TtXxKXj4TJ979fGqTnuVqU
         JwW2zuI12L5XMn6L0d0gI36rkXhJta0wkNZJYbuuOfOSlx6z0tfhlogJEK6abpUX34lg
         QtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680247847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3XUuqj7bKq4sqEKBJ9kOUJxwFH8O9yCA3hlxqudGM0=;
        b=FdhUEN0X5LubgKlG4gcQ9FTQhm5NLUw2R0GQp+uWMqIfoEgg2abySt/7DM4av6wjbC
         ytw25bNxRdrCgjIwtkw2gStOYko1+kwCRmvQpIuDqXlxzWkQ+xNDMZhgbwxVGukSIW+g
         u7lS/OhslfNI7hNeoaivLUKX3pZgC/Q1+56PXJP1CHMqMFd+ZkXOZSUmw00ucKhKnuT3
         ezHtTdh9ZSnzx7KyMzG4IDD9QsRp9U0iThuiR1JFtAgx39EeUTrFg1tS+5xmOJxg21LI
         66ILFZbpW0sAcK9pgFJL7D4alj1rAwnQUmsZxblzhggWbUcboQc1w987XUki4+FT2Bal
         S4nA==
X-Gm-Message-State: AAQBX9eoQUFnhImmPRkaCh9PIcUkeYinBrwWEIMfi0tDDx1vWKTttHqp
        LwjufyqKjA9c88wrVbpjs3ZDSfpOa+6kKeNTuk3Q5g==
X-Google-Smtp-Source: AKy350b5AcmwLZ9juLlS9K/F62ATFOsAhPvyQLkDd1WrL6qYD19g5H8RANCYexuuLD3iuFmBRlqQISUwO5ZWA2jECMo=
X-Received: by 2002:a17:906:2a15:b0:933:7658:8b44 with SMTP id
 j21-20020a1709062a1500b0093376588b44mr11617095eje.15.1680247847390; Fri, 31
 Mar 2023 00:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230331070818.2792558-1-yosryahmed@google.com>
 <20230331070818.2792558-4-yosryahmed@google.com> <CAOUHufY2NieQ8x7-Kv8PSzMVEOjJtBhi6QwKeu-Ojxnia4-TpQ@mail.gmail.com>
In-Reply-To: <CAOUHufY2NieQ8x7-Kv8PSzMVEOjJtBhi6QwKeu-Ojxnia4-TpQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 31 Mar 2023 00:30:11 -0700
Message-ID: <CAJD7tkbOupKO1CpKbtPdVUFUfCK=UqHcpctZYU3xJ_Ho+OS6kA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:25=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Mar 31, 2023 at 1:08=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
>
> ...
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a3e38851b34ac..bf9d8e175e92a 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -533,7 +533,35 @@ EXPORT_SYMBOL(mm_account_reclaimed_pages);
> >  static void flush_reclaim_state(struct scan_control *sc,
> >                                 struct reclaim_state *rs)
> >  {
> > -       if (rs) {
> > +       /*
> > +        * Currently, reclaim_state->reclaimed includes three types of =
pages
> > +        * freed outside of vmscan:
> > +        * (1) Slab pages.
> > +        * (2) Clean file pages from pruned inodes.
> > +        * (3) XFS freed buffer pages.
> > +        *
> > +        * For all of these cases, we have no way of finding out whethe=
r these
> > +        * pages were related to the memcg under reclaim. For example, =
a freed
> > +        * slab page could have had only a single object charged to the=
 memcg
> > +        * under reclaim. Also, populated inodes are not on shrinker LR=
Us
> > +        * anymore except on highmem systems.
> > +        *
> > +        * Instead of over-reporting the reclaimed pages in a memcg rec=
laim,
> > +        * only count such pages in system-wide reclaim. This prevents
> > +        * unnecessary retries during memcg charging and false positive=
 from
> > +        * proactive reclaim (memory.reclaim).
>
> What happens when writing to the root memory.reclaim?
>
> > +        *
> > +        * For uncommon cases were the freed pages were actually signif=
icantly
> > +        * charged to the memcg under reclaim, and we end up under-repo=
rting, it
> > +        * should be fine. The freed pages will be uncharged anyway, ev=
en if
> > +        * they are not reported properly, and we will be able to make =
forward
> > +        * progress in charging (which is usually in a retry loop).
> > +        *
> > +        * We can go one step further, and report the uncharged objcg p=
ages in
> > +        * memcg reclaim, to make reporting more accurate and reduce
> > +        * under-reporting, but it's probably not worth the complexity =
for now.
> > +        */
> > +       if (rs && !cgroup_reclaim(sc)) {
>
> To answer the question above, global_reclaim() would be preferred.

Great point, global_reclaim() is fairly recent. I didn't see it
before. Thanks for pointing it out. I will change it for v4 -- will
wait for more feedback before respinning.

Thanks Yu!
