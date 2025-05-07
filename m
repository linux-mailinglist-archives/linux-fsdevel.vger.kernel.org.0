Return-Path: <linux-fsdevel+bounces-48325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1975AAD514
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7F6189E4FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7551FDE02;
	Wed,  7 May 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQUu8fj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C51F4629;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595038; cv=none; b=O8gDwS5aK0sO1RxvUWaCAlOphMEPYosNR1NJML8TaXEMPrPMAWbgPM6bpp8WeFznziJ4vm7KZoAqxKe34WfaAK/zV6lQ1zk/LKU2meEUMlq9xcvIXg5+Ht76q5CpJQUlXiK6aw5nRo8vcmr55m/C1jjiopuzYrDUR8++ARg+OD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595038; c=relaxed/simple;
	bh=PdZyjzHGc/k8znJaJoDuI0ptJr6G6zL0QZPUy0jj/O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjIbP0zH/8dqHDJkDmByjLRXIzGA0eh/veGNwazcfSLEu2QQJoKDpu9ygwJQkJthfvac/VP18EzPkbEWe5du2kaOm2ITww7/YbewsqlcWUfvEpiyqy6fpBj0u8ZgJMFhrONJIWzNbmVrKZCQCSkdIjXMHlR1AKsqDvx0ROjsanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQUu8fj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F103C4CEEF;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746595037;
	bh=PdZyjzHGc/k8znJaJoDuI0ptJr6G6zL0QZPUy0jj/O0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PQUu8fj/CxrRZlSZ1o/c7MTa7mk1jSC7MVaXD7PzeBi7fJENhgfAXyz7k0jlKUhBC
	 Y8JwhbnMzfJSVmMV5HIaOkuMCxXewDYPcTIQBXuwmvASiS4T0/eHWaPWK9mdhzCWRJ
	 tT0TsyM8MGtNUW/NVwZwS9hauRMynZSHWZTIlN/3bMgQliFdfdDAWfD0V1bbrxryKb
	 /eVRSnug3YPqKLBIzMDUpCf4lxuP2y5Em8zhjMZijGNELYKeZED7/YEJQP3a7pSZeH
	 Zitkjkb5XJ2BsUgzHORrp3K/1u6Mwsprmv+UNztv9GYov2DNG2wSqQdbTkZZDoxB/Y
	 gdS47SktR8u6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A5AC3ABC0;
	Wed,  7 May 2025 05:17:17 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Date: Wed, 07 May 2025 13:16:42 +0800
Subject: [PATCH 2/2] docs: filesystems: add fuse-passthrough.rst
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-fuse-passthrough-doc-v1-2-cc06af79c722@uniontech.com>
References: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v1-0-cc06af79c722@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Bernd Schubert <bernd.schubert@fastmail.fm>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7979;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=Q99iNM7uiYR5brGKTUprcxMDvkBIBBO8n5B+ovq6PUU=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoGuzaBt/X7l1SdFXurzyC8VmMRUtniNh+DFJcy
 yhgGgWelDSJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBrs2gAKCRB2HuYUOZmu
 iy2HD/0QHucwDMRke0GnVoonqiIXC7Au0b99qe2mFbKVhOSViY13dJ7k+4gy+494bk+NBL+y5Sg
 fDSP0N2DAK9ivzsM1Evz+LpYbFxrrhY0lEEp7HosOEgO0dMyep7ORb8GaPKSdOOvtlh9cYcAM5+
 K6P/zC+GC/pHrPyW9e7j0Zif2PvEttkI9Pf38X4XhUnBYhyM6cd+Kqlb1I+G3PZgDNeJYzm7Swh
 aTBA4Cm39NU+JQ7mQ15mZFtL0M3gnYfGfIW5HHUfGRsKdc2b+Q5gsfLLE0e7g3LOzodjCNlLvdz
 zRpwcFjFZuAuQPFmovnj9lX4nSBO4t4tKbTv8mkACEbuD0gi4lwNmxM4PnPhGJI4if5w2fUza0f
 G2sMw5Q9KHtgkgoVryoOWgQ+tZn3bPMFLjwkdVwKl/Et2eGj82R60g96BiqrVEgtHF8mQV0tcKW
 6bLDaXHmXDfb3iP0xijNHggXMK3seYturO8Qg81S/wJ6AOQ+3reRmi3D2jCDxpIliCayhslIVqu
 IWHNKLtAm8Qtq8uYqK3+JftCuqcJ9wZd9foOGBaJnF+uLnCNA/vjUrN1KHtC/xQ4G+BDr+8HE6h
 iqM2CIS1mQziWh8rHIyQTTuuBA3sSFakLeFVXBSCwtb0v3xglvnJLo3EqFwjv2RxsppSXovd2hl
 l/xnODBDmUkKKlg==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

From: Chen Linxuan <chenlinxuan@uniontech.com>

Add a documentation about FUSE passthrough.

It's mainly about why FUSE passthrough needs CAP_SYS_ADMIN.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 Documentation/filesystems/fuse-passthrough.rst | 139 +++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/Documentation/filesystems/fuse-passthrough.rst b/Documentation/filesystems/fuse-passthrough.rst
new file mode 100644
index 0000000000000000000000000000000000000000..f7c3b3ac08c255906ed7c909229107ff15cdb223
--- /dev/null
+++ b/Documentation/filesystems/fuse-passthrough.rst
@@ -0,0 +1,139 @@
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
+introduce overhead. Passthrough allows certain operations on a FUSE file to
+bypass the userspace daemon and be executed directly by the kernel on an
+underlying "backing file".
+
+This is achieved by the FUSE daemon registering a file descriptor (pointing to
+the backing file on a lower filesystem) with the FUSE kernel module. The kernel
+then receives an identifier (`backing_id`) for this registered backing file.
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
+restricting this powerful capability to trusted processes. As noted in the
+kernel code (``fs/fuse/passthrough.c`` in ``fuse_backing_open()``):
+
+Discussions suggest that exposing information about these backing files, perhaps
+through a dedicated interface under ``/sys/fs/fuse/connections/``, could be a
+step towards relaxing this capability. This would be analogous to how
+``io_uring`` exposes its "fixed files", which are also visible via ``fdinfo``
+and accounted under the registering user's ``RLIMIT_NOFILE``.
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
+evaluated and addressed. As Amir Goldstein mentioned in one of the discussions,
+there was "no proof that this is the only potential security risk" when the
+initial privilege checks were put in place.
+

-- 
2.43.0



