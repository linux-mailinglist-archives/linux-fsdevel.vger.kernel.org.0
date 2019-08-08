Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1185E7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfHHJcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:32:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbfHHJb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256717; x=1596792717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xMaKip+xlhszDSiuVh43B5gpITCb2oW5pfRmyNf0mc=;
  b=n+tyPEfVLfmXTxxuZw6jwCd/NfMa/qRf6Mz27fXN7Nmh+P8MkKtkfsJS
   G9b3/B+y6vN7HB9m8sgnp74ZsBnMiEChdgC/mdzSdmKXThkaV5TpWzwoj
   D3XXhvHKCVCKGy6wRdIqz+j0gPhDfdOARM/0Lq2BHK+oEHPJfVIgQ9G+g
   yUFHbt5zjdERwNh1U++ugZYY59H+GoE3G4TrtvSYoWlylWJV/sxyJlIIb
   +RkUO1hMh7cTp2VWP9G4y/z1SuCX+hf0A0dWEgGqTNstcdCTL08KtrvGQ
   32F681mWMQABjcug/kfOpp/TzY7mrQdUP6Ufgz+RvIIPIcP2T3l5xyqS2
   A==;
IronPort-SDR: WdeAgK75X5uA/cYaTcHttFhiLQXZWtHcKl1ONfWzELet24NCm81pzNvIXcM5K1qbx9NSnglyqT
 0bYdZaFh6qPl9UBJ34t3xdpT8ajmR+P1kVwzhwYPefCZgTqtTdG9BN+nlVmi8krgHLDD6qncHv
 j6gCKBbAf585y2lB5/OnqhUNbTyAV14sE2rSYjgRTSwJkPW0NBTmOsp/L0oUrOsu4gSesksZbZ
 9DgynqH7KnJ5udoSTwhUpPJGai2fk7j8hCfwY7LxOWsSLO+jNKBcq0jLJ1RmdnBqwWqi6+iTUp
 WjY=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363413"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:57 +0800
IronPort-SDR: CkGjALXS95f8WL9FehMZpuH49NJCtmDoHEUweLbQdpjcsvqcl4E0IaT5bNN1TbK+L6ZOlfmcl+
 GyVALfyHp74fr7kwqTSgnGPZTlps54CKuNnI5SXBFSPQVVZj1mAq21TSUoG+RPhaEO/yAvwT3d
 nKhs/kAa767iHRmqxxExwqPphEBMq1dy8v1Pvfx72rE2Xg4C5X/gTHmjkHd+c3+t74iiz0TkWF
 354ZEp41YRpgNYWP4hvaLDOeTFDlZiQKyHInQlwKZUaIEmIoDx/+jFcc9I+4RZ5cKE4hlxhs3h
 d8R7RR6lcECxeJZ8wJPYKpyE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:41 -0700
IronPort-SDR: JYpQuDawn0Z7BQ84sS6TT1riyLEjVrAe0skOlDIcHSS5NbjzKGHGki4fGq+Of+X0s6aM1slT1Q
 jFeWQmxXthlonZgvpENicBWHjKjZ4Lk/EC2NO585N9LTzJlDaFwZ3cxcKJE4EuGPqqeJz4To59
 kX3GUu5TTuDKgnLNs7M8BaBvOAZHyGj2IAJhkIRlCZKV44WvCw5WHvTsldjfh3oSUCTvwrxkjF
 /hhboxx/rKBHCfMdR7JhLgMhgKOOtkgRDuT/cmtSUeNLnc3JdnE2LopKGSdIadPe02yJyyNzCH
 aG0=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 23/27] btrfs: disallow inode_cache in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:34 +0900
Message-Id: <20190808093038.4163421-24-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_cache use pre-allocation to write its cache data. However,
pre-allocation is completely disabled in HMZONED mode.

We can technically enable inode_cache in the same way as relocation.
However, inode_cache is rarely used and the man page discourage using it.
So, let's just disable it for now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 123d9c804c21..8529106321ac 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -275,6 +275,12 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_pending(info, SET_INODE_MAP_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable inode map caching with HMZONED mode");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.22.0

