Return-Path: <linux-fsdevel+bounces-73272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B496D13CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AF02304613C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710F3624B2;
	Mon, 12 Jan 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKL8JGVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735BB29BD80
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232849; cv=none; b=ZSNsB79D6kq/YQ22j8oH/tW2bHZpKamJrv5Hcxt6CzXzcoP2b24otnp3eL80TADig4c9NU7dPRnB/+EfcdILsMVNyNSmOLhyHBNJE3Ee+vxFl6fhto+dQXbXMdhewb5cfBkwdAgR8zzqpEuVI2zC4xuQ60SbhIB20HaepVnVN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232849; c=relaxed/simple;
	bh=6HQrZh39fYDkRra4JodEUv2QUElh0CEboGRC13P1ObY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Csw9/JhF6R/s0AtoMQVj04LBUxm98EdTg3za36VSz8QxZbfaOrIEpsw9dvHat1KFc1SMf4uO1tC8sVb4yhh1/CpRsovJ6szfHNGSOk/joZ2ngA0DqfymTEehjGk84mEaV3m5dKDFOB5ldXEEz9vneNRuBUD2G6cyqmgPYA/htTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKL8JGVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45000C16AAE;
	Mon, 12 Jan 2026 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232849;
	bh=6HQrZh39fYDkRra4JodEUv2QUElh0CEboGRC13P1ObY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HKL8JGVS9mN0k3hPJqKhOj/IH/64SkAXp4MfwUSwSZDw3drrvikQjso4wveElnNT8
	 FCJ5idepO2MBEboMwa79vh2b1A+leYyBAyqh4aSbMxQK3oe68c6nKhgJ3i5en3pC/P
	 JvRizmS5ox1nMpAaJpypd7kPl7EhKKN2h0NP796ZRa1mCHhezM52Qw1P7rPsZ/raBV
	 IKPPYaFmveLtJWfiMWJ2Zl4OBowLrLfHzgwEnAu3AwH+Uh/keoP2LaBGP0GwPMjoSW
	 k6hcEea7uFF8gZfE+tiYVjtcjjCaWMRrdCNTWDty7aha2lF5yhjh/FL84V7zO5ppGm
	 XGDI2GDqd1qOg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Jan 2026 16:47:11 +0100
Subject: [PATCH v2 4/4] docs: mention nullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-work-immutable-rootfs-v2-4-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6HQrZh39fYDkRra4JodEUv2QUElh0CEboGRC13P1ObY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmirfKTr7TV/zz9bf1y9qzqwucP6acY4m6v51HKV1ge
 lmoP9f+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMMWH4xZSvFnK4vzGuMoBZ
 RK2ofKGtV/n0reIvDCY2v3V/80DQiZFhQ1yDW6xY7ewOifi/OgLCjHO3Vkz8qT2r7y//Yo87Lxy
 ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a section about nullfs and how it enables pivot_root() to work.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/ramfs-rootfs-initramfs.rst         | 32 ++++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index a9d271e171c3..a8899f849e90 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -76,10 +76,15 @@ What is rootfs?
 ---------------
 
 Rootfs is a special instance of ramfs (or tmpfs, if that's enabled), which is
-always present in 2.6 systems.  You can't unmount rootfs for approximately the
-same reason you can't kill the init process; rather than having special code
-to check for and handle an empty list, it's smaller and simpler for the kernel
-to just make sure certain lists can't become empty.
+always present in 2.6 systems.  Traditionally, you can't unmount rootfs for
+approximately the same reason you can't kill the init process; rather than
+having special code to check for and handle an empty list, it's smaller and
+simpler for the kernel to just make sure certain lists can't become empty.
+
+However, if the kernel is booted with "nullfs_rootfs", an immutable empty
+filesystem called nullfs is used as the true root, with the mutable rootfs
+(tmpfs/ramfs) mounted on top of it.  This allows pivot_root() and unmounting
+of the initramfs to work normally.
 
 Most systems just mount another filesystem over rootfs and ignore it.  The
 amount of space an empty instance of ramfs takes up is tiny.
@@ -121,17 +126,26 @@ All this differs from the old initrd in several ways:
     program.  See the switch_root utility, below.)
 
   - When switching another root device, initrd would pivot_root and then
-    umount the ramdisk.  But initramfs is rootfs: you can neither pivot_root
-    rootfs, nor unmount it.  Instead delete everything out of rootfs to
-    free up the space (find -xdev / -exec rm '{}' ';'), overmount rootfs
-    with the new root (cd /newmount; mount --move . /; chroot .), attach
-    stdin/stdout/stderr to the new /dev/console, and exec the new init.
+    umount the ramdisk.  Traditionally, initramfs is rootfs: you can neither
+    pivot_root rootfs, nor unmount it.  Instead delete everything out of
+    rootfs to free up the space (find -xdev / -exec rm '{}' ';'), overmount
+    rootfs with the new root (cd /newmount; mount --move . /; chroot .),
+    attach stdin/stdout/stderr to the new /dev/console, and exec the new init.
 
     Since this is a remarkably persnickety process (and involves deleting
     commands before you can run them), the klibc package introduced a helper
     program (utils/run_init.c) to do all this for you.  Most other packages
     (such as busybox) have named this command "switch_root".
 
+    However, if the kernel is booted with "nullfs_rootfs", pivot_root() works
+    normally from the initramfs.  Userspace can simply do::
+
+      chdir(new_root);
+      pivot_root(".", ".");
+      umount2(".", MNT_DETACH);
+
+    This is the preferred method when nullfs_rootfs is enabled.
+
 Populating initramfs:
 ---------------------
 

-- 
2.47.3


