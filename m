Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A416970C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 06:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfHUEHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 00:07:35 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17887 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfHUEHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:07:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5cc3860001>; Tue, 20 Aug 2019 21:07:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Aug 2019 21:07:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Aug 2019 21:07:34 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:07:33 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:07:33 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 04:07:33 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5cc3850002>; Tue, 20 Aug 2019 21:07:33 -0700
From:   John Hubbard <jhubbard@nvidia.com>
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
Subject: [PATCH v2 1/3] For Ira: tiny formatting tweak to kerneldoc
Date:   Tue, 20 Aug 2019 21:07:25 -0700
Message-ID: <20190821040727.19650-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190821040727.19650-1-jhubbard@nvidia.com>
References: <20190821040727.19650-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566360454; bh=N6ccyzf5PMKW+koaJVWa/WJ5yd4Gtcd+1v71ttVDCNg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=kyATeI4GvI0wM6LrUvgYcUuvVkygFA4JyTgW+0ZbIfoMphOLUP79l03d3VBYHsz2s
         1CY7+MAZotjRlkUZf+gs3dpdA2mi38fNQj7WAuTHr35cgt5F0ODZXtOnG4BQ0KpeKy
         mx3iRvuI/rW4Jfnk/+2cwoElnxfMi8e4QwgNR5vbt3BQKBCNfotmHIM//RX1LyEPOW
         DHW1oHlGkyqC4At7gax4YXMnfwFq5jRR/YEsU8tlZ/yOAhWfATtCG5Okf20bfeGKGU
         w9byaMIBr4MVxT8h+4jI9vhBtdxj/dXbu80/v5ryCzlKcjbcNAi36pz6ZKsNKOwKvV
         ugMEds1/mnrEQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

