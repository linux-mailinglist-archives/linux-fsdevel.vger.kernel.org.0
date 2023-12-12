Return-Path: <linux-fsdevel+bounces-5617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CA80E40F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 06:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D4E282DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14902156D8;
	Tue, 12 Dec 2023 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcIicYjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81862A1;
	Mon, 11 Dec 2023 21:51:43 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67ad891ff36so35436906d6.1;
        Mon, 11 Dec 2023 21:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702360302; x=1702965102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12FoZrTM1qA1q6lNZED2M9R8Q7mbLhB+NwEb5K3ODV0=;
        b=CcIicYjH6PnbCsikTU98WRXT1KN5weE42GRdGcVdhL5+XaLe5rvb7f1hJpVJAN9/mv
         9Vsxx0OZ2VWI2YJnGyy0Xoz/xrhbQ5PEjzYcpiMrT45JjkSFBsHS++mP9LobnUNrgtTh
         IUxfeYwGmaFXIh6YLQ6XzjUgeS4kblM5wnlwBuuaNOgjo8bRfJ9f9jVYiJxCTibdYjyH
         XZkuZd5uzqyFy72GzmJufyweZm4L5DYiLtaWWsl09S8djzedx4Kmic3oyeeeyKFRjku3
         34XyzEv91L6P2UIU0PoP/Nln4TlOijNV/WEJKr3PfYwmE73piFHHG0/w3y7hE+DPuS7M
         TFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702360302; x=1702965102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12FoZrTM1qA1q6lNZED2M9R8Q7mbLhB+NwEb5K3ODV0=;
        b=foIjhvnWQYkLfvCyP4YdfpupKEiKqM12JbKf3DOf0RAfyVVeJqdTUHi8TtH8sJAckU
         EIhDD9NMTCT0y9SomI4qwt/AIdifPrgeJTTnogtesJg43uHXl290znhqXxAgXA3wp797
         EW/J3TWdbdQgx7H/60MYlqEBLZEjAhQISPik5wUBcMDDmwT6NjrReZFEOvwLzlSB497a
         Bwasu2jJ4WditXOkOSP+mQJjPZhFj3cv3WRZ1s5Wc3OaB0sIFjXLbfjKrReBIRl4Phui
         iL0Jd+DQBAv7nOlgF37YQ8oW1ZiZzzzvhInbFzzwdoaoW1St26cz1y23f5ZxESrv33vQ
         x6Ow==
X-Gm-Message-State: AOJu0YwJAnShmKFj3R7U89634h8Qrg4zo1JmXnM/Ghh4Q7xMEVlspyki
	QGQ3Vhv3vFLOWcXdJ8JPUfz+Fu8CffuAzJChhzw=
X-Google-Smtp-Source: AGHT+IEiBuQfFvnHdsHHCz9keYLFCQiREqBvBr3kSzui3aXGaRKF378COCxIlVwpG93n1BjmgFqb7WcmxMOMQ/ydxI4=
X-Received: by 2002:a05:6214:1022:b0:67a:38f3:10d9 with SMTP id
 k2-20020a056214102200b0067a38f310d9mr5973531qvr.7.1702360302581; Mon, 11 Dec
 2023 21:51:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211193048.580691-1-avagin@google.com>
In-Reply-To: <20231211193048.580691-1-avagin@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Dec 2023 07:51:31 +0200
Message-ID: <CAOQ4uxik0=0F-6CLRsuaOheFjwWF-B-Q5iEQ6qJbRszL52HeQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc: show correct device and inode numbers in /proc/pid/maps
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+fsdevel, +overlayfs, +brauner, +miklos

On Mon, Dec 11, 2023 at 9:30=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
ote:
>
> Device and inode numbers in /proc/pid/maps have to match numbers returned=
 by
> statx for the same files.

That statement may be true for regular files.
It is not true for block/char as far as I know.

I think that your fix will break that by displaying the ino/dev
of the block/char reference inode and not their backing rdev inode.

>
> /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> an issue. If a mapped file is on a stackable file system (e.g.,
> overlayfs), vma->vm_file is a backing file whose f_inode is on the
> underlying filesystem. To show correct numbers, we need to get a user
> file and shows its numbers. The same trick is used to show file paths in
> /proc/pid/maps.

For the *same* trick, see my patch below.

>
> But it isn't the end of this story. A file system can manipulate inode nu=
mbers
> within the getattr callback (e.g., ovl_getattr), so vfs_getattr must be u=
sed to
> get correct numbers.

This explanation is inaccurate, because it mixes two different overlayfs
traits which are unrelated.
It is true that a filesystem *can* manipulate st_dev in a way that will not
match i_ino and it is true that overlayfs may do that in some non-default
configurations (see [1]), but this is not the reason that you are seeing
mismatches ino/dev in /proc/<pid>/maps.

[1] https://docs.kernel.org/filesystems/overlayfs.html#inode-properties

The reason is that the vma->vm_file is a special internal backing file
which is not otherwise exposed to userspace.
Please see my suggested fix below.

>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/proc/task_mmu.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 435b61054b5b..abbf96c091ad 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -273,9 +273,23 @@ show_map_vma(struct seq_file *m, struct vm_area_stru=
ct *vma)
>         const char *name =3D NULL;
>
>         if (file) {
> -               struct inode *inode =3D file_inode(vma->vm_file);
> -               dev =3D inode->i_sb->s_dev;
> -               ino =3D inode->i_ino;
> +               const struct path *path;
> +               struct kstat stat;
> +
> +               path =3D file_user_path(file);
> +               /*
> +                * A file system can manipulate inode numbers within the
> +                * getattr callback (e.g. ovl_getattr).
> +                */
> +               if (!vfs_getattr_nosec(path, &stat, STATX_INO, AT_STATX_D=
ONT_SYNC)) {

Should you prefer to keep this solution it should be constrained to
regular files.

> +                       dev =3D stat.dev;
> +                       ino =3D stat.ino;
> +               } else {
> +                       struct inode *inode =3D d_backing_inode(path->den=
try);

d_inode() please.
d_backing_inode()/d_backing_dentry() are relics of an era that never existe=
d
(i.e. union mounts).

> +
> +                       dev =3D inode->i_sb->s_dev;
> +                       ino =3D inode->i_ino;
> +               }
>                 pgoff =3D ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
>         }
>

Would you mind trying this alternative (untested) patch?
I think it is preferred, because it is simpler.

Thanks,
Amir.

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..5328266be6b5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -273,7 +273,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct =
*vma)
        const char *name =3D NULL;

        if (file) {
-               struct inode *inode =3D file_inode(vma->vm_file);
+               struct inode *inode =3D file_user_inode(vma->vm_file);
+
                dev =3D inode->i_sb->s_dev;
                ino =3D inode->i_ino;
                pgoff =3D ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 900d0cd55b50..d78412c6fd47 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2581,20 +2581,28 @@ struct file *backing_file_open(const struct
path *user_path, int flags,
 struct path *backing_file_user_path(struct file *f);

 /*
- * file_user_path - get the path to display for memory mapped file
- *
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the f=
ile
  * stored in ->vm_file is a backing file whose f_inode is on the underlyin=
g
- * filesystem.  When the mapped file path is displayed to user (e.g. via
- * /proc/<pid>/maps), this helper should be used to get the path to displa=
y
- * to the user, which is the path of the fd that user has requested to map=
.
+ * filesystem.  When the mapped file path and inode number are displayed t=
o
+ * user (e.g. via /proc/<pid>/maps), these helper should be used to get th=
e
+ * path and inode number to display to the user, which is the path of the =
fd
+ * that user has requested to map and the inode number that would be retur=
ned
+ * by fstat() on that same fd.
  */
+/* Get the path to display in /proc/<pid>/maps */
 static inline const struct path *file_user_path(struct file *f)
 {
        if (unlikely(f->f_mode & FMODE_BACKING))
                return backing_file_user_path(f);
        return &f->f_path;
 }
+/* Get the inode whose inode number to display in /proc/<pid>/maps */
+static inline const struct path *file_user_inode(struct file *f)
+{
+       if (unlikely(f->f_mode & FMODE_BACKING))
+               return d_inode(backing_file_user_path(f)->dentry);
+       return file_inode(f);
+}

