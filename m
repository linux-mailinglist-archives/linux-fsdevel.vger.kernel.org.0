Return-Path: <linux-fsdevel+bounces-17848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF18B2E71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 03:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54091F22EA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 01:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1917F7;
	Fri, 26 Apr 2024 01:47:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxde.zte.com.cn (mxde.zte.com.cn [209.9.37.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719CEDC;
	Fri, 26 Apr 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.9.37.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096077; cv=none; b=dy4CaHeCCEvLMkaZTS2fhWgDGT6Y1yepnYZVvqyjKO7z3Ihd1w8w+PWmHLZ+UvHlE1+AtaDfGoNWfenPPJGRfl2278rkDrSGHJsEtGWC8+QTMGLrMp68umlHYfT/9+p6TxnWXgR8z3bJh6GJ4qJwyxofSMh6J/GBm7YUDJVSL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096077; c=relaxed/simple;
	bh=nRLNLg/Asrg+hntPItw/WD1R1FN0NMP2xzP/J61TePI=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=JaZStBomcqUUrOgDNIN+plppsIDO261JmH6ep8j4Eb3VSj8TzNtD5uMyIW9FV2TZFDKzASxcBfHq6HJSycizmpbvDAVSnXenxHzpIQIwP9sXyoZr3DEDi5kwl424sS7PgEnEBWFS1uq//OgfTNl06yzGfo8jdJtEs44edO0348E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=209.9.37.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4VQbFp2tPWz4xBV4;
	Fri, 26 Apr 2024 09:47:42 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VQbFc4t9xz4xPBZ;
	Fri, 26 Apr 2024 09:47:32 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4VQbF32nhVz50yRx;
	Fri, 26 Apr 2024 09:47:03 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 43Q1kI9M001841;
	Fri, 26 Apr 2024 09:46:18 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 26 Apr 2024 09:46:19 +0800 (CST)
Date: Fri, 26 Apr 2024 09:46:19 +0800 (CST)
X-Zmail-TransId: 2af9662b076bffffffff86b-1264c
X-Mailer: Zmail v1.0
Message-ID: <20240426094619962AxIC6CSpfpJNeiy8HRA9h@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <shr@devkernel.io>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIGtzbTogYWRkIGtzbSBpbnZvbHZlbWVudCBpbmZvcm1hdGlvbiBmb3IgZWFjaCBwcm9jZXNz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 43Q1kI9M001841
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 662B07BD.000/4VQbFp2tPWz4xBV4

From: xu xin <xu.xin16@zte.com.cn>

In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
MMF_VM_MERGEABLE and MMF_VM_MERGE_ANY. It helps administrators to
better know the system's KSM behavior at process level.

KSM_mergeable: yes/no
	whether the process'mm is added by madvise() into the candidate list
	of KSM or not.
KSM_merge_any: yes/no
	whether the process'mm is added by prctl() into the candidate list
	of KSM or not, and fully enabled at process level.

Changelog
=========
v1 -> v2:
	replace the internal flag names with straightforward strings.
	* MMF_VM_MERGEABLE -> KSM_mergeable
	* MMF_VM_MERGE_ANY -> KSM_merge_any

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/proc/base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..50e808ffcda4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
+		seq_printf(m, "KSM_mergeable: %s\n",
+				test_bit(MMF_VM_MERGEABLE, &mm->flags) ? "yes" : "no");
+		seq_printf(m, "KSM_merge_any: %s\n",
+				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
 		mmput(mm);
 	}

-- 
2.15.2

