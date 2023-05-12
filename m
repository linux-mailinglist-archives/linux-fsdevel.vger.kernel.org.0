Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC752700F59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbjELTiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbjELTiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 15:38:02 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7946EBF
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 12:38:00 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-434834245c3so3054034137.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920279; x=1686512279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neEwfvVsPOUWYzBEFFOjFTtscUS7umnZ7KJE32d6STQ=;
        b=BmfcA40xLKinKwDjn4QGJ3u4urZBu1n+ljB2UvxoVDFkpqVUkFehoMz2bK555rUkGU
         V3Vky8ry6BgwznjUytxKKD2vIg7W2gtDPYwQSIy/59HY8O+HyJLsA5FJnLeUbE25XV5x
         w6/dx1N29EzKM7IFQtVMXskYUquZiYJ6lzhV6VrKJGzsEsBmVwYiSHauh7pOFo+Ry2VY
         KjCCX7NCa4rf00eXuu+wtFeELX9irn//75fGd8QlOpKA5Gi6J2AbZGfmqtlI3EGoD2X3
         Ch1ADvklzzGtJnCaBIUPzwKqVJvu2gXkOYFvt1wFkPaTYZW94BQEkrgNaEAWPv7Ihez+
         HRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920279; x=1686512279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neEwfvVsPOUWYzBEFFOjFTtscUS7umnZ7KJE32d6STQ=;
        b=EkBh471vfvB+qws82MjbgG1vl2fNUN6IjJclPJj8kI1VnHC6UftPoHMiPGgs4t/wxj
         sbBHNDeAfBofPzK05Yg2fggRCtb5QB6d1ftthLTbUCq6t3rl4/+MKpgciuieOgPTgCOn
         j7RfxEVJaWEbP2mDMreMq7e/cIKW75m+aB3n+Db+HYKXIAuWFjNkzw8Kjrud8xSaM1t6
         GXKc18Jq3mxUqJj78ZzxyBqjk60R1vDfQIFV36siIxDKL6NCo1dOkaNONkzDVyrOLjj1
         HDMDcwMA/ZUiHdLeYtkBCff50XASxbDKcgutNNEM1nOG/mvA/OQA0LMEK9ePQKxLP3BV
         dmrg==
X-Gm-Message-State: AC+VfDwuELGkm70vLiRC34KYK90VQ0F6IFdBFKcLopzbSfLjzD/nStmx
        3pNE0JUVK9OZxwvNh6oDDhqU6vamo6Cmxu4jeGQ=
X-Google-Smtp-Source: ACHHUZ5mkDcmG+mrA+zE5A/42mHIOgSa0jSbGndY9mE1QhvJfhOF7VAe8EgoFpktk0V3uSYo/moFkVZbHGhRURlfOWg=
X-Received: by 2002:a67:e205:0:b0:434:5831:f89e with SMTP id
 g5-20020a67e205000000b004345831f89emr11165802vsa.6.1683920279122; Fri, 12 May
 2023 12:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com> <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 May 2023 15:37:47 -0400
Message-ID: <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Mon, Sep 12, 2022 at 8:29=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Sep 12, 2022 at 12:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote=
:
> >
> > On Sat, 10 Sept 2022 at 10:52, Amir Goldstein <amir73il@gmail.com> wrot=
e:
> >
> > > I think we should accept the fact that just as any current FUSE
> > > passthrough (in userspace) implementation is limited to max number of
> > > open files as the server's process limitation, kernel passthrough imp=
lementation
> > > will be limited by inheriting the mounter's process limitation.
> > >
> > > There is no reason that the server should need to keep more
> > > passthrough fd's open than client open fds.
> >
> > Maybe you're right.
> >
> > > If we only support FOPEN_PASSTHROUGH_AUTOCLOSE as v12
> > > patches implicitly do, then the memory overhead is not much different
> > > than the extra overlayfs pseudo realfiles.
> >
> > How exactly would this work?
> >
> > ioctl(F_D_I_P_OPEN) - create passthrough fd with ref 1
> > open/FOPEN_PASSTHOUGH -  inc refcount in passthrough fd
> > release - put refcount in passthrough fd
> > ioctl(F_D_I_P_CLOSE) - put ref in passthrough fd
> >
> > Due to being refcounted the F_D_I_P_CLOSE can come at any point past
> > the finished open request.
> >
> > Or did you have something else in mind?
> >
>
> What I had in mind is that FOPEN_PASSTHROUGH_AUTOCLOSE
> "transfers" the server's refcount to the kernel and server does
> not need to call explicit F_D_I_P_CLOSE.
>
> This is useful for servers that don't care about reusing mappings.
>

Hi Daniel,

I was waiting for LSFMM to see if and how FUSE-BPF intends to
address the highest value use case of read/write passthrough.

From what I've seen, you are still taking a very broad approach of
all-or-nothing which still has a lot of core design issues to address,
while these old patches already address the most important use case
of read/write passthrough of fd without any of the core issues
(credentials, hidden fds).

As far as I can tell, this old implementation is mostly independent of your
lookup based approach - they share the low level read/write passthrough
functions but not much more than that, so merging them should not be
a blocker to your efforts in the longer run.
Please correct me if I am wrong.

As things stand, I intend to re-post these old patches with mandatory
FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
questions about managing mappings.

Miklos, please stop me if I missed something and if you do not
think that these two approaches are independent.

Thanks,
Amir.
