Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742807B4832
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjJAOwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjJAOwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:52:05 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07673D8;
        Sun,  1 Oct 2023 07:52:03 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-452863742f3so7471945137.1;
        Sun, 01 Oct 2023 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696171922; x=1696776722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiVJrZTOoMF15rNCLrRoY/wfDOcC5GrLWKtrwYlzTwU=;
        b=AIA3yhIOO4AVU0yc5QpEeOOdfoh6Jb64y7ijorefISaSIoj18Mn/Ju9pGgyQGPqtYB
         RJYQOWfHwZqNxwTS4MV0bTBMpvD7m8KHRBy4uZY+5JCbx8d+JR0iwkaoVcSEvR8z4EkP
         ycRNQDVM1lRbsM/F9baxn0Eeqqz46jjz+PM4vmPCbwMtei4jbhgxPKS3pXr98tJ3UMFs
         nH0PszZ5YgTt4rXEaywa1B2Eon2astiymRGp7uxo8jpRZdY3uzkPh9iGyuOX4myHSZzn
         Iij/C9+ARa3o/jFAXoyfBgvIArSUxSxMuZqQtVLXEEoiNO77u6KJNn3I1iXGeobXfJjA
         wnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171922; x=1696776722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiVJrZTOoMF15rNCLrRoY/wfDOcC5GrLWKtrwYlzTwU=;
        b=hEiqOElJ85PW2bNukadmohemj/yrqIreYWKgZJ8g5JYsCQ0reurL4BbURFteFGXdNW
         +/HjL/6ABGyxGjOb5NhPrqQGPiDba4TBbZsc/22eca73qNjN2d6ASo6A55zPQooL/fZ6
         YMYh7amG3cF4e/1E3jEDukLsAZRbuMSuTc3vgTXemWSM3nSVuYGGxboyxq2i1197Yk3s
         iyF/p17HiAtXdFsh6NCxagsCf6P86e47Cvs5zbXnQ9Vl+RcuAd3sZb25K8bHs/LutMlK
         fieuKwq37kbr7Vk1GtzXGa2J+f7gqN9S1T52LnLcsDZLzZOoycjLYhLDVWzPusQ1noc/
         bTrA==
X-Gm-Message-State: AOJu0Yw4wMnyit9bOijdCl2X8LBfnUEHWARO71epMieJzwZiXzJwzr1v
        SsaGV9Il1YNYNu+p2hDPei5h7pUHx+5P56SBydY=
X-Google-Smtp-Source: AGHT+IHast/f6VkWZbGt+sIkPHyQ30rw82NF4d+PC0OSDFWExgL/kJNz3jLyMzekmfvF0SktdqlHfO5eRiPmbl4xtPE=
X-Received: by 2002:a67:db8a:0:b0:452:6320:60da with SMTP id
 f10-20020a67db8a000000b00452632060damr7372576vsk.22.1696171921867; Sun, 01
 Oct 2023 07:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000259bd8060596e33f@google.com> <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com> <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com> <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com> <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
 <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
 <20230921-gedanken-salzwasser-40d25b921162@brauner> <28997978-0b41-9bf3-8f62-ce422425f672@linux.ibm.com>
 <CAOQ4uxie6xT5mmCcCwYtnEvra37eSeFftXfxaTULfdJnk1VcXQ@mail.gmail.com> <99294acf-7275-8f4d-a129-d5df208b7b2a@linux.ibm.com>
In-Reply-To: <99294acf-7275-8f4d-a129-d5df208b7b2a@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 1 Oct 2023 17:51:50 +0300
Message-ID: <CAOQ4uxioQbE8_j3bnkwJS24GjHHB1inK18dOJimwNGPrdQLaOQ@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in d_path
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 3:39=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
> On 9/29/23 00:25, Amir Goldstein wrote:
> > On Fri, Sep 29, 2023 at 3:02=E2=80=AFAM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >>
> >> On 9/21/23 07:48, Christian Brauner wrote:
> >>> Imho, this is all very wild but I'm not judging.
> >>>
> >>> Two solutions imho:
> >>> (1) teach stacking filesystems like overlayfs and ecryptfs to use
> >>>       vfs_getattr_nosec() in their ->getattr() implementation when th=
ey
> >>>       are themselves called via vfs_getattr_nosec(). This will fix th=
is by
> >>>       not triggering another LSM hook.
> >>
> >> You can avoid all this churn.
> >> Just use the existing query_flags arg.
> >> Nothing outside the AT_STATX_SYNC_TYPE query_flags is
> >> passed into filesystems from userspace.
> >>
> >> Mast out AT_STATX_SYNC_TYPE in vfs_getattr()
> >> And allow kernel internal request_flags in vfs_getattr_nosec()
> Hm, I thought that vfs_getattr_nosec needs to pass AT_GETATTR_NOSEC into
> ->getattr().
> >>
> >> The AT_ flag namespace is already a challenge, but mixing user
> >> flags and kernel-only flags in vfs interfaces has been done before.
> >>
> >> ...
>
>
> That's what I wanted to avoid since now all filesystems' getattr() may
> have the AT_GETATTR_NOSEC mixed into the query_flags.
>
> Anyway, here's what I currently have:
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 992d9c7e64ae..f7b5b1843dcc 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -998,16 +998,28 @@ static int ecryptfs_getattr_link(struct mnt_idmap
> *idmap,
>          return rc;
>   }
>
> +static int ecryptfs_do_getattr(bool nosec, const struct path *path,
> +                              struct kstat *stat, u32 request_mask,
> +                              unsigned int flags)
> +{
> +       if (nosec)
> +               return vfs_getattr_nosec(path, stat, request_mask, flags)=
;
> +       return vfs_getattr(path, stat, request_mask, flags);
> +}
> +
>   static int ecryptfs_getattr(struct mnt_idmap *idmap,
>                              const struct path *path, struct kstat *stat,
>                              u32 request_mask, unsigned int flags)
>   {
>          struct dentry *dentry =3D path->dentry;
>          struct kstat lower_stat;
> +       bool nosec =3D flags & AT_GETATTR_NOSEC;
>          int rc;
>
> -       rc =3D vfs_getattr(ecryptfs_dentry_to_lower_path(dentry), &lower_=
stat,
> -                        request_mask, flags);
> +       flags &=3D ~AT_INTERNAL_MASK;
> +
> +       rc =3D ecryptfs_do_getattr(nosec,
> ecryptfs_dentry_to_lower_path(dentry),
> +                                &lower_stat, request_mask, flags);
>          if (!rc) {
>                  fsstack_copy_attr_all(d_inode(dentry),
> ecryptfs_inode_to_lower(d_inode(dentry)));
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 83ef66644c21..ec4ceb5b4ebf 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -166,12 +166,15 @@ int ovl_getattr(struct mnt_idmap *idmap, const
> struct path *path,
>          int fsid =3D 0;
>          int err;
>          bool metacopy_blocks =3D false;
> +       bool nosec =3D flags & AT_GETATTR_NOSEC;
> +
> +       flags &=3D ~AT_INTERNAL_MASK;

I don't understand why you need the nosec helper arg.
What's wrong with:

static int ovl_do_getattr(const struct path *path,
                              struct kstat *stat, u32 request_mask,
                              unsigned int flags)
{
       if (flags & AT_GETATTR_NOSEC)
               return vfs_getattr_nosec(path, stat, request_mask, flags);
       return vfs_getattr(path, stat, request_mask, flags);
}

likewise for ecryptfs.

>
>          metacopy_blocks =3D ovl_is_metacopy_dentry(dentry);
>
>          type =3D ovl_path_real(dentry, &realpath);
>          old_cred =3D ovl_override_creds(dentry->d_sb);
> -       err =3D vfs_getattr(&realpath, stat, request_mask, flags);
> +       err =3D ovl_do_getattr(nosec, &realpath, stat, request_mask, flag=
s);
>          if (err)
>                  goto out;
>
> @@ -196,8 +199,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const
> struct path *path,
>                                          (!is_dir ? STATX_NLINK : 0);
>
>                          ovl_path_lower(dentry, &realpath);
> -                       err =3D vfs_getattr(&realpath, &lowerstat,
> -                                         lowermask, flags);
> +                       err =3D ovl_do_getattr(nosec, &realpath, &lowerst=
at,
> +                                            lowermask, flags);
>                          if (err)
>                                  goto out;
>
> @@ -249,8 +252,9 @@ int ovl_getattr(struct mnt_idmap *idmap, const
> struct path *path,
>
>                          ovl_path_lowerdata(dentry, &realpath);
>                          if (realpath.dentry) {
> -                               err =3D vfs_getattr(&realpath, &lowerdata=
stat,
> -                                                 lowermask, flags);
> +                               err =3D ovl_do_getattr(nosec, &realpath,
> + &lowerdatastat, lowermask,
> +                                                    flags);
>                                  if (err)
>                                          goto out;
>                          } else {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 9817b2dcb132..cbee3ff3bab7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -397,6 +397,15 @@ static inline bool ovl_open_flags_need_copy_up(int
> flags)
>          return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
>   }
>
> +static inline int ovl_do_getattr(bool nosec, const struct path *path,
> +                                struct kstat *stat, u32 request_mask,
> +                                unsigned int flags)
> +{
> +       if (nosec)
> +               return vfs_getattr_nosec(path, stat, request_mask, flags)=
;
> +       return vfs_getattr(path, stat, request_mask, flags);
> +}
> +
>   /* util.c */
>   int ovl_want_write(struct dentry *dentry);
>   void ovl_drop_write(struct dentry *dentry);
> diff --git a/fs/stat.c b/fs/stat.c
> index d43a5cc1bfa4..3250e427e1aa 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -133,7 +133,8 @@ int vfs_getattr_nosec(const struct path *path,
> struct kstat *stat,
>          idmap =3D mnt_idmap(path->mnt);)
>          if (inode->i_op->getattr)
>                  return inode->i_op->getattr(idmap, path, stat,
> -                                           request_mask, query_flags);
> +                                           request_mask,
> +                                           query_flags | AT_GETATTR_NOSE=
C);
>

You also need in vfs_getattr():

if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC)
    return -EPERM;

>          generic_fillattr(idmap, request_mask, inode, stat);
>          return 0;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b528f063e8ff..9069d6a301f0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2027,6 +2027,12 @@ struct super_operations {
>          void (*shutdown)(struct super_block *sb);
>   };
>
> +/*
> + * Internal query flags. See fcntl.h AT_xxx flags for the rest.
> + */
> +#define AT_GETATTR_NOSEC               0x80000000
> +#define AT_INTERNAL_MASK               0x80000000
> +

Yeh, the problem is that people adding flags to fcntl.h
won't be seeing this comment and we don't want to put those
"expose" those flags in uapi header either.

One possible compromise is to put them in fcntl.h under
#ifdef __KERNEL__

Very controversial, yes, I know.
The whole concept of mixing functional flags (i.e. AT_STATX_*)
with lookup AT_* flags is controversial to begin with, not to
mention flag overload for different syscalls (i.e. AT_EACCESS/
AT_REMOVEDIR/AT_HANDLE_FID).

But since we have accepted this necessary evil, I think that at least
we could explicitly partition the AT_ flags namespace and declare:

#ifdef __KERNEL__
AT_LOOKUP_FLAGS_MASK ...
AT_MOUNT_FLAGS_MASK         AT_RECURSIVE
AT_SYSCALL_PRIVATE_MASK   AT_EACCESS
AT_SYNC_TYPE_MASK               AT_STATX_SYNC_TYPE
AT_KERNEL_INTERNAL_MASK  0x80000000
#endif

Sfefan,

I feel that I have to stress the point that this is only *my* opinion and
I accept that others (like some vfs co-maintains..) may passionately
disagree to further pollute the AT_ flags namespace.

The advantage of the AT_KERNEL_INTERNAL_MASK is that it is
in no way exposed to users via ABI, so if we decide to undo this
decision anytime in the future and reclaim the internal AT_ flags,
we could do that.

IMO, this is a decent compromise compared to the very noisy
patch that adds another flags argument to ->getattr() just to fix
this IMA/overlayfs corner case.

Thanks,
Amir.
