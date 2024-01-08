Return-Path: <linux-fsdevel+bounces-7565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C468277F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EA31F2366C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634554F8D;
	Mon,  8 Jan 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="X4lA5tGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FF54BE3;
	Mon,  8 Jan 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T839p37gxz9skW;
	Mon,  8 Jan 2024 19:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704740014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHWcZ2JmsqaWiasTCZlaDPgHas1hb4zo67ReyMpu1tI=;
	b=X4lA5tGAla/+Tth6KDfxt2BEwdrniSB6SuTwfgew/Cq4J8m2frjkG59L1T9LEVZfICopI7
	8DWThZRwAdYVX9P4QtYnyabHVIqyn7f0DHiTeWTGpnthtJG3PetxKFkIBbliqPMBUrpZUx
	j/MR682xahqMupc3AkjyQL5KhQRu8yqdp1Cpo36cueSL9T8gsY1mOidll0tzn+c7dAZI50
	utJAIesYsvSpXMxg+MLRATtMZ7SmgNnvzZMPpG9IkSZdL3+8IBO2gMQewXn4SlkJmmxbbt
	QyIws8lyXiNBxuAjf5xp0N5rum7Dkte9KjoQhbG3DPDizRwJSJg+S32PFsMVcA==
Date: Mon, 8 Jan 2024 19:53:31 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH 4/5] buffer: Fix __bread() kernel-doc
Message-ID: <20240108185331.nswciqsn676dhav3@localhost>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-5-willy@infradead.org>
 <20240108145808.2k4rob3ntdknrkp3@localhost>
 <ZZweHfmMWnlBFKdV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZweHfmMWnlBFKdV@casper.infradead.org>

On Mon, Jan 08, 2024 at 04:09:01PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 08, 2024 at 03:58:08PM +0100, Pankaj Raghav (Samsung) wrote:
> > On Thu, Jan 04, 2024 at 04:36:51PM +0000, Matthew Wilcox (Oracle) wrote:
> > > The extra indentation confused the kernel-doc parser, so remove it.
> > > Fix some other wording while I'm here, and advise the user they need to
> > > call brelse() on this buffer.
> > > 
> > It looks like __bread_gfp has the same problem:
> 
> I'm happy to incorporate this patch, but I'll need your S-o-B on it.

Something like this:

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 8 Jan 2024 19:37:41 +0100
Subject: [PATCH] buffer: Update __bread() and __bread_gfp kernel-doc

The extra indentation confused the kernel-doc parser, so remove it.
Fix some other wording while I'm here, and advise the user they need to
call brelse() on this buffer.

Instead of duplicating the doc in __bread() and __bread_gfp(), update
__bread_gfp() doc and point to it from __bread().

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c                 | 21 ++++++++++++---------
 include/linux/buffer_head.h |  9 +--------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 967f34b70aa8..ea55fb3fcfae 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1446,16 +1446,19 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 EXPORT_SYMBOL(__breadahead);
 
 /**
- *  __bread_gfp() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
- *  @block: number of block
- *  @size: size (in bytes) to read
- *  @gfp: page allocation flag
+ * __bread_gfp() - Read a block.
+ * @bdev: The block device to read from.
+ * @block: Block number in units of block size.
+ * @size: Block size in bytes.
+ * @gfp: gfp flags.
  *
- *  Reads a specified block, and returns buffer head that contains it.
- *  The page cache can be allocated from non-movable area
- *  not to prevent page migration if you set gfp to zero.
- *  It returns NULL if the block was unreadable.
+ * Read a specified block, and return the buffer head that refers to it.
+ * The memory can be allocated from a non-movable area to not to prevent
+ * page migration if you set gfp to zero. The buffer head has its
+ * refcount elevated and the caller should call brelse() when it has
+ * finished with the buffer.
+ *
+ * Return: NULL if the block was unreadable.
  */
 struct buffer_head *
 __bread_gfp(struct block_device *bdev, sector_t block,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 5f23ee599889..ac56014b29dd 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -440,14 +440,7 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
 }
 
 /**
- *  __bread() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
- *  @block: number of block
- *  @size: size (in bytes) to read
- *
- *  Reads a specified block, and returns buffer head that contains it.
- *  The page cache is allocated from movable area so that it can be migrated.
- *  It returns NULL if the block was unreadable.
+ * See __bread_gfp()
  */
 static inline struct buffer_head *
 __bread(struct block_device *bdev, sector_t block, unsigned size)
-- 
2.40.1


