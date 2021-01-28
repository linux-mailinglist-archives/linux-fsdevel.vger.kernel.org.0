Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FD30701B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhA1Hrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:47:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16178 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhA1HOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818069; x=1643354069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ph9rmwEURyYiJjcGgT3e2aApJZNJOSNpUoZqKSV1dx8=;
  b=pJMUZ/TA7QW66Su4KiMTkGnNml3YVmUUXL8FvT8CWdTICiwHzy9SUJgU
   TXjv01s14flrBBaAWvQCHWHoUqsVCepyQjaDFITyhZsgFhYPBHloIZTzM
   2EQc7MhOi8srxRNQauLUVgz/5M5fqP4eBrAl+OGRbvhBbw7Sev9QUzoif
   KRtCtrSR2H99NfodJZJYqJoyNHl1tuVQB5jmZlyQLWxmIxrsHpNXHQIqd
   FJxr5pKKjfSbpyxxyZs3CoMVAgTLrnjo705cCdhij1gPkeKMQGxh9ICPF
   bMJTJGrolKJhY3d2wuZW5bJ6YX741pV1Ij1jfB443zKvCIEF9pF6ytaT2
   A==;
IronPort-SDR: lcf9p2uMFMIQ4CYiIHDn5mNGpTbTZCCn0f0ivhToVYYSKxrf8wIHbddGTOsN4U+N2JCC3nnPtV
 R5IPbH3jOTlOGweI4woPUn91rtim3bq0l9QSsQaKQUaHVZEUv1i17Jj+wYbMsiZxrqzzonOA+/
 DwmJsnuswEkJBO6uSo0XqAsHCgpDU/zrS+9amx2t+nE84H00X9I5IPOtbTOaY+lAJI7S0Fwa5e
 nbIwpPFBn3UFF4YtxjGsP2HG+euzVSUU6GrQcrVu7PfXXzDXu1VH3xuijCHi68BRrSCQ/H0YvW
 gWI=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158518223"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:13:46 +0800
IronPort-SDR: gPp/S629irXe814+J8G9e6MHJKqJNKpnUqAM1y/LeHgiLbikxha+8BAL/UznFME/M5OB7/G3vG
 J5EeYChCOXgZyygYpcXpDUW3RDmDYFavuqVwHZDINwVecUK8Cilp5FB6kBujbLcTJg31wvhLnR
 xbKKqNkSoAedi9D1sKT33HHJAIqME/Gj18ByIyV7ZWQbUnKOROj6Q2bGYcRHkVSTnwS1W5jKvf
 mSoYQxhX3K6J6/Ge+/aUZm9bFuDYUsTU2TxMoac6K+LjiuYwUwH9G2aVqgsXC90h4JSUY2cuJ2
 O+0wpzfcfbXAdYMQwniRzJNA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:06 -0800
IronPort-SDR: 2qgPwD8neR80/SdtH4pRH50bxmDr7msnaiMmu0nET+XLf24Atsm9LH9w2S7p7pMRphnBeo5pVx
 VOFkyyTuzt5tWdOljMzaLRlQ/2Y+vBgbMl5P6BLyAgHROT8V3ajdo6WQ+YwR34TObygZuUERZX
 rfU+sPmHgGS1V+3dgxOeo8REERCKgWHIYxzhiuWRBtY6dBheQaeAr6VP4LTAPeLl+kd1iFUoyd
 mqKwU7dlwbyE4M8F7GURh/yglDYKxcs47wr8oitkT1bgU4EtSPSZoGcLrNM5tqqKQP8I79UW3Y
 S3E=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:46 -0800
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
Subject: [RFC PATCH 14/34] fs/buffer: use bio_new in submit_bh_wbc
Date:   Wed, 27 Jan 2021 23:11:13 -0800
Message-Id: <20210128071133.60335-15-chaitanya.kulkarni@wdc.com>
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
 fs/buffer.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 32647d2011df..fcbea667fa04 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3023,12 +3023,16 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
 		clear_buffer_write_io_error(bh);
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	if (buffer_meta(bh))
+		op_flags |= REQ_META;
+	if (buffer_prio(bh))
+		op_flags |= REQ_PRIO;
+
+	bio = bio_new(bh->b_bdev,  bh->b_blocknr * (bh->b_size >> 9), op,
+		      op_flags, GFP_NOIO, 1);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
-	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
 
 	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
@@ -3037,12 +3041,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
 
-	if (buffer_meta(bh))
-		op_flags |= REQ_META;
-	if (buffer_prio(bh))
-		op_flags |= REQ_PRIO;
-	bio_set_op_attrs(bio, op, op_flags);
-
 	/* Take care of bh's that straddle the end of the device */
 	guard_bio_eod(bio);
 
-- 
2.22.1

