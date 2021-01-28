Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAE306F22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhA1HXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:23:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhA1HRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818469; x=1643354469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gllqHMP2deuE0vZ0qLUvAasM9UgJt1wGssSRSahQx/E=;
  b=jZqg7b14awjkDww1zhHpLRzb3kL7E8WjIcBJ5nFM2XiRsE04oIQklT8x
   XR/s9k9cMax2HCqQUno5fEMDg45ZIWxoytY9CyJYnmQLM0QxiQH2pccA6
   8svwn4cxwSIcmbdsmUD0i+ANgrCcwo/dNJyBkjWLyXRJJzEGJJ6Eufcdz
   gsqi42yg42OjhIf3hwusBkzXQkrOOVK64SPI8/1EAvKKIdt0UXf5dt/vE
   n5OtfT5TcXONIrxIlrOJo6CaqqDMYQC65ncdH/JYmBBeDvQ+S2xkNzvc/
   AhtzMgFeajyprf9bOzru8ICss+0yPNxnRoQoORy7dA9s7q/oRYptws3o0
   g==;
IronPort-SDR: i7UYWM5gJO0n5ylMYKXu+lqPqWEUkpmId0oK/F2ZDyRwvJaO6xxMV4fB5Uau35FzGYaZdqTlby
 LsaoWQ6xKNGOj1tGk8pxROc58F9zfsyo2r+bD7gToTUPAg3amHa2kUfvyz3zXtzbuq6T5jB0zb
 sgaLMtZ4F7Cw2t88I02ITBRodGs9HRdtmngNvagEzPTdowTSBD0GL6JNG+j7W02z8xcPzUujz5
 b/42Y2E1z/7wgIwA21GPuWVXWK01cKUFYkNu2vdsSkwoBOThhFjrY+67C1KiosUQLSTRJRCPBh
 Cu0=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262549245"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:19:21 +0800
IronPort-SDR: VVn7p2oirJFetn+fXn8SdScJXtaPX6VgF60wxE3EFCJvAIKUqakQDO9uK/nZ2DfOpok2GQ6JQ1
 ptqYbS2r5Pg99oUjeGdp7lAK44mc7gyHNDFGw0h4Cl77gBfHVhOpOH3ItWoRM0K4Vo4oX8FuCd
 Cl8Hb8oI5syw4uyMAj+N9wTmYBXHyF4pYnHnjwL9Xd/LuEL8qeHErDIahn/62PJOxrBugxq2AQ
 G+WMV7LTDekg6zNIcTkPHO6p26QYLZCZY+M6px0lVX51PJ9z7Mfbf+DGkEeUQEIogr8mLlLao2
 FyA2ZRLuxpG+snAwC1WtJ3zZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:22 -0800
IronPort-SDR: Grws0RkRukNGo7nyou8ZmIctRPf+YpsLcKEKHc3Y9j2gH1wu+DvtqTycxE/+Um75XSsvYHsJz2
 XuCl7g+xJPknbJtkfE6+aL2ksGkx9esZlvJSCaOOok8lPoOpNpuMTJUvJF76PXh6twtzc4hV4l
 Ck271Nzyl0bN3jPxPpXSp854weGQ+wyoheQ1qJh2ewh7GEZUQlec6Cx5gMyzUS7NDfOacpsNSA
 i4cQzL4qbQiTmP11yVUjlWBUXU4/5eKNIGO+C/0onsAsvTsPxAAYkHYwd4fug7gJV2TpCU6JnF
 3ZY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:16:04 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 32/34] mm: use bio_new in __swap_writepage
Date:   Wed, 27 Jan 2021 23:11:31 -0800
Message-Id: <20210128071133.60335-33-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 mm/page_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 92f7941c6d01..25b321489703 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -342,10 +342,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	bio = bio_alloc(GFP_NOIO, 1);
-	bio_set_dev(bio, sis->bdev);
-	bio->bi_iter.bi_sector = swap_page_sector(page);
-	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
+	bio = bio_alloc(sis->bdev, swap_page_sector(page), REQ_OP_WRITE,
+			REQ_SWAP | wbc_to_write_flags(wbc), 1, GFP_NOIO);
 	bio->bi_end_io = end_write_func;
 	bio_add_page(bio, page, thp_size(page), 0);
 
-- 
2.22.1

