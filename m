Return-Path: <linux-fsdevel+bounces-44852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B2A6D164
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 23:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C8618952C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CF1B041E;
	Sun, 23 Mar 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZXKPy2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C53D561;
	Sun, 23 Mar 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768413; cv=none; b=fREa/n7Xd3Jp4mlclhk5AAdLUYB9H39KmDY0NjKPFPFzUzyX6W1t7UECOF3zI77bx7RQeH/A0k81qAF9EAz0r/MuJQfi6xzT9ezbzbg+AN3/fjigp9rSbARaWbw35GQz3mf0UB3B94WjaiENYm0l7XO7qLXu8VK6CaYLZDBwSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768413; c=relaxed/simple;
	bh=GB36pMTAasX1Pbrs9LyO95OprpoN7cMJr2SHJpME9mI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HxWc5M6uAjzoHbIxl3dZDwcF3a+nGgCjZ3u6B1zYuVaDt7oCt2qXK4Pxf5GkHPMxkOPJA0sY+/uPjEgxRTe7hIOELLOniVYXTCwkWgqf0H6CAxzBjhyEPXh93NxPQldWsQKFIbaDiCTlyIA4ifyni+qoQFNVNwyNm+VSqOmn0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZXKPy2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B45C4CEE4;
	Sun, 23 Mar 2025 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742768413;
	bh=GB36pMTAasX1Pbrs9LyO95OprpoN7cMJr2SHJpME9mI=;
	h=Date:From:To:Cc:Subject:From;
	b=FZXKPy2mDlMacYZBUVXW2ay5MLWnJMmmwbhBQDlOrNHy68IJs5mETFAuwM31oDqgK
	 TxtumgMuLnKSoLCP1/ZmkQGCF2+QlyvePX/eKcdNFykbp8HnV8R01rFVCRYrQkYExX
	 gBIH9029DaXVaMU09X2uGZTvQUvlNtUjpwUfIqnjKCpmil53kUt3tbsYCCFYTQTu3c
	 eUl5pWph/Q3MasJs8XX3NXwJ20MYHTwZ9a/mVvcveLBT6DLHSqYnwybiGhrv0+enph
	 Ev79B2Os5hwvPt+USKVo725nqG1xi6CnjiBceKYR7B9MQZG6ZiQSLqjs9Lu3xFWp9o
	 rLlIjrCiomKwQ==
Date: Sun, 23 Mar 2025 15:20:11 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] fsverity updates for 6.15
Message-ID: <20250323222011.GB9584@sol.localdomain>
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

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to a19bcde49998aac0a4ff99e9a84339adecffbfcb:

  Revert "fsverity: relax build time dependency on CRYPTO_SHA256" (2025-02-17 11:34:15 -0800)

----------------------------------------------------------------

A fix for an issue where CONFIG_FS_VERITY could be enabled without some
of its dependencies, and a small documentation update.

----------------------------------------------------------------
Allison Karlitskaya (1):
      Documentation: add a usecase for FS_IOC_READ_VERITY_METADATA

Eric Biggers (1):
      Revert "fsverity: relax build time dependency on CRYPTO_SHA256"

 Documentation/filesystems/fsverity.rst | 16 +++++++++++-----
 fs/verity/Kconfig                      |  8 ++------
 2 files changed, 13 insertions(+), 11 deletions(-)

