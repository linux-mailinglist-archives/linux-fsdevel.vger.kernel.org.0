Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88F2748207
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGEKXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGEKXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:23:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F3E47
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 03:23:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ED2B05C01DC;
        Wed,  5 Jul 2023 06:23:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 06:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688552624; x=1688639024; bh=pEq130co3PUVT23mcVY0c6VFqoMIxYThI7N
        /97V3oxE=; b=gIGP3zMdZViP8ioCqdSNs9TO1zRJ1T7GHc3AGIbVk9RhIWXs4rY
        +6dEfzftxxsD26O9bewiT4iijZkrSTGxNoHqYy/GHL9/+8Nc5b6DY4yyU3EPW3Z1
        fqsTRw77jS8UoUUdYlBQtyLxx9v798qYxqBfK2yH9TxrgT/1grW6eXEPMxrEsHac
        rCXPCtGr7upE9lXIwXzJIQzhdxJ7XrbJcOxwUOCVgBFCiSnETmKEbyN1R/DX7gN0
        2DMrKAU0NcV8NVtvZ6n24wsSGcFO4+TXrmCX5glqi4eBX92yjP9xgaBBQ1ig1aER
        AYOvsvt04GoUv+wjA6MF8ZAYhtyRdVext3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688552624; x=1688639024; bh=pEq130co3PUVT23mcVY0c6VFqoMIxYThI7N
        /97V3oxE=; b=hyrm5CSVgdUZtxR92Jk4GpjloZHgyMU9StPbYVmVMSt+2IWhzH5
        i6M7HzOTguxzVStk+drYh0huy7h5FtyggMAG2T2NUoNCGs6xrai38f8h+8qR3yaT
        X66HeTaq6hqZUf6NStYF/V6joc8yXsVRMKGERwQ53RtbrOvhU9x4IjuAvyzi3yUp
        ybQsaCBxKuW7vBou/AkeqxSwAOTBu5DAD2kBAChav6p+TaERb29pVMP37SeaHL9m
        n8cy+R3IKI+uVIvoB+4JdC43Ml1cw3KlUwnfpEmUzyAzfV20ZBSTmyS6BKi8N1aN
        O8n1FNwusEfNfu10NzKbeK0V4UIx+/ObqXw==
X-ME-Sender: <xms:r0SlZOfKYe2nqp8PmHrTImYJtVDaeWc-Za7aP8_aGiOETmIdlPQXaQ>
    <xme:r0SlZIMK2ZVTo_tEBxjWPl7rjVD1dE_fLaT4wh6U_GBpviq0P_Qn1RS1ObR3kKe1I
    NlsP2mYtGpCXOo5>
X-ME-Received: <xmr:r0SlZPiD_w4adDN7WqILoeHtEWuCV9JhEfSrSscJ2O_4nMHuieYncE4wfoKX44eHomehGHyHli-uOVSuS6uUZJ0KGbHWo5PZZzHGeTiLp7CQYIIuPkZK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:r0SlZL9s3_CTL8Fs3jyDYX0DN78mRrwS420voZnfthATrxWx6zrrcw>
    <xmx:r0SlZKurLGk81N9XBL5Vxv-TFY97bGszM60MPhQ7LHLaFiYShEl62w>
    <xmx:r0SlZCFWy_aRN-UY1ToeQBM0ARN6c8mAa5kJmmMSEPvaB-chbD53qA>
    <xmx:sESlZMVxfi4GuBwbr5uWH8AJdlx8ECj119VIQd1MUskeU5WblRUqbw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 06:23:42 -0400 (EDT)
Message-ID: <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm>
Date:   Wed, 5 Jul 2023 12:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [RFC] [PATCH] fuse: DIO writes always use the same code path
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        Dharmendra Singh <dsingh@ddn.com>
References: <20230630094602.230573-1-hao.xu@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230630094602.230573-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bernd Schubert <bschubert@ddn.com>

In commit 153524053bbb0d27bb2e0be36d1b46862e9ce74c DIO
writes can be handled in parallel, as long as the file
is not extended. So far this only works when daemon/server
side set FOPEN_DIRECT_IO and FOPEN_PARALLEL_DIRECT_WRITES,
but O_DIRECT (iocb->ki_flags & IOCB_DIRECT) went another
code path that doesn't have the parallel DIO write
optimization.
Given that fuse_direct_write_iter has to handle page writes
and invalidation anyway (for mmap), the DIO handler in
fuse_cache_write_iter() is removed and DIO writes are now
only handled by fuse_direct_write_iter().

Note: Correctness of this patch depends on a non-merged
series from Hao Xu <hao.xu@linux.dev>
( fuse: add a new fuse init flag to relax restrictions in no cache mode)
---
  fs/fuse/file.c |   38 +++++---------------------------------
  1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89d97f6188e0..1490329b536c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1337,11 +1337,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb 
*iocb, struct iov_iter *from)
  	struct file *file = iocb->ki_filp;
  	struct address_space *mapping = file->f_mapping;
  	ssize_t written = 0;
-	ssize_t written_buffered = 0;
  	struct inode *inode = mapping->host;
  	ssize_t err;
  	struct fuse_conn *fc = get_fuse_conn(inode);
-	loff_t endbyte = 0;

  	if (fc->writeback_cache) {
  		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1377,37 +1375,10 @@ static ssize_t fuse_cache_write_iter(struct 
kiocb *iocb, struct iov_iter *from)
  	if (err)
  		goto out;

-	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t pos = iocb->ki_pos;
-		written = generic_file_direct_write(iocb, from);
-		if (written < 0 || !iov_iter_count(from))
-			goto out;
-
-		pos += written;
-
-		written_buffered = fuse_perform_write(iocb, mapping, from, pos);
-		if (written_buffered < 0) {
-			err = written_buffered;
-			goto out;
-		}
-		endbyte = pos + written_buffered - 1;
-
-		err = filemap_write_and_wait_range(file->f_mapping, pos,
-						   endbyte);
-		if (err)
-			goto out;
-
-		invalidate_mapping_pages(file->f_mapping,
-					 pos >> PAGE_SHIFT,
-					 endbyte >> PAGE_SHIFT);
+	written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
+	if (written >= 0)
+		iocb->ki_pos += written;

-		written += written_buffered;
-		iocb->ki_pos = pos + written_buffered;
-	} else {
-		written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
-		if (written >= 0)
-			iocb->ki_pos += written;
-	}
  out:
  	current->backing_dev_info = NULL;
  	inode_unlock(inode);
@@ -1691,7 +1662,8 @@ static ssize_t fuse_file_write_iter(struct kiocb 
*iocb, struct iov_iter *from)
  	if (FUSE_IS_DAX(inode))
  		return fuse_dax_write_iter(iocb, from);

-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
+	    !(iocb->ki_flags & IOCB_DIRECT))
  		return fuse_cache_write_iter(iocb, from);
  	else
  		return fuse_direct_write_iter(iocb, from);

