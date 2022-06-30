Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44222561E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiF3O7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiF3O7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:59:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2ED1EAF0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 07:59:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h192so18766188pgc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlh+zR4sLlUERmwK/XvlQfyn3K58u4Hbj9CmOVIz4kE=;
        b=cySIqHpyfsq8wQfibZxaJwaBXBeRR3JRvYpqgG1nVFVyrgi4LGoeV1DCnz+GUpcJZi
         vT2GKVz1T5yQgwGNvIl6KYW0vxnhoYMmHep7DSLgEhlE4dH3JbX8xsH7u7Q0YDAaqWZB
         PXQeuKGS5/5qJdUNfMydr8TlO412HmIgUpCRDqcO6iCx42bmkoMoolK4422JO9qnvbKu
         sKB5LHRSVjQQL+eS4HB3OHwcVCB46n5hn22BgT5u4wWgh1yMKWK0hg2Fypw+Baqu285d
         Z1HOy9YW95intZv3yiOB/e2R2hwuAhPHQUe1HLSN9SxxalhlNtvcxT7m3s1B3qU6k40r
         XorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlh+zR4sLlUERmwK/XvlQfyn3K58u4Hbj9CmOVIz4kE=;
        b=h+/yTvZwpur/8oEtHhooWCaqL1a3odrv3sG/ftbS4oxtxDz25Hx1zKR3Clzg1BXk8t
         vwd4DWYt7Mgx33pLCe+xU2+VOAfG3j+2LSxMgTuXOXvLVvsG66yb9zf7mc0BF/t5o1C/
         tYQTOAxAnfv/pJuOHhsWoVMhaBfJmoKeDGz36/e4dw+LuaLaaTff/MOU9Jne7L/UJbQt
         y8u9hYiOHTRbidyBwfPdk2AnumOkAVBFkMbqQB1VogqWL6AtRgUhYxmW/VU0SCGYhUad
         4BqIjTSGGWuxRAvXngbYdJChD0qdsmT4eMvga29LWS1R5ePUh2Hx3EnjJ8ARn8Uf1zxg
         +YIw==
X-Gm-Message-State: AJIora9Z/pkbwBm+OfeXDNn5gIBt/zLqD8YjtqPAgCn+SNItKmlTe4ZM
        jogx5o7MGZG9dFgIauOX1EjMbwyuICMKKBgguJN/8A==
X-Google-Smtp-Source: AGRyM1vUCsuZmHMc5xW1I9rctk1g7DAhH7nYwPSylj9azya/RnKwLQLnCSlUCsYsF2F6h7UAtirPuEGm9aMBRhwBBmA=
X-Received: by 2002:a05:6a00:2395:b0:525:8980:5dc7 with SMTP id
 f21-20020a056a00239500b0052589805dc7mr16410526pfc.8.1656601156814; Thu, 30
 Jun 2022 07:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <xm26fsjotqda.fsf@google.com> <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
 <CALvZod5KX7XEHR9h_jFHf5pJcYB+dODEeaLKrQLtSy9EUqgvWw@mail.gmail.com> <20220629192435.df27c0dbb07ef72165e1de5e@linux-foundation.org>
In-Reply-To: <20220629192435.df27c0dbb07ef72165e1de5e@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Jun 2022 07:59:05 -0700
Message-ID: <CALvZod5hJ8VJ4E9jhqjCKc8au8_b-h_q+g=2pbQVUSBvappE6g@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH] epoll: autoremove wakers even more aggressively
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Khazhismel Kumykov <khazhy@google.com>, Heiher <r@hev.cc>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 7:24 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 29 Jun 2022 18:12:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > On Wed, Jun 29, 2022 at 4:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 15 Jun 2022 14:24:23 -0700 Benjamin Segall <bsegall@google.com> wrote:
> > >
> > > > If a process is killed or otherwise exits while having active network
> > > > connections and many threads waiting on epoll_wait, the threads will all
> > > > be woken immediately, but not removed from ep->wq. Then when network
> > > > traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
> > > > will not remove the entries from the list.
> > > >
> > > > This means that the cost of the wakeup attempt is far higher than usual,
> > > > does not decrease, and this also competes with the dying threads trying
> > > > to actually make progress and remove themselves from the wq.
> > > >
> > > > Handle this by removing visited epoll wq entries unconditionally, rather
> > > > than only when the wakeup succeeds - the structure of ep_poll means that
> > > > the only potential loss is the timed_out->eavail heuristic, which now
> > > > can race and result in a redundant ep_send_events attempt. (But only
> > > > when incoming data and a timeout actually race, not on every timeout)
> > > >
> > >
> > > Thanks.  I added people from 412895f03cbf96 ("epoll: atomically remove
> > > wait entry on wake up") to cc.  Hopefully someone there can help review
> > > and maybe test this.
> > >
> > >
> >
> > Thanks Andrew. Just wanted to add that we are seeing this issue in
> > production with real workloads and it has caused hard lockups.
> > Particularly network heavy workloads with a lot of threads in
> > epoll_wait() can easily trigger this issue if they get killed
> > (oom-killed in our case).
>
> Hard lockups are undesirable.  Is a cc:stable justified here?

Not for now as I don't know if we can blame a patch which might be the
source of this behavior.
