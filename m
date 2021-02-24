Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F7324084
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhBXPKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:10:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:47976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237992AbhBXOlD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:41:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 580A6AD5C;
        Wed, 24 Feb 2021 14:40:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1AA601E14F1; Wed, 24 Feb 2021 15:40:22 +0100 (CET)
Date:   Wed, 24 Feb 2021 15:40:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use sb_end_write instend of __sb_end_write
Message-ID: <20210224144022.GB849@quack2.suse.cz>
References: <20210219120149.1056-1-changfengnan@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219120149.1056-1-changfengnan@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 19-02-21 20:01:49, Fengnan Chang wrote:
> __sb_end_write is an internal function, use sb_end_write instead of __sb_end_write.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd47deea7c17..6b2e6f9035a5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2784,7 +2784,7 @@ static inline void file_end_write(struct file *file)
>  {
>  	if (!S_ISREG(file_inode(file)->i_mode))
>  		return;
> -	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +	sb_end_write(file_inode(file)->i_sb);
>  }
>  
>  /*
> -- 
> 2.29.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
