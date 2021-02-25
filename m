Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFE324AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhBYHJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:09:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26799 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhBYHIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236890; x=1645772890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hDmja61HZFUIv20A9Mnm2VsUFWdVGWs+qU/9EVKHfqA=;
  b=QDeCCdPXUPuPvJ77QaD2ZkHRoAEabeEvsaxrJoaUO+mUoUG1GofexfQp
   ZEvuSWmzqkyejR96a4L0yP86k654mvtB/7GHZnZDzVpDFKz92PhIQE7zW
   gKu112is2bgxHEzPJGexjidP+qNWnm3mp679uuYU+kBGsePKobuJT3aKM
   y/BFuJu8i7jO3cRbz+Od656gHiasbxjln2JfSPNgZJSmaBgU1FFFEwCJv
   7VEvwOTX9kI3Sa0NTNV38DhsWIc3eBSI9DTlDYDcdJSI9aApbfvWaEFki
   fMyChU7cBynmmmGop+FVtFDQKEtUuQkD9O2Vtwsmf2UPTG/YwzePpQz06
   g==;
IronPort-SDR: vk0v9O38q2fCgEM4LUfG5FuETWJ24ybM/LOOwXdm9ygG+eDdfeHzj3cbADbZVZjH/9myQBdoUr
 +hq5tB7DvrIzsbRj92jvldrHvRSsL3QoDW/yCt9zaVyvTGQ2vqHzev0Uy0h/vCfww0oRgf7JbS
 Vs/TI7qvXeTcOL0gDrmU6TM+ki5/k3h3CXNlIBsmKbBCvSu7O0WnqQGyac3eefhGHGCep7rYhb
 yKM2cf+Op+4+xzVcmXOvYu0Fxa6XLcQQE2ldPCZD7P8yd70+UvwoJHH8dDYloVGcNw/ayinkpt
 Pdk=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160778067"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:01 +0800
IronPort-SDR: gVBEH77x5Zo8nXUTQnGsFO15VfXM/m8LQOSVOvqObHbHqB7Hkrbe3zAVTLx4SGJ1sylkU93H8G
 Q7d+caTiuIqUZg6mWK9DRIe6rBRvKyONxkT/SK+ar4OmILEDm0poFenba82oj118slFde/jFmW
 ZXA8rh9wvkA1DoJRw771Nu9/Md99WTb7SIQ5zB0iqMKBp0vwQZ3mFYRH23J38h9rOmH+6y+1jI
 90j1QNlV+/2u10eqq19QeEjNQ0JrpaSFQyzFCEe48LcjQQX6zAsij8elV+qSd4LuEApgXu+X+Z
 CETy2c3t1QADLS8FMiEuaRFJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:50:16 -0800
IronPort-SDR: CHhvpJieFcZHaxcsqGdeS2DaoT2/z9LZL4ieb8JtJY5UqwOOs1MxpTh2UONdE++l88e7chonHA
 +bGxbkH/OqttlCEBYQvHk20ZVuimEZdFmRqgu3VDXoYAOkKsEAwN77JK88Tw8ttED4/02pL1zd
 JYrY3L9FbE8Ya1KGKr5VjmWDpM0rA98wo0jHnITnFZM788s2o+gQwajMZacPxLJNGbn0Rr0kTc
 vp4H+a3kzfp6c8NNnJCbYZwsMqOLxLuaW2wzPFycCLvpxgVSISmSFw5DReqAeu9K5Bokt/f9FH
 3wE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:01 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 31/39] blktrace: add trace_synthesize helper
Date:   Wed, 24 Feb 2021 23:02:23 -0800
Message-Id: <20210225070231.21136-32-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 75b2ec88d8c4..a904a800b696 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2416,6 +2416,21 @@ static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 			 sizeof(old) - offset + t->pdu_len);
 }
 
+static void blk_trace_synthesize_old_trace_ext(struct trace_iterator *iter)
+{
+	struct trace_seq *s = &iter->seq;
+	struct blk_io_trace_ext *t = (struct blk_io_trace_ext *)iter->ent;
+	const int offset = offsetof(struct blk_io_trace_ext, sector);
+	struct blk_io_trace_ext old = {
+		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT,
+		.time     = iter->ts,
+	};
+
+	trace_seq_putmem(s, &old, offset);
+	trace_seq_putmem(s, &t->sector,
+			 sizeof(old) - offset + t->pdu_len);
+}
+
 static enum print_line_t
 blk_trace_event_print_binary(struct trace_iterator *iter, int flags,
 			     struct trace_event *event)
-- 
2.22.1

