Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7711F8C37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 04:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgFOCMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFOCMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:12:41 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F87C061A0E;
        Sun, 14 Jun 2020 19:12:41 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id p187so3579004vkf.0;
        Sun, 14 Jun 2020 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iYIc1GtcJcRXPwfn7gCIOBfRVhZCjIN8kGdtKPHSdEo=;
        b=dK8zn/XjVSy/XYM2vM/gZEhYIZFcTKieRAV4HUqScvi41xvbLYYYlhKeZQApBd3LU7
         DHIl9dJtfE0BxBIkWLuXZ9eF3BDaNipKUdvDYMOSEldlkpEcrcpiD5u0sDM2PUNs+rVT
         a8EZU6EdX3028CeVyT3C6XfmsdSR4u5mVMQOZkvM/jneN0Khp5LIOS4pq2YjQoZecfEp
         Ek9XJLAYYdeTzJhHF9Ae0cURGBaKBlPXjbCV3/Rc2nDQk8ghfxiLLLaoM2u3rSZ2YHt5
         oERu0BsrEucrcxWMTZ3fIL3pV43L8dGexmuaszM84z/F5BPDz3UzaI+aal8+NDt3W244
         iQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iYIc1GtcJcRXPwfn7gCIOBfRVhZCjIN8kGdtKPHSdEo=;
        b=EzAh+CczDwu9elEHxgogXJ98Q4w0X80B8A3cWM89k/cGIOgtT+CuwQR/v5/DQmXaIs
         OcfjdIZ+RAibJoReMz1dl1czzdGRO1RLMaVZLOUtoCcrgI3kOhU3QED/jmwCq/Fps4Rr
         1qyAaTboxQ9Z8ATlBmxcRX6NxfMl4SGDkQBPPxmVY0p5oxeJ8ts/1F6VxRO0A+l4xrLl
         SxhBSXOBCf0pVVxYZg55SsW91kJG+YEVEAg1jDpK6pU24RdcssW8Aa/jvZ5URqFU2owY
         st/nItD6deWkydmHYuueHysj1pythYQEMeRqsJnwCdPb617o2H5Fsqm9JWrYvFTCHUKK
         orzw==
X-Gm-Message-State: AOAM533fvoGLqhNGSgKuiGuoPcSivjICKHGSS/jH/pfjrqGaaMvIVlWP
        w2QNwoLOb0nMcjRsNbkfZ9FzCxq5PwC4PDzTPE+5H3n+
X-Google-Smtp-Source: ABdhPJxmrUGqb0JHvGzVK9NhCq69idT6w4JzCQwq5WNKKTxmNOdgCtNhF7GNZTCsGg3Y6Fu7na666VqlMfNF2L1u5gA=
X-Received: by 2002:ac5:c801:: with SMTP id y1mr16475680vkl.82.1592187160826;
 Sun, 14 Jun 2020 19:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200612094250.9347-1-hyc.lee@gmail.com> <CGME20200612094318epcas1p30139d60fdcfc3672fede8977c536a5a8@epcas1p3.samsung.com>
 <20200612094250.9347-2-hyc.lee@gmail.com> <001501d642aa$8699aca0$93cd05e0$@samsung.com>
In-Reply-To: <001501d642aa$8699aca0$93cd05e0$@samsung.com>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Mon, 15 Jun 2020 11:12:25 +0900
Message-ID: <CANFS6bYW8AiaQRS+o9b5VNThyRiHinvGsK6bpuamh0GuDb7z3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] exfat: allow to change some mount options for remount
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 9:18, N=
amjae Jeon <namjae.jeon@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > Allow to change permission masks, allow_utime, errors. But ignore other=
 options.
> >
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> > ---
> >  fs/exfat/super.c | 40 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/exfat/super.c b/fs/exfat/super.c index 61c6cf240c19..3c=
1d47289ba2 100644
> > --- a/fs/exfat/super.c
> > +++ b/fs/exfat/super.c
> > @@ -696,9 +696,13 @@ static void exfat_free(struct fs_context *fc)  sta=
tic int
> > exfat_reconfigure(struct fs_context *fc)  {
> >       struct super_block *sb =3D fc->root->d_sb;
> > +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > +     struct exfat_mount_options *new_opts;
> >       int ret;
> >       bool new_rdonly;
> >
> > +     new_opts =3D &((struct exfat_sb_info *)fc->s_fs_info)->options;
> > +
> >       new_rdonly =3D fc->sb_flags & SB_RDONLY;
> >       if (new_rdonly !=3D sb_rdonly(sb)) {
> >               if (new_rdonly) {
> > @@ -708,6 +712,12 @@ static int exfat_reconfigure(struct fs_context *fc=
)
> >                               return ret;
> >               }
> >       }
> > +
> > +     /* allow to change these options but ignore others */
> > +     sbi->options.fs_fmask =3D new_opts->fs_fmask;
> > +     sbi->options.fs_dmask =3D new_opts->fs_dmask;
> > +     sbi->options.allow_utime =3D new_opts->allow_utime;
> > +     sbi->options.errors =3D new_opts->errors;
> Is there any reason why you allow a few options on remount ?

while exfat is remounted, inodes are not reclaimed. So I think
changing fs_uid, fs_gid, or time_offset is not impossible.
And I am not sure changing the iocharset is safe.

I am curious about your opinion.

Thanks.


> >       return 0;
> >  }
> >
> > @@ -726,17 +736,25 @@ static int exfat_init_fs_context(struct fs_contex=
t *fc)
> >       if (!sbi)
> >               return -ENOMEM;
> >
> > -     mutex_init(&sbi->s_lock);
> > -     ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
> > -                     DEFAULT_RATELIMIT_BURST);
> > -
> > -     sbi->options.fs_uid =3D current_uid();
> > -     sbi->options.fs_gid =3D current_gid();
> > -     sbi->options.fs_fmask =3D current->fs->umask;
> > -     sbi->options.fs_dmask =3D current->fs->umask;
> > -     sbi->options.allow_utime =3D -1;
> > -     sbi->options.iocharset =3D exfat_default_iocharset;
> > -     sbi->options.errors =3D EXFAT_ERRORS_RO;
> > +     if (fc->root) {
> > +             /* reconfiguration */
> > +             memcpy(&sbi->options, &EXFAT_SB(fc->root->d_sb)->options,
> > +                     sizeof(struct exfat_mount_options));
> > +             sbi->options.iocharset =3D exfat_default_iocharset;
> > +     } else {
> > +             mutex_init(&sbi->s_lock);
> > +             ratelimit_state_init(&sbi->ratelimit,
> > +                             DEFAULT_RATELIMIT_INTERVAL,
> > +                             DEFAULT_RATELIMIT_BURST);
> > +
> > +             sbi->options.fs_uid =3D current_uid();
> > +             sbi->options.fs_gid =3D current_gid();
> > +             sbi->options.fs_fmask =3D current->fs->umask;
> > +             sbi->options.fs_dmask =3D current->fs->umask;
> > +             sbi->options.allow_utime =3D -1;
> > +             sbi->options.iocharset =3D exfat_default_iocharset;
> > +             sbi->options.errors =3D EXFAT_ERRORS_RO;
> > +     }
> >
> >       fc->s_fs_info =3D sbi;
> >       fc->ops =3D &exfat_context_ops;
> > --
> > 2.17.1
>
>
