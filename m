Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A488436206
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhJUMrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJUMrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901CC06161C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vl3hjutl474IpUwXxU604+NLLsL0S4mgEjix5/Vk13k=; b=c5wm2WZo7QOeZctOZf/JkC6KeS
        VQ/Xc7HSH3XZ+HYG/vAr+3T449gcJb28cyxzjiXKCzB6SqTb8jGklEe2PGAAIFtX/jmCbpbEftMgf
        Zb7sy61TFef8NjuXC7RXft+gY/E84tQ0S9jqUOPNrIuJDnhIYBY1u6oaYWLAT/vVCONPkKHxiu3cG
        WOKHnkIYB5LTHEWzcLIDtNVChBuqrzYVENUc1HcLycMI7lP44EThrRYntKbE/f8pABJjxh8aMzZM+
        f5j8teexAflYQyQtt7GjaOudZ1ydwALezKy140hwTqsuWnZOcDOpWcODR0UWbrAEmhDUHmZLjoExx
        IVZcIxpA==;
Received: from [2001:4bb8:180:8777:dd70:8011:36d9:4c23] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXRA-007Wxh-Qs; Thu, 21 Oct 2021 12:44:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/5] mm: export bdi_unregister
Date:   Thu, 21 Oct 2021 14:44:37 +0200
Message-Id: <20211021124441.668816-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021124441.668816-1-hch@lst.de>
References: <20211021124441.668816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To wind down the magic auto-unregister semantics we'll need to push this
into modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/backing-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4a9d4e27d0d9b..8a46a0a4b72fa 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -958,6 +958,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 		bdi->owner = NULL;
 	}
 }
+EXPORT_SYMBOL(bdi_unregister);
 
 static void release_bdi(struct kref *ref)
 {
-- 
2.30.2

