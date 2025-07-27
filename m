Return-Path: <linux-fsdevel+bounces-56111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07801B13288
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E265168FA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23773253951;
	Sun, 27 Jul 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNAcJH/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BB1EE03B;
	Sun, 27 Jul 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753660228; cv=none; b=E2TxPIl9jcH+0aU0KbfYQkIEygeNVDygFLu+RcHa4FexA2kZSpabt7GX0XkDNb0cT4IyKEQk3pjHHaYhVpAqKcaauVy867GxygMBhuYg/tN8t73Rp6KDW2ohFO6T8mVoZJmU1fLHF8EQLpPB67Dwji72v8Nig66vkc1DH94VPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753660228; c=relaxed/simple;
	bh=Vj3HpeuQZVEq61Caf2pqR+ehJBv3qbSAJdwmfv5nlww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dw8T4n4D5j1b56056FcRZz3pQ94p1gDk7ZdhtvGAT29E3YwRuU7Ip8BlXc1g1wWfofV84bAlXlkpEEyNmSqigRZx3ZQul+83zCoeBYkR6fQS3C4MGsQt7oWTLVjT6kSSLEQXmpTNahUkAEkCHobslNLNly0ADD5irp3i3sTNdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNAcJH/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC83CC4CEEB;
	Sun, 27 Jul 2025 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753660228;
	bh=Vj3HpeuQZVEq61Caf2pqR+ehJBv3qbSAJdwmfv5nlww=;
	h=Date:From:To:Cc:Subject:From;
	b=HNAcJH/Oz+YTprMaPhQZ9kmxE8dw2M/9PFyuNxm1b8IW7CKRw/hNQSo/SP6YpoN1g
	 kCtyQCffGtll8Z48EJJNTXwzAXrCujnsAqNzI26SP4Ja1/a+1fWKS0w4aiohkGUfnr
	 0CeKAoeN3gKA/k1maU7RCxBA3Rav7AgmizEeuj6sOdMeCG8MWJJPdI0Otw/XeN/doe
	 p6CRFLHED20+Dbmg7vqfWZOTNsXZUi7nA9Jpo4bDjtqWmHRdKfJFmANJXZGdKN8jfV
	 sGvpxgdelu0crsBFfCG2p++/EFWxNPBwi+stbw9LXr2IqS0//42u/HQMVrQdshpZLj
	 2IXrN2wb8cZBg==
Date: Sun, 27 Jul 2025 16:49:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [GIT PULL] fscrypt updates for 6.17
Message-ID: <20250727234936.GE1261@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to fa65058063cbaba6e519b5291a7e2e9e0fa24ae3:

  ceph: Remove gfp_t argument from ceph_fscrypt_encrypt_*() (2025-07-10 12:33:17 -0700)

----------------------------------------------------------------

Simplify how fscrypt uses the crypto API, resulting in some
significant performance improvements:

 - Drop the incomplete and problematic support for asynchronous
   algorithms. These drivers are bug-prone, and it turns out they are
   actually much slower than the CPU-based code as well.

 - Allocate crypto requests on the stack instead of the heap. This
   improves encryption and decryption performance, especially for
   filenames. It also eliminates a point of failure during I/O.

----------------------------------------------------------------
Eric Biggers (9):
      fscrypt: Explicitly include <linux/export.h>
      fscrypt: Drop obsolete recommendation to enable optimized SHA-512
      fscrypt: Don't use problematic non-inline crypto engines
      fscrypt: Don't use asynchronous CryptoAPI algorithms
      fscrypt: Drop FORBID_WEAK_KEYS flag for AES-ECB
      fscrypt: Switch to sync_skcipher and on-stack requests
      fscrypt: Remove gfp_t argument from fscrypt_crypt_data_unit()
      fscrypt: Remove gfp_t argument from fscrypt_encrypt_block_inplace()
      ceph: Remove gfp_t argument from ceph_fscrypt_encrypt_*()

 Documentation/filesystems/fscrypt.rst | 45 ++++++++---------------
 fs/ceph/crypto.c                      | 13 +++----
 fs/ceph/crypto.h                      | 10 ++---
 fs/ceph/file.c                        |  3 +-
 fs/ceph/inode.c                       |  3 +-
 fs/crypto/bio.c                       |  9 +++--
 fs/crypto/crypto.c                    | 52 ++++++++++----------------
 fs/crypto/fname.c                     | 69 +++++++++++++----------------------
 fs/crypto/fscrypt_private.h           | 23 ++++++++++--
 fs/crypto/hkdf.c                      |  4 +-
 fs/crypto/hooks.c                     |  2 +
 fs/crypto/inline_crypt.c              |  1 +
 fs/crypto/keyring.c                   |  5 ++-
 fs/crypto/keysetup.c                  | 23 +++++++-----
 fs/crypto/keysetup_v1.c               | 55 ++++++++++++----------------
 fs/crypto/policy.c                    |  4 +-
 fs/ubifs/crypto.c                     |  2 +-
 include/linux/fscrypt.h               |  5 +--
 18 files changed, 146 insertions(+), 182 deletions(-)

