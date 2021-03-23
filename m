Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC8346693
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 18:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCWRnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCWRmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:42:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2675CC061574;
        Tue, 23 Mar 2021 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=prj80dSJB1H4uGiQ4K++/2VJu4iZ1LVIZ5jG7WZGO5A=; b=qjfMynPHYj7TPdw3idmm+KGSdH
        40eHVfHmrVLtCk52AeicasHl7pXVsC7L1AMArv1fTUeiLZEnTKRvyS1I7LQ23jNWsYhyA8xVnrA0H
        bW/06rR7J9xWGPVmQz1rgMlLeRqmCgLtG07MLFdDIUUcCKnDjQwSZzQQPChEs4g4VjimeWF7QcVAV
        3Fp+biFVh+0TK8PEsCa/5PnioZsZEX73/Hs34lARYPSTD+wq92GMHbA7ppFobRCH3mBB6ITokm5sA
        zLKKHN96LGth7u53hn/cPgA1+G+KgMYOGuzo3P2035Ca5BMzXWqrb5nqabU0uuH01O4vTNOB00JvW
        rvg1sdKQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOl2n-00AM9Q-Mi; Tue, 23 Mar 2021 17:42:20 +0000
Subject: Re: [PATCH v2] fs/dcache: fix typos and sentence disorder
To:     Xiaofeng Cao <cxfcosmos@gmail.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
References: <20210323065245.15083-1-caoxiaofeng@yulong.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <36a2d11d-8413-f4a7-9f69-fe513d26c4aa@infradead.org>
Date:   Tue, 23 Mar 2021 10:42:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323065245.15083-1-caoxiaofeng@yulong.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/21 11:52 PM, Xiaofeng Cao wrote:
> change 'sould' to 'should'
> change 'colocated' to 'co-located'
> change 'talke' to 'take'
> reorganize sentence
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2:change 'colocated' to 'co-located' instead of 'collocated'
>  fs/dcache.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 7d24ff7eb206..c23834334314 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -741,7 +741,7 @@ static inline bool fast_dput(struct dentry *dentry)
>  	unsigned int d_flags;
>  
>  	/*
> -	 * If we have a d_op->d_delete() operation, we sould not
> +	 * If we have a d_op->d_delete() operation, we should not
>  	 * let the dentry count go to zero, so use "put_or_lock".
>  	 */
>  	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE))
> @@ -1053,7 +1053,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
>  	struct dentry *de = NULL;
>  
>  	spin_lock(&inode->i_lock);
> -	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
> +	// ->i_dentry and ->i_rcu are co-located, but the latter won't be
>  	// used without having I_FREEING set, which means no aliases left
>  	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
>  		if (S_ISDIR(inode->i_mode)) {
> @@ -1297,7 +1297,7 @@ void shrink_dcache_sb(struct super_block *sb)
>  EXPORT_SYMBOL(shrink_dcache_sb);
>  
>  /**
> - * enum d_walk_ret - action to talke during tree walk
> + * enum d_walk_ret - action to take during tree walk
>   * @D_WALK_CONTINUE:	contrinue walk
>   * @D_WALK_QUIT:	quit walk
>   * @D_WALK_NORETRY:	quit when retry is needed
> @@ -2156,8 +2156,8 @@ EXPORT_SYMBOL(d_obtain_alias);
>   *
>   * On successful return, the reference to the inode has been transferred
>   * to the dentry.  In case of an error the reference on the inode is
> - * released.  A %NULL or IS_ERR inode may be passed in and will be the
> - * error will be propagate to the return value, with a %NULL @inode
> + * released.  A %NULL or IS_ERR inode may be passed in and the error will
> + * be propagated to the return value, with a %NULL @inode
>   * replaced by ERR_PTR(-ESTALE).
>   */
>  struct dentry *d_obtain_root(struct inode *inode)
> 


-- 
~Randy

