Return-Path: <linux-fsdevel+bounces-72333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B53ACEF4B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 21:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423DE303F0F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E712D0C60;
	Fri,  2 Jan 2026 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="Y+N5iGOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEA22424C;
	Fri,  2 Jan 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385070; cv=pass; b=kfCCFjNnKHlardvesGosUVlF/6AYXlmBRgn8VpZlBVYm1Hpj11DfwdDjX1vWUNr2sL6QdPopAf2pgvXquvu6Z2d/S1honUpcBdOPrLX8GqJD09I0riob/hrjCHYIBQq0AeCGNG8FD1ElLluBlL0SS4gzEBanZgletM19yOPZ4sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385070; c=relaxed/simple;
	bh=JncwMNFMVRgWnIz2ERkOCQFLXNGfzNX5DmMEy4JuWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0B1jcF4s7fvHLasd148yLthtYvq7RnXE/lj4I6WhEs+hkuFLw0icqDSfKeQHf8qd1IIcP0HeAQyLZvDeuMaeNY6GPb0U2o7S72MKHEnHhkjAZOGeqBTtXsl2Akvsu8HXRo7peOaTz+o1p5Q4nSO7HFAmfpIJriPqTn1987iHYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=Y+N5iGOL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767385025; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O7U0UncqjzVcAe7FCzKDD7zjZJlcLBQt6dR04QMrBVmJmGLbAbengEFlngaRBqni5+wcSaf+cfRif0KZbkD/Vdg25wz+9GiJpeNTgfzSo6Riz76ItnGgmy3Uf7URfot6/0JEzwMn65vUeTw/zfVA5M3hGhr7+OrxX/lPXbM77vc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767385025; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y7t9CAecc6vWkML+5EcN+CF4O7rK72BbvlPE9q2XDZ8=; 
	b=UuOPkPj5ob8OHQEu0pv5k9HAfPWaa/AIEdo2LYOMwPk1M0D0fwcqX8X3AbfKXoyaNWwyHutK5EH5Vd0uU2vxqppNwfFg0UUKGJiNX5fYMav86jofnDPtuO7Xpiz+jZ1yOd/GPRMoyLVFFanjp7MKnax29WqfY80dk4GTh9tCtAw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767385025;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Y7t9CAecc6vWkML+5EcN+CF4O7rK72BbvlPE9q2XDZ8=;
	b=Y+N5iGOL9Bpheb3rVmdc1JxyA59zNK2/j/Gevx3VcbsgJy6A3Aa80nxkN9Y2hvnq
	Y1Z/6xDCMKThYiWuc0j+UMvpefwc9ITM3kMHk2m+n0f6haOfCC+lCVfUMi8R06u1cQo
	IAtB8l2SAqiXgG2790arUA4dcAWXqgkzkWq1Nt8s=
Received: by mx.zohomail.com with SMTPS id 1767385024138570.8068171108126;
	Fri, 2 Jan 2026 12:17:04 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laveesh Bansal <laveeshb@laveeshbansal.com>
Subject: [PATCH 2/2] docs: clarify that dirtytime_expire_seconds=0 disables writeback
Date: Fri,  2 Jan 2026 20:16:57 +0000
Message-ID: <20260102201657.305094-3-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
References: <20260102201657.305094-1-laveeshb@laveeshbansal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Document that setting vm.dirtytime_expire_seconds to zero disables
periodic dirtytime writeback, matching the behavior of the related
dirty_writeback_centisecs sysctl which already documents this.

Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4d71211fdad8..e2fdbc521033 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -231,6 +231,8 @@ eventually gets pushed out to disk.  This tunable is used to define when dirty
 inode is old enough to be eligible for writeback by the kernel flusher threads.
 And, it is also used as the interval to wakeup dirtytime_writeback thread.
 
+Setting this to zero disables periodic dirtytime writeback.
+
 
 dirty_writeback_centisecs
 =========================
-- 
2.43.0


