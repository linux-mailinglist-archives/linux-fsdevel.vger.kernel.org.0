Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E641048E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 04:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKUDS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 22:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUDSz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:18:55 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDDA20721;
        Thu, 21 Nov 2019 03:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306335;
        bh=9H2OF06r0z9vuOQPos4thK3Jm060C1E9j+rNO8kjxq8=;
        h=From:To:Cc:Subject:Date:From;
        b=xO/lSD7umPYQXXuA+UM2wrEcjh6DDQvk1VEFM1pOYc6haFTNaMK8JboxifYKnrK9H
         cGHZ+QCLhOaCtJJON2poYJje3WJyebxlOYW8Opitpfi96pfwEVuIDizfjk8dmzbDqH
         t2gM+3c0M5o4Z9MZ07T488l2pjPh8iSJZkphJ/EY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:18:51 +0100
Message-Id: <1574306331-28973-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 fs/Kconfig        | 6 +++---
 fs/Kconfig.binfmt | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..59ad80f92446 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -7,7 +7,7 @@ menu "File systems"
 
 # Use unaligned word dcache accesses
 config DCACHE_WORD_ACCESS
-       bool
+	bool
 
 config VALIDATE_FS_PARSER
 	bool "Validate filesystem parameter description"
@@ -97,8 +97,8 @@ config FILE_LOCKING
 	default y
 	help
 	  This option enables standard file locking support, required
-          for filesystems like NFS and for the flock() system
-          call. Disabling this option saves about 11k.
+	  for filesystems like NFS and for the flock() system
+	  call. Disabling this option saves about 11k.
 
 config MANDATORY_FILE_LOCKING
 	bool "Enable Mandatory file locking"
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..72c5daeb257d 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -127,7 +127,7 @@ config BINFMT_SHARED_FLAT
 	  Support FLAT shared libraries
 
 config HAVE_AOUT
-       def_bool n
+	def_bool n
 
 config BINFMT_AOUT
 	tristate "Kernel support for a.out and ECOFF binaries"
@@ -191,9 +191,9 @@ config BINFMT_MISC
 	  <file:Documentation/admin-guide/binfmt-misc.rst> to learn how to use this
 	  feature, <file:Documentation/admin-guide/java.rst> for information about how
 	  to include Java support. and <file:Documentation/admin-guide/mono.rst> for
-          information about how to include Mono-based .NET support.
+	  information about how to include Mono-based .NET support.
 
-          To use binfmt_misc, you will need to mount it:
+	  To use binfmt_misc, you will need to mount it:
 		mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
 
 	  You may say M here for module support and later load the module when
-- 
2.7.4

