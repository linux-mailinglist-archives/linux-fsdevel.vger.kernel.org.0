Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80935ADEB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 06:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiIFE7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 00:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiIFE7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:59:05 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385F69F58
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 21:59:04 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a18so3928778uak.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Sep 2022 21:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n3vosyg6TixE5PUWrIh6OHNWjjfFIRc0D+/0wQaOfeY=;
        b=R6DzKrH/2vdecAj44ouE9neH40lG2xiq9QPq8D4OYBdW/btV/M6ilxRM33mPX8tzGQ
         q5yr2ivN1z/Sx8o9pMkLVZZz4nSmvaQjwnqfSbqubE8bElXEsiqfnFqX3bK5UWl4gOS3
         pdzpCfS6mh7DerCKzl32OwLMwL0LwGiDIZ432ndL+XjQgdjj6dUZ/0+lsUIoaVF4/Lji
         q36FvKUJIP2qrlsnJA+upoC4jt9GkBxUWIFaEqdrYFXqgmKVzKoecOiMhRgSemGzTJ/k
         E6NO3Ezib/cEbipsDs9BgUqTwoBW1UHFP7JvtHHe409k5dTaiEEIVh83xGTVNEyzcRYy
         twQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n3vosyg6TixE5PUWrIh6OHNWjjfFIRc0D+/0wQaOfeY=;
        b=Spa9mjrcK4NFkYtYAAReZlDQz1HtsDyJdrIOTzXcTT1voyVVLGhW/yYjm0YbBXEe3Z
         J/PPoDQ86/ZWvmjbP4Srots2kZMgb2G7oriZ/JOcokh+sqhyRkO5bK4GSyXzHzKEzuow
         r7PNX4Pfj/yUNptDI9OW11T4OrXSsbsFGcqwqY5UQx+3mn1X++RxceMTTkIMrm6HwEaW
         dx+Diu6EY0gxySC+HBxmPkkN/oGkT1CP7QddaYmdOYsDGFcNCqJIziOQMq8di5ju7G9a
         8kk9IAciUQbaOur0MIsxoAG8Bwanb4gVIWfdX2za1Kk8NUyOQeZONkNalVoNe5M+Z6TU
         Ox0g==
X-Gm-Message-State: ACgBeo22E1p7+/ROmOUvYo28QxNWNeuF7TUrU7cSoImAnT+xkz9b9hH+
        0IoDz3NvoHDIFDH7eGdOnaVKx67gTOkeaYG1EsU=
X-Google-Smtp-Source: AA6agR4SiEsJYlcXUEg6pfPMPInjhfk+h5vHYSszuWrdCzc4YVgn/xpoz244Ry1lmerOqs/xt8Tp7Cfm3UNkzkzExT4=
X-Received: by 2002:ab0:3b89:0:b0:39f:6dee:d6b with SMTP id
 p9-20020ab03b89000000b0039f6dee0d6bmr15568162uaw.102.1662440342978; Mon, 05
 Sep 2022 21:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com> <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
 <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com> <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com>
In-Reply-To: <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Sep 2022 07:58:50 +0300
Message-ID: <CAOQ4uxiK-nwpu8eNFByfHgfmEehMD9OEktjNF39ZY2v2NJMBmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Yu-li Lin <yulilin@google.com>, chirantan@chromium.org,
        dgreid@chromium.org, fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        suleiman@chromium.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 5, 2022 at 7:25 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Aug 31, 2022 at 02:30:40PM -0700, Yu-li Lin wrote:
> > Thanks for the reference. IIUC, the consensus is to make it atomic,
> > although there's no agreement on how it should be done. Does that mean
> > we should hold off on
> > this patch until atomic temp files are figured out higher in the stack
> > or do you have thoughts on how the fuse uapi should look like prior to
> > the vfs/refactoring decision?
>
> Here's a patch refactoring the tmpfile kapi to return an open file instead of a
> dentry.
>
> Comments?

IDGI. Why did you need to place do_dentry_open() in all the implementations
and not inside vfs_tmpfile_new()?
Am I missing something?

Thanks,
Amir.

>
> Thanks,
> Miklos
>
> ---
>  fs/bad_inode.c           |    2
>  fs/btrfs/inode.c         |   12 +++--
>  fs/cachefiles/namei.c    |    3 -
>  fs/ext2/namei.c          |    6 +-
>  fs/ext4/namei.c          |   15 ++++--
>  fs/f2fs/namei.c          |    9 +++-
>  fs/hugetlbfs/inode.c     |    9 +++-
>  fs/minix/namei.c         |    9 ++--
>  fs/namei.c               |  101 ++++++++++++++++++++++++++---------------------
>  fs/open.c                |    7 +++
>  fs/overlayfs/overlayfs.h |    3 -
>  fs/ramfs/inode.c         |    6 +-
>  fs/ubifs/dir.c           |    5 +-
>  fs/udf/namei.c           |    6 +-
>  fs/xfs/xfs_iops.c        |    9 +++-
>  include/linux/fs.h       |    6 +-
>  mm/shmem.c               |   12 +++--
>  17 files changed, 138 insertions(+), 82 deletions(-)
>
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -147,7 +147,7 @@ static int bad_inode_atomic_open(struct
>  }
>
>  static int bad_inode_tmpfile(struct user_namespace *mnt_userns,
> -                            struct inode *inode, struct dentry *dentry,
> +                            struct inode *inode, struct file *file,
>                              umode_t mode)
>  {
>         return -EIO;
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10169,7 +10169,7 @@ static int btrfs_permission(struct user_
>  }
>
>  static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                        struct dentry *dentry, umode_t mode)
> +                        struct file *file, umode_t mode)
>  {
>         struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
>         struct btrfs_trans_handle *trans;
> @@ -10177,7 +10177,7 @@ static int btrfs_tmpfile(struct user_nam
>         struct inode *inode;
>         struct btrfs_new_inode_args new_inode_args = {
>                 .dir = dir,
> -               .dentry = dentry,
> +               .dentry = file->f_path.dentry,
>                 .orphan = true,
>         };
>         unsigned int trans_num_items;
> @@ -10214,7 +10214,7 @@ static int btrfs_tmpfile(struct user_nam
>         set_nlink(inode, 1);
>
>         if (!ret) {
> -               d_tmpfile(dentry, inode);
> +               d_tmpfile(file->f_path.dentry, inode);
>                 unlock_new_inode(inode);
>                 mark_inode_dirty(inode);
>         }
> @@ -10224,9 +10224,11 @@ static int btrfs_tmpfile(struct user_nam
>  out_new_inode_args:
>         btrfs_new_inode_args_destroy(&new_inode_args);
>  out_inode:
> -       if (ret)
> +       if (ret) {
>                 iput(inode);
> -       return ret;
> +               return ret;
> +       }
> +       return finish_tmpfile(file);
>  }
>
>  void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -459,9 +459,10 @@ struct file *cachefiles_create_tmpfile(s
>         cachefiles_begin_secure(cache, &saved_cred);
>
>         path.mnt = cache->mnt;
> +       path.dentry = fan;
>         ret = cachefiles_inject_write_error();
>         if (ret == 0)
> -               path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
> +               path.dentry = vfs_tmpfile(&init_user_ns, &path, S_IFREG, O_RDWR);
>         else
>                 path.dentry = ERR_PTR(ret);
>         if (IS_ERR(path.dentry)) {
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -120,7 +120,7 @@ static int ext2_create (struct user_name
>  }
>
>  static int ext2_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                       struct dentry *dentry, umode_t mode)
> +                       struct file *file, umode_t mode)
>  {
>         struct inode *inode = ext2_new_inode(dir, mode, NULL);
>         if (IS_ERR(inode))
> @@ -128,9 +128,9 @@ static int ext2_tmpfile(struct user_name
>
>         ext2_set_file_ops(inode);
>         mark_inode_dirty(inode);
> -       d_tmpfile(dentry, inode);
> +       d_tmpfile(file->f_path.dentry, inode);
>         unlock_new_inode(inode);
> -       return 0;
> +       return finish_tmpfile(file);
>  }
>
>  static int ext2_mknod (struct user_namespace * mnt_userns, struct inode * dir,
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2849,7 +2849,7 @@ static int ext4_mknod(struct user_namesp
>  }
>
>  static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                       struct dentry *dentry, umode_t mode)
> +                       struct file *file, umode_t mode)
>  {
>         handle_t *handle;
>         struct inode *inode;
> @@ -2857,7 +2857,7 @@ static int ext4_tmpfile(struct user_name
>
>         err = dquot_initialize(dir);
>         if (err)
> -               return err;
> +               goto out;
>
>  retry:
>         inode = ext4_new_inode_start_handle(mnt_userns, dir, mode,
> @@ -2871,7 +2871,7 @@ static int ext4_tmpfile(struct user_name
>                 inode->i_op = &ext4_file_inode_operations;
>                 inode->i_fop = &ext4_file_operations;
>                 ext4_set_aops(inode);
> -               d_tmpfile(dentry, inode);
> +               d_tmpfile(file->f_path.dentry, inode);
>                 err = ext4_orphan_add(handle, inode);
>                 if (err)
>                         goto err_unlock_inode;
> @@ -2882,11 +2882,16 @@ static int ext4_tmpfile(struct user_name
>                 ext4_journal_stop(handle);
>         if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
>                 goto retry;
> -       return err;
> +out:
> +       if (err)
> +               return err;
> +
> +       return finish_tmpfile(file);
> +
>  err_unlock_inode:
>         ext4_journal_stop(handle);
>         unlock_new_inode(inode);
> -       return err;
> +       goto out;
>  }
>
>  struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -915,16 +915,21 @@ static int __f2fs_tmpfile(struct user_na
>  }
>
>  static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                       struct dentry *dentry, umode_t mode)
> +                       struct file *file, umode_t mode)
>  {
>         struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> +       int err;
>
>         if (unlikely(f2fs_cp_error(sbi)))
>                 return -EIO;
>         if (!f2fs_is_checkpoint_ready(sbi))
>                 return -ENOSPC;
>
> -       return __f2fs_tmpfile(mnt_userns, dir, dentry, mode, false, NULL);
> +       err = __f2fs_tmpfile(mnt_userns, dir, file->f_path.dentry, mode, false, NULL);
> +       if (err)
> +               return err;
> +
> +       return finish_tmpfile(file);
>  }
>
>  static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -932,10 +932,15 @@ static int hugetlbfs_create(struct user_
>  }
>
>  static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
> -                            struct inode *dir, struct dentry *dentry,
> +                            struct inode *dir, struct file *file,
>                              umode_t mode)
>  {
> -       return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
> +       int err = do_hugetlbfs_mknod(dir, file->f_path.dentry, mode | S_IFREG, 0, true);
> +
> +       if (err)
> +               return err;
> +
> +       return finish_tmpfile(file);
>  }
>
>  static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -53,16 +53,19 @@ static int minix_mknod(struct user_names
>  }
>
>  static int minix_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                        struct dentry *dentry, umode_t mode)
> +                        struct file *file, umode_t mode)
>  {
>         int error;
>         struct inode *inode = minix_new_inode(dir, mode, &error);
>         if (inode) {
>                 minix_set_inode(inode, 0);
>                 mark_inode_dirty(inode);
> -               d_tmpfile(dentry, inode);
> +               d_tmpfile(file->f_path.dentry, inode);
>         }
> -       return error;
> +       if (error)
> +               return error;
> +
> +       return finish_tmpfile(file);
>  }
>
>  static int minix_create(struct user_namespace *mnt_userns, struct inode *dir,
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3568,59 +3568,78 @@ static int do_open(struct nameidata *nd,
>         return error;
>  }
>
> -/**
> - * vfs_tmpfile - create tmpfile
> - * @mnt_userns:        user namespace of the mount the inode was found from
> - * @dentry:    pointer to dentry of the base directory
> - * @mode:      mode of the new tmpfile
> - * @open_flag: flags
> - *
> - * Create a temporary file.
> - *
> - * If the inode has been found through an idmapped mount the user namespace of
> - * the vfsmount must be passed through @mnt_userns. This function will then take
> - * care to map the inode according to @mnt_userns before checking permissions.
> - * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply passs init_user_ns.
> - */
> -struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> -                          struct dentry *dentry, umode_t mode, int open_flag)
> +static int vfs_tmpfile_new(struct user_namespace *mnt_userns,
> +                          const struct path *parent_path,
> +                          struct file *file, umode_t mode)
>  {
> -       struct dentry *child = NULL;
> -       struct inode *dir = dentry->d_inode;
> -       struct inode *inode;
> +       struct inode *inode, *dir = d_inode(parent_path->dentry);
> +       struct dentry *child;
>         int error;
>
>         /* we want directory to be writable */
>         error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>         if (error)
> -               goto out_err;
> +               goto out;
>         error = -EOPNOTSUPP;
>         if (!dir->i_op->tmpfile)
> -               goto out_err;
> +               goto out;
>         error = -ENOMEM;
> -       child = d_alloc(dentry, &slash_name);
> +       child = d_alloc(parent_path->dentry, &slash_name);
>         if (unlikely(!child))
> -               goto out_err;
> +               goto out;
> +       file->f_path.mnt = parent_path->mnt;
> +       file->f_path.dentry = child;
>         mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
> -       error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> +       error = dir->i_op->tmpfile(mnt_userns, dir, file, mode);
>         if (error)
> -               goto out_err;
> +               goto out_dput;
>         error = -ENOENT;
>         inode = child->d_inode;
>         if (unlikely(!inode))
> -               goto out_err;
> -       if (!(open_flag & O_EXCL)) {
> +               goto out_dput;
> +       if (!(file->f_flags & O_EXCL)) {
>                 spin_lock(&inode->i_lock);
>                 inode->i_state |= I_LINKABLE;
>                 spin_unlock(&inode->i_lock);
>         }
>         ima_post_create_tmpfile(mnt_userns, inode);
> -       return child;
> -
> -out_err:
> +       error = 0;
> +out_dput:
>         dput(child);
> -       return ERR_PTR(error);
> +out:
> +       return error;
> +}
> +
> +/**
> + * vfs_tmpfile - create tmpfile
> + * @mnt_userns:        user namespace of the mount the inode was found from
> + * @dentry:    pointer to dentry of the base directory
> + * @mode:      mode of the new tmpfile
> + * @open_flag: flags
> + *
> + * Create a temporary file.
> + *
> + * If the inode has been found through an idmapped mount the user namespace of
> + * the vfsmount must be passed through @mnt_userns. This function will then take
> + * care to map the inode according to @mnt_userns before checking permissions.
> + * On non-idmapped mounts or if permission checking is to be performed on the
> + * raw inode simply passs init_user_ns.
> + */
> +struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> +                          const struct path *path, umode_t mode, int open_flag)
> +{
> +       struct dentry *child;
> +       struct file *file;
> +       int error;
> +
> +       file = alloc_empty_file(open_flag, current_cred());
> +       child = ERR_CAST(file);
> +       if (!IS_ERR(file)) {
> +               error = vfs_tmpfile_new(mnt_userns, path, file, mode);
> +               child = error ? ERR_PTR(error) : dget(file->f_path.dentry);
> +               fput(file);
> +       }
> +       return child;
>  }
>  EXPORT_SYMBOL(vfs_tmpfile);
>
> @@ -3629,26 +3648,22 @@ static int do_tmpfile(struct nameidata *
>                 struct file *file)
>  {
>         struct user_namespace *mnt_userns;
> -       struct dentry *child;
>         struct path path;
> -       int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
> +       int error;
> +
> +       error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
>         if (unlikely(error))
>                 return error;
>         error = mnt_want_write(path.mnt);
>         if (unlikely(error))
>                 goto out;
>         mnt_userns = mnt_user_ns(path.mnt);
> -       child = vfs_tmpfile(mnt_userns, path.dentry, op->mode, op->open_flag);
> -       error = PTR_ERR(child);
> -       if (IS_ERR(child))
> +       error = vfs_tmpfile_new(mnt_userns, &path, file, op->mode);
> +       if (error)
>                 goto out2;
> -       dput(path.dentry);
> -       path.dentry = child;
> -       audit_inode(nd->name, child, 0);
> +       audit_inode(nd->name, file->f_path.dentry, 0);
>         /* Don't check for other permissions, the inode was just created */
> -       error = may_open(mnt_userns, &path, 0, op->open_flag);
> -       if (!error)
> -               error = vfs_open(&path, file);
> +       error = may_open(mnt_userns, &file->f_path, 0, op->open_flag);
>  out2:
>         mnt_drop_write(path.mnt);
>  out:
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -975,6 +975,13 @@ int finish_open(struct file *file, struc
>  }
>  EXPORT_SYMBOL(finish_open);
>
> +int finish_tmpfile(struct file *file)
> +{
> +       BUG_ON(file->f_mode & FMODE_OPENED);
> +       return do_dentry_open(file, d_inode(file->f_path.dentry), NULL);
> +}
> +
> +
>  /**
>   * finish_no_open - finish ->atomic_open() without opening the file
>   *
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -313,7 +313,8 @@ static inline int ovl_do_whiteout(struct
>  static inline struct dentry *ovl_do_tmpfile(struct ovl_fs *ofs,
>                                             struct dentry *dentry, umode_t mode)
>  {
> -       struct dentry *ret = vfs_tmpfile(ovl_upper_mnt_userns(ofs), dentry, mode, 0);
> +       struct path path = { .dentry = dentry, .mnt = ovl_upper_mnt(ofs) };
> +       struct dentry *ret = vfs_tmpfile(ovl_upper_mnt_userns(ofs), &path, mode, 0);
>         int err = PTR_ERR_OR_ZERO(ret);
>
>         pr_debug("tmpfile(%pd2, 0%o) = %i\n", dentry, mode, err);
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -146,15 +146,15 @@ static int ramfs_symlink(struct user_nam
>  }
>
>  static int ramfs_tmpfile(struct user_namespace *mnt_userns,
> -                        struct inode *dir, struct dentry *dentry, umode_t mode)
> +                        struct inode *dir, struct file *file, umode_t mode)
>  {
>         struct inode *inode;
>
>         inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
>         if (!inode)
>                 return -ENOSPC;
> -       d_tmpfile(dentry, inode);
> -       return 0;
> +       d_tmpfile(file->f_path.dentry, inode);
> +       return finish_tmpfile(file);
>  }
>
>  static const struct inode_operations ramfs_dir_inode_operations = {
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -424,8 +424,9 @@ static void unlock_2_inodes(struct inode
>  }
>
>  static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                        struct dentry *dentry, umode_t mode)
> +                        struct file *file, umode_t mode)
>  {
> +       struct dentry *dentry = file->f_path.dentry;
>         struct inode *inode;
>         struct ubifs_info *c = dir->i_sb->s_fs_info;
>         struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
> @@ -489,7 +490,7 @@ static int ubifs_tmpfile(struct user_nam
>
>         ubifs_release_budget(c, &req);
>
> -       return 0;
> +       return finish_tmpfile(file);
>
>  out_cancel:
>         unlock_2_inodes(dir, inode);
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -626,7 +626,7 @@ static int udf_create(struct user_namesp
>  }
>
>  static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -                      struct dentry *dentry, umode_t mode)
> +                      struct file *file, umode_t mode)
>  {
>         struct inode *inode = udf_new_inode(dir, mode);
>
> @@ -640,9 +640,9 @@ static int udf_tmpfile(struct user_names
>         inode->i_op = &udf_file_inode_operations;
>         inode->i_fop = &udf_file_operations;
>         mark_inode_dirty(inode);
> -       d_tmpfile(dentry, inode);
> +       d_tmpfile(file->f_path.dentry, inode);
>         unlock_new_inode(inode);
> -       return 0;
> +       return finish_tmpfile(file);
>  }
>
>  static int udf_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1080,10 +1080,15 @@ STATIC int
>  xfs_vn_tmpfile(
>         struct user_namespace   *mnt_userns,
>         struct inode            *dir,
> -       struct dentry           *dentry,
> +       struct file             *file,
>         umode_t                 mode)
>  {
> -       return xfs_generic_create(mnt_userns, dir, dentry, mode, 0, true);
> +       int err = xfs_generic_create(mnt_userns, dir, file->f_path.dentry, mode, 0, true);
> +
> +       if (err)
> +               return err;
> +
> +       return finish_tmpfile(file);
>  }
>
>  static const struct inode_operations xfs_inode_operations = {
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2005,7 +2005,8 @@ static inline int vfs_whiteout(struct us
>  }
>
>  struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> -                          struct dentry *dentry, umode_t mode, int open_flag);
> +                          const struct path *path,
> +                          umode_t mode, int open_flag);
>
>  int vfs_mkobj(struct dentry *, umode_t,
>                 int (*f)(struct dentry *, umode_t, void *),
> @@ -2167,7 +2168,7 @@ struct inode_operations {
>                            struct file *, unsigned open_flag,
>                            umode_t create_mode);
>         int (*tmpfile) (struct user_namespace *, struct inode *,
> -                       struct dentry *, umode_t);
> +                       struct file *, umode_t);
>         int (*set_acl)(struct user_namespace *, struct inode *,
>                        struct posix_acl *, int);
>         int (*fileattr_set)(struct user_namespace *mnt_userns,
> @@ -2777,6 +2778,7 @@ extern void putname(struct filename *nam
>
>  extern int finish_open(struct file *file, struct dentry *dentry,
>                         int (*open)(struct inode *, struct file *));
> +extern int finish_tmpfile(struct file *file);
>  extern int finish_no_open(struct file *file, struct dentry *dentry);
>
>  /* fs/dcache.c */
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2912,7 +2912,7 @@ shmem_mknod(struct user_namespace *mnt_u
>
>  static int
>  shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> -             struct dentry *dentry, umode_t mode)
> +             struct file *file, umode_t mode)
>  {
>         struct inode *inode;
>         int error = -ENOSPC;
> @@ -2927,12 +2927,16 @@ shmem_tmpfile(struct user_namespace *mnt
>                 error = simple_acl_create(dir, inode);
>                 if (error)
>                         goto out_iput;
> -               d_tmpfile(dentry, inode);
> +               d_tmpfile(file->f_path.dentry, inode);
>         }
> -       return error;
> +out:
> +       if (error)
> +               return error;
> +
> +       return finish_tmpfile(file);
>  out_iput:
>         iput(inode);
> -       return error;
> +       goto out;
>  }
>
>  static int shmem_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
