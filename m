Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52016AB690
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 07:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCFGwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 01:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCFGwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:52:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128683F9;
        Sun,  5 Mar 2023 22:52:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so6906519pjb.0;
        Sun, 05 Mar 2023 22:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IT1FiVQMyBFwjF1wOpOa6ILmz5MNm2RKjHdSLDxlVi0=;
        b=o/ek07NRjadh5WM060XSa5573dj9v+Rf2qVPmZttIdPa3TxKr0Ki9zxyvB8WhkDGX9
         o+2Xz6s4UXE4a3BJ4XEozK+wPRCgydRzYtPMWbTvq1SV4vErnL6CYqEimgL9TZjobAKU
         gmNNg+ra9tlu2YbX5cjOJFWq8nfiVGCZ87wX6y6y3LHGzM9Y1+Gqdp/7jNcRFLrr1ksy
         ARRuFvVw8SQ+BKkHz1u2yBGPO5RSmbR3Nhv50WYxrp95RZvEM9gWwMofYqooBzqkpnc8
         8pr+c8jEVkGlU5b2O43SvSoAf9kUwKRl0qjuoTUPDyTAcQlVo3IHjmVgHWqAvu5FPdZx
         DvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IT1FiVQMyBFwjF1wOpOa6ILmz5MNm2RKjHdSLDxlVi0=;
        b=mzdlbsDUXUHQzkEX7rZxOEMvKVoc8LuMmXWyjfGMUHmylOUjhE/Hazbm61BXSXEqZ9
         SFMfOl3gvpU4lE0cnfkO9hoi1reE+6p5HXHRUM/e3/WhtV2T6c/sVPSIYSzs8yy8MJvT
         m2aTItU7kAjsTlANoxohOJmdKKORiDluKGklGOekRM04TkTfUjUZuOXNgmiGOCpGam2/
         kaFFc4aRdnLRdMxcdQ7H7psP2KJVwQpzNuNQynS0JOiVJGhK2gofaF2WNHNRgMxPzLx6
         2KGW7yMsQdA1uhtHEzaGjftyGhfCVFJhk+idCB8faevS5ZMAJQA4lZKj0pIldK4Nngor
         aKBg==
X-Gm-Message-State: AO0yUKXjApLLbLqTuIMHwH9NsoedBQNKb4mHFhnza3eX+3JEWC20wFre
        eb19d9abgpgGlk8VdkMYfzbo38POwN8=
X-Google-Smtp-Source: AK7set8QiaMSVNVIna4KA3HvnUmGd1xiu/sVigD2uWobd4WwF13/d/BlTao1YrUOuOeV1IuoT5U9cw==
X-Received: by 2002:a17:902:e844:b0:19c:d97f:5d28 with SMTP id t4-20020a170902e84400b0019cd97f5d28mr13343148plg.32.1678085522316;
        Sun, 05 Mar 2023 22:52:02 -0800 (PST)
Received: from rh-tp ([129.41.58.21])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0019462aa090bsm5815593plh.284.2023.03.05.22.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 22:52:01 -0800 (PST)
Date:   Mon, 06 Mar 2023 12:21:48 +0530
Message-Id: <87wn3u1iez.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/31] ext4: Convert ext4_block_write_begin() to take a folio
In-Reply-To: <20230126202415.1682629-26-willy@infradead.org>
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

> All the callers now have a folio, so pass that in and operate on folios.
> Removes four calls to compound_head().

Why do you say four? Isn't it 3 calls of PageUptodate(page) which
removes calls to compound_head()? Which one did I miss?

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/inode.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index dbfc0670de75..507c7f88d737 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1055,12 +1055,12 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  }
>
>  #ifdef CONFIG_FS_ENCRYPTION
> -static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
> +static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  				  get_block_t *get_block)
>  {
>  	unsigned from = pos & (PAGE_SIZE - 1);
>  	unsigned to = from + len;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	unsigned block_start, block_end;
>  	sector_t block;
>  	int err = 0;
> @@ -1070,22 +1070,24 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
>  	int nr_wait = 0;
>  	int i;
>
> -	BUG_ON(!PageLocked(page));
> +	BUG_ON(!folio_test_locked(folio));
>  	BUG_ON(from > PAGE_SIZE);
>  	BUG_ON(to > PAGE_SIZE);
>  	BUG_ON(from > to);
>
> -	if (!page_has_buffers(page))
> -		create_empty_buffers(page, blocksize, 0);
> -	head = page_buffers(page);
> +	head = folio_buffers(folio);
> +	if (!head) {
> +		create_empty_buffers(&folio->page, blocksize, 0);
> +		head = folio_buffers(folio);
> +	}
>  	bbits = ilog2(blocksize);
> -	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
> +	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
>
>  	for (bh = head, block_start = 0; bh != head || !block_start;
>  	    block++, block_start = block_end, bh = bh->b_this_page) {
>  		block_end = block_start + blocksize;
>  		if (block_end <= from || block_start >= to) {
> -			if (PageUptodate(page)) {
> +			if (folio_test_uptodate(folio)) {
>  				set_buffer_uptodate(bh);
>  			}
>  			continue;
> @@ -1098,19 +1100,20 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
>  			if (err)
>  				break;
>  			if (buffer_new(bh)) {
> -				if (PageUptodate(page)) {
> +				if (folio_test_uptodate(folio)) {
>  					clear_buffer_new(bh);
>  					set_buffer_uptodate(bh);
>  					mark_buffer_dirty(bh);
>  					continue;
>  				}
>  				if (block_end > to || block_start < from)
> -					zero_user_segments(page, to, block_end,
> -							   block_start, from);
> +					folio_zero_segments(folio, to,
> +							    block_end,
> +							    block_start, from);
>  				continue;
>  			}
>  		}
> -		if (PageUptodate(page)) {
> +		if (folio_test_uptodate(folio)) {
>  			set_buffer_uptodate(bh);
>  			continue;
>  		}
> @@ -1130,13 +1133,13 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
>  			err = -EIO;
>  	}
>  	if (unlikely(err)) {
> -		page_zero_new_buffers(page, from, to);
> +		page_zero_new_buffers(&folio->page, from, to);
>  	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  		for (i = 0; i < nr_wait; i++) {
>  			int err2;
>
> -			err2 = fscrypt_decrypt_pagecache_blocks(page, blocksize,
> -								bh_offset(wait[i]));
> +			err2 = fscrypt_decrypt_pagecache_blocks(&folio->page,
> +						blocksize, bh_offset(wait[i]));

folio_decrypt_pagecache_blocks() takes folio as it's argument now.

Other than that it looks good to me. Please feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
