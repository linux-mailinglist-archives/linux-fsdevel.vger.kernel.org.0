Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4A312726
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBGTHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:07:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42837 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBGTHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612724826; x=1644260826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/sU16hyrajvlrgbsNAHlb0pAxwxEoMR2N8xqIOC5Bzw=;
  b=IlSvpcgsf5xMpaTId9WLF92FMxEIR6V5Qzr9DM7/0scTpq+kKDsz/frr
   1d5L6fDa43o2kkEgbhvcS7NWXu/kRNLhajAhtgvWNifcwE1P3rqtADH8h
   0O768kWmVFBp+oGMVnxA7iZyyebNwWP1TvYORR0TGcUqLtm4/G+Yvmv9v
   KYjX4r4QI8yBZeQnre3/QE+lQUOMl8kwEAWF0D0MVzR8RtH293sYln+0o
   XL8esizqJMqcUlcGvQj/e/6JXSH+JiN3cpWRaxpnc29/T6Hs6T4zJPe1V
   vHHPng4BMRm61ePOR92lNef7i+EBakB4cHdo9aaea4gLHe37db1Xa3aTj
   g==;
IronPort-SDR: s6ShBjTAjmrKNqAkshbBgjTbIJSsZgaOcaZdxGLhcvIoLVv4vHkrE91rX+WY+jNhsFUYBPpJlY
 mi145DmVuG2E1DA/ty1fbx8DL+R0OPCfUrA2WLM4THcXy8dWdXshp+EsgLgeAF1MjfH06WkOUZ
 Wt2JVm85Y1CaulW88xGPbrPtG1elCgeHjJ37Yksu/zkISr2NO3LxGKIjbF/Ov+Oxx06U8f7z9K
 S1BlhGTwlVNoofkmBEC3lc54Af9X4ZZM1NWEpXkptEbbJ5MU8LZsD8P2rDYuPXd9YTDiB16sft
 mAQ=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="159383150"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:05:58 +0800
IronPort-SDR: MIa54v5F2BKt7tb5J7OKkJ7hyuv1pTwFeboCPPYNTWzZWf2RVBBjDIs1fYowaBLhr+YD5dzuWZ
 Mi3zc0fI66FHXKGIx4g1keCq9/cdZskbeBT1Fpo80CKAzjdPcF567jMHeiFYn4HnvFye9ci6Uo
 dao1KPowoUFC/cTTvccsWrc6NY0I8uJJCuj5icMdYC++ZavDuizfey+2yfhQEWJHc/p+guN8lD
 +eq9FN2vTChhPAKiZF4F+EqiJYmzRMFieN9lep1kcCrnXFP1SXPApn8H223NFEMXbNYYzLq+Ma
 YNvrO86bJQeJgvtLhArMk7FX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:47:54 -0800
IronPort-SDR: Fh0a8KOx8UaWk2LjpLfdutmd2ZUZW4sTiB+72pFPwJmhQv9cItQK4N4vh6QK1NTzhF2pNQ2OQX
 ek/hhLyR9dj/BahvaXDLEkuILAf/UIf19rwag54p+32immh2DiQpUSJrcb5f/xx2eQS90p2Xp7
 Z/mNQDvFZUBz4EGwOtn/urCM1pO9tHUayhheIx7bB1AaDLfK2huaALMv7a0fnTRBE5ttLKIhl7
 32xqGxR0tsvTklF7k0y2ddxPy0Pct+UY5PvBXkbrm5prRkgWzo8U6vI3ViIKd4YZXu9DTfWuQC
 f5c=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:05:58 -0800
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
Subject: [RFC PATCH 7/8] f2fs: use memcpy_from_page() in pagecache_read()
Date:   Sun,  7 Feb 2021 11:04:24 -0800
Message-Id: <20210207190425.38107-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/f2fs/verity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 054ec852b5ea..44e057bdc416 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -47,16 +47,13 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *addr;
 
 		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
 					 NULL);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		addr = kmap_atomic(page);
-		memcpy(buf, addr + offset_in_page(pos), n);
-		kunmap_atomic(addr);
+		memcpy_from_page(buf, page, offset_in_page(pos), n);
 
 		put_page(page);
 
-- 
2.22.1

