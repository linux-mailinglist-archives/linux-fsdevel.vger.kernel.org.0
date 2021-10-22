Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76C4373C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhJVIoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:44:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37336 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVIoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:44:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1806A2197A;
        Fri, 22 Oct 2021 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634892113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMKMYiSqPLZx6mI9tbSjyNPXZXonSrHh0yVcGp6Iofg=;
        b=ppn42qI+9E3KRRP5VuBY0b/5USQBOI2yhUHuDmaqX99K+roxPXisRc8RDxbVIkRrK1Mv6P
        FfiSP89Bnuwsg4ZNZINx1K4w/mDdLK8zb9QC94MDUrZw8yO3Rz83vRN05Twn3sJwSBbRME
        5xYbTAMjjh3k5YjeK53IgCqVTGdPh9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634892113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMKMYiSqPLZx6mI9tbSjyNPXZXonSrHh0yVcGp6Iofg=;
        b=CeYX9S2+WW/qKiYbiSPqvJbsBYFuwF2O7DstixlFJEMmNGh/w0XvM1WbhwHDWbOH596Ael
        nPyNkicL7TSVRJAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id CD43EA3B81;
        Fri, 22 Oct 2021 08:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8EF511E11B6; Fri, 22 Oct 2021 10:41:49 +0200 (CEST)
Date:   Fri, 22 Oct 2021 10:41:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: export bdi_unregister
Message-ID: <20211022084149.GB1026@quack2.suse.cz>
References: <20211021124441.668816-1-hch@lst.de>
 <20211021124441.668816-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021124441.668816-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 14:44:37, Christoph Hellwig wrote:
> To wind down the magic auto-unregister semantics we'll need to push this
> into modular code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/backing-dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 4a9d4e27d0d9b..8a46a0a4b72fa 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -958,6 +958,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
>  		bdi->owner = NULL;
>  	}
>  }
> +EXPORT_SYMBOL(bdi_unregister);
>  
>  static void release_bdi(struct kref *ref)
>  {
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
