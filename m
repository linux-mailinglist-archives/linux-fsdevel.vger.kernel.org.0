Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97AD7298DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbjFIL6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjFIL6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:58:01 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8611735AD;
        Fri,  9 Jun 2023 04:57:32 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-786d74c317eso621593241.0;
        Fri, 09 Jun 2023 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686311851; x=1688903851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNSV+q4Tqz9JuuVN+6M0izWbHPbg8QS8M1gdsrJCElU=;
        b=TlemOSE19NslJ0txBg2dBg3Ho/doa+4Rf20idan3qHbw4DYkjdvw6qodbr7w9ZxA+v
         xNAMC2/UVKVUqfS6mq4FDZYTsxXAOyyg3fg/E/nOF5WRdTtZ35nNnTGreA+oWyIXPx5I
         5rgT0XBCkmCnZMk0540sWhEvnzWtA59ssqvCULaMuzavRCPyJM9H4x1COIsLGoDN9KfX
         3oQUAh9GCQiQYp2vU2/DKYCMXLRtNrS8i+nFky2JWFm7FCd+XjTrZzB0P7dMvHBgr2Fq
         fSPTHvsxCsvK1M95+OfCqsV97IdXWH8TYWwyGQsMdWjUkPwkxoC9fIdK6iEX5wWxs/T4
         YVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686311851; x=1688903851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNSV+q4Tqz9JuuVN+6M0izWbHPbg8QS8M1gdsrJCElU=;
        b=Hh0KjNj1oqQc882r8yQDFHZTZN2OdbZP29I2DHpwFo0ygT8XBvb/93B1AfgAG+5EAm
         5XnrWeXb/pZcoyyZTd824cBME4uXMoPf17Vz/7RKvma8GEKVN91GNhyN/vAInDUR7OrQ
         KKKMp8ayXEickYxjmBj+o/jVCH21Sj5vuqgDUJdFdyDE3bdrZ4xOaDaDRnMSJXu9yoJc
         HKxItBWdm114OT9skqf4EpQWGW3NF5bbreREMrLpUwIXPKgTPWCGrcskchlPFUBCNCgo
         IMYCsJzdzs8z5FbEwDKvqs+E1WvkddM6aKzKZc7RhbX00dmDRkjUT3txEkOT+Zrfw/Z9
         /HVA==
X-Gm-Message-State: AC+VfDxTqqhBHgBlLKjCS+BZkBjmLw+8lWZfs74xU6wmoITE3Tvzp4av
        +4zxoA7+t5f+4/5xeZs1JY/2g+Lo2xvvdaReXxhAcOYS+LI=
X-Google-Smtp-Source: ACHHUZ6dmIfnDjiS4x7lTOSx+ND7N2lAhQVmjep7NnrB/LSLNVLkMKwok0fkGOdAD+h8eIJjDwtPVgxYM5zNqo55sbE=
X-Received: by 2002:a67:d00e:0:b0:43b:3cab:23a8 with SMTP id
 r14-20020a67d00e000000b0043b3cab23a8mr661499vsi.20.1686311851319; Fri, 09 Jun
 2023 04:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <20230609073239.957184-2-amir73il@gmail.com>
 <20230609-umwandeln-zuhalten-dc8b985a7ad1@brauner>
In-Reply-To: <20230609-umwandeln-zuhalten-dc8b985a7ad1@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 14:57:20 +0300
Message-ID: <CAOQ4uxgR5z3yGqJ7jna=r45_Gru5LePU57XG++Ew_9pGWKcwCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs: use fake_file container for internal files with
 fake f_path
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
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

On Fri, Jun 9, 2023 at 2:32=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 09, 2023 at 10:32:37AM +0300, Amir Goldstein wrote:
> > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > files, where overlayfs also puts a "fake" path in f_path - a path which
> > is not on the same fs as f_inode.
> >
> > Allocate a container struct file_fake for those internal files, that
> > will be used to hold the fake path qlong with the real path.
> >
> > This commit does not populate the extra fake_path field and leaves the
> > overlayfs internal file's f_path fake.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/cachefiles/namei.c |  2 +-
> >  fs/file_table.c       | 85 +++++++++++++++++++++++++++++++++++--------
> >  fs/internal.h         |  5 ++-
> >  fs/namei.c            |  2 +-
> >  fs/open.c             | 11 +++---
> >  fs/overlayfs/file.c   |  2 +-
> >  include/linux/fs.h    | 13 ++++---
> >  7 files changed, 90 insertions(+), 30 deletions(-)
> >
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 82219a8f6084..a71bdf2d03ba 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -561,7 +561,7 @@ static bool cachefiles_open_file(struct cachefiles_=
object *object,
> >       path.mnt =3D cache->mnt;
> >       path.dentry =3D dentry;
> >       file =3D open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRE=
CT,
> > -                                d_backing_inode(dentry), cache->cache_=
cred);
> > +                                &path, cache->cache_cred);
> >       if (IS_ERR(file)) {
> >               trace_cachefiles_vfs_error(object, d_backing_inode(dentry=
),
> >                                          PTR_ERR(file),
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 372653b92617..adc2a92faa52 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -44,18 +44,48 @@ static struct kmem_cache *filp_cachep __read_mostly=
;
> >
> >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> >
> > +/* Container for file with optional fake path to display in /proc file=
s */
> > +struct file_fake {
> > +     struct file file;
> > +     struct path fake_path;
> > +};
> > +
> > +static inline struct file_fake *file_fake(struct file *f)
> > +{
> > +     return container_of(f, struct file_fake, file);
> > +}
> > +
> > +/* Returns fake_path if one exists, f_path otherwise */
> > +const struct path *file_fake_path(struct file *f)
> > +{
> > +     struct file_fake *ff =3D file_fake(f);
> > +
> > +     if (!(f->f_mode & FMODE_FAKE_PATH) || !ff->fake_path.dentry)
> > +             return &f->f_path;
> > +
> > +     return &ff->fake_path;
> > +}
> > +EXPORT_SYMBOL(file_fake_path);
> > +
> >  static void file_free_rcu(struct rcu_head *head)
> >  {
> >       struct file *f =3D container_of(head, struct file, f_rcuhead);
> >
> >       put_cred(f->f_cred);
> > -     kmem_cache_free(filp_cachep, f);
> > +     if (f->f_mode & FMODE_FAKE_PATH)
> > +             kfree(file_fake(f));
> > +     else
> > +             kmem_cache_free(filp_cachep, f);
> >  }
> >
> >  static inline void file_free(struct file *f)
> >  {
> > +     struct file_fake *ff =3D file_fake(f);
> > +
> >       security_file_free(f);
> > -     if (!(f->f_mode & FMODE_NOACCOUNT))
> > +     if (f->f_mode & FMODE_FAKE_PATH)
> > +             path_put(&ff->fake_path);
> > +     else
> >               percpu_counter_dec(&nr_files);
> >       call_rcu(&f->f_rcuhead, file_free_rcu);
> >  }
> > @@ -131,20 +161,15 @@ static int __init init_fs_stat_sysctls(void)
> >  fs_initcall(init_fs_stat_sysctls);
> >  #endif
> >
> > -static struct file *__alloc_file(int flags, const struct cred *cred)
> > +static int init_file(struct file *f, int flags, const struct cred *cre=
d)
> >  {
> > -     struct file *f;
> >       int error;
> >
> > -     f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > -     if (unlikely(!f))
> > -             return ERR_PTR(-ENOMEM);
> > -
> >       f->f_cred =3D get_cred(cred);
> >       error =3D security_file_alloc(f);
> >       if (unlikely(error)) {
> >               file_free_rcu(&f->f_rcuhead);
> > -             return ERR_PTR(error);
> > +             return error;
> >       }
> >
> >       atomic_long_set(&f->f_count, 1);
> > @@ -155,6 +180,22 @@ static struct file *__alloc_file(int flags, const =
struct cred *cred)
> >       f->f_mode =3D OPEN_FMODE(flags);
> >       /* f->f_version: 0 */
> >
> > +     return 0;
> > +}
> > +
> > +static struct file *__alloc_file(int flags, const struct cred *cred)
> > +{
> > +     struct file *f;
> > +     int error;
> > +
> > +     f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > +     if (unlikely(!f))
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     error =3D init_file(f, flags, cred);
> > +     if (unlikely(error))
> > +             return ERR_PTR(error);
> > +
> >       return f;
> >  }
> >
> > @@ -201,18 +242,32 @@ struct file *alloc_empty_file(int flags, const st=
ruct cred *cred)
> >  }
> >
> >  /*
> > - * Variant of alloc_empty_file() that doesn't check and modify nr_file=
s.
> > + * Variant of alloc_empty_file() that allocates a file_fake container
> > + * and doesn't check and modify nr_files.
> >   *
> >   * Should not be used unless there's a very good reason to do so.
> >   */
> > -struct file *alloc_empty_file_noaccount(int flags, const struct cred *=
cred)
> > +struct file *alloc_empty_file_fake(const struct path *fake_path, int f=
lags,
> > +                                const struct cred *cred)
> >  {
> > -     struct file *f =3D __alloc_file(flags, cred);
> > +     struct file_fake *ff;
> > +     int error;
> >
> > -     if (!IS_ERR(f))
> > -             f->f_mode |=3D FMODE_NOACCOUNT;
> > +     ff =3D kzalloc(sizeof(struct file_fake), GFP_KERNEL);
> > +     if (unlikely(!ff))
> > +             return ERR_PTR(-ENOMEM);
> >
> > -     return f;
> > +     error =3D init_file(&ff->file, flags, cred);
> > +     if (unlikely(error))
> > +             return ERR_PTR(error);
> > +
> > +     ff->file.f_mode |=3D FMODE_FAKE_PATH;
> > +     if (fake_path) {
> > +             path_get(fake_path);
> > +             ff->fake_path =3D *fake_path;
> > +     }
>
> Hm, I see that this check is mostly done for vfs_tmpfile_open() which
> only fills in file->f_path in vfs_tmpfile() but leaves ff->fake_path
> NULL.
>
> So really I think having FMODE_FAKE_PATH set but ff->fake_path be NULL
> is an invitation for NULL derefs sooner or later. I would simply
> document that it's required to set ff->fake_path. For callers such as
> vfs_tmpfile_open() it can just be path itself. IOW, vfs_tmpfile_open()
> should set ff->fake_path to file->f_path.

Makes sense.
I also took the liberty to re-arrange vfs_tmpfile_open() without the
unneeded if (!error) { nesting depth.

Thanks,
Amir.
