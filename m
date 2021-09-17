Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1140F526
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 11:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhIQJtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 05:49:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbhIQJtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:49:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AB2A520269;
        Fri, 17 Sep 2021 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631872057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkeJWRJvzLZmbJLa8WKhvrp6aRet3kWno8RhwtiyhTg=;
        b=QaWDugXPEQWcu3dSzPKcNLCFE21naNY742kJ+h5TlBF8z5c0tltoq4i+1SeoZ3gKET4VXg
        wbcQYmy3XKsMVgVYxMzPNAGJoQzU4B1Sc09R3AOUt2iDqODpSovV/2bb/L/+8el2KDifUe
        VdK5EMAoMW44O6x5bh6Xxw+CVVuWv54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631872057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkeJWRJvzLZmbJLa8WKhvrp6aRet3kWno8RhwtiyhTg=;
        b=K6QALvUjDs7t1h6S6Sr/3kTLrXP3ECemJ+A7+MSjxG+fcA3we0fgllUZf8ifFCe9BtIAfq
        VWszU8u0wvJIacDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A09DFA3B81;
        Fri, 17 Sep 2021 09:47:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 884BC1E0CA7; Fri, 17 Sep 2021 11:47:37 +0200 (CEST)
Date:   Fri, 17 Sep 2021 11:47:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 2/3] ext4: remove dax EXPERIMENTAL warning
Message-ID: <20210917094737.GE6547@quack2.suse.cz>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
 <1631726561-16358-3-git-send-email-sandeen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631726561-16358-3-git-send-email-sandeen@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-09-21 12:22:40, Eric Sandeen wrote:
> As there seems to be no significant outstanding concern about
> dax on ext4 at this point, remove the scary EXPERIMENTAL
> warning when in use.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

I agree. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0775950..82948d6 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2346,8 +2346,6 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  					     "both data=journal and dax");
>  				    return -1;
>  			}
> -			ext4_msg(sb, KERN_WARNING,
> -				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>  			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
>  			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
>  			break;
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
