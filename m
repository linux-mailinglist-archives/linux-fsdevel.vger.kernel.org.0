Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B77A67E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjISPVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjISPVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:21:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42659C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 08:21:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A6D2B5C0182;
        Tue, 19 Sep 2023 11:21:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 Sep 2023 11:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695136864; x=1695223264; bh=3yQ/E5fXi8IYKNdgyuCIBZq9U0mUDfGFlEu
        oaY5ix+8=; b=Kdp/sD4hn3stBVQQCRsIUN/pS4fw/23N9GTmFPBQ1SWr5QcUDGt
        BpLhHVmeoNUk0pq4HYY2EEticgiNEp9d3tYfpbLxdF73VDNz8hBvyUZMWbef/Isq
        BJ74De0LdQ5bM1FVthfT976QEYU9dMkhYlcp/B3GWEPYpJk69j/9ctP0mvtA2cuv
        FqAA8EZLyPfhndKjReUdcG6fyq4tZnZvUlSaHPtcyFI/4PNetSsVe0Y/07YbS/ef
        tRd6esq2/8xIj0WmhuuFSjaxPos2lBR5fpc6VuFrYXO1q4c6dTjv0nopkwdv9/Dc
        zGFppRPkJGO+Zk5yuGKTI16PkKrzgk0Kscw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695136864; x=1695223264; bh=3yQ/E5fXi8IYKNdgyuCIBZq9U0mUDfGFlEu
        oaY5ix+8=; b=GDG1HpoYEWwmPu614hrdOVVSu3PLMFtdfLOZrmOT8nyjSpexzUq
        sFGoWzo8hev5Cx7D/RLcG1DiaTMZzkSIDTT9FyyJIo6Xs701hbhI7e0j/U+520tY
        hAMmP5uWjnvtZPomW/Q0Bbb8bYb11Znb1aUz+pYjIGvR92h/WegNwEzCKgmZqwb8
        i7pH88F/bMfnr48HM1/xx7g2LJcHVDvVkdDEXfpRLDFZX6LkoPfrvJg0wbPA6VC8
        6YipOK8Q2N9V0aut6PFzDgLEuqM/uLBnlxR+370gXJHVncDJXCvTcZqtMxR2l/EY
        D6EhjRV8L1gMyoB/GBv3AwUXGSmIVFwklvw==
X-ME-Sender: <xms:X7wJZfaDkAyf6wNr7w3YdvnG2eX6z0te5xOcY5lcuRE1w5COEycH1w>
    <xme:X7wJZeZP1XKBdtDm7O_bkxLF9phmRH2pohueGcmnEM2UN2bfz3geJegH0QMWlnlPV
    yXZTxPuVP7WzO85>
X-ME-Received: <xmr:X7wJZR8BBJ51-6jqp8viBXaSMoaBt5kRDwwqQl9ZpudSMA9Ju_WdhQRm55n0QH9ozt4EjM3U8vaydHtSTDqBVncIFno4v0vGtMOJS9RgEty3hlZ8kZ4P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeekhe
    evkeelkeekjefhheegfedtffduudejjeeiheehudeuleelgefhueekfeevudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstg
    hhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:YLwJZVrALRBfMFR0_k7kszGQO52DbxoyGXsO40Fyp2sW9q0erNFLNg>
    <xmx:YLwJZaqGh5lXBLMu28hG3cs4_M8v0YON2xQqS_LWRKPe0-02QoyiZA>
    <xmx:YLwJZbSuTzMEqpXaLlt28NA9Ev6SlecMEE3spSkol2dTxQKrWxKVOg>
    <xmx:YLwJZXBiUgKewxwpYxJ52rLZpRfXMlTWtY6xNrcZzinxzoNlIcK0hA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Sep 2023 11:21:02 -0400 (EDT)
Message-ID: <9f7dda94-fb94-3b99-a16c-9f6d3a25029c@fastmail.fm>
Date:   Tue, 19 Sep 2023 17:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 07/10] fuse: Remove fuse_direct_write_iter code path /
 use IOCB_DIRECT
To:     kernel test robot <lkp@intel.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu, dsingh@ddn.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230918150313.3845114-8-bschubert@ddn.com>
 <202309190423.cEQ7h6ai-lkp@intel.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <202309190423.cEQ7h6ai-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/18/23 22:13, kernel test robot wrote:
> Hi Bernd,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on mszeredi-fuse/for-next]


Thanks, updated patch:

---
From: Bernd Schubert <bschubert@ddn.com>
Subject: fuse: Remove fuse_direct_write_iter code path / use
  IOCB_DIRECT

fuse_direct_write_iter is basically duplicating what is already
in fuse_cache_write_iter/generic_file_direct_write. That can be
avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
and fuse_direct_write_iter can be removed.

Before it was using for FOPEN_DIRECT_IO

1) async (!is_sync_kiocb(iocb)) && IOCB_DIRECT

fuse_file_write_iter
     fuse_direct_write_iter
         fuse_direct_IO
             fuse_send_dio

2) sync (is_sync_kiocb(iocb)) or IOCB_DIRECT not being set

fuse_file_write_iter
     fuse_direct_write_iter
         fuse_send_dio

3) FOPEN_DIRECT_IO not set

Same as the consolidates path below

The new consolidated code path is always

fuse_file_write_iter
     fuse_cache_write_iter
         generic_file_write_iter
              __generic_file_write_iter
                  generic_file_direct_write
                      mapping->a_ops->direct_IO / fuse_direct_IO
                          fuse_send_dio

So in general for FOPEN_DIRECT_IO the code path gets longer. Additionally
fuse_direct_IO does an allocation of struct fuse_io_priv - might be a bit
slower in micro benchmarks.
Also, the IOCB_DIRECT information gets lost (as we now set it outselves).
But then IOCB_DIRECT is directly related to O_DIRECT set in
struct file::f_flags.

An additional change is for condition 2 above, which might will now do
async IO on the condition ff->fm->fc->async_dio. Given that async IO for
FOPEN_DIRECT_IO was especially introduced in commit
'commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for
  FOPEN_DIRECT_IO")'
it should not matter. Especially as fuse_direct_IO is blocking for
is_sync_kiocb(), at worst it has another slight overhead.

Advantage is the removal of code paths and conditions and it is now also
possible to remove FOPEN_DIRECT_IO conditions in fuse_send_dio
(in a later patch).

Cc: Hao Xu <howeyxu@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dharmendra Singh <dsingh@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
  fs/fuse/file.c | 60 +++++++++-----------------------------------------
  1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 24fa6cab836f..41e10e6f5aa4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1061,6 +1061,12 @@ static unsigned int fuse_write_flags(struct kiocb *iocb)
  	if (iocb->ki_flags & IOCB_SYNC)
  		flags |= O_SYNC;
  
+	/*
+	 * Note: If O_DIRECT should be ever added here,
+	 *       iocb->ki_flags & IOCB_DIRECT cannot be trusted when
+	 *       FOPEN_DIRECT_IO is set.
+	 */
+
  	return flags;
  }
  
@@ -1631,52 +1637,6 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
  	return res;
  }
  
-static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
-	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from, inode);
-
-	/*
-	 * Take exclusive lock if
-	 * - Parallel direct writes are disabled - a user space decision
-	 * - Parallel direct writes are enabled and i_size is being extended.
-	 *   This might not be needed at all, but needs further investigation.
-	 */
-	if (exclusive_lock)
-		inode_lock(inode);
-	else {
-		inode_lock_shared(inode);
-
-		/* A race with truncate might have come up as the decision for
-		 * the lock type was done without holding the lock, check again.
-		 */
-		if (fuse_io_past_eof(iocb, from)) {
-			inode_unlock_shared(inode);
-			inode_lock(inode);
-			exclusive_lock = true;
-		}
-	}
-
-	res = generic_write_checks(iocb, from);
-	if (res > 0) {
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-			res = fuse_direct_IO(iocb, from);
-		} else {
-			res = fuse_send_dio(&io, from, &iocb->ki_pos,
-					    FUSE_DIO_WRITE);
-			fuse_write_update_attr(inode, iocb->ki_pos, res);
-		}
-	}
-	if (exclusive_lock)
-		inode_unlock(inode);
-	else
-		inode_unlock_shared(inode);
-
-	return res;
-}
-
  static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
  {
  	struct file *file = iocb->ki_filp;
@@ -1707,10 +1667,10 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
  	if (FUSE_IS_DAX(inode))
  		return fuse_dax_write_iter(iocb, from);
  
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
-		return fuse_direct_write_iter(iocb, from);
+	if (ff->open_flags & FOPEN_DIRECT_IO)
+		iocb->ki_flags |= IOCB_DIRECT;
+
+	return fuse_cache_write_iter(iocb, from);
  }
  
  static void fuse_writepage_free(struct fuse_writepage_args *wpa)
-- 
2.39.2


