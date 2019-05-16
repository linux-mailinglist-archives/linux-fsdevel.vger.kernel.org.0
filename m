Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921772065E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfEPLwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfEPLwa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96B90821C1;
        Thu, 16 May 2019 11:52:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22FBA5D97C;
        Thu, 16 May 2019 11:52:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/4] uapi,
 x86: Fix the syscall numbering of the mount API syscalls [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@arndb.de>,
        dhowells@redhat.com, christian@brauner.io, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 12:52:27 +0100
Message-ID: <155800754738.4037.11950529125416851948.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 16 May 2019 11:52:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the syscall numbering of the mount API syscalls so that the numbers
match between i386 and x86_64 and that they're in the common numbering
scheme space.

Fixes: a07b20004793 ("vfs: syscall: Add open_tree(2) to reference or clone a mount")
Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
Fixes: 24dcb3d90a1f ("vfs: syscall: Add fsopen() to prepare for superblock creation")
Fixes: ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
Fixes: 93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
Fixes: cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---

 arch/x86/entry/syscalls/syscall_32.tbl |   12 ++++++------
 arch/x86/entry/syscalls/syscall_64.tbl |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..ad968b7bac72 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,12 +398,6 @@
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
-387	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
-388	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
-389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
-390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
-391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
-392	i386	fspick			sys_fspick			__ia32_sys_fspick
 393	i386	semget			sys_semget    			__ia32_sys_semget
 394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
 395	i386	shmget			sys_shmget    			__ia32_sys_shmget
@@ -438,3 +432,9 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
+429	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
+430	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
+431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
+432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
+433	i386	fspick			sys_fspick			__ia32_sys_fspick
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..b4e6f9e6204a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,18 +343,18 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
-335	common	open_tree		__x64_sys_open_tree
-336	common	move_mount		__x64_sys_move_mount
-337	common	fsopen			__x64_sys_fsopen
-338	common	fsconfig		__x64_sys_fsconfig
-339	common	fsmount			__x64_sys_fsmount
-340	common	fspick			__x64_sys_fspick
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	open_tree		__x64_sys_open_tree
+429	common	move_mount		__x64_sys_move_mount
+430	common	fsopen			__x64_sys_fsopen
+431	common	fsconfig		__x64_sys_fsconfig
+432	common	fsmount			__x64_sys_fsmount
+433	common	fspick			__x64_sys_fspick
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact

