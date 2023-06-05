Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C67233C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjFEXvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 19:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFEXvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:51:40 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089BEC;
        Mon,  5 Jun 2023 16:51:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39a3f26688bso4594580b6e.2;
        Mon, 05 Jun 2023 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686009098; x=1688601098;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+eM4C2ENsNn3TvCFtZ2fiv12+aW4HWx9v/Lyj9FfzR0=;
        b=V+q6U5+TKzgJS/x7kHT7YFqqCqH2wjQwgo99QRCPHaOySKpABKQE3ZOa80c4HRGM1v
         jcv7oOKS5JQmguZsVom0sj1bEzqIAARL8/XLYe+NZ4nc/Fsob4MbCpGEvVHa0b4Lgu1n
         JdPC7zOra4yim37gNuCI0Bh4d/jb21H7yNuxDCK6B7gsHj3fEsPl9zgYM/IiupD9ug/m
         j4pwX5NaISYOvbkwtsKWU9ERCNxpGmcZ7kHwJxoxl3tfyZR+tEvO0mfc9PHB+0RXGMlG
         5VmwaeWtKFQNZeNHpfuxfrepCNzi7O6dPMZkNy3kqE8DWVZg1L1RbhVqnWUG/MLeL43i
         5LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009098; x=1688601098;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eM4C2ENsNn3TvCFtZ2fiv12+aW4HWx9v/Lyj9FfzR0=;
        b=Z9EbFkWgS2Ze3aRz+CrBmp2bNgPojLDUakDtToIkAWSKVyz2zrMgm9vjkc9F2/vzQx
         5FXyTHSnYFl0CgUwcbgG4bnap0n5OmpVHSPoicJ1X/4zxrvAst9iire2ZoIn86yzGmFK
         DZwh7CtQLALgLD+sQcsOBq8zgsWi9OM4KSmBHM9pOAfFTUEWs//2ryMqWsilS+6sQBEh
         v2ouzC7gaSivUiyPI9VZjoRxTmIYg25+sQSJI8WFGGHHzdo+LVNGAuBF3RvW52quJCV7
         EOvfe0s++9Uae7aqJu1EtXJT+zoPKGuqkXn0y4hzuo1PwA4h3V9IPyEy4O810tQxU4xa
         oS+Q==
X-Gm-Message-State: AC+VfDzvfsvzRL622LTvv6vxt+NMU8C1/LOnvR/jmQQQfClAO1UJ81BE
        AVq7BixKyISVyRAzzOCcxEQ=
X-Google-Smtp-Source: ACHHUZ5XmtCZE4lCG8f7CJeOdmFaH9SX2VOJ2AZv6gaipaicpvzOv0xdxrlS/oHxsKFJdCWz4e3ECw==
X-Received: by 2002:aca:1903:0:b0:39b:a87f:91e8 with SMTP id l3-20020aca1903000000b0039ba87f91e8mr123409oii.45.1686009097846;
        Mon, 05 Jun 2023 16:51:37 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902dac500b001acae9734c0sm7112772plx.266.2023.06.05.16.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:51:37 -0700 (PDT)
Date:   Tue, 06 Jun 2023 05:21:32 +0530
Message-Id: <87jzwhjwmz.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
In-Reply-To: <20230605225434.GF1325469@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Mon, Jun 05, 2023 at 04:25:03PM +0530, Ritesh Harjani (IBM) wrote:
>> We would eventually use iomap_iop_** function naming by the rest of the
>> buffered-io iomap code. This patch update function arguments and naming
>> from iomap_set_range_uptodate() -> iomap_iop_set_range_uptodate().
>> iop_set_range_uptodate() then becomes an accessor function used by
>> iomap_iop_** functions.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/buffered-io.c | 111 +++++++++++++++++++++++------------------
>>  1 file changed, 63 insertions(+), 48 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 6fffda355c45..136f57ccd0be 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -24,14 +24,14 @@
>>  #define IOEND_BATCH_SIZE	4096
>>
>>  /*
>> - * Structure allocated for each folio when block size < folio size
>> - * to track sub-folio uptodate status and I/O completions.
>> + * Structure allocated for each folio to track per-block uptodate state
>> + * and I/O completions.
>>   */
>>  struct iomap_page {
>>  	atomic_t		read_bytes_pending;
>>  	atomic_t		write_bytes_pending;
>> -	spinlock_t		uptodate_lock;
>> -	unsigned long		uptodate[];
>> +	spinlock_t		state_lock;
>> +	unsigned long		state[];
>>  };
>>
>>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
>> @@ -43,6 +43,48 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>>
>>  static struct bio_set iomap_ioend_bioset;
>>
>> +static bool iop_test_full_uptodate(struct folio *folio)
>
> Same comment as Andreas, I think this works better with 'fully', e.g.
>
> iop_test_fully_uptodate()
>
> Why you don't pass the iomap_page directly into this function?  Doesn't
> that eliminate the need for iomap_iop_free to keep folio->private set
> until the very end?
>
> static inline bool
> iomap_iop_is_fully_uptodate(const struct iomap_page *iop,
> 			    const struct folio *folio)
>
> Same sort of thing for the second function -- we already extracted
> folio->private and checked it wasn't null, so we don't need to do that
> again.
>
> static inline bool
> iomap_io_is_block_uptodate(const struct iomap_page *iop,
> 			   const struct folio *folio,
> 			   unsigned int block)
>
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	struct inode *inode = folio->mapping->host;
>> +
>> +	return bitmap_full(iop->state, i_blocks_per_folio(inode, folio));
>> +}
>> +
>> +static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +	return test_bit(block, iop->state);
>> +}
>> +
>> +static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
>> +				   size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iop->state_lock, flags);
>> +	bitmap_set(iop->state, first_blk, nr_blks);
>> +	if (iop_test_full_uptodate(folio))
>> +		folio_mark_uptodate(folio);
>> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>> +}
>> +
>> +static void iomap_iop_set_range_uptodate(struct inode *inode,
>
> I don't understand why iomap_set_range_uptodate is now
> iomap_iop_set_range_uptodate; it doesn't take an iomap_page object as an
> argument...?
>
> I thought I understood that iomap_FOO operates on a folio and a range,
> whereas iomap_iop_FOO operates on sub-blocks within a folio?  And that
> you were renaming the iop_* functions to iomap_iop_*?
>
> I'm also not sure why iop_set_range_uptodate needs to be passed the
> struct inode; can't it extract that from folio->mapping->host, like
> current upstream does?
>

So, I do have a confusion in __folio_mark_dirty() function...

i.e. __folio_mark_dirty checks whether folio->mapping is not NULL.
That means for marking range of blocks dirty within iop from
->dirty_folio(), we can't use folio->mapping->host is it?
We have to use inode from mapping->host (mapping is passed as a
parameter in ->dirty_folio).

I tried looking into the history of this, but I couldn't find any.
This is also the reason I thought we would need to pass an inode for the
iop_set_range_dirty() function (because it is also called from
->dirty_folio -> iomap_dirty_folio()) and to keep it consistent, I kept
inode argument for iop_**_uptodate functions as well.

Thoughts please?

<some code snippet>
====================

iomap_dirty_folio -> filemap_dirty_folio-> __folio_mark_dirty()

void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
			     int warn)
{
	unsigned long flags;

	xa_lock_irqsave(&mapping->i_pages, flags);
	if (folio->mapping) {	/* Race with truncate? */
		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
		folio_account_dirtied(folio, mapping);
		__xa_set_mark(&mapping->i_pages, folio_index(folio),
				PAGECACHE_TAG_DIRTY);
	}
	xa_unlock_irqrestore(&mapping->i_pages, flags);
}

-ritesh



> Generally I don't understand why this part of the patch is needed at
> all.  Wasn't the point merely to rename uptodate_* to state_* and
> introduce the iomap_iop_test_*_uptodate helpers?
>
> --D
>
>> +		struct folio *folio, size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +	if (iop)
>> +		iop_set_range_uptodate(inode, folio, off, len);
>> +	else
>> +		folio_mark_uptodate(folio);
>> +}
>> +
>>  static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>>  				struct folio *folio, unsigned int flags)
>>  {
>> @@ -58,12 +100,12 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
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
>> +			bitmap_fill(iop->state, nr_blocks);
>>  		folio_attach_private(folio, iop);
>>  	}
>>  	return iop;
>> @@ -72,14 +114,12 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>>  static void iomap_iop_free(struct folio *folio)
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
>> +	WARN_ON_ONCE(iop_test_full_uptodate(folio) !=
>>  			folio_test_uptodate(folio));
>>  	folio_detach_private(folio);
>>  	kfree(iop);
>> @@ -111,7 +151,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>
>>  		/* move forward for each leading block marked uptodate */
>>  		for (i = first; i <= last; i++) {
>> -			if (!test_bit(i, iop->uptodate))
>> +			if (!iop_test_block_uptodate(folio, i))
>>  				break;
>>  			*pos += block_size;
>>  			poff += block_size;
>> @@ -121,7 +161,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>
>>  		/* truncate len if we find any trailing uptodate block(s) */
>>  		for ( ; i <= last; i++) {
>> -			if (test_bit(i, iop->uptodate)) {
>> +			if (iop_test_block_uptodate(folio, i)) {
>>  				plen -= (last - i + 1) * block_size;
>>  				last = i - 1;
>>  				break;
>> @@ -145,30 +185,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>>  	*lenp = plen;
>>  }
>>
>> -static void iomap_iop_set_range_uptodate(struct folio *folio,
>> -		struct iomap_page *iop, size_t off, size_t len)
>> -{
>> -	struct inode *inode = folio->mapping->host;
>> -	unsigned first = off >> inode->i_blkbits;
>> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
>> -	unsigned long flags;
>> -
>> -	spin_lock_irqsave(&iop->uptodate_lock, flags);
>> -	bitmap_set(iop->uptodate, first, last - first + 1);
>> -	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
>> -		folio_mark_uptodate(folio);
>> -	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>> -}
>> -
>> -static void iomap_set_range_uptodate(struct folio *folio,
>> -		struct iomap_page *iop, size_t off, size_t len)
>> -{
>> -	if (iop)
>> -		iomap_iop_set_range_uptodate(folio, iop, off, len);
>> -	else
>> -		folio_mark_uptodate(folio);
>> -}
>> -
>>  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>>  		size_t len, int error)
>>  {
>> @@ -178,7 +194,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>>  		folio_clear_uptodate(folio);
>>  		folio_set_error(folio);
>>  	} else {
>> -		iomap_set_range_uptodate(folio, iop, offset, len);
>> +		iomap_iop_set_range_uptodate(folio->mapping->host, folio,
>> +					     offset, len);
>>  	}
>>
>>  	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
>> @@ -214,7 +231,6 @@ struct iomap_readpage_ctx {
>>  static int iomap_read_inline_data(const struct iomap_iter *iter,
>>  		struct folio *folio)
>>  {
>> -	struct iomap_page *iop;
>>  	const struct iomap *iomap = iomap_iter_srcmap(iter);
>>  	size_t size = i_size_read(iter->inode) - iomap->offset;
>>  	size_t poff = offset_in_page(iomap->offset);
>> @@ -232,15 +248,14 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>>  	if (WARN_ON_ONCE(size > iomap->length))
>>  		return -EIO;
>>  	if (offset > 0)
>> -		iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
>> -	else
>> -		iop = to_iomap_page(folio);
>> +		iomap_iop_alloc(iter->inode, folio, iter->flags);
>>
>>  	addr = kmap_local_folio(folio, offset);
>>  	memcpy(addr, iomap->inline_data, size);
>>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
>>  	kunmap_local(addr);
>> -	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
>> +	iomap_iop_set_range_uptodate(iter->inode, folio, offset,
>> +				     PAGE_SIZE - poff);
>>  	return 0;
>>  }
>>
>> @@ -277,7 +292,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>>
>>  	if (iomap_block_needs_zeroing(iter, pos)) {
>>  		folio_zero_range(folio, poff, plen);
>> -		iomap_set_range_uptodate(folio, iop, poff, plen);
>> +		iomap_iop_set_range_uptodate(iter->inode, folio, poff, plen);
>>  		goto done;
>>  	}
>>
>> @@ -452,7 +467,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>>  	last = (from + count - 1) >> inode->i_blkbits;
>>
>>  	for (i = first; i <= last; i++)
>> -		if (!test_bit(i, iop->uptodate))
>> +		if (!iop_test_block_uptodate(folio, i))
>>  			return false;
>>  	return true;
>>  }
>> @@ -591,7 +606,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>  			if (status)
>>  				return status;
>>  		}
>> -		iomap_set_range_uptodate(folio, iop, poff, plen);
>> +		iomap_iop_set_range_uptodate(iter->inode, folio, poff, plen);
>>  	} while ((block_start += plen) < block_end);
>>
>>  	return 0;
>> @@ -698,7 +713,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>>  static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  		size_t copied, struct folio *folio)
>>  {
>> -	struct iomap_page *iop = to_iomap_page(folio);
>>  	flush_dcache_folio(folio);
>>
>>  	/*
>> @@ -714,7 +728,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  	 */
>>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>>  		return 0;
>> -	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
>> +	iomap_iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos),
>> +				     len);
>>  	filemap_dirty_folio(inode->i_mapping, folio);
>>  	return copied;
>>  }
>> @@ -1630,7 +1645,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  	 * invalid, grab a new one.
>>  	 */
>>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> -		if (iop && !test_bit(i, iop->uptodate))
>> +		if (iop && !iop_test_block_uptodate(folio, i))
>>  			continue;
>>
>>  		error = wpc->ops->map_blocks(wpc, inode, pos);
>> --
>> 2.40.1
>>
