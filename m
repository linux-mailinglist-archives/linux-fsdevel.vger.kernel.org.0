Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43E73034D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbhAZF2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbhAZCdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628417; x=1643164417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SeEkBNnuIvaOUWWikpt8QDyQbatKEPjRZik1fvusQvM=;
  b=hvqQ3D1d4PKbunsR4h7aYyarLb81PJsgWJPBz9k2DXyV6ZNh3htNMt2O
   mJVfbVsyBXsIsvEmrN7MxZmnUFbpz9uQ9GdDGGlcvcILUXyggDpluEMss
   XgP5YtTPIqSIw3jJCJ3zMb4t1kHZbbrkQhyifyAnsxuppvm4VzEdzc8ZR
   w5gDM+TwDhZB/zWJqmQZBMec0T6RfA0udvUimoRrTZFWTJyKCSDYHypgJ
   F0BofnHoe+rysarJkgm0E8mI4wgT9olCopgNKTfl5dkYLO+XJAmDxD1KI
   epbtlHGChtCpN5arKyHfl5T1Oc3CAAVF556HsjuS9fiunnoHgXPXsSJWU
   A==;
IronPort-SDR: w1Ex3Bwb0vY+Ta4DiZefA31rTooUXN84Qi6ZVMHvwg1JYzLt3t1owaTNL2uCmvn2oU5qIs8eF2
 AnYw2hrXbYi3+FO+wUTxL2JzOzxaRUEyPsn3KKvFEnVZa3EsdtSrbAkZJsyQLygHx0tTlzaV0w
 5U07EfHyo/8Bh/pxmXgudiiMSXMUflwF4Xz2pSOq0oLCs9mkyvYN5O4UBmttrhpALNiTZ3wjAP
 5QoUAoMhprsXiuB/MEbyFhpyPh8OGa6xMlyqwejyccKN26KJJ3MtX7GoWclH8zvuitbHtkX0jU
 iJc=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483540"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:28 +0800
IronPort-SDR: Q4IEIoFiayd4A9eCbNkkwnErTCgApevPEYt/FTtx52m3l8mZLIWdmBzZJWHZiUqhuwRSPeporc
 OO0/LkL9fVTF505KTGUr2ZAzxlzJl9ZWRCEnG4XtQjNAAvvc3v+LxE7W6o9A1OnUcBXtPL6upx
 5TmeCVkI4DEhGqukbv4lZo6cWbIV9lEN7Mqe+JY1Ef5Iv6F5w/dYaU+8XXh/GfWEQCQqAvuBCs
 uaTjU9dFY+FZvxllC/uIaJdW151SUlC10JgdztIzdrTlqZY0i9xyapau9lthyorHN99ARgQboT
 YbRrw0W+5hASbs848W6nA6qH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:54 -0800
IronPort-SDR: Bpqs6fNKk87F1FvkG99HMYRLVXxXJbtPLPbjlgBqHMulp/pkHc5yy2MTyKuCAxTcaO7KzucKCC
 EkO/e6kZ9eQUfqTfayeP3XGdyMvMNnvgHDw1XABKbIhNWL1aJd0fzDA9Os9g8FVX17jBuZnR/r
 AeFtImJZksu3Wqa0zDk4mQbpMJetxZ/tfwlaoHkl1sKP30UUaUYOcrfvGKrQWaopM0ezct6DsN
 9lZGOAb7j91+JMWIdWZBY88o5TNsLkDHG7iQJjR2hUG/2F2pKA+ay7ZH5buaJWN6Atiru0YYrE
 nyQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 17/42] btrfs: enable to mount ZONED incompat flag
Date:   Tue, 26 Jan 2021 11:24:55 +0900
Message-Id: <51183faaa8afba3858bb48be627ef5072d268fc1.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the ZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ed6bb46a2572..29976d37f4f9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -298,7 +298,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.27.0

