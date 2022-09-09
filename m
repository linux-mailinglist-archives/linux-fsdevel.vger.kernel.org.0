Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380A5B3435
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiIIJki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiIIJke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:40:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE6B533C;
        Fri,  9 Sep 2022 02:40:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9C11F8A6;
        Fri,  9 Sep 2022 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662716427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NzTsWb7AkhKdCbXpx+cD91GgK4NEaTd8ZxVSs4tEis=;
        b=2SGa8HQOukQZYio7zu/9Tb+ApVHmmUeBlyeaOFe5NqTRBrhyqP/72elQqDBFV3KgjiEwE7
        ZFFRxzVq3e5RHZJMjTu6ylCFfyqSklHqgoVJs63JrOu5yTf07pfO4RjtFYvRD/dURF1JdE
        PR5LattLuO1K0LoAZas6Z94WYiKssUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662716427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NzTsWb7AkhKdCbXpx+cD91GgK4NEaTd8ZxVSs4tEis=;
        b=BDyzX9eTfwC7PnS53Nml/LZKewOISHJBCXFTVpQWfuqeyOSpPXD2Oof1gJpnTqwOQXKsLO
        FO2/T62GerjRLRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DEBE13A93;
        Fri,  9 Sep 2022 09:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3HDNGgsKG2PVZQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 09 Sep 2022 09:40:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F41E8A0684; Fri,  9 Sep 2022 11:40:26 +0200 (CEST)
Date:   Fri, 9 Sep 2022 11:40:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: remove unused declaration
Message-ID: <20220909094026.zh2ugriphnq3qgfj@quack3>
References: <20220909033828.993889-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909033828.993889-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 09-09-22 11:38:28, Gaosheng Cui wrote:
> fsnotify_alloc_event_holder() and fsnotify_destroy_event_holder()
> has been removed since commit 7053aee26a35 ("fsnotify: do not share
> events between notification groups"), so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fsnotify.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index 87d8a50ee803..fde74eb333cc 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -76,10 +76,6 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>   */
>  extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
>  
> -/* allocate and destroy and event holder to attach events to notification/access queues */
> -extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
> -extern void fsnotify_destroy_event_holder(struct fsnotify_event_holder *holder);
> -
>  extern struct kmem_cache *fsnotify_mark_connector_cachep;
>  
>  #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
