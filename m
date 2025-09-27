Return-Path: <linux-fsdevel+bounces-62934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79CBA62F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B367A977C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5AA1FA859;
	Sat, 27 Sep 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+c75Nqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F428371;
	Sat, 27 Sep 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759002499; cv=none; b=usEnp0GF6q12r9KTw4G2od6FeSlshADV8c+9UKMNf+wXA/AOMQG6Ljo9uyHrH82NX9IIyWONCnmPa4YkNxD2BD15J3OnCAYSfELombUxYKKl8b0QVuIuo02YJtHrxioeOouM1l31yVIorNMFiQ194qTgyom2WhOnQAXU7LOe54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759002499; c=relaxed/simple;
	bh=QBA3zI/gBN7kvMlUos4rsKwGEVoup2MTT6dIRmJogTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uTBmag/oxLSfPVQP7gwo9Lnm/uFPJjtrpzLyNXvwOYHICzJoLmwvUrquTUDcjKySuU7OjNI8OdCuacjQE5UIA6dVu6yIhvHZJKJtUwb34V+UPM7R6Myd6O1wghhkKNNfleIlNBBBW8DbO1rcMx5ev0vZPKyMUluBhhG282DFa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+c75Nqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FBAC4CEE7;
	Sat, 27 Sep 2025 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759002499;
	bh=QBA3zI/gBN7kvMlUos4rsKwGEVoup2MTT6dIRmJogTU=;
	h=Date:From:To:Cc:Subject:From;
	b=U+c75NqdMSVuNnLZeADwRQlC5+UwoybGxFf59qBy0bLWflW0gSQ9L11MB7PdqD/sQ
	 mnZkFiAtuIYtIrm4eN8RRQsVkhKadSD13019JFGpEXDNWIlcKFiiM7Ii8v2i8xBrLd
	 tOZtPJ0MFEJECug+n5HXvGZZF8JxQekKP8ZDxkhTk+2XUiTj06v519a/c/lbUm5wK3
	 xDOB4Hxg4yuFvnMu7Jr7lwouZth/EFm2QhMKwvkonrsLXK1wxKZ3D4KfUUsAwNTel+
	 /e740d+iFOoBOq0E52j3GUHjjJhu3P9GSNKsPD9SX5/WzUwm3QtfNiQh9lhhWCn2kL
	 PH6DATyDlHSdQ==
Date: Sat, 27 Sep 2025 12:48:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [GIT PULL] fscrypt updates for 6.18
Message-ID: <20250927194816.GA8682@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 19591f7e781fd1e68228f5b3bee60be6425af886:

  fscrypt: use HMAC-SHA512 library for HKDF (2025-09-05 21:01:51 -0700)

----------------------------------------------------------------

Make fs/crypto/ use the HMAC-SHA512 library functions instead of
crypto_shash. This is simpler, faster, and more reliable.

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: use HMAC-SHA512 library for HKDF

Qianfeng Rong (1):
      fscrypt: Remove redundant __GFP_NOWARN

 fs/crypto/Kconfig           |   5 +-
 fs/crypto/bio.c             |   2 +-
 fs/crypto/fname.c           |   1 -
 fs/crypto/fscrypt_private.h |  26 ++++-------
 fs/crypto/hkdf.c            | 109 ++++++++++++++++----------------------------
 fs/crypto/hooks.c           |   2 +-
 fs/crypto/keyring.c         |  30 ++++--------
 fs/crypto/keysetup.c        |  65 ++++++++------------------
 fs/crypto/policy.c          |   4 +-
 9 files changed, 83 insertions(+), 161 deletions(-)

