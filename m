Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B22557DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiFWOe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:34:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBA35DE8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 07:34:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1EBC91F8EF;
        Thu, 23 Jun 2022 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655994894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QajO7Q18Yuwi6zqS/c/A8TWFORLY3mcCTmvT9VvEcNQ=;
        b=rdE7Pc2NHi9OPLRRJkk0C1S5BaUeiEDMXDkteM1TIs0MKHuscqo4AAiPtMXR2tyjmNbWSC
        /TSuNCc9aJIvn3Irclw6OTko5PawCIXsFePkam9uKTvqJ3k/B2A/kfuaDvlTc3+BpxgNP+
        3wzkpjxS1OKZLdmBEPI2jLvNdEHtEGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655994894;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QajO7Q18Yuwi6zqS/c/A8TWFORLY3mcCTmvT9VvEcNQ=;
        b=E+2uIyZev2RNRGfQ0JJ5AYBGG7sjtten2CUeY5Ojsqb9D2QcXWXIKmIBhMxICzB6xaqV1s
        jOR8IpRz1tsWmmBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C50772C142;
        Thu, 23 Jun 2022 14:34:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F31FEA062B; Thu, 23 Jun 2022 16:34:49 +0200 (CEST)
Date:   Thu, 23 Jun 2022 16:34:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Oliver Ford <ojford@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: inotify: Fix typo in inotify comment
Message-ID: <20220623143449.ksh77ba6chbmyxql@quack3.lan>
References: <20220518145959.41-1-ojford@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518145959.41-1-ojford@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-05-22 15:59:59, Oliver Ford wrote:
> Correct spelling in comment.
> 
> Signed-off-by: Oliver Ford <ojford@gmail.com>

Thanks and sorry for a delayed reply! Please CC me directly when submitting
patches for faster replies :). I've added the patch to my tree.

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 54583f62dc44..bdd8436c4a7a 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -121,7 +121,7 @@ static inline u32 inotify_mask_to_arg(__u32 mask)
>  		       IN_Q_OVERFLOW);
>  }
>  
> -/* intofiy userspace file descriptor functions */
> +/* inotify userspace file descriptor functions */
>  static __poll_t inotify_poll(struct file *file, poll_table *wait)
>  {
>  	struct fsnotify_group *group = file->private_data;
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
