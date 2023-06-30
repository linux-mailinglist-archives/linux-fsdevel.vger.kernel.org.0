Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512C3743A56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjF3LIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjF3LIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:08:12 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F12707
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 04:08:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 49E5432009F2;
        Fri, 30 Jun 2023 07:08:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 30 Jun 2023 07:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688123286; x=1688209686; bh=3cUovgn6RrIc/EveZ/jC/IGkZsbXaM+3xWS
        MszdrokE=; b=QtQTXS5RGlKu2fiHLQQt/+PzME3YsLrxY/KVWUAw4Em5QuDSDM6
        SmvdH5+O68Hs0B1Ly/0hrtCwyLzrSj3XrKUV/0j21JVJ5Dpzj/wBqBapqp68gtAE
        +GtI+uG1UTF5MUk/sd2AzteL+ySOHlUdX+eYQfufW58zLayEZVQirgLTVs2cRYhA
        3+VXZZ9tdlNop/gcm5qaNmgi3EI+BAANHbErbdGWZRufJnJZ7tgLu6JeB1T3Cj+o
        wB0HMTEGkZ6BJUrJCD4qn0V645kGndo3Km6AXThNIr9RamOZj+Hj8gLTt5WMj9RF
        B5kK7SPYNHQBGFv69S1085Y9lw5YmH5kpxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688123286; x=1688209686; bh=3cUovgn6RrIc/EveZ/jC/IGkZsbXaM+3xWS
        MszdrokE=; b=P1ZLh44VC4+bfmNuNWkj2BVMLGr7WA5eDInFpkMCu66b30YUNJT
        Mf91qDcRrsoGnJ1bZQsqg753SrSWtd581SEdDTG9fzP4Z0bfLVxCfhfGlZ0EaOXM
        ladSkHHDJcUHmQuGLS0hFsyrdmzN1SGY65mQf/ciwgkPulZLjWoqxO0bRZGRQXh8
        ezBFS/wfUYImXOLyTIBORMDJbtH7Q/aFROm98QRcYfKxlExeZ+R/+ThRU5VpD7QZ
        wszYW5sBkUVWdBdELHN5Pmhi1qJ1+JfAguN/3W/K8vM8vodawlxcYyhndtcsauEI
        hoKaAlGHXY2AW/BMyAyM9ctxh9cxuSqfV5A==
X-ME-Sender: <xms:lreeZAPVf6rHQ_IlMKvkpA2RavV0VnW-wf8joYxF4LogYfGeX5Xb1w>
    <xme:lreeZG-AiLKK0bvv3Gdt1FIDqdT6LXYglYePUCcSJIn3-_hrxUGcRUiUpuect4zT4
    -DuKSSrI3XeUQlH>
X-ME-Received: <xmr:lreeZHTBNkfmGRA6Hsyx4Z_MKcKSoCkdEv1EsFfqscxss2XmaUMUOg5-2z4LmwCDF781P2_BI-Nv2Lg9FxjD2Qc5AAh6ubBhxmKEqecQJGyGijChbEIe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:lreeZIsC8rfwTVamVpBSdYQNzKE0h2-OXhk7O7lUpOhdGc8v1a-8Kg>
    <xmx:lreeZIe7u97ZMIT3b6596Q6VxJd19QTlVA0VAVhYu1AHrheB-PkPXg>
    <xmx:lreeZM2-xPODzpq2NiaBEHoIOmqW6e_RejrZ6RJBOGwYJ0JvJEz1ww>
    <xmx:lreeZGsEXyqozPuYk8k7_FMOSnoyBzZbwpoxQlhaNgJzAophnJrNLw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 07:08:04 -0400 (EDT)
Message-ID: <ca09c22e-8b85-b758-e38a-df78e829f132@fastmail.fm>
Date:   Fri, 30 Jun 2023 13:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/3] libfs: Add directory operations for stable offsets
Content-Language: en-US, de-DE
To:     Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <168796579723.157221.1988816921257656153.stgit@manet.1015granger.net>
 <168796590904.157221.11286772826871541854.stgit@manet.1015granger.net>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <168796590904.157221.11286772826871541854.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/28/23 17:25, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Create a vector of directory operations in fs/libfs.c that handles
> directory seeks and readdir via stable offsets instead of the
> current cursor-based mechanism.
> 
> For the moment these are unused.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/libfs.c         |  247 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/fs.h |   18 ++++
>   2 files changed, 265 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 89cf614a3271..2b0d5ac472df 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -239,6 +239,253 @@ const struct inode_operations simple_dir_inode_operations = {
>   };
>   EXPORT_SYMBOL(simple_dir_inode_operations);
>   
> +static void offset_set(struct dentry *dentry, unsigned long offset)
> +{
> +	dentry->d_fsdata = (void *)offset;
> +}
> +
> +static unsigned long dentry2offset(struct dentry *dentry)
> +{
> +	return (unsigned long)dentry->d_fsdata;
> +}
> +
> +/**
> + * simple_offset_init - initialize an offset_ctx
> + * @octx: directory offset map to be initialized
> + *
> + */
> +void simple_offset_init(struct offset_ctx *octx)
> +{
> +	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
> +
> +	/* 0 is '.', 1 is '..', so always start with offset 2 */
> +	octx->next_offset = 2;
> +}
> +
> +/**
> + * simple_offset_add - Add an entry to a directory's offset map
> + * @octx: directory offset ctx to be updated
> + * @dentry: new dentry being added
> + *
> + * Returns zero on success. @so_ctx and the dentry offset are updated.
> + * Otherwise, a negative errno value is returned.
> + */
> +int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
> +{
> +	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
> +	u32 offset;
> +	int ret;
> +
> +	if (dentry2offset(dentry) != 0)
> +		return -EBUSY;
> +
> +	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
> +			      &octx->next_offset, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	offset_set(dentry, offset);
> +	return 0;
> +}
> +
> +/**
> + * simple_offset_remove - Remove an entry to a directory's offset map
> + * @octx: directory offset ctx to be updated
> + * @dentry: dentry being removed
> + *
> + */
> +void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
> +{
> +	unsigned long index = dentry2offset(dentry);
> +
> +	if (index == 0)
> +		return;
> +
> +	xa_erase(&octx->xa, index);
> +	offset_set(dentry, 0);
> +}
> +
> +/**
> + * simple_offset_rename_exchange - exchange rename with directory offsets
> + * @old_dir: parent of dentry being moved
> + * @old_dentry: dentry being moved
> + * @new_dir: destination parent
> + * @new_dentry: destination dentry
> + *
> + * Returns zero on success. Otherwise a negative errno is returned and the
> + * rename is rolled back.
> + */
> +int simple_offset_rename_exchange(struct inode *old_dir,
> +				  struct dentry *old_dentry,
> +				  struct inode *new_dir,
> +				  struct dentry *new_dentry)
> +{
> +	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
> +	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
> +	unsigned long old_index = dentry2offset(old_dentry);
> +	unsigned long new_index = dentry2offset(new_dentry);
> +	int ret;
> +
> +	simple_offset_remove(old_ctx, old_dentry);
> +	simple_offset_remove(new_ctx, new_dentry);
> +
> +	ret = simple_offset_add(new_ctx, old_dentry);
> +	if (ret)
> +		goto out_restore;
> +
> +	ret = simple_offset_add(old_ctx, new_dentry);
> +	if (ret) {
> +		simple_offset_remove(new_ctx, old_dentry);
> +		goto out_restore;
> +	}
> +
> +	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
> +	if (ret) {
> +		simple_offset_remove(new_ctx, old_dentry);
> +		simple_offset_remove(old_ctx, new_dentry);
> +		goto out_restore;
> +	}
> +	return 0;
> +
> +out_restore:
> +	offset_set(old_dentry, old_index);
> +	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
> +	offset_set(new_dentry, new_index);
> +	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
> +	return ret;
> +}

Thanks for the update, looks great!

> +
> +/**
> + * simple_offset_destroy - Release offset map
> + * @octx: directory offset ctx that is about to be destroyed
> + *
> + * During fs teardown (eg. umount), a directory's offset map might still
> + * contain entries. xa_destroy() cleans out anything that remains.
> + */
> +void simple_offset_destroy(struct offset_ctx *octx)
> +{
> +	xa_destroy(&octx->xa);
> +}
> +
> +/**
> + * offset_dir_llseek - Advance the read position of a directory descriptor
> + * @file: an open directory whose position is to be updated
> + * @offset: a byte offset
> + * @whence: enumerator describing the starting position for this update
> + *
> + * SEEK_END, SEEK_DATA, and SEEK_HOLE are not supported for directories.
> + *
> + * Returns the updated read position if successful; otherwise a
> + * negative errno is returned and the read position remains unchanged.
> + */
> +static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	switch (whence) {
> +	case SEEK_CUR:
> +		offset += file->f_pos;
> +		fallthrough;
> +	case SEEK_SET:
> +		if (offset >= 0)
> +			break;
> +		fallthrough;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return vfs_setpos(file, offset, U32_MAX);
> +}
> +
> +static struct dentry *offset_find_next(struct xa_state *xas)
> +{
> +	struct dentry *child, *found = NULL;
> +
> +	rcu_read_lock();
> +	child = xas_next_entry(xas, U32_MAX);
> +	if (!child)
> +		goto out;
> +	spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> +	if (simple_positive(child))
> +		found = dget_dlock(child);
> +	spin_unlock(&child->d_lock);
> +out:
> +	rcu_read_unlock();
> +	return found;
> +}
> +
> +static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
> +{
> +	loff_t offset = dentry2offset(dentry);
> +	struct inode *inode = d_inode(dentry);
> +
> +	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
> +			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> +}
> +
> +static void offset_iterate_dir(struct dentry *dir, struct dir_context *ctx)
> +{
> +	struct inode *inode = d_inode(dir);
> +	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
> +	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> +	struct dentry *dentry;
> +
> +	while (true) {
> +		spin_lock(&dir->d_lock);
> +		dentry = offset_find_next(&xas);
> +		spin_unlock(&dir->d_lock);
> +		if (!dentry)
> +			break;
> +
> +		if (!offset_dir_emit(ctx, dentry)) {
> +			dput(dentry);
> +			break;
> +		}
> +
> +		dput(dentry);
> +		ctx->pos = xas.xa_index + 1;
> +	}
> +}
> +
> +/**
> + * offset_readdir - Emit entries starting at offset @ctx->pos
> + * @file: an open directory to iterate over
> + * @ctx: directory iteration context
> + *
> + * Caller must hold @file's i_rwsem to prevent insertion or removal of
> + * entries during this call.
> + *
> + * On entry, @ctx->pos contains an offset that represents the first entry
> + * to be read from the directory.
> + *
> + * The operation continues until there are no more entries to read, or
> + * until the ctx->actor indicates there is no more space in the caller's
> + * output buffer.
> + *
> + * On return, @ctx->pos contains an offset that will read the next entry
> + * in this directory when shmem_readdir() is called again with @ctx.
> + *
> + * Return values:
> + *   %0 - Complete
> + */
> +static int offset_readdir(struct file *file, struct dir_context *ctx)
> +{
> +	struct dentry *dir = file->f_path.dentry;
> +
> +	lockdep_assert_held(&d_inode(dir)->i_rwsem);
> +
> +	if (!dir_emit_dots(file, ctx))
> +		return 0;
> +
> +	offset_iterate_dir(dir, ctx);
> +	return 0;
> +}
> +
> +const struct file_operations simple_offset_dir_operations = {
> +	.llseek		= offset_dir_llseek,
> +	.iterate_shared	= offset_readdir,
> +	.read		= generic_read_dir,
> +	.fsync		= noop_fsync,
> +};
> +
>   static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
>   {
>   	struct dentry *child = NULL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 133f0640fb24..85de389e4eb8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1767,6 +1767,7 @@ struct dir_context {
>   
>   struct iov_iter;
>   struct io_uring_cmd;
> +struct offset_ctx;
>   
>   struct file_operations {
>   	struct module *owner;
> @@ -1854,6 +1855,7 @@ struct inode_operations {
>   	int (*fileattr_set)(struct mnt_idmap *idmap,
>   			    struct dentry *dentry, struct fileattr *fa);
>   	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
> +	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>   } ____cacheline_aligned;

Should this be documented in filesystems/vfs.rst and 
filesystems/locking.rst?


Thanks,
Bernd
