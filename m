Return-Path: <linux-fsdevel+bounces-44770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC09A6C90F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCC31B6263E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADCF1F76C2;
	Sat, 22 Mar 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+obPair"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117031F4E5B;
	Sat, 22 Mar 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638528; cv=none; b=irEFU6nPrwuTbnDe87NzGWWet1iv2nNE0qWLDTBW61JvA7/EymfC/IGV3AwI8kcfHb+IkzvEWInQmjijVAqvzLHaVj9dbnWLwMBUoictIlK+4ygl4FR2OkJ3dOqA3Nj45AH+VzMoeNA2908mZ+Lo2BUzhe51jLdOeo/+0GecTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638528; c=relaxed/simple;
	bh=4JPL14EXAhhdMKCNh9Uw7eGfv0cTkrxoR3hLHQMl0Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1yBcCHwYJwKA71zdukacHzFJ4HP/etG+9aYNfeHuWWEZdR6zkQzTcJAk82SiIhqM3XnNUDIzvyUSwxy+AxFK6m+MfbgkdnlTA5wIUlnsyHZi5wq1W0ZJB4zQdxVYDz+g8YsLarViokMR3WhJrsC+gkwwsT7trLkPlbaSsEG07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+obPair; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA6C4CEDD;
	Sat, 22 Mar 2025 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638527;
	bh=4JPL14EXAhhdMKCNh9Uw7eGfv0cTkrxoR3hLHQMl0Hw=;
	h=From:To:Cc:Subject:Date:From;
	b=Q+obPairTZ/nLHfO7SjI9YybR4+wU5LrbSANrU0in/ZbqfUiARwAPymZIXq2o/OaV
	 HwqogAwyxRaz2dJaLnQPW1qUfMxESrMUNg3xAJWImGQZHyvL4hewgO4TiPNiR02OJ8
	 a1f6yFQzOgO1q+xxtNhryjKC2VhACWCIBclAMv9Qpwq2gQeXi2mNCGHHEvoog6ziZv
	 5nZfvvcbTQGSapf4TFT6csDYCVsU6++mdvxLgOdexi35U6ilny5l/G6EXcMq94EBcm
	 8zW/SO36Tlg9DDqABgVWi/a5fS/XxR1RRh2uylWhDCfskVP9phucN6nStvxW60hRoD
	 DSDiAUfTIGSyA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs overlayfs
Date: Sat, 22 Mar 2025 11:15:17 +0100
Message-ID: <20250322-vfs-overlayfs-fd5f08e77ed3@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21741; i=brauner@kernel.org; h=from:subject:message-id; bh=4JPL14EXAhhdMKCNh9Uw7eGfv0cTkrxoR3hLHQMl0Hw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf693lKvavjqvebs+yj/fyJgTcv9m3Qn75qgWfVL4oG EW9zf8n1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARR1eGf5YacuGiX90tVWY4 6nqF5j/sWM+wzNPA5GTn1P/rsjX/XmX4nznrQt7S2WUdDGvCsnzcxDv1Jwv8+H9eM0umSXWisv1 XDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains some work for overlayfs for this cycle.

Currently overlayfs uses the mounter's credentials for it's
override_creds() calls. That provides a consistent permission model.

This patches allows a caller to instruct overlayfs to use its
credentials instead. The caller must be located in the same user
namespace hierarchy as the user namespace the overlayfs instance will be
mounted in. This provides a consistent and simple security model.

With this it is possible to e.g., mount an overlayfs instance where the
mounter must have CAP_SYS_ADMIN but the credentials used for
override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
custom fs{g,u}id different from the callers and other tweaks.

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

This contains a merge conflict with the vfs-6.15.mount pull request:

diff --cc tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index e65d95d97846,fd1e5d7c13a3..000000000000
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@@ -19,17 -24,18 +24,22 @@@ FIXTURE(set_layers_via_fds) 
  
  FIXTURE_SETUP(set_layers_via_fds)
  {
 +	ASSERT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
 +	ASSERT_EQ(mkdir("/set_layers_via_fds_tmpfs", 0755), 0);
+ 	self->pidfd = -EBADF;
 -	EXPECT_EQ(mkdir("/set_layers_via_fds", 0755), 0);
  }
  
  FIXTURE_TEARDOWN(set_layers_via_fds)
  {
+ 	if (self->pidfd >= 0) {
+ 		EXPECT_EQ(sys_pidfd_send_signal(self->pidfd, SIGKILL, NULL, 0), 0);
+ 		EXPECT_EQ(close(self->pidfd), 0);
+ 	}
  	umount2("/set_layers_via_fds", 0);
 -	EXPECT_EQ(rmdir("/set_layers_via_fds"), 0);
 +	ASSERT_EQ(rmdir("/set_layers_via_fds"), 0);
 +
 +	umount2("/set_layers_via_fds_tmpfs", 0);
 +	ASSERT_EQ(rmdir("/set_layers_via_fds_tmpfs"), 0);
  }
  
  TEST_F(set_layers_via_fds, set_layers_via_fds)
@@@ -218,195 -224,302 +228,493 @@@ TEST_F(set_layers_via_fds, set_500_laye
  	ASSERT_EQ(close(fd_overlay), 0);
  }
  
 +TEST_F(set_layers_via_fds, set_500_layers_via_opath_fds)
 +{
 +	int fd_context, fd_tmpfs, fd_overlay, fd_work, fd_upper, fd_lower;
 +	int layer_fds[500] = { [0 ... 499] = -EBADF };
 +
 +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
 +	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
 +
 +	fd_context = sys_fsopen("tmpfs", 0);
 +	ASSERT_GE(fd_context, 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
 +	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
 +	ASSERT_GE(fd_tmpfs, 0);
 +	ASSERT_EQ(close(fd_context), 0);
 +
 +	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++) {
 +		char path[100];
 +
 +		sprintf(path, "l%d", i);
 +		ASSERT_EQ(mkdirat(fd_tmpfs, path, 0755), 0);
 +		layer_fds[i] = openat(fd_tmpfs, path, O_DIRECTORY | O_PATH);
 +		ASSERT_GE(layer_fds[i], 0);
 +	}
 +
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
 +	fd_work = openat(fd_tmpfs, "w", O_DIRECTORY | O_PATH);
 +	ASSERT_GE(fd_work, 0);
 +
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
 +	fd_upper = openat(fd_tmpfs, "u", O_DIRECTORY | O_PATH);
 +	ASSERT_GE(fd_upper, 0);
 +
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "l501", 0755), 0);
 +	fd_lower = openat(fd_tmpfs, "l501", O_DIRECTORY | O_PATH);
 +	ASSERT_GE(fd_lower, 0);
 +
 +	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
 +	ASSERT_EQ(close(fd_tmpfs), 0);
 +
 +	fd_context = sys_fsopen("overlay", 0);
 +	ASSERT_GE(fd_context, 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, fd_work), 0);
 +	ASSERT_EQ(close(fd_work), 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, fd_upper), 0);
 +	ASSERT_EQ(close(fd_upper), 0);
 +
 +	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++) {
 +		ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[i]), 0);
 +		ASSERT_EQ(close(layer_fds[i]), 0);
 +	}
 +
 +	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower), 0);
 +	ASSERT_EQ(close(fd_lower), 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
 +
 +	fd_overlay = sys_fsmount(fd_context, 0, 0);
 +	ASSERT_GE(fd_overlay, 0);
 +	ASSERT_EQ(close(fd_context), 0);
 +	ASSERT_EQ(close(fd_overlay), 0);
 +}
 +
 +TEST_F(set_layers_via_fds, set_layers_via_detached_mount_fds)
 +{
 +	int fd_context, fd_tmpfs, fd_overlay, fd_tmp;
 +	int layer_fds[] = { [0 ... 8] = -EBADF };
 +	bool layers_found[] = { [0 ... 8] =  false };
 +	size_t len = 0;
 +	char *line = NULL;
 +	FILE *f_mountinfo;
 +
 +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
 +	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
 +
 +	fd_context = sys_fsopen("tmpfs", 0);
 +	ASSERT_GE(fd_context, 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
 +	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
 +	ASSERT_GE(fd_tmpfs, 0);
 +	ASSERT_EQ(close(fd_context), 0);
 +
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "u/upper", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "u/work", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "l3", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "l4", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "d1", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "d2", 0755), 0);
 +	ASSERT_EQ(mkdirat(fd_tmpfs, "d3", 0755), 0);
 +
 +	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/set_layers_via_fds_tmpfs", MOVE_MOUNT_F_EMPTY_PATH), 0);
 +
 +	fd_tmp = open_tree(fd_tmpfs, "u", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(fd_tmp, 0);
 +
 +	layer_fds[0] = openat(fd_tmp, "upper", O_CLOEXEC | O_DIRECTORY | O_PATH);
 +	ASSERT_GE(layer_fds[0], 0);
 +
 +	layer_fds[1] = openat(fd_tmp, "work", O_CLOEXEC | O_DIRECTORY | O_PATH);
 +	ASSERT_GE(layer_fds[1], 0);
 +
 +	layer_fds[2] = open_tree(fd_tmpfs, "l1", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[2], 0);
 +
 +	layer_fds[3] = open_tree(fd_tmpfs, "l2", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[3], 0);
 +
 +	layer_fds[4] = open_tree(fd_tmpfs, "l3", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[4], 0);
 +
 +	layer_fds[5] = open_tree(fd_tmpfs, "l4", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[5], 0);
 +
 +	layer_fds[6] = open_tree(fd_tmpfs, "d1", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[6], 0);
 +
 +	layer_fds[7] = open_tree(fd_tmpfs, "d2", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[7], 0);
 +
 +	layer_fds[8] = open_tree(fd_tmpfs, "d3", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
 +	ASSERT_GE(layer_fds[8], 0);
 +
 +	ASSERT_EQ(close(fd_tmpfs), 0);
 +
 +	fd_context = sys_fsopen("overlay", 0);
 +	ASSERT_GE(fd_context, 0);
 +
 +	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, layer_fds[0]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, layer_fds[1]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[4]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[5]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "datadir+",  NULL, layer_fds[6]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "datadir+",  NULL, layer_fds[7]), 0);
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "datadir+",  NULL, layer_fds[8]), 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy", "on", 0), 0);
 +
 +	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
 +
 +	fd_overlay = sys_fsmount(fd_context, 0, 0);
 +	ASSERT_GE(fd_overlay, 0);
 +
 +	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
 +
 +	f_mountinfo = fopen("/proc/self/mountinfo", "r");
 +	ASSERT_NE(f_mountinfo, NULL);
 +
 +	while (getline(&line, &len, f_mountinfo) != -1) {
 +		char *haystack = line;
 +
 +		if (strstr(haystack, "workdir=/tmp/w"))
 +			layers_found[0] = true;
 +		if (strstr(haystack, "upperdir=/tmp/u"))
 +			layers_found[1] = true;
 +		if (strstr(haystack, "lowerdir+=/tmp/l1"))
 +			layers_found[2] = true;
 +		if (strstr(haystack, "lowerdir+=/tmp/l2"))
 +			layers_found[3] = true;
 +		if (strstr(haystack, "lowerdir+=/tmp/l3"))
 +			layers_found[4] = true;
 +		if (strstr(haystack, "lowerdir+=/tmp/l4"))
 +			layers_found[5] = true;
 +		if (strstr(haystack, "datadir+=/tmp/d1"))
 +			layers_found[6] = true;
 +		if (strstr(haystack, "datadir+=/tmp/d2"))
 +			layers_found[7] = true;
 +		if (strstr(haystack, "datadir+=/tmp/d3"))
 +			layers_found[8] = true;
 +	}
 +	free(line);
 +
 +	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++) {
 +		ASSERT_EQ(layers_found[i], true);
 +		ASSERT_EQ(close(layer_fds[i]), 0);
 +	}
 +
 +	ASSERT_EQ(close(fd_context), 0);
 +	ASSERT_EQ(close(fd_overlay), 0);
 +	ASSERT_EQ(fclose(f_mountinfo), 0);
 +}
 +
+ TEST_F(set_layers_via_fds, set_override_creds)
+ {
+ 	int fd_context, fd_tmpfs, fd_overlay;
+ 	int layer_fds[] = { [0 ... 3] = -EBADF };
+ 	pid_t pid;
+ 	int pidfd;
+ 
+ 	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+ 	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+ 
+ 	fd_context = sys_fsopen("tmpfs", 0);
+ 	ASSERT_GE(fd_context, 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+ 	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+ 	ASSERT_GE(fd_tmpfs, 0);
+ 	ASSERT_EQ(close(fd_context), 0);
+ 
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
+ 
+ 	layer_fds[0] = openat(fd_tmpfs, "w", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[0], 0);
+ 
+ 	layer_fds[1] = openat(fd_tmpfs, "u", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[1], 0);
+ 
+ 	layer_fds[2] = openat(fd_tmpfs, "l1", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[2], 0);
+ 
+ 	layer_fds[3] = openat(fd_tmpfs, "l2", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[3], 0);
+ 
+ 	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+ 	ASSERT_EQ(close(fd_tmpfs), 0);
+ 
+ 	fd_context = sys_fsopen("overlay", 0);
+ 	ASSERT_GE(fd_context, 0);
+ 
+ 	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, layer_fds[0]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, layer_fds[1]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_STRING, "metacopy", "on", 0), 0);
+ 
+ 	pid = create_child(&pidfd, 0);
+ 	ASSERT_GE(pid, 0);
+ 	if (pid == 0) {
+ 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
+ 			TH_LOG("sys_fsconfig should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		_exit(EXIT_SUCCESS);
+ 	}
+ 	ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+ 	ASSERT_GE(close(pidfd), 0);
+ 
+ 	pid = create_child(&pidfd, 0);
+ 	ASSERT_GE(pid, 0);
+ 	if (pid == 0) {
+ 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "nooverride_creds", NULL, 0)) {
+ 			TH_LOG("sys_fsconfig should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		_exit(EXIT_SUCCESS);
+ 	}
+ 	ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+ 	ASSERT_GE(close(pidfd), 0);
+ 
+ 	pid = create_child(&pidfd, 0);
+ 	ASSERT_GE(pid, 0);
+ 	if (pid == 0) {
+ 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
+ 			TH_LOG("sys_fsconfig should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		_exit(EXIT_SUCCESS);
+ 	}
+ 	ASSERT_GE(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+ 	ASSERT_GE(close(pidfd), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+ 
+ 	fd_overlay = sys_fsmount(fd_context, 0, 0);
+ 	ASSERT_GE(fd_overlay, 0);
+ 
+ 	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
+ 
+ 	ASSERT_EQ(close(fd_context), 0);
+ 	ASSERT_EQ(close(fd_overlay), 0);
+ }
+ 
+ TEST_F(set_layers_via_fds, set_override_creds_invalid)
+ {
+ 	int fd_context, fd_tmpfs, fd_overlay, ret;
+ 	int layer_fds[] = { [0 ... 3] = -EBADF };
+ 	pid_t pid;
+ 	int fd_userns1, fd_userns2;
+ 	int ipc_sockets[2];
+ 	char c;
+ 	const unsigned int predictable_fd_context_nr = 123;
+ 
+ 	fd_userns1 = get_userns_fd(0, 0, 10000);
+ 	ASSERT_GE(fd_userns1, 0);
+ 
+ 	fd_userns2 = get_userns_fd(0, 1234, 10000);
+ 	ASSERT_GE(fd_userns2, 0);
+ 
+ 	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+ 	ASSERT_GE(ret, 0);
+ 
+ 	pid = create_child(&self->pidfd, 0);
+ 	ASSERT_GE(pid, 0);
+ 	if (pid == 0) {
+ 		if (close(ipc_sockets[0])) {
+ 			TH_LOG("close should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		if (!switch_userns(fd_userns2, 0, 0, false)) {
+ 			TH_LOG("switch_userns should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		if (read_nointr(ipc_sockets[1], &c, 1) != 1) {
+ 			TH_LOG("read_nointr should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		if (close(ipc_sockets[1])) {
+ 			TH_LOG("close should have succeeded");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		if (!sys_fsconfig(predictable_fd_context_nr, FSCONFIG_SET_FLAG, "override_creds", NULL, 0)) {
+ 			TH_LOG("sys_fsconfig should have failed");
+ 			_exit(EXIT_FAILURE);
+ 		}
+ 
+ 		_exit(EXIT_SUCCESS);
+ 	}
+ 
+ 	ASSERT_EQ(close(ipc_sockets[1]), 0);
+ 	ASSERT_EQ(switch_userns(fd_userns1, 0, 0, false), true);
+ 	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+ 	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+ 
+ 	fd_context = sys_fsopen("tmpfs", 0);
+ 	ASSERT_GE(fd_context, 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+ 	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+ 	ASSERT_GE(fd_tmpfs, 0);
+ 	ASSERT_EQ(close(fd_context), 0);
+ 
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
+ 
+ 	layer_fds[0] = openat(fd_tmpfs, "w", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[0], 0);
+ 
+ 	layer_fds[1] = openat(fd_tmpfs, "u", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[1], 0);
+ 
+ 	layer_fds[2] = openat(fd_tmpfs, "l1", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[2], 0);
+ 
+ 	layer_fds[3] = openat(fd_tmpfs, "l2", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[3], 0);
+ 
+ 	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+ 	ASSERT_EQ(close(fd_tmpfs), 0);
+ 
+ 	fd_context = sys_fsopen("overlay", 0);
+ 	ASSERT_GE(fd_context, 0);
+ 	ASSERT_EQ(dup3(fd_context, predictable_fd_context_nr, 0), predictable_fd_context_nr);
+ 	ASSERT_EQ(close(fd_context), 0);
+ 	fd_context = predictable_fd_context_nr;
+ 	ASSERT_EQ(write_nointr(ipc_sockets[0], "1", 1), 1);
+ 	ASSERT_EQ(close(ipc_sockets[0]), 0);
+ 
+ 	ASSERT_EQ(wait_for_pid(pid), 0);
+ 	ASSERT_EQ(close(self->pidfd), 0);
+ 	self->pidfd = -EBADF;
+ 
+ 	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, layer_fds[0]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, layer_fds[1]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
+ 
+ 	for (int i = 0; i < ARRAY_SIZE(layer_fds); i++)
+ 		ASSERT_EQ(close(layer_fds[i]), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "userxattr", NULL, 0), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+ 
+ 	fd_overlay = sys_fsmount(fd_context, 0, 0);
+ 	ASSERT_GE(fd_overlay, 0);
+ 
+ 	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
+ 
+ 	ASSERT_EQ(close(fd_context), 0);
+ 	ASSERT_EQ(close(fd_overlay), 0);
+ 	ASSERT_EQ(close(fd_userns1), 0);
+ 	ASSERT_EQ(close(fd_userns2), 0);
+ }
+ 
+ TEST_F(set_layers_via_fds, set_override_creds_nomknod)
+ {
+ 	int fd_context, fd_tmpfs, fd_overlay;
+ 	int layer_fds[] = { [0 ... 3] = -EBADF };
+ 	pid_t pid;
+ 	int pidfd;
+ 
+ 	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+ 	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
+ 
+ 	fd_context = sys_fsopen("tmpfs", 0);
+ 	ASSERT_GE(fd_context, 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+ 	fd_tmpfs = sys_fsmount(fd_context, 0, 0);
+ 	ASSERT_GE(fd_tmpfs, 0);
+ 	ASSERT_EQ(close(fd_context), 0);
+ 
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "w", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "u", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "l1", 0755), 0);
+ 	ASSERT_EQ(mkdirat(fd_tmpfs, "l2", 0755), 0);
+ 
+ 	layer_fds[0] = openat(fd_tmpfs, "w", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[0], 0);
+ 
+ 	layer_fds[1] = openat(fd_tmpfs, "u", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[1], 0);
+ 
+ 	layer_fds[2] = openat(fd_tmpfs, "l1", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[2], 0);
+ 
+ 	layer_fds[3] = openat(fd_tmpfs, "l2", O_DIRECTORY);
+ 	ASSERT_GE(layer_fds[3], 0);
+ 
+ 	ASSERT_EQ(sys_move_mount(fd_tmpfs, "", -EBADF, "/tmp", MOVE_MOUNT_F_EMPTY_PATH), 0);
+ 	ASSERT_EQ(close(fd_tmpfs), 0);
+ 
+ 	fd_context = sys_fsopen("overlay", 0);
+ 	ASSERT_GE(fd_context, 0);
+ 
+ 	ASSERT_NE(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir", NULL, layer_fds[2]), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "workdir",   NULL, layer_fds[0]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir",  NULL, layer_fds[1]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]), 0);
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "userxattr", NULL, 0), 0);
+ 
+ 	pid = create_child(&pidfd, 0);
+ 	ASSERT_GE(pid, 0);
+ 	if (pid == 0) {
+ 		if (!cap_down(CAP_MKNOD))
+ 			_exit(EXIT_FAILURE);
+ 
+ 		if (!cap_down(CAP_SYS_ADMIN))
+ 			_exit(EXIT_FAILURE);
+ 
+ 		if (sys_fsconfig(fd_context, FSCONFIG_SET_FLAG, "override_creds", NULL, 0))
+ 			_exit(EXIT_FAILURE);
+ 
+ 		_exit(EXIT_SUCCESS);
+ 	}
+ 	ASSERT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+ 	ASSERT_GE(close(pidfd), 0);
+ 
+ 	ASSERT_EQ(sys_fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0), 0);
+ 
+ 	fd_overlay = sys_fsmount(fd_context, 0, 0);
+ 	ASSERT_GE(fd_overlay, 0);
+ 
+ 	ASSERT_EQ(sys_move_mount(fd_overlay, "", -EBADF, "/set_layers_via_fds", MOVE_MOUNT_F_EMPTY_PATH), 0);
+ 	ASSERT_EQ(mknodat(fd_overlay, "dev-zero", S_IFCHR | 0644, makedev(1, 5)), -1);
+ 	ASSERT_EQ(errno, EPERM);
+ 
+ 	ASSERT_EQ(close(fd_context), 0);
+ 	ASSERT_EQ(close(fd_overlay), 0);
+ }
+ 
  TEST_HARNESS_MAIN

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.overlayfs

for you to fetch changes up to 9c27e5cc39bb7848051c42500207aa3a7f63558c:

  Merge patch series "ovl: add override_creds mount option" (2025-02-19 14:32:12 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.overlayfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.overlayfs

----------------------------------------------------------------
Christian Brauner (6):
      ovl: allow to specify override credentials
      selftests/ovl: add first selftest for "override_creds"
      selftests/filesystems: add utils.{c,h}
      selftests/ovl: add second selftest for "override_creds"
      selftests/ovl: add third selftest for "override_creds"
      Merge patch series "ovl: add override_creds mount option"

 Documentation/filesystems/overlayfs.rst            |  24 +-
 fs/overlayfs/params.c                              |  25 +
 fs/overlayfs/super.c                               |  16 +-
 .../selftests/filesystems/overlayfs/Makefile       |  11 +-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 312 ++++++++++++-
 tools/testing/selftests/filesystems/utils.c        | 501 +++++++++++++++++++++
 tools/testing/selftests/filesystems/utils.h        |  45 ++
 7 files changed, 924 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/utils.c
 create mode 100644 tools/testing/selftests/filesystems/utils.h

