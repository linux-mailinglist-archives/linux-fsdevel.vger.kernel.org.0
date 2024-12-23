Return-Path: <linux-fsdevel+bounces-38024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE319FAF52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6387A25FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A48714286;
	Mon, 23 Dec 2024 14:17:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31A1C36
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963444; cv=none; b=jBnFlUG6KMO8fv9qUt+O1clKXXSr4OMY+nMYpdGG/Ax6OmEm5wGID4mS/zqP/DW1sDnsJfHTjGhSd3xdPoD2dgXoMoWX4D8fYNLuPhfvIFwBW6pFnm/YMgSof7JQdLMfd2WpqEvLgd2ZbwMBiRW3b0MDuatyVBd2RLzQx2oPrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963444; c=relaxed/simple;
	bh=3+hCzobGASM1HEBoScZcjUYTApnHKHs2VGd+ZmtoZBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RallRIimP8KaMqhZs/BcDb4a/VLY2/VKZ7GxMQhtZ5bwpewD9MYeP/QS6o+8caQ2sGeitUok6wHapEyRgm00lX5uH4kqa/2kG3oXIZvCDpDS8ROFN3WeRNXLs/Ag6NgpIKpXW7QZ0MyIvOWzWSJ/pkVMITjT25M/Hf43PeyqInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YH0T9317tz4f3jkk
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:17:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 05AAC1A018C
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 22:17:16 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYXqcGlnLPiuFQ--.13522S3;
	Mon, 23 Dec 2024 22:17:15 +0800 (CST)
Message-ID: <f072048e-fec4-22bb-76ff-dbafe3a7fa78@huaweicloud.com>
Date: Mon, 23 Dec 2024 22:17:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 2/5] Revert "libfs: Add simple_offset_empty()"
To: cel@kernel.org, Hugh Dickins <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 Chuck Lever <chuck.lever@oracle.com>
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-3-cel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241220153314.5237-3-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYXqcGlnLPiuFQ--.13522S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xtFWUuw17Zry7Xr1fWFg_yoW5urWfpF
	nxKF4fKr4fX348WFWvvFsrZ34Fvw1DWr1UJ3yfWw4rtry2yrn7tF1Ikr4Y9as0krykCr47
	XFs8KFnY9a1UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

在 2024/12/20 23:33, cel@kernel.org 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> simple_empty() and simple_offset_empty() perform the same task.
> The latter's use as a canary to find bugs has not found any new
> issues. A subsequent patch will remove the use of the mtree for
> iterating directory contents, so revert back to using a similar
> mechanism for determining whether a directory is indeed empty.
> 
> Only one such mechanism is ever needed.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c         | 32 --------------------------------
>   include/linux/fs.h |  1 -
>   mm/shmem.c         |  4 ++--
>   3 files changed, 2 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 3da58a92f48f..8380d9314ebd 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -329,38 +329,6 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
>   	offset_set(dentry, 0);
>   }
>   
> -/**
> - * simple_offset_empty - Check if a dentry can be unlinked
> - * @dentry: dentry to be tested
> - *
> - * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
> - */
> -int simple_offset_empty(struct dentry *dentry)
> -{
> -	struct inode *inode = d_inode(dentry);
> -	struct offset_ctx *octx;
> -	struct dentry *child;
> -	unsigned long index;
> -	int ret = 1;
> -
> -	if (!inode || !S_ISDIR(inode->i_mode))
> -		return ret;
> -
> -	index = DIR_OFFSET_MIN;
> -	octx = inode->i_op->get_offset_ctx(inode);
> -	mt_for_each(&octx->mt, child, index, LONG_MAX) {
> -		spin_lock(&child->d_lock);
> -		if (simple_positive(child)) {
> -			spin_unlock(&child->d_lock);
> -			ret = 0;
> -			break;
> -		}
> -		spin_unlock(&child->d_lock);
> -	}
> -
> -	return ret;
> -}
> -
>   /**
>    * simple_offset_rename - handle directory offsets for rename
>    * @old_dir: parent directory of source entry
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..f7efc6866ebc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3468,7 +3468,6 @@ struct offset_ctx {
>   void simple_offset_init(struct offset_ctx *octx);
>   int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
>   void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
> -int simple_offset_empty(struct dentry *dentry);
>   int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
>   			 struct inode *new_dir, struct dentry *new_dentry);
>   int simple_offset_rename_exchange(struct inode *old_dir,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ccb9629a0f70..274c2666f457 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3818,7 +3818,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>   
>   static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
>   {
> -	if (!simple_offset_empty(dentry))
> +	if (!simple_empty(dentry))
>   		return -ENOTEMPTY;
>   
>   	drop_nlink(d_inode(dentry));
> @@ -3875,7 +3875,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>   		return simple_offset_rename_exchange(old_dir, old_dentry,
>   						     new_dir, new_dentry);
>   
> -	if (!simple_offset_empty(new_dentry))
> +	if (!simple_empty(new_dentry))
>   		return -ENOTEMPTY;
>   
>   	if (flags & RENAME_WHITEOUT) {


