Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64DB11DCF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfLMEL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfLMEL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210286; x=1607746286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/2PWrPqXZ5ElzQ0/FlPHhCO4f/Wes9FOqdwgVS4EW44=;
  b=Tk0XlOaApDIWQ3/envySfeZgCYXcgUaqseklmcfVIIRm4nXivoX697gS
   6LsKmem8k0ljRUeA4e03wRRnejZVAsujcCxWPrpoOnnrAUVXWDUHI+Yma
   66SoRq1TK+FyuomT+IBChskFmSvzbptbnRzLzib54zI7xTBHevWsv6zq/
   yvwFxwKxn9ynKtk4ZYbzCk28p8D3nGXirxMEi+FIXOFmWu7DqN7TbKMxA
   Nl2luQK9pizI0rrcG11VwgGOPSxts+QUOjBEXm3Ut22OCK7UA6sZ+1l/N
   4bRWT9Sc9nyl/aTUJoUuYw0pc1d75/RjpC5FnHrXqsjnm18PlaBj+bdSf
   A==;
IronPort-SDR: LEmtYSUTuGfjwT4CeCPaX6KYNUcWK36xDpmf3BJF/03YX4FmAiFARa700NdB67YnhqGtse+tuG
 sYKDDmbWLislVBd76g06EQOGQj77Jffj3hGAAwCK96uBL+F3Q387KkWRXClXXlIkc9Y7MEUMOQ
 IVTsu4wRavr/d1+xCiAlhzvA3hZUMMfS8fyj4DzpSg3t0UFqcxJhd1vd24PZjwKe3a4KhfTM3Z
 Z43aKPc8TXcO9vIPFHX83dDe1cFZiIBuFLsqavo4isjHJAhzyVKxJ3INWDh8d5TpL4TCQtM+G/
 bzM=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860156"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:26 +0800
IronPort-SDR: azbN2mXajNgyUKFUf8OKuykrqVp+4OINkF8yXq6wbJiU4pdgNnC6+w3SluyclZyo5YeSkYp573
 3fCqqCREimV/TGAceufMGU2Aw3kwYJb1fozqgs8x+di3HcILp5isoeT2KJUEWD4FjhysP044N/
 fIjN5go3T6w0Xhd6Gh/P45jQ85x1kNT8i40ra3Wt+NNeVZTRirvCfIi1Btd5+jXheUSA5dCIS7
 nGP7TqbyMEIwzx9D8Z5iTu92PxKX5rqml1Cc9UHPC8cRNQCHM7AS63izRFlACwTWV6PX8V15e1
 zKgYlYCkRJv/1uowp1CBPJvO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:57 -0800
IronPort-SDR: yzjb0wUSg21yiNVfUv1x7XeN9J5TwKTOkTcyD89bP3JXaTjMw3iEUy1pLeG7Yd0Eos5ohusgcY
 CWW8c2DXHWJb3mdkZy92VtXBDHVD/I/CruMtBCHJFbeX2EvphkHRGVLA04ibUAXVLsmEF/DwpM
 Va1iH4TV+baminVTPOCrACaO60M9hMyXFildviFs7dub9d/Ny9ahrjPQ6OUecQG0MddO0Azem5
 qADcXUgE7hIQ57pdIC5XDG/fqrQuzLrIpOINThxMvgnMQFy3aKHd5MJJYX9UATy2FDq/XjZiOD
 ZcM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 21/28] btrfs: disallow mixed-bg in HMZONED mode
Date:   Fri, 13 Dec 2019 13:09:08 +0900
Message-Id: <20191213040915.3502922-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Placing both data and metadata in a block group is impossible in HMZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do so, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

This commit check and disallow MIXED_BG with HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 1aa4c9d1032e..c779232bb003 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -306,6 +306,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "HMZONED mode is not allowed for mixed block groups");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fs_info->zone_size = zone_size;
 
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
-- 
2.24.0

