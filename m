Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F23A5F43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhFNJoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 05:44:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhFNJoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:44:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB7A02197F;
        Mon, 14 Jun 2021 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623663728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5VF4wx4G0e9qQliL3bw5l2XjtGudNuzSi9PypR4ch/k=;
        b=qS3qeTEwHHk2ClQI9IqN2xnn23QuCeY/p7Y7u5V1ouVelgJinu3EAnm4YeqHrxDzC1P6ib
        RxGdWArQt3sesHgrDUUwsjg+3Ql3tk0FlrZNFQHwKld/Y09ptjpKw0Uf3XHACCkEWrokJj
        ozH5hmnKGBhimQ4ACT/udVMkAsLW0Ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623663728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5VF4wx4G0e9qQliL3bw5l2XjtGudNuzSi9PypR4ch/k=;
        b=PbBkgy11v0GhAnNa/KM/Lnm81zc2i/7dLHHtMm8d8We9FY1/WjGwOC8LyXDiFuOWSKvfvr
        /LGPMiQ08+jcdqCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B57CFA3B93;
        Mon, 14 Jun 2021 09:42:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E96891F2B82; Mon, 14 Jun 2021 11:42:07 +0200 (CEST)
Date:   Mon, 14 Jun 2021 11:42:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: unexport __set_page_dirty
Message-ID: <20210614094207.GB26615@quack2.suse.cz>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-06-21 08:15:10, Christoph Hellwig wrote:
> __set_page_dirty is only used by built-in code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ea48c01fb76b..3d18831c7ad8 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -611,7 +611,6 @@ void __set_page_dirty(struct page *page, struct address_space *mapping,
>  	}
>  	xa_unlock_irqrestore(&mapping->i_pages, flags);
>  }
> -EXPORT_SYMBOL_GPL(__set_page_dirty);
>  
>  /*
>   * Add a page to the dirty page list.
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
