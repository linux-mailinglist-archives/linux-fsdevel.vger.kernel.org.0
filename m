Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C9D64A151
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 14:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiLLNif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 08:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiLLNhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:37:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2713F5E;
        Mon, 12 Dec 2022 05:37:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0AE034400;
        Mon, 12 Dec 2022 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670852240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKypSIdcoy898mpfc6Pyz2EaNFcY/Huodk8xnbTMnYQ=;
        b=iv4WXAmUUsF9MEuqV9UTmGO3gDR1uLGqo14V9kGfMr8ercXgZk278W8LX74/t815E/JazT
        wHZ4HABWaX4BECQkKoAwVxNvzAKeIBTMwEDSnF3bkZjzZb97i4iFyBxyogPBWNpzWjTkap
        g/gRv0ofCgoJaTpxQqq883RAT3P9FPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670852240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKypSIdcoy898mpfc6Pyz2EaNFcY/Huodk8xnbTMnYQ=;
        b=9QLw9/yLYpmbeyE3E/1UeSFFVSzcjUfyfuE03TQ30GvyyeTdAB0cHSD5NJiYyjPTRX3Viy
        mrnYZllBvrUAvSBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D34F213456;
        Mon, 12 Dec 2022 13:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6eaLM5Aul2MYJgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Dec 2022 13:37:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 57449A0728; Mon, 12 Dec 2022 14:37:20 +0100 (CET)
Date:   Mon, 12 Dec 2022 14:37:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
Message-ID: <20221212133720.xvnmz4nsfwknwqr4@quack3>
References: <20221210101042.2012931-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210101042.2012931-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 10-12-22 18:10:42, Miaohe Lin wrote:
> EXPIRE_DIRTY_ATIME is not used anymore. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Sure. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 9958d4020771..6bad645ac36f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1345,8 +1345,6 @@ static bool inode_dirtied_after(struct inode *inode, unsigned long t)
>  	return ret;
>  }
>  
> -#define EXPIRE_DIRTY_ATIME 0x0001
> -
>  /*
>   * Move expired (dirtied before dirtied_before) dirty inodes from
>   * @delaying_queue to @dispatch_queue.
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
