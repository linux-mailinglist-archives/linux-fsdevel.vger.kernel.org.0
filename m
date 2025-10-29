Return-Path: <linux-fsdevel+bounces-66138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB052C17D98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C44403CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B32D7DDB;
	Wed, 29 Oct 2025 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svRsLpJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AD78F2B;
	Wed, 29 Oct 2025 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700827; cv=none; b=nlBoXK8qkuIoQimq6N8EG/ogwIeJPNOSv84rUx7AolGstOi/fXiT86ky6eJ0jt2mDBZHPVfwLSygH6GjVjx4+ean7ooa57De8wuyQZVpm1cW519rx6yPIzGD0/yjkjTQnI0A5OwRgBpsQM1lGVC7pVc90OP+BNNekohR8vupDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700827; c=relaxed/simple;
	bh=KHl4n625Af6eME5dUyAG8Q8ffCdeA4hxnNyL0y08xbY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdF/OxwBvSGwerJZ51lODELGaKQawUAG2EXkwv1g2KIObb3aCb7tqa7X4HYKcLOw9yTpg16/0/p4AZbKx+83eVMAL+aX1pDFVClCTpW0YCuA5V5uSFexl/FtD3YSBjbGiayGC99YBcwBqAlCHvYcu0Q3gDb/RDeU+t69xc/rdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svRsLpJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723F9C4CEE7;
	Wed, 29 Oct 2025 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700826;
	bh=KHl4n625Af6eME5dUyAG8Q8ffCdeA4hxnNyL0y08xbY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=svRsLpJamnGG+aJ4LvJ4qTPgUW/n7dpAvXGmWhERGg2PDmX9ZBPYUWkrLNRqAe70w
	 1LDJoI4KRcGdncXrqpCtJJEVBupPc2qgPsjoNFrjzGvaLyRN0gkOrbUBWiU134lai6
	 Hm+2ijtZfBXySf9x4RW2NfP/8gxFNCUiOsJ85L386pmOJGNBbHzm57NiRnRGmDEaK3
	 pVmvyhpWDH0xZqgHaPJqbTc9Sez61OUtuI1zTVEWKQrlHCGRTJ23Isv2xqU9xWrBLu
	 qrYckJO23z0588vtYyb/fPK/l+1c+8FJ+UUA2pn5Iv8XB6k7zIwH4tDxZhBW0c8KIh
	 qLSrRn/5u64hw==
Date: Tue, 28 Oct 2025 18:20:26 -0700
Subject: [PATCH 7/7] debian: update packaging for fuse4fs service
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169819159.1431292.1462305252707455763.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
References: <176169819000.1431292.8063152341472986305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Update the Debian packaging code so that we can create fuse4fs service
containers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 debian/e2fsprogs.install |    7 ++++++-
 debian/fuse4fs.install   |    3 +++
 debian/rules             |    3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 debian/fuse4fs.install


diff --git a/debian/e2fsprogs.install b/debian/e2fsprogs.install
index 17a80e3922dcee..808474bcab1717 100755
--- a/debian/e2fsprogs.install
+++ b/debian/e2fsprogs.install
@@ -50,4 +50,9 @@ usr/share/man/man8/resize2fs.8
 usr/share/man/man8/tune2fs.8
 etc
 [linux-any] ${deb_udevudevdir}/rules.d
-[linux-any] ${deb_systemdsystemunitdir}
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub@.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub@.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_all.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_all.timer
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_fail@.service
+[linux-any] ${deb_systemdsystemunitdir}/e2scrub_reap.service
diff --git a/debian/fuse4fs.install b/debian/fuse4fs.install
old mode 100644
new mode 100755
index 17bdc90e33cb67..56048136c2b28b
--- a/debian/fuse4fs.install
+++ b/debian/fuse4fs.install
@@ -1,2 +1,5 @@
+#!/usr/bin/dh-exec
 usr/bin/fuse4fs
 usr/share/man/man1/fuse4fs.1
+[linux-any] ${deb_systemdsystemunitdir}/fuse4fs.socket
+[linux-any] ${deb_systemdsystemunitdir}/fuse4fs@.service
diff --git a/debian/rules b/debian/rules
index b680eb33ceac9e..b5c669c58c3a9b 100755
--- a/debian/rules
+++ b/debian/rules
@@ -173,6 +173,9 @@ override_dh_installinfo:
 ifneq ($(DEB_HOST_ARCH_OS), hurd)
 override_dh_installsystemd:
 	dh_installsystemd -p e2fsprogs --no-restart-after-upgrade --no-stop-on-upgrade e2scrub_all.timer e2scrub_reap.service
+ifeq ($(SKIP_FUSE2FS),)
+	dh_installsystemd -p fuse4fs fuse4fs.socket
+endif
 endif
 
 override_dh_makeshlibs:


