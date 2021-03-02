Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9982232A528
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443450AbhCBLrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44751 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837948AbhCBJPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614676544; x=1646212544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqys5MXEvTKBSvS3WmFhjdv9eLqHBzV2Qh4O5+5gNHM=;
  b=NZ4um3fTKshHJ+i4RtFXsSfkb2qwjIAnpZ3UJGODvpMtnpNoXGtQBpmu
   uD+M3x7WHClEj4dvgwLALWkP0nlcopQc7J41IjFf2gZUBxcUP5dflIENy
   52u8dVTx6cGpLSK/9KPiXZpvKVIL+3mYZsC+CAGFE141fQFSJpPvd8Dqv
   Nutig1NB33GJ5Qpx/jHZtchohkVq3Ymt90eQbSKV0J7Lol1lPUPeUD8Lr
   JfcTryOsjidpnGP/+8+XccmxqXO2NlYhbFLgyv5IRfL7e0ypBJSuC+ec8
   JmX9uOMHPz1stN66AxLBOygmMZu2j54Lb8Ng6FVJL17hPDEuzYuWWAVzu
   g==;
IronPort-SDR: mPaiPAvfuO336j2JYe3X5+J/RqYWrkRY5wrunoBCtxx2CApNbZzN4J3KAHcRnWu0F+yyO/AF9k
 XHilXETVggcdtsKIhOhS8yJdr/08LfOWfBwgdSECqI5RhM/1I6xnWYL0sqmoFPZ/ZskLD/QqXm
 2EyXGWl0qjxbQ21VfERnLW0nvphWKrnCBGwLzUR7SeoNgdHg+1tQ1Xt6PMkBSiIiJkN7A/93zt
 1p5ycz/j/w5vURnUKrCJytgAS01upnJ2ZqRPXKCK7NHWkSynLajoYtqbMIWMh5jdFkx6zf63nn
 U1c=
X-IronPort-AV: E=Sophos;i="5.81,216,1610380800"; 
   d="scan'208";a="165623460"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2021 17:13:15 +0800
IronPort-SDR: yKXriEGLZc2UVAnVcXdHxvJ7GrOTTbdmULA01Qf8AGT5hpTWRforVMq0vKVoPXEBDstbAFfCKd
 tlxGb3zFNfztPbuKk/vKZuKdPFbDD7E0MyITkqZAmv3C+jgixBCBG81j+WAeK5SZEFjet93Inn
 PdM19KqrGa9ZpWa6yjXzQojLsEeQ0DaThbIWc2pJtlx9uJ4Y3Qgq6Vk62K+SD0YfAAQiRJqxU5
 EAB6Tpfmx+cYek66VdEgtMrhjy8N49v8D9RzYImVqEFFvgQDzwF93vz3pn8Ys+ShWpL2cFznHM
 sRVGV5MhpVVowYnjCw5UZcWz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:54:31 -0800
IronPort-SDR: N4jZOJUBUEuSuEFIDGDGh70ydIvN7xt7F8awvZyfiHrgpU97FH6+cTGBM3GLqMqDDDtfVRK7Bv
 9ULLEOid25v+C9Chg1Yg/mXIlLujMgB205VLETr2kt15P4c0hx85cYVnzu23ot7vTfMjgN8s2/
 dp354yviEAH5VsBNUZQtKpPFnOYbfDAJxOnYzNX7rQiir7LVx/kjyONjwK54wOdaK+SY6W10pn
 PkeqCUIlY4LW3SWR6FSSj/ZJYsf8v9kK98ieyiljWmZHtjpJWKd6djsHGT8jtZPsv902kQX8cd
 ukw=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2021 01:13:16 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] btrfs: require discard functionality from scratch device
Date:   Tue,  2 Mar 2021 18:13:05 +0900
Message-Id: <20210302091305.27828-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some test cases for btrfs require the scratch device to support discard.
Check if the scratch device does support discard before trying to execute
the test.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc       | 8 ++++++++
 tests/btrfs/116 | 1 +
 tests/btrfs/156 | 1 +
 3 files changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index 7254130ffe22..9fca7f31d6a2 100644
--- a/common/rc
+++ b/common/rc
@@ -3513,6 +3513,14 @@ _require_batched_discard()
 	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
 }
 
+_require_scratch_discard()
+{
+	local sdev="$(_short_dev $SCRATCH_DEV)"
+	local discard=$(cat /sys/block/$sdev/queue/discard_granularity)
+
+	[ $discard -gt 0 ] || _notrun "discard not supported"
+}
+
 _require_dumpe2fs()
 {
 	if [ -z "$DUMPE2FS_PROG" ]; then
diff --git a/tests/btrfs/116 b/tests/btrfs/116
index 3ed097eccf03..f4db439caef8 100755
--- a/tests/btrfs/116
+++ b/tests/btrfs/116
@@ -29,6 +29,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_scratch_discard
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 89c80e7161e2..56206d99c801 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -42,6 +42,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _require_scratch
 _require_fstrim
+_require_scratch_discard
 
 # 1024fs size
 fs_size=$((1024 * 1024 * 1024))
-- 
2.30.0

