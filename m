Return-Path: <linux-fsdevel+bounces-15924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E4895D68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C831F22EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289B15CD7E;
	Tue,  2 Apr 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="aPN+3TrT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC15C8E6
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088813; cv=none; b=FPi9U/mPci5U3ATNhyeF+B9AApZnrwLCE3MSSuWXNaEoxhSvbXADbCtYoe6iTArE9fNeBWXUDDUkvD+7Tw3aPV4g8ubCN09umbfXGQTOZqs7uMtRSEYvDkb9TPYip5/PZlnKlxEmXYqiO8Eq5fZe4FwYZO57HMdyj/eFega0QHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088813; c=relaxed/simple;
	bh=d5AkhZkan1UcC+kCnXJ7lxerK2G8UzmEvabNx/4kFGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVYV/d4qetuPyBfvBeFamxEBnuAmydiWwbdHXbNUwTpn7tA2Ib9zIgnmZoIp2DSJMqWLe10SHvIVcaEbEW0F25IFYJU63josyzJ9+33hw5J4iZKGuYETPFEOxlLQ5EVfR1AqDIDsLyoL/RhL5MRgOTytuGg2prqRCXq1VAoipVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=aPN+3TrT; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 77EA380A86;
	Tue,  2 Apr 2024 16:13:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712088803; bh=d5AkhZkan1UcC+kCnXJ7lxerK2G8UzmEvabNx/4kFGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aPN+3TrT185R7UDpTnAB4eSBdBqicfcwchlZq4Syq5WV9ACjNhgXpzNK0jDKCg+RW
	 YEC4b0lQmGMHC90i4oIMgpWQf6RMDMAM6mGJ1D69YekE1wQH8M7OQKlpBktetfpgyN
	 6kk2COU+QwA/MLvC6tAMR2s5dNjhj+XGXB4VlRJsrX158tfRuW1IkKDrv7ptVc9gu1
	 /c6oePtRWCPvD24Bjf/HcualXNo/VXTMGe7BP8b734K9+3ZHXnsXr2hyhA9yp6az0K
	 7/wv7q8tapf01wVqZzXFo0igFuktjN026XSJ88ANKW+BPhA9/dpfTAAopn9RhYgzTf
	 tIieLKiFmTTHg==
Message-ID: <c52a81b4-2e88-4a89-b2e5-fecbb3e3d03e@dorminy.me>
Date: Tue, 2 Apr 2024 16:13:22 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v15 9/9] fuse: auto-invalidate inode attributes in
 passthrough mode
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-10-amir73il@gmail.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20240206142453.1906268-10-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/6/24 09:24, Amir Goldstein wrote:
> After passthrough read/write, we invalidate a/c/mtime/size attributes
> if the backing inode attributes differ from FUSE inode attributes.
> 
> Do the same in fuse_getattr() and after detach of backing inode, so that
> passthrough mmap read/write changes to a/c/mtime/size attribute of the
> backing inode will be propagated to the FUSE inode.
> 
> The rules of invalidating a/c/mtime/size attributes with writeback cache
> are more complicated, so for now, writeback cache and passthrough cannot
> be enabled on the same filesystem.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   fs/fuse/dir.c         |  4 ++++
>   fs/fuse/fuse_i.h      |  2 ++
>   fs/fuse/inode.c       |  4 ++++
>   fs/fuse/iomode.c      |  5 +++-
>   fs/fuse/passthrough.c | 55 ++++++++++++++++++++++++++++++++++++-------
>   5 files changed, 61 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 95330c2ca3d8..7f9d002b8f23 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2118,6 +2118,10 @@ static int fuse_getattr(struct mnt_idmap *idmap,
>   		return -EACCES;
>   	}
>   
> +	/* Maybe update/invalidate attributes from backing inode */
> +	if (fuse_inode_backing(get_fuse_inode(inode)))
> +		fuse_backing_update_attr_mask(inode, request_mask);
> +
>   	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
>   }
>   
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 98f878a52af1..4b011d31012f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1456,6 +1456,8 @@ void fuse_backing_files_init(struct fuse_conn *fc);
>   void fuse_backing_files_free(struct fuse_conn *fc);
>   int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
>   int fuse_backing_close(struct fuse_conn *fc, int backing_id);
> +void fuse_backing_update_attr(struct inode *inode, struct fuse_backing *fb);
> +void fuse_backing_update_attr_mask(struct inode *inode, u32 request_mask);
>   
>   struct fuse_backing *fuse_passthrough_open(struct file *file,
>   					   struct inode *inode,
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index c26a84439934..c68f005b6e86 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1302,9 +1302,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>   			 * on a stacked fs (e.g. overlayfs) themselves and with
>   			 * max_stack_depth == 1, FUSE fs can be stacked as the
>   			 * underlying fs of a stacked fs (e.g. overlayfs).
> +			 *
> +			 * For now, writeback cache and passthrough cannot be
> +			 * enabled on the same filesystem.
>   			 */
>   			if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
>   			    (flags & FUSE_PASSTHROUGH) &&
> +			    !fc->writeback_cache &&
>   			    arg->max_stack_depth > 0 &&
>   			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
>   				fc->passthrough = 1;
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index c545058a01e1..96eb311fe7bd 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -157,8 +157,11 @@ void fuse_file_uncached_io_end(struct inode *inode)
>   	spin_unlock(&fi->lock);
>   	if (!uncached_io)
>   		wake_up(&fi->direct_io_waitq);
> -	if (oldfb)
> +	if (oldfb) {
> +		/* Maybe update attributes after detaching backing inode */
> +		fuse_backing_update_attr(inode, oldfb);
>   		fuse_backing_put(oldfb);
> +	}
>   }
>   
>   /*
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 260e76fc72d5..c1bb80a6e536 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -11,11 +11,8 @@
>   #include <linux/backing-file.h>
>   #include <linux/splice.h>
>   
> -static void fuse_file_accessed(struct file *file)
> +static void fuse_backing_accessed(struct inode *inode, struct fuse_backing *fb)
>   {
> -	struct inode *inode = file_inode(file);
> -	struct fuse_inode *fi = get_fuse_inode(inode);
> -	struct fuse_backing *fb = fuse_inode_backing(fi);
>   	struct inode *backing_inode = file_inode(fb->file);
>   	struct timespec64 atime = inode_get_atime(inode);
>   	struct timespec64 batime = inode_get_atime(backing_inode);
> @@ -25,11 +22,8 @@ static void fuse_file_accessed(struct file *file)
>   		fuse_invalidate_atime(inode);
>   }
>   
> -static void fuse_file_modified(struct file *file)
> +static void fuse_backing_modified(struct inode *inode, struct fuse_backing *fb)
>   {
> -	struct inode *inode = file_inode(file);
> -	struct fuse_inode *fi = get_fuse_inode(inode);
> -	struct fuse_backing *fb = fuse_inode_backing(fi);
>   	struct inode *backing_inode = file_inode(fb->file);
>   	struct timespec64 ctime = inode_get_ctime(inode);
>   	struct timespec64 mtime = inode_get_mtime(inode);
> @@ -42,6 +36,51 @@ static void fuse_file_modified(struct file *file)
>   		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>   }
>   
> +/* Called from fuse_file_uncached_io_end() after detach of backing inode */
> +void fuse_backing_update_attr(struct inode *inode, struct fuse_backing *fb)
> +{
> +	fuse_backing_modified(inode, fb);
> +	fuse_backing_accessed(inode, fb);
> +}
> +
> +/* Called from fuse_getattr() - may race with detach of backing inode */
> +void fuse_backing_update_attr_mask(struct inode *inode, u32 request_mask)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_backing *fb;
> +
> +	rcu_read_lock();
> +	fb = fuse_backing_get(fuse_inode_backing(fi));
> +	rcu_read_unlock();
> +	if (!fb)
> +		return;
> +
> +	if (request_mask & FUSE_STATX_MODSIZE)
> +		fuse_backing_modified(inode, fb);
> +	if (request_mask & STATX_ATIME)
> +		fuse_backing_accessed(inode, fb);
> +
> +	fuse_backing_put(fb);
> +}
> +
> +static void fuse_file_accessed(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_backing *fb = fuse_inode_backing(fi);
> +
> +	fuse_backing_accessed(inode, fb);
> +}
> +
> +static void fuse_file_modified(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_backing *fb = fuse_inode_backing(fi);
> +
> +	fuse_backing_modified(inode, fb);
> +}
> +
>   ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
>   	struct file *file = iocb->ki_filp;

I noticed this patch doesn't seem to have made it into 6.9 like the rest 
of these passthrough patches -- may I ask why it didn't make it? I think 
it still makes sense but I might be missing some change between what's 
in 6.9 and this version of the patches.

Thanks!

Sweet Tea

