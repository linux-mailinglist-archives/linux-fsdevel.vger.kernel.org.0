Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03F830A39D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 09:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhBAIyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 03:54:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59326 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhBAIyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612169643; x=1643705643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rNLPMXJ7FaWzp+mFx4pkiefigAZutewdrtCsPMpvjOY=;
  b=FNGWFQSQUxUu0S/qw4Bn9nhXfphjIN8O1i1R4qsF6LlqA0drGMJJTaWl
   ZXnOCqyAcC+Ovxt9aYVics/himwF6B8H4tTo+Sk+IblJXPMmXdWCys0oP
   86eOWBR50QXWXmekgFI3AmFe+QAFSeLRnMi/vwD7xOD6yYtssAK17otRh
   zxkioLAa9ZS9lQDoOw+bR1lHbKvyFM2gqnRQDyzJc3lH6o1A7Pv26GfLz
   vrjHWt0NHjnm/vrEkeQeubXwuNZ3Uvo+gJBw6dMRQ671/xCjb2y5mv7EV
   5Vz4acgjnsYOj9C8E3pkq7ZeqwBuXth7GPZv415FYx+mdapW/7Q+pe1o8
   Q==;
IronPort-SDR: +8PTDpWKc1GHnuKlzcpH2SDgFCgZUGCrCkcsu6oHTZvs27yiX5CglLExVfzORDFRUCaApffxVM
 9RVV7+6qs2kruu3XbwowEdcKSZbA+Lz6s4sbLw5Ue0sonWlSzBjWqtNQB2/r+Y6Lc5CAO+fxTr
 aESfrKAE1/7IDwnwVpjU1bcN70QMUsUm5QLoZt3TcU/ikrxhDJ0r3zxcXGHffNIs2maFEmNLpx
 24xSFmgaXegeGmczFT61Hjj4bt3udy2rGVNiKd2DAIJkod/0iwJugwcmjTguhWunIZRFAGS1qN
 +IM=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="158797704"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 16:52:19 +0800
IronPort-SDR: l11Zv8QbwiXm6h0NhwXBtlyJM1VBxXr1g4a0XL6EZCVWVfAEHn9l/BHI/Tb8RzM+SmrkEbcHQY
 /KP2BfADOK9Mf+jSHx7LcClJAsbmTMLMCpyEsdJmrDiBeB6JBgB1IeZQytbxEri9aPzEiAFsR6
 L+Yffudev/+pPk6Fnxlz3bLUobW7VYHTRQIjpfGygpcD0gh++cfEt9aCmpU8kGT0QY9D8vQKej
 76n75D7vCRg4TqofQ3QjJv7hK5B7NgEVM+Tvt2473gXRAVvsp1XJ/Dfz+MiAozB7c0uI4enPci
 gJmkIYyPGe25GCP5CwLaCYgs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 00:36:30 -0800
IronPort-SDR: poHiwu5gFiofK/tSU57rT0ALWE5XJXInXriy37VsKyXRTJa+VBDtL1Z/PVG5QfO168jeGWD2kw
 A96CPnSgPJvZCWsW9lBSBiTKkqDfITAKIFgRAby7fuURV1Vo/w6aHEbOgltJ9K7CiSj5jCvTZo
 fSVZ3hwzcugtU54LDc1Imoh/3roNrq/djTxOJHI1C/CSbFXOFpPlBYFEaZd2hc1Efw7MIRxNPq
 OtBhr6s0V3MVx7qFf2Xp2/cKLabf6U/A3cNSmNLZTmOu6SO56JgYbw4QnzwbYVPpNDETcxSBiY
 500=
WDCIronportException: Internal
Received: from 7459l3apk6t.hitachigst.global (HELO naota-xeon.wdc.com) ([10.84.71.70])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Feb 2021 00:52:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH for-next 2/3] btrfs: properly unlock log_mutex in error case
Date:   Mon,  1 Feb 2021 17:52:03 +0900
Message-Id: <20210201085204.700090-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201085204.700090-1-naohiro.aota@wdc.com>
References: <20210201085204.700090-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to unlock log_root_tree->log_mutex in case of an error.

Fixes: 122cfba0d2eb ("btrfs: reorder log node allocation")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1dd7e34fe484..ed101420934c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3164,6 +3164,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
 		if (ret) {
 			mutex_unlock(&fs_info->tree_log_mutex);
+			mutex_unlock(&log_root_tree->log_mutex);
 			goto out;
 		}
 	}
-- 
2.30.0

