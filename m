Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1819348D63F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 12:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiAMLBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 06:01:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43790 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiAMLBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:01:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C0BD41F3D2;
        Thu, 13 Jan 2022 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642071695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCDhP7bldJJEb5IG2FBAn7a1olbFjes1C2dIqW8mwjw=;
        b=CC9Nzi6B3YsNyzP4H/xjYZtVOAL05nzfcS4oc14tKBhAk2ZYDZ7ZfxrXzYFLLxNluOR005
        +9HDrUMJslDFGmRT1liCKOnsYrFiTUEWG0p8reMYL1lKHmilYRXY/svCjUcZkfQJS0zvHx
        QRLR8aMcE4Xc4yQ/XtCmKoo7drACoDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642071695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RCDhP7bldJJEb5IG2FBAn7a1olbFjes1C2dIqW8mwjw=;
        b=GrP0n0thBal5rejUK13WuIJHUBGqyf6OQf0LcoRDkeAiVOqQ9JVC0mkx3GuFRFXqBwgqcH
        0VkJAJ/aVzAA/sDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B1AD4A3B88;
        Thu, 13 Jan 2022 11:01:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 773D2A05E2; Thu, 13 Jan 2022 12:01:35 +0100 (CET)
Date:   Thu, 13 Jan 2022 12:01:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH 4/6] jbd2: Cleanup unused functions declarations from
 jbd2.h
Message-ID: <20220113110135.jpmi2ogjunxyyleh@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <bd827c4a3a5b369fe4391b5fc929a00a08af8184.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd827c4a3a5b369fe4391b5fc929a00a08af8184.1642044249.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-01-22 08:56:27, Ritesh Harjani wrote:
> During code review found no references of few of these below function
> declarations. This patch cleans those up from jbd2.h
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Spring cleaning :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index fd933c45281a..f76598265896 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1419,9 +1419,7 @@ extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
>  extern bool __jbd2_journal_refile_buffer(struct journal_head *);
>  extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
>  extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
> -extern void __journal_free_buffer(struct journal_head *bh);
>  extern void jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
> -extern void __journal_clean_data_list(transaction_t *transaction);
>  static inline void jbd2_file_log_bh(struct list_head *head, struct buffer_head *bh)
>  {
>  	list_add_tail(&bh->b_assoc_buffers, head);
> @@ -1486,9 +1484,6 @@ extern int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  					      struct buffer_head **bh_out,
>  					      sector_t blocknr);
>  
> -/* Transaction locking */
> -extern void		__wait_on_journal (journal_t *);
> -
>  /* Transaction cache support */
>  extern void jbd2_journal_destroy_transaction_cache(void);
>  extern int __init jbd2_journal_init_transaction_cache(void);
> @@ -1774,8 +1769,6 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
>  #define BJ_Reserved	4	/* Buffer is reserved for access by journal */
>  #define BJ_Types	5
>  
> -extern int jbd_blocks_per_page(struct inode *inode);
> -
>  /* JBD uses a CRC32 checksum */
>  #define JBD_MAX_CHECKSUM_SIZE 4
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
