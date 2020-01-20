Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAF1421EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 04:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgATDXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 22:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDXT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:23:19 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842F02073D;
        Mon, 20 Jan 2020 03:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579490598;
        bh=MKn5Cznp3PMqaBXd9TGds8qNk4W8AABAuCaIwfqDjj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKLD7kVDum2dkbQys+xNuSdNm1AXY+9DeSYpNJ45uC17+iM4s0Y8v4CLCQl2c1iJN
         bIIBvSXLaN6QDVSmpVM65TiYZqSBc5H33knX6AVTlKDhT10HK2nBUPJLknAkr+b2lN
         3v0uzeVuh9F/pmwJjskxpmvQsvSUt7XuszldYTqY=
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
Subject: [PATCH 2/3] Documentation: bootconfig: Fix typos in bootconfig documentation
Date:   Mon, 20 Jan 2020 12:23:12 +0900
Message-Id: <157949059219.25888.16939971423610233631.stgit@devnote2>
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

Fix typos in bootconfig.rst according to Randy's suggestions.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |   32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index c8f7cd4cf44e..4d617693c0c8 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -11,20 +11,22 @@ Boot Configuration
 Overview
 ========
 
-The boot configuration is expanding current kernel cmdline to support
-additional key-value data when boot the kernel in an efficient way.
-This allows adoministrators to pass a structured-Key config file.
+The boot configuration expands the current kernel command line to support
+additional key-value data when booting the kernel in an efficient way.
+This allows administrators to pass a structured-Key config file.
 
 Config File Syntax
 ==================
 
 The boot config syntax is a simple structured key-value. Each key consists
-of dot-connected-words, and key and value are connected by "=". The value
+of dot-connected-words, and key and value are connected by ``=``. The value
 has to be terminated by semi-colon (``;``) or newline (``\n``).
 For array value, array entries are separated by comma (``,``). ::
 
 KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
 
+Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
+
 Each key word must contain only alphabets, numbers, dash (``-``) or underscore
 (``_``). And each value only contains printable characters or spaces except
 for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
@@ -35,7 +37,7 @@ quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
 you can not escape these quotes.
 
 There can be a key which doesn't have value or has an empty value. Those keys
-are used for checking the key exists or not (like a boolean).
+are used for checking if the key exists or not (like a boolean).
 
 Key-Value Syntax
 ----------------
@@ -63,7 +65,7 @@ at boot time. So you can append similar trees or key-values.
 Comments
 --------
 
-The config syntax accepts shell-script style comments. The comments start
+The config syntax accepts shell-script style comments. The comments starting
 with hash ("#") until newline ("\n") will be ignored.
 
 ::
@@ -108,7 +110,7 @@ update the boot loader and the kernel image itself.
 
 To do this operation, Linux kernel provides "bootconfig" command under
 tools/bootconfig, which allows admin to apply or delete the config file
-to/from initrd image. You can build it by follwoing command::
+to/from initrd image. You can build it by the following command::
 
  # make -C tools/bootconfig
 
@@ -122,7 +124,7 @@ To remove the config from the image, you can use -d option as below::
  # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
 
 
-C onfig File Limitation
+Config File Limitation
 ======================
 
 Currently the maximum config size size is 32KB and the total key-words (not
@@ -145,10 +147,10 @@ User can query or loop on key-value pairs, also it is possible to find
 a root (prefix) key node and find key-values under that node.
 
 If you have a key string, you can query the value directly with the key
-using xbc_find_value(). If you want to know what keys exist in the SKC
-tree, you can use xbc_for_each_key_value() to iterate key-value pairs.
+using xbc_find_value(). If you want to know what keys exist in the boot
+config, you can use xbc_for_each_key_value() to iterate key-value pairs.
 Note that you need to use xbc_array_for_each_value() for accessing
-each arraies value, e.g.::
+each array's value, e.g.::
 
  vnode = NULL;
  xbc_find_value("key.word", &vnode);
@@ -157,8 +159,8 @@ each arraies value, e.g.::
       printk("%s ", value);
     }
 
-If you want to focus on keys which has a prefix string, you can use
-xbc_find_node() to find a node which prefix key words, and iterate
+If you want to focus on keys which have a prefix string, you can use
+xbc_find_node() to find a node by the prefix string, and iterate
 keys under the prefix node with xbc_node_for_each_key_value().
 
 But the most typical usage is to get the named value under prefix
@@ -174,8 +176,8 @@ or get the named array under prefix as below::
 This accesses a value of "key.prefix.option" and an array of
 "key.prefix.array-option".
 
-Locking is not needed, since after initialized, the config becomes readonly.
-All data and keys must be copied if you need to modify it.
+Locking is not needed, since after initialization, the config becomes
+read-only. All data and keys must be copied if you need to modify it.
 
 
 Functions and structures

