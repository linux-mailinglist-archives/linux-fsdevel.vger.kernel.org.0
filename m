Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB73D7BFB9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjJJMgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjJJMf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:35:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01759D
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 05:35:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 722141F8B0;
        Tue, 10 Oct 2023 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696941353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RRtP+vYvF8BJUJh1g9jd2MU5oy2SZqDzSldc2oYFIo=;
        b=BUF+jy8fuOxDsPEfP4VfSsc9bj9MXbAZt2yz9Wu/fXXaMssOZEqdhJOWw/SY8iexuPxSzg
        4KuAHuB7DJdlig1hWzDth3A6j7vny4I5Z9vSCaPlyhc1PxVCBqUqjKY+Xks7MiD0m4fUVJ
        OgjP+eyHDmAqJUcGTsB0txds5EOVwJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696941353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RRtP+vYvF8BJUJh1g9jd2MU5oy2SZqDzSldc2oYFIo=;
        b=qB/oHScGEjdKcpOFJsVUgHApmAZiD/GC9kf+StEU5dp701UzyvwjQb1RBKBHEBy9707BOm
        qtKY9PS7Y0duAEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62F341348E;
        Tue, 10 Oct 2023 12:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZjX9FylFJWVxUQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 10 Oct 2023 12:35:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E859FA061C; Tue, 10 Oct 2023 14:35:52 +0200 (CEST)
Date:   Tue, 10 Oct 2023 14:35:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: delete useless parenthesis in
 FANOTIFY_INLINE_FH macro
Message-ID: <20231010123552.m27vp23k4lob47lr@quack3>
References: <633c251a-b548-4428-9e91-1cf8147d8c55@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <633c251a-b548-4428-9e91-1cf8147d8c55@p183>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-10-23 14:44:35, Alexey Dobriyan wrote:
> Parenthesis around identifier name in declaration are useless.
> This is just "put every macro argument inside parenthesis" practice.
> 
> Now "size" must be constant expression, but using comma expression in
> constant expression is useless too, therefore [] will guard "size"
> expression just as well as ().
> 
> Also g++ is somewhat upset about these:
> 
> 	fs/notify/fanotify/fanotify.h:278:28: warning: unnecessary parentheses in declaration of ‘object_fh’ [-Wparentheses]
> 	  278 |         struct fanotify_fh (name);
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Yeah, ok. Added to my tree. Thanks!

								Honza

> ---
> 
>  fs/notify/fanotify/fanotify.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -275,9 +275,9 @@ static inline void fanotify_init_event(struct fanotify_event *event,
>  
>  #define FANOTIFY_INLINE_FH(name, size)					\
>  struct {								\
> -	struct fanotify_fh (name);					\
> +	struct fanotify_fh name;					\
>  	/* Space for object_fh.buf[] - access with fanotify_fh_buf() */	\
> -	unsigned char _inline_fh_buf[(size)];				\
> +	unsigned char _inline_fh_buf[size];				\
>  }
>  
>  struct fanotify_fid_event {
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
