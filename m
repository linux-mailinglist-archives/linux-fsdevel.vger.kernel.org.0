Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032D9324AF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhBYHJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:09:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4505 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhBYHIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236894; x=1645772894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y4ZxvW+ayhHo+JhxLWhJUQIwkempqxmtM6LSOEmI9U0=;
  b=fVNgFb6ozWWJTy0yKoGb0uZSfKbnWL0f7I4uDRP0HzhBa4n2/pNcACMV
   C9wkYJs27QGXf/MBIa/Lsuo+XgEiHAUipivhMElc356BdkwMlw4bno9CJ
   LJHDJN/6t5+DYlnr4gG1Bl2CEjD5ARnfHgSfxA+yCfggnr4HFJvnocqck
   AoW3H7y3XG5i8AWWyCdq3i/dWKJybL4l+rhoornAoJA/2ktQFgBjNzhES
   hzfByd5DWlI0QwauAKcuA+yz60g0+8g6CULwjnoDfLmJpp4J3LIfUyfvO
   ffkG+aVWlTShpIppcCmUPv25qRWp7uAPrS78kRI4DDMcP9cqtzC7YQn0F
   w==;
IronPort-SDR: cKwTNKHJdtYesXwxvdp9PJ8iFBkMpATR/ERmgsbLfgMRnFbXb7cMbUiBIO1SF2IpTjcDdcM9Zj
 B6KT6ynpsCc5RyzJz+RgW8e/YJbT4nmI0LTs8AYgAl4zZepg/+2UROnH4QiO7nFMYfP1Va5Bmp
 E5RtrmU7CsfC6cKX08yZcF6VXAvkKJcl/+S+l4NhCKvmoEXYMVzA3PBX1YxYCrzq7LLfBUiCiT
 WXnlPK190JHjzk6UjdVoQPEGqSGbKEGEdDibtFv3OfFAZn2jqvPreUhqxFWkgETfpDxeBJB9sF
 WFE=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="271319235"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:09 +0800
IronPort-SDR: 6BnNq8mRGyniPz3Z59aufhkAqmuqxse+AVTYkAz7xkQg5YUjFFxp1gES2D2DdWLP712qOxv5xo
 wkmh9q62nRVHfuFRNJi8ajxO3agjKiudauFhY9CLhKspZZofhoULc2o59xGsc77LknvRYvaFPW
 L7Ypo52FEtvdvKP4Z61aK4lWO/0QhJ2bHCbLHNMELlHDOd6r/AAvU/YoiD/09mIPPE6uMnBCtm
 GIshfP2rys2W9wdG/yctlrPBj7g8d3HBhvg7zROEEcrrEnvpytr5cvmwDwAMoI2JJvQyEJtjN8
 PmzAVd90Zl8J8qC+YnPO0pgB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:50:24 -0800
IronPort-SDR: 7NUV+Cljl9oT4cLlsofGNqrp91SRWL5KA8y94YS21VX5HfaeRc0Q+3IMfMw9+DVNuEar5q/nlh
 7uTK2K0YrC357grRwbRvwnyXiubonoHUz3TBBEBvCeYSjQsPf7X0uZtCo0vAwIKkM4aH4uRFTD
 v42ww5buVuYpM99na2F3dZkv8bCVNZ9WTpf+ixT8YDXk7nrIXIOWvfWcQKYR1AJ/GdjI+8epEk
 7s8DuNwWmt+scDCfXP0Hg/PyFvLKDrwz57XTh5LVOVGdwVM/oqZa3JSth1SvQ3q7NyIAmiDsaF
 VSc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:09 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 32/39] blktrace: add trace print helpers
Date:   Wed, 24 Feb 2021 23:02:24 -0800
Message-Id: <20210225070231.21136-33-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a904a800b696..53bba8537294 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2440,6 +2440,15 @@ blk_trace_event_print_binary(struct trace_iterator *iter, int flags,
 	return trace_handle_return(&iter->seq);
 }
 
+static enum print_line_t
+blk_trace_event_print_binary_ext(struct trace_iterator *iter, int flags,
+			     struct trace_event *event)
+{
+	blk_trace_synthesize_old_trace_ext(iter);
+
+	return trace_handle_return(&iter->seq);
+}
+
 static enum print_line_t blk_tracer_print_line(struct trace_iterator *iter)
 {
 	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CLASSIC))
@@ -2448,6 +2457,14 @@ static enum print_line_t blk_tracer_print_line(struct trace_iterator *iter)
 	return print_one_line(iter, true);
 }
 
+static enum print_line_t blk_tracer_print_line_ext(struct trace_iterator *iter)
+{
+	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CLASSIC))
+		return TRACE_TYPE_UNHANDLED;
+
+	return print_one_line_ext(iter, true);
+}
+
 static int
 blk_tracer_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 {
-- 
2.22.1

