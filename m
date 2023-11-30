Return-Path: <linux-fsdevel+bounces-4441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DCB7FF680
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AAD281696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42E355777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibFLngaR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE7D40
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:29:01 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b844e3e817so679636b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701361741; x=1701966541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEeyBtKg+zNqLdmN9Mn1aFaLiTsVKErfnGuKFvUXEZ0=;
        b=ibFLngaR3WKyYNPjs7JRctrG80zb1TeAs8jl5mV2RG2y9dPyzcHBbZvQKzC/jXc2ZW
         Eb0kzuhZGwHcUfgX2Uvp+LsKzroNWd1A8X9n8VTMWGdyZKDPgEElQXgCcwpqqqaNQNI9
         5FJ9rM6HgPzy/9UcjnctN8N8kItmXsQ009EdE91MuhSKo0yW1lpbuXZJ0ETrMZE4ufiu
         VELN5FxFacseD8YwlEmN1Ied2qf4gchwXoA8YYAoBIvroUXPjn8oqRRYRvNyv6dgznIY
         UnsJWb1Q5kiULBstZBwEIf2k7oBefWn23wziJtT36MzHRQA2Tk0xK+1fkNCtoVkykQpw
         jkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361741; x=1701966541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEeyBtKg+zNqLdmN9Mn1aFaLiTsVKErfnGuKFvUXEZ0=;
        b=B55Smlk7UrY3PlCqQgI1feZd72/l7j0tZIFrgSp1DBmQeMEnpaOx218d6TOUVSfRSP
         zIt2ZrWPx8t8leZYvzv2rGrGKITLlddE28U51hL4bwOk+pSeIU+Jd4Vrm8PxEVcq6XkY
         dXdgTkosBqcru5J+F/H9rDf8FiZvuy5Ab8MBADTL3JidZ4top1HWjVT5BLq44N1XWQ2p
         Bh9uyp+5p79bae1jZni8plvsekbI4pI4fZb0eUTG5iOijAQOhMceQwDIzIAbo6QAkBKe
         UM5LpZkJ2S8Zj4O95HxlZwpjFrv3WhcuiqbxnlPek93NbQ7cZ2bcfMEEdbCADjIBLPwu
         wJXA==
X-Gm-Message-State: AOJu0YwBKCQdrDRr5Q/Wxryguc6yL4J4nPwdfiCxeVFYNz0RKgUhmYW7
	h/yO3YCVVpyTCbc4r9R/z9lv6BkytNF2l587sZc=
X-Google-Smtp-Source: AGHT+IFfdHfW/GN1ZeaDDznPoHMdu2T8W78NoPr4kXZ+yaiMSkpfv/H7SCSXlaYZ1LtBfoW9WI253J3PSveAwPbJK0s=
X-Received: by 2002:aca:220b:0:b0:3b8:402c:7081 with SMTP id
 b11-20020aca220b000000b003b8402c7081mr36829oic.27.1701361736162; Thu, 30 Nov
 2023 08:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118183018.2069899-1-amir73il@gmail.com> <20231118183018.2069899-3-amir73il@gmail.com>
 <20231130154738.rcdkvqhuztp5pz5y@quack3>
In-Reply-To: <20231130154738.rcdkvqhuztp5pz5y@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 18:28:44 +0200
Message-ID: <CAOQ4uxhdjzJRCbKzD_R6fQ7WqyZcpO=J8SsumZmvE0Dmok0BQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:47=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 18-11-23 20:30:18, Amir Goldstein wrote:
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
>
> Looks mostly good to me, some small comments below.
>
> > @@ -1192,11 +1192,68 @@ static bool fanotify_mark_add_to_mask(struct fs=
notify_mark *fsn_mark,
> >       return recalc;
> >  }
> >
> > +struct fan_fsid {
> > +     struct super_block *sb;
> > +     __kernel_fsid_t id;
> > +     bool weak;
> > +};
> > +
> > +static int fanotify_check_mark_fsid(struct fsnotify_group *group,
> > +                                 struct fsnotify_mark *mark,
> > +                                 struct fan_fsid *fsid)
>
> I'd call this fanotify_set_mark_fsid() because that's what it does and
> as part of that it also checks whether it can actually set the fsid...

ok.

>
> > @@ -1564,20 +1622,25 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> >       return fd;
> >  }
> >
> > -static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *=
fsid)
> > +static int fanotify_test_fsid(struct dentry *dentry, unsigned int flag=
s,
> > +                           struct fan_fsid *fsid)
> >  {
> > +     unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> >       __kernel_fsid_t root_fsid;
> >       int err;
> >
> >       /*
> >        * Make sure dentry is not of a filesystem with zero fsid (e.g. f=
use).
> >        */
> > -     err =3D vfs_get_fsid(dentry, fsid);
> > +     err =3D vfs_get_fsid(dentry, &fsid->id);
> >       if (err)
> >               return err;
> >
> > -     if (!fsid->val[0] && !fsid->val[1])
> > -             return -ENODEV;
> > +     /* Allow weak fsid when marking inodes */
> > +     fsid->sb =3D dentry->d_sb;
> > +     fsid->weak =3D mark_type =3D=3D FAN_MARK_INODE;
> > +     if (!fsid->id.val[0] && !fsid->id.val[1])
> > +             return fsid->weak ? 0 : -ENODEV;
> >
> >       /*
> >        * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
> > @@ -1587,10 +1650,10 @@ static int fanotify_test_fsid(struct dentry *de=
ntry, __kernel_fsid_t *fsid)
> >       if (err)
> >               return err;
> >
> > -     if (root_fsid.val[0] !=3D fsid->val[0] ||
> > -         root_fsid.val[1] !=3D fsid->val[1])
> > -             return -EXDEV;
> > +     if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
> > +             return fsid->weak ? 0 : -EXDEV;
> >
> > +     fsid->weak =3D false;
> >       return 0;
> >  }
>
> So the handling of 'weak' confuses me here as it combines determining
> whether fsid is weak with determining whether we accept it or not. Maybe =
my
> brain is just fried... Can we maybe simplify to something like:
>
>         fsid->sb =3D dentry->d_sb;
>         if (!fsid->id.val[0] && !fsid->id.val[1]) {
>                 fsid->weak =3D true;
>                 goto check;
>         }
>
>         ... fetch root_fsid ...
>
>         if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
>                 fsid->weak =3D true;
>
> check:
>         /* Allow weak fsids only for inode marks... */
>         if (fsid->weak && mark_type !=3D FAN_MARK_INODE)
>                 return -EXDEV;
>         return 0;
>
> This is how I understand the logic from your description but I'm not 100%
> sure this is equivalent to your code above ;).

Almost.
The return value for FUSE + sb mark is ENODEV.

The code below should work and be readable.

Thanks,
Amir.

        fsid->sb =3D dentry->d_sb;
        if (!fsid->id.val[0] && !fsid->id.val[1]) {
                err =3D -ENODEV;
                goto weak;
        }

... fetch root_fsid ...

        if (!fanotify_fsid_equal(&root_fsid, &fsid->id)) {
                err =3D -EXDEV;
                goto weak;
        }

        return 0;

weak:
        /* Allow weak fsid when marking inodes */
        fsid->weak =3D true;
        return (mark_type =3D=3D FAN_MARK_INODE) ? 0 : err;
}

