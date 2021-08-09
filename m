Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25533E488D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhHIPSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:18:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51678 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhHIPSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:18:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 059912000C;
        Mon,  9 Aug 2021 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628522301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7LQfr+QS70hPlEzdXU5UNfASl0hm6MYjCpn/TJE3Bc=;
        b=R4vTQk1xooDBp9mWzIXzqhwLD4CIHqYAxE00uuxm9oLbJhzDcwNh6qmud4FPuBHxoWpTKs
        /uupXehqAF9P9KZgz9j+mFeb0T4LfBlR3IfbjX03lQLinlhL1epZQVP3/ha2pv01dqhbhx
        Q4tSeteWdiPwWSpi+KBAapfqQhD7tok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628522301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7LQfr+QS70hPlEzdXU5UNfASl0hm6MYjCpn/TJE3Bc=;
        b=dm/cqvOl95qsMUroycYmEaR6xavGIMxMc49ZUMkfh0XYG2GNLNuYmbuk7HNcvA2Psn69/P
        q05ZLbbK32ovACDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id EAE89A3B81;
        Mon,  9 Aug 2021 15:18:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D3AB21E3BFC; Mon,  9 Aug 2021 17:18:20 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:18:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/5] block: add a queue_has_disk helper
Message-ID: <20210809151820.GG30319@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141744.1203023-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-08-21 16:17:42, Christoph Hellwig wrote:
> Add a helper to check if a gendisk is associated with a request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/blkdev.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ac3642c88a4d..96f3d9617cd8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -664,6 +664,7 @@ extern void blk_clear_pm_only(struct request_queue *q);
>  	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
>  	(dir), (attrs))
>  
> +#define queue_has_disk(q)	((q)->kobj.parent != NULL)
>  #define queue_to_disk(q)	(dev_to_disk(kobj_to_dev((q)->kobj.parent)))
>  
>  static inline bool queue_is_mq(struct request_queue *q)
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
