Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD647831F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 03:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLQCYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 21:24:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28082 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhLQCYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639707884; x=1671243884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KwdIIk7McG4kidrvTxgqMrjr3d6PT4XQUlcn0ozPwWo=;
  b=pjPLNRAU0O+2Kn36CJzW7dwJLLP94E+9gNaNPtWxDU/XIV4/PDbG7WfC
   evv1Ktr/tf1fDmKJKPf0nQeb78GMp/yEGhY/0euWFZlC1mmTsEfL8hvnP
   5qA59nhaMA7DEzVM/jK+bDA1sv9ZTNIggdbDd3eysylVgrEt7wQ/BIBhI
   qGPMR/XKcmaehuRDlQpa8nzBmUrLGtVd9TOFMXt4ckoyGbEuxRGc+McYD
   ChdnaN0nnggY71nSC5Iep8U/lR9naigah3xUWLRwQp71sGwnMncBLS5F1
   2LlJAk0lCD2KtQcOmRoe4PGCDa3ujG6dKZqo7/NJxnYcAre1htmXIOVU8
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="292471007"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 10:24:43 +0800
IronPort-SDR: YS++5sx0mjeshBM5xLXJVQjCOCt+H57GABHpSnSoVh0swuCJkMF+T23eBoAHZU2RjvrbBntkie
 QNwq+3CCTd3/naaPlU/rU/4y7/AHxY8f69ne9UnrTvIOju5OOVFUI3QfLwuTnmZKf/BJksBx/9
 rZRhIoIZyg6Fyqp9joV4zZGq15MqBtQSNIkJKVxNQGYgx8tSXTz1H5SH+4cBgJLWkaypKbLLcu
 lP5irFI4klqKcW4xpac3fg+9llhTNApwpIWwFZd7qv4+pIHei1oJvnuFs11nK5P/VOhmVG+YDk
 TqQzYGn5FeiMvzYk1bSWsVhg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:57:36 -0800
IronPort-SDR: new159yYMUl0vmVsoCbu1azvxU7vUTFM3mk4C2qo6pj6O4Wf0QHnuqnADkxZIFXZYR9lYs1T+f
 0IqLT5j9r2ZXlqEaVfg679cgmwrvtzs8ULcBVZ4i8FyIN/BjEAQBNkyYM+4WkrQ1cwrsNUD4vg
 kc8ihmBVfebw1Dfla/8thTMJxvkKlF+5408ProyrLEyUwzf6OsDchcCZBRIaXr1k9paHNKAwKw
 rXFErP5l+rtJHCaqNYpAC6jydYtjzhat7IDk11gJbaAwWvc/bRH8zjBpq70tuBosZmAzwA2f6M
 xLk=
WDCIronportException: Internal
Received: from 7vqj6g3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Dec 2021 18:24:43 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] zonefs: add MODULE_ALIAS_FS
Date:   Fri, 17 Dec 2021 11:24:03 +0900
Message-Id: <20211217022403.2327027-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add MODULE_ALIAS_FS() to load the module automatically when you do "mount
-t zonefs".

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/zonefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 259ee2bda492..b76dfb310ab6 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1787,5 +1787,6 @@ static void __exit zonefs_exit(void)
 MODULE_AUTHOR("Damien Le Moal");
 MODULE_DESCRIPTION("Zone file system for zoned block devices");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_FS("zonefs");
 module_init(zonefs_init);
 module_exit(zonefs_exit);
-- 
2.34.1

