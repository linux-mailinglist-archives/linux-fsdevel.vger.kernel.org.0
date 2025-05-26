Return-Path: <linux-fsdevel+bounces-49831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3277CAC3791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 03:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697101720B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A67263D;
	Mon, 26 May 2025 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBqZdmJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEC35972;
	Mon, 26 May 2025 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748221934; cv=none; b=LzF0/5HTmVLArdk8t1vlzn+KAvhlAEcRjtU4CLUGRZWzSEHD6flCSR24qmxGiPjsRADVCzC9EQN4uA0rA36HQx9ynNCtrFZvpdQFS0aUCVcXgHFQKNFjf64sMSaXFi7g0ZeitVkgQvGhPIRHBPQxvtU8CF6TkPOt0qe2T/wkT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748221934; c=relaxed/simple;
	bh=Hdf+EjjTXZohy7wvzsrbiXVv91he59uK5ObP7uvDCFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oTrvDnOmYXt7FXJGdM+xwBGRTtMTMcyjOLobjJ4eGMctQ5IRtzTGudsjbeh5WaRZPwdaKJosedAFynqjmVuAH6VMKEkMhmnnHQqxcy62m+cNNdQ9IKL7Q5E9+LtW8T75BRvR+tTp1UMLqB+lnqYLDBazvniRpf2+LO5aH2gmc3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBqZdmJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAE8C4CEEA;
	Mon, 26 May 2025 01:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748221933;
	bh=Hdf+EjjTXZohy7wvzsrbiXVv91he59uK5ObP7uvDCFk=;
	h=Date:From:To:Cc:Subject:From;
	b=SBqZdmJ/v5YNWL0MNAgOodpQ2MPdxMHNJh21PffomPOdBJBGshC4LaqDUttDtg+Nc
	 rqmN8p4KcWg7TelM/WUzeRiJ2LunogRlcyMsBf/cZabuk5QS4SdL/H6YhaMb4CbNqp
	 sHo9Gs16plVIVnKnzJIuk/51Ik81S7c+uX52VWLkYkSYS0YRB76AwZRcQFXlJj01Rq
	 EvhH8DTaDknnbQ/AYw8pUJg9txdtqkljBXDzxcalfkriV3T43aeOn//DPCo0H9y0Ub
	 m+A1TFazvRqku8RhSKOp/Wt8wiYOpmzouI6lt/mqNWqYwDbta28a6Xs8ybB+BFXR/6
	 0/sFt6PAX/s7w==
Date: Sun, 25 May 2025 18:11:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fscrypt update for 6.16
Message-ID: <20250526011159.GA23241@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to c07d3aede2b26830ee63f64d8326f6a87dee3a6d:

  fscrypt: add support for hardware-wrapped keys (2025-04-08 19:32:11 -0700)

----------------------------------------------------------------

Add support for "hardware-wrapped inline encryption keys" to fscrypt.
When enabled on supported platforms, this feature protects file contents
keys from certain attacks, such as cold boot attacks.

This feature uses the block layer support for wrapped keys which was
merged in 6.15.  Wrapped key support has existed out-of-tree in Android
for a long time, and it's finally ready for upstream now that there is a
platform on which it works end-to-end with upstream.  Specifically,
it works on the Qualcomm SM8650 HDK, using the Qualcomm ICE (Inline
Crypto Engine) and HWKM (Hardware Key Manager).  The corresponding
driver support is included in the SCSI tree for 6.16.  Validation for
this feature includes two new tests that were already merged into
xfstests (generic/368 and generic/369).

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: add support for hardware-wrapped keys

 Documentation/filesystems/fscrypt.rst | 187 +++++++++++++++++++++++++++-------
 fs/crypto/fscrypt_private.h           |  75 ++++++++++++--
 fs/crypto/hkdf.c                      |   4 +-
 fs/crypto/inline_crypt.c              |  44 ++++++--
 fs/crypto/keyring.c                   | 132 +++++++++++++++++-------
 fs/crypto/keysetup.c                  |  63 ++++++++++--
 fs/crypto/keysetup_v1.c               |   4 +-
 include/uapi/linux/fscrypt.h          |   6 +-
 8 files changed, 410 insertions(+), 105 deletions(-)

