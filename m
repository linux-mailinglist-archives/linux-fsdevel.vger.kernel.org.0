Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E553E3FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhHIGRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHIGRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:17:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483FFC0613CF;
        Sun,  8 Aug 2021 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wr5j7XIH32W7TXDAP4E3ZO40CXVukSchgwaRL3qYAAQ=; b=MtFhwQ8jmDdNMkJnVtJpsAcaYA
        OTFcbmcENPSWTyZHgy/1lQtWj507dyi8ZZqxxBZiO7noAHoU07UdgUA91+BLQabetZ4+JBhJ0g5uj
        Bk8oTsnYaT8iJ661pe30/HFZt+D2Td7tKCJNHsLFYjdx+7wUo3vARgtLJDIDoHFETw6/O7eeJ9lQl
        f4N6Wuo+gbOawpEaq8wYUvVSU53uzrwJN4p0qHLbvU6HgDWnREPTUoFH+ofVBqpMpmxwBtzLQB94F
        07CMRpMhAwLS7VRJoRRA/0MOd2UkMY0n6r/6SwjynbyUIYtiAhD/fn7E5A4qgemsD4Dd5a9F7AAG4
        WohrYm5w==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyYN-00AgPp-F0; Mon, 09 Aug 2021 06:14:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 03/30] iomap: mark the iomap argument to iomap_sector const
Date:   Mon,  9 Aug 2021 08:12:17 +0200
Message-Id: <20210809061244.1196573-4-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux/iomap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 72696a55c137f1..8030483331d17f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -91,8 +91,7 @@ struct iomap {
 	const struct iomap_page_ops *page_ops;
 };
 
-static inline sector_t
-iomap_sector(struct iomap *iomap, loff_t pos)
+static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
-- 
2.30.2

