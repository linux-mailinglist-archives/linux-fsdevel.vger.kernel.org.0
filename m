Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1B7240B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjFFLTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjFFLTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:19:30 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67364B1
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 04:19:29 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-786f7e1ea2fso1598808241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686050368; x=1688642368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egg+oVNc0RTwdbDGV6CuqrkQ8OAPiF2c24P5Mj/BV9g=;
        b=KUH0eZzBp/X60jDRR2maiFeycb9fKL/zKccIoQY1RgjYOmHBwxyI8Mjm5WOQ0KkO66
         Ij/jfJ0RXcJ9E9I3LKhkKyBjwt1sjGQcjPwq5AP+YCJIQGOmCuNwvBPbZf8aTvlslhqV
         NtxTFmxUx8KtUNm1sh8Dw/WxzLYQQECKdYpWSyl9vYgodPlzaWYOhyBl9ALRhA9tNQrD
         Xp6OeaZA+E8Q5XrvvxR/7jz2ikIzUVZNLjuPASS1Ttm4PhbNKDIe/u1AoIq9QFYIdKey
         tr0IktJ+WACtIH49OKagBoBTHp65w4lVs7kFflL10qGb58ZVUqOB8YCypeNg36Y+bkA6
         RkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686050368; x=1688642368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egg+oVNc0RTwdbDGV6CuqrkQ8OAPiF2c24P5Mj/BV9g=;
        b=VGFHu1mYg0SAJ5p/m2pVvf8uKYt8Ql/x3DXWqEqNcLJuzLlL2SKxUR+iPk8TLur/jf
         A/I5NRjmssRxV/QYLdhFrKOELEMzMOM3D31URI7H4APuAmmvSUwTut/7ZJl3MMtMd1+6
         CFsvZZ23o6AURBbxv/+8z+iJkCaJBPhcZ6zWeE1wb+rA6RErgJRedzx6EfoGG+fblzbv
         hWdViNbTXbJ+sh7g1QX065WZc7xzP3uawqkizz3FrVjNbzFv0/rht3LnjHFr65MVclS0
         giNbLA6lYAdoz7E2iwn2O5htgF9iXFybxl3EtZ9HpYGMZQglOHGSO+RMTjnusWpbSCTi
         kn4g==
X-Gm-Message-State: AC+VfDyIztxm5MgDjWpYwJQPavWZkFk3OMXMHxfXakZIwoKNLuVthvRB
        /NmHjWGFkn3HHpKqt7vCzIOnSeMpO70eEpgGofg=
X-Google-Smtp-Source: ACHHUZ55g62hq68ZryjfIKhUZrbnUdB2I1zzHUL+JDnxi01dsYi76cXbLJR+0QFDwiotKNVaP9+08gLrYjl5WlGQ8Fg=
X-Received: by 2002:a05:6102:52d:b0:43b:4a17:7fc2 with SMTP id
 m13-20020a056102052d00b0043b4a177fc2mr541388vsa.26.1686050368376; Tue, 06 Jun
 2023 04:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
In-Reply-To: <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Jun 2023 14:19:17 +0300
Message-ID: <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 6, 2023 at 12:49=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 6 Jun 2023 at 11:13, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, May 19, 2023 at 3:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > Miklos,
> > >
> > > This patch set addresses your review feedback on Alesio's V12 patch s=
et
> > > from 2021 [1] as well as other bugs that I have found since.
> > > This patch set uses refcounted backing files as we discussed recently=
 [2].
> > >
> > > I am posting this for several possible outcomes:
> > >
> > > 1. Either FUSE-BPF develpers can use this as a reference implementati=
on
> > >    for their 1st phase of "backing file passthrough"
> > > 2. Or they can tell me which API changes need to made to this patch s=
et
> > >    so the API is flexible enough to extend to "backing inode passthro=
ugh"
> > >    and to "BPF filters" later on
> > > 3. We find there is little overlap in the APIs and merge this as is
> > >
> > > These patches are available on github [3] along with libfuse patches =
[4].
> > > I tested them by running xfstests (./check -fuse -g quick.rw) with la=
test
> > > libfuse xfstest support.
> > >
> > > Without FOPEN_PASSTHROUGH, one test in this group fails (generic/451)
> > > which tests mixed buffered/aio writes.
> > > With FOPEN_PASSTHROUGH, this test also passes.
> > >
> > > This revision does not set any limitations on the number of backing f=
iles
> > > that can be mapped by the server.  I considered several ways to addre=
ss
> > > this and decided to try a different approach.
> > >
> > > Patch 10 (with matching libfuse patch) is an RFC patch for an alterna=
tive
> > > API approach. Please see my comments on that patch.
> > >
> >
> > Miklos,
> >
> > I wanted to set expectations w.r.t this patch set and the passthrough
> > feature development in general.
> >
> > So far I've seen comments from you up to path 5/10, so I assume you
> > did not get up to RFC patch 10/10.
> >
> > The comments about adding max stack depth to protocol and about
> > refactoring overlayfs common code are easy to do.
> >
> > However, I feel that there are still open core design questions that ne=
ed
> > to be spelled out, before we continue.
> >
> > Do you find the following acceptable for first implementation, or do yo=
u
> > think that those issues must be addressed before merging anything?
> >
> > 1. No lsof visibility of backing files (if server closes them)
> > 2. Derived backing files resource limit (cannot grow beyond nr of fuse =
files)
> > 3. No data consistency guaranty between different fd to the same inode
> >     (i.e. backing is per fd not per inode)
>
> I think the most important thing is to have the FUSE-BPF team onboard.

Yeh, I'd love to get some feedback from you guys.

>    I'm not sure that the per-file part of this is necessary, doing
> everything per-inode should be okay.   What are the benefits?
>

I agree that semantics are simpler with per-inode.
The only benefit I see to per-file is the lifetime of the mapping.

It is very easy IMO to program with a mapping scope of
open-to-close that is requested by FOPEN_PASSTHROUGH
and FOPEN_PASSTHROUGH_AUTO_CLOSE.

But I think the same lifetime can still be achieved with per-inode
mapping. I hand waved how I think that could be done in response
to patch 10/10 review.

I think if I can make this patch set work per-inode, the roadmap
from here to FUSE-BPF would be much more clear.

> Not having visibility and resource limits would be okay for a first
> version, as long as it's somehow constrained to privileged use.  But
> I'm not sure it would be worth it that way.
>

Speaking on behalf of my own use case for FUSE passthrough (HSM),
FUSE is used for "do something that does not belong in the kernel",
but running as unprivileged user is a non-requirement.
So I can say with confidence of paying customers that passthrough is
useful and essential even with privileged user constraint.

In summary, I will try to come up with v14 that is:
- privileged user only
- no resource limitation
- per-inode mapping

If at any time FUSE-BFP team would like to take this patch set
of my hands, or propose a replacement for it, I would be very happy
to step down - whatever it takes to land read/write passthrough.

Thanks,
Amir.
