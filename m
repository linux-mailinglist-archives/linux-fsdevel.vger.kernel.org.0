Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D95598B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiFXLnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiFXLnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:43:37 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415956B8E9;
        Fri, 24 Jun 2022 04:43:36 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D2D4A1D74;
        Fri, 24 Jun 2022 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656070962;
        bh=jv8IdGOGdSV+GhBlmZH3D981qwEa6lnf2CV+RS8Qun8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=cs2pRmj4hHeDGugH7QMgS4CAwyL7jmc1Zxf2L9ukSfkgcYMbT9DpQdBh14zZsJ+NP
         o1Bs8GwodApcz+3hS3AKUxHLE/WfI5AekmkKisrr+16PXje5lCsM/uGzeOr5YPQ/4W
         f7npjFKOURAJV59/V1t+steK9zkHjYNNuBltfGak=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2696321AE;
        Fri, 24 Jun 2022 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1656071014;
        bh=jv8IdGOGdSV+GhBlmZH3D981qwEa6lnf2CV+RS8Qun8=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=OO91RV3uS4o/8xpumPvG41UwwVp9JQ2SoTUPSNimzWvaOsYwKKwJcb3Xa5OWFzKJx
         5DL87edX6S7KOVQIye0A/HaJIlLH3mZY1JzX8DE3ty3uLOHZ1efRBfaeo96bAQEeXM
         JVdPv+/gp+vFnvzBnfWskEqKaohF7xt1b69rhF6I=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Jun 2022 14:43:33 +0300
Message-ID: <2e519232-6cc9-f9be-af78-c14d84c7f31f@paragon-software.com>
Date:   Fri, 24 Jun 2022 14:43:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH 3/3] fs/ntfs3: extend ni_insert_nonresident to return inserted
 ATTR_LIST_ENTRY
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
In-Reply-To: <f76c96bb-fdea-e1e5-5f47-c092af5fe556@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes xfstest generic/300
Fixes: 4534a70b7056 ("fs/ntfs3: Add headers and misc files")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 35 +++++++++++++++++++++--------------
  fs/ntfs3/frecord.c |  4 ++--
  fs/ntfs3/index.c   |  2 +-
  fs/ntfs3/ntfs_fs.h |  2 +-
  4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 3bd51cf4d8bd..65a5f651a4a2 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -320,7 +320,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
  
  	err = ni_insert_nonresident(ni, attr_s->type, attr_name(attr_s),
  				    attr_s->name_len, run, 0, alen,
-				    attr_s->flags, &attr, NULL);
+				    attr_s->flags, &attr, NULL, NULL);
  	if (err)
  		goto out3;
  
@@ -637,7 +637,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
  		/* Insert new attribute segment. */
  		err = ni_insert_nonresident(ni, type, name, name_len, run,
  					    next_svcn, vcn - next_svcn,
-					    attr_b->flags, &attr, &mi);
+					    attr_b->flags, &attr, &mi, NULL);
  		if (err)
  			goto out;
  
@@ -855,7 +855,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  		goto out;
  	}
  
-	asize = le64_to_cpu(attr_b->nres.alloc_size) >> sbi->cluster_bits;
+	asize = le64_to_cpu(attr_b->nres.alloc_size) >> cluster_bits;
  	if (vcn >= asize) {
  		err = -EINVAL;
  		goto out;
@@ -1047,7 +1047,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
  	if (evcn1 > next_svcn) {
  		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
  					    next_svcn, evcn1 - next_svcn,
-					    attr_b->flags, &attr, &mi);
+					    attr_b->flags, &attr, &mi, NULL);
  		if (err)
  			goto out;
  	}
@@ -1647,7 +1647,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
  	if (evcn1 > next_svcn) {
  		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
  					    next_svcn, evcn1 - next_svcn,
-					    attr_b->flags, &attr, &mi);
+					    attr_b->flags, &attr, &mi, NULL);
  		if (err)
  			goto out;
  	}
@@ -1812,18 +1812,12 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  				err = ni_insert_nonresident(
  					ni, ATTR_DATA, NULL, 0, run, next_svcn,
  					evcn1 - eat - next_svcn, a_flags, &attr,
-					&mi);
+					&mi, &le);
  				if (err)
  					goto out;
  
  				/* Layout of records maybe changed. */
  				attr_b = NULL;
-				le = al_find_ex(ni, NULL, ATTR_DATA, NULL, 0,
-						&next_svcn);
-				if (!le) {
-					err = -EINVAL;
-					goto out;
-				}
  			}
  
  			/* Free all allocated memory. */
@@ -1936,9 +1930,10 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  	struct ATTRIB *attr = NULL, *attr_b;
  	struct ATTR_LIST_ENTRY *le, *le_b;
  	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, vcn, len, end, alen, dealloc;
+	CLST svcn, evcn1, vcn, len, end, alen, dealloc, next_svcn;
  	u64 total_size, alloc_size;
  	u32 mask;
+	__le16 a_flags;
  
  	if (!bytes)
  		return 0;
@@ -2001,6 +1996,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  
  	svcn = le64_to_cpu(attr_b->nres.svcn);
  	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
+	a_flags = attr_b->flags;
  
  	if (svcn <= vcn && vcn < evcn1) {
  		attr = attr_b;
@@ -2048,6 +2044,17 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
  			err = mi_pack_runs(mi, attr, run, evcn1 - svcn);
  			if (err)
  				goto out;
+			next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
+			if (next_svcn < evcn1) {
+				err = ni_insert_nonresident(ni, ATTR_DATA, NULL,
+							    0, run, next_svcn,
+							    evcn1 - next_svcn,
+							    a_flags, &attr, &mi,
+							    &le);
+				if (err)
+					goto out;
+				/* Layout of records maybe changed. */
+			}
  		}
  		/* Free all allocated memory. */
  		run_truncate(run, 0);
@@ -2248,7 +2255,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
  	if (next_svcn < evcn1 + len) {
  		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
  					    next_svcn, evcn1 + len - next_svcn,
-					    a_flags, NULL, NULL);
+					    a_flags, NULL, NULL, NULL);
  		if (err)
  			goto out;
  	}
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3576268ee0a1..64041152fd98 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1406,7 +1406,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			  const __le16 *name, u8 name_len,
  			  const struct runs_tree *run, CLST svcn, CLST len,
  			  __le16 flags, struct ATTRIB **new_attr,
-			  struct mft_inode **mi)
+			  struct mft_inode **mi, struct ATTR_LIST_ENTRY **le)
  {
  	int err;
  	CLST plen;
@@ -1439,7 +1439,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
  	}
  
  	err = ni_insert_attr(ni, type, name, name_len, asize, name_off, svcn,
-			     &attr, mi, NULL);
+			     &attr, mi, le);
  
  	if (err)
  		goto out;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 8468cca5d54d..803dc49269e4 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1347,7 +1347,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
  		goto out;
  
  	err = ni_insert_nonresident(ni, ATTR_ALLOC, in->name, in->name_len,
-				    &run, 0, len, 0, &alloc, NULL);
+				    &run, 0, len, 0, &alloc, NULL, NULL);
  	if (err)
  		goto out1;
  
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 6e758ebdc011..1c504ef7dbe4 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -530,7 +530,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
  			  const __le16 *name, u8 name_len,
  			  const struct runs_tree *run, CLST svcn, CLST len,
  			  __le16 flags, struct ATTRIB **new_attr,
-			  struct mft_inode **mi);
+			  struct mft_inode **mi, struct ATTR_LIST_ENTRY **le);
  int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
  		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
  		       struct ATTRIB **new_attr, struct mft_inode **mi,
-- 
2.36.1


