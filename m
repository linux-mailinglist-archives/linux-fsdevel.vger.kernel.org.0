Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9986969AE3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBQOlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBQOlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:41:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199E6E649;
        Fri, 17 Feb 2023 06:41:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8CF301FDEA;
        Fri, 17 Feb 2023 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676644903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QRvjd8euydYgzZgxORS8x28oEgezB0PYJxS+PHJWU0M=;
        b=EiJt68fDXZfLDVFpaOiLTEgEwh4kRiHRtnJGtSPobKxnUb8FL8p7lIp0lCuM12u2mXRK7k
        Z7YLLZay9NuuxmEX5xcEyS4Hx7AxQDP3upOiYgA1tbxZxFL9Csr6d7e3kFsP7wfdp/Agq0
        l3+LmiFUUFfMkwbA0c/laeZTtzDFMz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676644903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QRvjd8euydYgzZgxORS8x28oEgezB0PYJxS+PHJWU0M=;
        b=tBF5rFFcCF9FOw7Zkkp1wWS7L9hrzS+C0HWPet3obX/ahRHqIA3xi7yT2E0qXSL0bfaAnB
        JyM6nO83JnWM0FDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80F9213274;
        Fri, 17 Feb 2023 14:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RGhvHyeS72NIJAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 14:41:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 16915A06E1; Fri, 17 Feb 2023 15:41:43 +0100 (CET)
Date:   Fri, 17 Feb 2023 15:41:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Li zeming <zeming@nfschina.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs-writeback: remove unnecessary =?utf-8?B?4oCYZmFs?=
 =?utf-8?B?c2XigJk=?= values from wakeup_bdi
Message-ID: <20230217144143.wikkdw44jkdcgdm2@quack3>
References: <20230208011742.5183-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208011742.5183-1-zeming@nfschina.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-02-23 09:17:42, Li zeming wrote:
> wakeup_bdi does not need to be initialized. It is used after being
> assigned.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6fba5a52127b..2d3191d9c736 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2486,7 +2486,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		 */
>  		if (!was_dirty) {
>  			struct list_head *dirty_list;
> -			bool wakeup_bdi = false;
> +			bool wakeup_bdi;
>  
>  			inode->dirtied_when = jiffies;
>  			if (dirtytime)
> -- 
> 2.18.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
