Return-Path: <linux-fsdevel+bounces-48335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F60EAADA62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81FF7A9390
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0659212F89;
	Wed,  7 May 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMjLXWUD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B61D5CE0;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607367; cv=none; b=KMO7ekHToe7LPB1D7vJMfLC/1RtCEZC2FMYKi8CB64ErUxcalaLPpUKfdDuOy2K6qASE8vvRzqWzI/tMSMJCHd7FtRN5EtLkLY0bGLtcqMtxjpTCjkZytyJbw1Cp4j45W9cau/SFrKiRBIr7h0l8ISK9QWsDpIVpAMcJk2Lud9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607367; c=relaxed/simple;
	bh=sMfc2MEmWe+OTy+/A8y1VlQc15fzCnGHPGGJoYi/UC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDKEU3ei3IdwKzRm2/p1fmsVU8kDAmfuQgxuw/obR9JahdK8nHdkTpvam9hcWwWgDjVrocZDJKA2gnun1mknMzcWmV7ncfku3uUFmZ6UPNxJWwoBygP9LArq987bwx/2rzML3nzj/7DdXLtYbojByAGwuxeIHaV5xpzgrPQo8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMjLXWUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBFB0C4CEEB;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746607366;
	bh=sMfc2MEmWe+OTy+/A8y1VlQc15fzCnGHPGGJoYi/UC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qMjLXWUDk42yOu/j69x1u+/yUuZZYG4i5mgeP2D5+zyvWtYhufdQUBYFGJzKl7DN7
	 zoQ2kmOCCweJw+PbzpSUNJK4+reLkotu1gVKZdqq7JAFaSph4zS/UXirRHv5oDhD8g
	 fjrJ61kg+gPVO1+HkgABNpBib/RIfxgGY82uwa2IhxKqfGsmG1FDY2YPetOz3YauYv
	 vG72fXhJL2srxke4RffHIz4t1UulbJDy9oxEQ6JKVOBpy7FQpVa/n3Q/tmgoC3UaD8
	 bhzcF2lTkxKB7djZ4kQdbwjvpxaiFD1mnATa4POAs2u9B24KmkK3law/oR+XNHANrI
	 mYnQeOK8LjacA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF819C3ABC9;
	Wed,  7 May 2025 08:42:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 07 May 2025 16:42:17 +0800
Subject: [PATCH v2 2/2] docs: filesystems: add fuse-passthrough.rst
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-fuse-passthrough-doc-v2-2-ae7c0dd8bba6@uniontech.com>
References: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Bernd Schubert <bernd.schubert@fastmail.fm>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8328;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=S1S/zXu1TEYabzgcjMgPUBwM81VJ+LsPv62zpTlym7Q=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoGx0E+Cu2teiatZ0ivGwbqh+nbaftpODrq0cz3
 H99DlmhVISJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBsdBAAKCRB2HuYUOZmu
 i9t/EAD5pgLS4hShoS0Aen0M3UnbeV1Wppnn8I1jVHRUppPLeZZovXnMEIOzGj712Aq/kNEy9mn
 al8q5mmEhhTE9KvQeUzqlTlLHcVc1SO9CaLhSsHgi5Y009GhQptLfM/pHQI9ZyMbWtOqKGVMx7K
 WgZ9wIQ4SAqVMyQgJ1q2P0rtknkv+5hPR92RaBqGaHqK5ilNBeg3GKY53JWCMXyqoGJjcE0FlO9
 8n+Ltu114UliLAtE+8hHAXV3daAKJ7Hqh/OfBpOUKD+w4VNuOGdpSL6LQcCLo/Y2dFG4DEMbAse
 H49n8qmIZEH0hF8JF2FMStfdbAqf8rcGZAyGfQ7ffR9Zz7TnH8adlALCqASUB0M4m75TmzgruLn
 yJRQRecjN3Hdf2Z7TCCXnMizK2vHzkmRM+9NT4caFLx66F/jj8uu4j9Q19K/E0LkbFJwstATFGD
 kH3uE7ZxVzxP1B04nIgGGGvwOOB7V9qkDmrNSeKHtfiYQpAlKjBEnwVS8izwD+ex3Udx/k4g6zJ
 /lq2W0MR6FJC/eUHE0g2Uufq03k02O7qV8v2nDPwIpW71J7wsI1NRyKP7ELSJQFvNSakBArkLjn
 fqKnciCdqAXNMaetF6l7Q4DghknzPDfcGGBCP4ZXzcwiTsgv/xtaHA49eUMxLLdsRC9qqP8gQz0
 REI/+GCtR31cSjQ==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

From: Chen Linxuan <chenlinxuan@uniontech.com>

Add a documentation about FUSE passthrough.

It's mainly about why FUSE passthrough needs CAP_SYS_ADMIN.

Some related discussions:

Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Documentation/filesystems/fuse-passthrough.rst | 133 +++++++++++++++++++++++++
 Documentation/filesystems/index.rst            |   1 +
 2 files changed, 134 insertions(+)

diff --git a/Documentation/filesystems/fuse-passthrough.rst b/Documentation/filesystems/fuse-passthrough.rst
new file mode 100644
index 0000000000000000000000000000000000000000..2b0e7c2da54acde4d48fd91ecece27256c4e04fd
--- /dev/null
+++ b/Documentation/filesystems/fuse-passthrough.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+FUSE Passthrough
+================
+
+Introduction
+============
+
+FUSE (Filesystem in Userspace) passthrough is a feature designed to improve the
+performance of FUSE filesystems for I/O operations. Typically, FUSE operations
+involve communication between the kernel and a userspace FUSE daemon, which can
+incur overhead. Passthrough allows certain operations on a FUSE file to bypass
+the userspace daemon and be executed directly by the kernel on an underlying
+"backing file".
+
+This is achieved by the FUSE daemon registering a file descriptor (pointing to
+the backing file on a lower filesystem) with the FUSE kernel module. The kernel
+then receives an identifier (``backing_id``) for this registered backing file.
+When a FUSE file is subsequently opened, the FUSE daemon can, in its response to
+the ``OPEN`` request, include this ``backing_id`` and set the
+``FOPEN_PASSTHROUGH`` flag. This establishes a direct link for specific
+operations.
+
+Currently, passthrough is supported for operations like ``read(2)``/``write(2)``
+(via ``read_iter``/``write_iter``), ``splice(2)``, and ``mmap(2)``.
+
+Enabling Passthrough
+====================
+
+To use FUSE passthrough:
+
+  1. The FUSE filesystem must be compiled with ``CONFIG_FUSE_PASSTHROUGH``
+     enabled.
+  2. The FUSE daemon, during the ``FUSE_INIT`` handshake, must negotiate the
+     ``FUSE_PASSTHROUGH`` capability and specify its desired
+     ``max_stack_depth``.
+  3. The (privileged) FUSE daemon uses the ``FUSE_DEV_IOC_BACKING_OPEN`` ioctl
+     on its connection file descriptor (e.g., ``/dev/fuse``) to register a
+     backing file descriptor and obtain a ``backing_id``.
+  4. When handling an ``OPEN`` or ``CREATE`` request for a FUSE file, the daemon
+     replies with the ``FOPEN_PASSTHROUGH`` flag set in
+     ``fuse_open_out::open_flags`` and provides the corresponding ``backing_id``
+     in ``fuse_open_out::backing_id``.
+  5. The FUSE daemon should eventually call ``FUSE_DEV_IOC_BACKING_CLOSE`` with
+     the ``backing_id`` to release the kernel's reference to the backing file
+     when it's no longer needed for passthrough setups.
+
+Privilege Requirements
+======================
+
+Setting up passthrough functionality currently requires the FUSE daemon to
+possess the ``CAP_SYS_ADMIN`` capability. This requirement stems from several
+security and resource management considerations that are actively being
+discussed and worked on. The primary reasons for this restriction are detailed
+below.
+
+Resource Accounting and Visibility
+----------------------------------
+
+The core mechanism for passthrough involves the FUSE daemon opening a file
+descriptor to a backing file and registering it with the FUSE kernel module via
+the ``FUSE_DEV_IOC_BACKING_OPEN`` ioctl. This ioctl returns a ``backing_id``
+associated with a kernel-internal ``struct fuse_backing`` object, which holds a
+reference to the backing ``struct file``.
+
+A significant concern arises because the FUSE daemon can close its own file
+descriptor to the backing file after registration. The kernel, however, will
+still hold a reference to the ``struct file`` via the ``struct fuse_backing``
+object as long as it's associated with a ``backing_id`` (or subsequently, with
+an open FUSE file in passthrough mode).
+
+This behavior leads to two main issues for unprivileged FUSE daemons:
+
+  1. **Invisibility to lsof and other inspection tools**: Once the FUSE
+     daemon closes its file descriptor, the open backing file held by the kernel
+     becomes "hidden." Standard tools like ``lsof``, which typically inspect
+     process file descriptor tables, would not be able to identify that this
+     file is still open by the system on behalf of the FUSE filesystem. This
+     makes it difficult for system administrators to track resource usage or
+     debug issues related to open files (e.g., preventing unmounts).
+
+  2. **Bypassing RLIMIT_NOFILE**: The FUSE daemon process is subject to
+     resource limits, including the maximum number of open file descriptors
+     (``RLIMIT_NOFILE``). If an unprivileged daemon could register backing files
+     and then close its own FDs, it could potentially cause the kernel to hold
+     an unlimited number of open ``struct file`` references without these being
+     accounted against the daemon's ``RLIMIT_NOFILE``. This could lead to a
+     denial-of-service (DoS) by exhausting system-wide file resources.
+
+The ``CAP_SYS_ADMIN`` requirement acts as a safeguard against these issues,
+restricting this powerful capability to trusted processes.
+
+**NOTE**: ``io_uring`` solves this similar issue by exposing its "fixed files",
+which are visible via ``fdinfo`` and accounted under the registering user's
+``RLIMIT_NOFILE``.
+
+Filesystem Stacking and Shutdown Loops
+--------------------------------------
+
+Another concern relates to the potential for creating complex and problematic
+filesystem stacking scenarios if unprivileged users could set up passthrough.
+A FUSE passthrough filesystem might use a backing file that resides:
+
+  * On the *same* FUSE filesystem.
+  * On another filesystem (like OverlayFS) which itself might have an upper or
+    lower layer that is a FUSE filesystem.
+
+These configurations could create dependency loops, particularly during
+filesystem shutdown or unmount sequences, leading to deadlocks or system
+instability. This is conceptually similar to the risks associated with the
+``LOOP_SET_FD`` ioctl, which also requires ``CAP_SYS_ADMIN``.
+
+To mitigate this, FUSE passthrough already incorporates checks based on
+filesystem stacking depth (``sb->s_stack_depth`` and ``fc->max_stack_depth``).
+For example, during the ``FUSE_INIT`` handshake, the FUSE daemon can negotiate
+the ``max_stack_depth`` it supports. When a backing file is registered via
+``FUSE_DEV_IOC_BACKING_OPEN``, the kernel checks if the backing file's
+filesystem stack depth is within the allowed limit.
+
+The ``CAP_SYS_ADMIN`` requirement provides an additional layer of security,
+ensuring that only privileged users can create these potentially complex
+stacking arrangements.
+
+General Security Posture
+------------------------
+
+As a general principle for new kernel features that allow userspace to instruct
+the kernel to perform direct operations on its behalf based on user-provided
+file descriptors, starting with a higher privilege requirement (like
+``CAP_SYS_ADMIN``) is a conservative and common security practice. This allows
+the feature to be used and tested while further security implications are
+evaluated and addressed.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index a9cf8e950b15ad68a021d5f214b07f58d752f4e3..2913f4f2e00ccc466563aba5692e2f95699cb674 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -99,6 +99,7 @@ Documentation for filesystem implementations.
    fuse
    fuse-io
    fuse-io-uring
+   fuse-passthrough
    inotify
    isofs
    nilfs2

-- 
2.43.0



