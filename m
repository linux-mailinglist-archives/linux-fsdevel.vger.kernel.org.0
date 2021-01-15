Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B242F7353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbhAOHAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:00:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbhAOHAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694002; x=1642230002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6YHwAG7kXo/LlM/7zJUdczbFgCU0tQ1zureC3L547I=;
  b=hdrzuW7KQkz0yoQygK/e48CRdJiA08mgw0yYn+45nS8dMj77EPuxt2KZ
   SdRXz+elTqEO4l7iY98Fcg78q4zqciQguaR2qRxQv18Y5LXiC3jcY9vb3
   hgMmurz4TEaCwCNnDLlDkt0zMSEUzJZqkI3AsXrA16eyY0unX8esRNgUx
   cqqitloflpqpkyGmzD9x45gUf6ttLBkfxtSZPIxRTab288Wae1F9FmG0I
   F7vj9RiOTC3Qrd0j1k1zc2WzH6jOA7hSfB5olXZK933BNREEa1D57eCkK
   lNKuKkrtY5fV7ZDiwX/+8YuUSYsSqLnLiidE9EjTcnaxqy5u1LJEveof6
   Q==;
IronPort-SDR: pfxwGNPI7mhDhNVfuylBek/PHPWOvch5SvY7JOEJ6jj4D0HTjquKhJYq8JBu08rPF81DLI18Ha
 /jr4RTtgsZKGyUZKUdTSLQE+YCRqGowH8wlLuAv6QifoAXcKF1D6yCXLKVojC7ctLxRgcVmMe3
 ynhe0jCpCt13kodiSN8Lz8d7KZ2lzcX6P8ftW0fenbmymMnJNoqJMq7wHyXkCja5mNpt7veBIm
 cYix6giBExCZjWWO2ssYL3AtQfuMylOG1L6aBT+7MLUcaO6hQEA4qA3oCp6UQw0Sz7tqQPm70z
 Olw=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928291"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:05 +0800
IronPort-SDR: hebNwMZht/Bw3Ei6b3nBnd8sIWt9LGSeu9k9r4eABKjwBNYgW2WV/N2IXZy3v2rsnGT/TdAhIm
 +xaXgaqmG/XC5KM3POIPwDEYaq+IRaFJo4h5dKPefTZxF7VTRFe+SuZKa1LtQzrvnE7nh7ZpUN
 L3AblFeBRZmZAt1BvLqT2lzESWPWXROrPeiUq02TsrNhXLnCifkvTGOzgBUOomqSKRD+B23Nku
 uFf+FC1sFm7Ngekf/FzfsTy2gA9lgOdUyFMyjn56Nyf92kFZnU+OTyyKm8SvOykLqv1D+aUCiq
 yECFUDBv9kOtic/weIYga5Au
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:47 -0800
IronPort-SDR: 0wJLofFV4VDoXeucziSPaP/L+1AtJeDQJgwmHMhIcTCdaastdrBJl0AEqVliivtYTBCEkhGipA
 9rEu03N2m/W7x2muIM/cfybSI8IpjRNaoemvN7f6hYgf/XtlrB0Ds99ObpOwZoJJJUckAAPyMY
 JbmOecb3CI3mE0rUbOlFz9kcSPhjxScGQCLY5d2emQEgoVmNaXFwbeh8wwdXtF/I+UqGMj48/p
 /Io4ZkyE04QJmtui4Z1zfmd1KF0GJvPxrgxAqnxaLwlK0AgFI9IKvfwDuNqkbZRm/EL99Ruxfo
 /Jk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:04 -0800
Received: (nullmailer pid 1916480 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 30/41] btrfs: wait existing extents before truncating
Date:   Fri, 15 Jan 2021 15:53:34 +0900
Message-Id: <278a7c8f77cbe67e3d36a91e24c9390eec8f0a39.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cf84fdfd6543..4b29a770bfa5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5136,6 +5136,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_is_zoned(fs_info)) {
+			ret = btrfs_wait_ordered_range(
+				inode,
+				ALIGN(newsize, fs_info->sectorsize),
+				(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.27.0

