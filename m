Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD132A527
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443443AbhCBLrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44674 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837944AbhCBJPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614676533; x=1646212533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xg+sumyidrcto9ywBuTvFiUnDLefsoi9x7LlAZwjdQc=;
  b=PQ0VWLbx2yYlNVcK2rULoPQU1bPVe9w2zBNSnnUeGPrWHVgdQrA/dagG
   mOLoN0KX1xhpp9cua8Ek0KWV3ivzR1BT1eoFIEI4IUwZ1Pvec0xL0+iOM
   HTtiqhzxKQHTNaqnHD6K2rOg83Ozrm84iu1KzbcLsB50E7YFERQ1rabmP
   u5EpVxXmLTjeE96ZFe8YQPAHDS4Wk0DzSdBgq84aJyD+t3ixOgom6LPZa
   YcK5mL0t9uUR0EJjISS9VQSWOASfXx8chyObHub3zHBpj9zbbBwFZU8SZ
   XUOp7jbIeQr6BoZirzMejke/Dd2T2YePpETFhi/8ZijnEZJFXtns3ap4N
   Q==;
IronPort-SDR: 9BlhlOM2FslXMXX8AHavGz5xifHZ2j6h2mONjB+2ZQyfjGIBbn5S+qbKKaEi/1g96ENrXdSgXw
 Z/l4tox1lZV51b+xJd+oN26m1XfbuU8btyZP1sQIx+fh7bueZAnaBAXdaspKMoWuvdX9rb8Mvr
 xKYFJz04gzjp1fBDkKdPmItwkOgKlg71URzWGxgZDY0EnVGMdifUv8jW39vmBWsXSE02obkRCw
 4FdLcMD4BlS5hsARpr+6QTWVcyyf7UPelXr2D9XIroIwMvyDN/pYAY7df38Y9tpq6IvC90/XIN
 3DM=
X-IronPort-AV: E=Sophos;i="5.81,216,1610380800"; 
   d="scan'208";a="165623458"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2021 17:13:14 +0800
IronPort-SDR: 1eQjLMvkWj3E200RiGY5+FmuN17sZEVoeaqRMNX1S5G8UmQwP6WjYJvrEqOPCiFDPKpBk90mnS
 K85paj8K1ALrjtEgCHO4iel4DW+rSbiKqhzvbC9ukdm9fja3XZaNhqRf4EVVz0HmlSpKcUFQnC
 p1IhZZItbzRC4s/ymZ9F6rU15mfhvpmg4O4f0SE0vt+svnK2GYgKQaCfq3eyID1hx5g4BGBsf0
 LYSLt5yYoGdL87XG3tBIijNqpxD9FCkwqCevg+Euo4oiJsvyHUAQf7o/z4ldeL4YBV1Fcfw3+L
 x3hBtVjQiMOZbIaUTqx6Ysj5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:54:30 -0800
IronPort-SDR: 4selDGOfALlNk9fb0BDzLfNfQsQNL2j7DUX3FEmH+Y4GlfekvoU/CSMZv80jDMDpsuFmDL3Bu8
 w+6G/YCKpNWBSFJd2cQAI0fKyRKgpaTbI02/Q05Y+XLW05kch/p0DByY4gfr6bocodMDETpbUC
 Qgf58Q/H8GUf+DZ16UbAbKE/fs4k2OJZDVQclmhcuX5GgnM6XJuxaH5MFac3untjNfKRP1Jznh
 egtcHqk8NZskThGai9oeRyYerHAkl0DGUchI8nmUPNjt5XuYU/YKgZ0S5THKCjfsNpS1C2gV8p
 SQU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2021 01:13:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] fstests: add missing checks of fallocate feature
Date:   Tue,  2 Mar 2021 18:13:04 +0900
Message-Id: <20210302091305.27828-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

Many test cases use xfs_io -c 'falloc' but forgot to add
_require_xfs_io_command "falloc". This will fail the test case if we run
the test case on a file system without fallcoate support e.g. F2FS ZZ

While we believe that normal fallocate(mode = 0) is always supported on
Linux, it is not true. Fallocate is disabled in several implementations of
zoned block support for file systems because the pre-allocated region will
break the sequential writing rule.

Currently, several test cases unconditionally call fallocate(). Let's add
_require_xfs_io_command "falloc" to properly check the feature is supported
by a testing file system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/013   | 1 +
 tests/btrfs/016   | 1 +
 tests/btrfs/025   | 1 +
 tests/btrfs/034   | 1 +
 tests/btrfs/037   | 1 +
 tests/btrfs/046   | 1 +
 tests/btrfs/107   | 1 +
 tests/ext4/001    | 1 +
 tests/f2fs/001    | 1 +
 tests/generic/456 | 1 +
 tests/xfs/042     | 1 +
 tests/xfs/114     | 1 +
 tests/xfs/118     | 1 +
 tests/xfs/331     | 1 +
 tests/xfs/341     | 1 +
 tests/xfs/342     | 1 +
 tests/xfs/423     | 1 +
 17 files changed, 17 insertions(+)

diff --git a/tests/btrfs/013 b/tests/btrfs/013
index 9252c82a2076..5e03ed4a4b4b 100755
--- a/tests/btrfs/013
+++ b/tests/btrfs/013
@@ -33,6 +33,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/016 b/tests/btrfs/016
index 8fd237cbdb64..015ec17f93d6 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -35,6 +35,7 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 _require_fssum
+_require_xfs_io_command "falloc"
 
 _scratch_mkfs > /dev/null 2>&1
 
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index 42cd7cefe825..5c8140552bfb 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -31,6 +31,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index bc7a4aae3886..07c84c347d3b 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -28,6 +28,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/037 b/tests/btrfs/037
index 1cfaf5be58c8..9ef199a93413 100755
--- a/tests/btrfs/037
+++ b/tests/btrfs/037
@@ -35,6 +35,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 882db8eacc4e..a1d82e1cdd54 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -37,6 +37,7 @@ _cleanup()
 _supported_fs btrfs
 _require_test
 _require_scratch
+_require_xfs_io_command "falloc"
 _require_fssum
 
 rm -f $seqres.full
diff --git a/tests/btrfs/107 b/tests/btrfs/107
index e57c9dead499..80db5ab9822d 100755
--- a/tests/btrfs/107
+++ b/tests/btrfs/107
@@ -34,6 +34,7 @@ rm -f $seqres.full
 
 _supported_fs btrfs
 _require_scratch
+_require_xfs_io_command "falloc"
 
 # Use 64K file size to match any sectorsize
 # And with a unaligned tailing range to ensure it will be at least 2 pages
diff --git a/tests/ext4/001 b/tests/ext4/001
index bbb74f1ea5bc..9650303d15b5 100755
--- a/tests/ext4/001
+++ b/tests/ext4/001
@@ -29,6 +29,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
 _supported_fs ext4
+_require_xfs_io_command "falloc"
 _require_xfs_io_command "fzero"
 _require_test
 
diff --git a/tests/f2fs/001 b/tests/f2fs/001
index 98bd2682d60f..0753a09b5576 100755
--- a/tests/f2fs/001
+++ b/tests/f2fs/001
@@ -36,6 +36,7 @@ _cleanup()
 
 _supported_fs f2fs
 _require_scratch
+_require_xfs_io_command "falloc"
 
 testfile=$SCRATCH_MNT/testfile
 dummyfile=$SCRATCH_MNT/dummyfile
diff --git a/tests/generic/456 b/tests/generic/456
index 2f9df5e5edc4..65667d449dd3 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # real QA test starts here
 _supported_fs generic
 _require_scratch
+_require_xfs_io_command "falloc"
 _require_dm_target flakey
 _require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fzero"
diff --git a/tests/xfs/042 b/tests/xfs/042
index b55d642c5170..fcd5181cf590 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -31,6 +31,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
 _supported_fs xfs
+_require_xfs_io_command "falloc"
 
 _require_scratch
 
diff --git a/tests/xfs/114 b/tests/xfs/114
index b936452461c6..3f5575a61dfb 100755
--- a/tests/xfs/114
+++ b/tests/xfs/114
@@ -32,6 +32,7 @@ _cleanup()
 _supported_fs xfs
 _require_test_program "punch-alternating"
 _require_xfs_scratch_rmapbt
+_require_xfs_io_command "falloc"
 _require_xfs_io_command "fcollapse"
 _require_xfs_io_command "finsert"
 
diff --git a/tests/xfs/118 b/tests/xfs/118
index 5e23617b39dd..9a431821aa62 100755
--- a/tests/xfs/118
+++ b/tests/xfs/118
@@ -41,6 +41,7 @@ _supported_fs xfs
 
 _require_scratch
 _require_command "$XFS_FSR_PROG" "xfs_fsr"
+_require_xfs_io_command "falloc"
 
 # 50M
 _scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
diff --git a/tests/xfs/331 b/tests/xfs/331
index 4ea54e2a534b..8e92b2e36a8d 100755
--- a/tests/xfs/331
+++ b/tests/xfs/331
@@ -33,6 +33,7 @@ _require_xfs_scratch_rmapbt
 _require_scratch_reflink
 _require_xfs_io_command "falloc"
 _require_test_program "punch-alternating"
+_require_xfs_io_command "falloc"
 
 rm -f "$seqres.full"
 
diff --git a/tests/xfs/341 b/tests/xfs/341
index e1fbe588d9eb..8bf05087e1ba 100755
--- a/tests/xfs/341
+++ b/tests/xfs/341
@@ -31,6 +31,7 @@ _require_realtime
 _require_xfs_scratch_rmapbt
 _require_test_program "punch-alternating"
 _disable_dmesg_check
+_require_xfs_io_command "falloc"
 
 rm -f "$seqres.full"
 
diff --git a/tests/xfs/342 b/tests/xfs/342
index 2be5f7698f01..4db222d65fb2 100755
--- a/tests/xfs/342
+++ b/tests/xfs/342
@@ -30,6 +30,7 @@ _supported_fs xfs
 _require_realtime
 _require_xfs_scratch_rmapbt
 _require_test_program "punch-alternating"
+_require_xfs_io_command "falloc"
 
 rm -f "$seqres.full"
 
diff --git a/tests/xfs/423 b/tests/xfs/423
index 8d51a9a60585..183c9cf5eded 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -35,6 +35,7 @@ _cleanup()
 _supported_fs xfs
 _require_test_program "punch-alternating"
 _require_xfs_io_command "scrub"
+_require_xfs_io_command "falloc"
 _require_scratch
 
 echo "Format and populate"
-- 
2.30.0

