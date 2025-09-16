Return-Path: <linux-fsdevel+bounces-61699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B5B58E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E0520523
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCE2DFA32;
	Tue, 16 Sep 2025 06:41:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968B2DF71E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004907; cv=none; b=KEau29/WzI/kOcM6m1WMUO8toIS2WPaXq8DL7p+NjGu286BCyHJgqmFGSCLWXtPDqgm8XG1ME4r4wbaIn3br2kgekTw5LhlEssybqHTMUpQyryL2C0sOPwu2r8m6mJdZqNk+K8xPR+Z3SmtG0Y1gfYL7uoGOsvJa+OkJv7QTYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004907; c=relaxed/simple;
	bh=aOqdtF6vKv2N4buSArHUuoQOds/my4Xf2GebP68+mPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/sFlUf0xznJeF6w1nbPOKyloq88FBzxUfNui0wajxLZ5nUz8pWTap7W1chrlXvdPDjESzuiauoUZZrlUB3DZzyWD5fJUPtzCPeGDb36KOWVktY/H1I/et9Zo7A+Oud6QybniV2l0py3yDqh9MgD9ksGAY9Q9OACmpbL95LsxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d605c6501so34611837b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 23:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758004904; x=1758609704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUtKMNKxtvgWRZoirTPKx9vVVwcjpbmiSQpSjnBdNlQ=;
        b=P7O9BpIpCE+VDmc32Q3JxCeP6snk2RPHC2t+7Z96VAf8MWG5IPF17Nr1nX/AdbnGu9
         bEJrhs5GDAnN1nEmfhhrZBbeH+H+j8HJ7v1kGqs/S69vLTBXL3YXIpRNKugtflzB3x31
         aMDV0sY/Xy0hFL3Av4QtM0WrUcs1ufUkaorlzSpeZkrZ7h7VFTc4On1r4xmPdGFg6WrY
         mASTboASnt5FrZoOPVdogiH63drZc2BID8yywDrazua5UNy49jlyFTVeHU2bZvE969G+
         CPf2TBV/nO6qTaGZartmXbgaUlNHPzXgeJrn38P1hb5xy/CEers+m/Bn+rZHX2SDI1Q4
         AyFg==
X-Forwarded-Encrypted: i=1; AJvYcCXHPgGi+tW8ugKFsLMZiJs0Uf1whekgHs2qKlmApHsSrbcgFRWFBCeaiqkd9GiEaQjMx8tW5PLniA16SjXo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mShvFSiQkClO8KNS9Qh9JfFBs7z53415ZM/jcSGj65ben6be
	RUlWD1JKuhtVJ0w4usGnMdVxDRDBcl5eSr5pa9fOVRKpBp9wPE9AdLuZVWNBuA16E+8=
X-Gm-Gg: ASbGncvAO7HFKqPnmcSSwCSLLJWToIJhiKtHB3CGmiqpCRlSF71e1S15TK4I9FfT85e
	Ykfk4dSl4SfjSH9y+cuj3RLy8hTzum+m4twzuapJbjVinQ5DKa6tLIED3KLvUnxfdMkAnd8xai9
	NJxlReXp/nL6XLcqhdDz2CQy4E95sUCxXoiz15rBRZRK5RYI73/tjI+Eduiu/Q+L8nwHuOZhRrT
	sHyjrBp6Vo9y43Ny31JYa4U+5q8weB4FstsZiMjY+Cdfd4CY7H+JYopI6H6hEMd46k01jtIY+Nn
	Llsf9P+i5B9lV5zN8bZExuozve3XjFsj696Etzl/FO0mi2USfh/aQtY1QLoEcfkeBBsHgfXzJCG
	ExEPppVr7/L1eEI0YWa/2XbOhijjRCr4iM+IUu9frOBYh4nueRyRKa598uJMmFKf/rHYuZNBvKj
	1kL8mwwdHva9lajj7313ls2B8p1g==
X-Google-Smtp-Source: AGHT+IFWcDxIrmRbNZFhZWxoA7DKvXaxRA4emPrO6QWu8DrEpeCMitjOt0zDdvIpo65vv2ZjvP0mRQ==
X-Received: by 2002:a05:690c:d1b:b0:735:c48a:c127 with SMTP id 00721157ae682-735c48ac511mr28642347b3.18.1758004903408;
        Mon, 15 Sep 2025 23:41:43 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79794201sm37953257b3.62.2025.09.15.23.41.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 23:41:42 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603cebd9so41385277b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 23:41:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZeBpEuz9kqEFI0iDb5qBeDe77e8Aw0uQG1a4LwaBpsG6VY7JMlm5JLN2X9WY05ncVw7oyZHzdHl7c9olD@vger.kernel.org
X-Received: by 2002:a05:690c:23c1:b0:720:bb3:ec14 with SMTP id
 00721157ae682-73064b08dfcmr139630637b3.25.1758004901891; Mon, 15 Sep 2025
 23:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs> <175798150177.381990.5457916685867195048.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150177.381990.5457916685867195048.stgit@frogsfrogsfrogs>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 16 Sep 2025 14:41:30 +0800
X-Gmail-Original-Message-ID: <CAC1kPDOv4sy3NPexFtdoROFi18b98W+PbP+9t8y4Jd5fQqCxCg@mail.gmail.com>
X-Gm-Features: Ac12FXzMunJk0T_4Jany0brcbouJMZaEvkm2CjAIMoFEj2ft7BYULOQkF-5rzVw
Message-ID: <CAC1kPDOv4sy3NPexFtdoROFi18b98W+PbP+9t8y4Jd5fQqCxCg@mail.gmail.com>
Subject: Re: [PATCH 7/8] fuse: propagate default and file acls on creation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:26=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> For local filesystems, propagate the default and file access ACLs to new
> children when creating them, just like the other in-kernel local
> filesystems.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    4 ++
>  fs/fuse/acl.c    |   65 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dir.c    |   92 +++++++++++++++++++++++++++++++++++++++++-------=
------
>  3 files changed, 138 insertions(+), 23 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 52776b77efc0e4..b9306678dcda0d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1507,6 +1507,10 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *i=
dmap,
>                                struct dentry *dentry, int type);
>  int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
>                  struct posix_acl *acl, int type);
> +int fuse_acl_create(struct inode *dir, umode_t *mode,
> +                   struct posix_acl **default_acl, struct posix_acl **ac=
l);
> +int fuse_init_acls(struct inode *inode, const struct posix_acl *default_=
acl,
> +                  const struct posix_acl *acl);
>
>  /* readdir.c */
>  int fuse_readdir(struct file *file, struct dir_context *ctx);
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 4997827ee83c6d..4faee72f1365a5 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -203,3 +203,68 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>
>         return ret;
>  }
> +
> +int fuse_acl_create(struct inode *dir, umode_t *mode,
> +                   struct posix_acl **default_acl, struct posix_acl **ac=
l)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(dir);
> +
> +       if (fuse_is_bad(dir))
> +               return -EIO;
> +
> +       if (IS_POSIXACL(dir) && fuse_has_local_acls(fc))
> +               return posix_acl_create(dir, mode, default_acl, acl);
> +
> +       if (!fc->dont_mask)
> +               *mode &=3D ~current_umask();
> +
> +       *default_acl =3D NULL;
> +       *acl =3D NULL;
> +       return 0;
> +}
> +
> +static int __fuse_set_acl(struct inode *inode, const char *name,
> +                         const struct posix_acl *acl)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       size_t size =3D posix_acl_xattr_size(acl->a_count);
> +       void *value;
> +       int ret;
> +
> +       if (size > PAGE_SIZE)
> +               return -E2BIG;
> +
> +       value =3D kmalloc(size, GFP_KERNEL);
> +       if (!value)
> +               return -ENOMEM;
> +
> +       ret =3D posix_acl_to_xattr(fc->user_ns, acl, value, size);
> +       if (ret < 0)
> +               goto out_value;
> +
> +       ret =3D fuse_setxattr(inode, name, value, size, 0, 0);
> +out_value:
> +       kfree(value);
> +       return ret;
> +}
> +
> +int fuse_init_acls(struct inode *inode, const struct posix_acl *default_=
acl,
> +                  const struct posix_acl *acl)
> +{
> +       int ret;
> +
> +       if (default_acl) {
> +               ret =3D __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_DEFAUL=
T,
> +                                    default_acl);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (acl) {
> +               ret =3D __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_ACCESS=
, acl);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index a7f47e43692f1c..b116e42431ee12 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -628,26 +628,28 @@ static int fuse_create_open(struct mnt_idmap *idmap=
, struct inode *dir,
>         struct fuse_entry_out outentry;
>         struct fuse_inode *fi;
>         struct fuse_file *ff;
> +       struct posix_acl *default_acl =3D NULL, *acl =3D NULL;
>         int epoch, err;
>         bool trunc =3D flags & O_TRUNC;
>
>         /* Userspace expects S_IFREG in create mode */
>         BUG_ON((mode & S_IFMT) !=3D S_IFREG);
>
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return err;
> +
>         epoch =3D atomic_read(&fm->fc->epoch);
>         forget =3D fuse_alloc_forget();
>         err =3D -ENOMEM;
>         if (!forget)
> -               goto out_err;
> +               goto out_acl_release;
>
>         err =3D -ENOMEM;
>         ff =3D fuse_file_alloc(fm, true);
>         if (!ff)
>                 goto out_put_forget_req;
>
> -       if (!fm->fc->dont_mask)
> -               mode &=3D ~current_umask();
> -
>         flags &=3D ~O_NOCTTY;
>         memset(&inarg, 0, sizeof(inarg));
>         memset(&outentry, 0, sizeof(outentry));
> @@ -699,12 +701,16 @@ static int fuse_create_open(struct mnt_idmap *idmap=
, struct inode *dir,
>                 fuse_sync_release(NULL, ff, flags);
>                 fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
>                 err =3D -ENOMEM;
> -               goto out_err;
> +               goto out_acl_release;
>         }
>         kfree(forget);
>         d_instantiate(entry, inode);
>         entry->d_time =3D epoch;
>         fuse_change_entry_timeout(entry, &outentry);
> +
> +       err =3D fuse_init_acls(inode, default_acl, acl);
> +       if (err)
> +               goto out_acl_release;
>         fuse_dir_changed(dir);
>         err =3D generic_file_open(inode, file);
>         if (!err) {
> @@ -726,7 +732,9 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>         fuse_file_free(ff);
>  out_put_forget_req:
>         kfree(forget);
> -out_err:
> +out_acl_release:
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return err;
>  }
>
> @@ -785,7 +793,9 @@ static int fuse_atomic_open(struct inode *dir, struct=
 dentry *entry,
>   */
>  static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct f=
use_mount *fm,
>                                        struct fuse_args *args, struct ino=
de *dir,
> -                                      struct dentry *entry, umode_t mode=
)
> +                                      struct dentry *entry, umode_t mode=
,
> +                                      struct posix_acl *default_acl,
> +                                      struct posix_acl *acl)
>  {
>         struct fuse_entry_out outarg;
>         struct inode *inode;
> @@ -793,14 +803,18 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
>         struct fuse_forget_link *forget;
>         int epoch, err;
>
> -       if (fuse_is_bad(dir))
> -               return ERR_PTR(-EIO);
> +       if (fuse_is_bad(dir)) {
> +               err =3D -EIO;
> +               goto out_acl_release;
> +       }
>
>         epoch =3D atomic_read(&fm->fc->epoch);
>
>         forget =3D fuse_alloc_forget();
> -       if (!forget)
> -               return ERR_PTR(-ENOMEM);
> +       if (!forget) {
> +               err =3D -ENOMEM;
> +               goto out_acl_release;
> +       }
>
>         memset(&outarg, 0, sizeof(outarg));
>         args->nodeid =3D get_node_id(dir);
> @@ -830,7 +844,8 @@ static struct dentry *create_new_entry(struct mnt_idm=
ap *idmap, struct fuse_moun
>                           &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
>         if (!inode) {
>                 fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
> -               return ERR_PTR(-ENOMEM);
> +               err =3D -ENOMEM;
> +               goto out_acl_release;
>         }
>         kfree(forget);
>
> @@ -846,19 +861,31 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
>                 entry->d_time =3D epoch;
>                 fuse_change_entry_timeout(entry, &outarg);
>         }
> +
> +       err =3D fuse_init_acls(inode, default_acl, acl);
> +       if (err)
> +               goto out_acl_release;
>         fuse_dir_changed(dir);
> +
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return d;
>
>   out_put_forget_req:
>         if (err =3D=3D -EEXIST)
>                 fuse_invalidate_entry(entry);
>         kfree(forget);
> + out_acl_release:
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return ERR_PTR(err);
>  }
>
>  static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount =
*fm,
>                              struct fuse_args *args, struct inode *dir,
> -                            struct dentry *entry, umode_t mode)
> +                            struct dentry *entry, umode_t mode,
> +                            struct posix_acl *default_acl,
> +                            struct posix_acl *acl)
>  {
>         /*
>          * Note that when creating anything other than a directory we
> @@ -869,7 +896,8 @@ static int create_new_nondir(struct mnt_idmap *idmap,=
 struct fuse_mount *fm,
>          */
>         WARN_ON_ONCE(S_ISDIR(mode));
>
> -       return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode=
));
> +       return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode=
,
> +                                       default_acl, acl));
>  }
>
>  static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> @@ -877,10 +905,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  {
>         struct fuse_mknod_in inarg;
>         struct fuse_mount *fm =3D get_fuse_mount(dir);
> +       struct posix_acl *default_acl, *acl;
>         FUSE_ARGS(args);
> +       int err;
>
> -       if (!fm->fc->dont_mask)
> -               mode &=3D ~current_umask();
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);

Please excuse me if this is a dumb question.
In this function (including fuse_mkdir and fuse_symlink),
why can't we pair fuse_acl_create and posix_acl_release together
within the same function,
just like in fuse_create_open?

Thanks,
Chen Linxuan

> +       if (err)
> +               return err;
>
>         memset(&inarg, 0, sizeof(inarg));
>         inarg.mode =3D mode;
> @@ -892,7 +923,8 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct=
 inode *dir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D entry->d_name.len + 1;
>         args.in_args[1].value =3D entry->d_name.name;
> -       return create_new_nondir(idmap, fm, &args, dir, entry, mode);
> +       return create_new_nondir(idmap, fm, &args, dir, entry, mode,
> +                                default_acl, acl);
>  }
>
>  static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
> @@ -924,13 +956,17 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *=
idmap, struct inode *dir,
>  {
>         struct fuse_mkdir_in inarg;
>         struct fuse_mount *fm =3D get_fuse_mount(dir);
> +       struct posix_acl *default_acl, *acl;
>         FUSE_ARGS(args);
> +       int err;
>
> -       if (!fm->fc->dont_mask)
> -               mode &=3D ~current_umask();
> +       mode |=3D S_IFDIR;        /* vfs doesn't set S_IFDIR for us */
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return ERR_PTR(err);
>
>         memset(&inarg, 0, sizeof(inarg));
> -       inarg.mode =3D mode;
> +       inarg.mode =3D mode & ~S_IFDIR;
>         inarg.umask =3D current_umask();
>         args.opcode =3D FUSE_MKDIR;
>         args.in_numargs =3D 2;
> @@ -938,7 +974,8 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *id=
map, struct inode *dir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D entry->d_name.len + 1;
>         args.in_args[1].value =3D entry->d_name.name;
> -       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
> +       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR,
> +                               default_acl, acl);
>  }
>
>  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> @@ -946,7 +983,14 @@ static int fuse_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
>  {
>         struct fuse_mount *fm =3D get_fuse_mount(dir);
>         unsigned len =3D strlen(link) + 1;
> +       struct posix_acl *default_acl, *acl;
> +       umode_t mode =3D S_IFLNK | 0777;
>         FUSE_ARGS(args);
> +       int err;
> +
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return err;
>
>         args.opcode =3D FUSE_SYMLINK;
>         args.in_numargs =3D 3;
> @@ -955,7 +999,8 @@ static int fuse_symlink(struct mnt_idmap *idmap, stru=
ct inode *dir,
>         args.in_args[1].value =3D entry->d_name.name;
>         args.in_args[2].size =3D len;
>         args.in_args[2].value =3D link;
> -       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
> +       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK,
> +                                default_acl, acl);
>  }
>
>  void fuse_flush_time_update(struct inode *inode)
> @@ -1155,7 +1200,8 @@ static int fuse_link(struct dentry *entry, struct i=
node *newdir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D newent->d_name.len + 1;
>         args.in_args[1].value =3D newent->d_name.name;
> -       err =3D create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, =
newent, inode->i_mode);
> +       err =3D create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, =
newent,
> +                               inode->i_mode, NULL, NULL);
>         if (!err)
>                 fuse_update_ctime_in_cache(inode);
>         else if (err =3D=3D -EINTR)
>
>
>

