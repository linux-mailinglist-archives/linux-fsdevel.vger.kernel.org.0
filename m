Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4130154C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 13:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbhAWMzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jan 2021 07:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbhAWMzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:55:08 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C91C06174A;
        Sat, 23 Jan 2021 04:54:27 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h11so16859054ioh.11;
        Sat, 23 Jan 2021 04:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFLJjQ6GqDf6idhlAi7eZoIx97QCRlqrFdGfzJJ1rlI=;
        b=d4CXAsK3TvxYJlbIcevCNHu7IncLMYzngiUYcUXsK05J5OX96uHRlBJ1A01TVAaI37
         KBKIu6cqZ4xwU2bf0SB0n7Rywn72a0mpRGAQTcecM89BFWPMP9ZONZj6MguRXDSEeqNj
         ZXFSN035Exc35JzeVJbEVwK094uyaRh6BapOMIvxscm9bGrPBFJr+spIgsd9A0cdpsCj
         T5qWKF4gJrFEbDj4nsGb5K8GlrERjp+RFlkPaEMD3wqme5+O5B7wZGeeFpEUzmZm+utV
         IdatRNqpESnsLPxPZkawPFme6J0kAAOxKZDUkES2xZ1VMH9cTOFbd7KQv6IilJq1gL2w
         ppaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFLJjQ6GqDf6idhlAi7eZoIx97QCRlqrFdGfzJJ1rlI=;
        b=g4dd5rDpOkz4YaCLAJUupjlnrX6D0fe3czgtCHUp+Ye9IjTfVFvEnSLnrTY4ifWa7H
         xn1DdP/01Otm5FXuBQ2bxVwKPjvqRbNJoc6kfLng/8NaZht1p0eD/d8pyVBZD5d995TD
         wDO49FOLaHl8sn7LromVkq0yCqXNwMW7+qZ4gDF7rAJiyq3Qf0HIoggKVdr/bqO3gzol
         lt/08zohCRQIgpwsGwuI0wmBe9xEiee+4ct7rCP8me0cj1gMpv/iXmSiOWvWbUu9JYfY
         HscNkLrgfH7nXDQ/OA2p7TmULnWKy9AmKpK+8IMBuIHcfKiUWCuk/DvDb9yeGj+B532E
         oJ8g==
X-Gm-Message-State: AOAM5337LWMbYGxRIcd7hgO7FJF/3W98H1CgA/Tpiq1bIgHpCxbBnogI
        IjsywPv5BPtcXnFQwtJWv2gJ6ZPFzzlfvuwNFS6yuZICqoo=
X-Google-Smtp-Source: ABdhPJyF0PNGZ5r9X5aqDEIxp+y5yAC+gKMzkLKLPeF951kWCaM6ULxT2iKCgI6cCObRKCk9ec4QF7X3FnRTOMRbZRQ=
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr388035ilj.250.1611406467216;
 Sat, 23 Jan 2021 04:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20201130030039.596801-1-sargun@sargun.me> <CAMp4zn-c6gOPTPBqqkPoQi3NVeZ0yW-WfVPFzpDiazj8PeUgBw@mail.gmail.com>
 <CAOQ4uxhU=eWAfTn8DJ7x4NZ2PO9Q9V7Ohpj9aTasXg3KcfFpMA@mail.gmail.com>
 <CAMp4zn9sdpk1A1hYpDjS_774UscYZ1sztCsLdfshs=pXEYf0NQ@mail.gmail.com> <CAJfpeguLFoLD8BYuNAAwV+F0583aujNBqto3QnFjeV+z4LszDA@mail.gmail.com>
In-Reply-To: <CAJfpeguLFoLD8BYuNAAwV+F0583aujNBqto3QnFjeV+z4LszDA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Jan 2021 14:54:16 +0200
Message-ID: <CAOQ4uxg=H46mVHeXFN-Sjd85TKRFawe0ZDqossg_Hn8BULWHkw@mail.gmail.com>
Subject: Re: [PATCH] overlay: Plumb through flush method
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 5:24 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Dec 3, 2020 at 7:32 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > On Thu, Dec 3, 2020 at 2:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Dec 3, 2020 at 12:16 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > > >
> > > > On Sun, Nov 29, 2020 at 7:00 PM Sargun Dhillon <sargun@sargun.me> wrote:
> > > > >
> > > > > Filesystems can implement their own flush method that release
> > > > > resources, or manipulate caches. Currently if one of these
> > > > > filesystems is used with overlayfs, the flush method is not called.
> > > > >
> > > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > > Cc: linux-fsdevel@vger.kernel.org
> > > > > Cc: linux-unionfs@vger.kernel.org
> > > > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  fs/overlayfs/file.c | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > > > index efccb7c1f9bc..802259f33c28 100644
> > > > > --- a/fs/overlayfs/file.c
> > > > > +++ b/fs/overlayfs/file.c
> > > > > @@ -787,6 +787,16 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
> > > > >                             remap_flags, op);
> > > > >  }
> > > > >
> > > > > +static int ovl_flush(struct file *file, fl_owner_t id)
> > > > > +{
> > > > > +       struct file *realfile = file->private_data;
> > > > > +
> > > > > +       if (realfile->f_op->flush)
> > > > > +               return realfile->f_op->flush(realfile, id);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  const struct file_operations ovl_file_operations = {
> > > > >         .open           = ovl_open,
> > > > >         .release        = ovl_release,
> > > > > @@ -798,6 +808,7 @@ const struct file_operations ovl_file_operations = {
> > > > >         .fallocate      = ovl_fallocate,
> > > > >         .fadvise        = ovl_fadvise,
> > > > >         .unlocked_ioctl = ovl_ioctl,
> > > > > +       .flush          = ovl_flush,
> > > > >  #ifdef CONFIG_COMPAT
> > > > >         .compat_ioctl   = ovl_compat_ioctl,
> > > > >  #endif
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > Amir, Miklos,
> > > > Is this acceptable? I discovered this being a problem when we had the discussion
> > > > of whether the volatile fs should return an error on close on dirty files.
> > >
> > > Yes, looks ok.
> > > Maybe we want to check if the realfile is upper although
> > > maybe flush can release resources also on read only fs?
> > >
> > > >
> > > > It seems like it would be useful if anyone uses NFS, or CIFS as an upperdir.
> > >
> > > They are not supported as upperdir. only FUSE is.
> > >
> > > Thanks,
> > > Amir.
> >
> > VFS does it on read-only files / mounts, so we should probably do the
> > same thing.
>
> Right, but it should handle files copied up after the oipen (i.e. call
> ovl_real_fdget() to get the real file).
>

Applied patch is missing fdput() xfstests fail.
Following tested fix.

Thanks,
Amir.

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -693,12 +693,17 @@ static int ovl_flush(struct file *file, fl_owner_t id)
        int err;

        err = ovl_real_fdget(file, &real);
-       if (!err && real.file->f_op->flush) {
+       if (err)
+               return err;
+
+       if (real.file->f_op->flush) {
                old_cred = ovl_override_creds(file_inode(file)->i_sb);
                err = real.file->f_op->flush(real.file, id);
                revert_creds(old_cred);
        }

+       fdput(real);
+
        return err;
 }
