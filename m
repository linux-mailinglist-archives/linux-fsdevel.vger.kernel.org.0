Return-Path: <linux-fsdevel+bounces-46911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E65FA96717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CBC189DF61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073127816E;
	Tue, 22 Apr 2025 11:14:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15752221287;
	Tue, 22 Apr 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320464; cv=none; b=R7ng4NikA/l6iy7jUxNIVQgr14O2cgzccOLQEZj20uUgTI1lYdsFzWDBdrlyV9xr4UYqpq/A5iTyjeJE0TDz+Dyux38Au5TsT/7Xj3NL+hG3fDzFPPAa2gzV/l1wHl9ELWTTdTLSSicCoNLZCpRotOyqY06h/1cwV4qErwSEfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320464; c=relaxed/simple;
	bh=/5lKOEIVjGel1cmwA5dz65NG853sDvO3RU57oww58bo=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=opy9HBBN5oA4sEaY88nHbFaX1vVzCXQMy39loZWtJwPBALkuIb9Op0VCHDSY7zlUJ47Hw3Kn4otSCVd/VSN5/JIHgv6F1/IP8oq8WV6C9O2AuZwdI1p7Qq6j6YF/O6mRB0smJuuoDss0G8t27iksE0pFOMBkeQb3H6uWvGZjSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Zhfkr6NB8z5B1Gs;
	Tue, 22 Apr 2025 19:14:12 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 53MBE4Yt057963;
	Tue, 22 Apr 2025 19:14:04 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 22 Apr 2025 19:14:07 +0800 (CST)
Date: Tue, 22 Apr 2025 19:14:07 +0800 (CST)
X-Zmail-TransId: 2afa680779ff2ba-70fc4
X-Mailer: Zmail v1.0
Message-ID: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wang.yaxin@zte.com.cn>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAwLzZdIHN1cHBvcnQga3NtX3N0YXQgc2hvd2luZyBhdCBjZ3JvdXAgbGV2ZWw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 53MBE4Yt057963
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68077A04.003/4Zhfkr6NB8z5B1Gs

From: xu xin <xu.xin16@zte.com.cn>

With the enablement of container-level KSM (e.g., via prctl [1]), there is
a growing demand for container-level observability of KSM behavior. However,
current cgroup implementations lack support for exposing KSM-related
metrics.

This patch introduces a new interface named ksm_stat
at the cgroup hierarchy level, enabling users to monitor KSM merging
statistics specifically for containers where this feature has been
activated, eliminating the need to manually inspect KSM information for
each individual process within the cgroup.

Users can obtain the KSM information of a cgroup just by:

# cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 76800
ksm_process_profit 309657600

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.


xu xin (6):
  memcontrol: rename mem_cgroup_scan_tasks()
  memcontrol: introduce the new mem_cgroup_scan_tasks()
  memcontrol-v1: introduce ksm_stat at cgroup level
  memcontrol-v1: add ksm_zero_pages in cgroup/memory.ksm_stat
  memcontrol-v1: add ksm_merging_pages in cgroup/memory.ksm_stat
  memcontrol-v1: add ksm_profit in cgroup/memory.ksm_stat

 include/linux/memcontrol.h |  7 +++++
 mm/memcontrol-v1.c         | 55 ++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            | 28 +++++++++++++++++--
 mm/oom_kill.c              |  6 ++---
 4 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.39.3

