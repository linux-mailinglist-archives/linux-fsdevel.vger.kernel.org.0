Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB91A4E4AC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 03:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiCWCP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 22:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiCWCP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:15:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA7170051
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 19:14:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c62so225984edf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=idUzTCY2AERtw5ZBkeYLX/VSx9T6HCNSjT0d5uQ1/lg=;
        b=DbGSpN9iikAnUob2Ygn9PbSpg9I0UAGIlM2wyiilOXi+bxpnAfWZst/xE/bZ/G/8mQ
         F1/WuGLLKEY8wirInPTAkTDhyk6txrbKwE81IMUAwE8H0hfh9YYYSiNljgOUJvz+W4PZ
         /3Rnk/5HhhAffQt8Pa/03B1mRW94/ThbBslqKhpt0Y/4JrJC042AA4gIYLUnnGMHIr8U
         F4tqKrgih2817Ea2bTsBsA5gI0KORq1f7I1V4yuxWfyFrYD8XAC7XK+ajoXQeHFl3qie
         pk92VJABw/vyRCRsyJhaEwtu5VH+ZZYOyh7CuhZz5sKF3flnb1ZJM2x/pwtRTxRHn7jj
         emDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=idUzTCY2AERtw5ZBkeYLX/VSx9T6HCNSjT0d5uQ1/lg=;
        b=ZIUm571G6b++Emu1UafQFVUoBJYA/Oexr3Kj8QM9ITC+ywtKQpqNufbWRApSbj89Tt
         P0Z8gB1aTkF9ryjicZbogiIOLjoEE/WeakaSenf5UIET65hdbgWz/fcn44ip6xPyqmKI
         Mv3JoI8ZYgcFpcaWhoSTkIhOVT/mHWkLuFo/OBcfbSG0VNdztcw6KnaKoa9VT1vtUkQe
         lr69YqaSXqDxXzTax2Kwn2uwhbF0Qx4HEEGIugGLskv66+iaZPwScEiFaBZuIcdJTd3/
         EHdV9Y7eHU95epy5xnsvo4By9yEZQQ/tFJcCsndt9+oZQC3FtEyb6tnHWY48EwNau+42
         Dxyw==
X-Gm-Message-State: AOAM533ssFnH9TUO08efh1Pf6kYoJgiUASkRCe2xpnClRS3+nw4Boghp
        RvDTI76VGsSdFb+yPYgF8znq5dBmm3UOAI/IsZValBmhN93mAg==
X-Google-Smtp-Source: ABdhPJyQZhlRi+f+e8qcEN8G0OieaQktNeW0NSlYx0VWHDVixFAkS/V91NxMtr4yDiAlqaPNmvDn/0lCCQB1snn8PBA=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr8218344edd.405.1648001665583; Tue, 22
 Mar 2022 19:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220321095814.175891-1-cccheng@synology.com> <20220321095814.175891-2-cccheng@synology.com>
 <87lex2e91h.fsf@mail.parknet.co.jp>
In-Reply-To: <87lex2e91h.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Wed, 23 Mar 2022 10:14:14 +0800
Message-ID: <CAHuHWtkvt4wOdwaoyYv0B4862pSYttMBh6BUz3vHbERv+CEGaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fat: introduce creation time
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> =E6=96=BC 2022=E5=B9=B43=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Chung-Chiang Cheng <cccheng@synology.com> writes:
>
> > In the old days, FAT supports creation time, but there's no correspondi=
ng
> > timestamp in VFS. The implementation mixed the meaning of change time a=
nd
> > creation time into a single ctime field.
> >
> > This patch introduces a new field for creation time, and reports it in
> > statx. The original ctime doesn't stand for create time any more. All
> > the behaviors of ctime (change time) follow mtime, as exfat does.
>
> Yes, ctime is issue (include compatibility issue when changing) from
> original author of this driver. And there is no perfect solution and
> subtle issue I think.
>
> I'm not against about this change though, this behavior makes utimes(2)
> behavior strange, e.g. user can change ctime, but FAT forget it anytime,
> because FAT can't save it.
>
> Did you consider about those behavior and choose this?

Yes. I think it's not perfect but a better choice to distinguish between
change-time and creation-time. While change-time is no longer saved to
disk, the new behavior maintains the semantic of "creation" and is more
compatible with non-linux systems.

Thanks.

> Thanks.
>
> > Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> > ---
> >  fs/fat/fat.h   |  1 +
> >  fs/fat/file.c  |  6 ++++++
> >  fs/fat/inode.c | 15 ++++++++++-----
> >  fs/fat/misc.c  |  6 +++---
> >  4 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> > index 508b4f2a1ffb..e4409ee82ea9 100644
> > --- a/fs/fat/fat.h
> > +++ b/fs/fat/fat.h
> > @@ -126,6 +126,7 @@ struct msdos_inode_info {
> >       struct hlist_node i_fat_hash;   /* hash by i_location */
> >       struct hlist_node i_dir_hash;   /* hash by i_logstart */
> >       struct rw_semaphore truncate_lock; /* protect bmap against trunca=
te */
> > +     struct timespec64 i_crtime;     /* File creation (birth) time */
> >       struct inode vfs_inode;
> >  };
> >
> > diff --git a/fs/fat/file.c b/fs/fat/file.c
> > index 13855ba49cd9..184fa0375152 100644
> > --- a/fs/fat/file.c
> > +++ b/fs/fat/file.c
> > @@ -405,6 +405,12 @@ int fat_getattr(struct user_namespace *mnt_userns,=
 const struct path *path,
> >               /* Use i_pos for ino. This is used as fileid of nfs. */
> >               stat->ino =3D fat_i_pos_read(MSDOS_SB(inode->i_sb), inode=
);
> >       }
> > +
> > +     if (request_mask & STATX_BTIME) {
> > +             stat->result_mask |=3D STATX_BTIME;
> > +             stat->btime =3D MSDOS_I(inode)->i_crtime;
> > +     }
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(fat_getattr);
> > diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> > index a6f1c6d426d1..41b85b95ee9d 100644
> > --- a/fs/fat/inode.c
> > +++ b/fs/fat/inode.c
> > @@ -566,12 +566,15 @@ int fat_fill_inode(struct inode *inode, struct ms=
dos_dir_entry *de)
> >                          & ~((loff_t)sbi->cluster_size - 1)) >> 9;
> >
> >       fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
> > +     inode->i_ctime =3D inode->i_mtime;
> >       if (sbi->options.isvfat) {
> > -             fat_time_fat2unix(sbi, &inode->i_ctime, de->ctime,
> > -                               de->cdate, de->ctime_cs);
> >               fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> > -     } else
> > -             fat_truncate_time(inode, &inode->i_mtime, S_ATIME|S_CTIME=
);
> > +             fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->cti=
me,
> > +                               de->cdate, de->ctime_cs);
> > +     } else {
> > +             fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime)=
;
> > +             fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)=
->i_crtime);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -756,6 +759,8 @@ static struct inode *fat_alloc_inode(struct super_b=
lock *sb)
> >       ei->i_logstart =3D 0;
> >       ei->i_attrs =3D 0;
> >       ei->i_pos =3D 0;
> > +     ei->i_crtime.tv_sec =3D 0;
> > +     ei->i_crtime.tv_nsec =3D 0;
> >
> >       return &ei->vfs_inode;
> >  }
> > @@ -887,7 +892,7 @@ static int __fat_write_inode(struct inode *inode, i=
nt wait)
> >                         &raw_entry->date, NULL);
> >       if (sbi->options.isvfat) {
> >               __le16 atime;
> > -             fat_time_unix2fat(sbi, &inode->i_ctime, &raw_entry->ctime=
,
> > +             fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_en=
try->ctime,
> >                                 &raw_entry->cdate, &raw_entry->ctime_cs=
);
> >               fat_time_unix2fat(sbi, &inode->i_atime, &atime,
> >                                 &raw_entry->adate, NULL);
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index c87df64f8b2b..36b6da6461cc 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -341,10 +341,10 @@ int fat_truncate_time(struct inode *inode, struct=
 timespec64 *now, int flags)
> >
> >       if (flags & S_ATIME)
> >               fat_truncate_atime(sbi, now, &inode->i_atime);
> > -     if (flags & S_CTIME)
> > -             fat_truncate_crtime(sbi, now, &inode->i_ctime);
> > -     if (flags & S_MTIME)
> > +     if (flags & (S_CTIME | S_MTIME)) {
> >               fat_truncate_mtime(sbi, now, &inode->i_mtime);
> > +             inode->i_ctime =3D inode->i_mtime;
> > +     }
> >
> >       return 0;
> >  }
>
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
