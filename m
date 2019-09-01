Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A929A47CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 07:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfIAFxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 01:53:40 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com ([98.137.69.32]:37178 "EHLO
        sonic316-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfIAFxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 01:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567317219; bh=kc+jedtmoECzNbCxq+nXpkl3ladCNpEIXX/cyggBQYg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GvP/AX1C4J1uMQFRwtfetI0r6XcrtZf1PEzg0Qh5NyGMPgnDp1k8dc3PLaePCyx1IMBC+e35jb3Ey4FdzqIwwF1sErp8MdPA9NMJIbQentaNarUjC1fVv/tH1ft3/swgHO1Yf9G2n4xxEkOON2uFICzD4YDt0/M4G6AKaU+wBNDUu0UH0+cEv9a4BqK9A6cc+0epMnwvoMDy2NSn/RHwI5sxfvSqOoUgAyHIizuHAWFvlrCH17IF1Z5c5Dq45jNkewqU1vZXIxaRJFITGqeKI7mEsLxt4bgnfeyhzC9yuIPwpaH57oK/IafdHthDcGI2c0a/C4/jyOS/3SVDpvTB/w==
X-YMail-OSG: 5Lqg_UwVM1nS91RGNddPh6.cu3jrZ2lmqxmsfB8rLjBGX4AuyhmWDRV1f4.L16h
 ntYge0xZIR0egY86xwZKuX8DDOYsUXjGZaWQvJqrFwBIDVhsqaK3cB.wm4MkGbS7cuohZYsgddaJ
 TFcsi4WY_sI.WBJgXukWssjk.q6gzOsmKID5RIR6r4FWbzDWY7FQ36qeYEkUdeQWM_8llOF8Wfez
 7lWKZJTwmewsUdHPo3F4uQEv796JoP.Lj.4tuVJ_UqOZK6oOv_hnT.RVchZziw.tZMyT2JaYsx.0
 VNK5i.V05BxDC2fGnaY37s5LJeuQUIO6Y3xF9Ym9QUq08kvTDsf6lcAtPgRYtfq8nP1TEyFSChP6
 pZbl_iVhoEQ2DnKBiktZwrh0muXOPQrlr3gAr3pM1tBrzFDOD.E6ceAdUpU_yCVvkzCujPB2iuA4
 W.lM27bVGnRNcQBgeOyEWBxgTF5boVO7vVwmCvhtdQqW6fmySbk8xXWg3EVqQqMrne1n9mHE.x_U
 VhBr.y95RUbCF.2jZc0iSWeNAN0wuwUEaK7J9CSuH4HVbVmiKJJQ.Hm0ApjrFxoZ5_0FCDlXiVBA
 5c4WVRbIfm37Yrc4_G9AvlpV0uJb_j68HvAjcwbkgfGyK5QtUZ7U3d9tv54bWA8hkkrqcsVOQ3pD
 Cq8eVxIZPJN1.YuYCGoNH3S3sD.f8HtBga7EKiDx.JBitSScfwfkaxSsnsO_fT7pKyyCKxOi_kdY
 WrTvXUR7qAcS03Hc8gLprMfsBmLC.KAe7SJMa5xQeKUEc.Pul3aiApt4hYC9ctazugrRUAOe2iQK
 6_PtSu.g_diD_lg0890bmmQykk.ZxyI0.1qNdApvELVq8k5wkucXEXft9O5yMxaz.gJhObXVNq2M
 B9jKqKLMXfVGG2iqQdbkWgL5CFtpFNQytrhXP8ikF9Y3gOxmAdU4wsumx1VbY_mGlEiKYom4Lf8E
 2pFpBGKRltQ8dk1SP5xKlu1_NKs6b9k0UHVoqnpLVmQh8ZcyXAvyVBXqbn2Z6O.TJM5piBCdAxvt
 ayvKW5Y6AXNlscvFzHymaK24nCo4s3k7Fl_TMZktOxnZxApBgw5PD0UBtsh8sz06JpIZ4m7WrvVC
 Dm.xvHJL59taEl2xbr2.Rs9w4sfYHlsERIEPX9gUj7BvLMZRQ8rCruf9CE9z0P_gWKhO.jQr26kc
 M9JLVDW4D1jnF0agbpaQs6T8ROe6xq.oU6HIMqMrx9Als5qr36qNUQPLk71jcOu5gfz8b7kOTmNk
 b0YmjabLH6E5fPHvcxmbhaC_P.uD38KGtF9wnAO3E9Xopd1YcTt0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:39 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426e3b5ec1af9e36f409445c51071a70;
          Sun, 01 Sep 2019 05:53:36 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 21/21] erofs: save one level of indentation
Date:   Sun,  1 Sep 2019 13:51:30 +0800
Message-Id: <20190901055130.30572-22-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph said [1], ".. and save one
level of indentation."

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index fcc16d2d10cb..ee39b32bb911 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -188,41 +188,42 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	data = page_address(page);
 
 	err = erofs_read_inode(inode, data + ofs);
-	if (!err) {
-		/* setup the new inode */
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFREG:
-			inode->i_op = &erofs_generic_iops;
-			inode->i_fop = &generic_ro_fops;
-			break;
-		case S_IFDIR:
-			inode->i_op = &erofs_dir_iops;
-			inode->i_fop = &erofs_dir_fops;
-			break;
-		case S_IFLNK:
-			err = erofs_fill_symlink(inode, data, ofs);
-			if (err)
-				goto out_unlock;
-			inode_nohighmem(inode);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-		case S_IFIFO:
-		case S_IFSOCK:
-			inode->i_op = &erofs_generic_iops;
-			init_special_inode(inode, inode->i_mode, inode->i_rdev);
-			goto out_unlock;
-		default:
-			err = -EFSCORRUPTED;
+	if (err)
+		goto out_unlock;
+
+	/* setup the new inode */
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &erofs_generic_iops;
+		inode->i_fop = &generic_ro_fops;
+		break;
+	case S_IFDIR:
+		inode->i_op = &erofs_dir_iops;
+		inode->i_fop = &erofs_dir_fops;
+		break;
+	case S_IFLNK:
+		err = erofs_fill_symlink(inode, data, ofs);
+		if (err)
 			goto out_unlock;
-		}
+		inode_nohighmem(inode);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_op = &erofs_generic_iops;
+		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		goto out_unlock;
+	default:
+		err = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 
-		if (erofs_inode_is_data_compressed(vi->datamode)) {
-			err = z_erofs_fill_inode(inode);
-			goto out_unlock;
-		}
-		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	if (erofs_inode_is_data_compressed(vi->datamode)) {
+		err = z_erofs_fill_inode(inode);
+		goto out_unlock;
 	}
+	inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 out_unlock:
 	unlock_page(page);
-- 
2.17.1

