Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58725514BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiFTJtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiFTJtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:49:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A136385;
        Mon, 20 Jun 2022 02:49:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 762C021B84;
        Mon, 20 Jun 2022 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655718551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgfjp60L1bs7Br5fWh3tJQLPmYj3G4xjjz2aFNrlkoU=;
        b=U63xSbF9iLinG/iLWbFKBIx7VWeBHPZ7s85fGYfdhqRGhDIubP2CXuzGZ1I7nJarE1rLyh
        SKUmRE5AKhdw7lTPHsT7MAlU+PQdpGNmB86AW63PbTx82rcE8/xgi8SyZWyXQfGFUp07ot
        QrirbnwByg2T4TWyc4mUoQYlQ4yQJlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655718551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgfjp60L1bs7Br5fWh3tJQLPmYj3G4xjjz2aFNrlkoU=;
        b=BFX7lmCvCLuzCUv8K7elDrz+MACcC0nswWXi8BbaxmQoeKwQwblMPmIUr/FPn4Khrzgeb+
        6E6YAjeMbdHuTxCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 585092C142;
        Mon, 20 Jun 2022 09:49:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC1AFA0636; Mon, 20 Jun 2022 11:49:09 +0200 (CEST)
Date:   Mon, 20 Jun 2022 11:49:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2 2/4] fs/ntfs: Drop useless return value of submit_bh
 from ntfs_submit_bh_for_read
Message-ID: <20220620094909.rksiex5yv3xnrsf4@quack3.lan>
References: <cover.1655715329.git.ritesh.list@gmail.com>
 <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 14:34:35, Ritesh Harjani wrote:
> submit_bh always returns 0. This patch drops the useless return value of
> submit_bh from ntfs_submit_bh_for_read(). Once all of submit_bh callers are
> cleaned up, we can make it's return type as void.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ntfs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index a8abe2296514..2389bfa654a2 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -532,12 +532,12 @@ static inline int __ntfs_grab_cache_pages(struct address_space *mapping,
>  	goto out;
>  }
> 
> -static inline int ntfs_submit_bh_for_read(struct buffer_head *bh)
> +static inline void ntfs_submit_bh_for_read(struct buffer_head *bh)
>  {
>  	lock_buffer(bh);
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_read_sync;
> -	return submit_bh(REQ_OP_READ, 0, bh);
> +	submit_bh(REQ_OP_READ, 0, bh);
>  }
> 
>  /**
> --
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
