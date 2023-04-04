Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE206D70E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjDDXrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjDDXrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 19:47:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AEC40D9
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 16:47:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-92fcb45a2cdso6367266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Apr 2023 16:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680652027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi8MTES466++qI3K8H2RA5xq0z5Rl84WyOaFw5DuASg=;
        b=If2bQ4PP42IMPaWPi/mxpS5uD6z8AbVQFXkkogns9TNyuIiTffcA5kdXIUSlty2ruA
         rgjxNGKOv1BufEIWhTD9lu0c4K7mbT4yKTlNFkff+F42czJEauhWZY6XNFIGiNjhQGGi
         wyphX7FpCilXQmTlQXOrHfAEZBurxOp8njL4j8MlQWFZfGqvlUkg+F1zYaJOC/+nb5Pm
         dq1esF1Dqz+Fpvnkx4FwAirFKJoN4xNv4NwZ+1tfRJWFBd8Or9qU3CKgrDUU0sPaDtY6
         0t1e9LwZ0ZXNWN9lWxopo8+RD7NR4rw/k5+aglNEJvKLnm4KjJ8YtgtcKQaKPOHxNSaU
         At6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680652027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi8MTES466++qI3K8H2RA5xq0z5Rl84WyOaFw5DuASg=;
        b=4lV0iHXcz+/ImNmXOKjD4B/b0AGDSDYohAMEJlyNWRzyCn6/Xd1tRhgoJJqzAy27VF
         HOyk+6S6Cjm3G901uREe/0pSGDlrilAmNxSk5RqZtUYemu/34nVvPl/iOBOjXO8/CzmI
         XgXbWw/f2EgMWVLCyEx4ATpfNmMTuFruTN3cdVfTpvYdNYEFrjk35yiA4GqWeTtfCmZX
         toNqn6UTnfPc/LQlECioQeNS/Qm/uWyRNec85xrGmOmW2F8VVyds2F/x9NC6ZWOH8Tkk
         eNBke5BY/5QxScT+Rb5/e0BAxngnPivfcclXkpQpVaC6xRkI5jZJeYd7ewKUPVs5GnJd
         XqVg==
X-Gm-Message-State: AAQBX9dRiPe50TKxSgRJ49tEtszsNMSCynRUH69d/CdLwqvUKQ5i9Mwd
        hjYD5cEE35rG+BU+6UGmjOCY+xkqcvlewEuNog9Q5w==
X-Google-Smtp-Source: AKy350amp5Q0CsMRA0vsSv+2EQyk24jR2b8+hCJYdKxg84vsQgd8qYOXeaFgiz9iTyZrvy0BpEcL+UO1UUrppWOUht0=
X-Received: by 2002:a50:aac1:0:b0:502:1d1c:7d37 with SMTP id
 r1-20020a50aac1000000b005021d1c7d37mr140133edc.8.1680652026905; Tue, 04 Apr
 2023 16:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230404001353.468224-1-yosryahmed@google.com>
 <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
 <CAJD7tkbZgA7QhkuxEbp=Sam6NCA0i3cZJYF4Z1nrLK1=Rem+Gg@mail.gmail.com>
 <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
 <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com>
 <20230404152816.cec6d41bfb9de4680ae8c787@linux-foundation.org> <20230404153124.b0fa5074cf9fc3b9925e8000@linux-foundation.org>
In-Reply-To: <20230404153124.b0fa5074cf9fc3b9925e8000@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Apr 2023 16:46:30 -0700
Message-ID: <CAJD7tkYFZGJqZ278stOWDyW3HgMP8iyAZu8hSG+bV-p9YoVxig@mail.gmail.com>
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

On Tue, Apr 4, 2023 at 3:31=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 4 Apr 2023 15:28:16 -0700 Andrew Morton <akpm@linux-foundation.or=
g> wrote:
>
> > On Tue, 4 Apr 2023 15:00:57 -0700 Yosry Ahmed <yosryahmed@google.com> w=
rote:
> >
> > > ...
> > >
> > > > >
> > > > > Without refactoring the code that adds reclaim_state->reclaimed t=
o
> > > > > scan_control->nr_reclaimed into a helper (flush_reclaim_state()),=
 the
> > > > > change would need to be done in two places instead of one, and I
> > > > > wouldn't know where to put the huge comment.
> > > >
> > > > Well, all depends on how desirable it it that we backport.  If "not
> > > > desirable" then leave things as-is.  If at least "possibly desirabl=
e"
> > > > then a simple patch with the two changes and no elaborate comment w=
ill
> > > > suit.
> > > >
> > >
> > > I would rather leave the current series as-is with an elaborate
> > > comment. I can send a separate single patch as a backport to stable i=
f
> > > this is something that we usually do (though I am not sure how to
> > > format such patch).
> >
> > -stable maintainers prefer to take something which has already been
> > accepted by Linus.
> >
> > The series could be as simple as
> >
> > simple-two-liner.patch
> > revert-simple-two-liner.patch
> > this-series-as-is.patch
> >
> > simple-two-liner.patch goes into 6.3-rcX and -stable.  The other
> > patches into 6.4-rc1.
>
> But the key question remains: how desirable is a backport?
>
> Looking at the changelogs I'm not seeing a clear statement of the
> impact upon real-world users' real-world workloads.  (This is a hint).
> So I am unable to judge.
>
> Please share your thoughts on this.

I think it's nice to have but not really important. It occasionally
causes writes to memory.reclaim to report false positives and *might*
cause unnecessary retrying when charging memory, but probably too rare
to be a practical problem.

Personally, I intend to backport to our kernel at Google because it's
a simple enough fix and we have occasionally seen test flakiness
without it.

I have a reworked version of the series that only has 2 patches:
- simple-two-liner-patch (actually 5 lines)
- one patch including all refactoring squashed (introducing
flush_reclaim_state() with the huge comment, introducing
mm_account_reclaimed_pages(), and moving set_task_reclaim_state()
around).

Let me know if you want me to send it as v5, or leave the current v4
if you think backporting is not generally important.

>
