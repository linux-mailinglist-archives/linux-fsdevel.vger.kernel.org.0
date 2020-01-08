Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C334B13433B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgAHNBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 08:01:41 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42755 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHNBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:01:41 -0500
Received: by mail-vk1-f195.google.com with SMTP id s142so922505vkd.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 05:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqCQrPpyfvJ6m17RhuP8iUaaDCZTkYJmOmcLsMQeCbA=;
        b=TQvVe9+MRroarPjSTG5AMtVaJxvlFpbSTRWmWNCUteTpi+6Luug0IfmOibQO2dZh/8
         mCHc0zKqKZc/0/RyOV53Mz48doEGjas6AT6CKWUcmUayFuqfnSSJJOHUQzRzTV84oNtr
         93cxahHvSq0b/2An6uhIiGcPA+b1b86kPgCm0RtS0Te8uyg7tt1lSDY56un+8oosGD0Z
         oSGed0zxweb5tl8U5FJmcksdfS6pNO5mWDLM1fvHeU9gVDchxADM7QXihKzcYo517JxM
         y0XeKpJZlEscwhvcvYFOYpjA++E6ZG0EtP5vgW2qV5hTyAcn1YpVHwgasXseo+YdyopN
         VECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqCQrPpyfvJ6m17RhuP8iUaaDCZTkYJmOmcLsMQeCbA=;
        b=FGNQsXw/4dFgSfr1se8D6k7vjvC+BjsL5BMaJcEs+IBUYY/1QvlyX1vAl6Sq8pvfIr
         0EbNdNqfA+SRZ8ebmdi4I7pKLTWfWuW4eB5LCMG+DAQXevfr20eRDVVkGURFV7wnep3f
         NY/eudTYF3IwsdCMdXeQZ82aekcfDMyy5YzMFQ4MRQwQcxRb2TGC4PN8sRg+i33N4ab3
         jK0x1+QdyPTW8fZEnAWrk42auMJU7qM4GuX1A5V2Zk7ttKeUMylDrota1jjaqndzgj3v
         aUrnOkF4Q07RRzs8g6ZHRSlTq4NcVd8r4IFq2K4o3AKuloonckDcbv9tNdOa6Nmb1qq5
         LJaw==
X-Gm-Message-State: APjAAAUhQmCUm+ZFjCCkLjr4GFgiImR1EQ5s2EbAxvkH5HFDclijdTkA
        JcW76YEm59yTRZGiaNYbx8r4gEf4zIPWa33luAt4LyRX01M=
X-Google-Smtp-Source: APXvYqwWgf6KlabKjPqUn1BZafotdHJG7YgXMn9xINi8qmatsY8ESslQ6ROy9axxwQ/jFO0ZniD23YEkraxBjrqeZbc=
X-Received: by 2002:ac5:c9a7:: with SMTP id f7mr2827510vkm.58.1578488500345;
 Wed, 08 Jan 2020 05:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20200101105248.25304-1-riteshh@linux.ibm.com> <CAOg9mSR17qRJ4VM5=1jndRwHw2Gcz8txgU9+-9GPFOfR34q7OA@mail.gmail.com>
 <20200108083827.6644642041@d06av24.portsmouth.uk.ibm.com>
In-Reply-To: <20200108083827.6644642041@d06av24.portsmouth.uk.ibm.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 8 Jan 2020 08:01:29 -0500
Message-ID: <CAOg9mSRvF=8AEw3P+WB9Bt5BnOnMLS40Eq+huHr_BVyK3Ov=5g@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/1] Use inode_lock/unlock class of provided APIs
 in filesystems
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yes, please do.

-Mike

On Wed, Jan 8, 2020 at 3:38 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 1/3/20 2:31 AM, Mike Marshall wrote:
> > Ritesh -
> >
> > I just loaded your patch on top of 5.5-rc4 and it looks fine to me
> > and xfstests :-) ... I pointed ftrace at the orangefs function you
> > modified while xfstests was running, and it got called about a
> > jillion times...
>
> Thanks Mike for testing this. Shall I add your Tested-by?
>
> -ritesh
>
>
> >
> > -Mike
> >
> > On Wed, Jan 1, 2020 at 5:53 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >>
> >> Al, any comments?
> >> Resending this after adding Reviewed-by/Acked-by tags.
> >>
> >>
> >>  From previous version:-
> >> Matthew Wilcox in [1] suggested that it will be a good idea
> >> to define some missing API instead of directly using i_rwsem in
> >> filesystems drivers for lock/unlock/downgrade purposes.
> >>
> >> This patch does that work. No functionality change in this patch.
> >>
> >> After this there are only lockdep class of APIs at certain places
> >> in filesystems which are directly using i_rwsem and second is XFS,
> >> but it seems to be anyway defining it's own xfs_ilock/iunlock set
> >> of APIs and 'iolock' naming convention for this lock.
> >>
> >> [1]: https://www.spinics.net/lists/linux-ext4/msg68689.html
> >>
> >> Ritesh Harjani (1):
> >>    fs: Use inode_lock/unlock class of provided APIs in filesystems
> >>
> >>   fs/btrfs/delayed-inode.c |  2 +-
> >>   fs/btrfs/ioctl.c         |  4 ++--
> >>   fs/ceph/io.c             | 24 ++++++++++++------------
> >>   fs/nfs/io.c              | 24 ++++++++++++------------
> >>   fs/orangefs/file.c       |  4 ++--
> >>   fs/overlayfs/readdir.c   |  2 +-
> >>   fs/readdir.c             |  4 ++--
> >>   include/linux/fs.h       | 21 +++++++++++++++++++++
> >>   8 files changed, 53 insertions(+), 32 deletions(-)
> >>
> >> --
> >> 2.21.0
> >>
>
