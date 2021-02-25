Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B0324AEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhBYHJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:09:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53171 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhBYHHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236873; x=1645772873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SC0pXVUCDuaPbg+F0lWxh72IEBX9ZhX5hajRxPIkVPU=;
  b=pAhZPr0Arm7V5sKxUnWamD5hWEWw4DuckhDm2ALM0LeXH2sX3ladTrDR
   UT6R4q3kf5BefyvKCYNpvTrjoxtCkQfeA7az7iGzZzrQJ2BpUBaM+C2y0
   Q7rZ2gBgKF70ZcXtETOvB9WScshgTHCWxb0nPCIhY44K1lhgPhwC32tGf
   JpP+Zrt+L72wloBahBmXSoDSL1iLh52BvrvhlDA8q9ZBZSgbtzELp6oy/
   O2YauWXEWeaSkjlEg/HIWm2Ji7YtXtTXROEsmrLPmCZbG7QPK38H9FF9v
   KPxW/87v0BxECPeDNb0tqqIOO0UNZ77jLz5s3SbigPGU/9Dc7SZD5BPjQ
   g==;
IronPort-SDR: 4K/2Qj4LqJKPs+drCu7XeWEux3OU1EysjFUzX/bIiMjIODfdNLBMjE/9UoMmgoW7X1kHyqVclH
 jagyonPEnAU7fKe/06JhuZCThZSbCwFG6Jp8VKFi65zaG0ktHU8kyky4zCsQztnjfauO1zAZTF
 ydaGjYh2/6vBeRADfu+1CN+lFX1h7FhhM5DBL05OKFE34SlgfSShZ0gL5vzFpqCc6dWSaBD43b
 sp50W+dhWV+rvFItsLa4dJzmEuPwdSu+AAU4ejAN+xAcqMJRPwlIOUOO2KTj4/oHNtIqUm833q
 qYU=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160778025"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:06:31 +0800
IronPort-SDR: O2EYhLQUJDq6JMLiMDc3GXjzcxEvV8vQn5QAFER9XsLRQgoUkkWth52FKcRaJNfGWGHYSb5UaN
 SHj8gSb02B6I5qLx0ZMO7sm2jedqI94wYYQrlXAnffUY86yV1FEOtcuwmHbw7GXFH3396Hw+mT
 D2+YGX1qupZcNe8Y9YnyAdd5yYiYKMhuVEF1Y0tOSko1zgDV6d8uwnEXSQRDe4moJ0tepZvT19
 gbdE2al46mtw3y6eWtBrOyMZPTCMBiIA+LdAF+L0lR75TZ/QzR9B9UL/aE/Y865Ys8weUyegcg
 6mRXiYQ46nNqUnijvr6bJMMg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:46 -0800
IronPort-SDR: 5UjRW13wELQaoILvjTuJW1uTQ2Reo7QcTwFg2ymZEjUdyxbflF4kqglXRB7TbrN679yLIo/9eh
 LtbOIm1qTpRdn4iXSBx9rNuewZfhwkWo3tWtVc/amVN45ND5g5qeuuS36hANy2pefoezaHLEQT
 ox9ILkFA+vIKM1c0jmUBZgnXs2Dp/DvZRqxGqydoWJhyxwQI06CUJMCm2u8AlI47ihwtGu3RqP
 8qwPUdC+DYY8DXJhe1GbM6F++EZP7fspwojPhxAdwa3OtOLVFsi841xwGQb8ii21s4Fq4W/aVp
 5A0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:30 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 27/39] blktrace: add a new formatting routine
Date:   Wed, 24 Feb 2021 23:02:19 -0800
Message-Id: <20210225070231.21136-28-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 84bee8677162..2241c7304749 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1722,6 +1722,62 @@ static void fill_rwbs(char *rwbs, const struct blk_io_trace *t)
 	rwbs[i] = '\0';
 }
 
+static void fill_rwbs_ext(char *rwbs, const struct blk_io_trace_ext *t)
+{
+	int i = 0;
+	int tc = t->action >> BLK_TC_SHIFT_EXT;
+
+	if ((t->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE_EXT) {
+		rwbs[i++] = 'N';
+		goto out;
+	}
+
+	if (tc & BLK_TC_FLUSH)
+		rwbs[i++] = 'F';
+
+	if (tc & BLK_TC_DISCARD)
+		rwbs[i++] = 'D';
+	else if ((tc & BLK_TC_WRITE_ZEROES)) {
+		rwbs[i++] = 'W';
+		rwbs[i++] = 'Z';
+	} else if ((tc & BLK_TC_ZONE_RESET)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+	} else if ((tc & BLK_TC_ZONE_RESET_ALL)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'R';
+		rwbs[i++] = 'A';
+	} else if ((tc & BLK_TC_ZONE_APPEND)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'A';
+	} else if ((tc & BLK_TC_ZONE_OPEN)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'O';
+	} else if ((tc & BLK_TC_ZONE_CLOSE)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'C';
+	} else if ((tc & BLK_TC_ZONE_FINISH)) {
+		rwbs[i++] = 'Z';
+		rwbs[i++] = 'F';
+	} else if (tc & BLK_TC_WRITE)
+		rwbs[i++] = 'W';
+	else if (t->bytes)
+		rwbs[i++] = 'R';
+	else
+		rwbs[i++] = 'N';
+
+	if (tc & BLK_TC_FUA)
+		rwbs[i++] = 'F';
+	if (tc & BLK_TC_AHEAD)
+		rwbs[i++] = 'A';
+	if (tc & BLK_TC_SYNC)
+		rwbs[i++] = 'S';
+	if (tc & BLK_TC_META)
+		rwbs[i++] = 'M';
+out:
+	rwbs[i] = '\0';
+}
+
 static inline
 const struct blk_io_trace *te_blk_io_trace(const struct trace_entry *ent)
 {
@@ -2514,5 +2570,6 @@ void blk_fill_rwbs(char *rwbs, unsigned int op)
 }
 EXPORT_SYMBOL_GPL(blk_fill_rwbs);
 
+
 #endif /* CONFIG_EVENT_TRACING */
 
-- 
2.22.1

