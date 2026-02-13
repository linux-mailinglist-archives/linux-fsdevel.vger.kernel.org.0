Return-Path: <linux-fsdevel+bounces-77080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLd1HZ7MjmkRFAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:02:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A5133619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D51A302F6FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD928F949;
	Fri, 13 Feb 2026 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dkrwgnbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA1283CB1;
	Fri, 13 Feb 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966124; cv=none; b=PvTH249d02jM6Ztbyp8D+MplN/BUQTKDYTXTZfexVPLk2SKDyY2528Bi8do5PcJPR+hXmceGZjVXIs5STk1zI57Ue5zv5hr6kqPT42vpBGlCUxx9NyScqRCOdbtvxxmesXZwT8KCjQqEnF9wKhDEuUEavwoqspYI/Y6KpJcMrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966124; c=relaxed/simple;
	bh=Z7yBzde7kusMZer2YyDMeci8ChO4itSl1Y37pEb5HpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD4VlOUSyolYDKxnjbLKh6aKuHBxkTLlkJ8P/xYdArTtVp48EPtVBK282RFRXybrQuhr5pdt2KzZBG3PbxSZmsBgNGoBEhxsVnC/wSkf/rZFbjILrsJJ8CJdA+s9ec9xKWM68jWz68hwQu126Fj3LXYTD8OIc7kIPeIF4ASAcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Dkrwgnbm; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770966122; x=1802502122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7yBzde7kusMZer2YyDMeci8ChO4itSl1Y37pEb5HpY=;
  b=DkrwgnbmHkCje/TU4KaVKa/woPMxmf7CNwdA/Hwf4c6OBqsY5grq/wH1
   5+LNs/TpAqpq8VYUbwS2ipbNkRBPioq2Z+kA3aFGACeKpl7qJbMrNPcK9
   BtViGB1dgrESMK9RDBkELBae+BhtEk+DVxQf7YRZ/DZJhm7oE1WPSOLt6
   mcHaLr3xfok4t5tdsjgFqngA3rr3PZDZEy+c3HV/uCoQ40D14bOoHsYGX
   VMX6nIAcSZeBdSQZb2DFJF0eD4wdVDUgHbTqMoX8Dvy3Y05FS1D/SfeSu
   N7RHlRwm33uvlWETrQJiH20dPs5smbnc1DCbRw4Wba9D5s9Y8LZgtiWKy
   A==;
X-CSE-ConnectionGUID: UmkgOCh4Tmu1+jvSn60/eg==
X-CSE-MsgGUID: YhTVwjyPSnG1a+C8+2eM1g==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="137154159"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2026 15:01:59 +0800
IronPort-SDR: 698ecc67_5pgllJW7rn1/88FfiqeppYuOqINdSSsl+S5atwpvdeQNPF4
 malnX9BXcaSs+CxhKhbYJF9j4QY3Z/pI/5SqbBQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2026 23:02:00 -0800
WDCIronportException: Internal
Received: from wdap-yooxex5p9f.ad.shared (HELO neo.wdc.com) ([10.224.28.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Feb 2026 23:01:57 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] fstests: use _fixed_by_fs_commit where appropriate
Date: Fri, 13 Feb 2026 08:01:48 +0100
Message-ID: <20260213070148.37518-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213070148.37518-1-johannes.thumshirn@wdc.com>
References: <20260213070148.37518-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77080-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,wdc.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A9A5133619
X-Rspamd-Action: no action

Use the newly introduced _fixed_by_fs_commit function where appropriate.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/generic/211 |  2 +-
 tests/generic/362 |  3 +--
 tests/generic/363 | 10 ++++------
 tests/generic/364 |  3 +--
 tests/generic/365 | 15 ++++++---------
 tests/generic/366 |  2 +-
 tests/generic/367 |  2 +-
 tests/generic/370 |  5 ++---
 tests/generic/471 |  2 +-
 tests/generic/562 |  3 +--
 tests/generic/623 |  2 +-
 tests/generic/631 |  3 +--
 tests/generic/646 |  2 +-
 tests/generic/649 |  2 +-
 tests/generic/650 |  2 +-
 tests/generic/695 |  2 +-
 tests/generic/700 |  2 +-
 tests/generic/701 |  2 +-
 tests/generic/702 |  2 +-
 tests/generic/703 |  3 +--
 tests/generic/704 |  2 +-
 tests/generic/706 |  3 +--
 tests/generic/707 |  2 +-
 tests/generic/708 |  3 +--
 tests/generic/733 | 10 ++--------
 tests/generic/736 |  2 +-
 tests/generic/738 |  2 +-
 tests/generic/741 |  2 +-
 tests/generic/742 |  3 +--
 tests/generic/748 |  2 +-
 tests/generic/755 |  2 +-
 tests/generic/757 |  2 +-
 tests/generic/761 |  2 +-
 tests/generic/763 |  2 +-
 tests/generic/764 |  2 +-
 tests/generic/766 |  8 +++-----
 tests/generic/771 |  2 +-
 tests/generic/779 |  2 +-
 tests/generic/782 |  2 +-
 tests/generic/784 |  2 +-
 tests/generic/785 |  2 +-
 41 files changed, 53 insertions(+), 75 deletions(-)

diff --git a/tests/generic/211 b/tests/generic/211
index f356d13b1c6a..ee73a59dffb0 100755
--- a/tests/generic/211
+++ b/tests/generic/211
@@ -15,7 +15,7 @@ _begin_fstest auto quick rw mmap
 
 _require_scratch
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 6599716de2d6 \
+_fixed_by_fs_commit btrfs 6599716de2d6 \
 	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
 
 # Use a 512M fs so that it's fast to fill it with data but not too small such
diff --git a/tests/generic/362 b/tests/generic/362
index 3a1993e81d4b..0cfaa726be70 100755
--- a/tests/generic/362
+++ b/tests/generic/362
@@ -17,8 +17,7 @@ _require_test
 _require_odirect
 _require_test_program dio-append-buf-fault
 
-[ $FSTYP == "btrfs" ] && \
-	_fixed_by_kernel_commit 939b656bc8ab \
+_fixed_by_fs_commit btrfs 939b656bc8ab \
 	"btrfs: fix corruption after buffer fault in during direct IO append write"
 
 # On error the test program writes messages to stderr, causing a golden output
diff --git a/tests/generic/363 b/tests/generic/363
index f361878a47e8..3e58d864d4ee 100755
--- a/tests/generic/363
+++ b/tests/generic/363
@@ -13,12 +13,10 @@ _begin_fstest rw auto
 
 _require_test
 
-if [ $FSTYP == "btrfs" ]; then
-	_fixed_by_kernel_commit da2dccd7451d \
-		"btrfs: fix hole expansion when writing at an offset beyond EOF"
-	_fixed_by_kernel_commit 8e4f21f2b13d \
-		"btrfs: handle unaligned EOF truncation correctly for subpage cases"
-fi
+_fixed_by_fs_commit btrfs da2dccd7451d \
+	"btrfs: fix hole expansion when writing at an offset beyond EOF"
+_fixed_by_fs_commit btrfs 8e4f21f2b13d \
+	"btrfs: handle unaligned EOF truncation correctly for subpage cases"
 
 # on failure, replace -q with -d to see post-eof writes in the dump output
 run_fsx "-q -S 0 -e 1 -N 100000"
diff --git a/tests/generic/364 b/tests/generic/364
index 968b4754deca..f7fb002ff858 100755
--- a/tests/generic/364
+++ b/tests/generic/364
@@ -17,8 +17,7 @@ _require_test_program dio-write-fsync-same-fd
 _require_command "$TIMEOUT_PROG" timeout
 
 # Triggers very frequently with kernel config CONFIG_BTRFS_ASSERT=y.
-[ $FSTYP == "btrfs" ] && \
-	_fixed_by_kernel_commit cd9253c23aed \
+_fixed_by_fs_commit btrfs cd9253c23aed \
 	"btrfs: fix race between direct IO write and fsync when using same fd"
 
 # On error the test program writes messages to stderr, causing a golden output
diff --git a/tests/generic/365 b/tests/generic/365
index 4acc4b01b584..0319ef1763dc 100755
--- a/tests/generic/365
+++ b/tests/generic/365
@@ -9,15 +9,12 @@
 . ./common/preamble
 _begin_fstest auto rmap fsmap
 
-if [ "$FSTYP" = "xfs" ]; then
-	_fixed_by_kernel_commit 68415b349f3f \
-		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
-	_fixed_by_kernel_commit ca6448aed4f1 \
-		"xfs: Fix missing interval for missing_owner in xfs fsmap"
-elif [ "$FSTYP" = "ext4" ]; then
-	_fixed_by_kernel_commit 4a622e4d477b \
-		"ext4: fix FS_IOC_GETFSMAP handling"
-fi
+_fixed_by_fs_commit xfs 68415b349f3f \
+	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
+_fixed_by_fs_commit xfs ca6448aed4f1 \
+	"xfs: Fix missing interval for missing_owner in xfs fsmap"
+_fixed_by_fs_commit ext4 4a622e4d477b \
+	"ext4: fix FS_IOC_GETFSMAP handling"
 
 . ./common/filter
 
diff --git a/tests/generic/366 b/tests/generic/366
index b2c2e607d6bb..271a01bc2eac 100755
--- a/tests/generic/366
+++ b/tests/generic/366
@@ -23,7 +23,7 @@ _require_scratch
 _require_odirect 512	# see fio job1 config below
 _require_aio
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
 	"btrfs: avoid deadlock when reading a partial uptodate folio"
 
 iterations=$((32 * LOAD_FACTOR))
diff --git a/tests/generic/367 b/tests/generic/367
index 567db5577898..0b3e67f1cdb8 100755
--- a/tests/generic/367
+++ b/tests/generic/367
@@ -16,7 +16,7 @@
 
 _begin_fstest ioctl quick
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2a492ff66673 \
+_fixed_by_fs_commit xfs 2a492ff66673 \
 	"xfs: Check for delayed allocations before setting extsize"
 
 _require_scratch_extsize
diff --git a/tests/generic/370 b/tests/generic/370
index d9ba6c57d5e9..b5d942de4f88 100755
--- a/tests/generic/370
+++ b/tests/generic/370
@@ -19,10 +19,9 @@ _cleanup()
 
 . ./common/reflink
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 03018e5d8508 \
+_fixed_by_fs_commit btrfs 03018e5d8508 \
     "btrfs: fix swap file activation failure due to extents that used to be shared"
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2d873efd174b \
-	"xfs: flush inodegc before swapon"
+_fixed_by_fs_commit xfs 2d873efd174b "xfs: flush inodegc before swapon"
 
 _require_scratch_swapfile
 _require_scratch_reflink
diff --git a/tests/generic/471 b/tests/generic/471
index e98e3f00c7c3..a1547e70d19c 100755
--- a/tests/generic/471
+++ b/tests/generic/471
@@ -23,7 +23,7 @@ _cleanup()
 _require_test
 _require_test_program rewinddir-test
 
-[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit e60aa5da14d0 \
+_fixed_by_fs_commit btrfs e60aa5da14d0 \
 	"btrfs: refresh dir last index during a rewinddir(3) call"
 
 target_dir="$TEST_DIR/test-$seq"
diff --git a/tests/generic/562 b/tests/generic/562
index b9562730eac9..115f3d89ad98 100755
--- a/tests/generic/562
+++ b/tests/generic/562
@@ -15,8 +15,7 @@ _begin_fstest auto clone punch
 . ./common/filter
 . ./common/reflink
 
-test "$FSTYP" = "xfs" && \
-	_fixed_by_kernel_commit 7ce31f20a077 "xfs: don't drop errno values when we fail to ficlone the entire range"
+_fixed_by_fs_commit xfs 7ce31f20a077 "xfs: don't drop errno values when we fail to ficlone the entire range"
 
 _require_scratch_reflink
 _require_test_program "punch-alternating"
diff --git a/tests/generic/623 b/tests/generic/623
index f546d529a32f..da884c72a4bc 100755
--- a/tests/generic/623
+++ b/tests/generic/623
@@ -11,7 +11,7 @@ _begin_fstest auto quick shutdown mmap
 
 . ./common/filter
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit e4826691cc7e \
+_fixed_by_fs_commit xfs e4826691cc7e \
 	"xfs: restore shutdown check in mapped write fault path"
 
 _require_scratch_nocheck
diff --git a/tests/generic/631 b/tests/generic/631
index c38ab7712fda..8b12b8f247ee 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -41,8 +41,7 @@ _require_attrs trusted
 _exclude_fs overlay
 _require_extra_fs overlay
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
-	"xfs: fix an ABBA deadlock in xfs_rename"
+_fixed_by_fs_commit xfs 6da1b4b1ab36 "xfs: fix an ABBA deadlock in xfs_rename"
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
diff --git a/tests/generic/646 b/tests/generic/646
index b3b0ab0ace56..10ae887e9539 100755
--- a/tests/generic/646
+++ b/tests/generic/646
@@ -14,7 +14,7 @@
 . ./common/preamble
 _begin_fstest auto quick recoveryloop shutdown
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 50d25484bebe \
+_fixed_by_fs_commit xfs 50d25484bebe \
 	"xfs: sync lazy sb accounting on quiesce of read-only mounts"
 
 _require_scratch
diff --git a/tests/generic/649 b/tests/generic/649
index 58ef96a8a12a..de45ad4e3bb4 100755
--- a/tests/generic/649
+++ b/tests/generic/649
@@ -31,7 +31,7 @@ _cleanup()
 
 
 # Modify as appropriate.
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 72a048c1056a \
+_fixed_by_fs_commit xfs 72a048c1056a \
 	"xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
 
 _require_cp_reflink
diff --git a/tests/generic/650 b/tests/generic/650
index 2e051b731568..48f81dcb5c21 100755
--- a/tests/generic/650
+++ b/tests/generic/650
@@ -10,7 +10,7 @@
 . ./common/preamble
 _begin_fstest auto rw stress soak
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit ecd49f7a36fb \
+_fixed_by_fs_commit xfs ecd49f7a36fb \
         "xfs: fix per-cpu CIL structure aggregation racing with dying cpus"
 
 # Override the default cleanup function.
diff --git a/tests/generic/695 b/tests/generic/695
index 694f42454511..e08834374abf 100755
--- a/tests/generic/695
+++ b/tests/generic/695
@@ -25,7 +25,7 @@ _cleanup()
 . ./common/dmflakey
 . ./common/punch
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit e6e3dec6c3c288 \
+_fixed_by_fs_commit btrfs e6e3dec6c3c288 \
         "btrfs: update generation of hole file extent item when merging holes"
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/generic/700 b/tests/generic/700
index 7f84df9df40a..8747b7be037a 100755
--- a/tests/generic/700
+++ b/tests/generic/700
@@ -19,7 +19,7 @@ _require_scratch
 _require_attrs
 _require_renameat2 whiteout
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 70b589a37e1a \
+_fixed_by_fs_commit xfs 70b589a37e1a \
 	"xfs: add selinux labels to whiteout inodes"
 
 get_selinux_label()
diff --git a/tests/generic/701 b/tests/generic/701
index 806cc65dd77e..62dda8595ac1 100755
--- a/tests/generic/701
+++ b/tests/generic/701
@@ -22,7 +22,7 @@ _cleanup()
 	rm -r -f $tmp.* $junk_dir
 }
 
-[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit 92fba084b79e \
+_fixed_by_fs_commit exfat 92fba084b79e \
 	"exfat: fix i_blocks for files truncated over 4 GiB"
 
 _require_test
diff --git a/tests/generic/702 b/tests/generic/702
index ae47eb27dfb3..8c3e2b49a12b 100755
--- a/tests/generic/702
+++ b/tests/generic/702
@@ -14,7 +14,7 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ac3c0d36a2a2f7 \
+_fixed_by_fs_commit btrfs ac3c0d36a2a2f7 \
 	"btrfs: make fiemap more efficient and accurate reporting extent sharedness"
 
 _require_scratch_reflink
diff --git a/tests/generic/703 b/tests/generic/703
index 2bace19d6f06..1a1a0184c6f6 100755
--- a/tests/generic/703
+++ b/tests/generic/703
@@ -23,8 +23,7 @@ fio_config=$tmp.fio
 fio_out=$tmp.fio.out
 test_file="${SCRATCH_MNT}/foo"
 
-[ $FSTYP == "btrfs" ] &&
-	_fixed_by_kernel_commit 8184620ae212 \
+_fixed_by_fs_commit btrfs 8184620ae212 \
 	"btrfs: fix lost file sync on direct IO write with nowait and dsync iocb"
 
 # We allocate 256M of data for the test file, so require a higher size of 512M
diff --git a/tests/generic/704 b/tests/generic/704
index f2360c42e40d..d0d7f1239489 100755
--- a/tests/generic/704
+++ b/tests/generic/704
@@ -21,7 +21,7 @@ _cleanup()
 # Import common functions.
 . ./common/scsi_debug
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 7c71ee78031c \
+_fixed_by_fs_commit xfs 7c71ee78031c \
 	"xfs: allow logical-sector sized O_DIRECT"
 
 _require_scsi_debug
diff --git a/tests/generic/706 b/tests/generic/706
index ce248814f871..30d06ef9a732 100755
--- a/tests/generic/706
+++ b/tests/generic/706
@@ -10,8 +10,7 @@
 . ./common/preamble
 _begin_fstest auto quick seek
 
-[ $FSTYP == "btrfs" ] &&
-	_fixed_by_kernel_commit 2f2e84ca6066 \
+_fixed_by_fs_commit btrfs 2f2e84ca6066 \
 	"btrfs: fix off-by-one in delalloc search during lseek"
 
 _require_test
diff --git a/tests/generic/707 b/tests/generic/707
index ed392a1b5bff..33737ee1673a 100755
--- a/tests/generic/707
+++ b/tests/generic/707
@@ -13,7 +13,7 @@ _begin_fstest auto
 
 _require_scratch
 
-[ "$FSTYP" = "udf" ] && _fixed_by_kernel_commit f950fd052913 \
+_fixed_by_fs_commit udf f950fd052913 \
 	"udf: Protect rename against modification of moved directory"
 [[ "$FSTYP" =~ ext[0-9]+ ]] && _fixed_by_kernel_commit 0813299c586b \
 	"ext4: Fix possible corruption when moving a directory"
diff --git a/tests/generic/708 b/tests/generic/708
index ec7e48a9f274..827dac134b92 100755
--- a/tests/generic/708
+++ b/tests/generic/708
@@ -14,8 +14,7 @@
 . ./common/preamble
 _begin_fstest quick auto mmap
 
-[ $FSTYP == "btrfs" ] && \
-	_fixed_by_kernel_commit b73a6fd1b1ef \
+_fixed_by_fs_commit btrfs b73a6fd1b1ef \
 		"btrfs: split partial dio bios before submit"
 
 _require_test
diff --git a/tests/generic/733 b/tests/generic/733
index 21347d51b4d2..01ede8003d60 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -25,16 +25,10 @@ _require_test_program "punch-alternating"
 _require_test_program "t_reflink_read_race"
 _require_command "$TIMEOUT_PROG" timeout
 
-case "$FSTYP" in
-"btrfs")
-	_fixed_by_kernel_commit 5d6f0e9890ed \
+_fixed_by_fs_commit btrfs 5d6f0e9890ed \
 		"btrfs: stop locking the source extent range during reflink"
-	;;
-"xfs")
-	_fixed_by_kernel_commit 14a537983b22 \
+_fixed_by_fs_commit xfs 14a537983b22 \
 		"xfs: allow read IO and FICLONE to run concurrently"
-	;;
-esac
 
 rm -f "$seqres.full"
 
diff --git a/tests/generic/736 b/tests/generic/736
index 2fe7ba8e5ae9..95bdcfbe723d 100755
--- a/tests/generic/736
+++ b/tests/generic/736
@@ -21,7 +21,7 @@ _cleanup()
 _require_test
 _require_test_program readdir-while-renames
 
-[ $FSTYP = "btrfs" ] && _fixed_by_kernel_commit 9b378f6ad48c \
+_fixed_by_fs_commit btrfs 9b378f6ad48c \
 	"btrfs: fix infinite directory reads"
 
 target_dir="$TEST_DIR/test-$seq"
diff --git a/tests/generic/738 b/tests/generic/738
index b0503025147d..3c1599c05459 100755
--- a/tests/generic/738
+++ b/tests/generic/738
@@ -9,7 +9,7 @@
 . ./common/preamble
 _begin_fstest auto quick freeze
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit ab23a7768739 \
+_fixed_by_fs_commit xfs ab23a7768739 \
 	"xfs: per-cpu deferred inode inactivation queues"
 
 _cleanup()
diff --git a/tests/generic/741 b/tests/generic/741
index c15dc4345b7a..c3fe927d10a7 100755
--- a/tests/generic/741
+++ b/tests/generic/741
@@ -33,7 +33,7 @@ _require_test
 _require_scratch
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 2f1aeab9fca1 \
+_fixed_by_fs_commit btrfs 2f1aeab9fca1 \
 			"btrfs: return accurate error code on open failure"
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/generic/742 b/tests/generic/742
index ceecbdf9edd4..52f0c3c39a9d 100755
--- a/tests/generic/742
+++ b/tests/generic/742
@@ -14,8 +14,7 @@
 . ./common/preamble
 _begin_fstest quick auto fiemap mmap
 
-[ $FSTYP == "btrfs" ] && \
-	_fixed_by_kernel_commit b0ad381fa769 \
+_fixed_by_fs_commit btrfs b0ad381fa769 \
 		"btrfs: fix deadlock with fiemap and extent locking"
 
 _cleanup()
diff --git a/tests/generic/748 b/tests/generic/748
index 062e29aa3165..9ea596e0670b 100755
--- a/tests/generic/748
+++ b/tests/generic/748
@@ -16,7 +16,7 @@ _require_scratch
 _require_attrs
 _require_odirect
 _require_xfs_io_command falloc -k
-[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit 9d274c19a71b \
+_fixed_by_fs_commit btrfs 9d274c19a71b \
 	"btrfs: fix crash on racing fsync and size-extending write into prealloc"
 
 # -i slows down xfs_io startup and makes the race much less reliable.
diff --git a/tests/generic/755 b/tests/generic/755
index b2fd3e58f5df..59df6bd86962 100755
--- a/tests/generic/755
+++ b/tests/generic/755
@@ -12,7 +12,7 @@ _begin_fstest auto quick
 
 _require_hardlinks
 _require_test
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 3bc2ac2f8f0b \
+_fixed_by_fs_commit btrfs 3bc2ac2f8f0b \
 	"btrfs: update target inode's ctime on unlink"
 
 testfile="$TEST_DIR/unlink-ctime1.$$"
diff --git a/tests/generic/757 b/tests/generic/757
index 11398d8677f7..98574114e890 100755
--- a/tests/generic/757
+++ b/tests/generic/757
@@ -19,7 +19,7 @@ _cleanup()
 }
 
 
-[ $FSTYP = "btrfs" ] && _fixed_by_kernel_commit e917ff56c8e7 \
+_fixed_by_fs_commit btrfs e917ff56c8e7 \
 	"btrfs: determine synchronous writers from bio or writeback control"
 
 fio_config=$tmp.fio
diff --git a/tests/generic/761 b/tests/generic/761
index bd7b02a9be34..e9030f3c6ab3 100755
--- a/tests/generic/761
+++ b/tests/generic/761
@@ -19,7 +19,7 @@ _require_scratch
 _require_odirect
 _require_test_program dio-writeback-race
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 968f19c5b1b7 \
+_fixed_by_fs_commit btrfs 968f19c5b1b7 \
 	"btrfs: always fallback to buffered write if the inode requires checksum"
 
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/763 b/tests/generic/763
index d78537ef324c..e5e1ccb10050 100755
--- a/tests/generic/763
+++ b/tests/generic/763
@@ -16,7 +16,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
+_fixed_by_fs_commit exfat dda0407a2026 \
 	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
 
 # Modify as appropriate.
diff --git a/tests/generic/764 b/tests/generic/764
index 55937fc0c988..4842c83aff25 100755
--- a/tests/generic/764
+++ b/tests/generic/764
@@ -20,7 +20,7 @@ _cleanup()
 
 . ./common/dmflakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 5e85262e542d \
+_fixed_by_fs_commit btrfs 5e85262e542d \
 	"btrfs: fix fsync of files with no hard links not persisting deletion"
 
 _require_scratch
diff --git a/tests/generic/766 b/tests/generic/766
index 3b6911f0bdb9..85c89ea71f08 100755
--- a/tests/generic/766
+++ b/tests/generic/766
@@ -32,12 +32,10 @@ _cleanup()
 
 _exclude_fs ext2
 
-[ $FSTYP == "ext4" ] && \
-        _fixed_by_kernel_commit 273108fa5015 \
-        "ext4: handle read only external journal device"
+_fixed_by_fs_commit ext4 273108fa5015 \
+	"ext4: handle read only external journal device"
 
-[ $FSTYP == "xfs" ] && \
-        _fixed_by_kernel_commit bfecc4091e07 \
+_fixed_by_fs_commit xfs bfecc4091e07 \
         "xfs: allow ro mounts if rtdev or logdev are read-only"
 
 _require_scratch_nocheck
diff --git a/tests/generic/771 b/tests/generic/771
index ea3e4ffa13da..e671ee00887e 100755
--- a/tests/generic/771
+++ b/tests/generic/771
@@ -25,7 +25,7 @@ _require_scratch
 _require_test_program unlink-fsync
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 0a32e4f0025a \
+_fixed_by_fs_commit btrfs 0a32e4f0025a \
 	"btrfs: fix log tree replay failure due to file with 0 links and extents"
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
diff --git a/tests/generic/779 b/tests/generic/779
index 842472aedc18..f8d53293f618 100755
--- a/tests/generic/779
+++ b/tests/generic/779
@@ -24,7 +24,7 @@ _require_scratch
 _require_symlinks
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 953902e4fb4c \
+_fixed_by_fs_commit btrfs 953902e4fb4c \
 	"btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
 
 rm -f $seqres.full
diff --git a/tests/generic/782 b/tests/generic/782
index 13c729d29bc4..7cb53f6ea178 100755
--- a/tests/generic/782
+++ b/tests/generic/782
@@ -25,7 +25,7 @@ _cleanup()
 _require_scratch
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit bfe3d755ef7c \
+_fixed_by_fs_commit btrfs bfe3d755ef7c \
 	"btrfs: do not update last_log_commit when logging inode due to a new name"
 
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
diff --git a/tests/generic/784 b/tests/generic/784
index 8e01dff05957..7456abf474bf 100755
--- a/tests/generic/784
+++ b/tests/generic/784
@@ -25,7 +25,7 @@ _cleanup()
 _require_scratch
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
 	"btrfs: don't log conflicting inode if it's a dir moved in the current transaction"
 
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
diff --git a/tests/generic/785 b/tests/generic/785
index a6cfdd87f31b..ec9ef34b9a3a 100755
--- a/tests/generic/785
+++ b/tests/generic/785
@@ -27,7 +27,7 @@ _require_scratch
 _require_dm_target flakey
 _require_fssum
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
 	"btrfs: do not skip logging new dentries when logging a new name"
 
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
-- 
2.53.0


