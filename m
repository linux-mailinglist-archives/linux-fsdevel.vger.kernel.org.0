Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E663A5CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhFNGRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhFNGR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:17:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E32C061756;
        Sun, 13 Jun 2021 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EpHWGaCwy1KswCUFoR9leRbMMAfxSqdfpjbRps8At1Q=; b=EZ/xajUAaBj1Heu1grdoO5DiKc
        YOV6ZGmDoCY6xXiZD2/ObXd+7Kk2WmCJzTF0gUNm1xzhREEBW1dWgWc1B7he/ArdOoKw5rtmxic7z
        dnshp5XIRF889a8r72Hklr0qy4O1CwNSkZZq2jsQXRMy5QycF/0oFWzI+qp++vwDXjqQ36m6afG52
        JZpIpi9//1i/7BJhrdmWi80N+F5c4W+7cLtENhcJOrbNRLUtw2Suj7+Xrmtfj4bBcFCqOGko5cbV1
        gbJwHqisc2fqvWUQoUGBO6kCugIPm61Zs05jUqDdfKs+54Sp1oy2R9bXXnXa7heYqHbjsNArXq/CV
        9C7+VUYA==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfsT-00Ch50-1z; Mon, 14 Jun 2021 06:15:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fs: unexport __set_page_dirty
Date:   Mon, 14 Jun 2021 08:15:10 +0200
Message-Id: <20210614061512.3966143-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614061512.3966143-1-hch@lst.de>
References: <20210614061512.3966143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__set_page_dirty is only used by built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ea48c01fb76b..3d18831c7ad8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -611,7 +611,6 @@ void __set_page_dirty(struct page *page, struct address_space *mapping,
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
-EXPORT_SYMBOL_GPL(__set_page_dirty);
 
 /*
  * Add a page to the dirty page list.
-- 
2.30.2

