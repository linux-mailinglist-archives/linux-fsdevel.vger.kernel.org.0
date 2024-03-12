Return-Path: <linux-fsdevel+bounces-14182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68556878DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 05:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B081C2170C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 04:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1440BE47;
	Tue, 12 Mar 2024 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idN/k94N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020FDB66F;
	Tue, 12 Mar 2024 04:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217256; cv=none; b=b6+HPF+qJZux/nHdYEI8bbjRM2CHGbtfBw+ftgkXvf8ylMeyEclcAOyO1jTsmBnjudz293p+mo9dXDZFLRliAYAbHXKyYMGKd3g6VoMWzGmfMkijVMXERzDCj6fwhQLMFyCX0zw44F2xVCNF74epquqiE6AaioXmcF8YlM8sqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217256; c=relaxed/simple;
	bh=6jUkBlOs8/qYxnY11jCaAhAjrJV89oOkFL8yos84uFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mwu2wSMa9RQL1p/B3QPvf9W/hTjUZj46mFzrAdGIWa5RGmZnh62unY65WyLJsZO16FDQRMxnkSu984Upjxie17WLew1Q2Ym518FLLWKjOJZm+2+jcDMpTtrVfX1Sf+AJaaNXMotQ/3XHsi81EHe8hVijeUjLIyb26oY+BfYXMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idN/k94N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625E2C433C7;
	Tue, 12 Mar 2024 04:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710217255;
	bh=6jUkBlOs8/qYxnY11jCaAhAjrJV89oOkFL8yos84uFQ=;
	h=Date:From:To:Cc:Subject:From;
	b=idN/k94NnT6596YAEgOX2Quo0sYcm1GHsfHDV7e4KnNxWCkGfBFfmOfirB/t9H0ln
	 AfJlqrSd0UlL6rCHLjvn8mg+hsBgUuPcZWAZXSV3gG1/JMNc9MYIRZPQwJ0CrX1aRN
	 NCmHZ0wZGJTO8/+y7ND9MXouOZmRWNvBxXHS3M1xHr7lZpRRjTe6Hni9mu6xkjRNjt
	 swgz8BcmKdfOwpz+MqCpEbj505M8vQYzD+tbyIAOgU5MvIFwHNw01E1lqCUNVOvhBc
	 KbrBU/vCghbyqap1UYtXr2QV2Yf2dHLDrMsu8bmWZLp6ALZCxtJaUgVYkhKNrq/yUj
	 sLR3zK8aYy0Qw==
Date: Mon, 11 Mar 2024 21:20:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Andrey Albershteyn <aalbersh@redhat.com>
Subject: [GIT PULL] fsverity updates for 6.9
Message-ID: <20240312042053.GI1182@sol.localdomain>
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

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 8e43fb06e10d2c811797740dd578c5099a3e6378:

  fsverity: remove hash page spin lock (2024-02-01 15:19:23 -0800)

----------------------------------------------------------------

Slightly improve data verification performance by eliminating an
unnecessary lock.

----------------------------------------------------------------
Andrey Albershteyn (1):
      fsverity: remove hash page spin lock

 fs/verity/fsverity_private.h |  1 -
 fs/verity/open.c             |  1 -
 fs/verity/verify.c           | 48 ++++++++++++++++++++++----------------------
 3 files changed, 24 insertions(+), 26 deletions(-)

