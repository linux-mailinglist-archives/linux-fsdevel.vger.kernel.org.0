Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9075B7A62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiIMTA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 15:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiIMS7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:59:51 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987F766F
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 11:54:42 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id p17so4686219uao.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Co+d+J1tEoeDNOz0j/nYkP/v4ocQj3W1GGQZD1NDNBg=;
        b=i7cMQbx1RdciQS03Aigw1V9ryzSqgDDS22mcTj80grbjSPM7WznsBJr0sZCl/4pZzG
         Kx/I6qVTXMOmkMfGrK7BbOn5dEhn4dm+35ctKDRRIijr58Mj9OGKNEHOVF3pSLQQI1GT
         IxrjVHTY6737bdNdDsFAnwFBRNQIySEaX++G9yB/IMHldOfQj6ucLOYOw5UlR9XIg5Zd
         1NyTFIn1zRjfVwAhDvb8ojIldfrcj7F4ApCfm3CJ0eeqAHxOOLgQZ/V2QXLNFK/BZvwX
         +U9/2wJhMwA6A8MoJVc39XMkqEpaUGlt2hm24qdPD/E2cELUAN5j0w94OjCNUp5dva2S
         z1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Co+d+J1tEoeDNOz0j/nYkP/v4ocQj3W1GGQZD1NDNBg=;
        b=2HXyOZifS3vBh/sCRREG3CdhEK8dRwO8ahOJKgZlX0B0KdcFfOM+rXK1w/oeyeT7Gm
         zqOzmPK7CBkTfhrA4jvpZMIfMAWDiLC/jqqY23AXIcW5QToUm7mKg9o6LUZf8DoF2J5y
         CK+U9ZwEDe16zBiI52vcsjLlxo3I9mBh3QZWGyeav+tahfmsk8UxDIhaFdUALtuLSbcC
         sGatYAEnMMQH/TuswuWZyTiONNy4nu7OQtCBd4dSI4kSieafynakbT3/JsMuy2GsyXQ+
         FejW1NqB0j1pl4ATVb2096DEy9RBDS4PQyAv78Jbtictx6vcPlL/AB6PH9VUEMBnbGVm
         hdKA==
X-Gm-Message-State: ACgBeo3d/C3CMKoU7jM6jwYnmmztZKOJwnPCJMF1Bw1k3ez3xiKbW460
        7HVVpA61K0QzMAB8fWDVe4r8WIJhR58O8KeidhCGfht6
X-Google-Smtp-Source: AA6agR6E2avCBnj7WP1H+GImFsVz2soR7jhyAxxrgaFUihc1N8j/JIbxkQfeg/K0DIWGjbrNZXF6CLPgykX1jXTfsAM=
X-Received: by 2002:a9f:38c2:0:b0:3af:4101:374f with SMTP id
 w2-20020a9f38c2000000b003af4101374fmr10759866uaf.80.1663095281627; Tue, 13
 Sep 2022 11:54:41 -0700 (PDT)
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
 <CAOQ4uxjjPOtH9+r=oSV4iVAUvW6s3RBjA9qC73bQN1LhUqjRYQ@mail.gmail.com>
 <CA+khW7hviAT6DbNORYKcatOV1cigGyrd_1mH-oMwehafobVXVg@mail.gmail.com>
 <CAOQ4uxjUbwKmLAO-jTE3y6EnH2PNw0+V=oXNqNyD+H9U+nX49g@mail.gmail.com> <CA+khW7jQ6fZbEgzxCafsaaTyv7ze58bd9hQ0HBH4R+dQyRaqog@mail.gmail.com>
In-Reply-To: <CA+khW7jQ6fZbEgzxCafsaaTyv7ze58bd9hQ0HBH4R+dQyRaqog@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 13 Sep 2022 21:54:29 +0300
Message-ID: <CAOQ4uxjP0qeuUrdjT6hXCb5zO0AoY+LKM6uza2cL9UCGMo8KsQ@mail.gmail.com>
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

On Tue, Sep 13, 2022 at 9:26 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Sep 12, 2022 at 11:28 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 8:43 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Mon, Sep 12, 2022 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 12, 2022 at 5:22 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > I imagine the "switch" layer for a HSM would be simple enough:
> > > > >
> > > > > a) if file exists on fastest layer (upper) then take that
> > > > > b) if not then fall back to fuse layer (lower) .
> > > > >
> > > > > It's almost like a read-only overlayfs (no copy up) except it would be
> > > > > read-write and copy-up/down would be performed by the server as
> > > > > needed. No page cache duplication for upper, and AFAICS no corner
> > > > > cases that overlayfs has, since all layers are consistent (the fuse
> > > > > layer would reference the upper if that is currently the up-to-date
> > > > > one).
> > > >
> > > > On recent LSF/MM/BPF, BPF developers asked me about using overlayfs
> > > > for something that looks like the above - merging of non overlapping layers
> > > > without any copy-up/down, but with write to lower.
> > > >
> > > > I gave them the same solution (overlayfs without copy-up)
> > > > but I said I didn't know what you would think about this overlayfs mode
> > > > and I also pointed them to the eBPF-FUSE developers as another
> > > > possible solution to their use case.
> > > >
> > >
> > > Thanks Amir for adding me in the thread. This idea is very useful for
> > > BPF use cases.
> >
> [...]
> >
> > Am I to understand that the eBPF-FUSE option currently
> > does not fit your needs (maybe because it is not ready yet)?
> >
>
> Yeah, mostly because eBPF-FUSE is not ready. I talked to Alessio and
> his colleague after LSF/MM/BPF. They were distracted from eBPF-FUSE
> development at that time and I didn't follow up, working on other BPF
> stuff.
>
> > >
> [...]
> > Can't say I was able to understand the description, but let me
> > try to write the requirement in overlayfs terminology.
> > Please correct me if I am wrong.
> >
> > 1. The "lower" fs (cgroupfs?) is a "remote" fs where directories
> >     may appear or disappear due to "remote" events
> >
>
> Right. Seems we are aligned on this.
>
> > I think there were similar requirements to support changes
> > to lower fs which in a network fs in the past.
> > As long as those directories are strictly lower that should be
> > possible.
> >
> > Does upper fs have directories of the same name that need to
> > be merged with those lower dirs?
> >
>
> No, I don't think so. Upper fs should only have files in my use case.
>
> > 2. You did not mention this but IIRC, the lower fs has (pseudo)
> >     files that you want to be able to write to, and those files never
> >     exist in the upper fs
> >
> > That translates to allowing write to lower fs without triggering copy-up
> >
>
> Writing to lower is not needed right now.
>
> > 3. The upper fs files are all "pure" - that means those file paths
> >     do not exist in lower fs
> >
> > Creating files in the upper fs is normal in overlayfs, so not a problem.
> >
>
> Yes. If used in an expected way, the lower fs won't have file paths
> that also exist in the upper.
>
> > 4. Merging upper and lower directory content is usually not needed??
> >
> > It must be needed for the root dir at least but where else?
> > In which directories are the upper files created?
> > Which directories are "pure" (containing either lower or upper files)
> > and which directories are "merge" of upper and lower children?
> >
>
> In my use case, if that's doable, all the directories are "pure",
> except the root dir, and they are in the lower. The files are either
> from upper or from lower, so no merge. This should be sufficient for
> the BPF use case.
>
> > If the answer is that some directories exist both in upper and in lower
> > and that those directories should be merged for the unified view then
> > this is standard overlayfs behavior.
> >
> > Once I get the requirement in order I will try to write coherent
> > semantics for this mode and see if it can meet the needs of other
> > projects, such as HSM with FUSE as lower fs.
>
> Thanks Amir. I want to clarify that with my very very limited
> knowledge on FS, I can't say what I am thinking right now is
> absolutely correct. Please take my request for features with a grain
> of salt and feel free to pick the semantics that you see make most
> sense.
>

OK. IIUC, you have upper fs files only in the root dir?
And the lower root dir has only subdirs?

If that is all then it sounds pretty simple.
It could be described something like this:
1. merged directories cannot appear/disappear
2. lower pure directories can appear/disappear
3. upper files/dirs can be created inside merge dirs and pure upper dirs

I think I have some patches that could help with #2.

Can you give a small example of an upper a lower and their
union trees just for the sake of discussion?

Thanks,
Amir.
