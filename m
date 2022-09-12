Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597375B6102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiILSey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiILSd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:33:27 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3CE17E00
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 11:30:04 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id i129so4679334vke.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jK7zQuVnyH6VKxB/HHGTOEjHjydvwE7ogHgu6RMg6hM=;
        b=UdYhCRrEwWOFDluk5xAl8PEDIeWwLvT+WLkajE3xKw6lY+DI6yU2AzZsRHTk9o+wud
         8PbDVsiowGsg/zBLRq3IISrgo0xKkYqKYBgVdx2tfetxSch8K0tyVQQ3EWlmuZtWUF2o
         KJ0B3amtQMgdLpRsIrxse4yD+B8RHMVo4ClBuwhPu9fn0w2z2coKMu/FMJ70wz25e9b5
         Rf/ViaEl1kANqcaWYmS8HBv3MOJapCb6yPTmjgcEys+wr6GcjG2ulX2TgHoQtfGFJJ6p
         zCiV65ETu/oOPivfxSGoDyXGfPVrmayRjtUVmTROWwgosJc96Lm07Vla3+xAZ5LW7/2J
         WiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jK7zQuVnyH6VKxB/HHGTOEjHjydvwE7ogHgu6RMg6hM=;
        b=Nqh7TloJLy86AxaX3a3Duqy0M0XrsZz/LiDfGM52Kx613VnSR7kuWQTSp99AQLT+Bk
         tBkqqPvfJYbi3ij2LImbr3N9VYDChfMzXDRHjZgahj6U+3M13OKwbLQrkvUtKru22wyx
         /x2I4ya0UCg6CR3N53jMpsUMdF96CvTImOTBOE4fpnCHZcs462FhR6cUJereROEmsll2
         FprohU6RqpdLDTTFqfUM0oPSvVgQd0KM3VNAx/Efe/CGgPcXE0t8tfj28mTV4Y6kWMGm
         aDcV8YsZumiGGkTNh0nHovp02zydQnrHw0sgLYzMfnYzx5B4dPcWT9EXfOfSbCTUrRYW
         7zjA==
X-Gm-Message-State: ACgBeo2QIJlyFllJr3pU2qqynpBQVqZMijpr2L+g3GA6hq1n3EgL5Jlt
        +wU5m6TaJEbk3oHOCkiE2GkyfjYRorxGmxhm217v3l4L
X-Google-Smtp-Source: AA6agR6dPkCdl3HQZJPw3N+qmInPLW9DQ9Peqz6I3OfGHrSI3fDZRYDnBpKo05fwS0Vl8rHK5kEQy7cjXCpNEYvweAk=
X-Received: by 2002:a1f:a004:0:b0:398:3e25:d2a7 with SMTP id
 j4-20020a1fa004000000b003983e25d2a7mr8942277vke.36.1663007335269; Mon, 12 Sep
 2022 11:28:55 -0700 (PDT)
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
 <CAJfpegt4N2nmCQGmLSBB--NzuSSsO6Z0sue27biQd4aiSwvNFw@mail.gmail.com>
 <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com> <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com>
In-Reply-To: <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 21:28:43 +0300
Message-ID: <CAOQ4uxjUbwKmLAO-jTE3y6EnH2PNw0+V=oXNqNyD+H9U+nX49g@mail.gmail.com>
Subject: Re: Overlayfs with writable lower layer
To:     Hao Luo <haoluo@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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

[Changing subject, reduce CC list and add move to overlayfs list]

On Mon, Sep 12, 2022 at 8:43 PM Hao Luo <haoluo@google.com> wrote:
>
> Sorry, resend, my response was bounced back by mail system due to not
> using plain text.
>
> On Mon, Sep 12, 2022 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 5:22 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > I imagine the "switch" layer for a HSM would be simple enough:
> > >
> > > a) if file exists on fastest layer (upper) then take that
> > > b) if not then fall back to fuse layer (lower) .
> > >
> > > It's almost like a read-only overlayfs (no copy up) except it would be
> > > read-write and copy-up/down would be performed by the server as
> > > needed. No page cache duplication for upper, and AFAICS no corner
> > > cases that overlayfs has, since all layers are consistent (the fuse
> > > layer would reference the upper if that is currently the up-to-date
> > > one).
> >
> > On recent LSF/MM/BPF, BPF developers asked me about using overlayfs
> > for something that looks like the above - merging of non overlapping layers
> > without any copy-up/down, but with write to lower.
> >
> > I gave them the same solution (overlayfs without copy-up)
> > but I said I didn't know what you would think about this overlayfs mode
> > and I also pointed them to the eBPF-FUSE developers as another
> > possible solution to their use case.
> >
>
> Thanks Amir for adding me in the thread. This idea is very useful for
> BPF use cases.

Hi Hao,

Thanks for chiming in.
This thread has long diverged from the FUSE_PASSTHROUGH
patch review so I started a new thread to discuss the overlayfs
option.

Am I to understand that the eBPF-FUSE option currently
does not fit your needs (maybe because it is not ready yet)?

>
> A bit more context here: we were thinking of overlaying two
> filesystems together to create a view that extends the filesystem at
> the lower layer. In our design, the lower layer is a pseudo
> filesystem, which one can _not_ create/delete files, but make
> directories _indirectly_, via creating a kernel object; the upper is
> bpf filesystem, from which, one can create files. The file's purpose
> is to describe the directory in the lower layer, that is, to describe
> the kernel object that directory corresponds to.
>
> With the flexibility brought by BPF, it can be a quite flexible
> solution to query kernel objects' states.
>

Can't say I was able to understand the description, but let me
try to write the requirement in overlayfs terminology.
Please correct me if I am wrong.

1. The "lower" fs (cgroupfs?) is a "remote" fs where directories
    may appear or disappear due to "remote" events

I think there were similar requirements to support changes
to lower fs which in a network fs in the past.
As long as those directories are strictly lower that should be
possible.

Does upper fs have directories of the same name that need to
be merged with those lower dirs?

2. You did not mention this but IIRC, the lower fs has (pseudo)
    files that you want to be able to write to, and those files never
    exist in the upper fs

That translates to allowing write to lower fs without triggering copy-up

3. The upper fs files are all "pure" - that means those file paths
    do not exist in lower fs

Creating files in the upper fs is normal in overlayfs, so not a problem.

4. Merging upper and lower directory content is usually not needed??

It must be needed for the root dir at least but where else?
In which directories are the upper files created?
Which directories are "pure" (containing either lower or upper files)
and which directories are "merge" of upper and lower children?

If the answer is that some directories exist both in upper and in lower
and that those directories should be merged for the unified view then
this is standard overlayfs behavior.

Once I get the requirement in order I will try to write coherent
semantics for this mode and see if it can meet the needs of other
projects, such as HSM with FUSE as lower fs.

Thanks,
Amir.
