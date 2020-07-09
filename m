Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C221A78B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGITIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 15:08:14 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:51798 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgGITIO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:08:14 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 768BCBC06F;
        Thu,  9 Jul 2020 19:08:11 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] FILESYSTEMS (VFS and infrastructure): Replace HTTP links with HTTPS ones
Date:   Thu,  9 Jul 2020 21:08:05 +0200
Message-Id: <20200709190805.25095-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 fs/Kconfig.binfmt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 885da6d983b4..ab548f38c0dd 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -20,7 +20,7 @@ config BINFMT_ELF
 	  want to say Y here.
 
 	  Information about ELF is contained in the ELF HOWTO available from
-	  <http://www.tldp.org/docs.html#howto>.
+	  <https://www.tldp.org/docs.html#howto>.
 
 	  If you find that after upgrading from Linux kernel 1.2 and saying Y
 	  here, you still can't run any ELF binaries (they just crash), then
@@ -188,7 +188,7 @@ config BINFMT_MISC
 	  programs that need an interpreter to run like Java, Python, .NET or
 	  Emacs-Lisp. It's also useful if you often run DOS executables under
 	  the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>). Once you have
+	  <https://www.tldp.org/docs.html#howto>). Once you have
 	  registered such a binary class with the kernel, you can start one of
 	  those programs simply by typing in its name at a shell prompt; Linux
 	  will automatically feed it to the correct interpreter.
-- 
2.27.0

