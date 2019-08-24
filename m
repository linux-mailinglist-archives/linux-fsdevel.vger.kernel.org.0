Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5059BA8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 03:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfHXBfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 21:35:45 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48388 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfHXBfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 21:35:17 -0400
Received: by mail-ua1-f74.google.com with SMTP id z21so838470uaq.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 18:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Yu24t+GKmNGWTShqeL1NHYrjL7wCiR6v+VbVrto/ls=;
        b=FtZv6CWAk9uIcK5EihKkvgzRxfidiAiM2pUfVeucyEbm8VDVbtycLUMHPYGslPVwfU
         0eIqT+ASSZ6xV5zsAtZV5Ol4Yo04EZqKmFRAobhpNM7nWQVLuQQ536Mt35WreemgiwHZ
         gWZW0E1jyoIO6xS+qS6uSSsWvjUtPOo8yKrven7V8F4OOHJ6C5vZz1f2sLCBtI9Dk3/n
         bUm/DKtRXh/DOIj/yuYimFHr/MKaKWnDiykZJMIiLjGdOiMc+ag6T8/pfBVpDTmRP0w5
         XOV+MsgzT3pLoFQDUhRoFMh9WfkpE4f8ZWgpilCROC2lxft1n6Lb81fgKEmctq9YfO3o
         OXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Yu24t+GKmNGWTShqeL1NHYrjL7wCiR6v+VbVrto/ls=;
        b=Py6nfYIKK0PzhXaDAga/IXrXxKnppxeLbcILdsix2Eq0UCxeBeAUKrD6pDitfLoxC4
         Ue+C+noa2a2NoZM5l3bP407ZilLgZYQ0ep9Y4Dswf81+MtVKwZHtzoDIEsjlyFuYTsrd
         n+CvMUCnQuPSURIu3lhRNGZa2yy8g+YxKOAStilMcmEyYmjAIQm+oU+k/2kjoIYqurio
         F+4MBtywGVqYQCsr01GSz6an/iLEJAEnE9jT7V8GEi4GluXfPv1Dn/PgUAws+BE6nu3B
         qfoKRsYC+SqhwCj3lKBdFSzNxcAVyOjMd3DypjkY3/1nBKFJL+OfYpT+20VGBQpzIOJf
         lZKg==
X-Gm-Message-State: APjAAAVJFqoSnJJ+m1XYW50KBNZr3xGoe20XbpIKW2JA4tynCt3hhAXd
        PYbPq/rwydOiakdf10q1y5HLBceKUbUXR4fgXwnwPA==
X-Google-Smtp-Source: APXvYqzjMsHpgEcypL6AsnXwB0s9oPCviAs8vELJ7Q8+2fOw4aUBN1yixNn8g+Zs3bZ4CdrioOR5tX/kcolWcoWgAhN0zQ==
X-Received: by 2002:a1f:db01:: with SMTP id s1mr3963209vkg.34.1566610514916;
 Fri, 23 Aug 2019 18:35:14 -0700 (PDT)
Date:   Fri, 23 Aug 2019 18:34:21 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 14/18] kunit: defconfig: add defconfigs for building KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add defconfig for UML and a fragment that can be used to configure other
architectures for building KUnit tests. Add option to kunit_tool to use
a defconfig to create the kunitconfig.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/configs/kunit_defconfig              |  3 +++
 tools/testing/kunit/configs/all_tests.config |  3 +++
 tools/testing/kunit/kunit.py                 | 28 +++++++++++++++++---
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 32 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index da11bd62a4b8..0944dea5c321 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -11,6 +11,7 @@ import argparse
 import sys
 import os
 import time
+import shutil
 
 from collections import namedtuple
 from enum import Enum, auto
@@ -21,7 +22,7 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -29,8 +30,16 @@ class KunitStatus(Enum):
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
+def create_default_kunitconfig():
+	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+		shutil.copyfile('arch/um/configs/kunit_defconfig',
+				kunit_kernel.KUNITCONFIG_PATH)
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
+	if request.defconfig:
+		create_default_kunitconfig()
+
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
@@ -72,7 +81,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	else:
 		return KunitResult(KunitStatus.SUCCESS, test_result)
 
-def main(argv, linux):
+def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
@@ -99,13 +108,24 @@ def main(argv, linux):
 				'directory.',
 				type=str, default=None, metavar='build_dir')
 
+	run_parser.add_argument('--defconfig',
+				help='Uses a default kunitconfig.',
+				action='store_true')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.defconfig:
+			create_default_kunitconfig()
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
-				       cli_args.build_dir)
+				       cli_args.build_dir,
+				       cli_args.defconfig)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
@@ -113,4 +133,4 @@ def main(argv, linux):
 		parser.print_help()
 
 if __name__ == '__main__':
-	main(sys.argv[1:], kunit_kernel.LinuxSourceTree())
+	main(sys.argv[1:])
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 07c0abf2f47d..bf3876835331 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
+KUNITCONFIG_PATH = 'kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -81,7 +82,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file('kunitconfig')
+		self._kconfig.read_from_file(KUNITCONFIG_PATH)
 		self._ops = LinuxSourceTreeOperations()
 
 	def clean(self):
-- 
2.23.0.187.g17f5b7556c-goog

