Return-Path: <linux-fsdevel+bounces-72512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F30CF8E12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AC063024F58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14AA334C08;
	Tue,  6 Jan 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="LTjjmONV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FA3346AC;
	Tue,  6 Jan 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711109; cv=pass; b=Yr2jFsuYKdG8o/+614s1F0Bkhqw/WU3sDawjqC4Q0uOhcqzdFuqj2pi1SbW++9zQdBlUUAA8drb2X7XGqBc01+uM3vrpuF5RpJu7tBRdS2SNy/VTcEEkIt7svvPHbMmpjZJVkyspjCMgJFeqctbyxX8/Oe+t+GdrnrnTg0Nd7bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711109; c=relaxed/simple;
	bh=pOevL+J7q+1CcY0mMmItyc9+v/qdrrMMr3syYm2BUjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+q5NUjTjajgRV4caeFfeHmZMfu2t+voGPxgUStrcaY9I6pVO4C3SgZ41G16r6Thz8xFpmGRgci96lCxBRJ9u04B+58XmT2/V9q1lDyh6oOn1UEW7HcYcCJ0PiNuWoAr3VneA9l2odHEtNRXmLNFiDoJ/P7tKPVYRGjvX4kVwIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=LTjjmONV; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767711065; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bRJnTZjv5X9F9j+IVfw92VnW7NSjXH7J0U3ooNlfVImIGxw5f3/S6+W3QRbJJegsTfYlgvZBVFBoYnsjt0P6BO4JhLmRPLl61T/+JGuG9McFvZfuB9y2oUm9xW9PXvlrVd/bDeCFvCGudlNTLx/voreoFfjNso0YEoVGcF8eWmg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767711065; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6KyVd/UMlOeq15tNM8m23IFXXj+MVBVuPZUOQSxgyPk=; 
	b=j5ktmlP50a6Iy6dRawgWjBZBSaYJ10KCsZLCZ3afETILbfqrI5p1r1Hjjnl0/43l2Grw+KUIIOZN9/BTJIDQ51nGSHWQvYpHEnlgKNoZSyRGEjufLTn37C134OGeoLZics8/n0TtWXiQJm7Mxzwf/AWKxxz8O7DX71svxsM9WfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767711065;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6KyVd/UMlOeq15tNM8m23IFXXj+MVBVuPZUOQSxgyPk=;
	b=LTjjmONViBp+m3MNntTu1dXNyI8uw29Nj7DtvevB7ecjCmGpXtVvW8W61i/nzSor
	ThI2b3njHmSV63Tu6JuA6QeqJSdPkXBP7W6/iGK2vVBMN7udPoXBh2vXB34x6o/LPxc
	ncZA3d0lHIQCaJJJl5oDUGLGOcEhk+FRW7tCe8jo=
Received: by mx.zohomail.com with SMTPS id 1767711061072771.7293821920516;
	Tue, 6 Jan 2026 06:51:01 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Laveesh Bansal <laveeshb@laveeshbansal.com>
Subject: [PATCH v2 2/2] docs: clarify that dirtytime_expire_seconds=0 disables writeback
Date: Tue,  6 Jan 2026 14:50:59 +0000
Message-ID: <20260106145059.543282-3-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
References: <20260106145059.543282-1-laveeshb@laveeshbansal.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


