Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9941165C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 05:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLIEOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 23:14:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfLIEOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SF9IOwLxSwRGjukZUPtaCFZ3lXUWkJ1FWi5NUIOe/7A=; b=InVNSIxeWARwc4hooWx/ysHoc
        UL76uin7ij551NcZAOD/aflRsdPq2BZCB8vsXbgVkK0E8BUiaguCJoLqYcxtEL85J9R21WEHD3Daq
        2mXBl/1tSbFhHiJoXHZlRuDtehm5dQMHtmix6jDNQFW/o/UVD+rrwR8cq/u7QYj8j+xOgJKthFGs3
        S5cP0+3+3r8wNVcPtARhlzIoezRpJzGyBmMWsPPDnN2NsUC3rzb5PEJzIH+uI5gcKUhFk/umu/auf
        CAXanrgZHNUUU8vmYgW0icAksjFQ9PdA7aklvlnq6cc6653DYhesk0KtW/q1NjnIfxuK0Sbc3YbTU
        /drRIPilw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieARQ-0004Sw-Np; Mon, 09 Dec 2019 04:14:36 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] xfs: fix Sphinx documentation warning
Message-ID: <bd3c7d7e-2859-06b0-a209-7d19f7c2e79f@infradead.org>
Date:   Sun, 8 Dec 2019 20:14:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx documentation format warning by not indenting so much.

Documentation/admin-guide/xfs.rst:257: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
---
 Documentation/admin-guide/xfs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20191209.orig/Documentation/admin-guide/xfs.rst
+++ linux-next-20191209/Documentation/admin-guide/xfs.rst
@@ -253,7 +253,7 @@ The following sysctls are available for
 	pool.
 
   fs.xfs.speculative_prealloc_lifetime
-		(Units: seconds   Min: 1  Default: 300  Max: 86400)
+	(Units: seconds   Min: 1  Default: 300  Max: 86400)
 	The interval at which the background scanning for inodes
 	with unused speculative preallocation runs. The scan
 	removes unused preallocation from clean inodes and releases

