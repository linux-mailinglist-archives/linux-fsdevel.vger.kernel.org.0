Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00435E9DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiIZJbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiIZJah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:30:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1B11838
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 02:29:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED8E21FD3C;
        Mon, 26 Sep 2022 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664184587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJJj4aZYrIuFfiolyhdZ4i6Rbsf+b3NcBTN6nhB25mk=;
        b=O2xy5GgkjnOBktiYXsatOBkkGe40PBdPHrdbet04Xxkg1XPVx4zlDA7Q5gKnyeigqhRll6
        XIV/PzLexmHffcC7sOKGzOe9dQ5hfDCc5/gmo6NpnDNQ3iQhSaBebrWRtLBRoCf2Q0KnhT
        mi6GE2qf81YHiAXjZEF4lLvKKR0sLWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664184587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJJj4aZYrIuFfiolyhdZ4i6Rbsf+b3NcBTN6nhB25mk=;
        b=lcCe6IO/cAhxUb46QEnzkJ2K5GXiYJYPojWLD/+XggKUjqubmj9s+kz+Wk/7ZfJPRx8ufE
        sQusQXQEUwOli9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E183E139BD;
        Mon, 26 Sep 2022 09:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hJoJNwtxMWNTdwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 09:29:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5A4C4A0685; Mon, 26 Sep 2022 11:29:47 +0200 (CEST)
Date:   Mon, 26 Sep 2022 11:29:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     jack@suse.cz, amir73il@gmail.com, repnop@google.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/notify: ftrace: Remove obsoleted
 fanotify_event_has_path()
Message-ID: <20220926092947.xou74xpgmu2t6nqb@quack3>
References: <20220926023018.1505270-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926023018.1505270-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-09-22 10:30:18, Gaosheng Cui wrote:
> All uses of fanotify_event_has_path() have
> been removed since commit 9c61f3b560f5 ("fanotify: break up
> fanotify_alloc_event()"), now it is useless, so remove it.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Thanks. Patch merged to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index bf6d4d38afa0..57f51a9a3015 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -452,12 +452,6 @@ static inline bool fanotify_is_error_event(u32 mask)
>  	return mask & FAN_FS_ERROR;
>  }
>  
> -static inline bool fanotify_event_has_path(struct fanotify_event *event)
> -{
> -	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
> -		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
> -}
> -
>  static inline const struct path *fanotify_event_path(struct fanotify_event *event)
>  {
>  	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
