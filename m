Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88003743207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 02:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjF3A7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 20:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF3A7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:59:21 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D22D4E
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 17:59:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c413d8224e3so162768276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 17:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688086759; x=1690678759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fMmXmW0bN/OZjvRrmhsMCE2AbjOlvmuvYsM+l0kwu0=;
        b=5Yi2t8UJnMuttj4mjP+RoihhUwYozeForLZddQeb2UGwZ4aZLqwDAnBkQ2O5n2B0Zv
         61TlwP3Z99zgdWvNHZyETBcOeT3SyQ6kCVyYsQbM00SL9PlT3Q2S5o+662/8pAw6idgc
         pWHhWwpTqsq8yIFzvMFy2UGDaFtfMn5QkoirnFaZNY6y/qm2vEHHadkn87oEW7p/MPlb
         6YmCwGN6A3n7BFHzxQQBbfm4olW/PoxEvACOAoRsizcycVGGKB6B1iDCla//58lwQf6z
         2+r6N6E1D8AVAuDMne+dEPeEnp26bFTvdgLcs4zKTS7hwRGkHzSEfrzwrBMzZoryhxPi
         X3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688086759; x=1690678759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fMmXmW0bN/OZjvRrmhsMCE2AbjOlvmuvYsM+l0kwu0=;
        b=Jvqh9Y+i02yrt9mODAk0EJf13F8/3YSsKcpuXvzwUXVs91uOodJTdP9UYsMQALkGxC
         gG20mMPCUTMN76b8kjjxTEa0Yfqce+vz6B1YqULp83rT1BQDsE3INfe37oxLmfjqzL53
         m2MjBrrMWSv/mwDUa5vlKCL0WEP3ZAR1KX9Mo2EBUfyMzljrhWz1SZUBxgkX9Bb2APkh
         HeUlsUcm4aLYh/ojmOwyJ2wtxkbs5DY5U3bDqCFBuFJadf5A6O8O28rilkH3Wg5+lYlQ
         lFINsBeopXUlMpEbmVvfyVYJ1PriBniJEuhAQVhkGnibkJmnJ6+MY0/Hb+W5lHIiJCBw
         k4Rw==
X-Gm-Message-State: ABy/qLZAqFRAcylCbUzlCxNVfVFGM/hOBq2fjphvtoFt+87/2vfGdo2N
        RbGpRsym3kZ9zghFg3/F0uiKXq7mbeXVZ7+4LA8s2g==
X-Google-Smtp-Source: APBJJlHxFBTsy1RIaDeoVbwUC3Ent+H7k2ftXq+l1oZLf/rgt8ocXK1cc9rGO7XOaIKbAEai1RmczmVdeul/5BawYDg=
X-Received: by 2002:a25:9e87:0:b0:bcc:571d:a300 with SMTP id
 p7-20020a259e87000000b00bcc571da300mr1221336ybq.20.1688086759059; Thu, 29 Jun
 2023 17:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner> <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner> <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner> <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
 <2023062845-stabilize-boogieman-1925@gregkh> <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
 <ZJyZWtK4nihRkTME@slm.duckdns.org> <CAJuCfpFKjhmti8k6OHoDHAu6dPvqP0jn8FFdSDPqmRfH97bkiQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFKjhmti8k6OHoDHAu6dPvqP0jn8FFdSDPqmRfH97bkiQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Jun 2023 17:59:07 -0700
Message-ID: <CAJuCfpH3JcwADEYPBhzUcunj0dcgYNRo+0sODocdhbuXQsbsUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 28, 2023 at 2:50=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jun 28, 2023 at 1:34=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello, Suren.
> >
> > On Wed, Jun 28, 2023 at 01:12:23PM -0700, Suren Baghdasaryan wrote:
> > > AFAIU all other files that handle polling rely on f_op->release()
> > > being called after all the users are gone, therefore they can safely
> > > free their resources. However kernfs can call ->release() while there
> > > are still active users of the file. I can't use that operation for
> > > resource cleanup therefore I was suggesting to add a new operation
> > > which would be called only after the last fput() and would guarantee
> > > no users. Again, I'm not an expert in this, so there might be a bette=
r
> > > way to handle it. Please advise.
> >
> > So, w/ kernfs, the right thing to do is making sure that whatever is ex=
posed
> > to the kernfs user is terminated on removal - ie. after kernfs_ops->rel=
ease
> > is called, the ops table should be considered dead and there shouldn't =
be
> > anything left to clean up from the kernfs user side. You can add abstra=
ction
> > kernfs so that kernfs can terminate the calls coming down from the high=
er
> > layers on its own. That's how every other operation is handled and what
> > should happen with the psi polling too.
>
> I'm not sure I understand. The waitqueue head we are freeing in
> ->release() can be accessed asynchronously and does not require any
> kernfs_op call. Here is a recap of that race:
>
>                                                 do_select
>                                                       vfs_poll
> cgroup_pressure_release
>     psi_trigger_destroy
>         wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
>         synchronize_rcu()
>         kfree(t) -> frees waitqueue head
>                                                      poll_freewait() -> U=
AF
>
> Note that poll_freewait() is not part of any kernel_op, so I'm not
> sure how adding an abstraction kernfs would help, but again, this is
> new territory for me and I might be missing something.
>
> On a different note, I think there might be an easy way to fix this.
> What if psi triggers reuse kernfs_open_node->poll waitqueue head?
> Since we are overriding the ->poll() method, that waitqueue head is
> unused AFAIKT. And best of all, its lifecycle is tied to the file's
> lifecycle, so it does not have the issue that trigger waitqueue head
> has. In the trigger I could simply store a pointer to that waitqueue
> and use it. Then in ->release() freeing trigger would not affect the
> waitqueue at all. Does that sound sane?

I think this approach is much cleaner and I'm guessing that's in line
with what Tejun was describing (maybe it's exactly what he was telling
me but it took time for me to get it). Posted the patch implementing
this approach here:
https://lore.kernel.org/all/20230630005612.1014540-1-surenb@google.com/

>
>
> >
> > Thanks.
> >
> > --
> > tejun
