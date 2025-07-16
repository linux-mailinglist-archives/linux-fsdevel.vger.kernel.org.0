Return-Path: <linux-fsdevel+bounces-55124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD7B070CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DA18911B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EE92EF282;
	Wed, 16 Jul 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdVB5mp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC228C872;
	Wed, 16 Jul 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655266; cv=none; b=NxGzuvHVjSsYeHOZ0kJSZVNP8f1su6qNd7AA/P4R8E1V73ODK/fIOwxqgEfxjGT9Wk1d+J4wDRYoeU9VvU6fxzaTEOuzjB1RNwwpfhsmg2YQsqIYcuMMNiD3kfsOiwUvoyK08fcKmR/wP8U0HFXy8hAPnwNu/3CpHU/ZMZHu5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655266; c=relaxed/simple;
	bh=mi/iQzwAUcNWNN3xOVg3QIwFGDVYgNwHIeGU+B4JcDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajf/NZpPnCc+348bBITiAl9u0VCYCp4UtK7s4FibINcKJKd9qDjBV+oO8h8lgQNfenjm01nwkflTEYqvOHC4Hde+Xx+mKvt265xCxoIfESSCDEpQpruxZKfUDXsO7/PksfdZkd/ijjIjGPuDlECTGegUqvXIlZUeXen5XQDsgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdVB5mp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABCEC4CEF0;
	Wed, 16 Jul 2025 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752655266;
	bh=mi/iQzwAUcNWNN3xOVg3QIwFGDVYgNwHIeGU+B4JcDU=;
	h=From:To:Cc:Subject:Date:From;
	b=DdVB5mp2uePcrb3oJDCIQbVydQ+zDPDeDAewPwkDCdFXgHifjMJpQlnFdMp8FU6zo
	 6id886dDcLUfRz/mNaVckKfhkwq3gZi+tozrn/Rx7CDp1PWMGdDUuMPbspBUeRQvzv
	 BacCaf/PX8D2qC/u4OQrvC2BGk35fRH3pVvEnWI3F/Cw3HztjFR00EP5pD0+NuRFiH
	 vTcV/vme8IIQjskFU1BXmEc1vhH2XIv1y7pFbG6cx1cJ6FuHanOQe6x4FXmdC/abdK
	 z7886Ivmsal2WiQ0pnsH6DKn+ap3a9CrIUBY3KTy+m6mRwmV3o8xTiBoR8TcQGiQ10
	 8UQ75r2LU2m7A==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.com>
Subject: [PATCH] MAINTAINERS: add block and fsdevel lists to iov_iter
Date: Wed, 16 Jul 2025 10:40:45 +0200
Message-ID: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=brauner@kernel.org; h=from:subject:message-id; bh=mi/iQzwAUcNWNN3xOVg3QIwFGDVYgNwHIeGU+B4JcDU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUp85kapFUP+vK3TY785HIpM+s+2XmPT/g7iG8mn/36 wvLKvsEO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS+prhf+65gyUsuXb6KTWC s0tvMi2bFrb43k+ntbubfxVK7a2/2svwP/Na60uxc1EsGS+c4u34Tv3X/fPXtHL/npOfK2O/zim LYwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

We've had multiple instances where people didn't Cc fsdevel or block
which are easily the most affected subsystems by iov_iter changes.
Put a stop to that and make sure both lists are Cced so we can catch
stuff like [1] early.

Link: https://lore.kernel.org/linux-nvme/20250715132750.9619-4-aaptel@nvidia.com [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..fcefe222f093 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25907,6 +25907,8 @@ F:	fs/hostfs/
 
 USERSPACE COPYIN/COPYOUT (UIOVEC)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
+L:	linux-block@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	include/linux/uio.h
 F:	lib/iov_iter.c
-- 
2.47.2


