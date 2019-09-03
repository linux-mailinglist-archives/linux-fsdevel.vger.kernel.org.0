Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C324A64E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfICJRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 05:17:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38642 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfICJRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:17:49 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so34310673iog.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuENc7crj8rqhon/s/3YCSFArTMbg3aHshy4WFfnKAI=;
        b=Od7NQm+xjFA01cLuFmHtQg+5TCm8UxKX2tGkiw8Mr4ix+wsAC5OqGe+z4RAxvjqQg/
         hOmmsMGgfL9ALOuzShRamJV28nj5bc9nAX+IVwfcCIvdcYByCAo2CXCt3AMWA49czLno
         sGMa721iOqpXpP31sm3p2t8tpiPNVDM2tg89o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuENc7crj8rqhon/s/3YCSFArTMbg3aHshy4WFfnKAI=;
        b=Nd8PkkXknraBTxqbczoQ44HdtaInheaqMLkrYKJoXg8xSLFURichaSukMt/fyInnUC
         ZJep7gm4hVNYtbrF05MtfVFfv5jhSOsKDaqPDV+IZgKvUs6EeRCQzE1RhtcYO9MVXXkk
         aM3Ln2zDiQj76clqJ/FCdxWAKa3Mj459a89VYicRh91jOtpwhTHKGbdOQAqqT1Vpr/YW
         nkl+NLH6XKcYKXp+qqU2ERejTanE+R0WjXfRcYoCxIU3Xd/0BcmaRnTXiJONAcgK9+6Y
         o7tgvV2amC+FZK99pAB1hetOpGJXA35nSYCPjeBmqIVC9NuWqDK3kwp7g8gWSUQuFIwA
         850w==
X-Gm-Message-State: APjAAAXjagy4HJmQrU/J/WVpYJcoNNNZrL9iPb6GHyPu1FNPuvkaG8IK
        HheGfB/1kpcPo2X2/reK2K9VKNoXvIxVE5rFygpYPg==
X-Google-Smtp-Source: APXvYqzSAqgiAZOGqKdxa2ybdBypwTKeZ7jt6jzTE8fFeVXwQ2aRbTvX6cO5BVl/b39XJh9PglydDRoEYuNDaq5h9II=
X-Received: by 2002:a02:c94b:: with SMTP id u11mr34398002jao.35.1567502266965;
 Tue, 03 Sep 2019 02:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190903041507-mutt-send-email-mst@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Sep 2019 11:17:35 +0200
Message-ID: <CAJfpeguB6fFhghuFS420ZQ+JuQvTLc5TgsGjoB_RvFrSVf+v5w@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 3, 2019 at 10:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> Can the patches themselves be posted to the relevant list(s) please?
> If possible, please also include "v3" in all patches so they are
> easier to find.

I'll post a v4.

> I poked at
> https://lwn.net/ml/linux-kernel/20190821173742.24574-1-vgoyal@redhat.com/
> specifically
> https://lwn.net/ml/linux-kernel/20190821173742.24574-12-vgoyal@redhat.com/
> and things like:
> +       /* TODO lock */
> give me pause.
>
> Cleanup generally seems broken to me - what pauses the FS
>
> What about the rest of TODOs in that file?

AFAICS, some of those are QOI issues, and some are long term
performance items.  I see no blockers or things that would pose a
security concern.

That said, it would be nice to get rid of them at some point.

> use of usleep is hacky - can't we do better e.g. with a
> completion?

Yes.  I have a different implementation, but was planning to leave
this one in until the dust settles.

> Some typos - e.g. "reuests".

Fixed.

> > >  fs/fuse/Kconfig                 |   11 +
> > >  fs/fuse/Makefile                |    1 +
> > >  fs/fuse/control.c               |    4 +-
> > >  fs/fuse/cuse.c                  |    4 +-
> > >  fs/fuse/dev.c                   |   89 ++-
> > >  fs/fuse/dir.c                   |   26 +-
> > >  fs/fuse/file.c                  |   15 +-
> > >  fs/fuse/fuse_i.h                |  120 +++-
> > >  fs/fuse/inode.c                 |  203 +++---
> > >  fs/fuse/virtio_fs.c             | 1061 +++++++++++++++++++++++++++++++
> > >  fs/splice.c                     |    3 +-
> > >  include/linux/fs.h              |    2 +
> > >  include/uapi/linux/virtio_fs.h  |   41 ++
> > >  include/uapi/linux/virtio_ids.h |    1 +
> > >  init/do_mounts.c                |   10 +
> > >  15 files changed, 1462 insertions(+), 129 deletions(-)
> > >  create mode 100644 fs/fuse/virtio_fs.c
> > >  create mode 100644 include/uapi/linux/virtio_fs.h
>
> Don't the new files need a MAINTAINERS entry?
> I think we want virtualization@lists.linux-foundation.org to be
> copied.

Yep.

Stefan, do you want to formally maintain this file?

Thanks,
Miklos
