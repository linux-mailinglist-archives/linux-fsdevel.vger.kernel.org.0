Return-Path: <linux-fsdevel+bounces-50910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF4AD0E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3197916DC41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202221E25E3;
	Sat,  7 Jun 2025 15:37:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3019B3EC;
	Sat,  7 Jun 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310621; cv=none; b=RjTSC7VL0IChUws0cqGB02FKJTxRpTfoxvwyqyRDMZVItRu9lkjPuAs2URbpVRCwFAFzW4UD2qje5OCg341FCqIrJNoEA2wCYxz0f8U5NmmwGVgsXMW54xWpjn+cAWMR0RywDEJkHrgL2Mx2fTbwyyyRH2KjsNFS+6LkOSmFHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310621; c=relaxed/simple;
	bh=IeOpdQJ2eq6EFL/hfmaSdYTtKTt2LixyF6JS3FWC1dQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hkhFLn7a5/CnYlRyXM79uicf4fIXBduf3tbRD1pdfZfqkAC5rgAi6Ml7aSRsQ9NNt3BcZInh9FD+pTOjleWxcSTt9QVFChDCuuIe4/ZNpacpyUGNP4aOpxG8fqaFBCWqqjcIP3ibReXFIyx4bqqEURdU2ox8L2a0uUj5osqW40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: wangfushuai <wangfushuai@baidu.com>
To: <corbet@lwn.net>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<andrii@kernel.org>, <npache@redhat.com>, <catalin.marinas@arm.com>,
	<xu.xin16@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, wangfushuai <wangfushuai@baidu.com>
Subject: [PATCH] docs: proc: update VmFlags documentation in smaps
Date: Sat, 7 Jun 2025 23:36:14 +0800
Message-ID: <20250607153614.81914-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc5.internal.baidu.com (172.31.3.15) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

Remove outdated VM_DENYWRITE("dw") reference and add missing
VM_LOCKONFAULT("lf") and VM_UFFD_MINOR("ui") flags.

Signed-off-by: wangfushuai <wangfushuai@baidu.com>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2a17865dfe39..e48dabab2a4a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -584,7 +584,6 @@ encoded manner. The codes are the following:
     ms    may share
     gd    stack segment growns down
     pf    pure PFN range
-    dw    disabled write to the mapped file
     lo    pages are locked in memory
     io    memory mapped I/O area
     sr    sequential read advise provided
@@ -607,8 +606,10 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
+    ui    userfaultfd minor fault
     ss    shadow/guarded control stack page
     sl    sealed
+    lf    lock on fault pages
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
-- 
2.36.1


