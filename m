Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03556363AC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 07:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhDSFCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 01:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSFCI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 01:02:08 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B43C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Apr 2021 22:01:39 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so5524733otp.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Apr 2021 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gc6u9uo+vC8RulIlt1GcE2iAKlGQUh2yZ4IyWMGgTvI=;
        b=p14frPcsaEpvIGz4weobGdBhnoPOpSAUWGgbIKY98KGfuLlIMGdzi3szJManARmcmR
         txQHuSALNpm7leLSuSSpl3QEN6CsL+iLd0ZPyqWB4W1s8WTROpy8GjTiuElB46877x2g
         PFuY1OS4IfhuxaEPj46GuN04kxqmEKnQUplKe8ZvH8whWkYERHVdhzSbmoPcbcrBZwjC
         jMjB0HardJy1qKqY8LVE+/Rew4OpUwXHggiI/amL49oF3d2VDcY54FOzizF+vdkRN4OF
         SaBlRF+jFGkZNdxVUt0lPuXm47Vy7gCZRi8m0F+c74PsdYHzPR0TYPqvRAMGXZRdf/kq
         MJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gc6u9uo+vC8RulIlt1GcE2iAKlGQUh2yZ4IyWMGgTvI=;
        b=XBnnaWQAQIT5UvkXUgnFIJYm5PJs01+JtDklG5doJAHErK9Euvwd9Ltvw/tNh1+1pe
         ruNOxwN1fv+wxP0CwPLoZ7ZQSJWbZ+EFreDQvqecAzlmU7AXnoXREgwSsaVEay46ax2g
         BwqOATuKAA+U72WsVl5odTOeYvG6TLn268ePwqx2HGvxxStC9PkSMiPaqKZnYG+MXwHf
         JsaqdQ9OgJv68PmIkgGjXdqEMNuLPAXD6uJgvoWUGljD9mcaVtBPJo2F3eMHYvKS7RCJ
         Y/n71y9KSxjpJjMxM263ep/jZbFc5PZ2/X+L0sO42Up8IPXVAenztlTId8K3Srp7Jzb9
         TNPw==
X-Gm-Message-State: AOAM531Ner0ytnXm9qt52DH7IjuouxSRwhdAlEN8iWNbzXGRaBwaCNjE
        e5OfOYn2KwptWMbtFGttSF8a7eQaTgBrLKbDw9k=
X-Google-Smtp-Source: ABdhPJxIHP6Lp44PcHiceGNDeLqR1knJimk4Ui6aGv/XuM5ngvXWAAsVwtri+ckj82Sw/X8uHEgB7A==
X-Received: by 2002:a9d:7342:: with SMTP id l2mr13558576otk.175.1618808498876;
        Sun, 18 Apr 2021 22:01:38 -0700 (PDT)
Received: from elm (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id 68sm3219655otc.54.2021.04.18.22.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 22:01:38 -0700 (PDT)
Date:   Mon, 19 Apr 2021 00:01:28 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-cachefs@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 6/7] ecryptfs: switch to using a private mount
Message-ID: <20210419050128.GA405651@elm>
References: <20210414123750.2110159-1-brauner@kernel.org>
 <20210414123750.2110159-7-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414123750.2110159-7-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-14 14:37:50, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Since [1] we support creating private mounts from a given path's
> vfsmount. This makes them very suitable for any filesystem or
> filesystem functionality that piggybacks on paths of another filesystem.
> Overlayfs, cachefiles, and ecryptfs are three prime examples.
> 
> Since private mounts aren't attached in the filesystem they aren't
> affected by mount property changes after ecryptfs makes use of them.
> This seems a rather desirable property as the underlying path can't e.g.
> suddenly go from read-write to read-only and in general it means that
> ecryptfs is always in full control of the underlying mount after the
> user has allowed it to be used (apart from operations that affect the
> superblock of course).
> 
> Besides that it also makes things simpler for a variety of other vfs
> features. One concrete example is fanotify. When the path->mnt of the
> path that is used as a cache has been marked with FAN_MARK_MOUNT the
> semantics get tricky as it isn't clear whether the watchers of path->mnt
> should get notified about fsnotify events when files are created by
> ecryptfs via path->mnt. Using a private mount let's us elegantly
> handle this case too and aligns the behavior of stacks created by
> overlayfs and cachefiles.
> 
> This change comes with a proper simplification in how ecryptfs currently
> handles the lower_path it stashes as private information in its
> dentries. Currently it always does:
> 
>         ecryptfs_set_dentry_private(dentry, dentry_info);
>         dentry_info->lower_path.mnt = mntget(path->mnt);
>         dentry_info->lower_path.dentry = lower_dentry;
> 
> and then during .d_relase() in ecryptfs_d_release():
> 
>         path_put(&p->lower_path);
> 
> which is odd since afaict path->mnt is guaranteed to be the mnt stashed
> during ecryptfs_mount():
> 
>         ecryptfs_set_dentry_private(s->s_root, root_info);
>         root_info->lower_path = path;
> 
> So that mntget() seems somewhat pointless but there might be reasons
> that I'm missing in how the interpose logic for ecryptfs works.
> 
> While switching to a long-term private mount via clone_private_mount()
> let's get rid of the gratuitous mntget() and mntput()/path_put().
> Instead, stash away the private mount in ecryptfs' s_fs_info and call
> kern_unmount() in .kill_sb() so we only take the mntput() hit once.
> 
> I've added a WARN_ON_ONCE() into ecryptfs_lookup_interpose() triggering
> if the stashed private mount and the path's mount don't match. I think
> that would be a proper bug even without that clone_private_mount()
> change in this patch.
> 
> [1]: c771d683a62e ("vfs: introduce clone_private_mount()")
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: ecryptfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

This patch and the following one both look technically correct to me. I
do want to spend a little time manually testing these changes, though.
I'm hoping to have that done by end of day Tuesday.

Tyler

> ---
>  fs/ecryptfs/dentry.c          |  6 +++++-
>  fs/ecryptfs/ecryptfs_kernel.h |  9 +++++++++
>  fs/ecryptfs/inode.c           |  5 ++++-
>  fs/ecryptfs/main.c            | 29 ++++++++++++++++++++++++-----
>  4 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
> index 44606f079efb..e5edafa165d4 100644
> --- a/fs/ecryptfs/dentry.c
> +++ b/fs/ecryptfs/dentry.c
> @@ -67,7 +67,11 @@ static void ecryptfs_d_release(struct dentry *dentry)
>  {
>  	struct ecryptfs_dentry_info *p = dentry->d_fsdata;
>  	if (p) {
> -		path_put(&p->lower_path);
> +		/*
> +		 * p->lower_path.mnt is a private mount which will be released
> +		 * when the superblock shuts down so we only need to dput here.
> +		 */
> +		dput(p->lower_path.dentry);
>  		call_rcu(&p->rcu, ecryptfs_dentry_free_rcu);
>  	}
>  }
> diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
> index e6ac78c62ca4..f89d0f7bb3fe 100644
> --- a/fs/ecryptfs/ecryptfs_kernel.h
> +++ b/fs/ecryptfs/ecryptfs_kernel.h
> @@ -352,6 +352,7 @@ struct ecryptfs_mount_crypt_stat {
>  struct ecryptfs_sb_info {
>  	struct super_block *wsi_sb;
>  	struct ecryptfs_mount_crypt_stat mount_crypt_stat;
> +	struct vfsmount *mnt;
>  };
>  
>  /* file private data. */
> @@ -496,6 +497,14 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
>  	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
>  }
>  
> +static inline void
> +ecryptfs_set_superblock_lower_mnt(struct super_block *sb,
> +				  struct vfsmount *mnt)
> +{
> +	struct ecryptfs_sb_info *sbi = sb->s_fs_info;
> +	sbi->mnt = mnt;
> +}
> +
>  static inline struct ecryptfs_dentry_info *
>  ecryptfs_dentry_to_private(struct dentry *dentry)
>  {
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 18e9285fbb4c..204df4bf476d 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -324,6 +324,7 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
>  				     struct dentry *lower_dentry)
>  {
>  	struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
> +	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(dentry->d_sb);
>  	struct inode *inode, *lower_inode;
>  	struct ecryptfs_dentry_info *dentry_info;
>  	int rc = 0;
> @@ -339,7 +340,9 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
>  	BUG_ON(!d_count(lower_dentry));
>  
>  	ecryptfs_set_dentry_private(dentry, dentry_info);
> -	dentry_info->lower_path.mnt = mntget(path->mnt);
> +	/* Warn if we somehow ended up with an unexpected path. */
> +	WARN_ON_ONCE(path->mnt != sb_info->mnt);
> +	dentry_info->lower_path.mnt = path->mnt;
>  	dentry_info->lower_path.dentry = lower_dentry;
>  
>  	/*
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index cdf40a54a35d..3ba2c0f349a3 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -476,6 +476,7 @@ static struct file_system_type ecryptfs_fs_type;
>  static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags,
>  			const char *dev_name, void *raw_data)
>  {
> +	struct vfsmount *mnt;
>  	struct super_block *s;
>  	struct ecryptfs_sb_info *sbi;
>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
> @@ -537,6 +538,16 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
>  		goto out_free;
>  	}
>  
> +	mnt = clone_private_mount(&path);
> +	if (IS_ERR(mnt)) {
> +		rc = PTR_ERR(mnt);
> +		pr_warn("Failed to create private mount for ecryptfs\n");
> +		goto out_free;
> +	}
> +
> +	/* Record our long-term lower mount. */
> +	ecryptfs_set_superblock_lower_mnt(s, mnt);
> +
>  	if (check_ruid && !uid_eq(d_inode(path.dentry)->i_uid, current_uid())) {
>  		rc = -EPERM;
>  		printk(KERN_ERR "Mount of device (uid: %d) not owned by "
> @@ -590,9 +601,15 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
>  	if (!root_info)
>  		goto out_free;
>  
> +	/* Use our private mount from now on. */
> +	root_info->lower_path.mnt = mnt;
> +	root_info->lower_path.dentry = dget(path.dentry);
> +
> +	/* We created a private clone of this mount above so drop the path. */
> +	path_put(&path);
> +
>  	/* ->kill_sb() will take care of root_info */
>  	ecryptfs_set_dentry_private(s->s_root, root_info);
> -	root_info->lower_path = path;
>  
>  	s->s_flags |= SB_ACTIVE;
>  	return dget(s->s_root);
> @@ -619,11 +636,13 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
>  static void ecryptfs_kill_block_super(struct super_block *sb)
>  {
>  	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
> +
>  	kill_anon_super(sb);
> -	if (!sb_info)
> -		return;
> -	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
> -	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
> +	if (sb_info) {
> +		kern_unmount(sb_info->mnt);
> +		ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
> +		kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
> +	}
>  }
>  
>  static struct file_system_type ecryptfs_fs_type = {
> -- 
> 2.27.0
> 
