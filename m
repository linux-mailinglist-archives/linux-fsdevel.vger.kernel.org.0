Return-Path: <linux-fsdevel+bounces-6041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FDA812A12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101191C20AFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA516411;
	Thu, 14 Dec 2023 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL+Zgvh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDEB9;
	Thu, 14 Dec 2023 00:11:13 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f320ca2d5so30802085a.1;
        Thu, 14 Dec 2023 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702541473; x=1703146273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDWO5H07PkvnzHoBQ35J//pcV3Lsec9flrFu7/XK3f4=;
        b=EL+Zgvh9oRTPlbh0tdgBHcSFh0YbxS17LmE+Eh6fRIFmfpcejw7ln1qZAvBo7iM0XG
         vi0wyQIWNLrb1cuwrIbGAUaJGDfRpwOJj/MKSj7Q9BESeN3t/jupPYjOoNQhbpv0WNTV
         +Ij2sx+N0JVXvL9duCv7TazZar61sWaWrmEVFPW3ozWu3ZoKYgZDd6TDiNlJwHesVReR
         itC5vGAoJeoJhin7Gl+TpTgmEtcUwA63smyW8KCkIl3Ol8ks4GOK1bQFSrNAIpF34yBe
         mmwKPkqvPFfvn9IE65t62+AeRn2EAz0zylUaCu3ZrUepp5iIuMQ14O/MHxpCS8LW26iQ
         SQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541473; x=1703146273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDWO5H07PkvnzHoBQ35J//pcV3Lsec9flrFu7/XK3f4=;
        b=itzSbSBMznHRD6ZqPnIr1FbmC2aJ2rOGi226Z9TUo/VTD+ijMz4arLd9QrjlfHcAgu
         lgNuL6NmjUUGgjxeNZQVsb0EP+betmh/eXukwXHDjsXTtIoDxf2UlvR21kZhxDyqITbp
         geHII2nQRoYzZT1mRX8WJ+xJy+s1L0zUvVnuCi46gv5jEwHi9wYH8gnRxv15XYB3jraw
         3G4L/DlIYlQKdyJvROnF8kCcR8KN0E0MyJkllloKW0iC43HvNIlny8HXNtXnYMKvjZh1
         zyPf23oEzRRLO2iB41LQExObCfx2i4GIMKoO3VmRX0nafYM1jZlpLC0Ouvpg1g/YUbp8
         p1Qg==
X-Gm-Message-State: AOJu0YyPQZpMa+8ekXyjMTLzhKKUuDkzHdL55yMLfxiBItw157huhYJG
	4Lqynb31qXesAxo//0v8Y3rkNb+Dy2S+4sT/J3r7kmUKUUA=
X-Google-Smtp-Source: AGHT+IFnk28laCTuTTQirxoyuffzhDMJBW7p37ZgeluhE7VxKNYyEk4jScBeTp1yfJ10ifiNG2xpSxQMjFRVMMFRpDo=
X-Received: by 2002:a05:620a:430e:b0:77d:5f96:720e with SMTP id
 u14-20020a05620a430e00b0077d5f96720emr15951323qko.15.1702541472735; Thu, 14
 Dec 2023 00:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214064439.1023011-1-avagin@google.com>
In-Reply-To: <20231214064439.1023011-1-avagin@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Dec 2023 10:11:01 +0200
Message-ID: <CAOQ4uxirQoaXxqoD8=OnYqASAB_qbz8iTgwga_-f3v88-af2_g@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] fs/proc: show correct device and inode numbers in /proc/pid/maps
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:44=E2=80=AFAM Andrei Vagin <avagin@google.com> wr=
ote:
>
> /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> an issue. If a mapped file is on a stackable file system (e.g.,
> overlayfs), vma->vm_file is a backing file whose f_inode is on the
> underlying filesystem. To show correct numbers, we need to get a user
> file and shows its numbers. The same trick is used to show file paths in
> /proc/pid/maps.
>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
> v2: Amir explained that vfs_getattr isn't needed, because
> file_user_inode(vma->vm_file).i_ino always matches an inode number
> returned by statx.

At least i_ino *should* always match st_ino for overlayfs non-dirs.
If it doesn't, it is a bug.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
>  fs/proc/task_mmu.c |  3 ++-
>  include/linux/fs.h | 18 +++++++++++++-----
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 435b61054b5b..1801e409a061 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -273,7 +273,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struc=
t *vma)
>         const char *name =3D NULL;
>
>         if (file) {
> -               struct inode *inode =3D file_inode(vma->vm_file);
> +               const struct inode *inode =3D file_user_inode(vma->vm_fil=
e);
> +
>                 dev =3D inode->i_sb->s_dev;
>                 ino =3D inode->i_ino;
>                 pgoff =3D ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..838ccfc63323 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2523,20 +2523,28 @@ struct file *backing_file_open(const struct path =
*user_path, int flags,
>  struct path *backing_file_user_path(struct file *f);
>
>  /*
> - * file_user_path - get the path to display for memory mapped file
> - *
>   * When mmapping a file on a stackable filesystem (e.g., overlayfs), the=
 file
>   * stored in ->vm_file is a backing file whose f_inode is on the underly=
ing
> - * filesystem.  When the mapped file path is displayed to user (e.g. via
> - * /proc/<pid>/maps), this helper should be used to get the path to disp=
lay
> - * to the user, which is the path of the fd that user has requested to m=
ap.
> + * filesystem.  When the mapped file path and inode number are displayed=
 to
> + * user (e.g. via /proc/<pid>/maps), these helpers should be used to get=
 the
> + * path and inode number to display to the user, which is the path of th=
e fd
> + * that user has requested to map and the inode number that would be ret=
urned
> + * by fstat() on that same fd.
>   */
> +/* Get the path to display in /proc/<pid>/maps */
>  static inline const struct path *file_user_path(struct file *f)
>  {
>         if (unlikely(f->f_mode & FMODE_BACKING))
>                 return backing_file_user_path(f);
>         return &f->f_path;
>  }
> +/* Get the inode whose inode number to display in /proc/<pid>/maps */
> +static inline const struct inode *file_user_inode(struct file *f)
> +{
> +       if (unlikely(f->f_mode & FMODE_BACKING))
> +               return d_inode(backing_file_user_path(f)->dentry);
> +       return file_inode(f);
> +}
>
>  static inline struct file *file_clone_open(struct file *file)
>  {
> --
> 2.43.0.472.g3155946c3a-goog
>

