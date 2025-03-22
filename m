Return-Path: <linux-fsdevel+bounces-44780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD50A6C92B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7793BFED0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F51FAC29;
	Sat, 22 Mar 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMwB356N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2291F5854;
	Sat, 22 Mar 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638640; cv=none; b=WGEuIpFsIVwvF4XXgeNjI/nHjhYEnFeTIseYdL1rLcX9bKckrf3KVdXw0Ccg0NSOx0aUvtHBQx4ReUKXSX2Lm5M13CCkVemF4M+YThNEIhvaiy/DBRjbZ9nKcejpUfVAv8n0+FD2oUolEtP9d5+v032QHIbmhBYf28anHT1KuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638640; c=relaxed/simple;
	bh=i51T8tOI+zdZ5Vpi08x5G+jEoM4dV06JVkiXYpeOUNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odHfHFtaZEdvtlmf1D7FeUve2d0umrd0Yup3Si2amoqu2RpvL6M0QihQCxHTY29s01l3lqCOoQXwflkefGVYVujb23EjG8CjRgmL7ySx9eEmbjqZarcv7ltQPgTwdQRbpGzWSXr/AR5YFSE2088I/HgywehoZvhR2PNBFjsYx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMwB356N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4C7C4CEDD;
	Sat, 22 Mar 2025 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638640;
	bh=i51T8tOI+zdZ5Vpi08x5G+jEoM4dV06JVkiXYpeOUNg=;
	h=From:To:Cc:Subject:Date:From;
	b=lMwB356NOzBlwrtHXY08IOT80HQMP/e/EQOY+Qw227GftKScpWd7st5VasT3tOn2F
	 RssH8KZXiPRzI3cDCOH3+A+Kkm0GsTrcWFUu6KKLhgpUBVkZm8DtCAHAB4Ulmwv+n5
	 UtML7+UWguKui7mQFBie3V5AaHe/IBbNQYj/r3xG0VpcWw2Oy6LhP6WjMEirWzQT0q
	 PkUuSobqzHG4G9ONFpScraZUw5ZX+bOQur0iy+dBA2nHSb2fmKcwWUP2DlJSMbVWMo
	 FMvW4pZiQRjvyX7KYeEBVo6q/RWmq17ylDhvtIq1iX32kgECiRLKSzd8/UL9DNvcZ0
	 ovZpWarO95SJQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs file
Date: Sat, 22 Mar 2025 11:17:12 +0100
Message-ID: <20250322-vfs-file-98e9b1f4bb07@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=brauner@kernel.org; h=from:subject:message-id; bh=i51T8tOI+zdZ5Vpi08x5G+jEoM4dV06JVkiXYpeOUNg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf69N0WcY8mZH3kx5zSEbsqdnCoTUNSXouNp0xs4SYp F2mnHHsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMijPQz/va0i3hxw2yIRu8gy fH7XQ26NSxUHN0nazypfPPPm/v7rvAz/tL7FRb8oktQzrXcWz4rIuO/1ermnvMNK4/lVi4RUIxl 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains performance improvements for struct file's new refcount
mechanism and various other performance work:

- The stock kernel transitioning the file to no refs held penalizes the
  caller with an extra atomic to block any increments. For cases where
  the file is highly likely to be going away this is easily avoidable.

  Add file_ref_put_close() to better handle the common case where
  closing a file descriptor also operates on the last reference and
  build fput_close_sync() and fput_close() on top of it. This brings
  about 1% performance improvement by eliding one atomic in the common
  case.

- Predict no error in close() since the vast majority of the time system
  call returns 0.

- Reduce the work done in fdget_pos() by predicting that the file was
  found and by explicitly comparing the reference count to one and
  ignoring the dead zone.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.file

for you to fetch changes up to 5370b43e4bcf60049bfd44db83ba8d2ec43d0152:

  fs: reduce work in fdget_pos() (2025-03-20 09:45:39 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.file tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.file

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "avoid the extra atomic on a ref when closing a fd"

Mateusz Guzik (6):
      fs: predict no error in close()
      file: add fput and file_ref_put routines optimized for use when closing a fd
      fs: use fput_close_sync() in close()
      fs: use fput_close() in filp_close()
      fs: use fput_close() in path_openat()
      fs: reduce work in fdget_pos()

 fs/file.c                | 52 ++++++++++++++++++++---------------
 fs/file_table.c          | 70 +++++++++++++++++++++++++++++++++---------------
 fs/internal.h            |  3 +++
 fs/namei.c               |  2 +-
 fs/open.c                | 15 ++++++-----
 include/linux/file_ref.h | 48 +++++++++++++++++++++++++++++++++
 6 files changed, 141 insertions(+), 49 deletions(-)

