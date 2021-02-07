Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D631270F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBGTFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:05:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38248 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhBGTFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612725610; x=1644261610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w6zlqoB4qKT1nXBrbOhQGOcEIB8ZlcLodmo+qNAVwo8=;
  b=o+37OtkrKRVa5bxJiQ87njX57fSJYvT/6ZP8mKa5QnwjcOK90zMixs1e
   m4HrxIYf3iRH7D4RoP280KXONEPH7bXy/IODxRRR03i5jGgwmBzcdEaZ8
   s2V88ye1uVcCx1bCVa7AqkT14Ul1AyYra9qNrKM7E9wrre5GMfKsaHO34
   y0n5Ar76LaHAhBNiKzNCsIxPIR19mUbstwLXZqdKN8R+T7zDdBfAWEfC2
   neEIiwDRCH7sPr+iaEJGQ04fzDOPp1JQQqIGKm8n8uaHLJrEi2tDn4aMp
   Pw9ulvzGQxAY3lnUxDAQMln5wKcPPspXkCEWPJnoUiAc4TblhwXLLtlly
   A==;
IronPort-SDR: d5EScVApKXNDCq/9I3Mq9wGHfo/OLkUEVparbqej4wCwVNUuq9sEvXD12cy0koLfItg6KyYfBN
 KThsCSO1h1tQ6NO4QPM3PJpnMOa96e9IdQ3QXMkiiaESYTGfwdGr25KkhApWlM/3QcH3U1I15U
 nIyBXma9XpXGCMERkMMtXNK/tpFStKJx6ef5sIlanzxUtjpKXLkQ/n7riyKWD85+RrlrPZyYRo
 uJiwXfbWvPulcWFf9j8Mfe321g6i0+12472JRBj0SIRB94m3N0SZICTG2KHZQYmCNJXMZMapUV
 7nc=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="263497349"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:18:30 +0800
IronPort-SDR: LE0IRDX7sLF2oxSnyUgA80MuzBxgVWZH4VYL7IIQATUiC07U9UyIq5OrcscwraV1AmgtEHeKF9
 SNVK9jvoXRb+6tjev9pzwB78Es09R2fWNxV/N7VKcyG1vOq5uqKZidWPKZESmvxm8NXj164f0g
 YBOumcTQZHHP5akeu84IuyEoR1WwDA/z3AHsKqd/F2OZF+CbkaXpgzPlWjfQyWW5dWm658zBEI
 NySdWWdtTmYyTTAvs5JzLaPXbo1wrEiGgC6WkbaYLvBIdE8E2jwGlPOIqOFU7wTEOyoxwuPgB6
 19F1Q3cM9zkfV8D2QP2DXApx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:48:22 -0800
IronPort-SDR: G5UkKRJXYnZF6S2td3KTLC+tstktMSOx5USrJ/8vqHVbIEJIIqHE54GblQXzzWDKDkJYqqMIm8
 /grFclx6OokLW8XLT0EahhHRmjldgbrOtSVmPY2iDCY5Jwp+My9e1mLwkFllm9yHbk9+aju3il
 15LQnCcS+ED+Ppe8kNeaBlIGJhrSuXnC4oBjsWuwx0fM688vkAbf9ysIyG2UljqmNHOexojEFr
 /H6RbprJtDTtcF2llfZVRwZ4x57vttCqniYZ/8MvLzgQIKhpwqYUiaZvOJJ8ufVCYjb+mvKwd7
 3Os=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:04:28 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, bvanassche@acm.org,
        chaitanya.kulkarni@wdc.com, dongli.zhang@oracle.com, clm@fb.com,
        ira.weiny@intel.com, dsterba@suse.com, ebiggers@kernel.org,
        hch@infradead.org, dave.hansen@intel.com
Subject: [RFC PATCH 0/8] use core page calls instead of kmaps
Date:   Sun,  7 Feb 2021 11:04:17 -0800
Message-Id: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This RFC is based on the discussion going on the linux-fsdevel [1].

I've tested this on the brd and null_blk. The fio verify job seems to
run without any error on the top of the original series applied [1].

Any feedback is welcome to move this forward.

-ck

[1] https://lore.kernel.org/linux-fsdevel/20210205232304.1670522-1-ira.weiny@intel.com/T/#m53145c155fa3631595594877da96a3a75b71e909

Chaitanya Kulkarni (8):
  brd: use memcpy_from_page() in copy_from_brd()
  brd: use memcpy_from_page() in copy_from_brd()
  null_blk: use memcpy_page() in copy_to_nullb()
  null_blk: use memcpy_page() in copy_from_nullb()
  ext4: use memcpy_from_page() in pagecache_read()
  ext4: use memcpy_to_page() in pagecache_write()
  f2fs: use memcpy_from_page() in pagecache_read()
  f2fs: use memcpy_to_page() in pagecache_write()

 drivers/block/brd.c           | 17 ++++++-----------
 drivers/block/null_blk/main.c | 23 ++++++-----------------
 fs/ext4/verity.c              | 10 ++--------
 fs/f2fs/verity.c              | 10 ++--------
 4 files changed, 16 insertions(+), 44 deletions(-)

-- 
2.22.1

