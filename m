Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2547D8A61E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfHLSZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:25:19 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:57313 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfHLSZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:25:18 -0400
Received: by mail-pg1-f201.google.com with SMTP id h5so65123261pgq.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pX6n91rvue//sk8KO1IpvJt6DpxeU7XjD76CqyTGWp0=;
        b=PW4wL0bO2zcWaoW4VBI+xUgymp8BzlRorRZ+4kMiTvtbMOXu4CD6+Vhkx3f7bIyn/l
         pLsw0gbsjZuAKYtYbirskoMed9WDPp4N26shnobQwJEEq3q1lig6Emt7qj/0bZwhdDKk
         88FASD4I+idci0XrkfHmSS8lrSGKqadp8a9AtZCcm+VZErjUDs5glJekR2PNCX5IJ7N8
         SNBgmjQb7SJElKH7SGzpwvEF2+Z9W7tChui3P0v2V2IXpzNSwi985Csmo/JsWAtoyqvD
         nHY5JCNtmNMBiG64ZXFD8aaZ0O9rvT9/YK/Dsx7Uk1i808geGclqDhjGxosbnvpda03E
         fbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pX6n91rvue//sk8KO1IpvJt6DpxeU7XjD76CqyTGWp0=;
        b=DHHeNyGNgu5qy+gmfiHgrmeNiSJbh6rMPxRtxf+UDICoiDoM3z+znPDW6vGknVyEv5
         rP/r14un15RFuBttbOwwGk4Oxy5aVf+oBElUjCNV/4MZC0UKXhKJuRHaODJ7KMEgmzaw
         k1zqdBhKGCGdRSNnsLfXkSqctsmYa57I89M/BL/Up50bNB8JrrJRe9up5ZjIr4BGqHRS
         NZAeEEU6yM7Xptjhk3WoBxCRamR4LH4D5iefAf+gAVp1deJDXIbtRFKcLTkfrY5jTU3r
         LXYWj0b1oONGv4SxIBd6sT4m5CB+uq2YEoBDnrk9qBA/srUZJ7AMOUJ04jX2kCTR5Gbc
         lDUQ==
X-Gm-Message-State: APjAAAUNr7XrnVVAcrISZCd/iY8L9Z1jnucez7DNdQUSqQ6pWBI83MTw
        n8T/VHIShnZvBTTNKRKEDkhGbcJEsF5eCS58AJfpfg==
X-Google-Smtp-Source: APXvYqx78NkQYYvJHwOdsQW33ggXQhwmeI4j0d/GB9YOT+8NGxuyiQnom9juCP4EAptKpj7HoOTjDPS38ZkMc0L+89sQAA==
X-Received: by 2002:a63:1743:: with SMTP id 3mr30446757pgx.435.1565634317319;
 Mon, 12 Aug 2019 11:25:17 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:24:17 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 14/18] kunit: defconfig: add defconfigs for building KUnit tests
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
 arch/um/configs/kunit_defconfig              |  8 ++++++
 tools/testing/kunit/configs/all_tests.config |  8 ++++++
 tools/testing/kunit/kunit.py                 | 28 +++++++++++++++++---
 tools/testing/kunit/kunit_kernel.py          |  3 ++-
 4 files changed, 42 insertions(+), 5 deletions(-)
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
index da11bd62a4b82..0944dea5c3211 100755
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
2.23.0.rc1.153.gdeed80330f-goog

