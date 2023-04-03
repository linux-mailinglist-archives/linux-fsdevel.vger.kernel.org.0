Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7CA6D4D40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjDCQKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDCQKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:10:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28482D1;
        Mon,  3 Apr 2023 09:10:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D547121ED0;
        Mon,  3 Apr 2023 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680538243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGPfSRWoGSI5fAPyYyzDsXwKPDOG1dsimMuY8Qfc4g0=;
        b=L7bZBbv+W6HfeLim3yfUjNHW01j9/SIIBfNVR04wJqM33iPUcmbg6ebLUe8kkXMTc65khp
        3IaivgE/Er8L7xX4jJ3LvlpT65CirVnK7FRZENHiOPhHe8lFo4GRoNOZqD5s7FANDQNjrQ
        YFbsVwG67dMxOa1CDsW88PwRqvt6Av0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680538243;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGPfSRWoGSI5fAPyYyzDsXwKPDOG1dsimMuY8Qfc4g0=;
        b=G0ospTt3eSGE7rc+rl9ghc7DxVIPQ968VED0M1W6bgoFt5ZKchg1Jp9l8iFpLJ4uD9BbW7
        Q6mEs4I2YimtoTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3DCE13416;
        Mon,  3 Apr 2023 16:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kA3BL4P6KmTTVQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Apr 2023 16:10:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 558EBA0732; Mon,  3 Apr 2023 18:10:43 +0200 (CEST)
Date:   Mon, 3 Apr 2023 18:10:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Message-ID: <20230403161043.tecfvgmhacs4j3qp@quack3>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-03-23 10:32:59, Jiapeng Chong wrote:
> Variable 'err' set but not used.
> 
> fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4589
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

I don't think the patch is quite correct (Christian, please drop it if I'm
correct). See below:

> diff --git a/fs/buffer.c b/fs/buffer.c
> index d759b105c1e7..b3eb905f87d6 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2580,7 +2580,7 @@ int block_truncate_page(struct address_space *mapping,
>  	struct inode *inode = mapping->host;
>  	struct page *page;
>  	struct buffer_head *bh;
> -	int err;
> +	int err = 0;
>  
>  	blocksize = i_blocksize(inode);
>  	length = offset & (blocksize - 1);
> @@ -2593,9 +2593,8 @@ int block_truncate_page(struct address_space *mapping,
>  	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
>  	
>  	page = grab_cache_page(mapping, index);
> -	err = -ENOMEM;
>  	if (!page)
> -		goto out;
> +		return -ENOMEM;
>  
>  	if (!page_has_buffers(page))
>  		create_empty_buffers(page, blocksize, 0);
> @@ -2609,7 +2608,6 @@ int block_truncate_page(struct address_space *mapping,
>  		pos += blocksize;
>  	}
>  
> -	err = 0;
>  	if (!buffer_mapped(bh)) {
>  		WARN_ON(bh->b_size != blocksize);
>  		err = get_block(inode, iblock, bh, 0);
> @@ -2633,12 +2631,11 @@ int block_truncate_page(struct address_space *mapping,
>  
>  	zero_user(page, offset, length);
>  	mark_buffer_dirty(bh);
> -	err = 0;

There is:

        if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh))
                err = -EIO;

above this assignment. So now we'll be returning -EIO if
block_truncate_page() needs to read the block AFAICT. Did this pass fstests
with some filesystem exercising this code (ext2 driver comes to mind)?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
