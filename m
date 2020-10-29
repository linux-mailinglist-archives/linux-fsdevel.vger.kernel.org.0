Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0275D29F440
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 19:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgJ2SrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 14:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2SrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:47:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2741C0613CF;
        Thu, 29 Oct 2020 11:47:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p7so4653408ioo.6;
        Thu, 29 Oct 2020 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wEcaN0VzDZ0Oc/PbArODzNa/VUI//iOrT8i9S3TtNo=;
        b=Dlj5EpBGsOiuFZfJmBM5dHhrn/UmRzWOxTOXnmRlJZLRUuB7oLXzg1gjarN/IdawM5
         7U0soCxmQxwzOOQFQVL70A4GxebcMbwKVR7PvMonpoydDGo83WsjFNz4kzTC6LX/TLh/
         LtjfzZ05aEe+LwvCT6Th8ofcXwUr3Y/yDfclH2XNBizd+KW6VdwP2sNgOibowybeYGM+
         Xk54Fg5r1nuR8+RkCSKj2BHmsEexU+u7Rt+bmADmJHYgzH7x5/fW7NeMA0tyaG0Osenx
         js10+fmGNUWKOcN588MZy83kRSHAQu3LjR0eL9LRlOGt2pMMPfbQb4rsCnBO3xH3a/i/
         QFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wEcaN0VzDZ0Oc/PbArODzNa/VUI//iOrT8i9S3TtNo=;
        b=jY+FTMdhLtLGGz3FikEj1atdiJx0CH8XnXVBQodJbJccFr6wEOJSLWZkNsq9HGAX01
         V7ReDUxBe7IMIWr3SUcZCGAp1gV3z362PalreQu8yQoN0uuB/N8kdtMvGFw6hRiA1bEi
         bSZtB0K7cd1Sk3wUYE0LdNRQ4YDL6Seoq0PqIQrhB3nnRUPM0+nwbVmNQsOxUN8S34Cz
         Jc6ehtyF96bzb4YRDuYnb6g5brcLrzIQAkqujxrvy2SXEFHdIbDWSaab7uie0vJwmBN4
         N9XA6zQUEd8QVcFZIDstbo5/pSo6TxIaUVIu+ElMvoj2hnggVmTIkH5gALU26X+HJQei
         +0lQ==
X-Gm-Message-State: AOAM530Q8BUXhuOjQCX0xedKn52lK1I083w448CNeFMzyki1SOEg+8vn
        LcBT7dZ3fPhmPRMqv0UxHSxD+lsE8XBsgj/UHqYGfiiV1Yo=
X-Google-Smtp-Source: ABdhPJwp5Fk9/1zp4/yizQO2b3OPYicCFO7vxmyWN3SwqtCzex4SK448ZZ9IvYRatR4F7RLjZ3dcluCdybFh1iFETr4=
X-Received: by 2002:a02:9f12:: with SMTP id z18mr4651365jal.123.1603997222219;
 Thu, 29 Oct 2020 11:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201029154535.2074-1-longman@redhat.com> <CAOQ4uxjT8rWLr1yCBPGkhJ7Rr6n3+FA7a0GmZaMBHMzk9t1Sag@mail.gmail.com>
 <ccec54cd-cbb5-2808-3800-890cda208967@redhat.com>
In-Reply-To: <ccec54cd-cbb5-2808-3800-890cda208967@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Oct 2020 20:46:51 +0200
Message-ID: <CAOQ4uximGK1DnM7fYabChp-8pNqt3cSHeDWZYNKSwr6qSnxpug@mail.gmail.com>
Subject: Re: [PATCH v2] inotify: Increase default inotify.max_user_watches
 limit to 1048576
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 8:05 PM Waiman Long <longman@redhat.com> wrote:
>
> On 10/29/20 1:27 PM, Amir Goldstein wrote:
> > On Thu, Oct 29, 2020 at 5:46 PM Waiman Long <longman@redhat.com> wrote:
> >> The default value of inotify.max_user_watches sysctl parameter was set
> >> to 8192 since the introduction of the inotify feature in 2005 by
> >> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> >> small for many modern usage. As a result, users have to explicitly set
> >> it to a larger value to make it work.
> >>
> >> After some searching around the web, these are the
> >> inotify.max_user_watches values used by some projects:
> >>   - vscode:  524288
> >>   - dropbox support: 100000
> >>   - users on stackexchange: 12228
> >>   - lsyncd user: 2000000
> >>   - code42 support: 1048576
> >>   - monodevelop: 16384
> >>   - tectonic: 524288
> >>   - openshift origin: 65536
> >>
> >> Each watch point adds an inotify_inode_mark structure to an inode to
> >> be watched. It also pins the watched inode as well as an inotify fdinfo
> >> procfs file.
> >>
> >> Modeled after the epoll.max_user_watches behavior to adjust the default
> >> value according to the amount of addressable memory available, make
> >> inotify.max_user_watches behave in a similar way to make it use no more
> >> than 1% of addressable memory within the range [8192, 1048576].
> >>
> >> For 64-bit archs, inotify_inode_mark plus 2 inode have a size close
> >> to 2 kbytes. That means a system with 196GB or more memory should have
> >> the maximum value of 1048576 for inotify.max_user_watches. This default
> >> should be big enough for most use cases.
> >>
> >> With my x86-64 config, the size of xfs_inode, proc_inode and
> >> inotify_inode_mark is 1680 bytes. The estimated INOTIFY_WATCH_COST is
> >> 1760 bytes.
> >>
> >> [v2: increase inotify watch cost as suggested by Amir and Honza]
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>   fs/notify/inotify/inotify_user.c | 24 +++++++++++++++++++++++-
> >>   1 file changed, 23 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> >> index 186722ba3894..37d9f09c226f 100644
> >> --- a/fs/notify/inotify/inotify_user.c
> >> +++ b/fs/notify/inotify/inotify_user.c
> >> @@ -37,6 +37,16 @@
> >>
> >>   #include <asm/ioctls.h>
> >>
> >> +/*
> >> + * An inotify watch requires allocating an inotify_inode_mark structure as
> >> + * well as pinning the watched inode and adding inotify fdinfo procfs file.
> > Maybe you misunderstood me.
> > There is no procfs file per watch.
> > There is a procfs file per inotify_init() fd.
> > The fdinfo of that procfile lists all the watches of that inotify instance.
> Thanks for the clarification. Yes, I probably had misunderstood you
> because of the 2 * sizeof(inode) figure you provided.
> >> + * The increase in size of a filesystem inode versus a VFS inode varies
> >> + * depending on the filesystem. An extra 512 bytes is added as rough
> >> + * estimate of the additional filesystem inode cost.
> >> + */
> >> +#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
> >> +                                2 * sizeof(struct inode) + 512)
> >> +
> > I would consider going with double the sizeof inode as rough approximation for
> > filesystem inode size.
> >
> > It is a bit less arbitrary than 512 and it has some rationale behind it -
> > Some kernel config options will grow struct inode (debug, smp)
> > The same config options may also grow the filesystem part of the inode.
> >
> > And this approximation can be pretty accurate at times.
> > For example, on Ubuntu 18.04 kernel 5.4.0:
> > inode_cache        608
> > nfs_inode_cache      1088
> > btrfs_inode            1168
> > xfs_inode              1024
> > ext4_inode_cache   1096
>
> Just to clarify, is your original 2 * sizeof(struct inode) figure
> include the filesystem inode overhead or there is an additional inode
> somewhere that I needs to go to 4 * sizeof(struct inode)?

No additional inode.

#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
                                                      2 * sizeof(struct inode))

Not sure if the inotify_inode_mark part matters, but it doesn't hurt.
Do note that Jan had a different proposal for fs inode size estimation (1K).
I have no objection to this estimation if Jan insists.

Thanks,
Amir.
