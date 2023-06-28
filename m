Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E0741B23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjF1VvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1VvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:51:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6FE1FF7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 14:51:13 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bd729434fa0so14361276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687989073; x=1690581073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiU1ba44MUUFQMwv4R2LW1J18iVFXpq0u3lKLnpz3Xc=;
        b=yGSq9469ZtBk1ZalIinO4oHCn6+fl9Mioak3I3ItprNlBB2i5CG8SW2uaDJYBJ82CF
         peruRSwPdWE3ulMVZphVZF6Td9mBMDF2emMRSAaDIr4OkPG0hzUxwu759Prh9CPgykAx
         XRFojr8qVtzUt0+3h9YqMTuRkgvFqqhNGoo7jyIUzTMo9Fv/tcwxK7Pf509o/7+YAM/1
         tKV74JfZJ9/F1aCnWQNLG0fLkTUQjrmSCb3EA6ygUrlLtha+2T5pHZRJYeNdWPu6mZye
         XjSaajeSL6VnNlsmoOo7Wm/driYwl+iqhGitf5wrv0LKJ3PsUo+PeXq0IYSVgg2GDAX8
         73Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989073; x=1690581073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiU1ba44MUUFQMwv4R2LW1J18iVFXpq0u3lKLnpz3Xc=;
        b=l+G1baFVGtYgcchwPE2Lj81G2u8iMNdzri4tIJmwiu1fnOEg/WYZpmHhDIoJymjGwS
         0X10LT9XEgRQxyzc8B8h98af8hXPikuTXnqU2nOV/tng+y77IBQGSyjzQI/FKyifiN6c
         bWTesoPQdzwETCV4a/ziSlMZPWGsXdmo6m0lIGVE+TPWlxgNvQelp22Vrce3Q0cCUwRH
         S6glyPTWOtQDKrfJ7JphYW7dWwTB4BwYkD/9mfgCJBEATMKCizPYV2QkZz1hAwA+OOw3
         wGl7I336uzs9r0etPqdcoWZ5dvNpqn72xs3cDY7fExKmQGUGPrYL0F3khESp/i8tvAzv
         Wo3w==
X-Gm-Message-State: AC+VfDyUxpVPLhBLLRGhv4Cb/X3sthrjapobj7NQwgYdXv8w2hpqAaaE
        5gqo4l0Gi6NxpjezDnIIK962kDNEBd2/YLItbvkVyg==
X-Google-Smtp-Source: ACHHUZ4cfXqbxLsUUem2cXUx8pH1XWjLr/u24Cm/eF5T/Yf+mADUuiGnm9aQFd2GhQSDjAHdcUKVPpC+nw4V4ifPuqc=
X-Received: by 2002:a25:6b50:0:b0:b9e:6fd1:4350 with SMTP id
 o16-20020a256b50000000b00b9e6fd14350mr35804952ybm.17.1687989072841; Wed, 28
 Jun 2023 14:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner> <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner> <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner> <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
 <2023062845-stabilize-boogieman-1925@gregkh> <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
 <ZJyZWtK4nihRkTME@slm.duckdns.org>
In-Reply-To: <ZJyZWtK4nihRkTME@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 14:50:59 -0700
Message-ID: <CAJuCfpFKjhmti8k6OHoDHAu6dPvqP0jn8FFdSDPqmRfH97bkiQ@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 1:34=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Suren.
>
> On Wed, Jun 28, 2023 at 01:12:23PM -0700, Suren Baghdasaryan wrote:
> > AFAIU all other files that handle polling rely on f_op->release()
> > being called after all the users are gone, therefore they can safely
> > free their resources. However kernfs can call ->release() while there
> > are still active users of the file. I can't use that operation for
> > resource cleanup therefore I was suggesting to add a new operation
> > which would be called only after the last fput() and would guarantee
> > no users. Again, I'm not an expert in this, so there might be a better
> > way to handle it. Please advise.
>
> So, w/ kernfs, the right thing to do is making sure that whatever is expo=
sed
> to the kernfs user is terminated on removal - ie. after kernfs_ops->relea=
se
> is called, the ops table should be considered dead and there shouldn't be
> anything left to clean up from the kernfs user side. You can add abstract=
ion
> kernfs so that kernfs can terminate the calls coming down from the higher
> layers on its own. That's how every other operation is handled and what
> should happen with the psi polling too.

I'm not sure I understand. The waitqueue head we are freeing in
->release() can be accessed asynchronously and does not require any
kernfs_op call. Here is a recap of that race:

                                                do_select
                                                      vfs_poll
cgroup_pressure_release
    psi_trigger_destroy
        wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
        synchronize_rcu()
        kfree(t) -> frees waitqueue head
                                                     poll_freewait() -> UAF

Note that poll_freewait() is not part of any kernel_op, so I'm not
sure how adding an abstraction kernfs would help, but again, this is
new territory for me and I might be missing something.

On a different note, I think there might be an easy way to fix this.
What if psi triggers reuse kernfs_open_node->poll waitqueue head?
Since we are overriding the ->poll() method, that waitqueue head is
unused AFAIKT. And best of all, its lifecycle is tied to the file's
lifecycle, so it does not have the issue that trigger waitqueue head
has. In the trigger I could simply store a pointer to that waitqueue
and use it. Then in ->release() freeing trigger would not affect the
waitqueue at all. Does that sound sane?


>
> Thanks.
>
> --
> tejun
