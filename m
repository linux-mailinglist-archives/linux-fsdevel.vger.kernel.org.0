Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2670A724
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 12:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjETKU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjETKU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 06:20:57 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A18189
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 03:20:55 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-456d0287ec1so1241170e0c.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684578054; x=1687170054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMYqw/hwN6F3xW5kPE2gwWolyPVBlaRq4lE3fKb151A=;
        b=IvY51UcWd0Sx0l9wN5Aud08E8xNM638QJ8d92HXguYKZyPbtPsgnAoEUjbHPLYMxMf
         mVT0rE7mzgocmD5+fiqBTheRTybebe/ZeDVPSIXCBlvU5ycl/B+VP1FynRoqrKyTeE2R
         OhBT+akJ9j5RLHkkkIXYlSxuK5e8BThg/yS3HaAleXPalA1GF1jjCr+5Wyyy2Lb/PyyH
         imdIkjWYg6C+XxQB+BlX2vzcVh0f50d7LycrZdNqkMfuZUNzg7G/u4zaJLb7dA19YAId
         fnhjtqHadr+1RsIc926reQ4f3YuIvyla2EL4xF8hYztLZmr5Hr3bUNEPn/EztUgjBwSu
         3VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684578054; x=1687170054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMYqw/hwN6F3xW5kPE2gwWolyPVBlaRq4lE3fKb151A=;
        b=Icctiz/a7OOttwNwRkNkql05I4qd4V7DGFqnzonwResX1zBiTTWhZ4P/Ky870gXjtR
         wIpHjwySzVZzXxBBpE+mG5rzu8WRMGt9beHGhHynmdNQFpXRjNj3iMqXv9n5w6tNK+1o
         4Sibxm2uJj4z99b7feuQU5icA1EoG2rSje/EgcqRwgGZf8RlL4WVDRqRR42HrQIoi3XM
         DA7hs0LaTFJK4Ukz9ahyt3kv3OLirL42TrQonLreUGjER/sevebMWKPUcWUyQ1Ptjqv/
         Fz28BeOcEb5SUk1gBFWSigbFGhxmWBWGPVJAqJdt7wBb7iRUFm9Hs18FgnTwie+CCE/v
         CgRQ==
X-Gm-Message-State: AC+VfDyGxASZKuGKYGvVWtLPhFe22+7LxCVndyV9lZ5KbvqO0cU+fi7f
        Q3UhoJDcavlqptHJYZVmcoFb5ceuLnelJqu+yYU=
X-Google-Smtp-Source: ACHHUZ6iukiPsgRNUUzicBi4evqXXTMwCWGwm15He3kZZcIH/eHpOv31gtF/pvebU4KZC0bf/OR5FLXI4NJnB+ufPW4=
X-Received: by 2002:a1f:eb42:0:b0:453:8a02:8e7 with SMTP id
 j63-20020a1feb42000000b004538a0208e7mr1785832vkh.6.1684578054295; Sat, 20 May
 2023 03:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-3-amir73il@gmail.com>
 <CAJfpegtK7dJ1wa5NdruK1rPmJ9JgXujjyxFCGFBXnu=6u_KzLQ@mail.gmail.com>
In-Reply-To: <CAJfpegtK7dJ1wa5NdruK1rPmJ9JgXujjyxFCGFBXnu=6u_KzLQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 May 2023 13:20:43 +0300
Message-ID: <CAOQ4uxi=wWWeDb5BLQiOmMG02R-LRugy1TXCM7YU77K-7Ost0A@mail.gmail.com>
Subject: Re: [PATCH v13 02/10] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
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

On Fri, May 19, 2023 at 6:13=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > From: Alessio Balsini <balsini@android.com>
> >
> > Expose the FUSE_PASSTHROUGH capability to user space and declare all th=
e
> > basic data structures and functions as the skeleton on top of which the
> > FUSE passthrough functionality will be built.
> >
> > As part of this, introduce the new FUSE passthrough ioctl, which allows
> > the FUSE daemon to specify a direct connection between a FUSE file and =
a
> > backing file.  The ioctl requires user space to pass the file descripto=
r
> > of one of its opened files to the FUSE driver and get an id in return.
> > This id may be passed in a reply to OPEN with flag FOPEN_PASSTHROUGH
> > to setup passthrough of read/write operations on the open file.
> >
> > Also, add the passthrough functions for the set-up and tear-down of the
> > data structures and locks that will be used both when fuse_conns and
> > fuse_files are created/deleted.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/fuse/Makefile          |  1 +
> >  fs/fuse/dev.c             | 33 ++++++++++++++++++++++++--------
> >  fs/fuse/dir.c             |  7 ++++++-
> >  fs/fuse/file.c            | 17 +++++++++++++----
> >  fs/fuse/fuse_i.h          | 27 ++++++++++++++++++++++++++
> >  fs/fuse/inode.c           | 21 +++++++++++++++++++-
> >  fs/fuse/passthrough.c     | 40 +++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fuse.h | 13 +++++++++++--
> >  8 files changed, 143 insertions(+), 16 deletions(-)
> >  create mode 100644 fs/fuse/passthrough.c
> >
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 0c48b35c058d..d9e1b47382f3 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
> >  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> >
> >  fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir=
.o ioctl.o
> > +fuse-y +=3D passthrough.o
> >  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> >
> >  virtiofs-y :=3D virtio_fs.o
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 1a8f82f478cb..cb00234e7843 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2255,16 +2255,19 @@ static long fuse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                            unsigned long arg)
> >  {
> >         int res;
> > -       int oldfd;
> > -       struct fuse_dev *fud =3D NULL;
> > +       int fd, id;
> > +       struct fuse_dev *fud =3D fuse_get_dev(file);
>
> This is broken, see below.

IIUC, *this* is not broken for the new ioctls...

>
> >         struct fd f;
> >
> > +       if (!fud)
> > +               return -EINVAL;
> > +
> >         switch (cmd) {
> >         case FUSE_DEV_IOC_CLONE:
> > -               if (get_user(oldfd, (__u32 __user *)arg))
> > +               if (get_user(fd, (__u32 __user *)arg))
> >                         return -EFAULT;
> >
> > -               f =3D fdget(oldfd);
> > +               f =3D fdget(fd);
> >                 if (!f.file)
> >                         return -EINVAL;
> >
> > @@ -2272,17 +2275,31 @@ static long fuse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                  * Check against file->f_op because CUSE
> >                  * uses the same ioctl handler.
> >                  */
> > -               if (f.file->f_op =3D=3D file->f_op)
> > -                       fud =3D fuse_get_dev(f.file);
> > -
> >                 res =3D -EINVAL;
> > -               if (fud) {
> > +               if (f.file->f_op =3D=3D file->f_op) {

and this can be fixed by adding:
 +                           fud =3D fuse_get_dev(f.file);

> >                         mutex_lock(&fuse_mutex);
> >                         res =3D fuse_device_clone(fud->fc, file);
>
> We are cloning f.file into file not the other way round.  So fud must
> come from f.file.
>
>
> >                         mutex_unlock(&fuse_mutex);
> >                 }
> >                 fdput(f);
> >                 break;
> > +       case FUSE_DEV_IOC_PASSTHROUGH_OPEN:
> > +               if (get_user(fd, (__u32 __user *)arg))
> > +                       return -EFAULT;
> > +
> > +               f =3D fdget(fd);
> > +               if (!f.file)
> > +                       return -EINVAL;
> > +
> > +               res =3D fuse_passthrough_open(fud->fc, fd);
> > +               fdput(f);
> > +               break;
> > +       case FUSE_DEV_IOC_PASSTHROUGH_CLOSE:
> > +               if (get_user(id, (__u32 __user *)arg))
> > +                       return -EFAULT;
> > +
> > +               res =3D fuse_passthrough_close(fud->fc, id);
> > +               break;
> >         default:
> >                 res =3D -ENOTTY;
> >                 break;
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 35bc174f9ba2..1894298e7f7a 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -619,6 +619,7 @@ static int fuse_create_open(struct inode *dir, stru=
ct dentry *entry,
> >  {
> >         int err;
> >         struct inode *inode;
> > +       struct fuse_conn *fc =3D get_fuse_conn(dir);
> >         struct fuse_mount *fm =3D get_fuse_mount(dir);
> >         FUSE_ARGS(args);
> >         struct fuse_forget_link *forget;
> > @@ -700,7 +701,11 @@ static int fuse_create_open(struct inode *dir, str=
uct dentry *entry,
> >         d_instantiate(entry, inode);
> >         fuse_change_entry_timeout(entry, &outentry);
> >         fuse_dir_changed(dir);
> > -       err =3D finish_open(file, entry, generic_file_open);
> > +       err =3D 0;
> > +       if (ff->open_flags & FOPEN_PASSTHROUGH)
> > +               err =3D fuse_passthrough_setup(fc, ff, &outopen);
> > +       if (!err)
> > +               err =3D finish_open(file, entry, generic_file_open);
> >         if (err) {
> >                 fi =3D get_fuse_inode(inode);
> >                 fuse_sync_release(fi, ff, flags);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 89d97f6188e0..96a46a5aa892 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -132,6 +132,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount =
*fm, u64 nodeid,
> >         struct fuse_conn *fc =3D fm->fc;
> >         struct fuse_file *ff;
> >         int opcode =3D isdir ? FUSE_OPENDIR : FUSE_OPEN;
> > +       int err;
> >
> >         ff =3D fuse_file_alloc(fm);
> >         if (!ff)
> > @@ -142,16 +143,17 @@ struct fuse_file *fuse_file_open(struct fuse_moun=
t *fm, u64 nodeid,
> >         ff->open_flags =3D FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR =
: 0);
> >         if (isdir ? !fc->no_opendir : !fc->no_open) {
> >                 struct fuse_open_out outarg;
> > -               int err;
> >
> >                 err =3D fuse_send_open(fm, nodeid, open_flags, opcode, =
&outarg);
> >                 if (!err) {
> >                         ff->fh =3D outarg.fh;
> >                         ff->open_flags =3D outarg.open_flags;
> > -
> > +                       if (ff->open_flags & FOPEN_PASSTHROUGH)
> > +                               err =3D fuse_passthrough_setup(fc, ff, =
&outarg);
> > +                       if (err)
> > +                               goto out_free_ff;
> >                 } else if (err !=3D -ENOSYS) {
> > -                       fuse_file_free(ff);
> > -                       return ERR_PTR(err);
> > +                       goto out_free_ff;
> >                 } else {
> >                         if (isdir)
> >                                 fc->no_opendir =3D 1;
> > @@ -166,6 +168,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount=
 *fm, u64 nodeid,
> >         ff->nodeid =3D nodeid;
> >
> >         return ff;
> > +
> > +out_free_ff:
> > +       fuse_file_free(ff);
> > +       return ERR_PTR(err);
> >  }
> >
> >  int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
> > @@ -279,6 +285,9 @@ static void fuse_prepare_release(struct fuse_inode =
*fi, struct fuse_file *ff,
> >         struct fuse_conn *fc =3D ff->fm->fc;
> >         struct fuse_release_args *ra =3D ff->release_args;
> >
> > +       fuse_passthrough_put(ff->passthrough);
> > +       ff->passthrough =3D NULL;
> > +
> >         /* Inode is NULL on error path of fuse_create_open() */
> >         if (likely(fi)) {
> >                 spin_lock(&fi->lock);
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 9b7fc7d3c7f1..f52604534ff6 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -173,6 +173,16 @@ struct fuse_conn;
> >  struct fuse_mount;
> >  struct fuse_release_args;
> >
> > +/**
> > + * Reference to backing file for read/write operations in passthrough =
mode.
> > + */
> > +struct fuse_passthrough {
> > +       struct file *filp;
> > +
> > +       /** refcount */
> > +       refcount_t count;
> > +};
> > +
> >  /** FUSE specific file data */
> >  struct fuse_file {
> >         /** Fuse connection for this file */
> > @@ -218,6 +228,9 @@ struct fuse_file {
> >
> >         } readdir;
> >
> > +       /** Container for data related to the passthrough functionality=
 */
> > +       struct fuse_passthrough *passthrough;
> > +
> >         /** RB node to be linked on fuse_conn->polled_files */
> >         struct rb_node polled_node;
> >
> > @@ -792,6 +805,9 @@ struct fuse_conn {
> >         /* Is tmpfile not implemented by fs? */
> >         unsigned int no_tmpfile:1;
> >
> > +       /** Passthrough mode for read/write IO */
> > +       unsigned int passthrough:1;
> > +
> >         /** The number of requests waiting for completion */
> >         atomic_t num_waiting;
> >
> > @@ -841,6 +857,9 @@ struct fuse_conn {
> >
> >         /* New writepages go into this bucket */
> >         struct fuse_sync_bucket __rcu *curr_bucket;
> > +
> > +       /** IDR for passthrough files */
> > +       struct idr passthrough_files_map;
> >  };
> >
> >  /*
> > @@ -1324,4 +1343,12 @@ struct fuse_file *fuse_file_open(struct fuse_mou=
nt *fm, u64 nodeid,
> >  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
> >                        unsigned int open_flags, fl_owner_t id, bool isd=
ir);
> >
> > +/* passthrough.c */
> > +int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd);
> > +int fuse_passthrough_close(struct fuse_conn *fc, int passthrough_fh);
> > +int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
> > +                          struct fuse_open_out *openarg);
> > +void fuse_passthrough_put(struct fuse_passthrough *passthrough);
> > +void fuse_passthrough_free(struct fuse_passthrough *passthrough);
> > +
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index d66070af145d..271586fac008 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -840,6 +840,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fu=
se_mount *fm,
> >         INIT_LIST_HEAD(&fc->bg_queue);
> >         INIT_LIST_HEAD(&fc->entry);
> >         INIT_LIST_HEAD(&fc->devices);
> > +       idr_init(&fc->passthrough_files_map);
> >         atomic_set(&fc->num_waiting, 0);
> >         fc->max_background =3D FUSE_DEFAULT_MAX_BACKGROUND;
> >         fc->congestion_threshold =3D FUSE_DEFAULT_CONGESTION_THRESHOLD;
> > @@ -1209,6 +1210,12 @@ static void process_init_reply(struct fuse_mount=
 *fm, struct fuse_args *args,
> >                                 fc->init_security =3D 1;
> >                         if (flags & FUSE_CREATE_SUPP_GROUP)
> >                                 fc->create_supp_group =3D 1;
> > +                       if (flags & FUSE_PASSTHROUGH) {
> > +                               fc->passthrough =3D 1;
> > +                               /* Prevent further stacking */
> > +                               fm->sb->s_stack_depth =3D
> > +                                       FILESYSTEM_MAX_STACK_DEPTH;
> > +                       }
>
> Seems too restrictive.  We could specify the max stacking depth in the
> protocol and verify that when registering the passthrough file.
>
> I.e. fuse_sb->s_stack_depth of
>
> 0 -> passthrough disabled
> 1 -> backing_sb->s_stack_depth =3D=3D 0
> 2 -> backing_sb->stack_depth <=3D 1
> ...
>

Ok. Let's see.
What do we stand to gain from the ability to setup nax stacking depth?

We could use it to setup an overlayfs with lower FUSE that allows passthrou=
gh
fds to a non-stacked backing fs and we could use it to setup FUSE that allo=
ws
passthrough fds to overlayfs.

I pity the FUSE userspace developers that will need to understand this
setup parameter...
So ignoring the possibility of  FILESYSTEM_MAX_STACK_DEPTH changing in
the future, maybe better describe this with two capability flags
instead of an int?

FUSE_PASSTHROUGH_NESTED ???

Would NESTED mean max depth 1 or 2 through? ;-)

> >                 } else {
> >                         ra_pages =3D fc->max_read / PAGE_SIZE;
> >                         fc->no_lock =3D 1;
> > @@ -1254,7 +1261,8 @@ void fuse_send_init(struct fuse_mount *fm)
> >                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS=
 |
> >                 FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> >                 FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT=
_EXT |
> > -               FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
> > +               FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
> > +               FUSE_PASSTHROUGH;
> >  #ifdef CONFIG_FUSE_DAX
> >         if (fm->fc->dax)
> >                 flags |=3D FUSE_MAP_ALIGNMENT;
> > @@ -1287,9 +1295,20 @@ void fuse_send_init(struct fuse_mount *fm)
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_send_init);
> >
> > +static int fuse_passthrough_id_free(int id, void *p, void *data)
> > +{
> > +       struct fuse_passthrough *passthrough =3D p;
> > +
> > +       WARN_ON_ONCE(refcount_read(&passthrough->count) !=3D 1);
> > +       fuse_passthrough_free(passthrough);
> > +       return 0;
> > +}
> > +
> >  void fuse_free_conn(struct fuse_conn *fc)
> >  {
> >         WARN_ON(!list_empty(&fc->devices));
> > +       idr_for_each(&fc->passthrough_files_map, fuse_passthrough_id_fr=
ee, NULL);
> > +       idr_destroy(&fc->passthrough_files_map);
> >         kfree_rcu(fc, rcu);
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_free_conn);
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > new file mode 100644
> > index 000000000000..fc723e004de9
> > --- /dev/null
> > +++ b/fs/fuse/passthrough.c
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +

Alessio et. al.
I noticed that this file does not have any copyright in your original patch=
.

Do you mind if I retroactively add:

/*
 * FUSE passthrough support.
 *
 * Copyright (c) 2021 Google LLC.
 * Copyright (c) 2023 CTERA Networks.
 */

Thanks,
Amir.
