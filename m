Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2184324AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBYHEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:04:55 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61594 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhBYHE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236667; x=1645772667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d651v85zCDRiBFcpLwJk/4ElAAp+r9REzayoZ1T+uy8=;
  b=S9ZrQrSe/0YdgP5VVm4QV/zYpsco+cWXJwQEslte3kJhxOPq/QhVibGC
   AK8UdFfbP4gLWw/Olv/0D28Zj+EhuvO+uwo4gZbkGY25EHSmAaXRxxLg+
   r+lSNVVpc0rIJgpdCOR2NJ+pHijKDIGzAa1LgnJIwMXPza72QyH49434o
   2LQrXX83G7ljetVSOc58bHa4DzzW0qCCCQ5A0DJRN0FD7Iqfu8KMDuEXY
   Jio3R2QoU9+fJ8CIubd10l4xryDKTHVrGbRj71fNpOIYhR7ynnTrYYw39
   DPhKPqOfkBt1b8BisFTgqzc5X7JPDMSDAJZKeLlLChoDuGxSnNiDqEFU+
   Q==;
IronPort-SDR: Fh/jv3+oTnM1C1PGV6JsYQ1TI/v1a9vY6fW2v6FHc0i7mIXrMFaqbT6J2DIYG4TlCqjKJjpsDJ
 4CewgS7EnaEDZ+zIoYy7Y9csPItnoo8RnreTG9p2pWCBOpppx/6caCZpvnWIhzB6isPhqKJgSx
 lwRjLFSdOHzpQ5kmvhnH56pKwQCH4LymaCxSNMdpDdaC4r2gVwWn/mUXtSBPfQYSlFNfdRCHls
 zMu2NPNzonOc4mhmXtZx7kmQW3V/fMcrLsI/grRNLbOKmQH5dY31SwwxIxMhE9SAtPKg095HG5
 Eho=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="161931329"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:03:12 +0800
IronPort-SDR: 09yDS0cB5LCtQmX/ZybKorEU7GvQnGqxdFAb6qA2AxABInOExbD/xKRSl/mKEZPZUjMn+nkMjp
 bOsQl+7JlEG4uq7EvNmFy8bAPu7fn1jYeNwCDL4wCUWvyJJ3QP+aVTLkYBjZ7PslYK1rUuCbl9
 2lxZg4leiWht117q+XutvXjWDIAEkMxplVHX9ffPwEg7ytINJWEmJfgsoNzmFJgz/0zUk7b25a
 1EFrMT+FGDvldk38yz9n9qID5P6CLqkUfxv4QSDs47wQ8kuIP+GsyB4M4upTmrBNiVNBfe0ifM
 rCQb43/N9k7YxCx5zGQNEFuW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:26 -0800
IronPort-SDR: 9iMZnrTBci9VBgi7qsOF6VGkQpmaHLHmW4QDyTlgIRxHhfj0xFHTkrxqZ9A4lnEsRqL1UwmCrR
 lK5sDvsne+COA3w8XYPFoZ7tQUVYgBDYBK/bEIMv2V66DRwIw1BHkzuzznYX7DYqXRpUR9NMTL
 5JvNmkqY0n4U03edOc/1VVYKiQ7hNg1Qxsy8XxusK4qNEQheFOea95/0XPHi2PiBbfHcmIl/ro
 MsLIe8WLtJ/4k5Ks2lPJFXDICD5x/w1lpkuZn9Rk48yIfT6LnlmjKidHiKR/j2TpDwSkN5X7zW
 Yr0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:11 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 03/39] blkdev.h: add new trace ext as a queue member
Date:   Wed, 24 Feb 2021 23:01:55 -0800
Message-Id: <20210225070231.21136-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update a struct queue with block trace extension.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c032cfe133c7..7c21f22f2077 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -533,6 +533,7 @@ struct request_queue {
 	struct mutex		debugfs_mutex;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
+	struct blk_trace_ext __rcu	*blk_trace_ext;
 #endif
 	/*
 	 * for flush operations
-- 
2.22.1

