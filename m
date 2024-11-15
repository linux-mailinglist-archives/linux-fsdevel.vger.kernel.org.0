Return-Path: <linux-fsdevel+bounces-34916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8B9CE501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712ECB34AC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966E1CEAD3;
	Fri, 15 Nov 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+MZoXMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033781B2EEB;
	Fri, 15 Nov 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679698; cv=none; b=mHL+S9gOrhpfJOH3eNEbC8qC/YmHeeVrk2oGCAqJgOxzvZs9oHrNVccwuh/U+jl4v1S+8ihl2RAcKVsWZwafcMOdmYCiZFZxrk/GDjHDYa32cpkGoGzcvfpYs5aMZb9UFNlLkW5HvWhJXxZJS9sY3U9IKiVlpxZjNnr9sjysitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679698; c=relaxed/simple;
	bh=7TCiUevGA4XMe2fgZ9qj70lMNta4ONqhloKEk8TYICg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kg9Ir912zD9kZNlQuJuHBpganz/YOcccXJZuj+hHLleaFQWH6q9G/rw+SMB2GbwAOLKOaSVKIa6yAywY1z3OL6Anh/HyyGUjR96c6/PUBn58Ubb/GVjGLSF2vpeHNe2AYqgikqnpgEsudKZB0VZ+NDGYFAe+f5uEZcBfi8RlxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+MZoXMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A5EC4CECF;
	Fri, 15 Nov 2024 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679697;
	bh=7TCiUevGA4XMe2fgZ9qj70lMNta4ONqhloKEk8TYICg=;
	h=From:To:Cc:Subject:Date:From;
	b=P+MZoXMjK2zMgyBDNsVFXsbriztsk7eG5Pg4SqXsIUAsf0fvqRFTMOs/QmAniXZq0
	 U2QQehRDOh7ieA0NWQ0/aeDA+MuWHoS7ZrfG7vFO1j7H+zF0dbg7ePi6eT4nZoGWvN
	 udaN9kwVXAwoL5Ufr1h1N0RkL26LBiagncPyCmACCTb/KLaGq6reTmLHkxlboAKPRr
	 IOzwUcJN9ELWqGpws8HfC1SaVlCrIVON/r9+1aVwj5cutml0Fh/KD59kxz3k8jdjfp
	 MbB21hH8qesI2aU8npVkaGxHJsC7vilJJdgWSVYD5A3PgRe32iVqz06z+MNhfX/G/B
	 7poc38F6U5AGw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs ecryptfs
Date: Fri, 15 Nov 2024 15:08:10 +0100
Message-ID: <20241115-vfs-ecryptfs-e1d0f86e210b@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=brauner@kernel.org; h=from:subject:message-id; bh=7TCiUevGA4XMe2fgZ9qj70lMNta4ONqhloKEk8TYICg=; b=kA0DAAoWkcYbwGV43KIByyZiAGc3VcyierHm0crafZHxXZmndFwl8g9s4Yzj95W0pXjeAeiCK Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmc3VcwACgkQkcYbwGV43KI9OQD9EOdg 2juws1hzScrp2SzvBlEnCkgy5C6Svv5oxCVlDMAA/0fz4tv8FRbW/G/i5YzO+0SpLxaITC4jWGi W0w2lYDgG
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The folio project is about to remove page->index. This pull request
contains the work required for ecryptfs.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc5 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known merge conflicts.

Merge conflicts with other trees
================================

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ecryptfs

for you to fetch changes up to b4201b51d93eac77f772298a96bfedbdb0c7150c:

  Merge patch series "Convert ecryptfs to use folios" (2024-11-05 17:20:17 +0100)

Please consider pulling these changes from the signed vfs-6.13.ecryptfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.ecryptfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Convert ecryptfs to use folios"

Matthew Wilcox (Oracle) (10):
      ecryptfs: Convert ecryptfs_writepage() to ecryptfs_writepages()
      ecryptfs: Use a folio throughout ecryptfs_read_folio()
      ecryptfs: Convert ecryptfs_copy_up_encrypted_with_header() to take a folio
      ecryptfs: Convert ecryptfs_read_lower_page_segment() to take a folio
      ecryptfs: Convert ecryptfs_write() to use a folio
      ecryptfs: Convert ecryptfs_write_lower_page_segment() to take a folio
      ecryptfs: Convert ecryptfs_encrypt_page() to take a folio
      ecryptfs: Convert ecryptfs_decrypt_page() to take a folio
      ecryptfs: Convert lower_offset_for_page() to take a folio
      ecryptfs: Pass the folio index to crypt_extent()

 fs/ecryptfs/crypto.c          |  35 ++++++-----
 fs/ecryptfs/ecryptfs_kernel.h |   9 ++-
 fs/ecryptfs/mmap.c            | 136 ++++++++++++++++++------------------------
 fs/ecryptfs/read_write.c      |  50 ++++++++--------
 4 files changed, 105 insertions(+), 125 deletions(-)

