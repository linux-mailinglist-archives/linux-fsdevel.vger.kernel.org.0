Return-Path: <linux-fsdevel+bounces-7907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A882E82CE09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 18:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D16283E90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D65695;
	Sat, 13 Jan 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Nmofdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B25663;
	Sat, 13 Jan 2024 17:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EC2C433C7;
	Sat, 13 Jan 2024 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705168566;
	bh=o0ViNHP3TScYhkELwvt+eygKREygV0KbiPNAvWpOviQ=;
	h=Date:From:To:Cc:Subject:From;
	b=q2NmofdohcSTZOCOVDonGkIyNmHLoKklk1ors4PoNFjlPxXY1x088uCM2B6W0+Aqd
	 qkUH2lBLb+iF/I0rrtpZb7Xiuc6pNOR1OOeWqeu6JVFcW3oJ0rZx/gGcbd8OF9OxnC
	 FWCD8p6w9rCHMRB0TZb34l6v/lDf3YFch6jYPTTw0l8d4UEojN1IFw0A9HEGveuykE
	 /iWaPuyfcHC8+dDPC0rBdqsiHIzajh+CQ+S1QiUlvPl/jMDQy7NYn3ceHjuR5jlRgf
	 nMrei7rO+3gM4273h6cMImSuAFS0yRKOIjwi/Q16LRSarHrjryT3Cwgw/xCuAzsziC
	 0hizZK5hOKlhg==
Date: Sat, 13 Jan 2024 09:56:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscrypt fix for 6.8-rc1
Message-ID: <20240113175604.GA1409@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 38814330fedd778edffcabe0c8cb462ee365782e:

  Merge tag 'devicetree-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2024-01-12 15:05:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to c919330dd57835970b37676d377de3eaaea2c1e9:

  f2fs: fix double free of f2fs_sb_info (2024-01-12 18:55:09 -0800)

----------------------------------------------------------------

Fix a bug in my change to how f2fs frees its superblock info (which was
part of changing the timing of fscrypt keyring destruction).

----------------------------------------------------------------
Eric Biggers (1):
      f2fs: fix double free of f2fs_sb_info

 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)


