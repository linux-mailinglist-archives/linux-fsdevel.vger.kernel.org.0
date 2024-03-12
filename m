Return-Path: <linux-fsdevel+bounces-14181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81EB878DC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 05:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CB21F21E85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 04:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE65BE6F;
	Tue, 12 Mar 2024 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkqfbv9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9DBA28;
	Tue, 12 Mar 2024 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217051; cv=none; b=asogfDd7b6n/MtyVakIyIOIVXjNwTAMCeXF7gcwW5O16okuql2iyGa4EkQOjkb+Gb1kUSVHJ6m9rGXC0E61WIFilcIhiMd7Q5ytrjlHkiomVIFFos+DuD4aMACuIpRvAGw7ga78uw2W4tYISQ7XxUxx0YL1lhztd2Uu1WyRGomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217051; c=relaxed/simple;
	bh=xz4MHuhx7VqPi+LlvH2nWgdl9tQFPX/Y615FRl2yNns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQqL5kVE7yZs0bdpbDfVzSfUWEQ0UyisBTnsOQM+cv5m4eEOxGoPgjA9Rvl1NoFAoH2YcHK0Wx3W6G6uLe6XGIpw1yR7okNYzh+jj5Yie6yRRJPldu198kUHYacIdrfQZD51crt6gi2sDY1pCFcOGG8ln4ULOCx1zu2pRzP5iLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkqfbv9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D976FC433F1;
	Tue, 12 Mar 2024 04:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710217051;
	bh=xz4MHuhx7VqPi+LlvH2nWgdl9tQFPX/Y615FRl2yNns=;
	h=Date:From:To:Cc:Subject:From;
	b=Rkqfbv9X9ca6+V61cxRxsVeWTUIWcoFaMPWn7C4/hRsTFF7zMHtQsrF8R2TBIrlM1
	 76w4fZQDomVGChmjKmR9E3C8WpVSwNQ8rc4go6fJ8vzQtvvVZeHgsfda4+WSmAaxjN
	 tQAzmGy8v1zBVXTt/J3nVY9tFa+cIT/AjH645/25tikEgCZ4g1LLb7XaFLUmB0nmyC
	 LMwGWRFYWlIDqLQMIgayZoWM6anydq0W9o9DxxNPkxvg1LK1T0PBoz8LoTlFV+jf22
	 98Chwz7VgiO3vxsgQXEG29ftePq+KqAyGnFhGIRxT9cf07Zp0wqxolryn9qgOf/j7S
	 vSJ6s4yWJbH8Q==
Date: Mon, 11 Mar 2024 21:17:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Luis Henriques <lhenriques@suse.de>, Xiubo Li <xiubli@redhat.com>
Subject: [GIT PULL] fscrypt updates for 6.9
Message-ID: <20240312041729.GH1182@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 8c62f31eddb71c6f6878258579318c1156045247:

  fscrypt: shrink the size of struct fscrypt_inode_info slightly (2024-02-23 22:03:48 -0800)

----------------------------------------------------------------

Fix flakiness in a test by releasing the quota synchronously when a key
is removed, and other minor cleanups.

----------------------------------------------------------------
Eric Biggers (2):
      fscrypt: write CBC-CTS instead of CTS-CBC
      fscrypt: shrink the size of struct fscrypt_inode_info slightly

Luis Henriques (1):
      fscrypt: clear keyring before calling key_put()

Xiubo Li (1):
      fscrypt: explicitly require that inode->i_blkbits be set

 Documentation/filesystems/fscrypt.rst | 27 +++++++++++++++------------
 fs/crypto/fscrypt_private.h           | 14 ++++++++------
 fs/crypto/keyring.c                   |  8 ++++++--
 fs/crypto/keysetup.c                  | 11 +++++++----
 4 files changed, 36 insertions(+), 24 deletions(-)

