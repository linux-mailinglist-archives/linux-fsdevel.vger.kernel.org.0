Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1430324AC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBYHFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:05:17 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54863 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhBYHEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236689; x=1645772689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qdyagKJPcWErAA46tCNY0K0NdqzdODTcXuAuyhapQbU=;
  b=TXZVyBQ8ml0SEGs/GcbgamKQkBnaTxOKu4+wZ3BloVx+0uf7gi7oi4HN
   L4GEFw3tJD3pxZ3LUfvlr9OKvwQZO5tYS71nLTmVwZTmWLYDep30sQU8u
   wiePmgcqVEYyBuuhfmxHAybRmgY4o9iRpgIde5rcqfCAi9tdslyd9UKjF
   DVivdIxlYvFDhe+znjaaGWnel+iDpuQXf5EqlboSnlIXotGj3XwrPcT+J
   9aXnUXCVw/so/jOqo5S16WG47UynPOFTWp+mGrrHvqyuUek4doKAiPXeL
   1DxU9JcccMcOZqcQ0YrgseyNm6f50FEKrful0hbHpSqZEQs8pY6amM3EW
   w==;
IronPort-SDR: c7nmWf4y87SmIsiYb/qc9ic1Yeva/zczDkR2v0hQLRJ1rAEFR548thTfj1tZBj1Iuh0skH/i4Q
 2B6BfVZl/CrsRLJUnF5ZR2tRqKb1L2kdn3v/vlBQYAHAJlUCRT+s6Y4odeRVcqTrQePhH5bgSQ
 PWDUL1ioGFREWeC0AMOajffTE2gQClcoZgKmbjLwIB8mFh+OsRDc++150zvculCS8DNShtyhgN
 CfR3tURH/sv885nNqGDCKm3q0QICHl/WyDDoSuD42pUa6gLyjgunxvwlB6d50cdFZt3+OoK+T9
 BuI=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160777860"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:03:38 +0800
IronPort-SDR: mN8GuriArjqQAZmozLuZwNQ3rNZnscbLSV1px7W/6G6r4HptqCjoiihtp/TIuoyelbuWgrH1Ia
 PQ2KEXITW82L3P1AmiX6B5z5FSxxOOms5WlBCPszncfJ4YMk8nvw1FLO+tp2CKfqyA+GV6dZLw
 vqst9XJ45ZmrclXNEMa+z3T4N/h3zH8qx8Kzg8KKlSnFAQg7GQjRgig5lSjtdMyTA+LJ5vhciX
 vaqF5gATQsXL60/BWnnld1U+73BIZ2yZWMpPhNpaBQtA7IsLBOWYndAX7yegy14qtrGtfDBgF7
 NI05nIbQ7lity5Ysh1rdtZwR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:53 -0800
IronPort-SDR: WnRuBgoyCtMo+vxu/gIkc0+9FWzQELFP7nsalmCAAODcVpugmiOW8wIWd/PIBLW2IdfWDfKK3a
 f+pqiiil1IcvKexTHHfZnk7C2Dyna4Z4zdNerJVaUYHTFHjtb/YWbZheMHSpx3Pv7Tfg/SN7iJ
 lhl/IMGzAxvQ9Ssba+FjiynX3819Vt+Mzn/aKE40FW4SG+v4Wy9/QZm6u+/5QdbKMXYioiJrAl
 1ATkJwVyEYu2npTQCi9UFPaAu5+PTEprOXaF0VAHrFNC4FFQFiOMtGjE/CwUMJ5JPyL5e8jjuT
 ScU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 06/39] blktrace: add act and prio check helpers
Date:   Wed, 24 Feb 2021 23:01:58 -0800
Message-Id: <20210225070231.21136-7-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4871934b9717..feb823b917ec 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,6 +311,43 @@ static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 	return 0;
 }
 
+static inline bool prio_log_check(struct blk_trace_ext *bt, u32 ioprio)
+{
+	bool ret;
+
+	switch (IOPRIO_PRIO_CLASS(ioprio)) {
+	case IOPRIO_CLASS_NONE:
+		ret = (bt->prio_mask & 0x01) ? true : false;
+		break;
+	case IOPRIO_CLASS_RT:
+		ret = (bt->prio_mask & 0x02) ? true : false;
+		break;
+	case IOPRIO_CLASS_BE:
+		ret = (bt->prio_mask & 0x04) ? true : false;
+		break;
+	case IOPRIO_CLASS_IDLE:
+		ret = (bt->prio_mask & 0x08) ? true : false;
+		break;
+	default:
+		/*XXX: print rate limit warn here */
+		ret = false;
+	}
+	return ret;
+}
+
+static inline int act_log_check_ext(struct blk_trace_ext *bt, u64 what,
+			     sector_t sector, pid_t pid)
+{
+	if (((bt->act_mask << BLK_TC_SHIFT_EXT) & what) == 0)
+		return 1;
+	if (sector && (sector < bt->start_lba || sector > bt->end_lba))
+		return 1;
+	if (bt->pid && pid != bt->pid)
+		return 1;
+
+	return 0;
+}
+
 /*
  * Data direction bit lookup
  */
-- 
2.22.1

