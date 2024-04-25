Return-Path: <linux-fsdevel+bounces-17758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984798B21EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E6D281D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CF1494D1;
	Thu, 25 Apr 2024 12:49:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6A1494C4;
	Thu, 25 Apr 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049368; cv=none; b=jrs5ds9Sy8ngV3LcbpKjtYZW5uWRCpucFTq/HNxGMJytmVankLamptNrDRrj94yVP3w1aO39IXsiejTDWfIAnJO2FqqduQt1BUa2uO3amFm+exNxzK4RMgi3jD8eWcZWqcNya2xGkZuFhDR1weYW4fn4khZMbP3nxiECmZASIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049368; c=relaxed/simple;
	bh=18cQvZb4ODs7lrECMHCH9NKnIsA3RHnLJppWoKGsy6Q=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=HyxXKzSgOVC45Iuliy2RWT9RGXOefmOTmjQ2dbblLvlMpllWqbvYHTlMZEjuHl+JIk5/bKx9ZkzJ7j4snqdUW7e+IPhMhos9XmKEjdFgHPnriZM4rZgBBTzv3RulurOXGs3JmHfo/Ro0VEEXHX6vCePe6CsMeXZgPrQTyDfYDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VQFzZ0Crpz8XrS3;
	Thu, 25 Apr 2024 20:49:14 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 43PCnC15071050;
	Thu, 25 Apr 2024 20:49:12 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 25 Apr 2024 20:49:15 +0800 (CST)
Date: Thu, 25 Apr 2024 20:49:15 +0800 (CST)
X-Zmail-TransId: 2afb662a514b6fd-99358
X-Mailer: Zmail v1.0
Message-ID: <202404252049158858OT9IpNshMmQC1itDY1B1@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <shr@devkernel.io>, <david@redhat.com>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGtzbTogYWRkIGtzbSBpbnZvbHZlbWVudCBpbmZvcm1hdGlvbiBmb3IgZWFjaCBwcm9jZXNz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 43PCnC15071050
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 662A514A.000/4VQFzZ0Crpz8XrS3

From: xu xin <xu.xin16@zte.com.cn>

In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
MMF_VM_MERGEABLE and MMF_VM_MERGE_ANY. It helps administrators to
better know the system's KSM behavior at process level.

MMF_VM_MERGEABLE: yes/no
	whether a process'mm is added by madvise() into the candidate list
	of KSM or not.
MMF_VM_MERGE_ANY: yes/no
	whether a process'mm is added by prctl at process level into the
candidate list of KSM or not.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/proc/base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..421594b8510c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
+		seq_printf(m, "MMF_VM_MERGEABLE: %s\n",
+				test_bit(MMF_VM_MERGEABLE, &mm->flags) ? "yes" : "no");
+		seq_printf(m, "MMF_VM_MERGE_ANY: %s\n",
+				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
 		mmput(mm);
 	}

-- 
2.15.2

