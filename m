Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D31421ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 04:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgATDXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 22:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDXH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:23:07 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119BF2073A;
        Mon, 20 Jan 2020 03:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579490586;
        bh=K7xZMmjWVKCT25PyjZdyGvQdXmOSlwcrsLU8kIcTW70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQfbeMNtQSCiuows61nUsvrS3a5EztfhYbHVK+L3clubDXRJTeiPMGRaiAZxlI8a1
         BR/stCU+1lL3Rgxzjb2c9GevFOheshReJkxlO5HCBda7XQl9BxwoSMOhP2danWU2tY
         WVRDUGxrjORfUaR/ZmAlGsbY7noIwoZBa/0BL4E0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bootconfig: Fix Kconfig help message for BOOT_CONFIG
Date:   Mon, 20 Jan 2020 12:23:00 +0900
Message-Id: <157949058031.25888.18399447161895787505.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157949056842.25888.12912764773767908046.stgit@devnote2>
References: <157949056842.25888.12912764773767908046.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix Kconfig help message since the bootconfig file is
only available to be appended to initramfs. And also
add a reference to the documentation.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index ffd240fb88c3..9506299a53e3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1223,7 +1223,9 @@ config BOOT_CONFIG
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
-	  The boot config file is usually attached at the end of initramfs.
+	  The boot config file must be attached at the end of initramfs
+	  with checksum and size.
+	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
 
 	  If unsure, say Y.
 

