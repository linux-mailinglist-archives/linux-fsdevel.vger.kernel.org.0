Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A72324ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBYHFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:05:05 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13098 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBYHEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237164; x=1645773164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YHFpfpeQSYIOW2oaDbitZ5qqGXHdZ7t0JGdaE7Ribi4=;
  b=lNEOabQtbKUQDK+Xkg0gO7Nth3FjBAhjK6fy9Z3DXm7+MBts32yZos/g
   xdyUnF6chRoMiEifF4JdE6cEWja3+yjHPinXtcl7+sOrLHWhvSuvOGSTa
   W0+CgfCvhAJu8gntdSQBgrIqcsOKmqB9EBdCXkCa67XYH3bWmCI2uglkl
   L+PgfqM/fiOVz9RcpgHykwqZ3bdCPIL3tMd/y1Pn9TpThC9dOYy0dX5gZ
   JDn9yunfhBithVkTgAykyajFaTuN4OaRt0svCCS8Vu1XfhMzRLL9yxBpk
   ZNlkwAQBk8Lt7zXc1W02aTSItfBO9JlpeDCSs3Z/spvcUrhjociPIB1PJ
   Q==;
IronPort-SDR: 2GCn4lzTdaxE9rUkuzQwMx+RlMjKD0Rf+lIoXnNd17t29hABDB1qV7HjIU3uuJ504VMd9zyDaF
 WjsSkzJ7ZgryyZRdp2AAjhfzDE0imCNRxPhbRHtIfUaARJDxfhKVXTCG0qJCniPjKoPO4byizl
 dMglyaGS2J7vKVDxlgvlM3L3nNlzMj0ZO3ELCpgFaBBAk3p2EThwZYIIwEODi+sg30eXJ+53So
 sNS7CJ/KYS4Gj9JaoWnwz88vNlZmMhAqYWxOqq8PapnJMI6RZr08T6GpJcH+0YkRCBGC5GhP23
 /zg=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978751"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:10:25 +0800
IronPort-SDR: MdmwdJTo//4u0g1TOkbgmjfHEmROYK8Rg4lQ5B+G6xpMSYlNybHVZNuRXuIRH6DGLJbMlqXIeF
 EQvmVUw0V25ECKTrhvjxp3HTk0ux8EqcmQylDwEx4BWc09Hiyaxtb3H7HeE/y9LlGCfjGYMxFu
 5QYouYNdvXd1Cu9GwgQLs4+Xr3KSF0/2qgUhD4V9Go0uTqaLmtshCDeBbDsRiB/jfc+fVM6Pbt
 eqG4YuBKg9YlKKSyWiTSEFQL1qlO4oC+zKaTtkebcXXh9kwB1W7ahBANUR41cGq2wJiHtJ5V7M
 /HPVO1YSrHRs/AKkesrJxoKZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:18 -0800
IronPort-SDR: wAMKbg1ieOidwvDUbTerEBZNf1ivBanSrkSpyh775lln15HTIx1A4URg3A/bN851aip0jXicPs
 tR+1jF+//r9upLjJKL78GfLSa3irUPYFVl3Oa+owaXW5c5vABXG2pqz2Uupg/dcG5pEw1sQ2D7
 B22asBF1klNr91EyaJ20lLbgkSqvA51c4GUGcRzP48c8ZlYOJv4CgGcQ1ujSVcXOT+bWnxGXey
 9nRhFZ4yepAALIQT3NfAW/IG7yQA6Gq2/6NOZQki66FHLPipFKeMIkYx60a25wor6IJaoAHx4m
 urI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 02/39] blktrace_api: add new trace definition
Date:   Wed, 24 Feb 2021 23:01:54 -0800
Message-Id: <20210225070231.21136-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds new structure similar to struct blk_trace to support
block trace extensions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blktrace_api.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index a083e15df608..6c2654f45ad2 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -27,6 +27,24 @@ struct blk_trace {
 	atomic_t dropped;
 };
 
+struct blk_trace_ext {
+	int trace_state;
+	struct rchan *rchan;
+	unsigned long __percpu *sequence;
+	unsigned char __percpu *msg_data;
+	u64 act_mask;
+	u32 prio_mask;
+	u64 start_lba;
+	u64 end_lba;
+	u32 pid;
+	u32 dev;
+	struct dentry *dir;
+	struct dentry *dropped_file;
+	struct dentry *msg_file;
+	struct list_head running_ext_list;
+	atomic_t dropped;
+};
+
 struct blkcg;
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
-- 
2.22.1

