Return-Path: <linux-fsdevel+bounces-14018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21691876A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82B1284F04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198556769;
	Fri,  8 Mar 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="Aa7aJRt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD240861;
	Fri,  8 Mar 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921013; cv=none; b=G1r77KxXls9oq/AlYRM+5uPp56cjvAygew242IsyWKVGkkCj5if0zpiy5pPyZ/xx3+NBhUICzsodyK8MhdfQXrmlUF7etYA3iKLyUQEZIqdvyTvlK6wccufqOKINn4819jb8G7P/zxocygF6rn4DPgctyiIW1V9nQDgWPfaftWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921013; c=relaxed/simple;
	bh=EuXu1Rj/t3nXyqZ0d9qa9AlmDwk/Lpelh4oxbH03g4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWn2EYKIHmUKmcW7RsDW/SnUw4qRZu8LaAbqDbKIBQ8X2tBUq9W7zKSKdUjYeOn1tRrP/pQiENm1HXYH1K5FMNKIe28fmIKHwpA7vKOqFDqUyFQ1IsbIPnJVDJv2/fNYvE5VF4BxFf3s3cQl4wuYnVqs0Xh2CozNcKDxTK/07Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=Aa7aJRt0; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 3DFDA8256D;
	Fri,  8 Mar 2024 13:03:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1709921005; bh=EuXu1Rj/t3nXyqZ0d9qa9AlmDwk/Lpelh4oxbH03g4o=;
	h=From:To:Cc:Subject:Date:From;
	b=Aa7aJRt0Lk3Qyxeixja9uZwg2QFC89DX8YeoDHBuuzhmsWsX6q6EulIqQLWAjBQgZ
	 TphNyrGY26Tcq/TjZd9OcZXQyocAnfaG6KgJZfUti51Ak1H9oRmET7cJRIyNrW1W8s
	 Tkz50gjRYsYg4pGowVhCUenAR9Q+aRb+TEUV0dbPo7mVqVd0pfptNBzrfDCfvXmtJd
	 5EM6EqztojHyIhqySN1cc7yUAoJ5ukskBNk5wzpd+Kc8xe4sgPQtDCbfsCfcnIKMic
	 hKCHOJaCMrJl2YXd1UKKQAuHs6hmm2tUiYWflHz/KaopTachXaZh6dYIFPKF6cd1T3
	 kElUoCwW3dUmg==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	clm@meta.com,
	dsterba@suse.com,
	josef@toxicpanda.com
Cc: jbacik@toxicpanda.com,
	kernel-team@meta.com,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 0/3] fiemap extension to add physical extent length
Date: Fri,  8 Mar 2024 13:03:17 -0500
Message-ID: <cover.1709918025.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For many years, various btrfs users have written programs to discover
the actual disk space used by files, using root-only interfaces.
However, this information is a great fit for fiemap: it is inherently
tied to extent information, all filesystems can use it, and the
capabilities required for FIEMAP make sense for this additional
information also.

Hence, this patchset adds physical extent length information to fiemap,
and extends btrfs to return it.  This uses some of the reserved padding
in the fiemap extent structure, so programs unaware of the new field
will be unaffected by its presence.

This is based on next-20240307. I've tested the btrfs part of this with
the standard btrfs testing matrix locally, and verified that the physical extent
information returned there is correct, but I'm still waiting on more
tests. Please let me know what you think of the general idea!

Sweet Tea Dorminy (3):
  fs: add physical_length field to fiemap extents
  fs: update fiemap_fill_next_extent() signature
  btrfs: fiemap: return extent physical size

 Documentation/filesystems/fiemap.rst | 29 +++++++++----
 fs/bcachefs/fs.c                     |  6 ++-
 fs/btrfs/extent_io.c                 | 63 +++++++++++++++++-----------
 fs/ext4/extents.c                    |  1 +
 fs/f2fs/data.c                       |  8 ++--
 fs/f2fs/inline.c                     |  3 +-
 fs/ioctl.c                           |  8 ++--
 fs/iomap/fiemap.c                    |  2 +-
 fs/nilfs2/inode.c                    |  8 ++--
 fs/ntfs3/frecord.c                   |  6 ++-
 fs/ocfs2/extent_map.c                |  4 +-
 fs/smb/client/smb2ops.c              |  1 +
 include/linux/fiemap.h               |  2 +-
 include/uapi/linux/fiemap.h          | 24 +++++++----
 14 files changed, 108 insertions(+), 57 deletions(-)


base-commit: 1843e16d2df9d98427ef8045589571749d627cf7
-- 
2.44.0


