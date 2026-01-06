Return-Path: <linux-fsdevel+bounces-72510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13785CF8DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22E0F300FD44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4033436D;
	Tue,  6 Jan 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="arVqikVM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49C314D15;
	Tue,  6 Jan 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711080; cv=pass; b=s6GaT7BQWyAIfPyREwHWV66gyrJHIVQBz45AVKWOKc2yVTZcQxllqMSXyRsoWxc00y4RVqWIpQ2pDq3lU7hCsXysm6tmlPkENqlCh0e71hiCgOfKs9nHqiGFytsHH4LfynCo7IuOEOUt2R0pyzRHbj4E7TdZi9eCMkxkFyoqv48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711080; c=relaxed/simple;
	bh=I7+WZsJlnaacNN7DFOp6ApVOpcgKDSSzoZ1PYNwnwXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekhFzTEBg1qSHXAmK4pdFVvIcAK0iq75Z/Coy6UbWXMv8NQAfoNtaTZYNsCIBKYAczYpxbH9N+zRHx8/LfhLq1M9YtGUpJ8P4tGp1YTvqZwOLIyEevnFuUb+KidVq0cq5T5B2vJ/6NhGQBqfm0+6YD1nr373MoM956TcLkKLEsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=arVqikVM; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767711062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZXM5HEW76h2kn1tWYTuU+fDXQuKJKxiiDhjUSPotxpYxRiI/Au07RMQERO6HSAuKetol4gaShaUi/lNS2TYb+1MIXgmvU/h1x7/KASK2Avo7wdO4rW/lTBcvNkT8HNxWUm1ydqU3h9ph7bqSnnxL0XYPgIDR5f9PXcbzJdxHBaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767711062; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XclwMtJxZbC9gB/28KUDmQUnNaQtyt0sW1eYHse8Qb0=; 
	b=G/o1nFf6hi9qGWEcm3c7NLGvC99LRSvlin0uGx4XDDOfOqLgfR04S48uK5I25FBZwO/GCS/vwfwavG9UcMSHHd8j4GPhAD178f4wHmJc2IJ1u6u0MisJZJgMKM6zvMLRj5AZq5l3rGC+u/nPeLTxd7LBfVsRbalNfiT/YpuZhmA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767711061;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XclwMtJxZbC9gB/28KUDmQUnNaQtyt0sW1eYHse8Qb0=;
	b=arVqikVMqhK47G6Wjx3MGrnWsJx+F62dmmAAAPllHUt82SV9i3FidO/lBrQCI7cq
	U/tj+lyy3YBp2pYDRpmHUOfYAqMaPOGs/mkH4h6nZN23A8jNPMbNVOfhRSIU6YtOFYT
	GMCve7V1oVR3MidRzpvxhNL6yRzT7DmB3kxx0Dzw=
Received: by mx.zohomail.com with SMTPS id 17677110596301010.7644755830726;
	Tue, 6 Jan 2026 06:50:59 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Laveesh Bansal <laveeshb@laveeshbansal.com>
Subject: [PATCH v2 0/2] Fix vm.dirtytime_expire_seconds=0 causing 100% CPU
Date: Tue,  6 Jan 2026 14:50:57 +0000
Message-ID: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Setting vm.dirtytime_expire_seconds to 0 causes wakeup_dirtytime_writeback()
to reschedule itself with a delay of 0, creating an infinite busy loop that
spins kworker at 100% CPU.

This series:
- Patch 1: Fixes the bug by handling interval=0 as "disable writeback"
           (consistent with dirty_writeback_centisecs behavior)
- Patch 2: Documents that setting the value to 0 disables writeback

Tested by booting kernels in QEMU with virtme-ng:
- Buggy kernel: kworker CPU spikes to ~73% when interval set to 0
- Fixed kernel: CPU remains normal, writeback correctly disabled
- Re-enabling (0 -> non-zero): writeback resumes correctly

v2:
- Added Reviewed-by from Jan Kara (no code changes)

Laveesh Bansal (2):
  writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
  docs: clarify that dirtytime_expire_seconds=0 disables writeback

 Documentation/admin-guide/sysctl/vm.rst |  2 ++
 fs/fs-writeback.c                       | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

--
2.43.0


