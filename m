Return-Path: <linux-fsdevel+bounces-15489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65E88F490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 02:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7801C25530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7362110F;
	Thu, 28 Mar 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="St8XH3fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2D3D7A;
	Thu, 28 Mar 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589405; cv=none; b=NTW2iHp2daQCRw9a/e7ZOGlL/3WIsoB+Zgrr0LD3tsVnN0i+txTk/SLTGA3e9aPr6OPK3PAmKpxp9FdBaqrqDPodkI/uivBJg9Ey/+aA7GApQWVPcqlvhl7rpqzjXCLy/UzDVeb6xCG2o6XsS3TUSTeixfJvvgxHgLjnI5bnLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589405; c=relaxed/simple;
	bh=LtHDO0v80y+Lyvcrk62TwQOMWdFY59WKgcJfLJ60cNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jJdW7iBbYOq1x5DzPhN0K/lmFvIYNmvK8EFpnWvlenz1aBoDEYukMCnKt37xcsDhJeazJ/OAHg/PFX3/ouSvcE4xaWFzG2kFjbe4KrapKfWeVN8ustHWwa/t5SDWDd7a0nM8dDnfwOGEnTYc2rvl2jISJ/cJqTrGIoBaPA9XHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=St8XH3fc; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 5CC31827B1;
	Wed, 27 Mar 2024 21:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711589397; bh=LtHDO0v80y+Lyvcrk62TwQOMWdFY59WKgcJfLJ60cNc=;
	h=From:To:Subject:Date:From;
	b=St8XH3fcQT8527KOe6J4m+oeLb8oEnrb4f5YLKV7C6NIH2/DQ+SQ44ByoTKJsH16w
	 5agrTV9d2cl8xoMRvvdB6z4PMxDLoIHpBH6eAts5WxvQuvIkS37LH2vyFJ/vGZbhSR
	 /cHTB7HZrHezcNLbqLXGPnKCXQDkLwN1o6goLihhtaGCExBchuyCeGfuIySKiDNY+E
	 5G9w+vc2v+JC+JRlPlWu7/lF4MseTRtIktl34cMSFWMiOiZA2ISlKEWpNIZOsXlzKV
	 sm1swILh6RAnbmOYitzSJjHEVfJiSlbsXkfuFP8pxQpPGhr6zZr3g8z9bDBEVIIVq7
	 VYjwpjpdp7m6Q==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/5] fiemap extension for more physical information
Date: Wed, 27 Mar 2024 21:22:18 -0400
Message-ID: <cover.1711588701.git.sweettea-kernel@dorminy.me>
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

Hence, this patchset adds various additional information to fiemap,
and extends btrfs to return it.  This uses some of the reserved padding
in the fiemap extent structure, so programs unaware of the changes
will be unaffected.

This is based on next-20240325. I've tested the btrfs part of this with
the standard btrfs testing matrix locally, and verified that the physical extent
information returned there is correct.

Changelog:

v2:
 - Adopted PHYS_LEN flag and COMPRESSED flag from the previous version,
   as per Andreas Dilger' comment.
   https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/

v1: https://lore.kernel.org/linux-fsdevel/20240315030334.GQ6184@frogsfrogsfrogs/T/#t

Sweet Tea Dorminy (5):
  fs: fiemap: add physical_length field to extents
  fs: fiemap: update fiemap_fill_next_extent() signature
  fs: fiemap: add new COMPRESSED extent state
  btrfs: fiemap: emit new COMPRESSED fiemap state.
  btrfs: fiemap: return extent physical size

 Documentation/filesystems/fiemap.rst | 35 ++++++++++----
 fs/bcachefs/fs.c                     |  7 +--
 fs/btrfs/extent_io.c                 | 72 ++++++++++++++++++----------
 fs/ext4/extents.c                    |  1 +
 fs/f2fs/data.c                       |  8 ++--
 fs/f2fs/inline.c                     |  3 +-
 fs/ioctl.c                           | 11 +++--
 fs/iomap/fiemap.c                    |  2 +-
 fs/nilfs2/inode.c                    |  6 +--
 fs/ntfs3/frecord.c                   |  7 +--
 fs/ocfs2/extent_map.c                |  4 +-
 fs/smb/client/smb2ops.c              |  1 +
 include/linux/fiemap.h               |  2 +-
 include/uapi/linux/fiemap.h          | 34 ++++++++++---
 14 files changed, 130 insertions(+), 63 deletions(-)


base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
-- 
2.43.0


