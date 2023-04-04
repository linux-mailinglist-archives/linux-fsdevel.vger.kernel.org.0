Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C956D6FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjDDWBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjDDWBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:01:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C210E5
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 15:01:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-932df5563b8so1982766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Apr 2023 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680645694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv2TSgddRLSEtUorKz+cZ0auOFXQwhCuKUblOc6sZ88=;
        b=TOTaDgb1ZEQy4TpifDssiU2hMo1Cm+YqC5+7Z6FE95Mi/bEuyXC1u/M4aU3edREnRj
         abGD92HeZ6xgeu7FjAYw6diUoPPyfBG1cfvNqWJVOrQvHCSc4aaLOHqlslc+kFKI4RFx
         KkHaaTCIGjHuAQOfyDZVwlMnIoE8lcpPoq9l8MqbaE8cFZVMbQ5G5WhWQ91Y4e4m3QTR
         g53IZwVWiElO21KaoaDIz3BRLFRVp/qOtK8ZbX/Pda6PygBlxrT0LK7JnQg0iB79/lEI
         vyKrAH5GxEeI5sbsE4u+nfFz7mscCPPQJQ9sMQtaD9tMMP1mJa8nZUZS50ftg878I7kc
         6hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680645694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv2TSgddRLSEtUorKz+cZ0auOFXQwhCuKUblOc6sZ88=;
        b=MLmJoFyTqEjkMTEgqTK/ozdN3rtMAhOeID03N+fDi6QjP/Hqi7W48UT+Xwuo/BQlJO
         pAOkAl1ZyRjvOtyuYFuYdy+BA77af2h3sSI9ZhGSXd6eEpyBfv4aU3sxMX6tixJN4SiH
         uW0zBuhNJ/KzTLJ1UOigEJCEZmTG9I72OTZjUkP+q1l2DAagw/6R1iityZRk99QUBoal
         /1pjEXaEX9gtyyjFGaRWg9xzxU4vPzz/aKpzAiHO8u8izkRQ0Gm2akWlfcZvL2fs1zbB
         75ClPnQ+U5pWF5hgMb7nrXr2zfLgVyioHdbU12WWqfchc/bN3/dUWDGbhQ3r5w/+1t7m
         sPPg==
X-Gm-Message-State: AAQBX9e6fXpioNoASqQXeF/GDL9Sy4KMxhuWc7qkD+lGbKK1of8EhZfx
        VltmqrMWMN/pQGc6/FChsNhhQcGWG6lC708WymTJKg==
X-Google-Smtp-Source: AKy350ZHcX0TAVCqcpBXk84eCLSYS6TADo3x8F71eFEmC/F00AdU8mbkH42S6DeFTXDJYBsmoM0gtHE9yfbMO1NG5jU=
X-Received: by 2002:a50:cc8e:0:b0:4fb:9735:f915 with SMTP id
 q14-20020a50cc8e000000b004fb9735f915mr32964edi.8.1680645693595; Tue, 04 Apr
 2023 15:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230404001353.468224-1-yosryahmed@google.com>
 <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
 <CAJD7tkbZgA7QhkuxEbp=Sam6NCA0i3cZJYF4Z1nrLK1=Rem+Gg@mail.gmail.com> <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
In-Reply-To: <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Apr 2023 15:00:57 -0700
Message-ID: <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Ignore non-LRU-based reclaim in memcg reclaim
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
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

On Tue, Apr 4, 2023 at 2:58=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 4 Apr 2023 14:49:13 -0700 Yosry Ahmed <yosryahmed@google.com> wro=
te:
>
> > On Tue, Apr 4, 2023 at 2:38=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Tue,  4 Apr 2023 00:13:50 +0000 Yosry Ahmed <yosryahmed@google.com=
> wrote:
> > >
> > > > Upon running some proactive reclaim tests using memory.reclaim, we
> > > > noticed some tests flaking where writing to memory.reclaim would be
> > > > successful even though we did not reclaim the requested amount full=
y.
> > > > Looking further into it, I discovered that *sometimes* we over-repo=
rt
> > > > the number of reclaimed pages in memcg reclaim.
> > > >
> > > > Reclaimed pages through other means than LRU-based reclaim are trac=
ked
> > > > through reclaim_state in struct scan_control, which is stashed in
> > > > current task_struct. These pages are added to the number of reclaim=
ed
> > > > pages through LRUs. For memcg reclaim, these pages generally cannot=
 be
> > > > linked to the memcg under reclaim and can cause an overestimated co=
unt
> > > > of reclaimed pages. This short series tries to address that.
> > > >
> > > > Patches 1-2 are just refactoring, they add helpers that wrap some
> > > > operations on current->reclaim_state, and rename
> > > > reclaim_state->reclaimed_slab to reclaim_state->reclaimed.
> > > >
> > > > Patch 3 ignores pages reclaimed outside of LRU reclaim in memcg rec=
laim.
> > > > The pages are uncharged anyway, so even if we end up under-reportin=
g
> > > > reclaimed pages we will still succeed in making progress during
> > > > charging.
> > > >
> > > > Do not let the diff stat deceive you, the core of this series is pa=
tch 3,
> > > > which has one line of code change. All the rest is refactoring and =
one
> > > > huge comment.
> > > >
> > >
> > > Wouldn't it be better to do this as a single one-line patch for
> > > backportability?  Then all the refactoring etcetera can be added on
> > > later.
> >
> > Without refactoring the code that adds reclaim_state->reclaimed to
> > scan_control->nr_reclaimed into a helper (flush_reclaim_state()), the
> > change would need to be done in two places instead of one, and I
> > wouldn't know where to put the huge comment.
>
> Well, all depends on how desirable it it that we backport.  If "not
> desirable" then leave things as-is.  If at least "possibly desirable"
> then a simple patch with the two changes and no elaborate comment will
> suit.
>

I would rather leave the current series as-is with an elaborate
comment. I can send a separate single patch as a backport to stable if
this is something that we usually do (though I am not sure how to
format such patch).
