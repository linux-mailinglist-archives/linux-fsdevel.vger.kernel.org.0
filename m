Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB333E3FAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhHIGSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHIGSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:18:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE8C0613CF;
        Sun,  8 Aug 2021 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ULc93SsR0oFAbcorhcrkpFeyrZ44RhHMjBbf3slQRNk=; b=KuxRfsFSfwtRwpyjNugPsO6n/J
        gt4oI3L96fDSgdvKTTeoEfJex/OZ2h9JQPFeolffpp4n5iV1xoBksAQijhj/42mS+Cq2o9/fCg91V
        RRsfRg94yhnbWUG3zuDgt8kSWonG3vTc5oOR5TVvr5ALYRncjNMYxV2APcRTrK02VtikM/2nJvWEv
        f95k0cMO+C9KFObvuyAQ+0o03zIoKCvkMGmIqaV2eD5Le8aHYjIBcELyO6YuTd7IXtrIvOaz/xcFK
        bFfBTejf0FkBpbghEWTQK0yGee/TBinkZ1jkrCwA39PWjbqCM6ndSGNeDeDNv9KgJHKR/eft/PUOi
        PYiOv6CQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyaH-00AgWJ-I8; Mon, 09 Aug 2021 06:16:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 05/30] iomap: mark the iomap argument to iomap_inline_data_valid const
Date:   Mon,  9 Aug 2021 08:12:19 +0200
Message-Id: <20210809061244.1196573-6-hch@lst.de>
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
index 560247130357b5..76bfc5d16ef49d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -109,7 +109,7 @@ static inline void *iomap_inline_data(const struct iomap *iomap, loff_t pos)
  * This is used to guard against accessing data beyond the page inline_data
  * points at.
  */
-static inline bool iomap_inline_data_valid(struct iomap *iomap)
+static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 {
 	return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
 }
-- 
2.30.2

