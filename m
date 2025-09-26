Return-Path: <linux-fsdevel+bounces-62885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78101BA419F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6CD3858CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA701FBE87;
	Fri, 26 Sep 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji3c4v7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920E1F4192;
	Fri, 26 Sep 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896353; cv=none; b=Fkq/MARck7v/3RwrPNkFwBDp16y+oUtfduDzSVQ2ppHZKMZTd5nhrBEM1X+IuL68yUmL4AkGnyOVJME6s2cFpgz74Ku4tZB0qZh1941l7+IqnPHn5SeKzcUHadQtYdOqqvTkVol7Fc04bWIe4dY0DX/I/90zPviWdHeKxjw6doA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896353; c=relaxed/simple;
	bh=QPeFFiaGmfZ49yeTi5Za9yvH8GXYhv6NBNKahJr3hzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1Uo8hgeX4M/mITEycD+gunVpjoUj6lWH6loWK2sXZqh4mb/CnrP7qZQ+r2FeVBaFucxU3limTQz7mzGTA5TuL6Wv4VtLBnj/5NWzw79+VpJXuKsglm+vcZKXjZT7NfdxS0teDcNVANMk0oGX/hh9Xc/GeOqGxWZikA67sB4KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji3c4v7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609A0C113CF;
	Fri, 26 Sep 2025 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896353;
	bh=QPeFFiaGmfZ49yeTi5Za9yvH8GXYhv6NBNKahJr3hzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ji3c4v7yyNh3C+Amgk+DrtWhqRHpdUctGq7YFdG86R+cX9RWHN2HQwsmbrEdpFQ/e
	 M0HSGQs+TiNIWzsCZH2MLvEqIgRHrleehNrlSCe4o4Ll/EkAfG8G99jBSAPNtknnjd
	 Dbkrl1jNz7IwGYwiYdBtsefRSVHMVgPlghuOswJvGyfRJgTT3XVxmJ9uY9XaGzYmPq
	 AUEdeL4DaqNFd8xAHxSknS2sLpRwbcpJPyFrCTeJOkallLOGjMQgdFpkEWZu33qAmA
	 bBAJqGAOOCxHiobiED7DxSRVcdctJ7JlEN+uMdkybSiC3mMK4F+zW/BHt38KuwnxA0
	 Kf4AQGeVWJNPg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/12 for v6.18] rust
Date: Fri, 26 Sep 2025 16:19:00 +0200
Message-ID: <20250926-vfs-rust-48d4952276a5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=brauner@kernel.org; h=from:subject:message-id; bh=QPeFFiaGmfZ49yeTi5Za9yvH8GXYhv6NBNKahJr3hzE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3Ahik92jeSCbM+Hj4qXVDx4vo573eYHjcxbvz3e5 HA56X/amo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJvF7HyHD6+NdN4WdcNyvP VbvZZtyqfzFXyPzu6gtanNbWMYn2K6IY/gr6VzteMf+3WYB7yeV9oW+NGRsDT1Rz+y/2Vk5eLbL KlxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few minor vfs rust changes:

* Add the pid namespace Rust wrappers to the correct MAINTAINERS entry.

* Use to_result() in the Rust file error handling code.

* Update imports for fs and pid_namespce Rust wrappers.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.rust

for you to fetch changes up to c37adf34a5dc511e017b5a3bab15fe3171269e46:

  rust: file: use to_result for error handling (2025-09-01 13:55:22 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.rust tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.rust

----------------------------------------------------------------
Alice Ryhl (1):
      pid: add Rust files to MAINTAINERS

Onur Özkan (1):
      rust: file: use to_result for error handling

Shankari Anand (2):
      rust: pid_namespace: update AlwaysRefCounted imports from sync::aref
      rust: fs: update ARef and AlwaysRefCounted imports from sync::aref

 MAINTAINERS                  |  1 +
 rust/kernel/fs/file.rs       | 10 +++++-----
 rust/kernel/pid_namespace.rs |  5 +----
 3 files changed, 7 insertions(+), 9 deletions(-)

