Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58884083F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhIMFrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhIMFrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:47:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8F9C061574;
        Sun, 12 Sep 2021 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6SfgkC+JZnr0UNolZwMoQM7LNrDA0S14AXQgn/IuMC4=; b=dhoftXNEpLcCsE4MsG8ssXT5DI
        R36G2CIY6RC7aqVwIsnkdsybOKMEaQUm+/ARpChj+GLJ0obZj6ehYVkXq0ojLsAZUprPlXongmXM+
        mKijVBgKrmDfCw4ZlWgPLek60eK6z6yLI9eVu5glcDo9lp1ULPmZ4g4DCXRTZSLW/CTGuPU61iS4y
        kMviLGl+3uAZ15mta4NDwabiD0DdZl0Hwt5XAl6PmtSPdhu8GoQXtmNyhp0OSaqK5XuVnxu2FLB8X
        Qn8goumjhuMujmJCeVLv0eEGhVEOj9XcMT86nW6mPWxkMewZ/QzPfcGSKZKQl0tOfnI0/HbPnnHhB
        tciUW/yg==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPelL-00DCaY-A9; Mon, 13 Sep 2021 05:44:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] kernfs: remove the unused lockdep_key field in struct kernfs_ops
Date:   Mon, 13 Sep 2021 07:41:11 +0200
Message-Id: <20210913054121.616001-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/kernfs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index cecfeedb7361d..3ccce6f245484 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -269,10 +269,6 @@ struct kernfs_ops {
 			 struct poll_table_struct *pt);
 
 	int (*mmap)(struct kernfs_open_file *of, struct vm_area_struct *vma);
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lock_class_key	lockdep_key;
-#endif
 };
 
 /*
-- 
2.30.2

