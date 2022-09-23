Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8815E7A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiIWMIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiIWMGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:06:17 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A212E405;
        Fri, 23 Sep 2022 05:04:13 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 24D1D2173;
        Fri, 23 Sep 2022 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663934523;
        bh=HQaCzeBKpccvY70lsjed2nvSDJHxgVGfg13R2geTI/w=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=LntRzvxz7J1PUnPuEb4bLzDGOGTK/Gi1LahXwe3mc+/cnAh1OW+LNWtWlEYLvozMI
         AfQ6FN8qBuwQoABxow96QWGjGXVeUTXVYVQBmCtc9KWHjpUaobwUb3ntHQK4/u5LnN
         AHauGE6uDnP7HwhmKAqgPWAkS7PZhnoYxu9u/8Sc=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 23 Sep 2022 15:04:11 +0300
Message-ID: <69396296-95d3-9c85-35ff-530e2a84066a@paragon-software.com>
Date:   Fri, 23 Sep 2022 15:04:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 2/2] fs/ntfs3: Rename variables and add comment
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <91c21f32-cc6f-2c2e-ebf7-d1d738090aef@paragon-software.com>
In-Reply-To: <91c21f32-cc6f-2c2e-ebf7-d1d738090aef@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After renaming we don't need to split code in two lines.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c |  1 +
  fs/ntfs3/fslog.c   | 24 +++++++++++-------------
  2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b752d83cf460..179b06762bdb 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3265,6 +3265,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
  			modified = true;
  		}
  
+		/* std attribute is always in primary MFT record. */
  		if (modified)
  			ni->mi.dirty = true;
  
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index e7c494005122..200e22b7871d 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3048,7 +3048,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
  	struct NEW_ATTRIBUTE_SIZES *new_sz;
  	struct ATTR_FILE_NAME *fname;
  	struct OpenAttr *oa, *oa2;
-	u32 nsize, t32, asize, used, esize, bmp_off, bmp_bits;
+	u32 nsize, t32, asize, used, esize, off, bits;
  	u16 id, id2;
  	u32 record_size = sbi->record_size;
  	u64 t64;
@@ -3635,30 +3635,28 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
  		break;
  
  	case SetBitsInNonresidentBitMap:
-		bmp_off =
-			le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
-		bmp_bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
+		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
+		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
  
-		if (cbo + (bmp_off + 7) / 8 > lco ||
-		    cbo + ((bmp_off + bmp_bits + 7) / 8) > lco) {
+		if (cbo + (off + 7) / 8 > lco ||
+		    cbo + ((off + bits + 7) / 8) > lco) {
  			goto dirty_vol;
  		}
  
-		__bitmap_set(Add2Ptr(buffer_le, roff), bmp_off, bmp_bits);
+		__bitmap_set(Add2Ptr(buffer_le, roff), off, bits);
  		a_dirty = true;
  		break;
  
  	case ClearBitsInNonresidentBitMap:
-		bmp_off =
-			le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
-		bmp_bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
+		off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
+		bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
  
-		if (cbo + (bmp_off + 7) / 8 > lco ||
-		    cbo + ((bmp_off + bmp_bits + 7) / 8) > lco) {
+		if (cbo + (off + 7) / 8 > lco ||
+		    cbo + ((off + bits + 7) / 8) > lco) {
  			goto dirty_vol;
  		}
  
-		__bitmap_clear(Add2Ptr(buffer_le, roff), bmp_off, bmp_bits);
+		__bitmap_clear(Add2Ptr(buffer_le, roff), off, bits);
  		a_dirty = true;
  		break;
  
-- 
2.37.0


