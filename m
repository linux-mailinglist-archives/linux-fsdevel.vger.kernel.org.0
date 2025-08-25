Return-Path: <linux-fsdevel+bounces-59010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862BB33E72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494022049D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF72E7BD4;
	Mon, 25 Aug 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7lTvDmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548922D23B5;
	Mon, 25 Aug 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122808; cv=none; b=C6lTbCEjR3/qUG2BeR7IJ05QIJw99zY/+xo4lMvQjSCd1STeowjPGvd2VngIGor1j8GMQMcXxNOQKrZJdPnNFWpeprGtY6g72e63F9TwtCBwNbNpPDjGsf0V/dyh6dV6uQTenY6egxVTbe/I4ElkZThTlaMR1S+DPjVf1wLbAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122808; c=relaxed/simple;
	bh=0hhkEvAKCKYwPCsyx9LPA3uyUWRLJOb4k+WN+qfOLKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaB8N+bCMk9yFJfI5AvzXicI7UivhyK2Lk060mVCJSE/tvIfRXtmXa14n6h/lLy1QH0UAH5sYNEskMlXGDJqO5OJFrR6rHbAKrdVhQ4LNqI0ufJdwNNp0A+FyVoItg0EBa9C+c42F//YhutSaqnMV1xp9iTmEX7b8GdoeIoCNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7lTvDmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1600C4CEED;
	Mon, 25 Aug 2025 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122807;
	bh=0hhkEvAKCKYwPCsyx9LPA3uyUWRLJOb4k+WN+qfOLKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7lTvDmvkLY5qx5OKllmYcuRYoUQayp0NeBdl1wnI3F21YYVJsxgN/UCAr2kEReYd
	 LsyovDDS0WTfZPFQj1gnvR+Sa3x3+qni3tS6Ot8zhy7hvVr5a8y/EcnXimaXSO5MsN
	 Rw9IDwMbLsGQLkd42O8utqwH2R4hBtcfY+Bnmk3MY6p0jLsaPSbv/02HRwRunARdqw
	 sf9XLBcA62qVs2asfUhGkSmTsLo6EfuQO7O2aq5QI2Vj7OWVeyoRPzJhuXv+4G5rDc
	 tyHxrlP96q2op4V2fYTNSZxt/FxQ+cvxPnJknzTzAbFy/12YyEkVNtqN6BsHUFhN3M
	 e+eChJI+zzPcA==
Date: Mon, 25 Aug 2025 13:53:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 49/50] fs: remove I_FREEING|I_WILL_FREE
Message-ID: <20250825-zellteilung-investieren-90b030b10963@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <986e757c6b725231500556c68967588b23081e79.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <986e757c6b725231500556c68967588b23081e79.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:19:00PM -0400, Josef Bacik wrote:
> Now that we're using the i_count reference count as the ultimate arbiter
> of whether or not an inode is life we can remove the I_FREEING and
> I_WILL_FREE flags.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Very nice.

>  fs/inode.c                       |  8 ++------
>  include/linux/fs.h               | 32 +++++++++++---------------------
>  include/trace/events/writeback.h |  2 --
>  3 files changed, 13 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f715504778d2..1bb528405b3d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -878,7 +878,7 @@ void clear_inode(struct inode *inode)
>  	BUG_ON(inode->i_state & I_CLEAR);
>  	BUG_ON(!list_empty(&inode->i_wb_list));
>  	/* don't need i_lock here, no concurrent mods to i_state */
> -	inode->i_state = I_FREEING | I_CLEAR;
> +	inode->i_state = I_CLEAR;
>  }
>  EXPORT_SYMBOL(clear_inode);
>  
> @@ -942,7 +942,7 @@ static void evict(struct inode *inode)
>  	 * This also means we don't need any fences for the call below.
>  	 */
>  	inode_wake_up_bit(inode, __I_NEW);
> -	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> +	BUG_ON(inode->i_state != I_CLEAR);
>  }
>  
>  static void iput_evict(struct inode *inode);
> @@ -1975,7 +1975,6 @@ static void iput_final(struct inode *inode, bool drop)
>  
>  	state = inode->i_state;
>  	if (!drop) {
> -		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>  		spin_unlock(&inode->i_lock);
>  
>  		write_inode_now(inode, 1);
> @@ -1983,10 +1982,7 @@ static void iput_final(struct inode *inode, bool drop)
>  		spin_lock(&inode->i_lock);
>  		state = inode->i_state;
>  		WARN_ON(state & I_NEW);
> -		state &= ~I_WILL_FREE;
>  	}
> -
> -	WRITE_ONCE(inode->i_state, state | I_FREEING);
>  	spin_unlock(&inode->i_lock);
>  
>  	evict(inode);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9d9acbea6433..0599faef0d6a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -672,8 +672,8 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
>   *
>   * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
> - * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
> - * various stages of removing an inode.
> + * until that flag is cleared.  I_CLEAR is set when the inode is clean and ready
> + * to be freed.
>   *
>   * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
>   *
> @@ -697,24 +697,18 @@ is_uncached_acl(struct posix_acl *acl)
>   *			New inodes set I_NEW.  If two processes both create
>   *			the same inode, one of them will release its inode and
>   *			wait for I_NEW to be released before returning.
> - *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
> - *			also cause waiting on I_NEW, without I_NEW actually
> - *			being set.  find_inode() uses this to prevent returning
> + *			Inodes with an i_count == 0 or I_CLEAR state can also
> + *			cause waiting on I_NEW, without I_NEW actually being
> + *			set.  find_inode() uses this to prevent returning
>   *			nearly-dead inodes.
> - * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
> - *			is zero.  I_FREEING must be set when I_WILL_FREE is
> - *			cleared.
> - * I_FREEING		Set when inode is about to be freed but still has dirty
> - *			pages or buffers attached or the inode itself is still
> - *			dirty.
>   * I_CLEAR		Added by clear_inode().  In this state the inode is
> - *			clean and can be destroyed.  Inode keeps I_FREEING.
> + *			clean and can be destroyed.
>   *
> - *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
> - *			prohibited for many purposes.  iget() must wait for
> - *			the inode to be completely released, then create it
> - *			anew.  Other functions will just ignore such inodes,
> - *			if appropriate.  I_NEW is used for waiting.
> + *			Inodes that have i_count == 0 or I_CLEAR are prohibited
> + *			for many purposes.  iget() must wait for the inode to be
> + *			completely released, then create it anew.  Other
> + *			functions will just ignore such inodes, if appropriate.
> + *			I_NEW is used for waiting.
>   *
>   * I_SYNC		Writeback of inode is running. The bit is set during
>   *			data writeback, and cleared with a wakeup on the bit
> @@ -752,8 +746,6 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
>   *			and thus is on the s_cached_inode_lru list.
>   *
> - * Q: What is the difference between I_WILL_FREE and I_FREEING?
> - *
>   * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
>   * upon. There's one free address left.
>   */
> @@ -776,8 +768,6 @@ enum inode_state_bits {
>  	INODE_BIT(I_DIRTY_SYNC),
>  	INODE_BIT(I_DIRTY_DATASYNC),
>  	INODE_BIT(I_DIRTY_PAGES),
> -	INODE_BIT(I_WILL_FREE),
> -	INODE_BIT(I_FREEING),
>  	INODE_BIT(I_CLEAR),
>  	INODE_BIT(I_REFERENCED),
>  	INODE_BIT(I_LINKABLE),
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 6949329c744a..58ee61f3d91d 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -15,8 +15,6 @@
>  		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
>  		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
>  		{I_NEW,			"I_NEW"},		\
> -		{I_WILL_FREE,		"I_WILL_FREE"},		\
> -		{I_FREEING,		"I_FREEING"},		\
>  		{I_CLEAR,		"I_CLEAR"},		\
>  		{I_SYNC,		"I_SYNC"},		\
>  		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
> -- 
> 2.49.0
> 

