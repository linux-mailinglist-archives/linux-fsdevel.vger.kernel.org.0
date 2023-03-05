Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E246AAF40
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCELSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 06:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCELSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 06:18:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960DA268;
        Sun,  5 Mar 2023 03:18:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so10440568pjb.3;
        Sun, 05 Mar 2023 03:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=modbLLVmR6UJ3BqInFBPWX5ndR9wTtXcrP9Sn+Yb3xY=;
        b=B3C+6EKxxrlZbl+63ztxZujMca7sqb73gumfGDWW/3GWqhUgt1MdzsIRD4LAph9fZU
         SWISpcUDkkIrwQQv3YpcJbX6IklK70ZK7fjY7XnwCNAiHxUrVhi1HnU/QojkWvpk3kRM
         2BPR9F6Kd39QAHhmXjAh661twnzQn3LBpwPnZkFuboWKviOaLCecFmrfkr1XVkOdDc4N
         3zLcb/HjeZThcFkd2vyilo7T35Z2CCuvBHP3cLgINrzR9tYGydmJom0OyMT5kn5MqxB4
         Ib9TfdxjVkcyODzgjvFFtKHiF0kvlibjqrIlH7VtM5BA684Uvii/6Q6wI0MCTAeKhc5s
         Qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=modbLLVmR6UJ3BqInFBPWX5ndR9wTtXcrP9Sn+Yb3xY=;
        b=59/Jz8ANFgvD0rFrFQXWQME34Fq47zIMQllLFycAbZ5QDab1aqkgqsILQHka9Yw9oS
         q4ZW3GM1lWcTBHSyj0KkEf9mSYRoF0hfk6LfrUCS5fd65FadhQMX2E19zcXvFYIPs23t
         J/PrRM+55+fndooiTv70b1GfSIRz59fBlIeY21VRxnMtB4hW01tbqnssOuxdGeGayjY+
         E+3JQYdfCIogAtvzu7x3OSFzglob67GD0XXjhplIw4h3DGpF1tzNtP45TVi24xZnQlYT
         IBw/kVgfaKHv+RKITUpVWpRrRCl4qbaWQSjiu17+geV63EzW3/L6WqtX1jICoYHTMep8
         s8Qw==
X-Gm-Message-State: AO0yUKXwMf6xDBxncYGLpwPV6o/PqivENzQlTD6w7OlhTnWVzKzLJuP2
        eo6jPGVq1mcQqAx6k84UPvWYUgGb+bIgCQ==
X-Google-Smtp-Source: AK7set/zS9ry2tPqqKt6wEnWDq0jjS+gRCXNGPXTQZi7DQ9d1MVtz7PaFlm8RyO3edCWxmCd1DS9cw==
X-Received: by 2002:a17:902:e892:b0:19c:ea4d:5995 with SMTP id w18-20020a170902e89200b0019cea4d5995mr10120109plg.68.1678015127107;
        Sun, 05 Mar 2023 03:18:47 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902b61700b0019c3296844csm4554009pls.301.2023.03.05.03.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 03:18:46 -0800 (PST)
Date:   Sun, 05 Mar 2023 16:48:32 +0530
Message-Id: <875ybf30qf.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
In-Reply-To: <20230126202415.1682629-4-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> Remove several calls to compound_head() and the last caller of
> set_page_writeback_keepwrite(), so remove the wrapper too.

Straight forward conversion.
Looks good to me. Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/page-io.c          | 58 ++++++++++++++++++--------------------
>  include/linux/page-flags.h |  5 ----
>  2 files changed, 27 insertions(+), 36 deletions(-)
>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index beaec6d81074..982791050892 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -409,11 +409,9 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
>
>  static void io_submit_add_bh(struct ext4_io_submit *io,
>  			     struct inode *inode,
> -			     struct page *page,
> +			     struct folio *folio,
>  			     struct buffer_head *bh)
>  {
> -	int ret;
> -
>  	if (io->io_bio && (bh->b_blocknr != io->io_next_block ||
>  			   !fscrypt_mergeable_bio_bh(io->io_bio, bh))) {
>  submit_and_retry:
> @@ -421,10 +419,9 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
>  	}
>  	if (io->io_bio == NULL)
>  		io_submit_init_bio(io, bh);
> -	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
> -	if (ret != bh->b_size)
> +	if (!bio_add_folio(io->io_bio, folio, bh->b_size, bh_offset(bh)))
>  		goto submit_and_retry;
> -	wbc_account_cgroup_owner(io->io_wbc, page, bh->b_size);
> +	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
>  	io->io_next_block++;
>  }
>
> @@ -432,8 +429,9 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			struct page *page,
>  			int len)
>  {
> -	struct page *bounce_page = NULL;
> -	struct inode *inode = page->mapping->host;
> +	struct folio *folio = page_folio(page);
> +	struct folio *io_folio = folio;
> +	struct inode *inode = folio->mapping->host;
>  	unsigned block_start;
>  	struct buffer_head *bh, *head;
>  	int ret = 0;
> @@ -441,30 +439,30 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  	struct writeback_control *wbc = io->io_wbc;
>  	bool keep_towrite = false;
>
> -	BUG_ON(!PageLocked(page));
> -	BUG_ON(PageWriteback(page));
> +	BUG_ON(!folio_test_locked(folio));
> +	BUG_ON(folio_test_writeback(folio));
>
> -	ClearPageError(page);
> +	folio_clear_error(folio);
>
>  	/*
>  	 * Comments copied from block_write_full_page:
>  	 *
> -	 * The page straddles i_size.  It must be zeroed out on each and every
> +	 * The folio straddles i_size.  It must be zeroed out on each and every
>  	 * writepage invocation because it may be mmapped.  "A file is mapped
>  	 * in multiples of the page size.  For a file that is not a multiple of
>  	 * the page size, the remaining memory is zeroed when mapped, and
>  	 * writes to that region are not written out to the file."
>  	 */
> -	if (len < PAGE_SIZE)
> -		zero_user_segment(page, len, PAGE_SIZE);
> +	if (len < folio_size(folio))
> +		folio_zero_segment(folio, len, folio_size(folio));
>  	/*
>  	 * In the first loop we prepare and mark buffers to submit. We have to
> -	 * mark all buffers in the page before submitting so that
> -	 * end_page_writeback() cannot be called from ext4_end_bio() when IO
> +	 * mark all buffers in the folio before submitting so that
> +	 * folio_end_writeback() cannot be called from ext4_end_bio() when IO
>  	 * on the first buffer finishes and we are still working on submitting
>  	 * the second buffer.
>  	 */
> -	bh = head = page_buffers(page);
> +	bh = head = folio_buffers(folio);
>  	do {
>  		block_start = bh_offset(bh);
>  		if (block_start >= len) {
> @@ -479,14 +477,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  				clear_buffer_dirty(bh);
>  			/*
>  			 * Keeping dirty some buffer we cannot write? Make sure
> -			 * to redirty the page and keep TOWRITE tag so that
> -			 * racing WB_SYNC_ALL writeback does not skip the page.
> +			 * to redirty the folio and keep TOWRITE tag so that
> +			 * racing WB_SYNC_ALL writeback does not skip the folio.
>  			 * This happens e.g. when doing writeout for
>  			 * transaction commit.
>  			 */
>  			if (buffer_dirty(bh)) {
> -				if (!PageDirty(page))
> -					redirty_page_for_writepage(wbc, page);
> +				if (!folio_test_dirty(folio))
> +					folio_redirty_for_writepage(wbc, folio);
>  				keep_towrite = true;
>  			}
>  			continue;
> @@ -498,11 +496,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  		nr_to_submit++;
>  	} while ((bh = bh->b_this_page) != head);
>
> -	/* Nothing to submit? Just unlock the page... */
> +	/* Nothing to submit? Just unlock the folio... */
>  	if (!nr_to_submit)
>  		goto unlock;
>
> -	bh = head = page_buffers(page);
> +	bh = head = folio_buffers(folio);
>
>  	/*
>  	 * If any blocks are being written to an encrypted file, encrypt them
> @@ -514,6 +512,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  	if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
>  		gfp_t gfp_flags = GFP_NOFS;
>  		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
> +		struct page *bounce_page;
>
>  		/*
>  		 * Since bounce page allocation uses a mempool, we can only use
> @@ -540,7 +539,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			}
>
>  			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
> -			redirty_page_for_writepage(wbc, page);
> +			folio_redirty_for_writepage(wbc, folio);
>  			do {
>  				if (buffer_async_write(bh)) {
>  					clear_buffer_async_write(bh);
> @@ -550,21 +549,18 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			} while (bh != head);
>  			goto unlock;
>  		}
> +		io_folio = page_folio(bounce_page);
>  	}
>
> -	if (keep_towrite)
> -		set_page_writeback_keepwrite(page);
> -	else
> -		set_page_writeback(page);
> +	__folio_start_writeback(folio, keep_towrite);
>
>  	/* Now submit buffers to write */
>  	do {
>  		if (!buffer_async_write(bh))
>  			continue;
> -		io_submit_add_bh(io, inode,
> -				 bounce_page ? bounce_page : page, bh);
> +		io_submit_add_bh(io, inode, io_folio, bh);
>  	} while ((bh = bh->b_this_page) != head);
>  unlock:
> -	unlock_page(page);
> +	folio_unlock(folio);
>  	return ret;
>  }
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0425f22a9c82..bba2a32031a2 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -766,11 +766,6 @@ bool set_page_writeback(struct page *page);
>  #define folio_start_writeback_keepwrite(folio)	\
>  	__folio_start_writeback(folio, true)
>
> -static inline void set_page_writeback_keepwrite(struct page *page)
> -{
> -	folio_start_writeback_keepwrite(page_folio(page));
> -}
> -
>  static inline bool test_set_page_writeback(struct page *page)
>  {
>  	return set_page_writeback(page);
> --
> 2.35.1
