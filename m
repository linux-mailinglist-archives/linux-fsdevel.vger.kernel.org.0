Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7674165C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjF1Q2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjF1Q2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:28:18 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5642694
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:28:15 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-565a8d9d832so70951eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687969695; x=1690561695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk9Ma8PHjIe8nBHU9Tz+Dpnfhv6Qv1Z0Rq6xA0WYD24=;
        b=yHNTfrxGBFOW4I1D4j3xGL3prMRwB4VqrZd+oQbzt1v9GmVnxue/rRqQs9O5tG6Rma
         tqKm8ycmdeozHiG6UOV7DHESuhV0ulqz7wdASTj3Hk8K9J7Cxuf/s7+KCcwdYnveGcz3
         KkPuGlmOPY8D9qeejwYGmoGgpzJ1DckSn+hqQFBmPAqTRsotfF/xhT/JibQazLM26ylg
         16yF0gld2Z0BqJ1ojmeS4QVTWkmd3uktowgpuPeiNbjwTKZv+Oq7r1ECR62LcP2FGK5O
         Oy1YJ7VqlxQOiwsv7ocYP8d9jFYpUFWWpx2/BRm6kH9ISoLodtLpR8eqzqHhZ5AtFYQ7
         DTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969695; x=1690561695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk9Ma8PHjIe8nBHU9Tz+Dpnfhv6Qv1Z0Rq6xA0WYD24=;
        b=Sxiw5MFURxzeInGh7BxzGiFPie1MDGVjexzkhGxqnQXZwUaQ1hry09aMv+2GqDItMs
         WhBpLnb2zn+O3YNSCLb82gwobMZavF4idaL9VUv3wyU/RrnoaOAoza1AEnGVCtf4ZPkB
         QtJ5r34xYtqfvyb0DX6u6Gfd+CcmFw1qJN2IPPzombrLOeqAZkU0071NOC15uUwM2BhM
         53396exzrdzlqf+x95vRXvDpbOKEiQRVkhzmBtmf0eDkbWxLhtG/Fde5K8FHYcI0VVjh
         qzpJJe5fKX/9R4XxF7l2KqfPnczWkxpoIjQmsPOGkdEYy0NhSp5p9N4KNoyQE15aRRCU
         EtTQ==
X-Gm-Message-State: AC+VfDw5bH7VB8L8556RNINQCdVK81mc/X/N1TdIArIRsDOmzxn/eGP+
        OIY76gEzSpypY+3C2LD3YpNGvw5G3lPaAoZGNLItBw==
X-Google-Smtp-Source: ACHHUZ61g6c+cebt5a5+lx02xCBTokStJ/vLCBLj9Zw+15RF2IKA/aXFIPF2r3qi4pRqHE4phsdPYoyRCE3RXYseP4g=
X-Received: by 2002:a05:6358:f49:b0:131:94f:b4ff with SMTP id
 c9-20020a0563580f4900b00131094fb4ffmr17431955rwj.5.1687969694941; Wed, 28 Jun
 2023 09:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner> <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org> <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner> <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner>
In-Reply-To: <20230628-faden-qualvoll-6c33b570f54c@brauner>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 09:28:03 -0700
Message-ID: <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 1:41=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jun 28, 2023 at 12:46:43AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jun 28, 2023 at 12:26=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Tue, Jun 27, 2023 at 08:09:46PM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Jun 27, 2023 at 6:54=E2=80=AFPM Tejun Heo <tj@kernel.org> w=
rote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Tue, Jun 27, 2023 at 02:58:08PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > Ok in kernfs_generic_poll() we are using kernfs_open_node.poll
> > > > > > waitqueue head for polling and kernfs_open_node is freed from i=
nside
> > > > > > kernfs_unlink_open_file() which is called from kernfs_fop_relea=
se().
> > > > > > So, it is destroyed only when the last fput() is done, unlike t=
he
> > > > > > ops->release() operation which we are using for destroying PSI
> > > > > > trigger's waitqueue. So, it seems we still need an operation wh=
ich
> > > > > > would indicate that the file is truly going away.
> > > > >
> > > > > If we want to stay consistent with how kernfs behaves w.r.t. seve=
ring, the
> > > > > right thing to do would be preventing any future polling at sever=
ing and
> > > > > waking up everyone currently waiting, which sounds fine from cgro=
up behavior
> > > > > POV too.
> > > >
> > > > That's actually what we are currently doing for PSI triggers.
> > > > ->release() is handled by cgroup_pressure_release() which signals t=
he
> > > > waiters, waits for RCU grace period to pass (per
> > > > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h=
#L258)
> > > > and then releases all the trigger resources including the waitqueue
> > > > head. However as reported in
> > > > https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawe=
i.com
> > > > this does not save us from the synchronous polling case:
> > > >
> > > >                                                   do_select
> > > >                                                       vfs_poll
> > > > cgroup_pressure_release
> > > >     psi_trigger_destroy
> > > >         wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
> > > >         synchronize_rcu()
> > > >         kfree(t) -> frees waitqueue head
> > > >                                                      poll_freewait(=
)
> > > > -> uses waitqueue head
> > > >
> > > >
> > > > This happens because we release the resources associated with the f=
ile
> > > > while there are still file users (the file's refcount is non-zero).
> > > > And that happens because kernfs can call ->release() before the las=
t
> > > > fput().
> > > >
> > > > >
> > > > > Now, the challenge is designing an interface which is difficult t=
o make
> > > > > mistake with. IOW, it'd be great if kernfs wraps poll call so tha=
t severing
> > > > > is implemented without kernfs users doing anything, or at least m=
ake it
> > > > > pretty obvious what the correct usage pattern is.
> > > > >
> > > > > > Christian's suggestion to rename current ops->release() operati=
on into
> > > > > > ops->drain() (or ops->flush() per Matthew's request) and introd=
uce a
> > > > > > "new" ops->release() which is called only when the last fput() =
is done
> > > > > > seems sane to me. Would everyone be happy with that approach?
> > > > >
> > > > > I'm not sure I'd go there. The contract is that once ->release() =
is called,
> > > > > the code backing that file can go away (e.g. rmmod'd). It really =
should
> > > > > behave just like the last put from kernfs users' POV.
> > > >
> > > > I 100% agree with the above statement.
> > > >
> > > > > For this specific fix,
> > > > > it's safe because we know the ops is always built into the kernel=
 and won't
>
> I don't know if this talks about kernfs_ops (likely) or talks about
> f_ops but fyi for f_ops this isn't a problem. See fops_get() in
> do_dentry_open() which takes a reference on the mode that provides the
> fops. And debugfs - a little more elaborately - handles this as well.
>
> > > > > go away but it'd be really bad if the interface says "this is a n=
ormal thing
> > > > > to do". We'd be calling into rmmod'd text pages in no time.
> > > > >
> > > > > So, I mean, even for temporary fix, we have to make it abundantly=
 clear that
> > > > > this is not for usual usage and can only be used if the code back=
ing the ops
> > > > > is built into the kernel and so on.
> > > >
> > > > I think the root cause of this problem is that ->release() in kernf=
s
> > > > does not adhere to the common rule that ->release() is called only
> > > > when the file is going away and has no users left. Am I wrong?
> > >
> > > So imho, ultimately this all comes down to rmdir() having special
> > > semantics in kernfs. On any regular filesystem an rmdir() on a direct=
ory
> > > which is still referenced by a struct file doesn't trigger an
> > > f_op->release() operation. It's just that directory is unlinked and
> > > you get some sort of errno like ENOENT when you try to create new fil=
es
> > > in there or whatever. The actual f_op->release) however is triggered
> > > on last fput().
> > >
> > > But in essence, kernfs treats an rmdir() operation as being equivalen=
t
> > > to a final fput() such that it somehow magically kills all file
> > > references. And that's just wrong and not supported.
> >
> > Thanks for the explanation, Christian!
> > If kernfs is special and needs different rules for calling
> > f_op->release() then fine, but I need an operation which tells me
> > there are no users of the file so that I can free the resources.
> > What's the best way to do that?
>
> Imho, if there's still someone with an fd referencing that file then
> there's still a user. That's unlink() while holding an fd in a nutshell.
>
> But generically, afaui what you seem to want is:
>
> (1) a way to shutdown functionality provided by a kernfs node on removal
>     of that node
> (2) a way to release the resources of a kernfs node
>
> So (2) is seemingly what kernfs_ops->release() is about but it's also
> used for (1). So while I initially thought about ->drain() or whatever
> it seems what you really want is for struct kernfs_ops to gain an
> unlink()/remove()/rmdir() method(s). The method can be implemented by
> interested callers and should be called when the kernfs node is removed.
>
> And that's when you can shutdown any functionality without freeing the
> resources.
>
> Imho, if you add struct gimmegimme_ops with same names as f_op you
> really to mirror them as close as possible otherwise you're asking for
> problems.

Thanks for the feedback!
To summarize my understanding of your proposal, you suggest adding new
kernfs_ops for the case you marked (1) and change ->release() to do
only (2). Please correct me if I misunderstood. Greg, Tejun, WDYT?
