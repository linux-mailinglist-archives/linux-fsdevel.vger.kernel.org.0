Return-Path: <linux-fsdevel+bounces-38025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F79FAF53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3019F165813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97A13FEE;
	Mon, 23 Dec 2024 14:17:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988ECEAFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963451; cv=none; b=D8gfNn6fOEh1fx/4lZNo+MXBlgqQlI1yjcKUTja4iwFZLWoxTADzidDYFYzI0EmQw82q/LirW0hD8In044O/xjWCa6fgBlsi2ooIBsQa76zYBDGby9+iQb4T8e4oFED/mmERb2aVnOvDTLmlRPEydqSH+cqWaVKKz+HMiCf4+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963451; c=relaxed/simple;
	bh=w3mka5qSOeGZYcJz+fOILnl9WIVvldMtYBNylfyJ6Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3oiR7HH45+hkcfmAvE8qOMuNhI8VX1RQ/7ny2I7/7WSRKv5ZCBV+pMuhdTep8xhZOl7E9dsUDcehWc1FxZgcrBSenE+8SV18moQKBgSpZIxRHgl8WM5GpOg6MgpouLF3l87OXtHteKoPQpGPWN3JpUrbSQ/uSpF3vDaVbpWhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YH0TD72mBz4f3lgB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:17:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B21B91A0359
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:17:25 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDnwob0cGlnHfuuFQ--.13616S3;
	Mon, 23 Dec 2024 22:17:25 +0800 (CST)
Message-ID: <a224beb9-d488-e641-835d-b76fc2394773@huaweicloud.com>
Date: Mon, 23 Dec 2024 22:17:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 3/5] Revert "libfs: fix infinite directory reads for
 offset dir"
To: cel@kernel.org, Hugh Dickins <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-4-cel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241220153314.5237-4-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnwob0cGlnHfuuFQ--.13616S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1kKw4Utw1rWF15Jr1DWrg_yoW7XF13pF
	ZxG3W3Kr4fX34jkF4vvF4DZr1F93Z3KF4UWr1ru345Ar9Iq398Kas2yr1qka4UJrZ5Cr1S
	qF45Kr13Zw4DCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>


在 2024/12/20 23:33, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The current directory offset allocator (based on mtree_alloc_cyclic)
> stores the next offset value to return in octx->next_offset. This
> mechanism typically returns values that increase monotonically over
> time. Eventually, though, the newly allocated offset value wraps
> back to a low number (say, 2) which is smaller than other already-
> allocated offset values.
> 
> Yu Kuai <yukuai3@huawei.com> reports that, after commit 64a7ce76fb90
> ("libfs: fix infinite directory reads for offset dir"), if a
> directory's offset allocator wraps, existing entries are no longer
> visible via readdir/getdents because offset_readdir() stops listing
> entries once an entry's offset is larger than octx->next_offset.
> These entries vanish persistently -- they can be looked up, but will
> never again appear in readdir(3) output.
> 
> The reason for this is that the commit treats directory offsets as
> monotonically increasing integer values rather than opaque cookies,
> and introduces this comparison:
> 
> 	if (dentry2offset(dentry) >= last_index) {
> 
> On 64-bit platforms, the directory offset value upper bound is
> 2^63 - 1. Directory offsets will monotonically increase for millions
> of years without wrapping.
> 
> On 32-bit platforms, however, LONG_MAX is 2^31 - 1. The allocator
> can wrap after only a few weeks (at worst).
> 
> Revert commit 64a7ce76fb90 ("libfs: fix infinite directory reads for
> offset dir") to prepare for a fix that can work properly on 32-bit
> systems and might apply to recent LTS kernels where shmem employs
> the simple_offset mechanism.
> 
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c | 35 +++++++++++------------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8380d9314ebd..8c9364a0174c 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -422,14 +422,6 @@ void simple_offset_destroy(struct offset_ctx *octx)
>   	mtree_destroy(&octx->mt);
>   }
>   
> -static int offset_dir_open(struct inode *inode, struct file *file)
> -{
> -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> -
> -	file->private_data = (void *)ctx->next_offset;
> -	return 0;
> -}
> -
>   /**
>    * offset_dir_llseek - Advance the read position of a directory descriptor
>    * @file: an open directory whose position is to be updated
> @@ -443,9 +435,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
>    */
>   static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   {
> -	struct inode *inode = file->f_inode;
> -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> -
>   	switch (whence) {
>   	case SEEK_CUR:
>   		offset += file->f_pos;
> @@ -459,8 +448,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   	}
>   
>   	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (!offset)
> -		file->private_data = (void *)ctx->next_offset;
> +	file->private_data = NULL;
>   	return vfs_setpos(file, offset, LONG_MAX);
>   }
>   
> @@ -491,7 +479,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>   			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>   }
>   
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
> +static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   {
>   	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>   	struct dentry *dentry;
> @@ -499,21 +487,17 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
>   	while (true) {
>   		dentry = offset_find_next(octx, ctx->pos);
>   		if (!dentry)
> -			return;
> -
> -		if (dentry2offset(dentry) >= last_index) {
> -			dput(dentry);
> -			return;
> -		}
> +			return ERR_PTR(-ENOENT);
>   
>   		if (!offset_dir_emit(ctx, dentry)) {
>   			dput(dentry);
> -			return;
> +			break;
>   		}
>   
>   		ctx->pos = dentry2offset(dentry) + 1;
>   		dput(dentry);
>   	}
> +	return NULL;
>   }
>   
>   /**
> @@ -540,19 +524,22 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
>   static int offset_readdir(struct file *file, struct dir_context *ctx)
>   {
>   	struct dentry *dir = file->f_path.dentry;
> -	long last_index = (long)file->private_data;
>   
>   	lockdep_assert_held(&d_inode(dir)->i_rwsem);
>   
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
>   
> -	offset_iterate_dir(d_inode(dir), ctx, last_index);
> +	/* In this case, ->private_data is protected by f_pos_lock */
> +	if (ctx->pos == DIR_OFFSET_MIN)
> +		file->private_data = NULL;
> +	else if (file->private_data == ERR_PTR(-ENOENT))
> +		return 0;
> +	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
>   	return 0;
>   }
>   
>   const struct file_operations simple_offset_dir_operations = {
> -	.open		= offset_dir_open,
>   	.llseek		= offset_dir_llseek,
>   	.iterate_shared	= offset_readdir,
>   	.read		= generic_read_dir,


