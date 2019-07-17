Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367546B402
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfGQB4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:56:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39901 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfGQB4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:56:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id 6so13507671pfi.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 18:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s82Ayn4neFYcAO/Xgs13SkQIKN7xjGSSC0eA9YZ5RLI=;
        b=Tp7gOfmDLxalewc8DAwq3ZTNgy43TRCgRYvSqtgzOp9OjXjBNnR3Ek/VJEJqC/P5pa
         ob8ROuPWUwvyQYECW/A65xP16vWlkPE7l/l496N09NFTaKfEXeeZjAijerBUHl9akhiY
         Hwo/0ABlqEowRiUcFvzzHJsVyssJgh55ttN/hz52YuXLLr0vz35VgDRHMg7WAIYN3jD9
         TMtz9T5bEm92TpTdjk+UI3JzqDiXrj8sfudmkW9ngFkd+OR3huzOUs0Yp2XbM8kyo2wH
         R1P4afORGIWa5IJlZGzTYI4utUje+O7x3ZmiM0X7iSlVWzjjqDQh4r/I6hIw/gJGQJ6V
         7Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s82Ayn4neFYcAO/Xgs13SkQIKN7xjGSSC0eA9YZ5RLI=;
        b=sWRIZPco/Id6tz2Sf58oKBsI5C9EBwl62reLmsQYVT672hqF4siCC6kZRg0faZzOMh
         7/lsh14PYOk/QxdUQhIRIHNzwVJR6EAEXLfiLXG6tlRLJnNH8jU93iDUlQy+C2VQIBQa
         SPoRl8hCJZc8j+2f97FNzKmSEsLfeCBRliMqJnVGxE3toC+0/xqspGXrW4TIjrEnnoYQ
         Thgr0i6+k/JM6o/xr+0UHvsiTrktBlEIIAhWIzzKyZgnD2PHVxIfmxrX6k/ee/VETIG9
         tfzABFJqHiq5UnX8EblO11MCoPoRAwVd/9nSe4XVxjf7oMABBi1YgZgQmZHyJQX+tEsm
         V3JQ==
X-Gm-Message-State: APjAAAV582Ebex5Ysfp4t69WN++EnW5pvD/N5N33VtYQUsPSh3pz2rNk
        v7Nya6FA474BYkpFrV019MTUqqWhbB56FSErSEb3iw==
X-Google-Smtp-Source: APXvYqwpTiZBljkWnEdkylF9doZCZyzuyfHQW5BM0lDtAlIaKKYFaiALqU75kIWAK9/dNceNH0xIw67549MuXwUpuUwi6g==
X-Received: by 2002:a63:1020:: with SMTP id f32mr6554669pgl.203.1563328592098;
 Tue, 16 Jul 2019 18:56:32 -0700 (PDT)
Date:   Tue, 16 Jul 2019 18:55:39 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 14/18] kunit: defconfig: add defconfigs for building KUnit tests
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
---
 arch/um/configs/kunit_defconfig              |  8 ++++++++
 tools/testing/kunit/configs/all_tests.config |  8 ++++++++
 tools/testing/kunit/kunit.py                 | 18 ++++++++++++++++--
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/configs/kunit_defconfig
 create mode 100644 tools/testing/kunit/configs/all_tests.config

diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
new file mode 100644
index 0000000000000..bfe49689038f1
--- /dev/null
+++ b/arch/um/configs/kunit_defconfig
@@ -0,0 +1,8 @@
+CONFIG_OF=y
+CONFIG_OF_UNITTEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
new file mode 100644
index 0000000000000..bfe49689038f1
--- /dev/null
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -0,0 +1,8 @@
+CONFIG_OF=y
+CONFIG_OF_UNITTEST=y
+CONFIG_OF_OVERLAY=y
+CONFIG_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index da11bd62a4b82..3e51dc4febfdc 100755
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
@@ -99,13 +108,18 @@ def main(argv, linux):
 				'directory.',
 				type=str, default=None, metavar='build_dir')
 
+	run_parser.add_argument('--defconfig',
+				help='Uses a default kunitconfig.',
+				action='store_true')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
-				       cli_args.build_dir)
+				       cli_args.build_dir,
+				       cli_args.defconfig)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 07c0abf2f47df..bf38768353313 100644
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
2.22.0.510.g264f2c817a-goog

