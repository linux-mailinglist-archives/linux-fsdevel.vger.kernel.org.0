Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F12AD528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgKJL34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgKJL3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007781; x=1636543781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6m8PjvRrTOtZX6WwjPVwecIv7/RxFMU445Z2iBOh5Q0=;
  b=JJmrsBkW1we8QHNB9LuYnUxfEZr1TwflrgVDauBn47DX4f9UK5jIGcwR
   BApNA8Hn4h85zXMc2AJBTMquNIE5ywlSBBfP2oQmINMa90rgbMLEeT8AL
   1DI1L2htY6cPQoickf7tERyCztKeRrowoSY8QXs0LS+FGOZigk8kAQdB7
   rrrF8WwEmS8eAdqe5n3YsfIh011s0t+S2qNSjwVzLEVyKKdLMsxeKgsM0
   EeHgrwxj9LCELPc3eb+R4yBFCvAfGr7UuWg1OW3n05Poi3nqzeNVhuRse
   qND/pAbVwmmVj9bTemmsA5i+hCKzqSqnH0e5DDe0ZNuOU4nOGxOreT0Ff
   g==;
IronPort-SDR: +tfKEwd7ahUIWwHRuEptT5oZkcdwD2MkFx9Db1FMp+48gDDBxm2woqypqi3Oyq38Oisd6PP3vi
 iv9YH0KPzhPl8WQ88qs728IfJCgNgHDkEyUFbOlG3RRFlpeN0FB2Bp/oHIZwoVhBldEP1Y/5AF
 3KIVX8tnhCdxM4dgySRp+4xTPXFvepUaFonrHStt3QOnhOuO8iUR5016LaKG8za/OaL9mEIPXY
 o1ls5VL4DWMr/YAg9/9DUdctus1h9hj3SaZbVi4Vi9O6TNHtO/S6xSonegiPij3auaGR2nvToz
 /sU=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376740"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:10 +0800
IronPort-SDR: rQEFe/b5x2mzN1Lt+aqZiy6ci6WfwFew2QQTS7SWVO/kB7YRbL5LP8ho3/vsEHsTmfIsYjyAea
 vq9opKPmitKBjUonYp+tDQNrs9KI2ivemhHZeOyUt514htHpXVQyP75nTsBFiR39O68RShDMDh
 J4J2L/wvsW6vzSZbr2m2hYvjVKIV4kLWQOn6QJIZmu4MZoNd0+0hPcDpANZf8IEZLUdrpyu/+J
 lgtOJY5V9Z7ek1W6U795wwKTi944UKfFkxOdMdI5fhOJNNTbF4QykpclAn786Sr2HW3Gvbk4gr
 Pmz3HlXMMDXwqIpLIXalS+xx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:11 -0800
IronPort-SDR: rOfT+k2lcOdioOaRf1KbwMRGCFGjiYfAq/dN5GmaVtcjTU7XdRndBsGSzXoton7Ke68DJPhpjk
 TBzHXFYlLZm49HeipoBJ4zRe2a13Oipa+zthU5hqHx3q492IEIVNrbiWGjoor9NcXU6uzYN1Aq
 7ZHxtIZUYAtjg/t+VeagtEG50LoRZ4nBOTkJrqCb2WFk5DNvhnTYI+5flrt/84a1UAwsimAMf0
 XvfAcjDGxHHEjrTeK1qZ3N461HjfFKMKSzMKsDalI/a9T/cM2s4kBJgF/RTZl1nsAo+66tudbV
 Hcc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 40/41] btrfs: reorder log node allocation
Date:   Tue, 10 Nov 2020 20:26:43 +0900
Message-Id: <76ce2df7936106a806f05e5e3628c586bd7bc62a.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 3/3 patch to enable tree-log on ZONED mode.

The allocation order of nodes of "fs_info->log_root_tree" and nodes of
"root->log_root" is not the same as the writing order of them. So, the
writing causes unaligned write errors.

This patch reorders the allocation of them by delaying allocation of the
root node of "fs_info->log_root_tree," so that the node buffers can go out
sequentially to devices.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c  |  7 -------
 fs/btrfs/tree-log.c | 24 ++++++++++++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 97e3deb46cf1..e896dd564434 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1255,18 +1255,11 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
-	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
-	ret = btrfs_alloc_log_tree_node(trans, log_root);
-	if (ret) {
-		btrfs_put_root(log_root);
-		return ret;
-	}
-
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 505de1cc1394..15f9e8a461ee 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3140,6 +3140,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
 	root_log_ctx.log_transid = log_root_tree->log_transid;
 
+	mutex_lock(&fs_info->tree_log_mutex);
+	if (!log_root_tree->node) {
+		ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
+		if (ret) {
+			mutex_unlock(&fs_info->tree_log_mutex);
+			goto out;
+		}
+	}
+	mutex_unlock(&fs_info->tree_log_mutex);
+
 	/*
 	 * Now we are safe to update the log_root_tree because we're under the
 	 * log_mutex, and we're a current writer so we're holding the commit
@@ -3289,12 +3299,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		.process_func = process_one_buffer
 	};
 
-	ret = walk_log_tree(trans, log, &wc);
-	if (ret) {
-		if (trans)
-			btrfs_abort_transaction(trans, ret);
-		else
-			btrfs_handle_fs_error(log->fs_info, ret, NULL);
+	if (log->node) {
+		ret = walk_log_tree(trans, log, &wc);
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(log->fs_info, ret, NULL);
+		}
 	}
 
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
-- 
2.27.0

