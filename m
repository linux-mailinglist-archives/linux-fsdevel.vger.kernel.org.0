Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31922B3D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGWQnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 12:43:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWQnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:43:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 48DA7283BFE
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com
Cc:     kernel@collabora.com, linux-fsdevel@vger.kernel.org,
        nikolaus@rath.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] fuse: Update project homepage
Date:   Thu, 23 Jul 2020 13:43:11 -0300
Message-Id: <20200723164311.29169-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As stated in https://sourceforge.net/projects/fuse/, "the FUSE project has
moved to https://github.com/libfuse/" in 22-Dec-2015. Update URLs to
reflect this.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/filesystems/fuse.rst | 2 +-
 MAINTAINERS                        | 2 +-
 fs/fuse/Kconfig                    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
index cd717f9bf940..8120c3c0cb4e 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -47,7 +47,7 @@ filesystems.  A good example is sshfs: a secure network filesystem
 using the sftp protocol.
 
 The userspace library and utilities are available from the
-`FUSE homepage: <http://fuse.sourceforge.net/>`_
+`FUSE homepage: <https://github.com/libfuse/>`_
 
 Filesystem type
 ===============
diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..068c463bb18f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7086,7 +7086,7 @@ FUSE: FILESYSTEM IN USERSPACE
 M:	Miklos Szeredi <miklos@szeredi.hu>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-W:	http://fuse.sourceforge.net/
+W:	https://github.com/libfuse/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 F:	Documentation/filesystems/fuse.rst
 F:	fs/fuse/
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 774b2618018a..0156dc8aa646 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -8,7 +8,7 @@ config FUSE_FS
 
 	  There's also a companion library: libfuse2.  This library is available
 	  from the FUSE homepage:
-	  <http://fuse.sourceforge.net/>
+	  <https://github.com/libfuse/>
 	  although chances are your distribution already has that library
 	  installed if you've installed the "fuse" package itself.
 
-- 
2.27.0

