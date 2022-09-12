Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7535B5F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiILRn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiILRn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:43:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02929248E0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 10:43:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d17so5807692qko.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NSD0+JSzOE3DYBBxAr82WQYEcSQ20vzTRARmSqp6YXs=;
        b=H7pyzH97EuMblUkBg5yM4+BZPVeR2afcgzkssQGorj5G2E/zFrPJ+Z9hWGdZQqjQPQ
         bayRK49Jk/H9NNa/KfEdl4OQ5spUSGr6Wcum6phfK2DEqaa/auKMoJWj+Ndd57PZBDRm
         Zs/U44H3SoJVlJP4uSNLQv8p+OhFKfYzy3RBTIl9oaDxPhYOKDIhbFOJDOkgapcgXPHH
         vrf/P4JvNLzxDa4eYtjaMF0fXHAXHaEYUZn5GI+fBo+kWdi2+JSd4eVaJ8z60yN9mUmN
         h+qQYaL7+p5ANshhT8aIFSvW+ecMjq1+jaFoYom1Patn/nmzmIbP/XDmGh5V9a9KTayF
         JBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NSD0+JSzOE3DYBBxAr82WQYEcSQ20vzTRARmSqp6YXs=;
        b=77D+C1rDU+bgwpfRbVN8Xu+Q78PQEcPrS16BB/ocDnB2n8pEChkhDFHPdEBLEJztMl
         U0KQoVTi0m41yCGAxWHBKgRipDy99EKsdQtsabiMJaCma2dAnj09tz7oYXogd2r4o9/y
         FBK42A+GggYNuDFtZFcwZpl1fCbvF/4u2VebJMfPnJN6kL1b62KIL/RQsx/+kBRSTqff
         mObGtjnMHFMqfLloPQc/q2IacJgG0SzbT86Gps7mLNccKbNYeQdpe59kbo0NmpGMwRJ2
         UjettKP4JqdZEx8K1qZ2nFi62bTXQuvCG/VVKm/AI0dGOkzzox0bKJ7rO/VzY1GeXFIy
         VFnA==
X-Gm-Message-State: ACgBeo02Zjr3MVDwBObCbKpqDa0wFaFg6H/M2cWBTeV5o/VcbhdG3PMi
        FuvL+gL43mvX1xsLl9vy5dniSIYC3lXC5YxMXJw4Nw==
X-Google-Smtp-Source: AA6agR5Ilgzx6McpA8hpi7nsjUePbN9bJPcZQh56ymng8fvhj75zL6VsgqWznRv/sbONMxEb2BG61fX0nfVt7kOL3SE=
X-Received: by 2002:a37:91c3:0:b0:6bc:5322:d49e with SMTP id
 t186-20020a3791c3000000b006bc5322d49emr20108348qkd.583.1663004633005; Mon, 12
 Sep 2022 10:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
 <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
 <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com> <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 12 Sep 2022 10:43:42 -0700
Message-ID: <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>,
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

Sorry, resend, my response was bounced back by mail system due to not
using plain text.

On Mon, Sep 12, 2022 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 5:22 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 12 Sept 2022 at 15:26, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > FWIW duplicate page cache exists in passthough FUSE whether
> > > passthrough is in kernel or in userspace, but going through yet another
> > > "switch" fs would make things even worse.
> >
> > I imagine the "switch" layer for a HSM would be simple enough:
> >
> > a) if file exists on fastest layer (upper) then take that
> > b) if not then fall back to fuse layer (lower) .
> >
> > It's almost like a read-only overlayfs (no copy up) except it would be
> > read-write and copy-up/down would be performed by the server as
> > needed. No page cache duplication for upper, and AFAICS no corner
> > cases that overlayfs has, since all layers are consistent (the fuse
> > layer would reference the upper if that is currently the up-to-date
> > one).
>
> On recent LSF/MM/BPF, BPF developers asked me about using overlayfs
> for something that looks like the above - merging of non overlapping layers
> without any copy-up/down, but with write to lower.
>
> I gave them the same solution (overlayfs without copy-up)
> but I said I didn't know what you would think about this overlayfs mode
> and I also pointed them to the eBPF-FUSE developers as another
> possible solution to their use case.
>

Thanks Amir for adding me in the thread. This idea is very useful for
BPF use cases.

A bit more context here: we were thinking of overlaying two
filesystems together to create a view that extends the filesystem at
the lower layer. In our design, the lower layer is a pseudo
filesystem, which one can _not_ create/delete files, but make
directories _indirectly_, via creating a kernel object; the upper is
bpf filesystem, from which, one can create files. The file's purpose
is to describe the directory in the lower layer, that is, to describe
the kernel object that directory corresponds to.

With the flexibility brought by BPF, it can be a quite flexible
solution to query kernel objects' states.

>
> >
> > readdir would go to the layer which has the complete directory (which
> > I guess the lower one must always have, but the upper could also).
> >
> > I'm probably missing lots of details, though...
> >
>
> That's what I said too :)
>
> Does that mean that you are open to seeing patches for
> an overlayfs mode that does not copy-up on write to lower?
> I can come up with some semantics for readdir that will
> make sense.

I am excited about this. Thanks Amir!

>
> Thanks,
> Amir.
