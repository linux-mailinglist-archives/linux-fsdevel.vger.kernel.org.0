Return-Path: <linux-fsdevel+bounces-27032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC595DF55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A10281BDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451D4AEE0;
	Sat, 24 Aug 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PsrrRCr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4539AEB
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522445; cv=none; b=f7VgXfjiRkQwFq7gplWPhBvxNxk+eORDCk5p7ahVMvLXqNx4eODpCMBEYZegYVEoZ8lkCTB0hlSNZKLJzqfiqWEnW2fLltW6AsWHLsCj/fDheTY0VUvYiebi3xWC52qpqetsE+tS4OVD9uiMH3rOKmSzidl0Lne6HgfhpomGd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522445; c=relaxed/simple;
	bh=4ImGiN+dalc2EiWRh370E/B3dtlLzilEjmwdd2IVEeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqeChVSVN6UlTt/K3IMXMpY5pBt+jw2irTA4SUO7TR6S7VTM1/OTGJtnsfmn3aZZgS3BHJzd4j2KhPed9d09J8pqw33ONqKbOBZLD662DWFPOYL3qFvRif0Dtn76HGNKTGd1khNdhkpA3lq2At6iAN0Mnmhi711cEfKwTaJaErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PsrrRCr9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Aug 2024 14:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+ITsWywuC23zRTdq77oCvQf+VsMpS+1Bu1kjdXrVh8=;
	b=PsrrRCr9z6jwz+Bkb5H7+uHLX3xZVtfRwhzp8vi3xzE67EGsfNaoRZ+YXqOTrie+pcxII1
	zuSpPPmsHDgbG1qgdbQLu+2rXIDgObx6GuL9T51pWg7GrB+PxMmSTlQVg41VeqxkEapkTs
	Iqa9w4jE49p0MdHGwccBF8vyqxs3tCs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hongbo Li <lihongbo22@huawei.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: brauner@kernel.org, sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: support idmap mounts
Message-ID: <gagg6xzdz4vjfn2gdsyk2aj6mg6qwdv7lcn4vbfavx3ehtvxbi@kfxnnujnyjvw>
References: <20240824012724.1256722-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824012724.1256722-1-lihongbo22@huawei.com>
X-Migadu-Flow: FLOW_OUT

this is passing fstests, I'm just hoping for someone who's more familiar
with the idmapping stuff to glance at it before I merge - Christain,
look reasonable to you?

On Sat, Aug 24, 2024 at 09:27:24AM GMT, Hongbo Li wrote:
> We enable idmapped mounts for bcachefs. Here, we just pass down
> the user_namespace argument from the VFS methods to the relevant
> helpers.
> 
> The idmap test in bcachefs is as following:
> 
> ```
> 1. losetup /dev/loop1 bcachefs.img
> 2. ./bcachefs format /dev/loop1
> 3. mount -t bcachefs /dev/loop1 /mnt/bcachefs/
> 4. ./mount-idmapped --map-mount b:0:1000:1 /mnt/bcachefs /mnt/idmapped1/
> 
> ll /mnt/bcachefs
> total 2
> drwx------. 2 root root    0 Jun 14 14:10 lost+found
> -rw-r--r--. 1 root root 1945 Jun 14 14:12 profile
> 
> ll /mnt/idmapped1/
> 
> total 2
> drwx------. 2 1000 1000    0 Jun 14 14:10 lost+found
> -rw-r--r--. 1 1000 1000 1945 Jun 14 14:12 profile
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> ---
> v2:
>   - fix the gid translation when umask S_ISGID
> 
> v1:
>   - https://lore.kernel.org/all/20240615102038.3110867-1-lihongbo22@huawei.com/T/
> ---
>  fs/bcachefs/fs.c | 50 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index c50457ba808d..0fcab802d376 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -350,6 +350,8 @@ __bch2_create(struct mnt_idmap *idmap,
>  	subvol_inum inum;
>  	struct bch_subvolume subvol;
>  	u64 journal_seq = 0;
> +	kuid_t kuid;
> +	kgid_t kgid;
>  	int ret;
>  
>  	/*
> @@ -376,13 +378,15 @@ __bch2_create(struct mnt_idmap *idmap,
>  retry:
>  	bch2_trans_begin(trans);
>  
> +	kuid = mapped_fsuid(idmap, i_user_ns(&dir->v));
> +	kgid = mapped_fsgid(idmap, i_user_ns(&dir->v));
>  	ret   = bch2_subvol_is_ro_trans(trans, dir->ei_inum.subvol) ?:
>  		bch2_create_trans(trans,
>  				  inode_inum(dir), &dir_u, &inode_u,
>  				  !(flags & BCH_CREATE_TMPFILE)
>  				  ? &dentry->d_name : NULL,
> -				  from_kuid(i_user_ns(&dir->v), current_fsuid()),
> -				  from_kgid(i_user_ns(&dir->v), current_fsgid()),
> +				  from_kuid(i_user_ns(&dir->v), kuid),
> +				  from_kgid(i_user_ns(&dir->v), kgid),
>  				  mode, rdev,
>  				  default_acl, acl, snapshot_src, flags) ?:
>  		bch2_quota_acct(c, bch_qid(&inode_u), Q_INO, 1,
> @@ -800,11 +804,17 @@ static void bch2_setattr_copy(struct mnt_idmap *idmap,
>  {
>  	struct bch_fs *c = inode->v.i_sb->s_fs_info;
>  	unsigned int ia_valid = attr->ia_valid;
> +	kuid_t kuid;
> +	kgid_t kgid;
>  
> -	if (ia_valid & ATTR_UID)
> -		bi->bi_uid = from_kuid(i_user_ns(&inode->v), attr->ia_uid);
> -	if (ia_valid & ATTR_GID)
> -		bi->bi_gid = from_kgid(i_user_ns(&inode->v), attr->ia_gid);
> +	if (ia_valid & ATTR_UID) {
> +		kuid = from_vfsuid(idmap, i_user_ns(&inode->v), attr->ia_vfsuid);
> +		bi->bi_uid = from_kuid(i_user_ns(&inode->v), kuid);
> +	}
> +	if (ia_valid & ATTR_GID) {
> +		kgid = from_vfsgid(idmap, i_user_ns(&inode->v), attr->ia_vfsgid);
> +		bi->bi_gid = from_kgid(i_user_ns(&inode->v), kgid);
> +	}
>  
>  	if (ia_valid & ATTR_SIZE)
>  		bi->bi_size = attr->ia_size;
> @@ -819,11 +829,11 @@ static void bch2_setattr_copy(struct mnt_idmap *idmap,
>  	if (ia_valid & ATTR_MODE) {
>  		umode_t mode = attr->ia_mode;
>  		kgid_t gid = ia_valid & ATTR_GID
> -			? attr->ia_gid
> +			? kgid
>  			: inode->v.i_gid;
>  
> -		if (!in_group_p(gid) &&
> -		    !capable_wrt_inode_uidgid(idmap, &inode->v, CAP_FSETID))
> +		if (!in_group_or_capable(idmap, &inode->v,
> +			make_vfsgid(idmap, i_user_ns(&inode->v), gid)))
>  			mode &= ~S_ISGID;
>  		bi->bi_mode = mode;
>  	}
> @@ -839,17 +849,23 @@ int bch2_setattr_nonsize(struct mnt_idmap *idmap,
>  	struct btree_iter inode_iter = { NULL };
>  	struct bch_inode_unpacked inode_u;
>  	struct posix_acl *acl = NULL;
> +	kuid_t kuid;
> +	kgid_t kgid;
>  	int ret;
>  
>  	mutex_lock(&inode->ei_update_lock);
>  
>  	qid = inode->ei_qid;
>  
> -	if (attr->ia_valid & ATTR_UID)
> -		qid.q[QTYP_USR] = from_kuid(i_user_ns(&inode->v), attr->ia_uid);
> +	if (attr->ia_valid & ATTR_UID) {
> +		kuid = from_vfsuid(idmap, i_user_ns(&inode->v), attr->ia_vfsuid);
> +		qid.q[QTYP_USR] = from_kuid(i_user_ns(&inode->v), kuid);
> +	}
>  
> -	if (attr->ia_valid & ATTR_GID)
> -		qid.q[QTYP_GRP] = from_kgid(i_user_ns(&inode->v), attr->ia_gid);
> +	if (attr->ia_valid & ATTR_GID) {
> +		kgid = from_vfsgid(idmap, i_user_ns(&inode->v), attr->ia_vfsgid);
> +		qid.q[QTYP_GRP] = from_kgid(i_user_ns(&inode->v), kgid);
> +	}
>  
>  	ret = bch2_fs_quota_transfer(c, inode, qid, ~0,
>  				     KEY_TYPE_QUOTA_PREALLOC);
> @@ -905,13 +921,15 @@ static int bch2_getattr(struct mnt_idmap *idmap,
>  {
>  	struct bch_inode_info *inode = to_bch_ei(d_inode(path->dentry));
>  	struct bch_fs *c = inode->v.i_sb->s_fs_info;
> +	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, &inode->v);
> +	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, &inode->v);
>  
>  	stat->dev	= inode->v.i_sb->s_dev;
>  	stat->ino	= inode->v.i_ino;
>  	stat->mode	= inode->v.i_mode;
>  	stat->nlink	= inode->v.i_nlink;
> -	stat->uid	= inode->v.i_uid;
> -	stat->gid	= inode->v.i_gid;
> +	stat->uid	= vfsuid_into_kuid(vfsuid);
> +	stat->gid	= vfsgid_into_kgid(vfsgid);
>  	stat->rdev	= inode->v.i_rdev;
>  	stat->size	= i_size_read(&inode->v);
>  	stat->atime	= inode_get_atime(&inode->v);
> @@ -2169,7 +2187,7 @@ static struct file_system_type bcache_fs_type = {
>  	.name			= "bcachefs",
>  	.init_fs_context	= bch2_init_fs_context,
>  	.kill_sb		= bch2_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>  
>  MODULE_ALIAS_FS("bcachefs");
> -- 
> 2.34.1
> 

