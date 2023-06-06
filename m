Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D897233F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 02:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjFFAIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 20:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFFAIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:08:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61457FD;
        Mon,  5 Jun 2023 17:08:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b04706c85fso51385985ad.0;
        Mon, 05 Jun 2023 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686010116; x=1688602116;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Z4NiJkmAX/LjPpbsrqunZogv+TZiIqdTsr1xJifim8=;
        b=IPwRFrv5vTl9PVbKR1yPr7DqaTDTqJJLNOLZwbYx28sFYN8DP3S+zzs/eqLHnP/sRj
         EbOrCX7R82bqfitdQDSvGRZBz2ggDo4JYu5+BmNVBjkii4C7i0M/9ka133JyvtTzasiO
         9FQlNtuabrdi/dYt0jdMytiWRwfzolXpT4JP1D3Q6PuiSDChSg91IhMsFDvD5O0mBlxR
         NHNV/LbXqxb26Ho7HD8eFpzRRHvoLlrpZnYwetD6omgAyKxtcbKHjaXClPpQJ3pLBQci
         uzwgftV8AMMo4sAxknPtubztJAaECv2CtpbesCCh06lXE8noaUmMf8387CILk5HlfqeQ
         zaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686010116; x=1688602116;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Z4NiJkmAX/LjPpbsrqunZogv+TZiIqdTsr1xJifim8=;
        b=FCDiUUTlHB3irqekwjmIWie41pdgmtafUXvNXLis/uDCzy08lDcQGxJiQucwsFjske
         8n8+R5firgHuytso258ThFXlbudCMFIjii1nuovyLqQWkFJBRgOupnpXtO4o61zQaa12
         XFd2J2Rogh2E7mDO6n6dzjiSbRAhmjq9sD35jkO7yoyYOzzuXxkboTfL+0QD+gdWjBGl
         wXSeK4AVzyNmPKOhJMdulRjTgnMV5nc9DTIjHnsr06a4pnN+yj+d0j3/0sw+3shs8bIy
         qlCcalAeUm4S3vfY0uavd5dhtsO7/nkJczncdkwIQhpuTX6E/KJYSGvrdV0wUsgiUkNN
         Teog==
X-Gm-Message-State: AC+VfDyfeit/laWdruD5ABfENo3/uQyANlemw79ntto6YxnHo8zOYa0S
        boepJaGq2pKv475fkWlWPhA=
X-Google-Smtp-Source: ACHHUZ537PfXLeITJWmftBDFdnUW7qWUDn32WEfbsLO4j4v1Kecnrhd0Sb87vca2Ny7vdfUyFEnh1A==
X-Received: by 2002:a17:903:234c:b0:1ae:5f7e:c117 with SMTP id c12-20020a170903234c00b001ae5f7ec117mr592408plh.60.1686010115618;
        Mon, 05 Jun 2023 17:08:35 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001a96a6877fdsm7199665pls.3.2023.06.05.17.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:08:35 -0700 (PDT)
Date:   Tue, 06 Jun 2023 05:38:30 +0530
Message-Id: <87h6rljvup.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv7 6/6] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <20230605231014.GI1325469@frogsfrogsfrogs>
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

> On Mon, Jun 05, 2023 at 04:25:06PM +0530, Ritesh Harjani (IBM) wrote:
>> When filesystem blocksize is less than folio size (either with
>> mapping_large_folio_support() or with blocksize < pagesize) and when the
>> folio is uptodate in pagecache, then even a byte write can cause
>> an entire folio to be written to disk during writeback. This happens
>> because we currently don't have a mechanism to track per-block dirty
>> state within struct iomap_page. We currently only track uptodate state.
>>
>> This patch implements support for tracking per-block dirty state in
>> iomap_page->state bitmap. This should help improve the filesystem write
>> performance and help reduce write amplification.
>>
>> Performance testing of below fio workload reveals ~16x performance
>> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
>> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
>>
>> 1. <test_randwrite.fio>
>> [global]
>> 	ioengine=psync
>> 	rw=randwrite
>> 	overwrite=1
>> 	pre_read=1
>> 	direct=0
>> 	bs=4k
>> 	size=1G
>> 	dir=./
>> 	numjobs=8
>> 	fdatasync=1
>> 	runtime=60
>> 	iodepth=64
>> 	group_reporting=1
>>
>> [fio-run]
>>
>> 2. Also our internal performance team reported that this patch improves
>>    their database workload performance by around ~83% (with XFS on Power)
>>
>> Reported-by: Aravinda Herle <araherle@in.ibm.com>
>> Reported-by: Brian Foster <bfoster@redhat.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/gfs2/aops.c         |   2 +-
>>  fs/iomap/buffered-io.c | 120 +++++++++++++++++++++++++++++++++++++++--
>>  fs/xfs/xfs_aops.c      |   2 +-
>>  fs/zonefs/file.c       |   2 +-
>>  include/linux/iomap.h  |   1 +
>>  5 files changed, 120 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
>> index a5f4be6b9213..75efec3c3b71 100644
>> --- a/fs/gfs2/aops.c
>> +++ b/fs/gfs2/aops.c
>> @@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aops = {
>>  	.writepages = gfs2_writepages,
>>  	.read_folio = gfs2_read_folio,
>>  	.readahead = gfs2_readahead,
>> -	.dirty_folio = filemap_dirty_folio,
>> +	.dirty_folio = iomap_dirty_folio,
>>  	.release_folio = iomap_release_folio,
>>  	.invalidate_folio = iomap_invalidate_folio,
>>  	.bmap = gfs2_bmap,
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 2a97d73edb96..e7d114b5b918 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -85,6 +85,63 @@ static void iomap_iop_set_range_uptodate(struct inode *inode,
>>  		folio_mark_uptodate(folio);
>>  }
>>
>> +static bool iop_test_block_dirty(struct folio *folio, int block)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	struct inode *inode = folio->mapping->host;
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +
>> +	return test_bit(block + blks_per_folio, iop->state);
>> +}
>> +
>> +static void iop_set_range_dirty(struct inode *inode, struct folio *folio,
>> +				size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iop->state_lock, flags);
>> +	bitmap_set(iop->state, first_blk + blks_per_folio, nr_blks);
>> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>> +}
>> +
>> +static void iomap_iop_set_range_dirty(struct inode *inode, struct folio *folio,
>> +				size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +	if (iop)
>> +		iop_set_range_dirty(inode, folio, off, len);
>> +}
>> +
>> +static void iop_clear_range_dirty(struct inode *inode, struct folio *folio,
>> +				  size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> +	unsigned int first_blk = off >> inode->i_blkbits;
>> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&iop->state_lock, flags);
>> +	bitmap_clear(iop->state, first_blk + blks_per_folio, nr_blks);
>> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>> +}
>> +
>> +static void iomap_iop_clear_range_dirty(struct inode *inode,
>> +				struct folio *folio, size_t off, size_t len)
>> +{
>> +	struct iomap_page *iop = to_iomap_page(folio);
>> +
>> +	if (iop)
>> +		iop_clear_range_dirty(inode, folio, off, len);
>> +}
>
> Same question as patch 3 -- I was under the impression that
> iomap_clear_range_dirty would take a folio/off/len, and if an iop is
> necessary, then it would call iomap_iop_clear_range_dirty with the
> iop/folio/off/len?
>
>

Sorry a lot of renaming of the functions happened. I started with the
thought that anything iop related should start with iomap_iop_ prefx.
But what you are suggesting make more sense.

For e.g. we have iomap_set_range_uptodate() which has both cases iop and
!iop. So for iop case it would then be iomap_iop_set_range_uptodate().
And then we should do the same thing for iomap_set_range_dirty part as well.

Sure. This makes it more clear.

Also I agree we can directly pass iop to iomap_iop_** functions.
I was assuming we need not pass it because it can be extracted easily. But as we
are anyways extracting it in the caller, it make sense to just pass it
in the function arguments itself.

>> +
>>  static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>>  				struct folio *folio, unsigned int flags)
>>  {
>> @@ -100,12 +157,20 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>>  	else
>>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>>
>> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
>> +	/*
>> +	 * iop->state tracks two sets of state flags when the
>> +	 * filesystem block size is smaller than the folio size.
>> +	 * The first state tracks per-block uptodate and the
>> +	 * second tracks per-block dirty state.
>> +	 */
>> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
>>  		      gfp);
>>  	if (iop) {
>>  		spin_lock_init(&iop->state_lock);
>>  		if (folio_test_uptodate(folio))
>> -			bitmap_fill(iop->state, nr_blocks);
>> +			bitmap_set(iop->state, 0, nr_blocks);
>> +		if (folio_test_dirty(folio))
>> +			bitmap_set(iop->state, nr_blocks, nr_blocks);
>>  		folio_attach_private(folio, iop);
>>  	}
>>  	return iop;
>> @@ -533,6 +598,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>>  }
>>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
>>
>> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
>> +{
>> +	struct inode *inode = mapping->host;
>> +	size_t len = folio_size(folio);
>> +
>> +	iomap_iop_alloc(inode, folio, 0);
>
> Why do we need to allocate an iop if there isn't already one?  Doesn't
> it suffice to let filemap_dirty_folio even if there are multiple blocks
> per folio?  I understand why __iomap_write_end would do that for a
> sub-folio write, but not here where we always going to mark the whole
> folio dirty...?
>
> Oh, is it because everything else after this (write_end,
> write_delalloc_punch, etc) might need to undo some of the work, hence
> you want to have the iop allocated before we dirty the folio, no matter
> which path lead to the folio getting dirtied?
>

Frankly speaking allocating an iop is always the right thing to do here.
Not allocating an iop for special cases like all bits are dirty is an
optimization case for lazy allocation during the writeback time.

We discussed other reasons as well for not doing this for mmapped writes
in v5 [1]. And I suggested that we can look into such optimizations as a
seperate series after this.

[1]: https://lore.kernel.org/linux-xfs/87ttw5ugse.fsf@doe.com/

-ritesh


>> +	iomap_iop_set_range_dirty(inode, folio, 0, len);
>> +	return filemap_dirty_folio(mapping, folio);
>> +}
>> +EXPORT_SYMBOL_GPL(iomap_dirty_folio);
>> +
>>  static void
>>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>>  {
>> @@ -739,6 +815,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>>  		return 0;
>>  	iomap_iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos),
>>  				     len);
>> +	iomap_iop_set_range_dirty(inode, folio, offset_in_folio(folio, pos),
>> +				  copied);
>
> ...and hence you don't want to be allocating it now?
>
> --D
>
>>  	filemap_dirty_folio(inode->i_mapping, folio);
>>  	return copied;
>>  }
>> @@ -908,6 +986,10 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>>  		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>>  {
>>  	int ret = 0;
>> +	struct iomap_page *iop;
>> +	unsigned int first_blk, last_blk, i;
>> +	loff_t last_byte;
>> +	u8 blkbits = inode->i_blkbits;
>>
>>  	if (!folio_test_dirty(folio))
>>  		return ret;
>> @@ -919,6 +1001,29 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>>  		if (ret)
>>  			goto out;
>>  	}
>> +	/*
>> +	 * When we have per-block dirty tracking, there can be
>> +	 * blocks within a folio which are marked uptodate
>> +	 * but not dirty. In that case it is necessary to punch
>> +	 * out such blocks to avoid leaking any delalloc blocks.
>> +	 */
>> +	iop = to_iomap_page(folio);
>> +	if (!iop)
>> +		goto skip_iop_punch;
>> +
>> +	last_byte = min_t(loff_t, end_byte - 1,
>> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
>> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
>> +	for (i = first_blk; i <= last_blk; i++) {
>> +		if (!iop_test_block_dirty(folio, i)) {
>> +			ret = punch(inode, i << blkbits, 1 << blkbits);
>> +			if (ret)
>> +				goto out;
>> +		}
>> +	}
>> +
>> +skip_iop_punch:
>>  	/*
>>  	 * Make sure the next punch start is correctly bound to
>>  	 * the end of this data range, not the end of the folio.
>> @@ -1652,7 +1757,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  		struct writeback_control *wbc, struct inode *inode,
>>  		struct folio *folio, u64 end_pos)
>>  {
>> -	struct iomap_page *iop = iomap_iop_alloc(inode, folio, 0);
>> +	struct iomap_page *iop = to_iomap_page(folio);
>>  	struct iomap_ioend *ioend, *next;
>>  	unsigned len = i_blocksize(inode);
>>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
>> @@ -1660,6 +1765,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  	int error = 0, count = 0, i;
>>  	LIST_HEAD(submit_list);
>>
>> +	if (!iop && nblocks > 1) {
>> +		iop = iomap_iop_alloc(inode, folio, 0);
>> +		iomap_iop_set_range_dirty(inode, folio, 0, folio_size(folio));
>> +	}
>> +
>>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>>
>>  	/*
>> @@ -1668,7 +1778,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  	 * invalid, grab a new one.
>>  	 */
>>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> -		if (iop && !iop_test_block_uptodate(folio, i))
>> +		if (iop && !iop_test_block_dirty(folio, i))
>>  			continue;
>>
>>  		error = wpc->ops->map_blocks(wpc, inode, pos);
>> @@ -1712,6 +1822,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  		}
>>  	}
>>
>> +	iomap_iop_clear_range_dirty(inode, folio, 0,
>> +				    end_pos - folio_pos(folio));
>>  	folio_start_writeback(folio);
>>  	folio_unlock(folio);
>>
>> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
>> index 2ef78aa1d3f6..77c7332ae197 100644
>> --- a/fs/xfs/xfs_aops.c
>> +++ b/fs/xfs/xfs_aops.c
>> @@ -578,7 +578,7 @@ const struct address_space_operations xfs_address_space_operations = {
>>  	.read_folio		= xfs_vm_read_folio,
>>  	.readahead		= xfs_vm_readahead,
>>  	.writepages		= xfs_vm_writepages,
>> -	.dirty_folio		= filemap_dirty_folio,
>> +	.dirty_folio		= iomap_dirty_folio,
>>  	.release_folio		= iomap_release_folio,
>>  	.invalidate_folio	= iomap_invalidate_folio,
>>  	.bmap			= xfs_vm_bmap,
>> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
>> index 132f01d3461f..e508c8e97372 100644
>> --- a/fs/zonefs/file.c
>> +++ b/fs/zonefs/file.c
>> @@ -175,7 +175,7 @@ const struct address_space_operations zonefs_file_aops = {
>>  	.read_folio		= zonefs_read_folio,
>>  	.readahead		= zonefs_readahead,
>>  	.writepages		= zonefs_writepages,
>> -	.dirty_folio		= filemap_dirty_folio,
>> +	.dirty_folio		= iomap_dirty_folio,
>>  	.release_folio		= iomap_release_folio,
>>  	.invalidate_folio	= iomap_invalidate_folio,
>>  	.migrate_folio		= filemap_migrate_folio,
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index e2b836c2e119..eb9335c46bf3 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -264,6 +264,7 @@ bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
>>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
>>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>>  		const struct iomap_ops *ops);
>>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>> --
>> 2.40.1
>>
