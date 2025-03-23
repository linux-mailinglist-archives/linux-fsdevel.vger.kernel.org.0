Return-Path: <linux-fsdevel+bounces-44851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4CFA6D163
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 23:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CA189529D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041241AAA1B;
	Sun, 23 Mar 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0Uvda6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C095134AB;
	Sun, 23 Mar 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768365; cv=none; b=roz8jRjab+gnKx5zlmjN+CM1667Iud9HkktJXlAZ8nIuN3XzmP9uNliyijIS4mb0eWHu7Ej0uUpDcaVI99aLsQGUydgUDhgLYSePy5I7HiIPqlLrKYCyDefxT0fvUwNaZ8R6cNhxN2Wg1E+aFQxv73dfv4i387e3FfZCjFsw6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768365; c=relaxed/simple;
	bh=zQYAC0WeK/HLdSMPs5eI3xI9ESFZnHjQhuLSNcMGd6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ExQtPiAjK4JWnG1YUaxwxSc578sf1ts8khbi56vIt7/5QOp/zFxQ4rTbIReZxwR1EbTalwGyDEvJaMUVzIRHgcVp8R02I3NFrG4o7r2jPAnutnVVKcgxHMOVf1l599YAjyO/Vq2PzPKoJr1pD3B8BJh+idLd57FKE2ipCDGySTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0Uvda6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96701C4CEE2;
	Sun, 23 Mar 2025 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742768364;
	bh=zQYAC0WeK/HLdSMPs5eI3xI9ESFZnHjQhuLSNcMGd6w=;
	h=Date:From:To:Cc:Subject:From;
	b=r0Uvda6qvOHETsqnNvJSZWwURFFLvwuCLYIKTbo7vmVoWZWtHEThZqIPX5Bix9ZY3
	 zf4tmn+4AMruqai/TgM9zCbnfubYyhX3byqAEI3BWimRsg+Zch/lVxQH32pmUmG/el
	 Tfc0QxIvAWCh/q+rHlZn1a8IM+iiTLVPeTfDIBhNecHCynhbVd2zK/ZjnzMaA18+ro
	 lygTLJF0BJ7T16tNIiilU1tX9QNLot0TYiEk5CCYiRZN3cUr42xjF/168vuElERFMp
	 dpsN9HdoD/h8plJM/0vA9VQM2TC3a9eAkeaaU1CUNNeXGIcY0KRKUR1TJFTqsJTZ6k
	 IJgESyZ8bTuWw==
Date: Sun, 23 Mar 2025 15:19:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [GIT PULL] fscrypt updates for 6.15
Message-ID: <20250323221923.GA9584@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 13dc8eb90067f3aae45269214978e552400d5e28:

  fscrypt: mention init_on_free instead of page poisoning (2025-03-04 13:02:45 -0800)

----------------------------------------------------------------

A fix for an issue where CONFIG_FS_ENCRYPTION could be enabled without
some of its dependencies, and a small documentation update.

----------------------------------------------------------------
Eric Biggers (3):
      Revert "fscrypt: relax Kconfig dependencies for crypto API algorithms"
      fscrypt: drop obsolete recommendation to enable optimized ChaCha20
      fscrypt: mention init_on_free instead of page poisoning

 Documentation/filesystems/fscrypt.rst |  8 ++------
 fs/crypto/Kconfig                     | 20 ++++++++------------
 2 files changed, 10 insertions(+), 18 deletions(-)

