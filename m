Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6A72A06E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgJ3Nw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21969 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3NwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065943; x=1635601943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ZABgDOLOrs+rLLlJ5W237XDgbrWRnHoebecHstMnyg=;
  b=E74CDCL9fMwLY/CO1HV37ml18vUTfcN/6bEGXdS3IDatxXmvZFazokik
   0qAHlVFU3OaAUs4GHFZGOqYPDN3iB78iQGZtUa/EQVBWZ9kFQ4T9rjU8g
   Amf0mYJNTZ8FzPT+/FEVitbjWXa1ZuVtKtWC9dS2TRJqsYm/eVpXJS1FR
   HTNjWV89Nz8reVu2g5VO85koQ0agkt+GHDCY906guvwxiAq9hRriSWGqZ
   HJ3eQtXY1Nd4gzS41N1PaQKj7B1Syk3FzqNauLA62zqs8gBeBjGkbtSUp
   9YTixO7Vpq973XTOK2f+KIm+qL7zbuJmUsDQxyAW7YG7UDyQoHAaOQjnZ
   w==;
IronPort-SDR: ol1eygZ3kOOkWOvbDHiqIpkhxfoz6gsUAVqp4tUr2LAlEyoPxCv5B606naT2OS0AVi/ZTABgC3
 t/x40DDWQleoy1OZjiwREKpyIhBGbUbchvFJzhij2V48DfyGEWCS7M9Gm8XBJZ/3QVHSb7dn9f
 U4htG+cI5AhOD1rUGo7kSRjc6AlLHo19M1oNcBWFj1AyrNGktVdEqzyEzJlRd0YQrGGpLryZq2
 ft/ubdScAonmiq05kGRHmQSD0s1UEvMWLUa62KfkNwLXGOpWintb5LwcLVdYkYxZtABdEwfm5D
 aWs=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806573"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:23 +0800
IronPort-SDR: T8aaf2usyLXdvDvRqqF3VzuTE4sCfmcbQBqgSZZkVCc02zFgJTYvRtfPs8B9EiF+N8th2ehLgn
 NFdA5PaF/qcIH34delFhCRt+5YDXzN1P+hLwa+LrOEoGb9N/LMQVxfEyD4ieAU/oXyehQbxCOj
 PDST9kWCVQZ3Yg5rAYdrRR+JsqlJm9AzlQ3G1oAU5Pegs5rxAEv21u8CqQ8+W++z6LDZPxh5T5
 gXr5mv5m4FmE2Eg5Z5zA6AeJrpH9k6HJnd6GqVDhVDtfzQ3mPdGRzc1DjI+5H5HZNm4y7aCJlf
 xZae8tfPa/gr9fAQmamxpFLe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:37 -0700
IronPort-SDR: noWgkHUxjtaSgnGZjmNtgHrbLYWetIWjhxuBiDzqZDYnXgWrLskwG3q9vM16A1VWTI+PkbRr68
 5rkwU6h6+4BHolzl5dAz6uklUOTvYexQn/CNUycoSV9fniMbwPFYtDcymPqOOz/BgcZaNQIxYU
 1k0VVWel8aQHEsnD85T1CyitH2Pu566VcgULWz0w47E8lH4hjYq7yoPYTeEh4eJDedrq5gKQ4L
 k6vQy6wLkaHmC8ny8pnOPo0xGdutMVMhlT/agJvJAiyuI38g79ESRy174WXHpNJlryAdaE6ece
 c7s=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:22 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v9 02/41] iomap: support REQ_OP_ZONE_APPEND
Date:   Fri, 30 Oct 2020 22:51:09 +0900
Message-Id: <cb409918a22b8f15ec20d7efad2281cb4c99d18c.1604065694.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding
max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds
such restricted bio using __bio_iov_append_get_pages if bio_op(bio) ==
REQ_OP_ZONE_APPEND.

To utilize it, we need to set the bio_op before calling
bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so
that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND
and restricted bio.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/iomap/direct-io.c  | 22 ++++++++++++++++------
 include/linux/iomap.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..e534703c5594 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -210,6 +210,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
+	bool zone_append = false;
 	int nr_pages, ret = 0;
 	size_t copied = 0;
 	size_t orig_count;
@@ -241,6 +242,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			use_fua = true;
 	}
 
+	zone_append = iomap->flags & IOMAP_F_ZONE_APPEND;
+
 	/*
 	 * Save the original count and trim the iter to just the extent we
 	 * are operating on right now.  The iter will be re-expanded once
@@ -278,6 +281,19 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
+		if (dio->flags & IOMAP_DIO_WRITE) {
+			bio->bi_opf = (zone_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE) |
+				      REQ_SYNC | REQ_IDLE;
+			if (use_fua)
+				bio->bi_opf |= REQ_FUA;
+			else
+				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
+		} else {
+			WARN_ON_ONCE(zone_append);
+
+			bio->bi_opf = REQ_OP_READ;
+		}
+
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
 			/*
@@ -292,14 +308,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		n = bio->bi_iter.bi_size;
 		if (dio->flags & IOMAP_DIO_WRITE) {
-			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
-			if (use_fua)
-				bio->bi_opf |= REQ_FUA;
-			else
-				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
 			task_io_account_write(n);
 		} else {
-			bio->bi_opf = REQ_OP_READ;
 			if (dio->flags & IOMAP_DIO_DIRTY)
 				bio_set_pages_dirty(bio);
 		}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..1bccd1880d0d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -54,6 +54,7 @@ struct vm_fault;
 #define IOMAP_F_SHARED		0x04
 #define IOMAP_F_MERGED		0x08
 #define IOMAP_F_BUFFER_HEAD	0x10
+#define IOMAP_F_ZONE_APPEND	0x20
 
 /*
  * Flags set by the core iomap code during operations:
-- 
2.27.0

