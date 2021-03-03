Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78AB32C4F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355091AbhCDASq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31108 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451362AbhCCGDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614751379; x=1646287379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rJBaxnWWvl+K1CTo7fGZgrtTmx1xOutkeMIExgBhjHM=;
  b=QCfH+VpUJ8brh/4S8aREt4YwHUZY3FpVYu6M8QWaYSeVexqA93oBroPK
   ComMLBYOCTD1lhfmKcm0SEwA0YP1eu6layLbiQhB0Fk+43GCY5alXKAw8
   pLOItDNH0rdw6qmTpaFr6JBxK3hCV1CjeUJJB6pp1TtX3uhED3qwDYfEN
   RLp2BIHp9XfrMWi//vj7zHdU8PFVHuVfQEmAYC5SzunDWj2n7BX5IyEab
   3caNEvFZ3bpAAK+i4r5hsWSldiccKTVnsWK7QOesM4jPJS/eCzCjcRluO
   1phuTtpUEHsAGjInOkw9t9UUwAMa7DawNG8ojPCBqdqYxnxAqC5qDRlPU
   Q==;
IronPort-SDR: RgfBQx1zOQaryAgyLBNTVdeD33i7FegMQQc00/JVW54okaiYj7I3WtcWdO/wA7nsPMPy6Vdhew
 BG/Tbln+5XvJR/M3lLhjU7d+OQpmczXDPFx1gNZ+WLBQLX1VG3Vik/R23NlzSJxHeKgWu07cMh
 9l4JyfPPZ8+BJLrqGieogN9hVIVeDqFWhXsKnbAk379wnruOKspPRdXr2wHET/NbFvKtPhAm06
 gvsA/SiuWL0dXLQt/pliGFaQTtbB0P5gFXu8u/QphOmw6E4bJeZQ7v3fPoct1YVSnIJOU3ek5U
 ESU=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="161241995"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 14:01:54 +0800
IronPort-SDR: MNTofaKaCZh70LKpfByYN5USj65dMrZoeM6gh0YvgZmgtifEqQeibEUOSx3tcAtaG7Km0xoeCu
 h74TwUrUzJbUyyQyL0K8JFKiis4O0gppRdeUT+dX6OtdKOSV42h6pNiJHM8NJIBPdfP7zcvhXq
 f0245Rm3PslA23GT15i+ko1O0xWETjPlZdVOTi6vANZgqysMJJmKmmvsgfXLOSe1iMwWB5OISl
 LoQcJ2G87QOCpcTEIpXvMSiTE0gf3oAiWfMijyrTFtG3h6kn1TsJNXLItgWTHsU5KO5vzeNx2D
 Uzxupoz4y9RtxhE0fIJjtbNI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:43:09 -0800
IronPort-SDR: DMFS7Z2dyHAno26ORbp4IAf03tDAjRNVqIWyGwf7gE3toAChurUBS/7BYZ5PCupbtOEhy/FZaR
 cM9cLiBIPAnzJfcZw7TH8zJNNoWN14YSPvN6FTPp6hu6bbNtJ94Vqv2ovAKkutwSv81ZvdtrcA
 9y+cD7cbOg3myqDBGbh/YEJX0UPG23+x8d0uYoWd55r6I746TeAmyfJRcY7EPrkTFKDzNQCPaO
 V2aueWJGvgZTgB42qukxYmCogpq88MLCcthMZajox/gtXJe/z/FuZfQWKLv04pZk4JaH2PbdcZ
 EFo=
WDCIronportException: Internal
Received: from bksm5s2.ad.shared (HELO naota-xeon) ([10.225.49.22])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:01:54 -0800
Date:   Wed, 3 Mar 2021 15:01:52 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: add missing checks of fallocate feature
Message-ID: <20210303060152.r2xi46ke6bpfifyk@naota-xeon>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
 <20210302091305.27828-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302091305.27828-2-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 02, 2021 at 06:13:04PM +0900, Johannes Thumshirn wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> Many test cases use xfs_io -c 'falloc' but forgot to add
> _require_xfs_io_command "falloc". This will fail the test case if we run
> the test case on a file system without fallcoate support e.g. F2FS ZZ
>

The sentences between "This will " .. "e.g. F2FS ZZ" should be removed.
# Vim command leaked to the log ... oops.

> While we believe that normal fallocate(mode = 0) is always supported on
> Linux, it is not true. Fallocate is disabled in several implementations of
> zoned block support for file systems because the pre-allocated region will
> break the sequential writing rule.
> 
> Currently, several test cases unconditionally call fallocate(). Let's add
> _require_xfs_io_command "falloc" to properly check the feature is supported
> by a testing file system.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  tests/btrfs/013   | 1 +
>  tests/btrfs/016   | 1 +
>  tests/btrfs/025   | 1 +
>  tests/btrfs/034   | 1 +
>  tests/btrfs/037   | 1 +
>  tests/btrfs/046   | 1 +
>  tests/btrfs/107   | 1 +
>  tests/ext4/001    | 1 +
>  tests/f2fs/001    | 1 +
>  tests/generic/456 | 1 +
>  tests/xfs/042     | 1 +
>  tests/xfs/114     | 1 +
>  tests/xfs/118     | 1 +
>  tests/xfs/331     | 1 +
>  tests/xfs/341     | 1 +
>  tests/xfs/342     | 1 +
>  tests/xfs/423     | 1 +
>  17 files changed, 17 insertions(+)
> 
> diff --git a/tests/btrfs/013 b/tests/btrfs/013
> index 9252c82a2076..5e03ed4a4b4b 100755
> --- a/tests/btrfs/013
> +++ b/tests/btrfs/013
> @@ -33,6 +33,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
>  # real QA test starts here
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/btrfs/016 b/tests/btrfs/016
> index 8fd237cbdb64..015ec17f93d6 100755
> --- a/tests/btrfs/016
> +++ b/tests/btrfs/016
> @@ -35,6 +35,7 @@ _supported_fs btrfs
>  _require_test
>  _require_scratch
>  _require_fssum
> +_require_xfs_io_command "falloc"
>  
>  _scratch_mkfs > /dev/null 2>&1
>  
> diff --git a/tests/btrfs/025 b/tests/btrfs/025
> index 42cd7cefe825..5c8140552bfb 100755
> --- a/tests/btrfs/025
> +++ b/tests/btrfs/025
> @@ -31,6 +31,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/btrfs/034 b/tests/btrfs/034
> index bc7a4aae3886..07c84c347d3b 100755
> --- a/tests/btrfs/034
> +++ b/tests/btrfs/034
> @@ -28,6 +28,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/btrfs/037 b/tests/btrfs/037
> index 1cfaf5be58c8..9ef199a93413 100755
> --- a/tests/btrfs/037
> +++ b/tests/btrfs/037
> @@ -35,6 +35,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/btrfs/046 b/tests/btrfs/046
> index 882db8eacc4e..a1d82e1cdd54 100755
> --- a/tests/btrfs/046
> +++ b/tests/btrfs/046
> @@ -37,6 +37,7 @@ _cleanup()
>  _supported_fs btrfs
>  _require_test
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  _require_fssum
>  
>  rm -f $seqres.full
> diff --git a/tests/btrfs/107 b/tests/btrfs/107
> index e57c9dead499..80db5ab9822d 100755
> --- a/tests/btrfs/107
> +++ b/tests/btrfs/107
> @@ -34,6 +34,7 @@ rm -f $seqres.full
>  
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  
>  # Use 64K file size to match any sectorsize
>  # And with a unaligned tailing range to ensure it will be at least 2 pages
> diff --git a/tests/ext4/001 b/tests/ext4/001
> index bbb74f1ea5bc..9650303d15b5 100755
> --- a/tests/ext4/001
> +++ b/tests/ext4/001
> @@ -29,6 +29,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
>  
>  # real QA test starts here
>  _supported_fs ext4
> +_require_xfs_io_command "falloc"
>  _require_xfs_io_command "fzero"
>  _require_test
>  
> diff --git a/tests/f2fs/001 b/tests/f2fs/001
> index 98bd2682d60f..0753a09b5576 100755
> --- a/tests/f2fs/001
> +++ b/tests/f2fs/001
> @@ -36,6 +36,7 @@ _cleanup()
>  
>  _supported_fs f2fs
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  
>  testfile=$SCRATCH_MNT/testfile
>  dummyfile=$SCRATCH_MNT/dummyfile
> diff --git a/tests/generic/456 b/tests/generic/456
> index 2f9df5e5edc4..65667d449dd3 100755
> --- a/tests/generic/456
> +++ b/tests/generic/456
> @@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # real QA test starts here
>  _supported_fs generic
>  _require_scratch
> +_require_xfs_io_command "falloc"
>  _require_dm_target flakey
>  _require_xfs_io_command "falloc" "-k"
>  _require_xfs_io_command "fzero"
> diff --git a/tests/xfs/042 b/tests/xfs/042
> index b55d642c5170..fcd5181cf590 100755
> --- a/tests/xfs/042
> +++ b/tests/xfs/042
> @@ -31,6 +31,7 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
>  
>  # real QA test starts here
>  _supported_fs xfs
> +_require_xfs_io_command "falloc"
>  
>  _require_scratch
>  
> diff --git a/tests/xfs/114 b/tests/xfs/114
> index b936452461c6..3f5575a61dfb 100755
> --- a/tests/xfs/114
> +++ b/tests/xfs/114
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs xfs
>  _require_test_program "punch-alternating"
>  _require_xfs_scratch_rmapbt
> +_require_xfs_io_command "falloc"
>  _require_xfs_io_command "fcollapse"
>  _require_xfs_io_command "finsert"
>  
> diff --git a/tests/xfs/118 b/tests/xfs/118
> index 5e23617b39dd..9a431821aa62 100755
> --- a/tests/xfs/118
> +++ b/tests/xfs/118
> @@ -41,6 +41,7 @@ _supported_fs xfs
>  
>  _require_scratch
>  _require_command "$XFS_FSR_PROG" "xfs_fsr"
> +_require_xfs_io_command "falloc"
>  
>  # 50M
>  _scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
> diff --git a/tests/xfs/331 b/tests/xfs/331
> index 4ea54e2a534b..8e92b2e36a8d 100755
> --- a/tests/xfs/331
> +++ b/tests/xfs/331
> @@ -33,6 +33,7 @@ _require_xfs_scratch_rmapbt
>  _require_scratch_reflink
>  _require_xfs_io_command "falloc"
>  _require_test_program "punch-alternating"
> +_require_xfs_io_command "falloc"
>  
>  rm -f "$seqres.full"
>  
> diff --git a/tests/xfs/341 b/tests/xfs/341
> index e1fbe588d9eb..8bf05087e1ba 100755
> --- a/tests/xfs/341
> +++ b/tests/xfs/341
> @@ -31,6 +31,7 @@ _require_realtime
>  _require_xfs_scratch_rmapbt
>  _require_test_program "punch-alternating"
>  _disable_dmesg_check
> +_require_xfs_io_command "falloc"
>  
>  rm -f "$seqres.full"
>  
> diff --git a/tests/xfs/342 b/tests/xfs/342
> index 2be5f7698f01..4db222d65fb2 100755
> --- a/tests/xfs/342
> +++ b/tests/xfs/342
> @@ -30,6 +30,7 @@ _supported_fs xfs
>  _require_realtime
>  _require_xfs_scratch_rmapbt
>  _require_test_program "punch-alternating"
> +_require_xfs_io_command "falloc"
>  
>  rm -f "$seqres.full"
>  
> diff --git a/tests/xfs/423 b/tests/xfs/423
> index 8d51a9a60585..183c9cf5eded 100755
> --- a/tests/xfs/423
> +++ b/tests/xfs/423
> @@ -35,6 +35,7 @@ _cleanup()
>  _supported_fs xfs
>  _require_test_program "punch-alternating"
>  _require_xfs_io_command "scrub"
> +_require_xfs_io_command "falloc"
>  _require_scratch
>  
>  echo "Format and populate"
> -- 
> 2.30.0
> 
