Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2825B5A20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiILMaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILM37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:29:59 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9ACDF46
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 05:29:58 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m66so8769040vsm.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FbHuYn2yHZD4P39GIhq59lzSsQnk4xcftgHYa5tQ00Q=;
        b=COhohJKwz9eBBBEW5kUCh57o5v9KhaabBMVaUuUHhAT0DM9pBwXRCKybFA+9anM0YY
         tq/lLawXQnV8UDA2XgVHjADIZMyqV8Hs+lwcX/zN7jOHEkSltsBiGNUHk4y8mNfhqNbX
         wbuLV3sfaBwa2WcM7ybPjQeCDlGdHVN5v2VDu8dJTK3bED7/b796BGxSERz/sYRU94TR
         eK0SUvk4seghBc7xC/LFvI/4ltEJm0FcCWKprcv5HH+7oaQwvtZsImEiptmN2taO7V6T
         kvH5B0nf1bUkOkJwYGJ+m4nAYjzLqfKRe61ZupZAjVKy2P8GqdOWmPkDu+lMOkhJJ+Qc
         5dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FbHuYn2yHZD4P39GIhq59lzSsQnk4xcftgHYa5tQ00Q=;
        b=gPH01XK4D11l7VtwM0jnkmO26sNoJYDC2yuAPOD9J5JwIwd54ySRrRZjIm8CqtTuAv
         Dv+eqyfkYXe2pqbEvZaDIapqhXJ5S6pytQ2t1rjWsNcH4kL/fJfRqh2WHztFt2wKovZt
         HudrESS1aY3T7zYnRsdUfK2EhRl13c9gTB/e+4zeamAvWpYp4DeyT0yvJxKUo26JsfES
         loMXUYg5+N/JBo4pvAWTafM3VDL7AoKYMULliAytHtoXFVNCyQo/a1veT9HCaR4Ljeki
         9SeG27M8oVxFId3McJ4x68Mz1JT0+b1pDyAKuqUKHpQRmF/q4rHD0dXVbv1l1HEp36BL
         9HFA==
X-Gm-Message-State: ACgBeo1WyaluLlFQ9UY+iJR864aOCvPBJmhbLpDY2CZjeGwnUFePM3e2
        396KD3iM0v5GcxRSBv3S80SunMCtHl+QkcYw62o=
X-Google-Smtp-Source: AA6agR69s5ybbwgtBCSvxwT/zGZrU9mm97LGmnznMFskQ+0obLw8a8PxxulUrnQoBz5WLEWAGo/rSeR1T06lmdahcAU=
X-Received: by 2002:a67:a243:0:b0:398:a30e:1566 with SMTP id
 t3-20020a67a243000000b00398a30e1566mr314047vsh.2.1662985797646; Mon, 12 Sep
 2022 05:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com> <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
In-Reply-To: <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 15:29:46 +0300
Message-ID: <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sat, 10 Sept 2022 at 10:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I think we should accept the fact that just as any current FUSE
> > passthrough (in userspace) implementation is limited to max number of
> > open files as the server's process limitation, kernel passthrough implementation
> > will be limited by inheriting the mounter's process limitation.
> >
> > There is no reason that the server should need to keep more
> > passthrough fd's open than client open fds.
>
> Maybe you're right.
>
> > If we only support FOPEN_PASSTHROUGH_AUTOCLOSE as v12
> > patches implicitly do, then the memory overhead is not much different
> > than the extra overlayfs pseudo realfiles.
>
> How exactly would this work?
>
> ioctl(F_D_I_P_OPEN) - create passthrough fd with ref 1
> open/FOPEN_PASSTHOUGH -  inc refcount in passthrough fd
> release - put refcount in passthrough fd
> ioctl(F_D_I_P_CLOSE) - put ref in passthrough fd
>
> Due to being refcounted the F_D_I_P_CLOSE can come at any point past
> the finished open request.
>
> Or did you have something else in mind?
>

What I had in mind is that FOPEN_PASSTHROUGH_AUTOCLOSE
"transfers" the server's refcount to the kernel and server does
not need to call explicit F_D_I_P_CLOSE.

This is useful for servers that don't care about reusing mappings.

> > > One other question that's nagging me is how to "unhide" these pseudo-fds.
> > >
> > > Could we create a kernel thread for each fuse sb which has normal
> > > file-table for these?  This would would allow inspecting state through
> > > /proc/$KTHREDID/fd, etc..
> > >
> >
> > Yeah that sounds like a good idea.
> > As I mentioned elsewhere in the thread, io_uring also has a mechanism
> > to register open files with the kernel to perform IO on them later.
> > I assume those files are also visible via some /proc/$KTHREDID/fd,
> > but I'll need to check.
> >
> > BTW, I see that the Android team is presenting eBPF-FUSE on LPC
> > coming Tuesday [1].
>
> At first glance it looks like a filtered kernel-only passthrough +
> fuse fallback, where filtering is provided by eBPF scripts and only
> falls back to userspace access on more complex cases.  Maybe it's a
> good direction, we'll see.

Yeh, we'll see.

> Apparently the passthrough case is
> important enough for various use cases.
>

Indeed.
My use case is HSM and I think that using FUSE for HSM is becoming
more and more common these days.

One of the things that bothers me is that both this FUSE_PASSTHROUGH
patch set and any future eBPF-FUSE passthrough implementation is
bound to duplicate a lot of code and know how from overlayfs
(along with the bugs).

We could try to factor out some common bits to a kernel fs passthough
library.

Anotehr options to consider is not to add any passthrough logic
to FUSE at all.

Instead, implement a "switch" fs to choose between passthrough
to one of several underlying fs "branches", where one of the branches
could be local fs and another a FUSE fs (i.e. for the complex cases).

A similar design was described at:
https://github.com/github/libprojfs/blob/master/docs/design.md#phase-2--hybrid

This "switch" fs is not that much different from overlayfs, when
removing the "merge dir" logic and replacing the "is_upper" logic
with a generic eBPF "choose_branch" logic.

Food for thought.

Thanks,
Amir.
