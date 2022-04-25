Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A477F50D8CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 07:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbiDYF3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 01:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbiDYF33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:29:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8719AE79;
        Sun, 24 Apr 2022 22:26:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h12so20820107plf.12;
        Sun, 24 Apr 2022 22:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6n/OL5RtRKry/ejJnnG0sV+EXhOC8aEsPGzLqFNOZM=;
        b=lydlBm/tNmLJWApowx99avQXyIPLq2r8KLWKVcGdC+QmyA2F8jQ3jV/FEeYnfhrzBM
         9krNNABMNGSdUKYyShYc0LZgEk+qI0EBfAdbjRPkC3fpQ54aXt5Kp/w3cNBB2iY0zRb+
         iCv3QLK1RwVs44KsJdAnQM99LgVSnaDMrWvvXmt5voTiDzt8PW6WXzSVrDkOkeDruKB8
         uVNCtjsq/kgr3E3End1HEaj2M/4M67W3ow6dVY0RQOiTFpRhlSAaBbXSUmVvNwNEBwas
         pJiqOa6NvFtlWUP0SkukMPm1drBcbtAZTMtzhadtCyERzPhas5sO+BpreKu+RLenMCeF
         lEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6n/OL5RtRKry/ejJnnG0sV+EXhOC8aEsPGzLqFNOZM=;
        b=YSMQZSfMWPvLftHJnSmbL/NWfvqfXT2e1yV5FFZoDAwLz+9PxJ8F/cC5lW3EHOC4tT
         63+uyXqpH2Qdm1fpunuS77UXal6dqAGUH0M4Gt4NlSIfo0KxqyJ5pbjPuAAg0fSew9it
         P1IcOe6A7QFHeOBMz3p1lyR8kC3ixHromMR15f0QH5HuNAUZ8+8lelQVxMeKG6Gu3DSw
         yJIG6a0mduj5ZHaubcAcyRXtSLHORI1yvsqASCUSQlj1O0FJZIKdfJffm61jT2wG6zTT
         8SEf2yHcW6d4tpSmZILNPDHK8iX66Cjvohni/iQlyveSaJrDct8/z0AUDDJCgt96K8sQ
         p+FQ==
X-Gm-Message-State: AOAM531P9GDNagC7rAz8+UlLbHp8EgI+L0Gc9tX5tbAvYFq5U4zF2SB5
        kzEghI+MnVZ42gqnarXyU6y6XjDcd8iBQ4uBSPo=
X-Google-Smtp-Source: ABdhPJyRqW+rG2UAK2v3fSFuTf7ikn6iiQMsspZDgZj5FYV7pjAHAZwSWrE1XfnhEKIdH0efhV21XxhpyT5X4CnwnbI=
X-Received: by 2002:a17:90b:4f48:b0:1d1:d1ba:2aa5 with SMTP id
 pj8-20020a17090b4f4800b001d1d1ba2aa5mr29304583pjb.116.1650864385128; Sun, 24
 Apr 2022 22:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com> <20220322115148.3870-2-dharamhans87@gmail.com>
 <CAJfpegtunCe5hV1b9cKJgPk44B2SQgtK3RG5r2is8V5VrMYeNg@mail.gmail.com>
In-Reply-To: <CAJfpegtunCe5hV1b9cKJgPk44B2SQgtK3RG5r2is8V5VrMYeNg@mail.gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Mon, 25 Apr 2022 10:55:56 +0530
Message-ID: <CACUYsyGmab57_efkXRXD8XvO6Stn4JbJM8+NfBHNKQ+FLcA7nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] FUSE: Implement atomic lookup + open
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 8:59 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 22 Mar 2022 at 12:52, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >
> > From: Dharmendra Singh <dsingh@ddn.com>
> >
> > There are couple of places in FUSE where we do agressive
> > lookup.
> > 1) When we go for creating a file (O_CREAT), we do lookup
> > for non-existent file. It is very much likely that file
> > does not exists yet as O_CREAT is passed to open(). This
> > lookup can be avoided and can be performed  as part of
> > open call into libfuse.
> >
> > 2) When there is normal open for file/dir (dentry is
> > new/negative). In this case since we are anyway going to open
> > the file/dir with USER space, avoid this separate lookup call
> > into libfuse and combine it with open.
> >
> > This lookup + open in single call to libfuse and finally to
> > USER space has been named as atomic open. It is expected
> > that USER space open the file and fills in the attributes
> > which are then used to make inode stand/revalidate in the
> > kernel cache.
> >
> > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > ---
> > v2 patch includes:
> > - disabled o-create atomicity when the user space file system
> >   does not have an atomic_open implemented. In principle lookups
> >   for O_CREATE also could be optimized out, but there is a risk
> >   to break existing fuse file systems. Those file system might
> >   not expect open O_CREATE calls for exiting files, as these calls
> >   had been so far avoided as lookup was done first.
>
> So we enabling atomic lookup+create only if FUSE_DO_ATOMIC_OPEN is
> set.  This logic is a bit confusing as CREATE is unrelated to
> ATOMIC_OPEN.   It would be cleaner to have a separate flag for atomic
> lookup+create.  And in fact FUSE_DO_ATOMIC_OPEN could be dropped and
> the usual logic of setting fc->no_atomic_open if ENOSYS is returned
> could be used instead.

I am aware that ATOMIC_OPEN is not directly related to CREATE. But
This is more of feature enabling by using the flag. If we do not
FUSE_DO_ATOMIC_OPEN, CREATE calls would not know that it need to
optimize lookup calls otherwise as we know only from open call that
atomic open is implemented. So workloads or performance measuring
applications such as bonnie++ would not be showing improvements for
CREATE, it would not be making 'open' calls. And it is only in open
calls we set fc->do_atomic_open.

>
> >
> >  fs/fuse/dir.c             | 113 +++++++++++++++++++++++++++++++-------
> >  fs/fuse/fuse_i.h          |   3 +
> >  fs/fuse/inode.c           |   4 +-
> >  include/uapi/linux/fuse.h |   2 +
> >  4 files changed, 101 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 656e921f3506..b2613eb87a4e 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -516,16 +516,14 @@ static int get_security_context(struct dentry *entry, umode_t mode,
> >  }
> >
> >  /*
> > - * Atomic create+open operation
> > - *
> > - * If the filesystem doesn't support this, then fall back to separate
> > - * 'mknod' + 'open' requests.
> > + * Perform create + open or lookup + open in single call to libfuse
> >   */
> > -static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > -                           struct file *file, unsigned int flags,
> > -                           umode_t mode)
> > +static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
> > +                                  struct dentry **alias, struct file *file,
> > +                                  unsigned int flags, umode_t mode,
> > +                                  uint32_t opcode)
> >  {
> > -       int err;
> > +       bool create = (opcode == FUSE_CREATE ? true : false);
> >         struct inode *inode;
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> >         FUSE_ARGS(args);
> > @@ -535,11 +533,16 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         struct fuse_entry_out outentry;
> >         struct fuse_inode *fi;
> >         struct fuse_file *ff;
> > +       struct dentry *res = NULL;
> >         void *security_ctx = NULL;
> >         u32 security_ctxlen;
> > +       int err;
> > +
> > +       if (alias)
> > +               *alias = NULL;
> >
> >         /* Userspace expects S_IFREG in create mode */
> > -       BUG_ON((mode & S_IFMT) != S_IFREG);
> > +       BUG_ON(create && (mode & S_IFMT) != S_IFREG);
> >
> >         forget = fuse_alloc_forget();
> >         err = -ENOMEM;
> > @@ -554,7 +557,13 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         if (!fm->fc->dont_mask)
> >                 mode &= ~current_umask();
> >
> > -       flags &= ~O_NOCTTY;
> > +       if (!create) {
> > +               flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
>
> We know O_CREAT and O_EXCL are not set in this case.

Would remove it

>
> > +               if (!fm->fc->atomic_o_trunc)
> > +                       flags &= ~O_TRUNC;
>
> I think atomic_open should imply atomic_o_trunc.  Not worth
> complicating this further with a separate case.

 I see. So if atomic open is enabled, we should be truncating file as
part of this atomic open call itself despite  fc->atomic_o_trunc is
set or not. Would make changes here.

>
> > +       } else {
> > +               flags &= ~O_NOCTTY;
> > +       }
> >         memset(&inarg, 0, sizeof(inarg));
> >         memset(&outentry, 0, sizeof(outentry));
> >         inarg.flags = flags;
> > @@ -566,7 +575,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >                 inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> >         }
> >
> > -       args.opcode = FUSE_CREATE;
> > +       args.opcode = opcode;
> >         args.nodeid = get_node_id(dir);
> >         args.in_numargs = 2;
> >         args.in_args[0].size = sizeof(inarg);
> > @@ -595,8 +604,12 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         if (err)
> >                 goto out_free_ff;
> >
> > +       err = -ENOENT;
> > +       if (!S_ISDIR(outentry.attr.mode) && !outentry.nodeid)
> > +               goto out_free_ff;
> > +
> >         err = -EIO;
> > -       if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
> > +       if (invalid_nodeid(outentry.nodeid) ||
> >             fuse_invalid_attr(&outentry.attr))
> >                 goto out_free_ff;
> >
> > @@ -612,10 +625,32 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >                 err = -ENOMEM;
> >                 goto out_err;
> >         }
> > +       if (!fm->fc->do_atomic_open)
> > +               d_instantiate(entry, inode);
> > +       else {
> > +               res = d_splice_alias(inode, entry);
> > +               if (res) {
> > +                       /* Close the file in user space, but do not unlink it,
> > +                        * if it was created - with network file systems other
> > +                        * clients might have already accessed it.
> > +                        */
> > +                       if (IS_ERR(res)) {
> > +                               fi = get_fuse_inode(inode);
> > +                               fuse_sync_release(fi, ff, flags);
> > +                               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> > +                               err = PTR_ERR(res);
> > +                               goto out_err;
> > +                       } else {
> > +                               entry = res;
> > +                               if (alias)
> > +                                       *alias = res;
> > +                       }
> > +               }
> > +       }
> >         kfree(forget);
> > -       d_instantiate(entry, inode);
> >         fuse_change_entry_timeout(entry, &outentry);
> > -       fuse_dir_changed(dir);
> > +       if (create)
> > +               fuse_dir_changed(dir);
>
> This will invalidate the parent even if the file was not created.
> Userspace will have to indicate whether the file was created or not as
> the kernel won't be able to determine this otherwise.  This affects
> permission checking as well.

Thanks, I see. I would check if we can pass a flag from libfuse to
fuse kernel and check here for the same in case file was actually
created or not.

> >         err = finish_open(file, entry, generic_file_open);
> >         if (err) {
> >                 fi = get_fuse_inode(inode);
> > @@ -634,20 +669,54 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         return err;
> >  }
> >
> > +/*
> > + * Atomic lookup + open
> > + */
> > +
> > +static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
> > +                              struct dentry **alias, struct file *file,
> > +                              unsigned int flags, umode_t mode)
> > +{
> > +       int err;
> > +       struct fuse_conn *fc = get_fuse_conn(dir);
> > +
> > +       if (!fc->do_atomic_open)
> > +               return -ENOSYS;
> > +       err = fuse_atomic_open_common(dir, entry, alias, file,
> > +                                     flags, mode, FUSE_ATOMIC_OPEN);
> > +       return err;
> > +}
> > +
> >  static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
> >                       umode_t, dev_t);
> >  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> >                             struct file *file, unsigned flags,
> >                             umode_t mode)
> >  {
> > -       int err;
> > +       bool create = (flags & O_CREAT) ? true : false;
> >         struct fuse_conn *fc = get_fuse_conn(dir);
> > -       struct dentry *res = NULL;
> > +       struct dentry *res = NULL, *alias = NULL;
> > +       int err;
> >
> >         if (fuse_is_bad(dir))
> >                 return -EIO;
> >
> > -       if (d_in_lookup(entry)) {
> > +       /* Atomic lookup + open - dentry might be File or Directory */
> > +       if (!create) {
> > +               err = fuse_do_atomic_open(dir, entry, &alias, file, flags, mode);
> > +               res = alias;
> > +               if (!err)
> > +                       goto out_dput;
> > +               else if (err != -ENOSYS)
> > +                       goto no_open;
>
> The above looks bogus.  On error we just want to return that error,
> not finish the open.

Thanks for pointing it out. I would handle error return.
