Return-Path: <linux-fsdevel+bounces-1012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32547D4D66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 12:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFD1C20BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19B25102;
	Tue, 24 Oct 2023 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGZJ4JU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCE3FE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 10:12:55 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D9D10A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 03:12:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo6579298a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698142371; x=1698747171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS03m0zIQpWzJqFO/k73A81T1gIRLXPNL2PUhAGjUoU=;
        b=KGZJ4JU++px0wxncho/p01QN15XntPDdIPlKyoH+NvSvAJmqMRjh8mJG+7LmfBc4wo
         +BXlkQySi9feMyRmH0G9HgR/UKSyXUbI+NpnBb7Z7qoz92ue5w8t/4OeikdCOm8/gQV0
         VP/Wt2og9dFTvU+AhO/K27RKoe2ljIOmt60X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698142371; x=1698747171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS03m0zIQpWzJqFO/k73A81T1gIRLXPNL2PUhAGjUoU=;
        b=p8qiajZ9VxTrZ99bRy8+C1MbyDWBzUb4V5dTwWYl+8GcJ1lQ7AY1PFGPOKcMXP6+hu
         oNeVDw6b/pDS3FEBM+ZXeLmI4NDIjgUYpGyiu5oQUxBsiEDjd3USSSg6QxMK8bn7pwwm
         7BNzUuSbENc2XoIH5ob+QGgwJhzVIPY0odHtQOjh8asc2sUZXekdX9rm5qBCzjBXzHGW
         epldd2aATEGeLMftxo/rrBIMAElOu9Py80xNYuzjqr9GpPB40JSxh3WWpqobujKVsYNf
         yZBwvcEGaZhQirN1SNMXODAeizLVnIh9aHtp4GmjvoA1c4VWvumQYomXfMDtt6gta8sK
         X6tQ==
X-Gm-Message-State: AOJu0YzYA/AKAxImZiSWiX/RpNq4vNNOVIk3NXSnzZpwJGtleLntp2dx
	udSickzG7xfIOS+HOzpQDiu1Fn+6VwKHn3b2Au8B7Z+ZAqO4snrOcw==
X-Google-Smtp-Source: AGHT+IE4hgd5RJgjNcB4YcAelxdOX5jxyyUH1sPi9b5BxM738DjSN9FEPgi0F+HBtAKbfASojpcz9YyALdzcWb8OjQ0=
X-Received: by 2002:a17:907:744:b0:9b2:b269:d563 with SMTP id
 xc4-20020a170907074400b009b2b269d563mr9509843ejb.63.1698142370844; Tue, 24
 Oct 2023 03:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023183035.11035-1-bschubert@ddn.com> <20231023183035.11035-3-bschubert@ddn.com>
In-Reply-To: <20231023183035.11035-3-bschubert@ddn.com>
From: Yuan Yao <yuanyaogoog@chromium.org>
Date: Tue, 24 Oct 2023 19:12:39 +0900
Message-ID: <CAOJyEHZUq0xWBaMet8s1O5Bpz-M-pR39wWCfwFtm66rySzm6vg@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] fuse: introduce atomic open
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	miklos@szeredi.hu, dsingh@ddn.com, Horst Birthelmer <hbirthelmer@ddn.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Keiichi Watanabe <keiichiw@chromium.org>, Takaya Saeki <takayas@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for addressing the symbolic link problems!
Additionally, I found an incompatibility with the no_open feature.
When the FUSE server has the no_open feature enabled, the atomic_open
FUSE request returns a d_entry with an empty file handler and open
option FOPEN_KEEP_CACHE (for files) or FOPEN_CACHE_DIR (for
directories). With this situation, if we can set fc->no_open =3D 1 or
fc->no_opendir =3D 1 after receiving the such FUSE reply, as follows,
will make the atomic_open compatible with no_open feature:
+       if (!inode) {
+               flags &=3D ~(O_CREAT | O_EXCL | O_TRUNC);
+               fuse_sync_release(NULL, ff, flags);
+               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+               err =3D -ENOMEM;
+               goto out_err;
+       }
+
+ if(ff->fh =3D=3D 0) {
+        if(ff->open_flags & FOPEN_KEEP_CACHE)
+            fc->no_open =3D 1;
+        if(ff->open_flags & FOPEN_CACHE_DIR)
+          fc->no_opendir =3D 1;
+       }
+
+       /* prevent racing/parallel lookup on a negative hashed */


On Tue, Oct 24, 2023 at 3:41=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> From: Dharmendra Singh <dsingh@ddn.com>
>
> This adds full atomic open support, to avoid lookup before open/create.
> If the implementation (fuse server/daemon) does not support atomic open
> it falls back to non-atomic open.
>
> Co-developed-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/fuse/dir.c             | 214 +++++++++++++++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h          |   3 +
>  include/uapi/linux/fuse.h |   3 +
>  3 files changed, 219 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index e1095852601c..61cdb8e5f68e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -716,7 +716,7 @@ static int _fuse_create_open(struct inode *dir, struc=
t dentry *entry,
>
>  static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry =
*,
>                       umode_t, dev_t);
> -static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +static int fuse_create_open(struct inode *dir, struct dentry *entry,
>                             struct file *file, unsigned flags,
>                             umode_t mode)
>  {
> @@ -763,6 +763,218 @@ static int fuse_atomic_open(struct inode *dir, stru=
ct dentry *entry,
>         return finish_no_open(file, res);
>  }
>
> +static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +                            struct file *file, unsigned int flags,
> +                            umode_t mode)
> +{
> +       int err;
> +       struct inode *inode;
> +       FUSE_ARGS(args);
> +       struct fuse_mount *fm =3D get_fuse_mount(dir);
> +       struct fuse_conn *fc =3D fm->fc;
> +       struct fuse_forget_link *forget;
> +       struct fuse_create_in inarg;
> +       struct fuse_open_out outopen;
> +       struct fuse_entry_out outentry;
> +       struct fuse_inode *fi;
> +       struct fuse_file *ff;
> +       struct dentry *switched_entry =3D NULL, *alias =3D NULL;
> +       DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> +
> +       /* Expect a negative dentry */
> +       if (unlikely(d_inode(entry)))
> +               goto fallback;
> +
> +       /* Userspace expects S_IFREG in create mode */
> +       if ((flags & O_CREAT) && (mode & S_IFMT) !=3D S_IFREG)
> +               goto fallback;
> +
> +       forget =3D fuse_alloc_forget();
> +       err =3D -ENOMEM;
> +       if (!forget)
> +               goto out_err;
> +
> +       err =3D -ENOMEM;
> +       ff =3D fuse_file_alloc(fm);
> +       if (!ff)
> +               goto out_put_forget_req;
> +
> +       if (!fc->dont_mask)
> +               mode &=3D ~current_umask();
> +
> +       flags &=3D ~O_NOCTTY;
> +       memset(&inarg, 0, sizeof(inarg));
> +       memset(&outentry, 0, sizeof(outentry));
> +       inarg.flags =3D flags;
> +       inarg.mode =3D mode;
> +       inarg.umask =3D current_umask();
> +
> +       if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
> +           !(flags & O_EXCL) && !capable(CAP_FSETID)) {
> +               inarg.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
> +       }
> +
> +       args.opcode =3D FUSE_OPEN_ATOMIC;
> +       args.nodeid =3D get_node_id(dir);
> +       args.in_numargs =3D 2;
> +       args.in_args[0].size =3D sizeof(inarg);
> +       args.in_args[0].value =3D &inarg;
> +       args.in_args[1].size =3D entry->d_name.len + 1;
> +       args.in_args[1].value =3D entry->d_name.name;
> +       args.out_numargs =3D 2;
> +       args.out_args[0].size =3D sizeof(outentry);
> +       args.out_args[0].value =3D &outentry;
> +       args.out_args[1].size =3D sizeof(outopen);
> +       args.out_args[1].value =3D &outopen;
> +
> +       if (flags & O_CREAT) {
> +               err =3D get_create_ext(&args, dir, entry, mode);
> +               if (err)
> +                       goto out_free_ff;
> +       }
> +
> +       err =3D fuse_simple_request(fm, &args);
> +       free_ext_value(&args);
> +       if (err =3D=3D -ENOSYS || err =3D=3D -ELOOP) {
> +               if (unlikely(err =3D=3D -ENOSYS))
> +                       fc->no_open_atomic =3D 1;
> +               goto free_and_fallback;
> +       }
> +
> +       if (!err && !outentry.nodeid)
> +               err =3D -ENOENT;
> +
> +       if (err)
> +               goto out_free_ff;
> +
> +       err =3D -EIO;
> +       if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentr=
y.attr))
> +               goto out_free_ff;
> +
> +       ff->fh =3D outopen.fh;
> +       ff->nodeid =3D outentry.nodeid;
> +       ff->open_flags =3D outopen.open_flags;
> +       inode =3D fuse_iget(dir->i_sb, outentry.nodeid, outentry.generati=
on,
> +                         &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
> +       if (!inode) {
> +               flags &=3D ~(O_CREAT | O_EXCL | O_TRUNC);
> +               fuse_sync_release(NULL, ff, flags);
> +               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +               err =3D -ENOMEM;
> +               goto out_err;
> +       }
> +
> +       /* prevent racing/parallel lookup on a negative hashed */
> +       if (!(flags & O_CREAT) && !d_in_lookup(entry)) {
> +               d_drop(entry);
> +               switched_entry =3D d_alloc_parallel(entry->d_parent,
> +                                                  &entry->d_name, &wq);
> +               if (IS_ERR(switched_entry)) {
> +                       err =3D PTR_ERR(switched_entry);
> +                       switched_entry =3D NULL;
> +                       goto out_free_ff;
> +               }
> +
> +               if (unlikely(!d_in_lookup(switched_entry))) {
> +                       /* fall back */
> +                       dput(switched_entry);
> +                       switched_entry =3D NULL;
> +                       goto free_and_fallback;
> +               }
> +
> +               entry =3D switched_entry;
> +       }
> +
> +       if (d_really_is_negative(entry)) {
> +               d_drop(entry);
> +               alias =3D d_exact_alias(entry, inode);
> +               if (!alias) {
> +                       alias =3D d_splice_alias(inode, entry);
> +                       if (IS_ERR(alias)) {
> +                               /*
> +                                * Close the file in user space, but do n=
ot unlink it,
> +                                * if it was created - with network file =
systems other
> +                                * clients might have already accessed it=
.
> +                                */
> +                               fi =3D get_fuse_inode(inode);
> +                               fuse_sync_release(fi, ff, flags);
> +                               fuse_queue_forget(fm->fc, forget, outentr=
y.nodeid, 1);
> +                               err =3D PTR_ERR(alias);
> +                               goto out_err;
> +                       }
> +               }
> +
> +               if (alias)
> +                       entry =3D alias;
> +       }
> +
> +       fuse_change_entry_timeout(entry, &outentry);
> +
> +       /*  File was indeed created */
> +       if (outopen.open_flags & FOPEN_FILE_CREATED) {
> +               if (!(flags & O_CREAT)) {
> +                       pr_debug("Server side bug, FOPEN_FILE_CREATED set=
 "
> +                                "without O_CREAT, ignoring.");
> +               } else {
> +                       /* This should be always set when the file is cre=
ated */
> +                       fuse_dir_changed(dir);
> +                       file->f_mode |=3D FMODE_CREATED;
> +               }
> +       }
> +
> +       if (S_ISDIR(mode))
> +               ff->open_flags &=3D ~FOPEN_DIRECT_IO;
> +       err =3D finish_open(file, entry, generic_file_open);
> +       if (err) {
> +               fi =3D get_fuse_inode(inode);
> +               fuse_sync_release(fi, ff, flags);
> +       } else {
> +               file->private_data =3D ff;
> +               fuse_finish_open(inode, file);
> +       }
> +
> +       kfree(forget);
> +
> +       if (switched_entry) {
> +               d_lookup_done(switched_entry);
> +               dput(switched_entry);
> +       }
> +
> +       dput(alias);
> +
> +       return err;
> +
> +out_free_ff:
> +       fuse_file_free(ff);
> +out_put_forget_req:
> +       kfree(forget);
> +out_err:
> +       if (switched_entry) {
> +               d_lookup_done(switched_entry);
> +               dput(switched_entry);
> +       }
> +
> +       return err;
> +
> +free_and_fallback:
> +       fuse_file_free(ff);
> +       kfree(forget);
> +fallback:
> +       return fuse_create_open(dir, entry, file, flags, mode);
> +}
> +
> +static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +                           struct file *file, unsigned int flags,
> +                           umode_t mode)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(dir);
> +
> +       if (fc->no_open_atomic)
> +               return fuse_create_open(dir, entry, file, flags, mode);
> +       else
> +               return _fuse_atomic_open(dir, entry, file, flags, mode);
> +}
> +
>  /*
>   * Code shared between mknod, mkdir, symlink and link
>   */
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index bf0b85d0b95c..af69578763ef 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -677,6 +677,9 @@ struct fuse_conn {
>         /** Is open/release not implemented by fs? */
>         unsigned no_open:1;
>
> +       /** Is open atomic not implemented by fs? */
> +       unsigned no_open_atomic:1;
> +
>         /** Is opendir/releasedir not implemented by fs? */
>         unsigned no_opendir:1;
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index db92a7202b34..1508afbd9446 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -353,6 +353,7 @@ struct fuse_file_lock {
>   * FOPEN_STREAM: the file is stream-like (no file position at all)
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK=
_CACHE)
>   * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the s=
ame inode
> + * FOPEN_FILE_CREATED: the file was indeed created
>   */
>  #define FOPEN_DIRECT_IO                (1 << 0)
>  #define FOPEN_KEEP_CACHE       (1 << 1)
> @@ -361,6 +362,7 @@ struct fuse_file_lock {
>  #define FOPEN_STREAM           (1 << 4)
>  #define FOPEN_NOFLUSH          (1 << 5)
>  #define FOPEN_PARALLEL_DIRECT_WRITES   (1 << 6)
> +#define FOPEN_FILE_CREATED     (1 << 7)
>
>  /**
>   * INIT request/reply flags
> @@ -617,6 +619,7 @@ enum fuse_opcode {
>         FUSE_SYNCFS             =3D 50,
>         FUSE_TMPFILE            =3D 51,
>         FUSE_STATX              =3D 52,
> +       FUSE_OPEN_ATOMIC        =3D 53,
>
>         /* CUSE specific operations */
>         CUSE_INIT               =3D 4096,
> --
> 2.39.2
>
>

