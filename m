Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5A704A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjEPKOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEPKOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 06:14:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498021BD2;
        Tue, 16 May 2023 03:14:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24de2954bc5so9525512a91.1;
        Tue, 16 May 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684232056; x=1686824056;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NMQMCbxHSWAUGKr0MqbDCx6WOe4AvAp9AsCQpJh5C5E=;
        b=Gvelv051dwXZq9lOWIEjNhRK2HPn1mK8nWkyNFRKE5FUOgQB3st1M57FoVFOzLh/i6
         QvsqhZNkjjLhyhN7OVYyEdUuvkvup9NbVht757oroZExcSdfUJ9Ox0f8oU3ZFutgbfmT
         dn+C6K/KR499uG7+9HzrG44Iw9xXo8XhJiYKUlJA5sYf03J2apgrpCsoww32sshCGUGA
         ul7Lg2KWt3J7uXDGG0JLX4t3F+FhG94dyPYkZC/m076PhWor6fm6AFZ2fDgItMAGa3VH
         pSNYWsRcv9HFwaVv35XPF8y1VQEHPT8TXlXy+q1QEiRQsjh3NXNtvJYeeAC8hYUr8+iY
         iaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232056; x=1686824056;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMQMCbxHSWAUGKr0MqbDCx6WOe4AvAp9AsCQpJh5C5E=;
        b=cggCeWUdoPfD8ALUlh4p4Q+S9Z0ppnWqLmAMR+NHYl4yxujX8sl3Hq7QuCAjS2r7HG
         tu6qh1pW+4AeblprlAiN+BTO/9YmhWEouuN32L+zC+KVG9kMukZvE1K3Kj9CpUrz6Iwy
         MHXKO0iHhKxyslinMsOB9lYNbehrbN5BxHZF9HlK3jSjYxDsH1/SjbS8WIez3cxbYmRh
         sDyGQC0tZhegXLuNK2vyhYm/JC68SLbxvi48dnmiicUO9SEiQ2vLjN+vAfYCjYl6nmIH
         5ySSbuo9XZYxACcdsBwK/o0TV1mWEjpN0fJ2GPhUIadCsDdzyPtpAFQGSJkUnqY47h9m
         iPBg==
X-Gm-Message-State: AC+VfDyA2cvwVTtGQhsi4++gNSIDacPWpq0jhLRuyN7DtqWiZyXUfMTj
        fMdAA5hPFRm0yOrlqrG0S6Q=
X-Google-Smtp-Source: ACHHUZ6Rfey9VTl/cWY0UdXH9blgr9NInO0J/jChTBizbFJdNBW1SchzbsMFbSqxU5Dfzyx+NJWOQg==
X-Received: by 2002:a17:90a:7b8d:b0:247:3548:e470 with SMTP id z13-20020a17090a7b8d00b002473548e470mr36767490pjc.29.1684232056622;
        Tue, 16 May 2023 03:14:16 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a898800b0024e069c4099sm1249244pjn.46.2023.05.16.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 03:14:16 -0700 (PDT)
Date:   Tue, 16 May 2023 15:44:10 +0530
Message-Id: <87cz30lh1p.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 3/5] iomap: Add iop's uptodate state handling functions
In-Reply-To: <ZGJLXcTkzdyHY25d@bfoster>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Brian Foster <bfoster@redhat.com> writes:

> On Mon, May 08, 2023 at 12:57:58AM +0530, Ritesh Harjani (IBM) wrote:
>> Firstly this patch renames iop->uptodate to iop->state bitmap.
>> This is because we will add dirty state to iop->state bitmap in later
>> patches. So it makes sense to rename the iop->uptodate bitmap to
>> iop->state.
>>
>> Secondly this patch also adds other helpers for uptodate state bitmap
>> handling of iop->state.
>>
>> No functionality change in this patch.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/buffered-io.c | 78 +++++++++++++++++++++++++++++++-----------
>>  1 file changed, 58 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index e732581dc2d4..5103b644e115 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
> ...
>> @@ -43,6 +43,47 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
> ...
>> +/*
>> + * iop related helpers for checking uptodate/dirty state of per-block
>> + * or range of blocks within a folio
>> + */
>> +static bool iop_test_full_uptodate(struct folio *folio)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	struct inode *inode = folio->mapping->host;
>> +
>> +	WARN_ON(!iop);
>
> It looks like an oops or something is imminent here if iop is NULL. Why
> the warn (here and in a couple other places)?
>

I agree. I will remove it in the next revision.

-ritesh

> Brian
>
>> +	return iop_bitmap_full(iop, i_blocks_per_folio(inode, folio));
>> +}
>> +
>> +static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +	WARN_ON(!iop);
>> +	return iop_test_block(iop, block);
>> +}
>> +
>>  static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>>  				   size_t off, size_t len)
>>  {
>> @@ -53,12 +94,11 @@ static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>>  	unsigned long flags;
>>
>>  	if (iop) {
>> -		spin_lock_irqsave(&iop->uptodate_lock, flags);
>> -		bitmap_set(iop->uptodate, first_blk, nr_blks);
>> -		if (bitmap_full(iop->uptodate,
>> -				i_blocks_per_folio(inode, folio)))
>> +		spin_lock_irqsave(&iop->state_lock, flags);
>> +		iop_set_range(iop, first_blk, nr_blks);
>> +		if (iop_test_full_uptodate(folio))
>>  			folio_mark_uptodate(folio);
>> -		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>> +		spin_unlock_irqrestore(&iop->state_lock, flags);
>>  	} else {
>>  		folio_mark_uptodate(folio);
>>  	}
>> @@ -79,12 +119,12 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
>>  	else
>>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>>
>> -	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
>> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
>>  		      gfp);
>>  	if (iop) {
>> -		spin_lock_init(&iop->uptodate_lock);
>> +		spin_lock_init(&iop->state_lock);
>>  		if (folio_test_uptodate(folio))
>> -			bitmap_fill(iop->uptodate, nr_blocks);
>> +			iop_set_range(iop, 0, nr_blocks);
>>  		folio_attach_private(folio, iop);
>>  	}
>>  	return iop;
>> @@ -93,15 +133,13 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
>>  static void iop_free(struct folio *folio)
>>  {
>>  	struct iomap_page *iop = to_iomap_page(folio);
>> -	struct inode *inode = folio->mapping->host;
>> -	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>>
>>  	if (!iop)
>>  		return;
>>  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>>  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
>> -	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
>> -			folio_test_uptodate(folio));
>> +	WARN_ON_ONCE(iop_test_full_uptodate(folio) !=
>> +		     folio_test_uptodate(folio));
>>  	folio_detach_private(folio);
>>  	kfree(iop);
>>  }
>> @@ -132,7 +170,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>
>>  		/* move forward for each leading block marked uptodate */
>>  		for (i = first; i <= last; i++) {
>> -			if (!test_bit(i, iop->uptodate))
>> +			if (!iop_test_block_uptodate(folio, i))
>>  				break;
>>  			*pos += block_size;
>>  			poff += block_size;
>> @@ -142,7 +180,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>
>>  		/* truncate len if we find any trailing uptodate block(s) */
>>  		for ( ; i <= last; i++) {
>> -			if (test_bit(i, iop->uptodate)) {
>> +			if (iop_test_block_uptodate(folio, i)) {
>>  				plen -= (last - i + 1) * block_size;
>>  				last = i - 1;
>>  				break;
>> @@ -450,7 +488,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>>  	last = (from + count - 1) >> inode->i_blkbits;
>>
>>  	for (i = first; i <= last; i++)
>> -		if (!test_bit(i, iop->uptodate))
>> +		if (!iop_test_block_uptodate(folio, i))
>>  			return false;
>>  	return true;
>>  }
>> @@ -1634,7 +1672,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  	 * invalid, grab a new one.
>>  	 */
>>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> -		if (iop && !test_bit(i, iop->uptodate))
>> +		if (iop && !iop_test_block_uptodate(folio, i))
>>  			continue;
>>
>>  		error = wpc->ops->map_blocks(wpc, inode, pos);
>> --
>> 2.39.2
>>
