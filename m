Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2B118359
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 10:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLJJQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 04:16:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbfLJJQe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:16:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE8CFABC7;
        Tue, 10 Dec 2019 09:16:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 302EE1E0B23; Tue, 10 Dec 2019 10:16:32 +0100 (CET)
Date:   Tue, 10 Dec 2019 10:16:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH] jbd2: fix kernel-doc notation warning
Message-ID: <20191210091632.GB1551@quack2.suse.cz>
References: <53e3ce27-ceae-560d-0fd4-f95728a33e12@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e3ce27-ceae-560d-0fd4-f95728a33e12@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 08-12-19 20:31:32, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning by inserting a beginning '*' character
> for the kernel-doc line.
> 
> ../include/linux/jbd2.h:461: warning: bad line:         journal. These are dirty buffers and revoke descriptor blocks.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20191209.orig/include/linux/jbd2.h
> +++ linux-next-20191209/include/linux/jbd2.h
> @@ -457,7 +457,7 @@ struct jbd2_revoke_table_s;
>   * @h_journal: Which journal handle belongs to - used iff h_reserved set.
>   * @h_rsv_handle: Handle reserved for finishing the logical operation.
>   * @h_total_credits: Number of remaining buffers we are allowed to add to
> -	journal. These are dirty buffers and revoke descriptor blocks.
> + *	journal. These are dirty buffers and revoke descriptor blocks.
>   * @h_revoke_credits: Number of remaining revoke records available for handle
>   * @h_ref: Reference count on this handle.
>   * @h_err: Field for caller's use to track errors through large fs operations.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
