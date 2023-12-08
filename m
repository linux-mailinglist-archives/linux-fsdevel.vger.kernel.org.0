Return-Path: <linux-fsdevel+bounces-5317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3DF80A35C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA69281253
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A51C68F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="u2DBbl8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2156F10DA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034880;
	bh=4GBoC0gYPldUjUEGpilpruyOmY/wrXDXA2dEFhgCO2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u2DBbl8KBGS8XktnaVcZl0EBJbffcBCgantODOY1BFY7esm7Y6VCy3B8kbdAtCSiN
	 Lir6rJuNhx4YSGbEIndpiA1OZFg6aKPTSERIwLa1uH5tl55K9dN6fQ1IDLZ6LDZG1U
	 N4UfCK4vxbQMMJq9355GH87umV0FfJu5RETZtFsA=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034503te7cs98g6
Message-ID: <tencent_B02EBA3CA542FA85A57F88CF08EC6A189C0A@qq.com>
X-QQ-XMAILINFO: MFWpArBVhhGT0AaG2QyKGAXauDJzuTNtMN/SuQSJEUUOr9cpFAniT0CuljEzTr
	 XOf9zP8RIAbr07KJrEeyTir0Yf73r4SuauhxJAtQ3qmEIpSxTwLW/h54eFv/jJznlOeq0uqdwrXJ
	 0FDvhQ9FeDQuIfQFOlWl/LFphQ4YIKfw7h47jKpN++zKNplZUZS/ViRLlkGLTPjkf3YLQlmEjC/c
	 Q/14qcG+6ezPN178zLTbHQE4RaADnb1TDvjBAFXe4l9b6jZ9yz1Gz5WywDvsVZfnuK0lygmZj1FB
	 Ni57YPwvu8EjXQdp8sC4DgwResykt3iRIaNV4v4uuyeWTC5QA3NSyalbAgpDIK8ZoDxUWLXd5WM8
	 DqFSVvluqqmc1jpUrn9p7xUxPy4pZn5ozmJhVlT1AJREkchTn1rS5pifX5oZ97TVDCQEdoZYBNJh
	 7ZywCvUVYEMQEbijhQi+RtZL9/iQvyHPHizBzRAvBfFtx1bKz7r76jBFKOfL/6H9JO4GY1oeyTlG
	 FU2KNaVdOjrNcm9zoNEGtiwhsIV+T7MHfbbMWk0znUFUOwdaqYruAkRtiRoUd5HWS6YUuAtovcqx
	 8Gwqf2iqGOymT95TNbO3yauOlM+POmNgLnDF89PO+jLZGq1V94IfhWuDOuF92bBYWnUxMxzF19nk
	 QLZVWzNvhNhI0iJa7qrGwBGPDjWmp+MbTfAhngCueedcAV1VhTSQ3CWdqRyfVt2v4u85i2bsnwbL
	 QLSYuBzkB7ddiBUc0FxntPD0scg9A5Dht6O4R1C2BIYJ3gYV+6q9vUkysG2bmDQRtiSPBBX8NN8j
	 Sgm65lv8PiWRxFzBo5vLBMKtJrvkw8MqGTfJ+ogylGJcj7v78+zHKKt/MUt4mtSihQ8QAd8VqwVW
	 +XlidOszP8R20+jRmmrfaAv0vdoOYNQTvpLW554qyc3GDWjhgqm6FJzMPFzyiUatSiKgC8ujDggl
	 w4T+zp5ajxoGQq/fIJlFCOmCdenboGrcDViefv4s3HqVWJq/zv7ipsrn0TlnGoMa0i0x9/L0s=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 09/11] exfat: remove unused functions
Date: Fri,  8 Dec 2023 19:23:18 +0800
X-OQ-MSGID: <20231208112318.1135649-10-yuezhang.mo@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208112318.1135649-1-yuezhang.mo@foxmail.com>
References: <20231208112318.1135649-1-yuezhang.mo@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

exfat_count_ext_entries() is no longer called, remove it.
exfat_update_dir_chksum() is no longer called, remove it and
rename exfat_update_dir_chksum_with_entry_set() to it.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c      | 60 ++-------------------------------------------
 fs/exfat/exfat_fs.h |  6 +----
 fs/exfat/inode.c    |  2 +-
 3 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 94cedc145291..c57a727d5285 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -478,41 +478,6 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 	exfat_init_stream_entry(ep, start_clu, size);
 }
 
-int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
-		int entry)
-{
-	struct super_block *sb = inode->i_sb;
-	int ret = 0;
-	int i, num_entries;
-	u16 chksum;
-	struct exfat_dentry *ep, *fep;
-	struct buffer_head *fbh, *bh;
-
-	fep = exfat_get_dentry(sb, p_dir, entry, &fbh);
-	if (!fep)
-		return -EIO;
-
-	num_entries = fep->dentry.file.num_ext + 1;
-	chksum = exfat_calc_chksum16(fep, DENTRY_SIZE, 0, CS_DIR_ENTRY);
-
-	for (i = 1; i < num_entries; i++) {
-		ep = exfat_get_dentry(sb, p_dir, entry + i, &bh);
-		if (!ep) {
-			ret = -EIO;
-			goto release_fbh;
-		}
-		chksum = exfat_calc_chksum16(ep, DENTRY_SIZE, chksum,
-				CS_DEFAULT);
-		brelse(bh);
-	}
-
-	fep->dentry.file.checksum = cpu_to_le16(chksum);
-	exfat_update_bh(fbh, IS_DIRSYNC(inode));
-release_fbh:
-	brelse(fbh);
-	return ret;
-}
-
 static void exfat_free_benign_secondary_clusters(struct inode *inode,
 		struct exfat_dentry *ep)
 {
@@ -552,7 +517,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
-	exfat_update_dir_chksum_with_entry_set(es);
+	exfat_update_dir_chksum(es);
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
@@ -574,7 +539,7 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 		es->modified = true;
 }
 
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
+void exfat_update_dir_chksum(struct exfat_entry_set_cache *es)
 {
 	int chksum_type = CS_DIR_ENTRY, i;
 	unsigned short chksum = 0;
@@ -1237,27 +1202,6 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 	return dentry - num_ext;
 }
 
-int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
-		int entry, struct exfat_dentry *ep)
-{
-	int i, count = 0;
-	unsigned int type;
-	struct exfat_dentry *ext_ep;
-	struct buffer_head *bh;
-
-	for (i = 0, entry++; i < ep->dentry.file.num_ext; i++, entry++) {
-		ext_ep = exfat_get_dentry(sb, p_dir, entry, &bh);
-		if (!ext_ep)
-			return -EIO;
-
-		type = exfat_get_entry_type(ext_ep);
-		brelse(bh);
-		if (type & TYPE_CRITICAL_SEC || type & TYPE_BENIGN_SEC)
-			count++;
-	}
-	return count;
-}
-
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 {
 	int i, count = 0;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 0280a975586c..a2c70b3a27bd 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -431,8 +431,6 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		unsigned int *content);
 int exfat_ent_set(struct super_block *sb, unsigned int loc,
 		unsigned int content);
-int exfat_count_ext_entries(struct super_block *sb, struct exfat_chain *p_dir,
-		int entry, struct exfat_dentry *p_entry);
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		unsigned int len);
 int exfat_zeroed_cluster(struct inode *dir, unsigned int clu);
@@ -487,9 +485,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 		struct exfat_uni_name *p_uniname);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 		int order);
-int exfat_update_dir_chksum(struct inode *inode, struct exfat_chain *p_dir,
-		int entry);
-void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es);
+void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 522edcbb2ce4..0614bccfbe76 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -94,7 +94,7 @@ int __exfat_write_inode(struct inode *inode, int sync)
 		ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
 	}
 
-	exfat_update_dir_chksum_with_entry_set(&es);
+	exfat_update_dir_chksum(&es);
 	return exfat_put_dentry_set(&es, sync);
 }
 
-- 
2.25.1


