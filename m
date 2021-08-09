Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20203E3FA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhHIGSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHIGSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:18:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADCEC0613CF;
        Sun,  8 Aug 2021 23:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D1DrTl7p0ZP9ybZiGeaO0Rt2UyAZRiquLkgdxcnWHpw=; b=hWqyNP4eNGgZKXb5qSQfA/DvDw
        kz82MY+mNhamxb+284ckFoHQcxRRbiyGUQufd6EQeRRPqjEjvc2tMkHmi5t7Xqn5S+x0He8RpvVjV
        1W0Uh+cEcU78qB3VMfJf1dfmZkoZ9f/2SmWcnVBQUDPMLuvz+p3e/X6sa6WGET1mFBQQ2g8HshcpR
        DQJFbC8nZ7XeIU3oW9vdyTkGnwXWjFR8sh4eWdE+68d6lx+JMcJwVrdv9WCEVOKXAe6cjhsqYu5+B
        mPp4HGq0ozDPTEUnAd1KE5aBKXgnwsnNsZw10n8nHGxlT/sCP+ilbvmLyHuYWEQ9jSXoJocW62I72
        Z9+b8O5Q==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyZ1-00AgS0-Tp; Mon, 09 Aug 2021 06:15:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 04/30] iomap: mark the iomap argument to iomap_inline_data const
Date:   Mon,  9 Aug 2021 08:12:18 +0200
Message-Id: <20210809061244.1196573-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iomap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8030483331d17f..560247130357b5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -99,7 +99,7 @@ static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 /*
  * Returns the inline data pointer for logical offset @pos.
  */
-static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
+static inline void *iomap_inline_data(const struct iomap *iomap, loff_t pos)
 {
 	return iomap->inline_data + pos - iomap->offset;
 }
-- 
2.30.2

