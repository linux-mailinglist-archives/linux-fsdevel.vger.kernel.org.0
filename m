Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5152324ABD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBYHFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:05:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40841 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBYHE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236668; x=1645772668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqyjlzPNQjTMRjOk6Mtz4VEUf84S5Nuxb+VjgSMGlAw=;
  b=UaW74+j7pQoSpS/9ZXr8d6w1v/HAU6NP/MjOe2QBVb1gcwN3KsrCy5vl
   Qj5oauJsrKV/PMs/0CaWknZ118X2yyUI7fCdSbAeLCFu6TchQKoNUzptn
   JpxFn0YnsG5gCD6fGuhd70RwENr22RgKXO6bNcDbvHmm5MYxTAsIgCZhV
   jZ9a+L3pNhVQ4ztOaz1EMccu38MuMnWbABByrot3qZclhow4ut8gDZb2P
   FlyQswkdmaq9byyN/AA7MuIpS9WPtL2yUdd1yhfGbDVq9ir07vjUnMiXG
   gN8Cvz53Vm6HbjYpk01rc4x6+AR5GPOanf7Yq5qd7NVHj+Ac3Qw4SLcWX
   g==;
IronPort-SDR: vug1FgfP955B5CgApzZts6lfg3uSpKmH1ZpKE0jCyG+0atOc4P3lagz4LCM3+amho/wmhFnj/z
 TVlTYxWR/yQWAInDOyK3dl5SysX8BIJ4AG0Wx1zl5327PatURRKBKciZTiK7XBmB67spJXJuCm
 7YEFliVsraMMgqF07T62tIz+M/wBulXC6SZP1+AJcglyuWbk4XGkeV/BHtVDwtLf+F+o/oTbXT
 tJDiX6eLrR0DUNamm+evd8chNZU9p5wPAOUeZH0QzpxPknT1SVMy7fthl0g1d3eL/JItdWLwUl
 lH4=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="271318941"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:03:20 +0800
IronPort-SDR: XHoA/padyu3eAVe0wow4xq6KZprJeYXDVXB4pj95VJutdAhbIuubARBKCu01iQJ96f/gJmiKOr
 0YRA4B0L0J/SSWjZNJ3ttdKDEUWiQNlMN9xq0NdvnCumxNDYk8fNzx2xkhA0a6zNzxdhIqL1ko
 lY5HNNnnOAo6HLH9pgg6fx3NiSTONtKr38Q/KlLCB8c4vCkQEpWqyj+642eILq1/Cjagy/MOzF
 2j3qQvkYKBPrn4FYD8MvyABohLsxy7+3/T5HZuHLOdfHWg23f2eHQyFcgHReg9LTuBr6p1rXrO
 aCVRKdJcIWwG5XcP++/6hcWH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:44:42 -0800
IronPort-SDR: /hjG3Gw3NpTQ7UoUXCey8Agu3ljuUiBGQbfO/EQmLCyI3xHTR+KfpB6Ii8FPxyUgbB9CzPKL5e
 jOjj/xsxrWHba2EZ5XZzyczE9szDplFR2ahNG1oBXxUF8WewA0ygQULv7KFgEbkVwrHK/4hviY
 rF2Qn1uxI7XfZg7jwODu5qkMedGLnhN3bDYrNMrUgRS9rsMCmOJ71HgIMuubzv4Bj1wC4P9OJN
 83KMkdikvEDTK7AHfzBtbOiLI6VmAs6pgFusE3ewldgarFDhYJ8fXuDCh+ESsDuDQtFInhpeFV
 9wI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:20 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 04/39] blktrace: add a new global list
Date:   Wed, 24 Feb 2021 23:01:56 -0800
Message-Id: <20210225070231.21136-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a separate list to hold running extension traces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca6f0ceba09b..e45bbfcb5daf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -36,6 +36,9 @@ static bool blk_tracer_enabled __read_mostly;
 static LIST_HEAD(running_trace_list);
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
 
+static LIST_HEAD(running_trace_ext_list);
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_ext_lock);
+
 /* Select an alternative, minimalistic output than the original one */
 #define TRACE_BLK_OPT_CLASSIC	0x1
 #define TRACE_BLK_OPT_CGROUP	0x2
-- 
2.22.1

