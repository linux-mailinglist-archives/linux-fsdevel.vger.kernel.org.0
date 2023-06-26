Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228F73E064
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjFZNSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 09:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFZNSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:18:48 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C70B9
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 06:18:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BC8025C0167;
        Mon, 26 Jun 2023 09:18:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Jun 2023 09:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687785523; x=1687871923; bh=gZrijpOdvanWIKt5AZyAe9P8aRprxVz3zI1
        89BLiGus=; b=SGk3RVq7fmAH06kq0usDUDSQPMffXg2Xf/oYLNqLhXQaGLGTfWC
        wR03jQUgEr6ZYR8UvwOiMiAu9pXRqXb+4SbAveUM7KBH7mkfS/rN5IiBp5xNZz5T
        6vHn5RV5mdm/xCji2qhpXmskTKNVxMeoqGL/Jx7OlFOfd3HhZLt8NyRCvGjsIyI/
        6Muw/5c8Vc03hujPN5r1o1C97jehQr6Gs70gPpFwoEWDMhpAGILLY2+iBQSCHHVj
        7cXbmZxkIEFap2RoxipvYIAI/RuGWIdufqwWR3nCc4+BXGcS9qUgvx7g1xbiIRvh
        5tnjOQDy/mH1LVkZRscWoYtjCnS0X1uN2Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687785523; x=1687871923; bh=gZrijpOdvanWIKt5AZyAe9P8aRprxVz3zI1
        89BLiGus=; b=dqfuaZ6mMvTFXSqW9u5C+e1VJCYVfi4zBXNq/bEw0x17C2Hbirz
        1bowEWBFvXZh6luErnWq11LZsWzlgx3aw3SwPR4z9G7vohagfFpZ5tJok7QB47ge
        kHpVY+rlO4Mq3MVrSk795RSAAsVffog1xgqjGEdgXco1tK1EpkKLPyWe7kbQqHe+
        lNRRcdWb8gjjlqx+ogotKYlptWOWA9geXFCw49E7qcoYPqJoCT5qU7MBk1bjJtbE
        dGLNLDW0c5wB5e2JFg9aH6Sr3D6qDxLopXTlWCYFv8MbI7uUUhroOCXzszZZePs/
        bTgGu+uzvTUiVhqfP8/Irtf4krafuboPfig==
X-ME-Sender: <xms:M5CZZFjnmmNxBG12OK9Dmb8Cq08Q2AKjdW0k7eqTx4ZZ8KPgIOnbWg>
    <xme:M5CZZKCs43EV9bdSO1hW2Dkwt1qd2PDUg0ASvuRMzkNERLjoWLnBC3tA4kbZZk3fM
    bbgfY0scjv3dPsK>
X-ME-Received: <xmr:M5CZZFGY6OU7vqIfiUiwEtfBiCAsr63Usp_1JUrOPoylUqBkyQZAUn67p9N8ggwazg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:M5CZZKQMccqyhouvuaoklHENFvP6cKGqJzVGvZaBErl21UEJlDLtTw>
    <xmx:M5CZZCx-8d4W7hzgjTLnpHzdzmrz7dZqlqOOc6qFjdwimaOzDCkydw>
    <xmx:M5CZZA7dpN36mP-IAIFkpea9kE3VZ7lDoqdG94Deriv4QZIG8X2qZw>
    <xmx:M5CZZJnScP8NQrh1rOQNAcNkBQrgDLD4EWQOHchDvUYtCqgOCLX8yQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 09:18:42 -0400 (EDT)
Message-ID: <f6191d0e-ede3-620b-ae96-311b001e1ece@fastmail.fm>
Date:   Mon, 26 Jun 2023 15:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] shmem: stable directory offsets
To:     Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
 <168605707262.32244.4794425063054676856.stgit@manet.1015granger.net>
Content-Language: en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <168605707262.32244.4794425063054676856.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/6/23 15:11, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The current cursor-based directory offset mechanism doesn't work
> when a tmpfs filesystem is exported via NFS. This is because NFS
> clients do not open directories. Each server-side READDIR operation
> has to open the directory, read it, then close it. The cursor state
> for that directory, being associated strictly with the opened
> struct file, is thus discarded after each NFS READDIR operation.
> 
> Directory offsets are cached not only by NFS clients, but also by
> user space libraries on those clients. Essentially there is no way
> to invalidate those caches when directory offsets have changed on
> an NFS server after the offset-to-dentry mapping changes. Thus the
> whole application stack depends on unchanging directory offsets.
> 
> The solution we've come up with is to make the directory offset for
> each file in a tmpfs filesystem stable for the life of the directory
> entry it represents.
> 
> shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
> directory offset (an loff_t integer) to the memory address of a
> struct dentry.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   mm/shmem.c |   39 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 721f9fd064aa..fd9571056181 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2410,7 +2410,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
>   			/* Some things misbehave if size == 0 on a directory */
>   			inode->i_size = 2 * BOGO_DIRENT_SIZE;
>   			inode->i_op = &shmem_dir_inode_operations;
> -			inode->i_fop = &simple_dir_operations;
> +			inode->i_fop = &stable_dir_operations;
> +			stable_offset_init(inode);
>   			break;
>   		case S_IFLNK:
>   			/*
> @@ -2950,6 +2951,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   		if (error && error != -EOPNOTSUPP)
>   			goto out_iput;
>   
> +		error = stable_offset_add(dir, dentry);
> +		if (error)
> +			goto out_iput;
> +
>   		error = 0;

This line can be removed?

>   		dir->i_size += BOGO_DIRENT_SIZE;
>   		dir->i_ctime = dir->i_mtime = current_time(dir);
> @@ -3027,6 +3032,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>   			goto out;
>   	}
>   
> +	ret = stable_offset_add(dir, dentry);
> +	if (ret)
> +		goto out;
> +

I think this should call shmem_free_inode() before goto out - reverse 
what shmem_reserve_inode() has done.

>   	dir->i_size += BOGO_DIRENT_SIZE;
>   	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>   	inode_inc_iversion(dir);
> @@ -3045,6 +3054,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>   	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>   		shmem_free_inode(inode->i_sb);
>   
> +	stable_offset_remove(dir, dentry);
> +
>   	dir->i_size -= BOGO_DIRENT_SIZE;
>   	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>   	inode_inc_iversion(dir);
> @@ -3103,24 +3114,37 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>   {
>   	struct inode *inode = d_inode(old_dentry);
>   	int they_are_dirs = S_ISDIR(inode->i_mode);
> +	int error;
>   
>   	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>   		return -EINVAL;
>   
> -	if (flags & RENAME_EXCHANGE)
> +	if (flags & RENAME_EXCHANGE) {
> +		stable_offset_remove(old_dir, old_dentry);
> +		stable_offset_remove(new_dir, new_dentry);
> +		error = stable_offset_add(new_dir, old_dentry);
> +		if (error)
> +			return error;
> +		error = stable_offset_add(old_dir, new_dentry);
> +		if (error)
> +			return error;
>   		return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
> +	}

Hmm, error handling issues? Everything needs to be reversed when any of 
the operations fails?

>   
>   	if (!simple_empty(new_dentry))
>   		return -ENOTEMPTY;
>   
>   	if (flags & RENAME_WHITEOUT) {
> -		int error;
> -
>   		error = shmem_whiteout(idmap, old_dir, old_dentry);
>   		if (error)
>   			return error;
>   	}
>   
> +	stable_offset_remove(old_dir, old_dentry);
> +	error = stable_offset_add(new_dir, old_dentry);
> +	if (error)
> +		return error;
> +
>   	if (d_really_is_positive(new_dentry)) {
>   		(void) shmem_unlink(new_dir, new_dentry);
>   		if (they_are_dirs) {
> @@ -3185,6 +3209,11 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   		folio_unlock(folio);
>   		folio_put(folio);
>   	}
> +
> +	error = stable_offset_add(dir, dentry);
> +	if (error)
> +		goto out_iput;
> +

Error handling, there is a kmemdup() above which needs to be freed? I'm 
not sure about folio, automatically released with the inode?

>   	dir->i_size += BOGO_DIRENT_SIZE;
>   	dir->i_ctime = dir->i_mtime = current_time(dir);
>   	inode_inc_iversion(dir);
> @@ -3920,6 +3949,8 @@ static void shmem_destroy_inode(struct inode *inode)
>   {
>   	if (S_ISREG(inode->i_mode))
>   		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
> +	if (S_ISDIR(inode->i_mode))
> +		stable_offset_destroy(inode);
>   }
>   
>   static void shmem_init_inode(void *foo)
> 
> 

Thanks,
Bernd
