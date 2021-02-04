Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3830F0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhBDKad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:30:33 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhBDK2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434519; x=1643970519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zeq2M3/a65vBJPrd3OlLIz4zmQghn50s1Ztj4AnIRcs=;
  b=jzBxmbjq8W+pJpUxQlUslJ1T59SaZKz2tQast7UthG8OE0ZD2fAab4nC
   tKuS4xwXmoT+AIX2PjbOnMw5YAHk/LGLnjlRWjB6PKUKysaJLnOnamtIm
   Fdj2QbPsZHaQhAoHkTR5HqD+DkCusLA6T5MdxKMPzjUvqTaJzrGprgZJu
   MVZU86UcFFmhbY7XuPQhhXL9txocODiCf9rEBzzUISE0WirGAvNRAgHC6
   ExzgkF1NXetFZqiMq8a66W8UFTco1/iaFe/o1JoSzBlx9C+2/QOFgkAi2
   g2zAMQezmLJSo8iyA1jl4XllDhHnv927dSfcCcEj4qAnQApuKjpDGoiOc
   Q==;
IronPort-SDR: g0Q0PfDjnp5W0Dns+hKCxdQeY2FUBvkKYyKjMGHfI0RPunhkX6nl5qUmb6hbykGr3DrnHbGSQV
 ezjKXnWCTkP9pGE2Mja9AbHJOTaoRUpYtcIsJjXDs2k6BAb1c/+QUYKiRxRPYnBscCz4etYcjZ
 VOaog9dSE1IhH+YQws7jceMFHK4mqzDMfN/Ms91OVd08AG8SR5hUHCNuC2Mx4ozKiwXHf/7U5Q
 LMf9d0WOinaQsVH3q2+Nx4huvCdw7OLqb52yOaqWCCtSCgOyPS7ucgm9KTZmpGZFPanb+hMzre
 juA=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108045"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:37 +0800
IronPort-SDR: cBA78nPkqfESplqjiAQEc7SLsM4A8jut1gzDn9sGxvzYWbzm4A11k6cp0KQse7hGh5UDxn5vEl
 8E/0hOQEO2oqUMunRtDuePIaRHui2ZTshF4TyeT+bxQXn8HxcvJb+M3/jfXu1yVJyiw/LgMgAT
 IJoVZ+nnDJX3g6Axevt4F9uQ2u8CNYoptjCEFzTExojH8ntAiaeK5gzTxlgPDv1dOKkdZcyx9w
 O2uys9KPyXPGU+6IeQSRKiEBmMhozUsbRHTjFbsOxRcJQGfLamDXDhkQw0IBTh6S8Uo06GSQE/
 HDv27IWtSHv/zmamvPKLZcky
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:40 -0800
IronPort-SDR: TjVNHvGYSJGSMTRCsMBNd5COq+IduvWtYcFJX7L6wACWK9iVSKC2KPx6C/lNIGjo6xGelq/Fdc
 Vc+00sepCMUeu7RNIVclk4w3hOx+9qGbXF+K8ORttY4OqtrFxDpP8wKShwwHGlzYSXWTUQHNMQ
 Naj1WAa8PwhrmmH+V1MSpVmvGCI+4/6dwMrpte9eQ1a7Iq+uxxLDJvJpPVmSRjpDCaaCT6sD6a
 xBy04o5MsoumQF83UUOZGjSwu35Wl9j3yRnRb2cc7TfJ5C/gAu7Q7EIyarRX8DFPyms/+L8KhM
 E9o=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 30/42] btrfs: zoned: wait for existing extents before truncating
Date:   Thu,  4 Feb 2021 19:22:09 +0900
Message-Id: <e87dfc529b4b2f830f240b6b5d690a43b6ba420b.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated. Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4779cde83c6..535abf898225 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5169,6 +5169,15 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_is_zoned(fs_info)) {
+			ret = btrfs_wait_ordered_range(inode,
+					ALIGN(newsize, fs_info->sectorsize),
+					(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.30.0

