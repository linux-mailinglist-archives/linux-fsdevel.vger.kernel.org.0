Return-Path: <linux-fsdevel+bounces-78633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNf9GPeroGlulgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:24:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D21AF101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8046730DDAB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E774657F1;
	Thu, 26 Feb 2026 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XTPLWk9H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9032E720;
	Thu, 26 Feb 2026 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137154; cv=none; b=U+WIDkbPZ3REsvFQbSb5NQ5FPMp84ZwO/+7TXfG2Yh+2aGip1xGNVKM2CGd/dKONunMmpFEZnclRujXMwSo4sKJdBpW8QOXRTwJitT7fLYQnJUeTf03gYw9FDTTEOt0Ga8PKq50zTSddfqMhbMZFzkSmVABOE3R16PSV6YAOiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137154; c=relaxed/simple;
	bh=XMDAjoQkTjgcB7K1B5xaNYpPic527m/p7uMetODqzp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jzBgmZE4v3DQ6GyIcqvq5m/ByoDrYmBGWkPnlcLT0slRbUrMhb+gOA9oTjGAWb/wuMJUdpredOZchl5JZWKFPLWOFPD+XYj5J0Tp0YDwZxCUGog4fe9WJGKgFk5Y+hDbSZppPH3dcOsPUfPfbkTNrh06XGQmOD6ZZxtKnIOrVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XTPLWk9H; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772137153; x=1803673153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l5CyLmWSy70xXQrTFUBICNcYiP+xBbTRP1l/4MnIwJo=;
  b=XTPLWk9HSHdi2yxmL8gJokx/u1ZpNgEhf0TSFkqb6iiRpRyadlqr/jB/
   0PSCzli+F2fSUU8tlRwIgeA3Ap/ippgy5yp4E+e8a3NvUdRTnTgwiPgr/
   Rxh4DvIB69ZWaVNjifMyGfQnidjhLdMzsKrdiHmj5Vt+RIDcuhF7qv+Xz
   rPD7vlVZZMw8zgqxNE7sApPKDcblmbPOYbNG1uPgoxCDSLP86UW4AYgdj
   lH1mzkKgqKByyUAkpXcKB5TazayxrZhCVYyNhAQl5luCNMLqj7pbuu7Wh
   74+GTaRpzpOO2Po824HvAKWrwypQ3tpm//iQMuBCWkdHmlFM7wy1gVas6
   A==;
X-CSE-ConnectionGUID: xcG1cJc8QiKHzmVxUnhJMA==
X-CSE-MsgGUID: 2GZQKUuhRJqLX4PVlkovFQ==
X-IronPort-AV: E=Sophos;i="6.21,312,1763424000"; 
   d="scan'208";a="13881999"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 20:19:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:15821]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.152:2525] with esmtp (Farcaster)
 id 73aa004f-0205-4f88-98b1-e027e45a5a1d; Thu, 26 Feb 2026 20:19:10 +0000 (UTC)
X-Farcaster-Flow-ID: 73aa004f-0205-4f88-98b1-e027e45a5a1d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 26 Feb 2026 20:19:08 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.20) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 26 Feb 2026 20:19:06 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, Yuto Ohnuki <ytohnuki@amazon.com>, "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH v2] fs: remove stale and duplicate forward declarations
Date: Thu, 26 Feb 2026 20:18:58 +0000
Message-ID: <20260226201857.27310-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_FROM(0.00)[bounces-78633-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B02D21AF101
X-Rspamd-Action: no action

Remove the following unnecessary forward declarations from fs.h, which
improves maintainability.

- struct hd_geometry: became unused in fs.h when
  block_device_operations was moved to blkdev.h in commit 08f858512151
  ("[PATCH] move block_device_operations to blkdev.h"). The forward
  declaration is now added to blkdev.h where it is actually used.

- struct iovec: became unused when aio_read/aio_write were removed in
  commit 8436318205b9 ("->aio_read and ->aio_write removed")

- struct iov_iter: duplicate forward declaration. This removes the
  redundant second declaration, added in commit 293bc9822fa9
  ("new methods: ->read_iter() and ->write_iter()")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512301303.s7YWTZHA-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512302139.Wl0soAlz-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512302105.pmzYfmcV-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512302125.FNgHwu5z-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512302108.nIV8r5ES-lkp@intel.com/
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
Changes in v2:
- Add forward declaration of struct hd_geometry to blkdev.h to fix
  build errors reported by kernel test robot.
- Verified with allmodconfig build and all configs reported by 
  kernel test robot.

v1: https://lore.kernel.org/lkml/20251229071401.98146-1-ytohnuki@amazon.com/
---
 include/linux/blkdev.h | 1 +
 include/linux/fs.h     | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..0b5942e08754 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -38,6 +38,7 @@ struct blk_flush_queue;
 struct kiocb;
 struct pr_ops;
 struct rq_qos;
+struct hd_geometry;
 struct blk_report_zones_args;
 struct blk_queue_stats;
 struct blk_stat_callback;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..75c97faf8799 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -55,8 +55,6 @@ struct bdi_writeback;
 struct bio;
 struct io_comp_batch;
 struct fiemap_extent_info;
-struct hd_geometry;
-struct iovec;
 struct kiocb;
 struct kobject;
 struct pipe_inode_info;
@@ -1917,7 +1915,6 @@ struct dir_context {
  */
 #define COPY_FILE_SPLICE		(1 << 0)
 
-struct iov_iter;
 struct io_uring_cmd;
 struct offset_ctx;
 
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




