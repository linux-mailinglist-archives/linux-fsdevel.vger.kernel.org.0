Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C339576B30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 03:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiGPB1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 21:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPB1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 21:27:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266B15A14
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jul 2022 18:27:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c8a5d51adso51213727b3.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jul 2022 18:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oNUmtpieKLTpKC9Phy1E+O2Qwr+LcgpjVlKPKz6ZsMY=;
        b=o3YYx9oRz4vs+i20GvTWtA2fo2ETFMeVSiAqrPAjMumbgk6QsUfn/L2857Y1U4kr91
         vklLL5DSuzEDM920bdCqKAMwVm4TZrdIbmt15k1jgJIHxfR2M3E7zYEP8JAC7UfjbOPP
         BUfsSW6TIpP5Zd+0767BBU6jYGQIuKTH6NuHwbuI8Ok0AGwudcmQcNEJKE0uPakdLJha
         BSQHl/QlbT7Tx2Gt4EzHMIkcAgxAelFpUjH17w/t9BXELeqSi0tBgNQP9F0wr/k6HFmy
         H0kpyAk/8g5j0lUBzM1Q5DdfBFyv+9bdMt4D3AGxguc5NSFR9q3njhxZLt3co38DKu8I
         5FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oNUmtpieKLTpKC9Phy1E+O2Qwr+LcgpjVlKPKz6ZsMY=;
        b=QOdu49x1ZKHJ1K6L55Q1sgznE0X1uA+vS19CXeKao35AMR9b6vzOtb+8OOTTT5LSFx
         EqzrWywzqB879Jp900+4zyAkKHS2LmonYq8OSzuoUCPRGak3WN/pjOgwmQJR6UdwlfcS
         JFArTguZIgUUYtz3iEqiKPxExDQLVaJtH+aUk8H/3OB8sxfz8oaYPD0gx4hT2l5F1jLm
         7li4/F/ZYBF2pcJUHI9Lz+YmWKiYo2CHV5f8xXpoDfnSKykmeB+/79id57rR1wSAW5pw
         thIIBZPIcIuDtVQlt6+fP8Z3gXChFvjlz/I1rmsMHigf2XfTbGGaiumGBKJTQO01mWtH
         /gaQ==
X-Gm-Message-State: AJIora+US/V6NSoBqnRr/2ShPaBXmKwb/FiM+nD6xAOGjzaHd5tESmgq
        u9YnIlqccy0LoKJmVeEywCaFYdaqKXjlOg==
X-Google-Smtp-Source: AGRyM1tgce6Og74FBQ8kWDBrQFEYIJs1vYjRR78miz5377H8QoZuC/el3NaKqVJGVtRTP4sANPPWTE2wuKnhCw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:e74d:0:b0:66e:5c8e:609 with SMTP id
 e74-20020a25e74d000000b0066e5c8e0609mr16394088ybh.585.1657934854024; Fri, 15
 Jul 2022 18:27:34 -0700 (PDT)
Date:   Sat, 16 Jul 2022 01:27:31 +0000
In-Reply-To: <CALvZod5hJ8VJ4E9jhqjCKc8au8_b-h_q+g=2pbQVUSBvappE6g@mail.gmail.com>
Message-Id: <20220716012731.2zz7hpg3qbhwgeqd@google.com>
Mime-Version: 1.0
References: <xm26fsjotqda.fsf@google.com> <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
 <CALvZod5KX7XEHR9h_jFHf5pJcYB+dODEeaLKrQLtSy9EUqgvWw@mail.gmail.com>
 <20220629192435.df27c0dbb07ef72165e1de5e@linux-foundation.org> <CALvZod5hJ8VJ4E9jhqjCKc8au8_b-h_q+g=2pbQVUSBvappE6g@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH] epoll: autoremove wakers even more aggressively
From:   Shakeel Butt <shakeelb@google.com>
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:59:05AM -0700, Shakeel Butt wrote:
> On Wed, Jun 29, 2022 at 7:24 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 29 Jun 2022 18:12:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Wed, Jun 29, 2022 at 4:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 15 Jun 2022 14:24:23 -0700 Benjamin Segall <bsegall@google.com> wrote:
> > > >
> > > > > If a process is killed or otherwise exits while having active network
> > > > > connections and many threads waiting on epoll_wait, the threads will all
> > > > > be woken immediately, but not removed from ep->wq. Then when network
> > > > > traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
> > > > > will not remove the entries from the list.
> > > > >
> > > > > This means that the cost of the wakeup attempt is far higher than usual,
> > > > > does not decrease, and this also competes with the dying threads trying
> > > > > to actually make progress and remove themselves from the wq.
> > > > >
> > > > > Handle this by removing visited epoll wq entries unconditionally, rather
> > > > > than only when the wakeup succeeds - the structure of ep_poll means that
> > > > > the only potential loss is the timed_out->eavail heuristic, which now
> > > > > can race and result in a redundant ep_send_events attempt. (But only
> > > > > when incoming data and a timeout actually race, not on every timeout)
> > > > >
> > > >
> > > > Thanks.  I added people from 412895f03cbf96 ("epoll: atomically remove
> > > > wait entry on wake up") to cc.  Hopefully someone there can help review
> > > > and maybe test this.
> > > >
> > > >
> > >
> > > Thanks Andrew. Just wanted to add that we are seeing this issue in
> > > production with real workloads and it has caused hard lockups.
> > > Particularly network heavy workloads with a lot of threads in
> > > epoll_wait() can easily trigger this issue if they get killed
> > > (oom-killed in our case).
> >
> > Hard lockups are undesirable.  Is a cc:stable justified here?
> 
> Not for now as I don't know if we can blame a patch which might be the
> source of this behavior.

I am able to repro the epoll hard lockup on next-20220715 with Ben's
patch reverted. The repro is a simple TCP server and tens of clients
communicating over loopback. Though to cause the hard lockup I have to
create a couple thousand threads in epoll_wait() in server and also
reduce the kernel.watchdog_thresh. With Ben's patch the repro does not
cause the hard lockup even with kernel.watchdog.thresh=1.

Please add:

Tested-by: Shakeel Butt <shakeelb@google.com>
