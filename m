Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1C53F695
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiFGGxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 02:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFGGxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:53:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728027A464
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654584819; x=1686120819;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=zkyNNmeyTZYd9xNTID/AUVMNtINiL7ppxbtmL1rZXAM=;
  b=Juc/bBf6ROpW6Vd6Gc4zNoobkR3b3OIQMe2vd5iM3a5MTIDs5Pooh166
   eJ1lpF7S6BxNauEW+CyBLDHfhunrdBrQC/p0h9eyWBfiPBklDffkeyVge
   k7XBSPCX87la/8BJx4JjMty/NdrLt2olaiVKLc+UDVDAr9ZidQkldiZDJ
   p78KuQQ/C8Y92ABi7dGL/rpe7Xd/Yiz9YmoMGsy0gvfI03mHrPZXYZPNQ
   MbsXXtIMIQT4UsZNPp7Jbqti7nHEguTzGXgI12hJV1gwMqcBv/TITdgrw
   8h9C8IKyLt6qUhLJ2QCUQjUXGdZk6v5XGUl89a1kqquIYENOE2WT52tYj
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="201190035"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 14:53:38 +0800
IronPort-SDR: bPGmpbD+1DTpgTABteRwt27R9eBtJLQghdb+KpaDclMkP2ASI6U+DMXKDfihS6ZBhvszzULPPm
 6BEBiF5np2rtfBV9eFJ1vovhZzUzP5FlxFWiN3hg7jErog1SS5E7eYdKf8YmpO77NXDXuBmJO6
 QBXmrp4vlICDVsp0nsLkDa5sskcdyTdd1nXQbn6+xCbPs3RNWLMkR6gEIH/wchX+mdJO5Qkq2n
 hZI2fjJbiqyQ8hBPdF1qZbzvl3i6hITuk2WuF1kFFiqBWq55C71gKimd5OzXXlxVLe0138DlKx
 5Ii/RTfBTQ2hTS5AM6tnKvJZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 23:12:28 -0700
IronPort-SDR: MSJw2TPYo43YhRciubYBtJEf75VHlrTZeAeQdxL444FXRD7lCGHMdCRT+xE8W1a82pAj4bAeuh
 gnRZFI4n+LWA7lNLnCdZtuURAOUkWIbv93jCl0uNmS1pMgRlOHcQKB2/6lJQ1qUSRu5AH2CAxS
 GyPUrLKjNxtKAGhtFkXlwZtrvlM7tY8/XDoZU0Ws+lAd3aSKiZzgv8lFDrjctoXwjBkxRU4w0a
 n7bTxQWBYYTF2DkvT/EqINI1bf+P4hHAmsvSdUYFBZB/1gyrKO7RL6mxHqzhmZqKLYHpHmTIOU
 EdU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 23:53:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHLfp1gnWz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 23:53:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:content-language:references:to:subject
        :from:user-agent:mime-version:date:message-id; s=dkim; t=
        1654584817; x=1657176818; bh=zkyNNmeyTZYd9xNTID/AUVMNtINiL7ppxbt
        mL1rZXAM=; b=Bu09SRLtn8d1EJ50dVebZOrTaGlF4kESXOVbloDCDciQaRbxpMJ
        2kBUanoMYi7NXvs3umsltO0iv/EDfrNAiIrXO9lXn6q8LJH091+Jg15BmuJgphAN
        D02mJnhARO+Q5bCWhHMVqoaIj2NqfVH09T6rDBw+cbY8nTEuslU8f7sr2nS0/jqi
        wvYo7/FjKuKiEdrsINkf69qcVGbFiBXvDfbcmTF4hB2TxUWmG0dJm93zJOlyqv+C
        +GEiKtbfVNsHq+DTSGSUcB4ZAfuFXcQ2VEd280oatThl3qKoHd1+wuek8TqR8lPC
        iWkvfXQI0XO0TAllgKT64P64W+ahuRIvNUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A8GeWORSO-Nx for <linux-fsdevel@vger.kernel.org>;
        Mon,  6 Jun 2022 23:53:37 -0700 (PDT)
Received: from [10.89.82.246] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.246])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHLfm6fLmz1Rvlc;
        Mon,  6 Jun 2022 23:53:36 -0700 (PDT)
Message-ID: <48ea1d34-6992-f85d-c763-d817cd32cca4@opensource.wdc.com>
Date:   Tue, 7 Jun 2022 15:53:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 3/3] zonefs: fix zonefs_iomap_begin() for reads
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-4-damien.lemoal@opensource.wdc.com>
 <Yp7rox7SRvKcsZPT@infradead.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Yp7rox7SRvKcsZPT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/06/07 15:09, Christoph Hellwig wrote:
> On Fri, Jun 03, 2022 at 08:49:39PM +0900, Damien Le Moal wrote:
>> If a read operation (e.g. a readahead) is issued to a sequential zone
>> file with an offset exactly equal to the current file size, the iomap
>> type will be set to IOMAP_UNWRITTEN, which will prevent an IO, but the
>> iomap length is always calculated as 0. This causes a WARN_ON() in
>> iomap_iter():
> 
> Is there a testsuite somewhere with a reproducer?

Yes, test case 0325 of the test suite that comes with zonefs-tools:

git@github.com:westerndigitalcorporation/zonefs-tools.git

The tests are under the "tests" directory and running:

zonefs-tests-nullblk.sh -t 0325

triggers the problem 100% of the time.

> 
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index 123464d2145a..64f4ceb6f579 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -144,7 +144,7 @@ static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  		iomap->type = IOMAP_MAPPED;
>>  	if (flags & IOMAP_WRITE)
>>  		length = zi->i_max_size - offset;
>> -	else
>> +	else if (offset < isize)
>>  		length = min(length, isize - offset);
> 
> So you still report an IOMAP_UNWRITTEN extent for the whole size of
> the requst past EOF?  Looking at XFS we do return the whole requested
> length, but do return it as HOLE.  Maybe we need to clarify the behavior
> here and document it.

Yes, I checked xfs and saw that. But in zonefs case, since the file blocks are
always preallocated, blocks after the write pointer are indeed UNWRITTEN. I did
check that iomap read processing treats UNWRITTEN and HOLE similarly, that is,
ignore the value of length and stop issuing IOs when either type is seen. But I
may have missed something.

Note that initially I wrote the patch below to fix the problem. But it is very
large and should probably be a cleanup for the next cycle. It separates the
begin op for read and write, which makes things easier to understand.



From 1e1024daff9158f36fe01328c4be83db940d4309 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Date: Mon, 23 May 2022 16:29:10 +0900
Subject: [PATCH] zonefs: fix iomap_begin operation


Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/zonefs/super.c | 103 +++++++++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 123464d2145a..29c609aede65 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -110,15 +110,48 @@ static inline void zonefs_i_size_write(struct inode
*inode, loff_t isize)
 	}
 }

-static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-			      unsigned int flags, struct iomap *iomap,
-			      struct iomap *srcmap)
+static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
+				   loff_t length, unsigned int flags,
+				   struct iomap *iomap, struct iomap *srcmap)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	loff_t isize;
+	loff_t isize = i_size_read(inode);
+
+	/*
+	 * All blocks are always mapped below EOF. If reading past EOF,
+	 * act as if there is a hole up to the file maximum size.
+	 */
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
+	if (iomap->offset >= isize) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->length = length;
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+		iomap->length = min(length, isize - iomap->offset);
+	}
+
+	trace_zonefs_iomap_begin(inode, iomap);
+
+	return 0;
+}
+
+static const struct iomap_ops zonefs_read_iomap_ops = {
+	.iomap_begin	= zonefs_read_iomap_begin,
+};
+
+static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
+				    loff_t length, unsigned int flags,
+				    struct iomap *iomap, struct iomap *srcmap)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	loff_t remaining, isize = i_size_read(inode);

-	/* All I/Os should always be within the file maximum size */
+	/* All write I/Os should always be within the file maximum size */
 	if (WARN_ON_ONCE(offset + length > zi->i_max_size))
 		return -EIO;

@@ -128,56 +161,51 @@ static int zonefs_iomap_begin(struct inode *inode, loff_t
offset, loff_t length,
 	 * operation.
 	 */
 	if (WARN_ON_ONCE(zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
-			 (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT)))
+			 !(flags & IOMAP_DIRECT)))
 		return -EIO;

 	/*
-	 * For conventional zones, all blocks are always mapped. For sequential
-	 * zones, all blocks after always mapped below the inode size (zone
-	 * write pointer) and unwriten beyond.
+	 * For conventional zones, since the inode size is fixed, all blocks
+	 * are always mapped. For sequential zones, all blocks after always
+	 * mapped below the inode size (zone write pointer) and unwriten beyond.
 	 */
-	mutex_lock(&zi->i_truncate_mutex);
-	isize = i_size_read(inode);
-	if (offset >= isize)
-		iomap->type = IOMAP_UNWRITTEN;
-	else
-		iomap->type = IOMAP_MAPPED;
-	if (flags & IOMAP_WRITE)
-		length = zi->i_max_size - offset;
-	else
-		length = min(length, isize - offset);
-	mutex_unlock(&zi->i_truncate_mutex);
-
-	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
-	iomap->length = ALIGN(offset + length, sb->s_blocksize) - iomap->offset;
 	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	iomap->addr = (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
+	if (iomap->offset >= isize) {
+		iomap->type = IOMAP_UNWRITTEN;
+		remaining = zi->i_max_size - iomap->offset;
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		remaining = isize - iomap->offset;
+	}
+	iomap->length = min(length, remaining);

 	trace_zonefs_iomap_begin(inode, iomap);

 	return 0;
 }

-static const struct iomap_ops zonefs_iomap_ops = {
-	.iomap_begin	= zonefs_iomap_begin,
+static const struct iomap_ops zonefs_write_iomap_ops = {
+	.iomap_begin	= zonefs_write_iomap_begin,
 };

 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
 }

 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_iomap_ops);
+	iomap_readahead(rac, &zonefs_read_iomap_ops);
 }

 /*
  * Map blocks for page writeback. This is used only on conventional zone files,
  * which implies that the page range can only be within the fixed inode size.
  */
-static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
-			     struct inode *inode, loff_t offset)
+static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
+				   struct inode *inode, loff_t offset)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);

@@ -191,12 +219,12 @@ static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
 	    offset < wpc->iomap.offset + wpc->iomap.length)
 		return 0;

-	return zonefs_iomap_begin(inode, offset, zi->i_max_size - offset,
-				  IOMAP_WRITE, &wpc->iomap, NULL);
+	return zonefs_write_iomap_begin(inode, offset, zi->i_max_size - offset,
+					IOMAP_WRITE, &wpc->iomap, NULL);
 }

 static const struct iomap_writeback_ops zonefs_writeback_ops = {
-	.map_blocks		= zonefs_map_blocks,
+	.map_blocks		= zonefs_write_map_blocks,
 };

 static int zonefs_writepage(struct page *page, struct writeback_control *wbc)
@@ -226,7 +254,8 @@ static int zonefs_swap_activate(struct swap_info_struct *sis,
 		return -EINVAL;
 	}

-	return iomap_swapfile_activate(sis, swap_file, span, &zonefs_iomap_ops);
+	return iomap_swapfile_activate(sis, swap_file, span,
+				       &zonefs_read_iomap_ops);
 }

 static const struct address_space_operations zonefs_file_aops = {
@@ -647,7 +676,7 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct
vm_fault *vmf)

 	/* Serialize against truncates */
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
+	ret = iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops);
 	filemap_invalidate_unlock_shared(inode->i_mapping);

 	sb_end_pagefault(inode->i_sb);
@@ -899,7 +928,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb,
struct iov_iter *from)
 	if (append)
 		ret = zonefs_file_dio_append(iocb, from);
 	else
-		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+		ret = iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
 				   &zonefs_write_dio_ops, 0, NULL, 0);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
@@ -948,7 +977,7 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 	if (ret <= 0)
 		goto inode_unlock;

-	ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
 	if (ret > 0)
 		iocb->ki_pos += ret;
 	else if (ret == -EIO)
@@ -1041,7 +1070,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb,
struct iov_iter *to)
 			goto inode_unlock;
 		}
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
+		ret = iomap_dio_rw(iocb, to, &zonefs_read_iomap_ops,
 				   &zonefs_read_dio_ops, 0, NULL, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
-- 
2.36.1



-- 
Damien Le Moal
Western Digital Research
