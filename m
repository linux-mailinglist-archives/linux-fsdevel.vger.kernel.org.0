Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489B1324B05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhBYHLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:11:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13098 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhBYHI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237562; x=1645773562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=noVlfdAKnU4/DGq6YcXktGnI8djjvUkkGf2lKgCrAX4=;
  b=cSPIYwhGSIUejV88S5mKlwioyBu6zbWW1mtPo90H8faTR7QILTFRpGxp
   ELianDUDr28tdOFE9idOto/0qzezhYC9GZC0qxg8aggG8nFwKdoSdA1Er
   6qCGNi9rzgRknoxfjV2w6oRZiGcE4L0jZ7yAACPL5w9P4ifxmHSfBZY9D
   X9VB/VBOVk9BklHu8183u5TqK/aMoGZJ2Xq/oQzYtL4jS1btWqWAoMmBe
   yVaQqyBVFExEr4x+vH7ccRSdJ7GpYbfLFCqInXKHdiDgjC5j1g8NqkTTW
   82WVWTlXV+qaRNFCoKkf8UKibKksdhJfRQVx9vSV1qa2VB6b6cYQnyxn9
   w==;
IronPort-SDR: 8gqxMM8ZWzHpKGx+n1PWvpekDx8AWvcPgAghsllp6V2uXMXIqtg0tZM7od/aiiwOwnMxx3RCli
 nuymznVq0U5V2UGzndHgM6Ley2QL4cgV/Je/DtolfzPVegyYzZ/Ru4awaudSn48WfwLZDhaWa+
 /GSExXVYpMYBsv0syx55tgEeXH6H38mPTt+HD56QfCSaEc9L7soRqSUiQr1/7+B/FEWNYxRfiP
 5Bz0meudCACB8sXg+eiOhWmhFja8HEgy71hh6wV8gF3qeH6ShZEfmGmMAltEnKCd4pE6Typ05q
 Z4s=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264979007"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:16:03 +0800
IronPort-SDR: rsNQwtKUayRvaSkli0NLoqm1GObehnsms0PPysiLq+d4vDtTvq2LPc+/hfDISMpUUSY9tFlquy
 CtdKDEnHlEvi8iyw4C3KXJvcBVmMUyE4f4uw7VVxDOznhEuOd+16+GWthpVPTCtXnooS5bFDng
 UzIcB+99MkRr/S5sf1fkgpnAyxff89q1XLhTbkJNQ2qqO6w6nCVL190mjPyWRRei8nZDUDb+yx
 JJXDFr6n0T1neVd3sdBR9VFggAGvItS3LbD9zSoVsdMxOzfQPY9y/wMaC1cN3cWbvhrXJ/Xoun
 dLnujhaFKkR0ZDW0/liTV2jS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:50:01 -0800
IronPort-SDR: vmgi6cHID6K41DB+8KrCq4QjXdT70xFkXHUOdUmSgXrJwU9B2QMv7y/3Si5TgBo85fwjIblUhc
 WoYO3YwnUJXGat67wjhTWCk5EV6WZKdLYnXsnoyshNnoAbrlC6XvUtOq8xuXf5y0vnGxsMSZD9
 TjPusohN+UnSYA/ElQwAZU7Mh3Vy9smvxumz6fjlAIm3/Q+MfmfX6dXmSW3ibXK9QIsbcGzgcR
 3QlhcEnH1GvHyiI0J1BPhWmp+XZR6TocQ4qSzTejWkkZcATBZj2WxmVdzhfcVK6hEv28w2j6a7
 30Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 29/39] blktrace: link blk_log_xxx() to trace action
Date:   Wed, 24 Feb 2021 23:02:21 -0800
Message-Id: <20210225070231.21136-30-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 425756a62457..4a4ba1d45cb9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2301,6 +2301,28 @@ static const struct {
 	[__BLK_TA_REMAP]	= {{  "A", "remap" },	   blk_log_remap },
 };
 
+static const struct {
+	const char *act[2];
+	void	   (*print)(struct trace_seq *s, const struct trace_entry *ent,
+			    bool has_cg);
+} what2act_ext[] = {
+	[__BLK_TA_QUEUE]	= {{  "Q", "queue" },	   blk_log_generic_ext },
+	[__BLK_TA_BACKMERGE]	= {{  "M", "backmerge" },  blk_log_generic_ext },
+	[__BLK_TA_FRONTMERGE]	= {{  "F", "frontmerge" }, blk_log_generic_ext },
+	[__BLK_TA_GETRQ]	= {{  "G", "getrq" },	   blk_log_generic_ext },
+	[__BLK_TA_SLEEPRQ]	= {{  "S", "sleeprq" },	   blk_log_generic_ext },
+	[__BLK_TA_REQUEUE]	= {{  "R", "requeue" },	   blk_log_with_error_ext },
+	[__BLK_TA_ISSUE]	= {{  "D", "issue" },	   blk_log_generic_ext },
+	[__BLK_TA_COMPLETE]	= {{  "C", "complete" },   blk_log_with_error_ext },
+	[__BLK_TA_PLUG]		= {{  "P", "plug" },	   blk_log_plug },
+	[__BLK_TA_UNPLUG_IO]	= {{  "U", "unplug_io" },  blk_log_unplug_ext },
+	[__BLK_TA_UNPLUG_TIMER]	= {{ "UT", "unplug_timer" }, blk_log_unplug_ext},
+	[__BLK_TA_INSERT]	= {{  "I", "insert" },	   blk_log_generic_ext},
+	[__BLK_TA_SPLIT]	= {{  "X", "split" },	   blk_log_split_ext },
+	[__BLK_TA_BOUNCE]	= {{  "B", "bounce" },	   blk_log_generic_ext },
+	[__BLK_TA_REMAP]	= {{  "A", "remap" },	   blk_log_remap_ext },
+};
+
 static enum print_line_t print_one_line(struct trace_iterator *iter,
 					bool classic)
 {
-- 
2.22.1

