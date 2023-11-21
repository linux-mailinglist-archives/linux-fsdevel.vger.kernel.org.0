Return-Path: <linux-fsdevel+bounces-3309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A297F2E63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12ABB21742
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF451C37;
	Tue, 21 Nov 2023 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQSxXRKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AFED6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 05:33:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41eae4f0ee6so32083461cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700573631; x=1701178431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oHQ6PX/8KpSmBhuF0g2rqcRuQGmolvsWl6Rj8dXzaE=;
        b=AQSxXRKpPs7tHdHhNUkZ5hNkdkopXhymDDnly4OFXO6jM3/IfpkBORaWxW5P9gjwj7
         e8o5lQ8A8/gZqlEj0niWwXRc/fG2w/mHL+M0LSbs+ULRm19yFi6+P4U/v7UJU4hYreE3
         5PN5pYFi1PBygR/WcOrHLM/Rxo/JNp8st4iBGKXyB+dDDXztdsE3KsvHWGe7eJMOZsV+
         DgcNI6hGMo1UMxRUdO9Ulkp+rnnrQs+WG/Zq2YW3jDkS2N7UO64F+Vi8IJ2wUTleVcnJ
         9kkcsQeT1aMBx6Col1nIGiZ/OyIzXlPATISkBVXdxf7bqUCo2WGkOMrGvs2mJbZL558n
         kAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573631; x=1701178431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oHQ6PX/8KpSmBhuF0g2rqcRuQGmolvsWl6Rj8dXzaE=;
        b=uhuewMdHEBRaBz4XlKc4/73JN2ySIcE2gesf3sj4762GcAtk3VBli6WkJCWrbXusmb
         WKbS4EjGseDLHYmza61O/Zklu2ej8e1HHJbH9c7dgr9rR4WZhlXnHJv02nsBxKu39NiJ
         qAIPU1Olw917/YgvOYj0z8p2vudV5OIrVyjSmYgIbLw43XbQ9l6Gb3c0i0w/uhwLm/1h
         Fd9S28oC/lpVTAP/q4MtcUjnSEF2y5FSZwxAsECgT2xmTNk8hCYbFit3UkCiLZoaJrx7
         UZusnfCbyIjuAteLwnWiZ8ccrWPif8ETqXZyxjSgHBEu3PxhMAAv+Ro2eFVlY0nP34T4
         FCWA==
X-Gm-Message-State: AOJu0YybDF8OSaSpnxUf6E8Hp3nL3unJJ3gZ9MVAXNpqL0xsgCOtQLNq
	CxyBg76i076YehQ7i1IUXCFJGzx1v8pzz7WPYE70TE8FBqs=
X-Google-Smtp-Source: AGHT+IGwMG5uynehB9hxdzzosGX3BE1M09CzkQbnbeQ8dgkMmcsExJ/ukeW+qoj8M5UBdi4RzX5IwSh+WassqyBJyvA=
X-Received: by 2002:ac8:7d08:0:b0:417:b545:e962 with SMTP id
 g8-20020ac87d08000000b00417b545e962mr10247666qtb.7.1700573631458; Tue, 21 Nov
 2023 05:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118183018.2069899-1-amir73il@gmail.com> <20231118183018.2069899-3-amir73il@gmail.com>
 <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 15:33:40 +0200
Message-ID: <CAOQ4uxgfyAcD_pZ8egQuEoiNstgrD8E0YPDps5Am=St9jY6rXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 9:42=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sat, Nov 18, 2023 at 8:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> > on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> > non-uniform fsid (e.g. btrfs non-root subvol).
> >
> > When group is watching inodes all from the same filesystem (or subvol),
> > allow adding inode marks with "weak" fsid, because there is no ambiguit=
y
> > regarding which filesystem reports the event.
> >
> > The first mark added to a group determines if this group is single or
> > multi filesystem, depending on the fsid at the path of the added mark.
> >
> > If the first mark added has a "strong" fsid, marks with "weak" fsid
> > cannot be added and vice versa.
> >
> > If the first mark added has a "weak" fsid, following marks must have
> > the same "weak" fsid and the same sb as the first mark.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c      | 15 +----
> >  fs/notify/fanotify/fanotify.h      |  6 ++
> >  fs/notify/fanotify/fanotify_user.c | 97 ++++++++++++++++++++++++------
> >  include/linux/fsnotify_backend.h   |  1 +
> >  4 files changed, 90 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index aff1ab3c32aa..1e4def21811e 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -29,12 +29,6 @@ static unsigned int fanotify_hash_path(const struct =
path *path)
> >                 hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
> >  }
> >
> > -static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
> > -                                      __kernel_fsid_t *fsid2)
> > -{
> > -       return fsid1->val[0] =3D=3D fsid2->val[0] && fsid1->val[1] =3D=
=3D fsid2->val[1];
> > -}
> > -
> >  static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
> >  {
> >         return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
> > @@ -851,7 +845,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsn=
otify_iter_info *iter_info)
> >                 if (!(mark->flags & FSNOTIFY_MARK_FLAG_HAS_FSID))
> >                         continue;
> >                 fsid =3D FANOTIFY_MARK(mark)->fsid;
> > -               if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
> > +               if (!(mark->flags & FSNOTIFY_MARK_FLAG_WEAK_FSID) &&
> > +                   WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
> >                         continue;
> >                 return fsid;
> >         }
> > @@ -933,12 +928,8 @@ static int fanotify_handle_event(struct fsnotify_g=
roup *group, u32 mask,
> >                         return 0;
> >         }
> >
> > -       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
> > +       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
> >                 fsid =3D fanotify_get_fsid(iter_info);
> > -               /* Racing with mark destruction or creation? */
> > -               if (!fsid.val[0] && !fsid.val[1])
> > -                       return 0;
> > -       }
> >
> >         event =3D fanotify_alloc_event(group, mask, data, data_type, di=
r,
> >                                      file_name, &fsid, match_mask);
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index 2847fa564298..9c97ae638ac5 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -504,6 +504,12 @@ static inline __kernel_fsid_t *fanotify_mark_fsid(=
struct fsnotify_mark *mark)
> >         return &FANOTIFY_MARK(mark)->fsid;
> >  }
> >
> > +static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
> > +                                      __kernel_fsid_t *fsid2)
> > +{
> > +       return fsid1->val[0] =3D=3D fsid2->val[0] && fsid1->val[1] =3D=
=3D fsid2->val[1];
> > +}
> > +
> >  static inline unsigned int fanotify_mark_user_flags(struct fsnotify_ma=
rk *mark)
> >  {
> >         unsigned int mflags =3D 0;
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index e3d836d4d156..1cc68ea56c17 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -23,7 +23,7 @@
> >
> >  #include <asm/ioctls.h>
> >
> > -#include "../../mount.h"
> > +#include "../fsnotify.h"
> >  #include "../fdinfo.h"
> >  #include "fanotify.h"
> >
> > @@ -1192,11 +1192,68 @@ static bool fanotify_mark_add_to_mask(struct fs=
notify_mark *fsn_mark,
> >         return recalc;
> >  }
> >
> > +struct fan_fsid {
> > +       struct super_block *sb;
> > +       __kernel_fsid_t id;
> > +       bool weak;
> > +};
> > +
> > +static int fanotify_check_mark_fsid(struct fsnotify_group *group,
> > +                                   struct fsnotify_mark *mark,
> > +                                   struct fan_fsid *fsid)
> > +{
> > +       struct fsnotify_mark_connector *conn;
> > +       struct fsnotify_mark *old;
> > +       struct super_block *old_sb =3D NULL;
> > +
> > +       *fanotify_mark_fsid(mark) =3D fsid->id;
> > +       mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_FSID;
> > +       if (fsid->weak)
> > +               mark->flags |=3D FSNOTIFY_MARK_FLAG_WEAK_FSID;
> > +
> > +       /* First mark added will determine if group is single or multi =
fsid */
> > +       if (list_empty(&group->marks_list))
> > +               return 0;
> > +
> > +       /* Find sb of an existing mark */
> > +       list_for_each_entry(old, &group->marks_list, g_list) {
> > +               conn =3D READ_ONCE(old->connector);
> > +               if (!conn)
> > +                       continue;
> > +               old_sb =3D fsnotify_connector_sb(conn);
> > +               if (old_sb)
> > +                       break;
> > +       }
> > +
> > +       /* Only detached marks left? */
> > +       if (!old_sb)
> > +               return 0;
> > +
> > +       /* Do not allow mixing of marks with weak and strong fsid */
> > +       if ((mark->flags ^ old->flags) & FSNOTIFY_MARK_FLAG_WEAK_FSID)
> > +               return -EXDEV;
> > +
> > +       /* Allow mixing of marks with strong fsid from different fs */
> > +       if (!fsid->weak)
> > +               return 0;
> > +
> > +       /* Do not allow mixing marks with weak fsid from different fs *=
/
> > +       if (old_sb !=3D fsid->sb)
> > +               return -EXDEV;
> > +
> > +       /* Do not allow mixing marks from different btrfs sub-volumes *=
/
> > +       if (!fanotify_fsid_equal(fanotify_mark_fsid(old),
> > +                                fanotify_mark_fsid(mark)))
> > +               return -EXDEV;
> > +
> > +       return 0;
> > +}
> > +
> >  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_gro=
up *group,
> >                                                    fsnotify_connp_t *co=
nnp,
> >                                                    unsigned int obj_typ=
e,
> >                                                    unsigned int fan_fla=
gs,
> > -                                                  __kernel_fsid_t *fsi=
d)
> > +                                                  struct fan_fsid *fsi=
d)
> >  {
> >         struct ucounts *ucounts =3D group->fanotify_data.ucounts;
> >         struct fanotify_mark *fan_mark;
> > @@ -1225,8 +1282,9 @@ static struct fsnotify_mark *fanotify_add_new_mar=
k(struct fsnotify_group *group,
> >
> >         /* Cache fsid of filesystem containing the marked object */
> >         if (fsid) {
> > -               fan_mark->fsid =3D *fsid;
> > -               mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_FSID;
> > +               ret =3D fanotify_check_mark_fsid(group, mark, fsid);
> > +               if (ret)
>
> OOPS, missed fsnotify_put_mark(mark);
> better add a goto target out_put_mark as this is the second case now.

FYI, I pushed the fix to:
https://github.com/amir73il/linux/commits/fanotify_fsid

Let me know if you want me to post v2 for this.

Thanks,
Amir.

>
> > +                       goto out_dec_ucounts;
> >         } else {
> >                 fan_mark->fsid.val[0] =3D fan_mark->fsid.val[1] =3D 0;
> >         }
> > @@ -1289,7 +1347,7 @@ static int fanotify_may_update_existing_mark(stru=
ct fsnotify_mark *fsn_mark,
> >  static int fanotify_add_mark(struct fsnotify_group *group,
> >                              fsnotify_connp_t *connp, unsigned int obj_=
type,
> >                              __u32 mask, unsigned int fan_flags,
> > -                            __kernel_fsid_t *fsid)
> > +                            struct fan_fsid *fsid)
> >  {
> >         struct fsnotify_mark *fsn_mark;
> >         bool recalc;
> > @@ -1337,7 +1395,7 @@ static int fanotify_add_mark(struct fsnotify_grou=
p *group,
> >
> >  static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
> >                                       struct vfsmount *mnt, __u32 mask,
> > -                                     unsigned int flags, __kernel_fsid=
_t *fsid)
> > +                                     unsigned int flags, struct fan_fs=
id *fsid)
> >  {
> >         return fanotify_add_mark(group, &real_mount(mnt)->mnt_fsnotify_=
marks,
> >                                  FSNOTIFY_OBJ_TYPE_VFSMOUNT, mask, flag=
s, fsid);
> > @@ -1345,7 +1403,7 @@ static int fanotify_add_vfsmount_mark(struct fsno=
tify_group *group,
> >
> >  static int fanotify_add_sb_mark(struct fsnotify_group *group,
> >                                 struct super_block *sb, __u32 mask,
> > -                               unsigned int flags, __kernel_fsid_t *fs=
id)
> > +                               unsigned int flags, struct fan_fsid *fs=
id)
> >  {
> >         return fanotify_add_mark(group, &sb->s_fsnotify_marks,
> >                                  FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsi=
d);
> > @@ -1353,7 +1411,7 @@ static int fanotify_add_sb_mark(struct fsnotify_g=
roup *group,
> >
> >  static int fanotify_add_inode_mark(struct fsnotify_group *group,
> >                                    struct inode *inode, __u32 mask,
> > -                                  unsigned int flags, __kernel_fsid_t =
*fsid)
> > +                                  unsigned int flags, struct fan_fsid =
*fsid)
> >  {
> >         pr_debug("%s: group=3D%p inode=3D%p\n", __func__, group, inode)=
;
> >
> > @@ -1564,20 +1622,25 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> >         return fd;
> >  }
> >
> > -static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *=
fsid)
> > +static int fanotify_test_fsid(struct dentry *dentry, unsigned int flag=
s,
> > +                             struct fan_fsid *fsid)
> >  {
> > +       unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> >         __kernel_fsid_t root_fsid;
> >         int err;
> >
> >         /*
> >          * Make sure dentry is not of a filesystem with zero fsid (e.g.=
 fuse).
> >          */
> > -       err =3D vfs_get_fsid(dentry, fsid);
> > +       err =3D vfs_get_fsid(dentry, &fsid->id);
> >         if (err)
> >                 return err;
> >
> > -       if (!fsid->val[0] && !fsid->val[1])
> > -               return -ENODEV;
> > +       /* Allow weak fsid when marking inodes */
> > +       fsid->sb =3D dentry->d_sb;
> > +       fsid->weak =3D mark_type =3D=3D FAN_MARK_INODE;
> > +       if (!fsid->id.val[0] && !fsid->id.val[1])
> > +               return fsid->weak ? 0 : -ENODEV;
> >
> >         /*
> >          * Make sure dentry is not of a filesystem subvolume (e.g. btrf=
s)
> > @@ -1587,10 +1650,10 @@ static int fanotify_test_fsid(struct dentry *de=
ntry, __kernel_fsid_t *fsid)
> >         if (err)
> >                 return err;
> >
> > -       if (root_fsid.val[0] !=3D fsid->val[0] ||
> > -           root_fsid.val[1] !=3D fsid->val[1])
> > -               return -EXDEV;
> > +       if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
> > +               return fsid->weak ? 0 : -EXDEV;
> >
> > +       fsid->weak =3D false;
> >         return 0;
> >  }
> >
> > @@ -1675,7 +1738,7 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >         struct fsnotify_group *group;
> >         struct fd f;
> >         struct path path;
> > -       __kernel_fsid_t __fsid, *fsid =3D NULL;
> > +       struct fan_fsid __fsid, *fsid =3D NULL;
> >         u32 valid_mask =3D FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
> >         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> >         unsigned int mark_cmd =3D flags & FANOTIFY_MARK_CMD_BITS;
> > @@ -1827,7 +1890,7 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >         }
> >
> >         if (fid_mode) {
> > -               ret =3D fanotify_test_fsid(path.dentry, &__fsid);
> > +               ret =3D fanotify_test_fsid(path.dentry, flags, &__fsid)=
;
> >                 if (ret)
> >                         goto path_put_and_out;
> >
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index a80b525ca653..7f63be5ca0f1 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -529,6 +529,7 @@ struct fsnotify_mark {
> >  #define FSNOTIFY_MARK_FLAG_NO_IREF             0x0200
> >  #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS    0x0400
> >  #define FSNOTIFY_MARK_FLAG_HAS_FSID            0x0800
> > +#define FSNOTIFY_MARK_FLAG_WEAK_FSID           0x1000
> >         unsigned int flags;             /* flags [mark->lock] */
> >  };
> >
> > --
> > 2.34.1
> >

