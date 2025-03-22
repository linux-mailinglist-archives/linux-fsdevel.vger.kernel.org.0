Return-Path: <linux-fsdevel+bounces-44772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A183A6C90B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70B37A4B45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451A1FBCB1;
	Sat, 22 Mar 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icPK/rDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A516DC28;
	Sat, 22 Mar 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638551; cv=none; b=Q5Z/VGojjk0f3D6fUVe0PwCyj/sHZamHpV0dUM59KlNumV5oCWEhkoCPtg3NDi6rDAT1z86N/Ks9AQiHlgB4oTOavQ9iY/n+0DhlO2KjzZetRKvkIdgRgu2b32ReuT7qkW+Nm+az53WkC23J1MaYrCT00/bzpZ/XbYNPs5Qz94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638551; c=relaxed/simple;
	bh=G7L3pgL41zLXMcCt+l0If9AHx6p9D72YR4JWDQfOLe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ofq4LHcFi1+IRStQSkQEfYIjD2xzMnJcaXuNvugZsfbsH+QHA0STQLZ6TpaeplejToqmJypt7Z5GWy9w20d2dv5if/yAkKjGSsPWfY/bYu5egiNf1riw8QcaawJ1a3nV8bGQck4gBR6XUzXmwOLexpZbXYOuM29qU1T/3TBZX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icPK/rDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9080AC4CEDD;
	Sat, 22 Mar 2025 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638550;
	bh=G7L3pgL41zLXMcCt+l0If9AHx6p9D72YR4JWDQfOLe0=;
	h=From:To:Cc:Subject:Date:From;
	b=icPK/rDkRIIy9t0z7XYCKFj4WHfFQL7Qz0PU/U8d3Vx3daHKcHpwrQd8mcNDYQfxp
	 I3NR9rXOe1ou7snhcH9j0piN3qj9FUpFdzE5s7A959My27h4/OzCQqkVBIH+WLii5R
	 L3MWKCI2QRu8gnA/cSE/zp3gg5Q7NkCbuFIxaq7VgySAoL9MLBM5TqttVWGARFcDam
	 SNF7UAKFwohyXDVNO/umN6aLuDFWYebSwtGY/CjqotteSR9pkzqGXym/8Vw+bge6on
	 8TY+BBU7KXqMUBdfOh/Q2Cd/6enqZ1ar5AKO3PLO49G9OpjPpAW5QDE1k5llYf4BNb
	 0YgntlEGashCw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs eventpoll
Date: Sat, 22 Mar 2025 11:15:44 +0100
Message-ID: <20250322-vfs-eventpoll-6e7927cfbe2c@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=brauner@kernel.org; h=from:subject:message-id; bh=G7L3pgL41zLXMcCt+l0If9AHx6p9D72YR4JWDQfOLe0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf670gs/1ZOofKCeHSlnNTrlxsZtpZIynlwWRS1MG0V 6xzwalDHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP58IORoeH/qV9/ROtkQias Cy1w8DwpUKS28+mmDqP7JjvdNuzKu8XI0Lp0zeJUmR1bDj8+IM8/j8HjVsgnz1XOMtyuu5TNbCe 8YQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few preparatory changes to eventpoll to allow io_uring
to support epoll.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.eventpoll

for you to fetch changes up to 0511f4e6a16988e485a5e60727c89e2ca9f83f44:

  Merge patch series "epoll changes for io_uring wait support" (2025-02-20 10:18:47 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.eventpoll tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.eventpoll

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "epoll changes for io_uring wait support"

Jens Axboe (3):
      eventpoll: abstract out parameter sanity checking
      eventpoll: abstract out ep_try_send_events() helper
      eventpoll: add epoll_sendevents() helper

 fs/eventpoll.c            | 87 ++++++++++++++++++++++++++++++++++-------------
 include/linux/eventpoll.h |  4 +++
 2 files changed, 67 insertions(+), 24 deletions(-)

