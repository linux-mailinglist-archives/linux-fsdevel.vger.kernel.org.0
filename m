Return-Path: <linux-fsdevel+bounces-7576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA2A827ADA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 23:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0AA28528F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5EF56758;
	Mon,  8 Jan 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j++Ya042"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3188326AD1;
	Mon,  8 Jan 2024 22:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B9DC433C7;
	Mon,  8 Jan 2024 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704754093;
	bh=2dn01Ck7l9ZSNneq0vNQpDyByDGDn8pwsyKXUDoZh+8=;
	h=Date:From:To:Cc:Subject:From;
	b=j++Ya042narb+knTvJOY2epSK5WKovJhRVG8Vi6o/sRSdUtMt03nYFrJPl/JiagIK
	 XLOncxosj2WCkpcULAnF+5nVHvt9tiBLog7bT1m0n8uo6E+MN8Mug9n0x1z4k5yDNO
	 KnZYEFGTjv/+BNxk3e5t9SlipKhl6o1q7A/EJEbfq4ELeL7kqZYj90HCkwKmoLCuu0
	 0dYrM+MRnywQumVZ4/vnaJFxNC0/3jQPIdGJAkm/lb2ErmkQKPkS46D2U7+M+3hNT1
	 OyRQbRWQomXojWRZbHa0peIv5gnuKNCXDj57bwOh7XpA70E4eJeFYHL/Ec8CHHDlEH
	 xPsI2ZYxYZCWg==
Date: Mon, 8 Jan 2024 14:48:11 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 6.8
Message-ID: <20240108224811.GA94550@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 2a0e85719892a1d63f8f287563e2c1778a77879e:

  fs: move fscrypt keyring destruction to after ->put_super (2023-12-27 21:56:01 -0600)

----------------------------------------------------------------

Adjust the timing of the fscrypt keyring destruction, to prepare for
btrfs's fscrypt support. Also document that CephFS supports fscrypt now.

----------------------------------------------------------------
Eric Biggers (4):
      fscrypt.rst: update definition of struct fscrypt_context_v2
      fscrypt: update comment for do_remove_key()
      fscrypt: document that CephFS supports fscrypt now
      f2fs: move release of block devices to after kill_block_super()

Josef Bacik (1):
      fs: move fscrypt keyring destruction to after ->put_super

 Documentation/filesystems/fscrypt.rst | 21 +++++++++++----------
 fs/crypto/Kconfig                     |  2 +-
 fs/crypto/keyring.c                   |  6 +++---
 fs/f2fs/super.c                       | 13 ++++++++-----
 fs/super.c                            | 12 ++++++------
 5 files changed, 29 insertions(+), 25 deletions(-)

