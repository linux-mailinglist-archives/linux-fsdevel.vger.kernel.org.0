Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8087930491F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbhAZFaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbhAZClC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628862; x=1643164862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2s5NK8tSWvlhL5OFm4v5zkBSPKsGpOvG+1jvfV3eidk=;
  b=PgvcKT1F+lG/ikSRMOMOgFIj0qcD+cDDTRmO5oI29wDHExNTVfeUFXZZ
   ExvdLoPqe6WVUYcxyOdKQD6Cynlg7odFPfLlKuuUY+oLHVbOCqhDQSmF2
   Cb3ON/YfhtgN88lmTinJZ74EBbPbicCyJpaz71io+/ReX9nMTgnviJ68K
   Y+L84S3IUbCkjyzPof65FgGrPUJStW0F17pFOvPu5GtU/1hhlhWoxFHna
   rZCZ9QNouGai74lipYL303koSotPtfFz8ABheiO4x0/Xwgy+MH4+BzcMp
   jYgK5Nh1ZM9jyBVDOEc3xf9gTveNxrpRvayZBK8KPNj3GvsIyLlu2bzCC
   w==;
IronPort-SDR: OmhjJhBlrGNYPXbn17bkRs4+Te1mic33KZXBqPy7IZd4mJqSSVSVBgNgLnxUieNBaZNmdz2+YV
 bwUK6PbtOgEr09aq9GMhMbTqSPatC8i1pHPPZgI3KIYX/xdp4f227O4XXPJhdX1lRzg53ZEdA6
 UxOYz0UQztgFrW/hsUcdOOsRHs097IRVgi3/Gg9MPoDBP6IKC3T9Uyh8eeLA1GKHZhEAhyScUR
 XVUFOxSp1h45BxzW94UGAK0LJnabTHJ6+rMsonxkRzBBYVGZybO7IY/UOdGzwZzX2DKTIfv0md
 ksc=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483570"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:53 +0800
IronPort-SDR: RfR6M534V2iPo/+KbE7Fb9RJMS5IynvqJrgaTMf2rgn2/0GAID8LO4ThJ9DQ0XgrDSJp3138LC
 jvT0Ex1TXvQOBTGPPRXVRI29ziOTLu2lUmVctiinqSV/RgWVzn5xdTj4tVbq6s10rzlFHxxaa+
 jmAEHU7S6yL0xeEMpEJe1iPyMCLNfj2lIG0AjmXjX5ZsCbgnIio884jFOZI1CNvJZM/AElKpqe
 9xM9ZoIQxXFkLRvjmfi0di/8EEv3nNBO7MwhY20Dzs75KwQcbhD9LRIDSDmiOuakH/7rzYAhJ6
 KcnaFlCDqrLHd00PaS1jGsf5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:20 -0800
IronPort-SDR: A0AFHjaDQFZ7MQvLjVov5GROTL1kleCIbn4O47K1mRjENq8sz5FDORroRUuxSillJ1HAtTzsbv
 rw9wfZkF81KTmgINiJBqGO/EZ2CXPFpCCQAFboltnG3brI2n61/jXCG50Bzx/hSMHkxng185cF
 hK216r1rtT8H+Ij4mPtDmpSpC4i9fDgu8EUtgZUNF2S8ZJn2c7EDUkRBO13x0X5NTT+O/kHypZ
 cVdmPA56cnNoBz1oGfHJyvyu/JZDNzVLMb/5sdUrE+bi/73NLzhdraWfvXLGPEmTUcxZzVseGX
 1qc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 32/42] btrfs: avoid async metadata checksum on ZONED mode
Date:   Tue, 26 Jan 2021 11:25:10 +0900
Message-Id: <13728adcc4f433c928b00be73ea5466f62ccb4b9.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ZONED, btrfs uses per-FS zoned_meta_io_lock to serialize the metadata
write IOs.

Even with these serialization, write bios sent from btree_write_cache_pages
can be reordered by async checksum workers as these workers are per CPU and
not per zone.

To preserve write BIO ordering, we can disable async metadata checksum on
ZONED.  This does not result in lower performance with HDDs as a single CPU
core is fast enough to do checksum for a single zone write stream with the
maximum possible bandwidth of the device. If multiple zones are being
written simultaneously, HDD seek overhead lowers the achievable maximum
bandwidth, resulting again in a per zone checksum serialization not
affecting performance.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a41bdf9312d6..5d14100ecf72 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -814,6 +814,8 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_is_zoned(fs_info))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-- 
2.27.0

