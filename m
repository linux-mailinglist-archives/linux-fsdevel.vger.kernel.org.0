Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764583E3FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhHIGUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHIGUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:20:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B49C0613CF;
        Sun,  8 Aug 2021 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gZs/5VXHLNemF1diUFV8JjL2uvMR07HXumQXu+SNRS4=; b=CSdzaEMzx8hb8TdFtto6R9saeR
        PwhyWjyLx+OjpeUGAgzx3IZZh6GMa0B/c5aCDwJ9OXR/dzTwuv/F+ZEv5T7XgKzOSGV5wyZYTavbb
        Je2BnGwC0eIgNxOjOPVFgs1F9FRTvIwCyfNh4EN1rn1vdeWje8ccjtL3+QjSo0KLt4lcXI95arB85
        cLXjKfj2znsnEs2ATSJNBoEx85duqMgeWk78TO3mjPSXHlq8SQJ/iYkkpP0UDWIkoF8l3Y6EZPAvm
        q8aKXFIXluJIzvlru5XFsVYhuiXbT+xjdKgXLJYu/v+ckDC+NARYySSBZti/BZ47bNDuU58RrtcBp
        WTOY/vXA==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCybf-00AgdT-QS; Mon, 09 Aug 2021 06:18:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 07/30] fsdax: mark the iomap argument to dax_iomap_sector as const
Date:   Mon,  9 Aug 2021 08:12:21 +0200
Message-Id: <20210809061244.1196573-8-hch@lst.de>
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
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index da41f9363568e0..4d63040fd71f56 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1005,7 +1005,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
-static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
+static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
-- 
2.30.2

