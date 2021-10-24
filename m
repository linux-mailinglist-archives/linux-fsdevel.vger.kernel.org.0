Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6ED4389D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJXPc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJXPcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:32:55 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76219C061745
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Oct 2021 08:30:34 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h20so3149215ila.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Oct 2021 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SmDlj5YKjmNCKnX86fc+9EqQcx4KoxCiTPcHywA2dU=;
        b=Gmb1BPsW7Jhx1ToE3SbC5X5lDh2KU2T3DaaTDrJvecMT3h97k/j4YpekeM7EZVDDzK
         ffCC6bMXVElD+9I3xNRYZIurQlxeBQeiGwtBvCxmh8hznJsdrUfChkTdo3U0S5XpyvpT
         Xlqj86vIOno2W6cSHw29FjlXFxanGdBK9EI3b82yzB6EeNXdpWMvmpvdonI8klInjwxv
         ME++T0z7OcMlP5KbIlYltTHbhiKA8tfJZ+2hen4AmVpcKHNk0p0lXQSJRo+YdFbmhrJ7
         rnEynApl7czXiFyckSkgS/vYsNHepyseCP6lQZWa9hI68yfpxCs3EzLBjbGZXF3+WTFm
         lKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SmDlj5YKjmNCKnX86fc+9EqQcx4KoxCiTPcHywA2dU=;
        b=pnyIJQAZo1SNaqcIAhELw3/+LdYWqeWFCeImjlDJiBwbbkBVbayoHhe9VbWofSeZ41
         ONY2QLQiJegeQqIHhTXTpp3uqVCrG3JWP6huo0umeDJogo6Cn+ouZSVoNTFDqP6uSuvZ
         pbJzEMqXhuYZT7W5SjTo1dverD2aWaXVYLZpGwvnIWzJaRe7FqwM+jY9Bvu6CVXr2Dv8
         s/dCi+p9Q7pw1CksJw+jo/qEBS8rItoU+BYuQz4ovYY96Ul/BKFxA8KC2lywwxloBcWs
         yT5k5gvV3fyG/ZjhOle3kKvSkT2sMtlj8y4HnNCNgIOjFQnw8bNKIfAwzCxkA7Fs6Xmk
         Lb3w==
X-Gm-Message-State: AOAM532nf8dKBq4qgqmpOcw2Rlo6pehGyMNoxmXlVw1vjIbs2U3rkBQv
        27d8p4pED27NHlEj+7cxeQmWJsg4TGfp6DDhrbxd1keV+mc=
X-Google-Smtp-Source: ABdhPJzAtIUzqRh0346cKhycb1va3vQgh5IGO5+C5zVuAmk8FnL4V5tTf1itBSL2YQObQ/Dx01r0IqxP4rV9zNQ3k14=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr1845159ilu.198.1635089433461;
 Sun, 24 Oct 2021 08:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211024132607.1636952-1-amir73il@gmail.com> <YXVltvcDKNCqodJz@lpc>
 <CAOQ4uxjV2LXvu0kiLuDR_kvgHxLcwPCT1Y5NyD6aaMWrwg1EiQ@mail.gmail.com> <YXV4/u4iryv/sXFX@lpc>
In-Reply-To: <YXV4/u4iryv/sXFX@lpc>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Oct 2021 18:30:22 +0300
Message-ID: <CAOQ4uxjq-HBRQ8DFNTnRobtmAOi6kKs-1WTXeoik_x=_=QDa2g@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_NOFLUSH
To:     Shachar Sharon <synarete@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 24, 2021 at 6:17 PM Shachar Sharon <synarete@gmail.com> wrote:
>
> On Sun, Oct 24, 2021 at 05:21:55PM +0300, Amir Goldstein wrote:
> >On Sun, Oct 24, 2021 at 4:55 PM Shachar Sharon <synarete@gmail.com> wrote:
> >>
> >> On Sun, Oct 24, 2021 at 04:26:07PM +0300, Amir Goldstein wrote:
> >> >Add flag returned by OPENDIR request to avoid flushing data cache
> >> >on close.
> >> >
> >> I believe this holds not only for FUSE_OPENDIR but also to FUSE_OPEN and
> >> FUSE_CREATE (see 'struct fuse_open_out').
> >>
> >
> >Oops that was a copy&paste typo.
> >Of course this is only relevant for FUSE_OPEN and FUSE_CREATE.
> IMHO it is relevant to all 3 cases (FUSE_OPEN, FUSE_CREATE,
> FUSE_OPENDIR).
>

fuse_dir_operations have no ->flush() as there is no write cache for
directories.

>
> >
> >> >Different filesystems implement ->flush() is different ways:
> >> >- Most disk filesystems do not implement ->flush() at all
> >> >- Some network filesystem (e.g. nfs) flush local write cache of
> >> >  FMODE_WRITE file and send a "flush" command to server
> >> >- Some network filesystem (e.g. cifs) flush local write cache of
> >> >  FMODE_WRITE file without sending an additional command to server
> >> >
> >> >FUSE flushes local write cache of ANY file, even non FMODE_WRITE
> >> >and sends a "flush" command to server (if server implements it).
> >> >
> >> >The FUSE implementation of ->flush() seems over agressive and
> >> >arbitrary and does not make a lot of sense when writeback caching is
> >> >disabled.
> >> >
> >> >Instead of deciding on another arbitrary implementation that makes
> >> >sense, leave the choice of per-file flush behavior in the hands of
> >> >the server.
> >> >
> >> >Link: https://lore.kernel.org/linux-fsdevel/CAJfpegspE8e6aKd47uZtSYX8Y-1e1FWS0VL0DH2Skb9gQP5RJQ@mail.gmail.com/
> >> >Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> >> >Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >> >---
> >> >
> >> >Hi Miklos,
> >> >
> >> >I've tested this manually by watching --debug-fuse prints
> >> >with and without --nocache option to passthrough_hp.
> >> >
> >> >The libfuse+passthrough_hp patch is at:
> >> >https://github.com/amir73il/libfuse/commits/fopen_noflush
> >> >
> >> >Thanks,
> >> >Amir.
> >> >
> >> > fs/fuse/file.c            | 3 +++
> >> > include/uapi/linux/fuse.h | 3 +++
> >> > 2 files changed, 6 insertions(+)
> >> >
> >> >diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> >index 11404f8c21c7..6f502a76f9ac 100644
> >> >--- a/fs/fuse/file.c
> >> >+++ b/fs/fuse/file.c
> >> >@@ -483,6 +483,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
> >> >       if (fuse_is_bad(inode))
> >> >               return -EIO;
> >> >
> >> >+      if (ff->open_flags & FOPEN_NOFLUSH)
> >> >+              return 0;
> >> >+
> >> >       err = write_inode_now(inode, 1);
> >> >       if (err)
> >> >               return err;
> >> >diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >> >index 36ed092227fa..383781d1878f 100644
> >> >--- a/include/uapi/linux/fuse.h
> >> >+++ b/include/uapi/linux/fuse.h
> >> >@@ -184,6 +184,7 @@
> >> >  *
> >> >  *  7.34
> >> >  *  - add FUSE_SYNCFS
> >> Most likely you want to bump to 7.35; 7.34 is already out in the wild
> >> (e.g., on my Fedora33 workstation)
> >>
> >
> >Possibly. I wasn't sure what was the rationale behind when the version
> >should be bumped.
> >One argument against bumping the version is that there is not much
> >harm is passing this flag to an old kernel - it just ignored the flag
> >and sends the flush requests anyway.

Miklos, do I need to bump the protocol version?

Thanks,
Amir.
