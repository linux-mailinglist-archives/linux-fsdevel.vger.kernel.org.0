Return-Path: <linux-fsdevel+bounces-25422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51994BFB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E071F21E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89418E74D;
	Thu,  8 Aug 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpDl+vWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6342C0B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127706; cv=none; b=u+L14DvUwJWySUu4U7DJatKogRj+t5lsR6Go/QpS58TJds8Rq9zzkPCN1NeO8f7Ywxqu+lyDmZokpnJzy1G48dwmb++GtknZBBFI8Kbr9JDnbtEZChnDIcTHSmIP99+irzoKCetiKQtMNLKOqd/yBT2d+cpZ4rh1Y4rhPD12/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127706; c=relaxed/simple;
	bh=ADS6zuvrDee5HIJ+vvxEyrTqvFv/8TQmbZpZGTVeG84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDP8/BKeXYbTYjuc7zsnMTaRB5Os37YgQeOZMYrQllFwLz6pp+3cJmMrAw9EhuQOx+dQLNsRJi/fzq54JakLcOAOulVvi/LEcb1TJ712RZeUmWBlydcjNlWuIN4/5uKvdgeE1VD5Moo1Crm3zVo2v1eawdWQKfMLu5lbyo3ZJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpDl+vWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D36CC32782;
	Thu,  8 Aug 2024 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723127705;
	bh=ADS6zuvrDee5HIJ+vvxEyrTqvFv/8TQmbZpZGTVeG84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpDl+vWjab5Dhg7zEP4qoVWuVQ+E1/WULhVy7rBc/B/6Oz1hbQGQ3aAfn3wye3BsV
	 otTnxircEmYaGowGVe4k7lNawoGHWQj5NYHBZSA3yOjIV0hXoAy4SbRiDO5viIZM3s
	 i5NMT2Txdm9jx64Gx42d8hksyPZIMmibQmy/RibiaUaxdq81HE0/6AF3HiVzWFoTTv
	 UYeQh9BrOJLh/uTc7hgmm3o3Zca+z9M4BWxhg6uOPP4F+ajEsgVEK1gHyTz7a1JpfS
	 oZptx64JF9wPvJDwyNK5ObHHI8E/2qyWzhZx/5BOQ4TYZfjfWsymU5ixDPjF+l/4zn
	 8Oh/bOfi2nC2w==
Date: Thu, 8 Aug 2024 07:35:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 06/13] fs: Drop unnecessary underscore from _SB_I_
 constants
Message-ID: <20240808143505.GB6043@frogsfrogsfrogs>
References: <20240807180706.30713-1-jack@suse.cz>
 <20240807183003.23562-6-jack@suse.cz>
 <CAOQ4uxhhzFZy-QBrwhRWubRm75Uw_sx92OZv3gp1bV-MTWwYPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhhzFZy-QBrwhRWubRm75Uw_sx92OZv3gp1bV-MTWwYPA@mail.gmail.com>

On Thu, Aug 08, 2024 at 01:47:20PM +0200, Amir Goldstein wrote:
> On Wed, Aug 7, 2024 at 8:31 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Now that old constants are gone, remove the unnecessary underscore from
> > the new _SB_I_ constants. Pure mechanical replacement, no functional
> > changes.
> >
> 
> This is a potential backporting bomb.
> It is true that code using the old constant names with new macros
> will not build on stable kernels, but I think this is still asking for trouble.
> 
> Also, it is a bit strange that SB_* flags are bit masks and SB_I_*
> flags are bit numbers.
> How about leaving the underscore and using  sb_*_iflag() macros to add
> the underscore?

Or append _BIT to the new names, as is sometimes done elsewhere in the
kernel?

#define SB_I_VERSION_BIT	23

etc.

--D

> Thanks,
> Amir.
> 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/bdev.c                          |  2 +-
> >  drivers/android/binderfs.c            |  4 ++--
> >  fs/aio.c                              |  2 +-
> >  fs/btrfs/super.c                      |  2 +-
> >  fs/devpts/inode.c                     |  2 +-
> >  fs/exec.c                             |  2 +-
> >  fs/ext2/super.c                       |  2 +-
> >  fs/ext4/super.c                       |  2 +-
> >  fs/f2fs/super.c                       |  2 +-
> >  fs/fuse/inode.c                       |  4 ++--
> >  fs/inode.c                            |  2 +-
> >  fs/kernfs/mount.c                     |  4 ++--
> >  fs/namei.c                            |  2 +-
> >  fs/namespace.c                        |  8 ++++----
> >  fs/nfs/fs_context.c                   |  2 +-
> >  fs/nfs/super.c                        |  2 +-
> >  fs/overlayfs/super.c                  |  6 +++---
> >  fs/proc/root.c                        |  6 +++---
> >  fs/super.c                            | 18 ++++++++---------
> >  fs/sync.c                             |  2 +-
> >  fs/sysfs/mount.c                      |  2 +-
> >  fs/xfs/xfs_super.c                    |  2 +-
> >  include/linux/backing-dev.h           |  2 +-
> >  include/linux/fs.h                    | 28 +++++++++++++--------------
> >  include/linux/namei.h                 |  2 +-
> >  ipc/mqueue.c                          |  4 ++--
> >  security/integrity/evm/evm_main.c     |  2 +-
> >  security/integrity/ima/ima_appraise.c |  4 ++--
> >  security/integrity/ima/ima_main.c     |  4 ++--
> >  29 files changed, 63 insertions(+), 63 deletions(-)
> >
> > diff --git a/block/bdev.c b/block/bdev.c
> > index c1ea2aeb93dd..6c13ba60c0b1 100644
> > --- a/block/bdev.c
> > +++ b/block/bdev.c
> > @@ -373,7 +373,7 @@ static int bd_init_fs_context(struct fs_context *fc)
> >         struct pseudo_fs_context *ctx = init_pseudo(fc, BDEVFS_MAGIC);
> >         if (!ctx)
> >                 return -ENOMEM;
> > -       fc->s_iflags |= 1 << _SB_I_CGROUPWB;
> > +       fc->s_iflags |= 1 << SB_I_CGROUPWB;
> >         ctx->ops = &bdev_sops;
> >         return 0;
> >  }
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index f9454b93c2f7..6070923fbfbd 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -672,8 +672,8 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >          * allowed to do. So removing the SB_I_NODEV flag from s_iflags is both
> >          * necessary and safe.
> >          */
> > -       sb_clear_iflag(sb, _SB_I_NODEV);
> > -       sb_set_iflag(sb, _SB_I_NOEXEC);
> > +       sb_clear_iflag(sb, SB_I_NODEV);
> > +       sb_set_iflag(sb, SB_I_NOEXEC);
> >         sb->s_magic = BINDERFS_SUPER_MAGIC;
> >         sb->s_op = &binderfs_super_ops;
> >         sb->s_time_gran = 1;
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 63ce0736c3a3..48d99221ff57 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -279,7 +279,7 @@ static int aio_init_fs_context(struct fs_context *fc)
> >  {
> >         if (!init_pseudo(fc, AIO_RING_MAGIC))
> >                 return -ENOMEM;
> > -       fc->s_iflags |= 1 << _SB_I_NOEXEC;
> > +       fc->s_iflags |= 1 << SB_I_NOEXEC;
> >         return 0;
> >  }
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 321696697279..fb3938ec127c 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -950,7 +950,7 @@ static int btrfs_fill_super(struct super_block *sb,
> >  #endif
> >         sb->s_xattr = btrfs_xattr_handlers;
> >         sb->s_time_gran = 1;
> > -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> > +       sb_set_iflag(sb, SB_I_CGROUPWB);
> >
> >         err = super_setup_bdi(sb);
> >         if (err) {
> > diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> > index d473156d2791..6094cb7e1a16 100644
> > --- a/fs/devpts/inode.c
> > +++ b/fs/devpts/inode.c
> > @@ -428,7 +428,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
> >         struct inode *inode;
> >         int error;
> >
> > -       sb_clear_iflag(s, _SB_I_NODEV);
> > +       sb_clear_iflag(s, SB_I_NODEV);
> >         s->s_blocksize = 1024;
> >         s->s_blocksize_bits = 10;
> >         s->s_magic = DEVPTS_SUPER_MAGIC;
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b62b67bea10b..a8bd15aa6bd8 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -112,7 +112,7 @@ static inline void put_binfmt(struct linux_binfmt * fmt)
> >  bool path_noexec(const struct path *path)
> >  {
> >         return (path->mnt->mnt_flags & MNT_NOEXEC) ||
> > -              sb_test_iflag(path->mnt->mnt_sb, _SB_I_NOEXEC);
> > +              sb_test_iflag(path->mnt->mnt_sb, SB_I_NOEXEC);
> >  }
> >
> >  #ifdef CONFIG_USELIB
> > diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> > index 9da8652c10c5..cbe79fb7ac35 100644
> > --- a/fs/ext2/super.c
> > +++ b/fs/ext2/super.c
> > @@ -916,7 +916,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
> >
> >         sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
> >                 (test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> > -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> > +       sb_set_iflag(sb, SB_I_CGROUPWB);
> >
> >         if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
> >             (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index a776d4e7ec66..b5b2f17f1b65 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4972,7 +4972,7 @@ static int ext4_check_journal_data_mode(struct super_block *sb)
> >                 if (test_opt(sb, DELALLOC))
> >                         clear_opt(sb, DELALLOC);
> >         } else {
> > -               sb_set_iflag(sb, _SB_I_CGROUPWB);
> > +               sb_set_iflag(sb, SB_I_CGROUPWB);
> >         }
> >
> >         return 0;
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 041b7b7b0810..8437612bf64b 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4472,7 +4472,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >                 (test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
> >         super_set_uuid(sb, (void *) raw_super->uuid, sizeof(raw_super->uuid));
> >         super_set_sysfs_name_bdev(sb);
> > -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> > +       sb_set_iflag(sb, SB_I_CGROUPWB);
> >
> >         /* init f2fs-specific super block info */
> >         sbi->valid_super_block = valid_super_block;
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 3602a578b7b3..5b6254481d5c 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1566,9 +1566,9 @@ static void fuse_sb_defaults(struct super_block *sb)
> >         sb->s_maxbytes = MAX_LFS_FILESIZE;
> >         sb->s_time_gran = 1;
> >         sb->s_export_op = &fuse_export_operations;
> > -       sb_set_iflag(sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE);
> > +       sb_set_iflag(sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE);
> >         if (sb->s_user_ns != &init_user_ns)
> > -               sb_set_iflag(sb, _SB_I_UNTRUSTED_MOUNTER);
> > +               sb_set_iflag(sb, SB_I_UNTRUSTED_MOUNTER);
> >         sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
> >  }
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index a8598a968940..3091385a4de1 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -216,7 +216,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> >         lockdep_set_class_and_name(&mapping->invalidate_lock,
> >                                    &sb->s_type->invalidate_lock_key,
> >                                    "mapping.invalidate_lock");
> > -       if (sb_test_iflag(sb, _SB_I_STABLE_WRITES))
> > +       if (sb_test_iflag(sb, SB_I_STABLE_WRITES))
> >                 mapping_set_stable_writes(mapping);
> >         inode->i_private = NULL;
> >         inode->i_mapping = mapping;
> > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > index 762edcf5387e..f5331f2e0b2d 100644
> > --- a/fs/kernfs/mount.c
> > +++ b/fs/kernfs/mount.c
> > @@ -252,8 +252,8 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
> >
> >         info->sb = sb;
> >         /* Userspace would break if executables or devices appear on sysfs */
> > -       sb_set_iflag(sb, _SB_I_NOEXEC);
> > -       sb_set_iflag(sb, _SB_I_NODEV);
> > +       sb_set_iflag(sb, SB_I_NOEXEC);
> > +       sb_set_iflag(sb, SB_I_NODEV);
> >         sb->s_blocksize = PAGE_SIZE;
> >         sb->s_blocksize_bits = PAGE_SHIFT;
> >         sb->s_magic = kfc->magic;
> > diff --git a/fs/namei.c b/fs/namei.c
> > index de6936564298..9e9bca0566e9 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3308,7 +3308,7 @@ EXPORT_SYMBOL(vfs_mkobj);
> >  bool may_open_dev(const struct path *path)
> >  {
> >         return !(path->mnt->mnt_flags & MNT_NODEV) &&
> > -               !sb_test_iflag(path->mnt->mnt_sb, _SB_I_NODEV);
> > +               !sb_test_iflag(path->mnt->mnt_sb, SB_I_NODEV);
> >  }
> >
> >  static int may_open(struct mnt_idmap *idmap, const struct path *path,
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 17126569b3c4..1c5591673f96 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2919,7 +2919,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
> >         struct super_block *sb = mnt->mnt_sb;
> >
> >         if (!__mnt_is_readonly(mnt) &&
> > -          !sb_test_iflag(sb, _SB_I_TS_EXPIRY_WARNED) &&
> > +          !sb_test_iflag(sb, SB_I_TS_EXPIRY_WARNED) &&
> >            (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
> >                 char *buf = (char *)__get_free_page(GFP_KERNEL);
> >                 char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
> > @@ -2931,7 +2931,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
> >                         (unsigned long long)sb->s_time_max);
> >
> >                 free_page((unsigned long)buf);
> > -               sb_set_iflag(sb, _SB_I_TS_EXPIRY_WARNED);
> > +               sb_set_iflag(sb, SB_I_TS_EXPIRY_WARNED);
> >         }
> >  }
> >
> > @@ -5629,10 +5629,10 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
> >                 return false;
> >
> >         /* Can this filesystem be too revealing? */
> > -       if (!sb_test_iflag(sb, _SB_I_USERNS_VISIBLE))
> > +       if (!sb_test_iflag(sb, SB_I_USERNS_VISIBLE))
> >                 return false;
> >
> > -       if (!sb_test_iflag(sb, _SB_I_NOEXEC) || !sb_test_iflag(sb, _SB_I_NODEV)) {
> > +       if (!sb_test_iflag(sb, SB_I_NOEXEC) || !sb_test_iflag(sb, SB_I_NODEV)) {
> >                 WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC and "
> >                           "SB_I_NODEV\n");
> >                 return true;
> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index 2fbae7e2b6ce..52fc52b6350f 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -1643,7 +1643,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
> >                 ctx->xprtsec.cert_serial        = TLS_NO_CERT;
> >                 ctx->xprtsec.privkey_serial     = TLS_NO_PRIVKEY;
> >
> > -               fc->s_iflags            |= 1 << _SB_I_STABLE_WRITES;
> > +               fc->s_iflags            |= 1 << SB_I_STABLE_WRITES;
> >         }
> >         fc->fs_private = ctx;
> >         fc->ops = &nfs_fs_context_ops;
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index b6b806fb6286..246ecceda7c8 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -1094,7 +1094,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
> >                 sb->s_export_op = &nfs_export_ops;
> >                 break;
> >         case 4:
> > -               sb_set_iflag(sb, _SB_I_NOUMASK);
> > +               sb_set_iflag(sb, SB_I_NOUMASK);
> >                 sb->s_time_gran = 1;
> >                 sb->s_time_min = S64_MIN;
> >                 sb->s_time_max = S64_MAX;
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index afa5263ff016..f5a60d0bcb1c 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1453,14 +1453,14 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> >  #ifdef CONFIG_FS_POSIX_ACL
> >         sb->s_flags |= SB_POSIXACL;
> >  #endif
> > -       sb_set_iflag(sb, _SB_I_SKIP_SYNC);
> > +       sb_set_iflag(sb, SB_I_SKIP_SYNC);
> >         /*
> >          * Ensure that umask handling is done by the filesystems used
> >          * for the the upper layer instead of overlayfs as that would
> >          * lead to unexpected results.
> >          */
> > -       sb_set_iflag(sb, _SB_I_NOUMASK);
> > -       sb_set_iflag(sb, _SB_I_EVM_HMAC_UNSUPPORTED);
> > +       sb_set_iflag(sb, SB_I_NOUMASK);
> > +       sb_set_iflag(sb, SB_I_EVM_HMAC_UNSUPPORTED);
> >
> >         err = -ENOMEM;
> >         root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index ac78ec69dde9..7acfa535b925 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -171,9 +171,9 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
> >         proc_apply_options(fs_info, fc, current_user_ns());
> >
> >         /* User space would break if executables or devices appear on proc */
> > -       sb_set_iflag(s, _SB_I_USERNS_VISIBLE);
> > -       sb_set_iflag(s, _SB_I_NOEXEC);
> > -       sb_set_iflag(s, _SB_I_NODEV);
> > +       sb_set_iflag(s, SB_I_USERNS_VISIBLE);
> > +       sb_set_iflag(s, SB_I_NOEXEC);
> > +       sb_set_iflag(s, SB_I_NODEV);
> >         s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> >         s->s_blocksize = 1024;
> >         s->s_blocksize_bits = 10;
> > diff --git a/fs/super.c b/fs/super.c
> > index e3020b3db4f0..873808245d54 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -355,7 +355,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
> >         s->s_bdi = &noop_backing_dev_info;
> >         s->s_flags = flags;
> >         if (s->s_user_ns != &init_user_ns)
> > -               sb_set_iflag(s, _SB_I_NODEV);
> > +               sb_set_iflag(s, SB_I_NODEV);
> >         INIT_HLIST_NODE(&s->s_instances);
> >         INIT_HLIST_BL_HEAD(&s->s_roots);
> >         mutex_init(&s->s_sync_lock);
> > @@ -589,11 +589,11 @@ void retire_super(struct super_block *sb)
> >  {
> >         WARN_ON(!sb->s_bdev);
> >         __super_lock_excl(sb);
> > -       if (sb_test_iflag(sb, _SB_I_PERSB_BDI)) {
> > +       if (sb_test_iflag(sb, SB_I_PERSB_BDI)) {
> >                 bdi_unregister(sb->s_bdi);
> > -               sb_clear_iflag(sb, _SB_I_PERSB_BDI);
> > +               sb_clear_iflag(sb, SB_I_PERSB_BDI);
> >         }
> > -       sb_set_iflag(sb, _SB_I_RETIRED);
> > +       sb_set_iflag(sb, SB_I_RETIRED);
> >         super_unlock_excl(sb);
> >  }
> >  EXPORT_SYMBOL(retire_super);
> > @@ -678,7 +678,7 @@ void generic_shutdown_super(struct super_block *sb)
> >         super_wake(sb, SB_DYING);
> >         super_unlock_excl(sb);
> >         if (sb->s_bdi != &noop_backing_dev_info) {
> > -               if (sb_test_iflag(sb, _SB_I_PERSB_BDI))
> > +               if (sb_test_iflag(sb, SB_I_PERSB_BDI))
> >                         bdi_unregister(sb->s_bdi);
> >                 bdi_put(sb->s_bdi);
> >                 sb->s_bdi = &noop_backing_dev_info;
> > @@ -1331,7 +1331,7 @@ static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
> >
> >  static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
> >  {
> > -       return !sb_test_iflag(s, _SB_I_RETIRED) &&
> > +       return !sb_test_iflag(s, SB_I_RETIRED) &&
> >                 s->s_dev == *(dev_t *)fc->sget_key;
> >  }
> >
> > @@ -1584,7 +1584,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
> >         sb->s_bdev = bdev;
> >         sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
> >         if (bdev_stable_writes(bdev))
> > -               sb_set_iflag(sb, _SB_I_STABLE_WRITES);
> > +               sb_set_iflag(sb, SB_I_STABLE_WRITES);
> >         spin_unlock(&sb_lock);
> >
> >         snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
> > @@ -1648,7 +1648,7 @@ EXPORT_SYMBOL(get_tree_bdev);
> >
> >  static int test_bdev_super(struct super_block *s, void *data)
> >  {
> > -       return !sb_test_iflag(s, _SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
> > +       return !sb_test_iflag(s, SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
> >  }
> >
> >  struct dentry *mount_bdev(struct file_system_type *fs_type,
> > @@ -1864,7 +1864,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
> >         }
> >         WARN_ON(sb->s_bdi != &noop_backing_dev_info);
> >         sb->s_bdi = bdi;
> > -       sb_set_iflag(sb, _SB_I_PERSB_BDI);
> > +       sb_set_iflag(sb, SB_I_PERSB_BDI);
> >
> >         return 0;
> >  }
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 4e5ad48316be..a7c0645aa9dc 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -79,7 +79,7 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
> >
> >  static void sync_fs_one_sb(struct super_block *sb, void *arg)
> >  {
> > -       if (!sb_rdonly(sb) && !sb_test_iflag(sb, _SB_I_SKIP_SYNC) &&
> > +       if (!sb_rdonly(sb) && !sb_test_iflag(sb, SB_I_SKIP_SYNC) &&
> >             sb->s_op->sync_fs)
> >                 sb->s_op->sync_fs(sb, *(int *)arg);
> >  }
> > diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
> > index 124385961da7..b461c216731a 100644
> > --- a/fs/sysfs/mount.c
> > +++ b/fs/sysfs/mount.c
> > @@ -33,7 +33,7 @@ static int sysfs_get_tree(struct fs_context *fc)
> >                 return ret;
> >
> >         if (kfc->new_sb_created)
> > -               sb_set_iflag(fc->root->d_sb, _SB_I_USERNS_VISIBLE);
> > +               sb_set_iflag(fc->root->d_sb, SB_I_USERNS_VISIBLE);
> >         return 0;
> >  }
> >
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 7707f2a1a836..0020724e3b0a 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1701,7 +1701,7 @@ xfs_fs_fill_super(
> >                 sb->s_time_max = XFS_LEGACY_TIME_MAX;
> >         }
> >         trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
> > -       sb_set_iflag(sb, _SB_I_CGROUPWB);
> > +       sb_set_iflag(sb, SB_I_CGROUPWB);
> >
> >         set_posix_acl_flag(sb);
> >
> > diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> > index 54fdae7b1be4..bc5f96ba499e 100644
> > --- a/include/linux/backing-dev.h
> > +++ b/include/linux/backing-dev.h
> > @@ -176,7 +176,7 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
> >         return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> >                 cgroup_subsys_on_dfl(io_cgrp_subsys) &&
> >                 (bdi->capabilities & BDI_CAP_WRITEBACK) &&
> > -               sb_test_iflag(inode->i_sb, _SB_I_CGROUPWB);
> > +               sb_test_iflag(inode->i_sb, SB_I_CGROUPWB);
> >  }
> >
> >  /**
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 65e70ceb335e..52841aab13fb 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1174,22 +1174,22 @@ extern int send_sigurg(struct fown_struct *fown);
> >
> >  /* sb->s_iflags */
> >  enum {
> > -       _SB_I_CGROUPWB,         /* cgroup-aware writeback enabled */
> > -       _SB_I_NOEXEC,           /* Ignore executables on this fs */
> > -       _SB_I_NODEV,            /* Ignore devices on this fs */
> > -       _SB_I_STABLE_WRITES,    /* don't modify blks until WB is done */
> > +       SB_I_CGROUPWB,          /* cgroup-aware writeback enabled */
> > +       SB_I_NOEXEC,            /* Ignore executables on this fs */
> > +       SB_I_NODEV,             /* Ignore devices on this fs */
> > +       SB_I_STABLE_WRITES,     /* don't modify blks until WB is done */
> >
> >         /* sb->s_iflags to limit user namespace mounts */
> > -       _SB_I_USERNS_VISIBLE,   /* fstype already mounted */
> > -       _SB_I_IMA_UNVERIFIABLE_SIGNATURE,
> > -       _SB_I_UNTRUSTED_MOUNTER,
> > -       _SB_I_EVM_HMAC_UNSUPPORTED,
> > -
> > -       _SB_I_SKIP_SYNC,        /* Skip superblock at global sync */
> > -       _SB_I_PERSB_BDI,        /* has a per-sb bdi */
> > -       _SB_I_TS_EXPIRY_WARNED, /* warned about timestamp range expiry */
> > -       _SB_I_RETIRED,          /* superblock shouldn't be reused */
> > -       _SB_I_NOUMASK,          /* VFS does not apply umask */
> > +       SB_I_USERNS_VISIBLE,    /* fstype already mounted */
> > +       SB_I_IMA_UNVERIFIABLE_SIGNATURE,
> > +       SB_I_UNTRUSTED_MOUNTER,
> > +       SB_I_EVM_HMAC_UNSUPPORTED,
> > +
> > +       SB_I_SKIP_SYNC, /* Skip superblock at global sync */
> > +       SB_I_PERSB_BDI, /* has a per-sb bdi */
> > +       SB_I_TS_EXPIRY_WARNED,  /* warned about timestamp range expiry */
> > +       SB_I_RETIRED,           /* superblock shouldn't be reused */
> > +       SB_I_NOUMASK,           /* VFS does not apply umask */
> >  };
> >
> >  /* Possible states of 'frozen' field */
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 3fbf340dac1a..0bd6db9adb7f 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -107,7 +107,7 @@ extern void unlock_rename(struct dentry *, struct dentry *);
> >   */
> >  static inline umode_t __must_check mode_strip_umask(const struct inode *dir, umode_t mode)
> >  {
> > -       if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, _SB_I_NOUMASK))
> > +       if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, SB_I_NOUMASK))
> >                 mode &= ~current_umask();
> >         return mode;
> >  }
> > diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> > index e73fff4c2f12..abe4dfe4374c 100644
> > --- a/ipc/mqueue.c
> > +++ b/ipc/mqueue.c
> > @@ -406,8 +406,8 @@ static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
> >         struct inode *inode;
> >         struct ipc_namespace *ns = sb->s_fs_info;
> >
> > -       sb_set_iflag(sb, _SB_I_NOEXEC);
> > -       sb_set_iflag(sb, _SB_I_NODEV);
> > +       sb_set_iflag(sb, SB_I_NOEXEC);
> > +       sb_set_iflag(sb, SB_I_NODEV);
> >         sb->s_blocksize = PAGE_SIZE;
> >         sb->s_blocksize_bits = PAGE_SHIFT;
> >         sb->s_magic = MQUEUE_MAGIC;
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 3ff29bf73f04..a15a87250d55 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -155,7 +155,7 @@ static int is_unsupported_hmac_fs(struct dentry *dentry)
> >  {
> >         struct inode *inode = d_backing_inode(dentry);
> >
> > -       if (sb_test_iflag(inode->i_sb, _SB_I_EVM_HMAC_UNSUPPORTED)) {
> > +       if (sb_test_iflag(inode->i_sb, SB_I_EVM_HMAC_UNSUPPORTED)) {
> >                 pr_info_once("%s not supported\n", inode->i_sb->s_type->name);
> >                 return 1;
> >         }
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 9c290dd8a4ac..dfa16dba5d89 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -564,8 +564,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
> >          * system not willing to accept such a risk, fail the file signature
> >          * verification.
> >          */
> > -       if (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
> > -           (sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) ||
> > +       if (sb_test_iflag(inode->i_sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
> > +           (sb_test_iflag(inode->i_sb, SB_I_UNTRUSTED_MOUNTER) ||
> >              (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> >                 status = INTEGRITY_FAIL;
> >                 cause = "unverifiable-signature";
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index b04eaa33eca4..27d446136c4f 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -280,8 +280,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
> >          * (Limited to privileged mounted filesystems.)
> >          */
> >         if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
> > -           (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
> > -            !sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) &&
> > +           (sb_test_iflag(inode->i_sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
> > +            !sb_test_iflag(inode->i_sb, SB_I_UNTRUSTED_MOUNTER) &&
> >              !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> >                 iint->flags &= ~IMA_DONE_MASK;
> >                 iint->measured_pcrs = 0;
> > --
> > 2.35.3
> >
> >
> 

