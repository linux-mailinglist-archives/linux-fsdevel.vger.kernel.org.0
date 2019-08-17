Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD65990C1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfHQCYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:24:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2876 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHQCYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:24:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5765580001>; Fri, 16 Aug 2019 19:24:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 19:24:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 16 Aug 2019 19:24:21 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Aug
 2019 02:24:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 17 Aug 2019 02:24:21 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5765550001>; Fri, 16 Aug 2019 19:24:21 -0700
From:   <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH v2 1/3] For Ira: tiny formatting tweak to kerneldoc
Date:   Fri, 16 Aug 2019 19:24:17 -0700
Message-ID: <20190817022419.23304-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817022419.23304-1-jhubbard@nvidia.com>
References: <20190817022419.23304-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566008664; bh=vujlpEbUPcZOIHM0E4+H2IssxqbGZn6F4auD5+LUKwo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=UrOX2DWBxcLHfSdWH9D1O4EqxSJYzLmgQW88SJBsz2UXDE9uNYezznYJFM9XFY1+R
         yL20cRMLCB+M51fikAto9Y7iuHTb2RxVyglHrqlQWYjoP7bj9A8Rbm69Yb5Kz0biu4
         Di0qY0Zwu6Xhp5HVhjQFdLlH/yP7SgnWMEQx53qsQp1ClujvwGwtwOwHdduYJ5kBaY
         WzHujmy4Nfh7VqdbvTyufzCUrO7xgAmcDs12SRcm00djT2WyKpcPNOhiFrnk9HdML5
         CGgFJOMySWlq3Tg1MLyGwnBseQ04uzqWAOAvEWfm/gTUp1onvO5OfqmzsMH55SwGm8
         uhx3wILje553g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For your vaddr_pin_pages() and vaddr_unpin_pages().
Just merge it into wherever it goes please. Didn't want to
cause merge problems so it's a separate patch-let.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 56421b880325..e49096d012ea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2465,7 +2465,7 @@ int get_user_pages_fast(unsigned long start, int nr_p=
ages,
 EXPORT_SYMBOL_GPL(get_user_pages_fast);
=20
 /**
- * vaddr_pin_pages pin pages by virtual address and return the pages to th=
e
+ * vaddr_pin_pages() - pin pages by virtual address and return the pages t=
o the
  * user.
  *
  * @addr: start address
@@ -2505,7 +2505,7 @@ long vaddr_pin_pages(unsigned long addr, unsigned lon=
g nr_pages,
 EXPORT_SYMBOL(vaddr_pin_pages);
=20
 /**
- * vaddr_unpin_pages - counterpart to vaddr_pin_pages
+ * vaddr_unpin_pages() - counterpart to vaddr_pin_pages
  *
  * @pages: array of pages returned
  * @nr_pages: number of pages in pages
--=20
2.22.1

