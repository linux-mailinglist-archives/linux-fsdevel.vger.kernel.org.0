Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F96AAF7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 13:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCEM0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 07:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCEM0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:26:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B86A5A;
        Sun,  5 Mar 2023 04:26:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso10498841pjr.5;
        Sun, 05 Mar 2023 04:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xl6vFQ8hkQZXo44bP1B53YtidADnYRkkCpZDgBto+Ns=;
        b=fWAE6kDK6cLjnWoKKFqTQKS46k6YBJbs/Y35QxFtDPDxjvaZE/U8iCdV5aDw5WKMHP
         khWReskA4FTtEqV5ZtLjpSVHC12Q7OIjjG/SNuXsjpAfUmbuHq25G5u7jALq5mAakPz7
         2d5scY2CHOUIPFx+rSPNJZL1L61eRDrF7Ph4XVWEXbP9Co9Pr5JvsBiie8oDIshfKnyR
         Or6uM6LjQMIx213rv2yKM0MAywWiBbz99lC9YB8y+LeoeZOiIVUCWBLdTJGdh4glSr92
         oolb6QjebyxT+6vPROd/1QaR3Ohbg/BcW1IbIAThMQjRAgAN2pYYYhhMevU14kPOzRid
         RrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xl6vFQ8hkQZXo44bP1B53YtidADnYRkkCpZDgBto+Ns=;
        b=dSWc5ax4gGF6GtlGkcS+nvbNo12B5dlRaPI13u5yWc7mdaIz+ygsui5xwrv1H13Y1z
         y7oz/u3FP75D2gxLS4Az+w+8qwJ6te2vNRnPxm7kEyQxq/uIkdRqBz7JqPB/4EDLwRFi
         xFXBV5T+MkzcO+T1fNmVWln0vnquWGLsObnyGs8EXj7if4/gy063swiUHfMUjnpXpJhq
         7ygHkkjcZodboheoFQ7HLcy5U/kqlg/XKRBbyxdACr6RzSEUo6kA58GLzKRxPGgtXFas
         ngRPLGPJ5ZbndCPfKNNwtS7uhwOjO5tK+HLEs/IJqMCAnCUymlXT8v3Qf0aUWX+bcigI
         lO0w==
X-Gm-Message-State: AO0yUKW+6p7claxUD3jwVkRrJW6uyBjNP9uoSYqXOyhRjMlYXnMYtBEU
        IM1y357/p8pxYmJn92nSZfY5KdeyTyUTiQ==
X-Google-Smtp-Source: AK7set/JhFWvhV+4RtlLAix3MAknUUeAZO0KumPI+d44GUXEMbsUIWDLTkZiwVqZ6cB0kYSmx4DWUw==
X-Received: by 2002:a17:90b:1bc2:b0:237:a174:ce54 with SMTP id oa2-20020a17090b1bc200b00237a174ce54mr8409118pjb.21.1678019210952;
        Sun, 05 Mar 2023 04:26:50 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id lt15-20020a17090b354f00b0023377b98c7csm4319571pjb.38.2023.03.05.04.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:26:50 -0800 (PST)
Date:   Sun, 05 Mar 2023 17:56:32 +0530
Message-Id: <87zg8r1j0n.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 20/31] ext4: Convert __ext4_block_zero_page_range() to use a folio
In-Reply-To: <20230126202415.1682629-21-willy@infradead.org>
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

> Use folio APIs throughout.  Saves many calls to compound_head().

minor comment below.

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/inode.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b79e591b7c8e..727aa2e51a9d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3812,23 +3812,26 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	ext4_lblk_t iblock;
>  	struct inode *inode = mapping->host;
>  	struct buffer_head *bh;
> -	struct page *page;
> +	struct folio *folio;
>  	int err = 0;
>
> -	page = find_or_create_page(mapping, from >> PAGE_SHIFT,
> -				   mapping_gfp_constraint(mapping, ~__GFP_FS));
> -	if (!page)
> +	folio = __filemap_get_folio(mapping, from >> PAGE_SHIFT,
> +				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +				    mapping_gfp_constraint(mapping, ~__GFP_FS));
> +	if (!folio)
>  		return -ENOMEM;
>
>  	blocksize = inode->i_sb->s_blocksize;
>
>  	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
>
> -	if (!page_has_buffers(page))
> -		create_empty_buffers(page, blocksize, 0);
> +	bh = folio_buffers(folio);
> +	if (!bh) {
> +		create_empty_buffers(&folio->page, blocksize, 0);
> +		bh = folio_buffers(folio);
> +	}
>
>  	/* Find the buffer that contains "offset" */
> -	bh = page_buffers(page);
>  	pos = blocksize;
>  	while (offset >= pos) {
>  		bh = bh->b_this_page;
> @@ -3850,7 +3853,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	}
>
>  	/* Ok, it's mapped. Make sure it's up-to-date */
> -	if (PageUptodate(page))
> +	if (folio_test_uptodate(folio))
>  		set_buffer_uptodate(bh);
>
>  	if (!buffer_uptodate(bh)) {
> @@ -3860,7 +3863,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  		if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  			/* We expect the key to be set. */
>  			BUG_ON(!fscrypt_has_encryption_key(inode));
> -			err = fscrypt_decrypt_pagecache_blocks(page, blocksize,
> +			err = fscrypt_decrypt_pagecache_blocks(&folio->page,
> +							       blocksize,
>  							       bh_offset(bh));

I think after this patch which added support for decrypting large folio,
fscrypt_descrypt_pagecache_blocks() takes folio as it's 1st argument.
Hence this patch will need a small change to pass folio instead of page.

Other than that the change looks good to me.

Please feel free to add -
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

    51e4e3153ebc32d3280d5d17418ae6f1a44f1ec1
    Author:     Eric Biggers <ebiggers@google.com>
    CommitDate: Sat Jan 28 15:10:12 2023 -0800

    fscrypt: support decrypting data from large folios


-ritesh
