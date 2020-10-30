Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6782A0716
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgJ3Nxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgJ3NxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065986; x=1635601986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acVyMDibRvMfztPSjphbHCXJZqzL0/hyecarrVfdIp4=;
  b=HAdYS8np+mXT1Sx85dEypo7anGJwg9z0a3n4IiUanIJCZFWwjsS7KMhd
   YjoAomGErOZ5AYP0z7OHtCPIHKPcixmlyqbOO0bXTsLymfib+YzTQEPj+
   sovbQqu1LlxspkJJQLyaexFi+ptUlA5y+W9igz206zd42MGLxYvYEuUCv
   1c6vpNdAptmWqiLfRk65OBnfnIr0KIGHtWVWft3m04eFlDyBZRjJ9Nt8p
   45UMwJMJ1GfLCieNiYkbo4y8B686sxm8+TrhBqEJU+bZ6H1ceo4TMXxrw
   K8nDHY+oSDe1v3qfWsyEN28CFgcd31z8abyetF8CXA/NdnRbkKQGpHPUc
   A==;
IronPort-SDR: k+S5I0lq+jxN9HdksXsxSzdlMOW7voO1qBbWIeLKDlkoNPc9ix5fDHfyTH8D82KrJaOhtUZcb3
 M14ir26ETfwHrQymL0orrK5OvKAOPo5n92pGuEc/Wik3n8P3e/e7OrH4VwGU+4rsLXzFxEc6qw
 23YSVHwQ8t2MDbMIoZrflYx9Ixl+4MZp0ck10spKtaLrmjAJ6uFxhmoq7mkEjzlIsypy97YALC
 wGEeWN0H1E0PDLytJVe/dwUW6vJWoVYzU3PWtcWtqAK7yToLzaDRy2m4J+v2Y9vzd/GQl+EF4k
 exM=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806633"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:58 +0800
IronPort-SDR: fIsW3/QBBd/J1Z58ddEpsempU+JrKTBsFmuWXr0JQOaSVwHGIEdYRoex4uL+EFbxzknblUnCTi
 wgCSBGIrgjZhfwunUkNnFeNuAIumcQxo0GtRfBt6dcPeDy9G6RZjNolRFXhysSLiEs6pDCbGop
 zO5FzeCu2okD2BcHOQ5AT+iEnq3fOhRsoKAvzYMYfr98AMid0vkR0O47p39PhTZftNLfJaCZY+
 Jq+wuFmXJlwsXwpiv9UvuxkhirgIOSRqRDDv9T5TWN+enM948jJv6yHR7LVL9BthMJpMZ5j0LQ
 4b7g8vEGRSjXA6BJMkaZ44yk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:12 -0700
IronPort-SDR: uigXKqk6+fabkqBM1GPiKillEkeVRTlMyB9gn/mUBKydm4PgueCSNbnDuHmfpdx8Z8dx238q47
 dgNNBHrt63UxRNNaZ6GXF6j0UlEdfAoTtHUaX+X+l50NDYsVUW9z7+LLfJuqkk5GLvD0Tl1LSj
 V1HpHdWcYvXaKqY6e8iA+fAZKja/YGJFqFjraCGLJzQbtoDvCCwOjJOtQt86B2rzWvCaj/a3sY
 UKrvFd/WMzqmkSnlUcrvglspOpZKb5NRgwLtY6k+IScaMyic/cBfgpU9yXvVSPEp0QvjwZholk
 li8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 30/41] btrfs: avoid async metadata checksum on ZONED mode
Date:   Fri, 30 Oct 2020 22:51:37 +0900
Message-Id: <3434830b6fadf644c5a47eaaea6759c375b39ad7.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f02b121d8213..2b30ef8a7034 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -813,6 +813,8 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
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

