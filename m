Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42192187BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGHMht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 08:37:49 -0400
Received: from casper.infradead.org ([90.155.50.34]:33904 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgGHMhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eRYeofupNTAg/hMagEXpMB0U80BJt/uEJfgiybjPcNs=; b=cOohz1deWmiTukpTMOvRxjYkSC
        FlpE7v6s71YH+r89i7WhAB1eRC6X7Wyeu3vWEBebMxiDpVy4J/hwl7fjN3pMz+4NLAKBZSd4L8+Az
        bbw81HjNoRag9LCrtloVUR39LdORU9gy/0c6s5rbCjoWSDYA6Z9HM4tyE6BhNWXRlV5COxT19H7UW
        +zJgjE3ye8ekvfsAqy7m65No5mPVx9JNFTd7wdKktW35PU+qcPw0MHROFMcUVVNq069PQTZbchnLm
        WjS13dO3u4DM6Ky+9v1AbDaW+9lM3N6Y8GhAZLU66aKPYfeVJj3LBGabpR4KfGtc3JvQPANvFMBHQ
        LToSj//g==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9Jp-0002JP-Mv; Wed, 08 Jul 2020 12:37:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] isofs: remove a stale comment
Date:   Wed,  8 Jul 2020 14:25:44 +0200
Message-Id: <20200708122546.214579-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708122546.214579-1-hch@lst.de>
References: <20200708122546.214579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

check_disk_change isn't for consumers of the block layer, so remove
the comment mentioning it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/isofs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index d634561f871a56..78f5c96c76f31e 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -612,9 +612,6 @@ static bool rootdir_empty(struct super_block *sb, unsigned long block)
 
 /*
  * Initialize the superblock and read the root inode.
- *
- * Note: a check_disk_change() has been done immediately prior
- * to this call, so we don't need to check again.
  */
 static int isofs_fill_super(struct super_block *s, void *data, int silent)
 {
-- 
2.26.2

