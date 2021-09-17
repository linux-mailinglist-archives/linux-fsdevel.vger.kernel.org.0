Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97740F51F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhIQJsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 05:48:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhIQJsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:48:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E5E620267;
        Fri, 17 Sep 2021 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631872027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1t7gEb5/sjDaV4EgNaCcb4u5rshwlUjpresNzaFeZ4=;
        b=vlPADcIh9UBXN+qL78GFZ/7QPrxP2HBa6YLUFkFo7A1f5tqLIgvptBlV5jWCfXbRn48gao
        8hH73r9SXSWaQ/mmzoJaFB+ABzcBOXYGl9dyJJYVh6jpUERFJMf+rM4ezSVNnz6fXrJ7gP
        bFK5ZWsdaZajxmtctulBRQ74vsZfbUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631872027;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1t7gEb5/sjDaV4EgNaCcb4u5rshwlUjpresNzaFeZ4=;
        b=2s6OPr/NY9mztvQsarxpBiGJy8SWHMRZ3y7N5EdAcND1LlUJLwY/FcfCr7SUSbR1fM83X4
        MYXiUjb3DeIVFxDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 440F4A3B97;
        Fri, 17 Sep 2021 09:47:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A94E1E0CA7; Fri, 17 Sep 2021 11:47:07 +0200 (CEST)
Date:   Fri, 17 Sep 2021 11:47:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 3/3] ext2: remove dax EXPERIMENTAL warning
Message-ID: <20210917094707.GD6547@quack2.suse.cz>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
 <1631726561-16358-4-git-send-email-sandeen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631726561-16358-4-git-send-email-sandeen@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-09-21 12:22:41, Eric Sandeen wrote:
> As there seems to be no significant outstanding concern about
> dax on ext2 at this point, remove the scary EXPERIMENTAL
> warning when in use.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Agreed. Do you want my ack or should I just merge this patch?

								Honza

> ---
>  fs/ext2/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index d8d580b..1915733 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -587,8 +587,6 @@ static int parse_options(char *options, struct super_block *sb,
>  			fallthrough;
>  		case Opt_dax:
>  #ifdef CONFIG_FS_DAX
> -			ext2_msg(sb, KERN_WARNING,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
>  			set_opt(opts->s_mount_opt, DAX);
>  #else
>  			ext2_msg(sb, KERN_INFO, "dax option not supported");
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
