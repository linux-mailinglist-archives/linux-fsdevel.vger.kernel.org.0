Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6BAB9A75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbfITXU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 19:20:57 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56206 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437080AbfITXUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:20:20 -0400
Received: by mail-pg1-f201.google.com with SMTP id k18so5339050pgh.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2019 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XW6ObdsygoQczUzhnAeFOiZL9hvh/FcVMF1CQf4gGoM=;
        b=fN8BbWKkmRWbki39ZBHS5ypTABzdFkBbS17uOOzZIBa9I0/uONV1bGF+mQFoBxTwHy
         zF4o8ega2hGp8xygdEQArh+kCnmLjjjr9TYrCZwA//Tm2wHujPFBJClVGn9j86/H0jLi
         b2Xaxq8Lzq6txv7pSIc+jnf/1UXvj+mWm9RYoYPs7FksxUFLw+SbqXRKqFET1FnQOD/9
         4kkQrjNSMR2R3RzMaznpXBVtLPYJMhMBVI668K3BGdfu3bwViWUN3QqJTUwTRbLFtiNU
         Ej22MFIEnLSsw8vnMbCiXQVCdTWw23HPUbk7RFORErjOyEgfVwdH6/QHN6VKjkYfLBTe
         EIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XW6ObdsygoQczUzhnAeFOiZL9hvh/FcVMF1CQf4gGoM=;
        b=VcjbBF4OxrmcfBzm+u1MHSSZJEQr4n0Q4/dQRvbAXUXYAUcGDoUC5NbsMYFjN5I902
         eFzKVqxe5Kxp9QEqpCBf1F+BNg7cAV3A0ZFqh/ZgJw7YhIOhv+ybnhnxj7/L8bMCI91/
         pAw3VyzU04iS9WcvhsZLLDqqr4bvinNDXaDdRY93A1aah2Q558zgMj9Q8nvKbvrTu1/T
         hsqbyzqZH5gRGNOtP9Wrt7yBm9GS8OIkLilwZPuaxlZJFypQTRtm25uRdAnfdLtW84oh
         lz/XsTGT8pqipp0LyXu4+EtboU2F7YFVUcAOzXM2dlNfQP/y02v5ECGpMVT/98icNFG/
         KDLA==
X-Gm-Message-State: APjAAAXiG4l78DnXevVYbQEvbBjbh4TvrtyoMxFsa+L0FraNfleJM11g
        meOl8/ly3lailJrJdUC92HA2yOMPQ+kyU9di4DNvfg==
X-Google-Smtp-Source: APXvYqxKVyhgyp4fnQJvfBqNIedf10ujv/TGP90gZCYCjp1JDQT/YqURWr/Bs7K6Ny1E5F/kXnYi2soTBwRXscawpsjg+g==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr17488162pgf.353.1569021617565;
 Fri, 20 Sep 2019 16:20:17 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:19:18 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 14/19] kunit: defconfig: add defconfigs for building KUnit tests
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Brendan Higgins <brendanhiggins@google.com>
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
2.23.0.351.gc4317032e6-goog

