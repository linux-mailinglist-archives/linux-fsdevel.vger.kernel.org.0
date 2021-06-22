Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB223B0464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhFVMcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhFVMcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F7C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h2so7994190iob.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HLmTmVuuBpaotf6UimooCw0I2x7NRsXSXiyt5vUC6yo=;
        b=CVBcfjSTzsrzZcOg7yBHG95WzkSzsc9ei7Ds7laJEdW4W6mVhcYgjQtTk059FPoUAN
         s95UIYRZgvP4jIfJpCNaajkjfcfQj5I23cVGmqF8tD4WosC2L79Q6lsxz8Lx6x4mV7ZV
         lHLQzNRVvbq+pMNxpfNwDvFDxG9Ao9QECe2AvUkwG0crqiVOTiTu2AFKd6undHoZZL+h
         Pel4diN4gl/ojs9Wd1/5GAtwHB0t86XK2PXD0RSj5J0iFKy8IlRQm+MGybLyiPCy/Oqr
         4sM59HYTtYcvClDZYlclZlm9bNDL59PfXEIz7Lsh1U0FUwq0q0fld0SF9apUM72E1epd
         dxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HLmTmVuuBpaotf6UimooCw0I2x7NRsXSXiyt5vUC6yo=;
        b=KXNsm0Ua933AKrlsHntjT/ixje/gT5p8fvQDCMC9oTwnW1n+RWSrUhnJvhhAa4Nhbl
         w654qb9SvFY4wHJ7WLrVBhHRM6aHgkBSc/7v4FkFBEfMw5lQSkwgozpV8vr8K+pfndkC
         qDpUG5loKjGaZ8IlNokdRanwE+PR8t8k+OL608dY/tpBx+vIR+VFjrri0+v/ZBGkKbhY
         37l2qIl7rnAziTm6TKab7lxQs5Z60WWnzJiP4OvoSnz6xlIX8oDCMBMcc5m76i7VC+lr
         6T3Nme9cHbqCVvzhwnWCAIA2x+1JpBpqvcLq+IFot0Ejx/IpnE4Zv/3T0Ks/XM5JBab9
         FBdg==
X-Gm-Message-State: AOAM533RBPiNGiGxRjT3lBC3U7yRxeSbhooukda8cu2gBAMyPVrWdEfA
        oEDxoGnvO8r2lRM8d1OYigo5SEM7tlxgSz8SXyjLOA==
X-Google-Smtp-Source: ABdhPJyBFnZ/enj0tZDRqDCSnSs4jMGpAl1FO4ZrOEGPE1Kdkl8s+X+/DbqvC3LAwuWmsofe9hBKZhrFj5Fbqz7m7AM=
X-Received: by 2002:a02:5b45:: with SMTP id g66mr3798144jab.62.1624364983969;
 Tue, 22 Jun 2021 05:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095309.3542373-1-stapelberg+linux@google.com>
 <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com>
 <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
 <CAJfpegu0prjjHVhBzwZBVk5N+avHvUcyi4ovhKbf+F7GEuVkmw@mail.gmail.com>
 <CAH9Oa-YxeZ25Vbto3NyUw=RK5vQWv_v7xp3vHS9667iJJ8XV_A@mail.gmail.com> <20210622121205.GG14261@quack2.suse.cz>
In-Reply-To: <20210622121205.GG14261@quack2.suse.cz>
From:   Michael Stapelberg <stapelberg+linux@google.com>
Date:   Tue, 22 Jun 2021 14:29:32 +0200
Message-ID: <CAH9Oa-YxL1iu_TVn6bL3Nd4qzYSVDPaO9a96sX4u7dhq+ewasA@mail.gmail.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for taking a look! Comments inline:

On Tue, 22 Jun 2021 at 14:12, Jan Kara <jack@suse.cz> wrote:
>
> On Mon 21-06-21 11:20:10, Michael Stapelberg wrote:
> > Hey Miklos
> >
> > On Fri, 18 Jun 2021 at 16:42, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Fri, 18 Jun 2021 at 10:31, Michael Stapelberg
> > > <stapelberg+linux@google.com> wrote:
> > >
> > > > Maybe, but I don=E2=80=99t have the expertise, motivation or time t=
o
> > > > investigate this any further, let alone commit to get it done.
> > > > During our previous discussion I got the impression that nobody els=
e
> > > > had any cycles for this either:
> > > > https://lore.kernel.org/linux-fsdevel/CANnVG6n=3DySfe1gOr=3D0ituQid=
p56idGARDKHzP0hv=3DERedeMrMA@mail.gmail.com/
> > > >
> > > > Have you had a look at the China LSF report at
> > > > http://bardofschool.blogspot.com/2011/?
> > > > The author of the heuristic has spent significant effort and time
> > > > coming up with what we currently have in the kernel:
> > > >
> > > > """
> > > > Fengguang said he draw more than 10K performance graphs and read ev=
en
> > > > more in the past year.
> > > > """
> > > >
> > > > This implies that making changes to the heuristic will not be a qui=
ck fix.
> > >
> > > Having a piece of kernel code sitting there that nobody is willing to
> > > fix is certainly not a great situation to be in.
> >
> > Agreed.
> >
> > >
> > > And introducing band aids is not going improve the above situation,
> > > more likely it will prolong it even further.
> >
> > Sounds like =E2=80=9CPerfect is the enemy of good=E2=80=9D to me: you=
=E2=80=99re looking for a
> > perfect hypothetical solution,
> > whereas we have a known-working low risk fix for a real problem.
> >
> > Could we find a solution where medium-/long-term, the code in question
> > is improved,
> > perhaps via a Summer Of Code project or similar community efforts,
> > but until then, we apply the patch at hand?
> >
> > As I mentioned, I think adding min/max limits can be useful regardless
> > of how the heuristic itself changes.
> >
> > If that turns out to be incorrect or undesired, we can still turn the
> > knobs into a no-op, if removal isn=E2=80=99t an option.
>
> Well, removal of added knobs is more or less out of question as it can
> break some userspace. Similarly making them no-op is problematic unless w=
e
> are pretty certain it cannot break some existing setup. That's why we hav=
e
> to think twice (or better three times ;) before adding any knobs. Also
> honestly the knobs you suggest will be pretty hard to tune when there are
> multiple cgroups with writeback control involved (which can be affected b=
y
> the same problems you observe as well). So I agree with Miklos that this =
is
> not the right way to go. Speaking of tunables, did you try tuning
> /sys/devices/virtual/bdi/<fuse-bdi>/min_ratio? I suspect that may
> workaround your problems...

Back then, I did try the various tunables (vm.dirty_ratio and
vm.dirty_background_ratio on the global level,
/sys/class/bdi/<bdi>/{min,max}_ratio on the file system level), and
they have had no observable effect on the problem at all in my tests.

>
> Looking into your original report and tracing you did (thanks for that,
> really useful), it seems that the problem is that writeback bandwidth is
> updated at most every 200ms (more frequent calls are just ignored) and ar=
e
> triggered only from balance_dirty_pages() (happen when pages are dirtied)=
 and
> inode writeback code so if the workload tends to have short spikes of act=
ivity
> and extended periods of quiet time, then writeback bandwidth may indeed b=
e
> seriously miscomputed because we just won't update writeback throughput
> after most of writeback has happened as you observed.
>
> I think the fix for this can be relatively simple. We just need to make
> sure we update writeback bandwidth reasonably quickly after the IO
> finishes. I'll write a patch and see if it helps.

Thank you! Please keep us posted.
