Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05572B384
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjFKTLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFKTLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:11:43 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3B9F;
        Sun, 11 Jun 2023 12:11:42 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-786f7e1ea2fso1036874241.3;
        Sun, 11 Jun 2023 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686510701; x=1689102701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+0XjLNqdv1cjDkreG0lm/3u/uCvjjs0ca/sTaQKB20=;
        b=mstAc9rYO1NuN7psSQA00Fx645Uy5+GjV4bBzbqmRsC25LIqJO9VYMESULI+pgEw15
         zdGGZHOzEVDQ2mG0Y5kfOd9KNTY66Bnfj7rctbw708Xjb1v0PFCCEZxUmKIYecyrn6L4
         CXIIHjxBx8uxnJ9M1EcmFYpOKm/ipK6VT6SuMxLHH5R7ns9AGPAjGEZQr+etS2IGGf4X
         pQ24BVRzGUVyEOU/XtRotgLoHQpCgZrj2pcCpjWeglTC+7gtSUdrys3U10xrqOG8+SG9
         T4iCdqIw7HP9RsmxVrf+7J06Ct29b6l24wPQtR6ybKOAKTBSrrmKO8eAhklc+lYQKZEK
         BM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686510701; x=1689102701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+0XjLNqdv1cjDkreG0lm/3u/uCvjjs0ca/sTaQKB20=;
        b=ABUsr8pN3KbwqUtbhFp7rl+D4azGH+l1++VLhe142dwkFJD7X51P1P8pbtcQHbd3rp
         4gO5mIlbDKa6R7Nr/TeZE7rRB1yugow/sLYLwecBJDiapThvVyiqmubCFYub37Qr3ObS
         xDvlPBDhGO7GG+zyafCkG+QWenqeNawzF4oSSD7XZk6rhn8J87T6AXyeDWgNIsu40ZGv
         ++ghONhOJ5MkMX2DOy3jaYBEgHJcFA5wLx7T1PRXDsyu0nmuDhEQYUladj8rGbSp0GgT
         L3XZxP0h6WcthQxHB9G0AFi2irqXgPrUsyFjsStBBPIwomW1pG4mVt9vX7yWaS1PZXUz
         +J7w==
X-Gm-Message-State: AC+VfDxGTExaCtEYnmCpIz/3OKn6jG4x+FXO8eSHODe7rVSFEFS7ZNuj
        kV84He+iUugsGrwjgejiBiXYkfVk8hdaU/GjZLzA4bEo
X-Google-Smtp-Source: ACHHUZ6uFMcbvmq196ahBkk9G4ZxG2S/3x1STy7CDdoPWsDt4Ii/b/fL1nItXf/OuOHjBCbIJXuytNjbEhx5vvxo+zY=
X-Received: by 2002:a67:d00d:0:b0:43d:e8c5:7998 with SMTP id
 r13-20020a67d00d000000b0043de8c57998mr1916700vsi.1.1686510701076; Sun, 11 Jun
 2023 12:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <20230609073239.957184-2-amir73il@gmail.com>
 <20230609-umwandeln-zuhalten-dc8b985a7ad1@brauner> <CAOQ4uxgR5z3yGqJ7jna=r45_Gru5LePU57XG++Ew_9pGWKcwCQ@mail.gmail.com>
 <20230609-fakten-bildt-4bda22b203f8@brauner>
In-Reply-To: <20230609-fakten-bildt-4bda22b203f8@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Jun 2023 22:11:29 +0300
Message-ID: <CAOQ4uxi0q1AawSbxC0Fo3+bifjW0EGSk0m-iBA54Nq+36_70wg@mail.gmail.com>
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

On Fri, Jun 9, 2023 at 3:12=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 09, 2023 at 02:57:20PM +0300, Amir Goldstein wrote:
> > On Fri, Jun 9, 2023 at 2:32=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Jun 09, 2023 at 10:32:37AM +0300, Amir Goldstein wrote:
> > > > Overlayfs and cachefiles use open_with_fake_path() to allocate inte=
rnal
> > > > files, where overlayfs also puts a "fake" path in f_path - a path w=
hich
> > > > is not on the same fs as f_inode.
> > > >
> > > > Allocate a container struct file_fake for those internal files, tha=
t
> > > > will be used to hold the fake path qlong with the real path.
> > > >
> > > > This commit does not populate the extra fake_path field and leaves =
the
> > > > overlayfs internal file's f_path fake.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/cachefiles/namei.c |  2 +-
> > > >  fs/file_table.c       | 85 +++++++++++++++++++++++++++++++++++----=
----
> > > >  fs/internal.h         |  5 ++-
> > > >  fs/namei.c            |  2 +-
> > > >  fs/open.c             | 11 +++---
> > > >  fs/overlayfs/file.c   |  2 +-
> > > >  include/linux/fs.h    | 13 ++++---
> > > >  7 files changed, 90 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > > > index 82219a8f6084..a71bdf2d03ba 100644
> > > > --- a/fs/cachefiles/namei.c
> > > > +++ b/fs/cachefiles/namei.c
> > > > @@ -561,7 +561,7 @@ static bool cachefiles_open_file(struct cachefi=
les_object *object,
> > > >       path.mnt =3D cache->mnt;
> > > >       path.dentry =3D dentry;
> > > >       file =3D open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_=
DIRECT,
> > > > -                                d_backing_inode(dentry), cache->ca=
che_cred);
> > > > +                                &path, cache->cache_cred);
> > > >       if (IS_ERR(file)) {
> > > >               trace_cachefiles_vfs_error(object, d_backing_inode(de=
ntry),
> > > >                                          PTR_ERR(file),
> > > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > > index 372653b92617..adc2a92faa52 100644
> > > > --- a/fs/file_table.c
> > > > +++ b/fs/file_table.c
> > > > @@ -44,18 +44,48 @@ static struct kmem_cache *filp_cachep __read_mo=
stly;
> > > >
> > > >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> > > >
> > > > +/* Container for file with optional fake path to display in /proc =
files */
> > > > +struct file_fake {
> > > > +     struct file file;
> > > > +     struct path fake_path;
> > > > +};
> > > > +
> > > > +static inline struct file_fake *file_fake(struct file *f)
> > > > +{
> > > > +     return container_of(f, struct file_fake, file);
> > > > +}
> > > > +
> > > > +/* Returns fake_path if one exists, f_path otherwise */
> > > > +const struct path *file_fake_path(struct file *f)
> > > > +{
> > > > +     struct file_fake *ff =3D file_fake(f);
> > > > +
> > > > +     if (!(f->f_mode & FMODE_FAKE_PATH) || !ff->fake_path.dentry)
> > > > +             return &f->f_path;
> > > > +
> > > > +     return &ff->fake_path;
> > > > +}
> > > > +EXPORT_SYMBOL(file_fake_path);
> > > > +
> > > >  static void file_free_rcu(struct rcu_head *head)
> > > >  {
> > > >       struct file *f =3D container_of(head, struct file, f_rcuhead)=
;
> > > >
> > > >       put_cred(f->f_cred);
> > > > -     kmem_cache_free(filp_cachep, f);
> > > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > > +             kfree(file_fake(f));
> > > > +     else
> > > > +             kmem_cache_free(filp_cachep, f);
> > > >  }
> > > >
> > > >  static inline void file_free(struct file *f)
> > > >  {
> > > > +     struct file_fake *ff =3D file_fake(f);
> > > > +
> > > >       security_file_free(f);
> > > > -     if (!(f->f_mode & FMODE_NOACCOUNT))
> > > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > > +             path_put(&ff->fake_path);
> > > > +     else
> > > >               percpu_counter_dec(&nr_files);
> > > >       call_rcu(&f->f_rcuhead, file_free_rcu);
> > > >  }
> > > > @@ -131,20 +161,15 @@ static int __init init_fs_stat_sysctls(void)
> > > >  fs_initcall(init_fs_stat_sysctls);
> > > >  #endif
> > > >
> > > > -static struct file *__alloc_file(int flags, const struct cred *cre=
d)
> > > > +static int init_file(struct file *f, int flags, const struct cred =
*cred)
> > > >  {
> > > > -     struct file *f;
> > > >       int error;
> > > >
> > > > -     f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > > > -     if (unlikely(!f))
> > > > -             return ERR_PTR(-ENOMEM);
> > > > -
> > > >       f->f_cred =3D get_cred(cred);
> > > >       error =3D security_file_alloc(f);
> > > >       if (unlikely(error)) {
> > > >               file_free_rcu(&f->f_rcuhead);
> > > > -             return ERR_PTR(error);
> > > > +             return error;
> > > >       }
> > > >
> > > >       atomic_long_set(&f->f_count, 1);
> > > > @@ -155,6 +180,22 @@ static struct file *__alloc_file(int flags, co=
nst struct cred *cred)
> > > >       f->f_mode =3D OPEN_FMODE(flags);
> > > >       /* f->f_version: 0 */
> > > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static struct file *__alloc_file(int flags, const struct cred *cre=
d)
> > > > +{
> > > > +     struct file *f;
> > > > +     int error;
> > > > +
> > > > +     f =3D kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > > > +     if (unlikely(!f))
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     error =3D init_file(f, flags, cred);
> > > > +     if (unlikely(error))
> > > > +             return ERR_PTR(error);
> > > > +
> > > >       return f;
> > > >  }
> > > >
> > > > @@ -201,18 +242,32 @@ struct file *alloc_empty_file(int flags, cons=
t struct cred *cred)
> > > >  }
> > > >
> > > >  /*
> > > > - * Variant of alloc_empty_file() that doesn't check and modify nr_=
files.
> > > > + * Variant of alloc_empty_file() that allocates a file_fake contai=
ner
> > > > + * and doesn't check and modify nr_files.
> > > >   *
> > > >   * Should not be used unless there's a very good reason to do so.
> > > >   */
> > > > -struct file *alloc_empty_file_noaccount(int flags, const struct cr=
ed *cred)
> > > > +struct file *alloc_empty_file_fake(const struct path *fake_path, i=
nt flags,
> > > > +                                const struct cred *cred)
> > > >  {
> > > > -     struct file *f =3D __alloc_file(flags, cred);
> > > > +     struct file_fake *ff;
> > > > +     int error;
> > > >
> > > > -     if (!IS_ERR(f))
> > > > -             f->f_mode |=3D FMODE_NOACCOUNT;
> > > > +     ff =3D kzalloc(sizeof(struct file_fake), GFP_KERNEL);
> > > > +     if (unlikely(!ff))
> > > > +             return ERR_PTR(-ENOMEM);
> > > >
> > > > -     return f;
> > > > +     error =3D init_file(&ff->file, flags, cred);
> > > > +     if (unlikely(error))
> > > > +             return ERR_PTR(error);
> > > > +
> > > > +     ff->file.f_mode |=3D FMODE_FAKE_PATH;
> > > > +     if (fake_path) {
> > > > +             path_get(fake_path);
> > > > +             ff->fake_path =3D *fake_path;
> > > > +     }
> > >
> > > Hm, I see that this check is mostly done for vfs_tmpfile_open() which
> > > only fills in file->f_path in vfs_tmpfile() but leaves ff->fake_path
> > > NULL.
> > >
> > > So really I think having FMODE_FAKE_PATH set but ff->fake_path be NUL=
L
> > > is an invitation for NULL derefs sooner or later. I would simply
> > > document that it's required to set ff->fake_path. For callers such as
> > > vfs_tmpfile_open() it can just be path itself. IOW, vfs_tmpfile_open(=
)
> > > should set ff->fake_path to file->f_path.
> >
> > Makes sense.
> > I also took the liberty to re-arrange vfs_tmpfile_open() without the
> > unneeded if (!error) { nesting depth.
>
> Yes, please. I had a rough sketch just for my own amusement...
>
> fs/namei.c
>   struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
>                                 const struct path *parentpath, umode_t mo=
de,
>                                 int open_flag, const struct cred *cred)
>   {
>           struct file *file;
>           int error;
>
>           file =3D alloc_empty_file_fake(open_flag, cred);
>           if (IS_ERR(file))
>                   return file;
>
>           error =3D vfs_tmpfile(idmap, parentpath, file, mode);
>           if (error) {
>                   fput(file);
>                   return ERR_PTR(error);
>           }
>
>           return file_set_fake_path(file, &file->f_path);

FYI, this is not enough to guarantee that the fake_path cannot
be empty, for example in fput() above.
So I did keep the real_path empty in this case in v3 and
I have an accessor that verifies that real_path is not empty
before returning it.

Thanks,
Amir.
