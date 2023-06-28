Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64E740A1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjF1H6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjF1Hzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:55:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8430EE
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 00:55:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7659924cd9bso370184585a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687938910; x=1690530910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHEtQ2wJjmvauaUesNJbaTs9laDotb9BZAcf/mJEhKc=;
        b=B0xZwq+ES1wDrmiBK/m9JIrklY2l9dJZ1vXsjiTr7cfMeMGD6Xc2U1BgRHY732FQW6
         AbDkI1I1k7hLvdtStJkfnyfJI8J44VNVJi6uWdrOD0si0B4hy0DF/w+I0TYw7hxm1iaX
         IrN20z43+vzIJ11ZMZ2+dhcnT6wO8ps6lSnG4Ki1hKSqBlJ7H1ILMggU+LAalfsK6GQs
         Fb3r8m7sGBUb9OFZkro9b1+GA/vWHRtmQNQD46xlw9Ns9vncaiwfMOzoH1IGmzIydPki
         N8gUB1pfL4/8j4bSO6NgzVPUGaqkIqDXWRCcXhobnlwl64+u+8/sDGQHjXswEzMF9oga
         nzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938910; x=1690530910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHEtQ2wJjmvauaUesNJbaTs9laDotb9BZAcf/mJEhKc=;
        b=W6B1HJULxqdCqgsvzSGXADaMHFrUS/0XrzHBRtuigr4gI/OTc7LshDA4eePA0M2vqp
         uJc4PYrT9M6Jk2MpBAWn1gS9RRlBgtwYs1lYuzZ52zP/uoxawc3qkNzI8UAxODi7w6qj
         tFZA9fPnN4VE+BTDmmLD8k2uH3f1q0wQlVsLbGl5ZvrWEzzKr8HPSXATSfaB70nartCl
         x0+xXp06Hys80UnRWvgPplkIAeEOUYiA8nYhjwzL/ISoAEdPQjIgF4rqU3lrkWO3kQen
         uAVmcJXNFVOQb3/8yYNk2k0EKRTaG0ueSyenE8lHHuWQC9idyQloleXR+7fMJcmGssHt
         sE3g==
X-Gm-Message-State: AC+VfDzy7k2ggrtoLy204YezxP+9DNDoePbSeRRwzDble1WHrAl+BIWN
        wFfesvorydwjguHMi048w0w/U1k4CDZALhu4NK7yA7I61cwRit7PviU4xQ==
X-Google-Smtp-Source: ACHHUZ7oPxWxgKTjkcD/pMkzXjHroPoc0154QI5Hv1NcAZMIvWKxBZmhFgad6ttNvypRyPckzF2PABKURWpyjMsi0Xw=
X-Received: by 2002:a5b:4c:0:b0:c17:afbd:71a9 with SMTP id e12-20020a5b004c000000b00c17afbd71a9mr8721564ybp.25.1687938415193;
 Wed, 28 Jun 2023 00:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZJn1tQDgfmcE7mNG@slm.duckdns.org> <20230627-kanon-hievt-bfdb583ddaa6@brauner>
 <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner> <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org> <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner>
In-Reply-To: <20230628-meisennest-redlich-c09e79fde7f7@brauner>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 00:46:43 -0700
Message-ID: <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 12:26=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Jun 27, 2023 at 08:09:46PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 27, 2023 at 6:54=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > Hello,
> > >
> > > On Tue, Jun 27, 2023 at 02:58:08PM -0700, Suren Baghdasaryan wrote:
> > > > Ok in kernfs_generic_poll() we are using kernfs_open_node.poll
> > > > waitqueue head for polling and kernfs_open_node is freed from insid=
e
> > > > kernfs_unlink_open_file() which is called from kernfs_fop_release()=
.
> > > > So, it is destroyed only when the last fput() is done, unlike the
> > > > ops->release() operation which we are using for destroying PSI
> > > > trigger's waitqueue. So, it seems we still need an operation which
> > > > would indicate that the file is truly going away.
> > >
> > > If we want to stay consistent with how kernfs behaves w.r.t. severing=
, the
> > > right thing to do would be preventing any future polling at severing =
and
> > > waking up everyone currently waiting, which sounds fine from cgroup b=
ehavior
> > > POV too.
> >
> > That's actually what we are currently doing for PSI triggers.
> > ->release() is handled by cgroup_pressure_release() which signals the
> > waiters, waits for RCU grace period to pass (per
> > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L25=
8)
> > and then releases all the trigger resources including the waitqueue
> > head. However as reported in
> > https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.co=
m
> > this does not save us from the synchronous polling case:
> >
> >                                                   do_select
> >                                                       vfs_poll
> > cgroup_pressure_release
> >     psi_trigger_destroy
> >         wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
> >         synchronize_rcu()
> >         kfree(t) -> frees waitqueue head
> >                                                      poll_freewait()
> > -> uses waitqueue head
> >
> >
> > This happens because we release the resources associated with the file
> > while there are still file users (the file's refcount is non-zero).
> > And that happens because kernfs can call ->release() before the last
> > fput().
> >
> > >
> > > Now, the challenge is designing an interface which is difficult to ma=
ke
> > > mistake with. IOW, it'd be great if kernfs wraps poll call so that se=
vering
> > > is implemented without kernfs users doing anything, or at least make =
it
> > > pretty obvious what the correct usage pattern is.
> > >
> > > > Christian's suggestion to rename current ops->release() operation i=
nto
> > > > ops->drain() (or ops->flush() per Matthew's request) and introduce =
a
> > > > "new" ops->release() which is called only when the last fput() is d=
one
> > > > seems sane to me. Would everyone be happy with that approach?
> > >
> > > I'm not sure I'd go there. The contract is that once ->release() is c=
alled,
> > > the code backing that file can go away (e.g. rmmod'd). It really shou=
ld
> > > behave just like the last put from kernfs users' POV.
> >
> > I 100% agree with the above statement.
> >
> > > For this specific fix,
> > > it's safe because we know the ops is always built into the kernel and=
 won't
> > > go away but it'd be really bad if the interface says "this is a norma=
l thing
> > > to do". We'd be calling into rmmod'd text pages in no time.
> > >
> > > So, I mean, even for temporary fix, we have to make it abundantly cle=
ar that
> > > this is not for usual usage and can only be used if the code backing =
the ops
> > > is built into the kernel and so on.
> >
> > I think the root cause of this problem is that ->release() in kernfs
> > does not adhere to the common rule that ->release() is called only
> > when the file is going away and has no users left. Am I wrong?
>
> So imho, ultimately this all comes down to rmdir() having special
> semantics in kernfs. On any regular filesystem an rmdir() on a directory
> which is still referenced by a struct file doesn't trigger an
> f_op->release() operation. It's just that directory is unlinked and
> you get some sort of errno like ENOENT when you try to create new files
> in there or whatever. The actual f_op->release) however is triggered
> on last fput().
>
> But in essence, kernfs treats an rmdir() operation as being equivalent
> to a final fput() such that it somehow magically kills all file
> references. And that's just wrong and not supported.

Thanks for the explanation, Christian!
If kernfs is special and needs different rules for calling
f_op->release() then fine, but I need an operation which tells me
there are no users of the file so that I can free the resources.
What's the best way to do that?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
