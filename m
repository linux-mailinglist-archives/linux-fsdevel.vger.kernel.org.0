Return-Path: <linux-fsdevel+bounces-53398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61988AEE671
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903613E083E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08622E7171;
	Mon, 30 Jun 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtPwYcXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5113774D;
	Mon, 30 Jun 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306721; cv=none; b=BN/Ch2GQjKP66YSm2qmnxvcTbtVeOpcLGw+uSzuA44c/J2MRQPVvjEdbne+F0UF9sx5Tc7OaRSxbhU0n4oI00BJeygKhTsXC4PM+H164xCon91/rFwYCHDcjwDcETQkGnM1O+Kd6ojzOSdsigQh/l+zY2KxKNL7Wos41y92LbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306721; c=relaxed/simple;
	bh=tl3IJSJVWYtA6RkFsx548Iw+3juorNIHo0GmkdIldYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz7Kg8Mq0rMaHVr0IElOiP4iLUROaWYuKa7v6YQEFvlIS7wBDjbiJwfRLjrj9Bs9G4zkwsN5ciL9jnH3dcgP7KDoBL8bRcCWkn8DHfuJuzax/7JMCyFi3ZgvwRi0IdcmW4se2kUqfVAuTDVJWiRMj9fnAkJ0y8CRqwEyPIom35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtPwYcXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E9C4CEE3;
	Mon, 30 Jun 2025 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751306720;
	bh=tl3IJSJVWYtA6RkFsx548Iw+3juorNIHo0GmkdIldYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtPwYcXZCYQbUJ0UW5mJ3NLb5ej0jQhVjsJVjjsaONidi8/FG4sIG5VUW5i0BpmuC
	 mKH8LIOymp+izoaWZ7GLbl7pykOcPNWtPCJ77LoEacc9QWgjb2xfP6X3H4cGT3ePhb
	 4Q4c5hTrz/qFikIotbEyZRabHmHhn1zq2ME3aTwuP56fNcI8D/3ktwLU5T3UJo6dVi
	 1PZWpqq3UMArcRuKfh+fgIVUUON+f9qlGsE2Ma5sbVLAz1ZGiiscerke8TfqGXN+/l
	 QEDRO5BK2MwGDuWZpJtuAAJVls09YT9Xd13Z4V4WDbcqvHmfSAy4YUXzcxXnor+jMR
	 DAdBaP4exac4A==
Received: by pali.im (Postfix)
	id 029617FE; Mon, 30 Jun 2025 20:05:17 +0200 (CEST)
Date: Mon, 30 Jun 2025 20:05:17 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <20250630180517.5jrptwuucy4c6ezk@pali>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
User-Agent: NeoMutt/20180716

nit: typo in commit subject and description: Missing T in EOPNO*T*SUPP.
But please do not resend whole patch series just because of this.
That is not needed.

On Monday 30 June 2025 18:20:14 Andrey Albershteyn wrote:
> Future patches will add new syscalls which use these functions. As
> this interface won't be used for ioctls only, the EOPNOSUPP is more
> appropriate return code.
> 
> This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/ecryptfs/inode.c  |  8 +++++++-
>  fs/file_attr.c       | 12 ++++++++++--
>  fs/overlayfs/inode.c |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 493d7f194956..a55c1375127f 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1126,7 +1126,13 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
>  
>  static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
> -	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	int rc;
> +
> +	rc = vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	if (rc == -EOPNOTSUPP)
> +		rc = -ENOIOCTLCMD;
> +
> +	return rc;
>  }
>  
>  static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index be62d97cc444..4e85fa00c092 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -79,7 +79,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  	int error;
>  
>  	if (!inode->i_op->fileattr_get)
> -		return -ENOIOCTLCMD;
> +		return -EOPNOTSUPP;
>  
>  	error = security_inode_file_getattr(dentry, fa);
>  	if (error)
> @@ -229,7 +229,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  	int err;
>  
>  	if (!inode->i_op->fileattr_set)
> -		return -ENOIOCTLCMD;
> +		return -EOPNOTSUPP;
>  
>  	if (!inode_owner_or_capable(idmap, inode))
>  		return -EPERM;
> @@ -271,6 +271,8 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
>  	int err;
>  
>  	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (err == -EOPNOTSUPP)
> +		err = -ENOIOCTLCMD;
>  	if (!err)
>  		err = put_user(fa.flags, argp);
>  	return err;
> @@ -292,6 +294,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  			fileattr_fill_flags(&fa, flags);
>  			err = vfs_fileattr_set(idmap, dentry, &fa);
>  			mnt_drop_write_file(file);
> +			if (err == -EOPNOTSUPP)
> +				err = -ENOIOCTLCMD;
>  		}
>  	}
>  	return err;
> @@ -304,6 +308,8 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
>  	int err;
>  
>  	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (err == -EOPNOTSUPP)
> +		err = -ENOIOCTLCMD;
>  	if (!err)
>  		err = copy_fsxattr_to_user(&fa, argp);
>  
> @@ -324,6 +330,8 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  		if (!err) {
>  			err = vfs_fileattr_set(idmap, dentry, &fa);
>  			mnt_drop_write_file(file);
> +			if (err == -EOPNOTSUPP)
> +				err = -ENOIOCTLCMD;
>  		}
>  	}
>  	return err;
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 6f0e15f86c21..096d44712bb1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
>  		return err;
>  
>  	err = vfs_fileattr_get(realpath->dentry, fa);
> -	if (err == -ENOIOCTLCMD)
> +	if (err == -EOPNOTSUPP)
>  		err = -ENOTTY;
>  	return err;
>  }
> 
> -- 
> 2.47.2
> 

