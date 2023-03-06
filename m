Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216C66AB964
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 10:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCFJLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 04:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCFJLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:11:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5B722DC5;
        Mon,  6 Mar 2023 01:11:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so12559153pjh.0;
        Mon, 06 Mar 2023 01:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUAjzJ8IzCY5Wkgn8cd2LZwJjvmVx8dZSoBFT4ZwXBs=;
        b=FDWGrVlAXFzJI8In6ZdbBDv9hyxoq1c5bwEazCtHa1SdGc3RYyavvkv6uiuMT3zJpV
         2rIlX2WvxMw6+y6pvjqOP6bNL13d7u7KG9p/OVTdA+VmAiCqLwpdLdVD46HhrmKZmfYX
         sS3aLA3J1JESZeZooVk49lcBbasJITabM3kmK/Ytq1jQLf+R+3QvsUxxogiFMWyq0z+S
         2OIbrpddIfHBv0jmKqDOKTC3PXAH9JCBzefbHbFEaLPYK7bLh4cyNSScK4/xN9CTcJMe
         FWbE29kyHThlcWs5Ouwg2vgAkJlCVPE1PgoZoOQ5KWtZ3mJwZ+tnZHWDAID0FcIwdaPw
         9Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUAjzJ8IzCY5Wkgn8cd2LZwJjvmVx8dZSoBFT4ZwXBs=;
        b=sVji05jOJTlLGFyi+SreFnppywu+5Tlsp3kPRU+s+sdc/xkQja2RGyZQtTjkqBIEFR
         OSefmrBdNkDAfBafUvL1DJYZEATgxTmyTYWR9BBtB6e0M1fHHz3is3eVM8ZYeCb1L9gV
         jhuUpPJQgCDNuvt+RJ60mQ8XS8zJUy2zs1eiSDy8xmb1J0g1euZPNBJ6Dqbvx22geq1o
         bCsQtkcMGriDLqkXQjZVyKzyhZ/B3scbm+e+fYaRV11CfQCbHRcajwkTBm30J29YGUY1
         A+OjwDWj/uSEuw9n/Y5RviUsdPOm9ci3weISek4zOiM7IeV+wS/vM+qLmCzlAzcBnmhg
         6JhQ==
X-Gm-Message-State: AO0yUKWMOvOm1kTgF7zRu8xbVCtjt1fBM5c23+NH9rtdCebkoUOLL+D+
        qcpVAjLOH7wI2XhyWmClAp9aenjkfTE=
X-Google-Smtp-Source: AK7set9QQW08iEsXBh4iP4wdez/TKWXRYPcgfmJzhxvQDk3P2GIqIWFLj2gtxtqtRpGsMb8pJ5DiIA==
X-Received: by 2002:a05:6a20:7aa7:b0:c7:6232:c6e2 with SMTP id u39-20020a056a207aa700b000c76232c6e2mr8322562pzh.48.1678093867803;
        Mon, 06 Mar 2023 01:11:07 -0800 (PST)
Received: from rh-tp ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id t8-20020aa79388000000b0058bb79beefcsm5837456pfe.123.2023.03.06.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:11:07 -0800 (PST)
Date:   Mon, 06 Mar 2023 14:40:55 +0530
Message-Id: <87ttyy1bz4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/31] ext4: Convert ext4_finish_bio() to use folios
In-Reply-To: <20230126202415.1682629-5-willy@infradead.org>
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

> Prepare ext4 to support large folios in the page writeback path.

Sure. I am guessing for ext4 to completely support large folio
requires more work like fscrypt bounce page handling doesn't
yet support folios right?

Could you please give a little background on what all would be required
to add large folio support in ext4 buffered I/O path?
(I mean ofcourse other than saying move ext4 to iomap ;))

What I was interested in was, what other components in particular for
e.g. fscrypt, fsverity, ext4's xyz component needs large folio support?

And how should one go about in adding this support? So can we move
ext4's read path to have large folio support to get started?
Have you already identified what all is missing from this path to
convert it?

> Also set the actual error in the mapping, not just -EIO.

Right. I looked at the history and I think it always just had EIO.
I think setting the actual err in mapping_set_error() is the right thing
to do here.

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

w.r.t this patch series. I reviewed the mechanical changes & error paths
which converts ext4 ext4_finish_bio() to use folio.

The changes looks good to me from that perspective. Feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> ---
>  fs/ext4/page-io.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 982791050892..fd6c0dca24b9 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -99,30 +99,30 @@ static void buffer_io_error(struct buffer_head *bh)
>
>  static void ext4_finish_bio(struct bio *bio)
>  {
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> +	struct folio_iter fi;
>
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> -		struct page *bounce_page = NULL;
> +	bio_for_each_folio_all(fi, bio) {
> +		struct folio *folio = fi.folio;
> +		struct folio *io_folio = NULL;
>  		struct buffer_head *bh, *head;
> -		unsigned bio_start = bvec->bv_offset;
> -		unsigned bio_end = bio_start + bvec->bv_len;
> +		size_t bio_start = fi.offset;
> +		size_t bio_end = bio_start + fi.length;
>  		unsigned under_io = 0;
>  		unsigned long flags;
>
> -		if (fscrypt_is_bounce_page(page)) {
> -			bounce_page = page;
> -			page = fscrypt_pagecache_page(bounce_page);
> +		if (fscrypt_is_bounce_folio(folio)) {
> +			io_folio = folio;
> +			folio = fscrypt_pagecache_folio(folio);
>  		}
>
>  		if (bio->bi_status) {
> -			SetPageError(page);
> -			mapping_set_error(page->mapping, -EIO);
> +			int err = blk_status_to_errno(bio->bi_status);
> +			folio_set_error(folio);
> +			mapping_set_error(folio->mapping, err);
>  		}
> -		bh = head = page_buffers(page);
> +		bh = head = folio_buffers(folio);
>  		/*
> -		 * We check all buffers in the page under b_uptodate_lock
> +		 * We check all buffers in the folio under b_uptodate_lock
>  		 * to avoid races with other end io clearing async_write flags
>  		 */
>  		spin_lock_irqsave(&head->b_uptodate_lock, flags);
> @@ -141,8 +141,8 @@ static void ext4_finish_bio(struct bio *bio)
>  		} while ((bh = bh->b_this_page) != head);
>  		spin_unlock_irqrestore(&head->b_uptodate_lock, flags);
>  		if (!under_io) {
> -			fscrypt_free_bounce_page(bounce_page);
> -			end_page_writeback(page);
> +			fscrypt_free_bounce_page(&io_folio->page);

Could you please help understand what would it take to convert bounce
page in fscrypt to folio?

Today, we allocate 32 bounce pages of order 0 via mempool in
    fscrypt_initialize()
    <...>
        fscrypt_bounce_page_pool =
            mempool_create_page_pool(num_prealloc_crypto_pages, 0);
    <...>

And IIUC, we might need to add some support for having higher order
pages in the pool so that one can allocate a folio->_folio_order
folio from this pool for bounce page to support large folio.
Is that understanding correct? Your thoughts on this please?

-ritesh
