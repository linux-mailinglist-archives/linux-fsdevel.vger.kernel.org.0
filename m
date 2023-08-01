Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169F676BF7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 23:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHAVqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjHAVqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:46:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BD1FE8;
        Tue,  1 Aug 2023 14:46:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BE4621BB3;
        Tue,  1 Aug 2023 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690926401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXoRq/syaXRfKHZ4IrLuTP3yaz9naXR2FbQv5om0wQE=;
        b=Um2QKcQS+PnZaE4xorS6yIh7Yqan88xX+C4jCf0BrNCpa1Da3BPDhmzAVSKYuHO2sPIb6G
        TGEG43AfKVacmAiEvo8iNzk/j42LkULd6QtZ6Xsp1HhUQFcP2PIyqzm6jMCCC5EXjwk0oc
        92tvzp8bpzlivUYW3HFiAycl9uad+ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690926401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXoRq/syaXRfKHZ4IrLuTP3yaz9naXR2FbQv5om0wQE=;
        b=4JcYkDcBfLRyUEZLH7EemgohDZOI7ush+pXQJGbbMF5cZDJ27hTik0q2G6SCDHCKTaL55H
        /OG6ktAWbGNZObCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 692F5139BD;
        Tue,  1 Aug 2023 21:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KtPEGUF9yWSOLQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 01 Aug 2023 21:46:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A71E0A076B; Tue,  1 Aug 2023 23:46:40 +0200 (CEST)
Date:   Tue, 1 Aug 2023 23:46:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fanotify: Remove unused extern declaration
 fsnotify_get_conn_fsid()
Message-ID: <20230801214640.3hgms34jme6357cg@quack3>
References: <20230725135528.25996-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725135528.25996-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-07-23 21:55:28, YueHaibing wrote:
> This is never used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  include/linux/fsnotify_backend.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index d7d96c806bff..c0892d75ce33 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -760,9 +760,6 @@ extern void fsnotify_init_mark(struct fsnotify_mark *mark,
>  /* Find mark belonging to given group in the list of marks */
>  extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
>  						struct fsnotify_group *group);
> -/* Get cached fsid of filesystem containing object */
> -extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
> -				  __kernel_fsid_t *fsid);
>  /* attach the mark to the object */
>  extern int fsnotify_add_mark(struct fsnotify_mark *mark,
>  			     fsnotify_connp_t *connp, unsigned int obj_type,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
