Return-Path: <linux-fsdevel+bounces-47797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542AAA5A26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4169E1BC561F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18022FDE2;
	Thu,  1 May 2025 04:09:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1D1E5718;
	Thu,  1 May 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072555; cv=none; b=c+2iOCGsVpAJAJTLXH91y4M3L1l9TXChCR3gzOPEUV/1Pb5NS2bmbLtpC2ajfVSOrk3tNchrgwzrMjB6m7gbl/rzpLxl0It2IrMIy573/tx0I0/nyNqTaXuCKPLIhv1uwiOJ2+7v9f3TBICyZJz50K/sUXaOkWe2Fl+4WvUMc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072555; c=relaxed/simple;
	bh=KfSrdHusUAwnyXl/SAjl5LcCOK4cacE/Ammmm4oHo1E=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=r6EzGgJADqQJrqvS0iPXUDdpmM+tiBUZ+UT2omLFsgqkILEfbG0HEAzWHrbXDSdsJxSQ77WXY74qgOGsWFuJswV835My5sNYdIfSIjTdXWyjYgYSdD03GV17zLGwgg7sKHcEy1t8cBcDbtGaBnvrfaU1a65bddj9lUT2fRIMsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Zp0t13CjTz51SWH;
	Thu,  1 May 2025 12:08:57 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 54148rMj021500;
	Thu, 1 May 2025 12:08:53 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 1 May 2025 12:08:54 +0800 (CST)
Date: Thu, 1 May 2025 12:08:54 +0800 (CST)
X-Zmail-TransId: 2afb6812f3d6005-4673f
X-Mailer: Zmail v1.0
Message-ID: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
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
        <linux-fsdevel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvOV0gc3VwcG9ydCBrc21fc3RhdCBzaG93aW5nIGF0IGNncm91cCBsZXZlbA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 54148rMj021500
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6812F3D9.000/4Zp0t13CjTz51SWH

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

Current implementation supports both cgroup v2 and cgroup v1.

xu xin (9):
  memcontrol: rename mem_cgroup_scan_tasks()
  memcontrol: introduce the new mem_cgroup_scan_tasks()
  memcontrol: introduce ksm_stat at memcg-v2
  memcontrol: add ksm_zero_pages in cgroup/memory.ksm_stat
  memcontrol: add ksm_merging_pages in cgroup/memory.ksm_stat
  memcontrol: add ksm_profit in cgroup/memory.ksm_stat
  memcontrol-v1: add ksm_stat at memcg-v1
  Documentation: add ksm_stat description in cgroup-v1/memory.rst
  Documentation: add ksm_stat description in cgroup-v2.rst

 Documentation/admin-guide/cgroup-v1/memory.rst | 36 +++++++++++
 Documentation/admin-guide/cgroup-v2.rst        | 12 ++++
 include/linux/memcontrol.h                     | 14 +++++
 mm/memcontrol-v1.c                             |  6 ++
 mm/memcontrol.c                                | 83 +++++++++++++++++++++++++-
 mm/oom_kill.c                                  |  6 +-
 6 files changed, 152 insertions(+), 5 deletions(-)

-- 
2.15.2

