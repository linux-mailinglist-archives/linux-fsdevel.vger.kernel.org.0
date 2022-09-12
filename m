Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C95B5B1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiILN0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiILN0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:26:47 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173202F385
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:26:45 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id j7so3575912vsr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2K4qNeGlECmc0A5eAc5NwijHTd9Qquk2WwbzlWJgtm0=;
        b=aTFX2sgkmn9r9sTdhCEX6vfBqS+e8cOD+tl6+moMK9A8bf4Ygr8CeEcvJ0v+1ZV2aU
         T7g7z+RD/9Lb3m72hQJeR6326Z/2l01VErJSjq4ZEVl6TOI5CR6Q3tAuc30V9Yy/MkK/
         q/8nClLBhG9Pe/VSyg7bbDlWZG6lpCQeXO3f1sCff0C0G0/Sw6Sk7xk/BMC7p/IZ2U+V
         Z9RCqnfqGi6hkKPYwaEkbOSSWt84/zR0KHuKHBzTcYyI4wu/A3u6hxhadsQw1kNGpHuy
         SXkmrQPtqj5tvQ9TU9w52WsYZnwnQqzclAQ/bzxCvCF70tpqOAoyHMNcNTNfKLv0kf/u
         KKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2K4qNeGlECmc0A5eAc5NwijHTd9Qquk2WwbzlWJgtm0=;
        b=EGWZ/L57pWAGmH8djKxozFCCBWcQdb2j0vtOdPo2D1r10y9I+Ir/CChvzwKxNH41eb
         He0S6eViV1B14VPv5hKQvfrS2uX4JxxwYKkBoBmIF+SUGCRFv509CkG321Wldw12Oh+9
         t0968FOGghCfJLXv+TgIu5P3OpzlK5JCoYod+fNsoZPT3qriP4n4jeaUrtF1LdLeFKMb
         I8AxiW+bdtgNW5rA8abgQUW8hrZQEkoGwkMPZNSmi9L3e/FZlXr1TN9zmOfAhehbIxq5
         M0podg6c+NaS5GRJX1uiE+ZycVxPhm5Il/k9K5hPi3snOcaRZ+24BR8rqOKJ8NxeGCDP
         nAjg==
X-Gm-Message-State: ACgBeo0E8ueJTlSyVgbwQz+acBQuEgWzppJVi07X5lAsNGEO1ULX+SCP
        N9xAsxqhUbr7I/2FRmHcUaK+rR6EvpHzUrERRu8=
X-Google-Smtp-Source: AA6agR4zhH8vrOrZTQpuqOliaL2UML2Iu6xcLRxWGRsog0Ps7OfumXzFu0IZL1WFsoxUUUKWefdjcughQ27Dm9KO9fU=
X-Received: by 2002:a05:6102:14b:b0:398:2e7c:4780 with SMTP id
 a11-20020a056102014b00b003982e7c4780mr6624642vsr.72.1662989204188; Mon, 12
 Sep 2022 06:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com> <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
In-Reply-To: <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 16:26:32 +0300
Message-ID: <CAOQ4uxh2OZ_AMp6XRcMy0ZtjkQnBfBZFhH0t-+Pd298uPuSEVw@mail.gmail.com>
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

On Mon, Sep 12, 2022 at 4:03 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 12 Sept 2022 at 14:29, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 12:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Sat, 10 Sept 2022 at 10:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > BTW, I see that the Android team is presenting eBPF-FUSE on LPC
> > > > coming Tuesday [1].
> > >
> > > At first glance it looks like a filtered kernel-only passthrough +
> > > fuse fallback, where filtering is provided by eBPF scripts and only
> > > falls back to userspace access on more complex cases.  Maybe it's a
> > > good direction, we'll see.
> >
> > Yeh, we'll see.
> >
> > > Apparently the passthrough case is
> > > important enough for various use cases.
> > >
> >
> > Indeed.
> > My use case is HSM and I think that using FUSE for HSM is becoming
> > more and more common these days.
>
> HSM?
>

Sorry, Hierarchical Storage Management.
such as the product described at:
https://github.com/github/libprojfs/blob/master/docs/design.md#vfsforgit-on-windows

> >
> > One of the things that bothers me is that both this FUSE_PASSTHROUGH
> > patch set and any future eBPF-FUSE passthrough implementation is
> > bound to duplicate a lot of code and know how from overlayfs
> > (along with the bugs).
> >
> > We could try to factor out some common bits to a kernel fs passthough
> > library.
>
> Yeah, although fuse/passthrough might not want all the complexity.
> Getting rid of the context switch latency is the easy part.  Getting
> rid of  page cache duplication is the hard one, though it seems that the
> current level of hacks in overlayfs seems sufficient and nobody much
> cares for the corner cases (or works around them).
>

FWIW duplicate page cache exists in passthough FUSE whether
passthrough is in kernel or in userspace, but going through yet another
"switch" fs would make things even worse.

I have another completely different solution that I am considering
for HSM that is a little less flexible than FUSE, but does not have many of
the passthrough challenges:

https://lore.kernel.org/linux-fsdevel/CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com/

> >
> > Anotehr options to consider is not to add any passthrough logic
> > to FUSE at all.
> >
> > Instead, implement a "switch" fs to choose between passthrough
> > to one of several underlying fs "branches", where one of the branches
> > could be local fs and another a FUSE fs (i.e. for the complex cases).
>
> st_dev/st_ino management might become a headache (as it is in overlayfs).
>

Yeh. It's interesting how passthough of readdir and lookup/create in
eBPF-FUSE is going to handle those things...

Thanks,
Amir.
