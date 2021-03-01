Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322CE3275EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 02:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhCABuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 20:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCABuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 20:50:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF1EC06174A;
        Sun, 28 Feb 2021 17:50:05 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v5so22849466lft.13;
        Sun, 28 Feb 2021 17:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=2realms.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMgNTJPOAg+qQMXwj/r3vYLwLDCB8oAbkinZW7qbAWo=;
        b=RNajYS1RBlyo70JbifMa8d+4/2KHLfnKnvomLVhV29cGqMRhLAcTWLMKfyxnbSmGBt
         6vvyCOZvGLfbTY6qwa5UED254ZyGkeJpFtVJHOZSbsFTBniSHib7arzhkbDOwMauxj4x
         iB2jSCZZo9wCLLRYwHAWyV+B2wfCqXIr6n4D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMgNTJPOAg+qQMXwj/r3vYLwLDCB8oAbkinZW7qbAWo=;
        b=jKTEx/ui+Jb9ENyHDNQKJR5l3i3IHzk4Y2nQAOM1ZlhlO4GYuqvonEEQSNE8d0pJ4O
         TK7qXRRn8uMAFeheEXOJmJ4HhWeH8fGTsuRzk3JysU0vFgy6Mro4XJLQvUoYKTVyAKZY
         jESgwpNoRX5ldyHrGNjjWuhTKB2p16qaFmuLk1JaEH2ebi0Uoph8GzOOitFCZNghtx9Z
         X5RMJCPvkHD703qLEvKeyjgHwcclZMsXvO+l7Ia24BZd2iltNSP/xoWbALozR+BQu991
         lcENEmiQc94YXM8hrLP/U7SfMe4/lqBKD7Oz7S9EryT+Ih5PGh4MeuxuerYvSjaJmaL/
         RIuQ==
X-Gm-Message-State: AOAM533dC+4cSbnzok44e51HtsHsBt3B1XevUBQUX9TJINDzWf8uJZgv
        ZSQ5ZbpE7j9Pn/fSdgFTnHnfXD0Typ44fLvRMDt3L1nRcY8=
X-Google-Smtp-Source: ABdhPJwK5Nvh9BNvLEkZovgQTEJPl6MR/K6ohmOrnYQm11sjAukYEI/8aL6gHduiL4N+JlRo7tBzd8gwyIAokqOLh2Q=
X-Received: by 2002:a19:c14c:: with SMTP id r73mr8341900lff.581.1614563402083;
 Sun, 28 Feb 2021 17:50:02 -0800 (PST)
MIME-Version: 1.0
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com> <20210218121503.GQ2858050@casper.infradead.org>
 <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net> <20210219142201.GU2858050@casper.infradead.org>
 <20210222014844.GB4626@dread.disaster.area>
In-Reply-To: <20210222014844.GB4626@dread.disaster.area>
From:   GWB <gwb@2realms.com>
Date:   Sun, 28 Feb 2021 19:49:25 -0600
Message-ID: <CAP8EXU0JMsL=G=tSfuOVCdnx8W5_N3J-q4WmCy3+PSVdJmHhXg@mail.gmail.com>
Subject: Re: page->index limitation on 32bit system?
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Getting btrfs patched for 32 bit arm would be of interest, but I'm not
suggesting the devs can do much more with that.  In practical usage,
we ran into similar difficulties a while back on embedded and
dedicated devices which would boot btrfs, but eventually it was easier
to put storage on nilfs2.  Nilfs2 is nice, but not nearly as developed
as btrfs (it snapshots, but did not allow sending and incremental
backups, and it is comparatively slow).  No idea, however, if it would
even compile on arm 32.

I'm delighted, Erik, that you were able to get btrfs to function to
the extent that it did, and that you're willing to put time and effort
in btrfs on arm 32 bit.  But before you do, consider nilfs2 for
storage.  You can even get zfs to work on some 32 bit systems but RAM
is an issue.  Also take a look at the Raspberry Pi 4's.  They have an
8gig 64 bit embedded version called Compute Module 4, which seems to
handle btrfs, and are not too pricey.  ZFS can work, but its too
memory intensive for 8 gigs.

Gordon

On Sun, Feb 21, 2021 at 7:52 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 19, 2021 at 02:22:01PM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 18, 2021 at 01:27:09PM -0800, Erik Jensen wrote:
> > > On 2/18/21 4:15 AM, Matthew Wilcox wrote:
> > >
> > > > On Thu, Feb 18, 2021 at 04:54:46PM +0800, Qu Wenruo wrote:
> > > > > Recently we got a strange bug report that, one 32bit systems like armv6
> > > > > or non-64bit x86, certain large btrfs can't be mounted.
> > > > >
> > > > > It turns out that, since page->index is just unsigned long, and on 32bit
> > > > > systemts, that can just be 32bit.
> > > > >
> > > > > And when filesystems is utilizing any page offset over 4T, page->index
> > > > > get truncated, causing various problems.
> > > > 4TB?  I think you mean 16TB (4kB * 4GB)
> > > >
> > > > Yes, this is a known limitation.  Some vendors have gone to the trouble
> > > > of introducing a new page_index_t.  I'm not convinced this is a problem
> > > > worth solving.  There are very few 32-bit systems with this much storage
> > > > on a single partition (everything should work fine if you take a 20TB
> > > > drive and partition it into two 10TB partitions).
> > > For what it's worth, I'm the reporter of the original bug. My use case is a
> > > custom NAS system. It runs on a 32-bit ARM processor, and has 5 8TB drives,
> > > which I'd like to use as a single, unified storage array. I chose btrfs for
> > > this project due to the filesystem-integrated snapshots and checksums.
> > > Currently, I'm working around this issue by exporting the raw drives using
> > > nbd and mounting them on a 64-bit system to access the filesystem, but this
> > > is very inconvenient, only allows one machine to access the filesystem at a
> > > time, and prevents running any tools that need access to the filesystem
> > > (such as backup and file sync utilities) on the NAS itself.
> > >
> > > It sounds like this limitation would also prevent me from trying to use a
> > > different filesystem on top of software RAID, since in that case the logical
> > > filesystem would still be over 16TB.
> > >
> > > > As usual, the best solution is for people to stop buying 32-bit systems.
> > > I purchased this device in 2018, so it's not exactly ancient. At the time,
> > > it was the only SBC I could find that was low power, used ECC RAM, had a
> > > crypto accelerator, and had multiple sata ports with port-multiplier
> > > support.
> >
> > I'm sorry you bought unsupported hardware.
> >
> > This limitation has been known since at least 2009:
> > https://lore.kernel.org/lkml/19041.4714.686158.130252@notabene.brown/
>
> 2004:
>
> commit 839099eb5ea07aef093ae2c5674f5a16a268f8b6
> Author: Eric Sandeen <sandeen@sgi.com>
> Date:   Wed Jul 14 20:02:01 2004 +0000
>
>     Add filesystem size limit even when XFS_BIG_BLKNOS is
>     in effect; limited by page cache index size (16T on ia32)
>
> This all popped up on XFS around 2003 when the the disk address
> space was expanded from 32 bits to 64 bits on 32 bit systems
> (CONFIG_LBD) and so XFS could define XFS_BIG_FILESYSTEMS on 32 bit
> systems for the first time.
>
> FWIW, from an early 1994 commit into xfs_types.h:
>
> +/*
> + * Some types are conditional based on the selected configuration.
> + * Set XFS_BIG_FILES=1 or 0 and XFS_BIG_FILESYSTEMS=1 or 0 depending
> + * on the desired configuration.
> + * XFS_BIG_FILES needs pgno_t to be 64 bits.
> + * XFS_BIG_FILESYSTEMS needs daddr_t to be 64 bits.
> + *
> + * Expect these to be set from klocaldefs, or from the machine-type
> + * defs files for the normal case.
> + */
>
> So limiting file and filesystem sizes on 32 bit systems is
> something XFS has done right from the start...
>
> > In the last decade, nobody's tried to fix it in mainline that I know of.
> > As I said, some vendors have tried to fix it in their NAS products,
> > but I don't know where to find that patch any more.
>
> It's not suportable from a disaster recovery perspective. I recently
> saw a 14TB filesystem with billions of hardlinks in it require 240GB
> of RAM to run xfs_repair. We just can't support large filesystems
> on 32 bit systems, and it has nothing to do with simple stuff like
> page cache index sizes...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
