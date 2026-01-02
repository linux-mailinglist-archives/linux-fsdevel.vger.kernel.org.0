Return-Path: <linux-fsdevel+bounces-72331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA83CEF4A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 21:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025F4301D649
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD3299A81;
	Fri,  2 Jan 2026 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="dUKgVBxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E680450F2;
	Fri,  2 Jan 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385041; cv=pass; b=VqBJQfd8IUvPIBUDjNiiCiteREJ3M9KZBR1l6t707jc0OW0+SzJ7zzQR1SdQswg7s7BJakOPt2oZBfItUiHrSmDmuT3fV5B+9Cqw5kIXtwdKCX1V3t0gj/uw3Gr0DPgqqvPfb2qP7/UXXg1qVRORnoLdQmqziaC7JJOlz4J0Aqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385041; c=relaxed/simple;
	bh=1QLJgBYvAaQLjL+nqK83fHrm2g9A8ClkPotlD/YgaXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXjxEKU4PcUnqFPoKCcwG8rU+SXKrUxWjOirjMJLBYV8cWKvmTdL+iyl2asIfrvrdxark6BqQq7jREiVTqr9GJOpfpZ9KJMlIOC4Rru5/dDYEo67Pp1VGzGNkXd13/HJhv6ZxEYFVDLo0K+ALEGjQ7RPX73U0AUs8IHTfU/Q+Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=dUKgVBxK; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767385023; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XflKY4Pqwg4r+g2W0z6FHtAbeHbhp4hTbPUV2uk8nJ5TAEdU7ye4EVdnYhaUs7NlxvW3suWLXxMi6aeXTmQMl/qi2RAbIwScothKSjZoyMNgH4D2HwPZykWWZTXM2udc1+3SO6QAEp7OS0MmXLJYizFm0jOS+8Mb8E2bUllj0T4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767385023; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kkLzdLeULcFQNPPzxCYEFOffEJAcxbrYKKnVM1PTjQQ=; 
	b=Ledirmte1UuOTZ+8MPdz8VVttI3fTmhWBaQ/XhXfUhhvSjZzuu1IKyejthIkXUTlM6cO3TMa93QIdRAyavyM5vksMpce9ZYr/zXR+CLaYeffh9FPFs7yAiPl6PBCoTMVZifCYVa5r2yNPh1YOoRfB5Air17WZlxIB5cs/tYGAu4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767385023;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kkLzdLeULcFQNPPzxCYEFOffEJAcxbrYKKnVM1PTjQQ=;
	b=dUKgVBxKdxMv6TgklvOl0XoXLlqeT4MYpvYvNcPXdQpIEdw455i+/Q8FZO9VMkFw
	ineCyHZDereO0CMY6Cxqso7/Gd6PK2XKhPlapoEfADVNkfRg0Fdeqx/zuwkWg8y7Bmw
	wh2GIWacAXTzXExaoa8of+o9DbfFMpH0k951s/eM=
Received: by mx.zohomail.com with SMTPS id 1767385020890350.2236947331377;
	Fri, 2 Jan 2026 12:17:00 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laveesh Bansal <laveeshb@laveeshbansal.com>
Subject: [PATCH 0/2] Fix vm.dirtytime_expire_seconds=0 causing 100% CPU
Date: Fri,  2 Jan 2026 20:16:55 +0000
Message-ID: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
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

Laveesh Bansal (2):
  writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
  docs: clarify that dirtytime_expire_seconds=0 disables writeback

 Documentation/admin-guide/sysctl/vm.rst |  2 ++
 fs/fs-writeback.c                       | 14 ++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

--
2.43.0


