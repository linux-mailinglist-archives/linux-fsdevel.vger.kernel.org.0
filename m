Return-Path: <linux-fsdevel+bounces-4885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5F805A13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD4B21174
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C3C7ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuSMCuZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7730F2;
	Tue,  5 Dec 2023 07:22:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2866e4ac34bso3251022a91.1;
        Tue, 05 Dec 2023 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701789756; x=1702394556; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HukrsINileVXmL1T7otcd0/SrbJD9FVWJcl4CEYOpoA=;
        b=TuSMCuZlrTr1wTEBXrZPfSApI07LyduZPnhO1aeSES8DXvp+R64+zl65bG4mOgFpLo
         CATF/eztG7ek5JbomHn3F49mEHf/NawvlkkTYnUOwesGGwb9ZHeaF/yUkEqx3W2K4Az3
         cBC6uWkkm+zvDwqwIBzOn+TX0rbiSMMqpB7OODy4nP0SZnk0eMq/GFcbqDo25tVOWt48
         uNSFH6RAHcqdE3lRrM27kgEEW8LQMBOKocMLEoWPuJJ43dEsk7cs/Qb1wORoD2600+Gf
         pdgKHKeEdcxqGfQksp/tLuKyHF9uTxQmxZl9eGfA2Iq//gdB+1C5e2TS0/5bOKZ21B/P
         EmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701789756; x=1702394556;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HukrsINileVXmL1T7otcd0/SrbJD9FVWJcl4CEYOpoA=;
        b=Jlz6aknNx8CO9wJy8+k74k9n4k9o8fd2VNooE64Mlh0GMM2KNbe6hHWLflIMuFUiFN
         59DOwma75B+Q9hacOSAMA3JaOmYWNtjBntxoVC42E19mSb0NuPbaOjIeDKt8ZX5B+pgv
         5tlrlpkpX2D9CM41D2DFBXoFdi4PNwRH2TenEorYGkHhylc5yMsE0yiowqOtDCq1Q5yO
         aoMbDPTrW/BQdFIBEXDTy+IBGMOFbcRluTzok7EBFNTfRm/xYExFJcG0Y/WCCvIPVF6F
         3anP8RekEjrPp7SJVtc+NMNSfxTnF4gdJRH83G9N1633vrhjbo9M3Nvks9Oj4/oQMYaf
         duZg==
X-Gm-Message-State: AOJu0YxZCM09C6sXlH3fj+y46vnoyN+G5fLEDhclLF1Kf64ZKyGbYwnD
	Vr6KvSdO0r2r093JV0xLmMG1YzsbEnU=
X-Google-Smtp-Source: AGHT+IETw8PyRK2JHsrlQkCoe6QoS72yn0kzxlfN3KmHUd+NjE2gJAgjg4Du014/2FCtuHGeIuhSsQ==
X-Received: by 2002:a17:90b:4b04:b0:286:6cc0:cacb with SMTP id lx4-20020a17090b4b0400b002866cc0cacbmr1287655pjb.66.1701789756271;
        Tue, 05 Dec 2023 07:22:36 -0800 (PST)
Received: from dw-tp ([171.76.86.224])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b002609cadc56esm4939002pje.11.2023.12.05.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:22:35 -0800 (PST)
Date: Tue, 05 Dec 2023 20:52:26 +0530
Message-Id: <87fs0gisi5.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <ZWpntZXm32kyfX7M@dread.disaster.area>
X-Spam-Level: *
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> 
>> > Christoph Hellwig <hch@infradead.org> writes:
>> >
>> >> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
>> >>> writeback bit set. XFS plays the revalidation sequence counter games
>> >>> because of this so we'd have to do something similar for ext2. Not that I'd
>> >>> care as much about ext2 writeback performance but it should not be that
>> >>> hard and we'll definitely need some similar solution for ext4 anyway. Can
>> >>> you give that a try (as a followup "performance improvement" patch).
>> >>
>> >> Darrick has mentioned that he is looking into lifting more of the
>> >> validation sequence counter validation into iomap.
>> >>
>> >> In the meantime I have a series here that at least maps multiple blocks
>> >> inside a folio in a single go, which might be worth trying with ext2 as
>> >> well:
>> >>
>> >> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iomap-map-multiple-blocks
>> >
>> > Sure, thanks for providing details. I will check this.
>> >
>> 
>> So I took a look at this. Here is what I think -
>> So this is useful of-course when we have a large folio. Because
>> otherwise it's just one block at a time for each folio. This is not a
>> problem once FS buffered-io handling code moves to iomap (because we
>> can then enable large folio support to it).
>> 
>> However, this would still require us to pass a folio to ->map_blocks
>> call to determine the size of the folio (which I am not saying can't be
>> done but just stating my observations here).
>> 
>> Now coming to implementing validation seq check. I am hoping, it should
>> be straight forward at least for ext2, because it mostly just have to
>> protect against truncate operation (which can change the block mapping)...
>> 
>> ...ok so here is the PoC for seq counter check for ext2. Next let me
>> try to see if we can lift this up from the FS side to iomap - 
>> 
>> 
>> From 86b7bdf79107c3d0a4f37583121d7c136db1bc5c Mon Sep 17 00:00:00 2001
>> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
>> Subject: [PATCH] ext2: Implement seq check for mapping multiblocks in ->map_blocks
>> 
>> This implements inode block seq counter (ib_seq) which helps in validating 
>> whether the cached wpc (struct iomap_writepage_ctx) still has the valid 
>> entries or not. Block mapping can get changed say due to a racing truncate. 
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext2/balloc.c |  1 +
>>  fs/ext2/ext2.h   |  6 ++++++
>>  fs/ext2/inode.c  | 51 +++++++++++++++++++++++++++++++++++++++++++-----
>>  fs/ext2/super.c  |  2 +-
>>  4 files changed, 54 insertions(+), 6 deletions(-)
>> 
>> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
>> index e124f3d709b2..e97040194da4 100644
>> --- a/fs/ext2/balloc.c
>> +++ b/fs/ext2/balloc.c
>> @@ -495,6 +495,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
>>  	}
>>  
>>  	ext2_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
>> +	ext2_inc_ib_seq(EXT2_I(inode));
>>  
>>  do_more:
>>  	overflow = 0;
>> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
>> index 677a9ad45dcb..882c14d20183 100644
>> --- a/fs/ext2/ext2.h
>> +++ b/fs/ext2/ext2.h
>> @@ -663,6 +663,7 @@ struct ext2_inode_info {
>>  	struct rw_semaphore xattr_sem;
>>  #endif
>>  	rwlock_t i_meta_lock;
>> +	unsigned int ib_seq;
>>  
>>  	/*
>>  	 * truncate_mutex is for serialising ext2_truncate() against
>> @@ -698,6 +699,11 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
>>  	return container_of(inode, struct ext2_inode_info, vfs_inode);
>>  }
>>  
>> +static inline void ext2_inc_ib_seq(struct ext2_inode_info *ei)
>> +{
>> +	WRITE_ONCE(ei->ib_seq, READ_ONCE(ei->ib_seq) + 1);
>> +}
>> +
>>  /* balloc.c */
>>  extern int ext2_bg_has_super(struct super_block *sb, int group);
>>  extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
>> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
>> index f4e0b9a93095..a5490d641c26 100644
>> --- a/fs/ext2/inode.c
>> +++ b/fs/ext2/inode.c
>> @@ -406,6 +406,8 @@ static int ext2_alloc_blocks(struct inode *inode,
>>  	ext2_fsblk_t current_block = 0;
>>  	int ret = 0;
>>  
>> +	ext2_inc_ib_seq(EXT2_I(inode));
>> +
>>  	/*
>>  	 * Here we try to allocate the requested multiple blocks at once,
>>  	 * on a best-effort basis.
>> @@ -966,14 +968,53 @@ ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
>>  	return mpage_writepages(mapping, wbc, ext2_get_block);
>>  }
>>  
>> +struct ext2_writepage_ctx {
>> +	struct iomap_writepage_ctx ctx;
>> +	unsigned int		ib_seq;
>> +};
>
> Why copy this structure from XFS? The iomap held in ctx->iomap now
> has a 'u64 validity_cookie;' which is expressly intended to be used
> for holding this information.
>
> And then this becomes:
>

Right. Thanks for pointing out.

>> +static inline
>> +struct ext2_writepage_ctx *EXT2_WPC(struct iomap_writepage_ctx *ctx)
>> +{
>> +	return container_of(ctx, struct ext2_writepage_ctx, ctx);
>> +}
>> +
>> +static bool ext2_imap_valid(struct iomap_writepage_ctx *wpc, struct inode *inode,
>> +			    loff_t offset)
>> +{
>> +	if (offset < wpc->iomap.offset ||
>> +	    offset >= wpc->iomap.offset + wpc->iomap.length)
>> +		return false;
>> +
>> +	if (EXT2_WPC(wpc)->ib_seq != READ_ONCE(EXT2_I(inode)->ib_seq))
>> +		return false;
>
> 	if (wpc->iomap->validity_cookie != EXT2_I(inode)->ib_seq)
> 		return false;
>
>> +
>> +	return true;
>> +}
>> +
>>  static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
>>  				 struct inode *inode, loff_t offset)
>>  {
>> -	if (offset >= wpc->iomap.offset &&
>> -	    offset < wpc->iomap.offset + wpc->iomap.length)
>> +	loff_t maxblocks = (loff_t)INT_MAX;
>> +	u8 blkbits = inode->i_blkbits;
>> +	u32 bno;
>> +	bool new, boundary;
>> +	int ret;
>> +
>> +	if (ext2_imap_valid(wpc, inode, offset))
>>  		return 0;
>>  
>> -	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
>> +	EXT2_WPC(wpc)->ib_seq = READ_ONCE(EXT2_I(inode)->ib_seq);
>> +
>> +	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
>> +			      &bno, &new, &boundary, 0);
>
> This is incorrectly ordered. ext2_get_blocks() bumps ib_seq when it
> does allocation, so the newly stored EXT2_WPC(wpc)->ib_seq is
> immediately staled and the very next call to ext2_imap_valid() will
> fail, causing a new iomap to be mapped even when not necessary.

In case of ext2 here, the allocation happens at the write time itself
for buffered writes. So what we are essentially doing here (at the time
of writeback) is querying ->get_blocks(..., create=0) and passing those
no. of blocks (ret) further. So it is unlikely that the block
allocations will happen right after we sample ib_seq
(unless we race with truncate).

For mmapped writes, we expect to find a hole and in case of a hole at
the offset, we only pass & cache 1 block in wpc. 

For mmapped writes case since we go and allocate 1 block, so I agree
that the ib_seq will change right after in ->get_blocks. But since in
this case we only alloc and cache 1 block, we anyway will have to call
->get_blocks irrespective of ib_seq checking.

>
> Indeed, we also don't hold the ei->truncate_mutex here, so the
> sampling of ib_seq could race with other allocation or truncation
> calls on this inode. That's a landmine that will eventually bite
> hard, because the sequence number returned with the iomap does not
> reflect the state of the extent tree when the iomap is created.
>

So by sampling the ib_seq before calling ext2_get_blocks(), we ensure
any change in block mapping after the sampling gets recorded like race
of writeback with truncate (which can therefore change ib_seq value)


> If you look at the XFS code, we set iomap->validity_cookie whenever
> we call xfs_bmbt_to_iomap() to format the found/allocated extent
> into an iomap to return to the caller. The sequence number is passed
> into that function alongside the extent map by the caller, because
> when we format the extent into an iomap the caller has already dropped the
> allocation lock. We must sample the sequence number after the allocation
> but before we drop the allocation lock so that the sequence number
> -exactly- matches the extent tree and the extent map we are going to
> format into the iomap, otherwise the extent we map into the iomap
> may already be stale and the validity cookie won't tell us that.
>
> i.e. the cohrenecy relationship between the validity cookie and the
> iomap must be set up from a synchronised state.  If the sequence
> number is allowed to change between mapping the extent and sampling
> the sequence number, then the extent we map and cache may already be
> invalid and this introduces the possibility that the validity cookie
> won't always catch that...
>

Yes, Dave. Thanks for sharing the details.
In the current PoC, I believe it is synchronized w.r.t ib_seq change.

>> +	if (ret < 0)
>> +		return ret;
>> +	/*
>> +	 * ret can be 0 in case of a hole which is possible for mmaped writes.
>> +	 */
>> +	ret = ret ? ret : 1;
>> +	return ext2_iomap_begin(inode, offset, (loff_t)ret << blkbits,
>>  				IOMAP_WRITE, &wpc->iomap, NULL);
>
> So calling ext2_iomap_begin() here might have to change. Indeed,
> given that we just allocated the blocks and we know where they are
> located, calling ext2_iomap_begin()->ext2_get_blocks() to look them
> up again just to format them into the iomap seems .... convoluted.
>
> It would be better to factor ext2_iomap_begin() into a call to
> ext2_get_blocks() and then a "ext2_blocks_to_iomap()" function to
> format the returned blocks into the iomap that is returned. Then
> ext2_write_map_blocks() can just call ext2_blocks_to_iomap() here
> and it skips the unnecessary block mapping lookup....
>
> It also means that the ib_seq returned by the allocation can be fed
> directly into the iomap->validity_cookie...
>

Thanks for your extensive review and sharing more details around this. 
Let me spend more time to see if this can bring benefit in this case for
ext2.

-ritesh

