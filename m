Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3011E22C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 11:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMKkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 05:40:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfLMKkF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:40:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28312B0B6;
        Fri, 13 Dec 2019 10:40:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BAC151E0CAF; Fri, 13 Dec 2019 11:40:03 +0100 (CET)
Date:   Fri, 13 Dec 2019 11:40:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io.c: include fs/internal.h for missing
 prototype
Message-ID: <20191213104003.GA15474@quack2.suse.cz>
References: <20191209234544.128302-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209234544.128302-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-12-19 15:45:44, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Include fs/internal.h to address the following 'sparse' warning:
> 
>     fs/direct-io.c:591:5: warning: symbol 'sb_init_dio_done_wq' was not declared. Should it be static?
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Hi Andrew, please consider applying this straightforward cleanup.
> This has been sent to Al four times with no response.
> 
>  fs/direct-io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 0ec4f270139f6..00b4d15bb811a 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -39,6 +39,8 @@
>  #include <linux/atomic.h>
>  #include <linux/prefetch.h>
>  
> +#include "internal.h"
> +
>  /*
>   * How many user pages to map in one call to get_user_pages().  This determines
>   * the size of a structure in the slab cache
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
