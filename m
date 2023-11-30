Return-Path: <linux-fsdevel+bounces-4375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20987FF279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEA1C20DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0651006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0YrHbGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87E1B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 04:42:42 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a2c4e61abso4132896d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701348161; x=1701952961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZhaaIFVtZJRpamdALhxFr4KaIQj0nLVmsqXZ+pZ9ks=;
        b=j0YrHbGwydAG89yHR14Mhsj817D/7TZ5z9mKRccK6wHZEPA7fyAe7M8SEA4IWi9Npb
         eD44lyZbeW1K2RGajwGPbVt8NQgKlWMyAel31cw9zhvrWCNzJ4C7e+u93JN/KUPW+wOP
         1mKyF06h4s68hxGBDSOi2baL2wadPSI2MSiOQXQfNNoYSpZw2cu+jIyjnJQhqWxzd9OK
         YFe7sYen37LM4dQltOuWh6TooRHg0LGsDf3St8Bia3jHNzWeaOD3efjANz91JMQwZ1mi
         x7S0kGZjRdeiz8H0gpcbcvgSX4741lEE2IWf2TbsfH8kjvKBjxZuzuOvz2tv2Gyus/lj
         4itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701348161; x=1701952961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZhaaIFVtZJRpamdALhxFr4KaIQj0nLVmsqXZ+pZ9ks=;
        b=WW2jc8zBBF/CCo2kLeFk7DObanhCQp8ccifB37HKaagWv8hilESiYKF3itZj663anN
         un0p2fr76wc62YezRmJOYkZSBKpm2kOUzObspG8BtfDTE1Rn3g44HxU0Va7SU8AXZ7ag
         ybDWaYL2Z7KDEPxrtyKbAPeOe0RPe67R29f94NmXqxhUe1jih+Jr/41tWtvW6ZMxm0RC
         GXttRzTulUFW13lWcqO+Fg7eGisTJHNRWofVv2vqRzCva2I0Q7vPpThApDwwK/3UlMZ/
         Ey6NApFkFA6MZ7k1xauPOLpf4REG1SFix/vsdn9sW3adir+XIafyigBUIrsfKDJopoRY
         9YfQ==
X-Gm-Message-State: AOJu0Yy2gWM/CM394xifgC3N1Y51ltCXyeKHfDt2TLcwxKe/F96psGM7
	Jr3ndrKxWQpBdBM5au5eTUMBsZHwikWy3FgQWhI=
X-Google-Smtp-Source: AGHT+IFVTE/PYbw8dJqozodC0nyvgJM+8A7q2Q5dMB3lIbLbfRmJXy8H4KN996GyC34kzPPkqqolXUSvC28omGwoYkU=
X-Received: by 2002:a0c:ed47:0:b0:67a:27c4:31f9 with SMTP id
 v7-20020a0ced47000000b0067a27c431f9mr19108949qvq.11.1701348160959; Thu, 30
 Nov 2023 04:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118183018.2069899-1-amir73il@gmail.com> <20231118183018.2069899-3-amir73il@gmail.com>
 <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com> <CAOQ4uxgfyAcD_pZ8egQuEoiNstgrD8E0YPDps5Am=St9jY6rXw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgfyAcD_pZ8egQuEoiNstgrD8E0YPDps5Am=St9jY6rXw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 14:42:29 +0200
Message-ID: <CAOQ4uxhrPofk==ASam-uV0=JKSff=YEJm_VUuWw_PpAAi9YYFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Nov 20, 2023 at 9:42=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Sat, Nov 18, 2023 at 8:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> > > on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> > > non-uniform fsid (e.g. btrfs non-root subvol).
> > >
> > > When group is watching inodes all from the same filesystem (or subvol=
),
> > > allow adding inode marks with "weak" fsid, because there is no ambigu=
ity
> > > regarding which filesystem reports the event.
> > >
> > > The first mark added to a group determines if this group is single or
> > > multi filesystem, depending on the fsid at the path of the added mark=
.
> > >
> > > If the first mark added has a "strong" fsid, marks with "weak" fsid
> > > cannot be added and vice versa.
> > >
> > > If the first mark added has a "weak" fsid, following marks must have
> > > the same "weak" fsid and the same sb as the first mark.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.c      | 15 +----
> > >  fs/notify/fanotify/fanotify.h      |  6 ++
> > >  fs/notify/fanotify/fanotify_user.c | 97 ++++++++++++++++++++++++----=
--
> > >  include/linux/fsnotify_backend.h   |  1 +
> > >  4 files changed, 90 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanot=
ify.c
> > > index aff1ab3c32aa..1e4def21811e 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -29,12 +29,6 @@ static unsigned int fanotify_hash_path(const struc=
t path *path)
> > >                 hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
> > >  }
> > >
> > > -static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
> > > -                                      __kernel_fsid_t *fsid2)
> > > -{
> > > -       return fsid1->val[0] =3D=3D fsid2->val[0] && fsid1->val[1] =
=3D=3D fsid2->val[1];
> > > -}
> > > -
> > >  static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
> > >  {
> > >         return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
> > > @@ -851,7 +845,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct f=
snotify_iter_info *iter_info)
> > >                 if (!(mark->flags & FSNOTIFY_MARK_FLAG_HAS_FSID))
> > >                         continue;
> > >                 fsid =3D FANOTIFY_MARK(mark)->fsid;
> > > -               if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
> > > +               if (!(mark->flags & FSNOTIFY_MARK_FLAG_WEAK_FSID) &&
> > > +                   WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
> > >                         continue;
> > >                 return fsid;
> > >         }
> > > @@ -933,12 +928,8 @@ static int fanotify_handle_event(struct fsnotify=
_group *group, u32 mask,
> > >                         return 0;
> > >         }
> > >
> > > -       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
> > > +       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
> > >                 fsid =3D fanotify_get_fsid(iter_info);
> > > -               /* Racing with mark destruction or creation? */
> > > -               if (!fsid.val[0] && !fsid.val[1])
> > > -                       return 0;
> > > -       }
> > >
> > >         event =3D fanotify_alloc_event(group, mask, data, data_type, =
dir,
> > >                                      file_name, &fsid, match_mask);
> > > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanot=
ify.h
> > > index 2847fa564298..9c97ae638ac5 100644
> > > --- a/fs/notify/fanotify/fanotify.h
> > > +++ b/fs/notify/fanotify/fanotify.h
> > > @@ -504,6 +504,12 @@ static inline __kernel_fsid_t *fanotify_mark_fsi=
d(struct fsnotify_mark *mark)
> > >         return &FANOTIFY_MARK(mark)->fsid;
> > >  }
> > >
> > > +static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
> > > +                                      __kernel_fsid_t *fsid2)
> > > +{
> > > +       return fsid1->val[0] =3D=3D fsid2->val[0] && fsid1->val[1] =
=3D=3D fsid2->val[1];
> > > +}
> > > +
> > >  static inline unsigned int fanotify_mark_user_flags(struct fsnotify_=
mark *mark)
> > >  {
> > >         unsigned int mflags =3D 0;
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/=
fanotify_user.c
> > > index e3d836d4d156..1cc68ea56c17 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -23,7 +23,7 @@
> > >
> > >  #include <asm/ioctls.h>
> > >
> > > -#include "../../mount.h"
> > > +#include "../fsnotify.h"
> > >  #include "../fdinfo.h"
> > >  #include "fanotify.h"
> > >
> > > @@ -1192,11 +1192,68 @@ static bool fanotify_mark_add_to_mask(struct =
fsnotify_mark *fsn_mark,
> > >         return recalc;
> > >  }
> > >
> > > +struct fan_fsid {
> > > +       struct super_block *sb;
> > > +       __kernel_fsid_t id;
> > > +       bool weak;
> > > +};
> > > +
> > > +static int fanotify_check_mark_fsid(struct fsnotify_group *group,
> > > +                                   struct fsnotify_mark *mark,
> > > +                                   struct fan_fsid *fsid)
> > > +{
> > > +       struct fsnotify_mark_connector *conn;
> > > +       struct fsnotify_mark *old;
> > > +       struct super_block *old_sb =3D NULL;
> > > +
> > > +       *fanotify_mark_fsid(mark) =3D fsid->id;
> > > +       mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_FSID;
> > > +       if (fsid->weak)
> > > +               mark->flags |=3D FSNOTIFY_MARK_FLAG_WEAK_FSID;
> > > +
> > > +       /* First mark added will determine if group is single or mult=
i fsid */
> > > +       if (list_empty(&group->marks_list))
> > > +               return 0;
> > > +
> > > +       /* Find sb of an existing mark */
> > > +       list_for_each_entry(old, &group->marks_list, g_list) {
> > > +               conn =3D READ_ONCE(old->connector);
> > > +               if (!conn)
> > > +                       continue;
> > > +               old_sb =3D fsnotify_connector_sb(conn);
> > > +               if (old_sb)
> > > +                       break;
> > > +       }
> > > +
> > > +       /* Only detached marks left? */
> > > +       if (!old_sb)
> > > +               return 0;
> > > +
> > > +       /* Do not allow mixing of marks with weak and strong fsid */
> > > +       if ((mark->flags ^ old->flags) & FSNOTIFY_MARK_FLAG_WEAK_FSID=
)
> > > +               return -EXDEV;
> > > +
> > > +       /* Allow mixing of marks with strong fsid from different fs *=
/
> > > +       if (!fsid->weak)
> > > +               return 0;
> > > +
> > > +       /* Do not allow mixing marks with weak fsid from different fs=
 */
> > > +       if (old_sb !=3D fsid->sb)
> > > +               return -EXDEV;
> > > +
> > > +       /* Do not allow mixing marks from different btrfs sub-volumes=
 */
> > > +       if (!fanotify_fsid_equal(fanotify_mark_fsid(old),
> > > +                                fanotify_mark_fsid(mark)))
> > > +               return -EXDEV;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_g=
roup *group,
> > >                                                    fsnotify_connp_t *=
connp,
> > >                                                    unsigned int obj_t=
ype,
> > >                                                    unsigned int fan_f=
lags,
> > > -                                                  __kernel_fsid_t *f=
sid)
> > > +                                                  struct fan_fsid *f=
sid)
> > >  {
> > >         struct ucounts *ucounts =3D group->fanotify_data.ucounts;
> > >         struct fanotify_mark *fan_mark;
> > > @@ -1225,8 +1282,9 @@ static struct fsnotify_mark *fanotify_add_new_m=
ark(struct fsnotify_group *group,
> > >
> > >         /* Cache fsid of filesystem containing the marked object */
> > >         if (fsid) {
> > > -               fan_mark->fsid =3D *fsid;
> > > -               mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_FSID;
> > > +               ret =3D fanotify_check_mark_fsid(group, mark, fsid);
> > > +               if (ret)
> >
> > OOPS, missed fsnotify_put_mark(mark);
> > better add a goto target out_put_mark as this is the second case now.
>
> FYI, I pushed the fix to:
> https://github.com/amir73il/linux/commits/fanotify_fsid
>
> Let me know if you want me to post v2 for this.
>

Hi Jan,

Ping.

Reminder, I have LTP tests for testing fs with "weak" fsid [2].
After your LTP patches are merged, I will rebase them.

The way that I tested fs with "weak" fsid is that LTP tests
the ntfs-3g FUSE filesystem with .all_filesystems =3D 1.

With this work, the tests started to run on FUSE and skip
the test cases of sb/mount marks.

Thanks,
Amir.

[2] https://github.com/amir73il/tlp/commits/fanotify_fsid

