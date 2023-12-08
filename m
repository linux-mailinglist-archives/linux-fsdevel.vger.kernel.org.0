Return-Path: <linux-fsdevel+bounces-5309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB880A34A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A571C208EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1419478
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mjoU/Opw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3110DA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034489;
	bh=fBjHqqL/688Jd+q4DnrxTJF34FfawJT5VyX8pOqIxdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjoU/Opw0ENKROLjc4OhH8Kh+FY5jfxuHqQFIFOjM71X/r/yqLMohUJT3KA2YZlkK
	 hbeFMX38CdiYHHjf/1BpZwD6hsfv8lU3bN/FgCbmw10AQiC245D2b/pbj8FUj00cPr
	 yRFa8enhEr1FhcKRc1hKFYGGY++Y0D8NWsJUdqI0=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034451tylabw18y
Message-ID: <tencent_7DD31A2AA74D2EFCA9667E52E9D7E2CB0208@qq.com>
X-QQ-XMAILINFO: NwIPvWX4YDagzLBgX/1LcAFo6QsPqXfyFfZtRjxizTcySoZIMMp8/TIdCoEcQX
	 spkh9OZMntSvYTu9NjmgxS0y5ME4CPccRL80MywKeM6bjNnSdUq9pEXh4R+LAyxkG7TEt+je6FdW
	 uGO6OoqI/Q6UR8UCkDVOIstMpCrK/d8fAVBkhwJl6ysua62626v5CPjpjEhECUAcq1o8TzbDz71N
	 cpnHu9WMQEDd5r4/5aWRmrvA3C+aCwZ+S0ZdDcVN7dY9V76CIWuPPB2Isa/vXlUpYn3DCrD1wbIB
	 bIhZ4MyDug9Hmi1eKtSB7+81NTVDDkPOQ5w+kDuq3vc5xPYj4GMYlVkxw+1r4L/FUBVQGkvRMzYG
	 lEvkHcPzy+v2gCXhE3956MkG00tsrC+6ACBSPJB/sWuj1C4WkXzzURKcmO2jFQFikT4oHx21D1rm
	 ZoOPtAmHzIO+rvdasoEKa77MHH/QAw93D8Y1k0QVIiQKC5FpXxa8uJiOvtSbgCCFFs/FuqA/Kik4
	 qLSKcQznkZV3RV6CrZcTvMgebwaShhVMdfY80q85rq9ZknnfIQn//eltrI/smAjoIWwPmxb5NOMQ
	 2YTnNFot1X+w7Mdd1MnDeJCnxngbb4o5F6PAd7FII/fyDWch2hqWCy5SE6UIr+6zPvLrdt4T6bZ9
	 eya7z1RcaqgvFThzlkUx0QIRSwKblkh0Qf/aQinHqjpPobMvHkFOE2Gw1l0UNNAt70yvDAGObUE9
	 HzmiMLpVt6exrz6iLp89M9OV3diBK7c9HuYYLcOKWDJkxeVJPqVCHIg8dJDOYJPQe/io3WE4Nq/W
	 KLJvo7HLsSUuwOH777d89uQ5152LT2pz1QCxjjsi8QvtIIMDwlF/m9VYb6UrCautEArkTxyIvzk1
	 /VAqFkfpazd7Ao2L/v24GOa3R/8PbGN9DUcpVGsZHOtdYoxO4hFpCWk6xhHvz+b3tMPy620XHVvH
	 ON1TfQIokPrlm9SxPG47EFH2h95HI3
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 01/11] exfat: add __exfat_get_dentry_set() helper
Date: Fri,  8 Dec 2023 19:23:10 +0800
X-OQ-MSGID: <20231208112318.1135649-2-yuezhang.mo@foxmail.com>
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

Since exfat_get_dentry_set() invokes the validate functions of
exfat_validate_entry(), it only supports getting a directory
entry set of an existing file, doesn't support getting an empty
entry set.

To remove the limitation, add this helper.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c | 61 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 9f9295847a4e..f33e40aad276 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -775,7 +775,6 @@ struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 }
 
 enum exfat_validate_dentry_mode {
-	ES_MODE_STARTED,
 	ES_MODE_GET_FILE_ENTRY,
 	ES_MODE_GET_STRM_ENTRY,
 	ES_MODE_GET_NAME_ENTRY,
@@ -790,11 +789,6 @@ static bool exfat_validate_entry(unsigned int type,
 		return false;
 
 	switch (*mode) {
-	case ES_MODE_STARTED:
-		if  (type != TYPE_FILE && type != TYPE_DIR)
-			return false;
-		*mode = ES_MODE_GET_FILE_ENTRY;
-		break;
 	case ES_MODE_GET_FILE_ENTRY:
 		if (type != TYPE_STREAM)
 			return false;
@@ -834,7 +828,7 @@ struct exfat_dentry *exfat_get_dentry_cached(
 }
 
 /*
- * Returns a set of dentries for a file or dir.
+ * Returns a set of dentries.
  *
  * Note It provides a direct pointer to bh->data via exfat_get_dentry_cached().
  * User should call exfat_get_dentry_set() after setting 'modified' to apply
@@ -842,22 +836,24 @@ struct exfat_dentry *exfat_get_dentry_cached(
  *
  * in:
  *   sb+p_dir+entry: indicates a file/dir
- *   type:  specifies how many dentries should be included.
+ *   num_entries: specifies how many dentries should be included.
+ *                It will be set to es->num_entries if it is not 0.
+ *                If num_entries is 0, es->num_entries will be obtained
+ *                from the first dentry.
+ * out:
+ *   es: pointer of entry set on success.
  * return:
- *   pointer of entry set on success,
- *   NULL on failure.
+ *   0 on success
+ *   < 0 on failure
  */
-int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
+static int __exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		struct super_block *sb, struct exfat_chain *p_dir, int entry,
-		unsigned int type)
+		unsigned int num_entries)
 {
 	int ret, i, num_bh;
 	unsigned int off;
 	sector_t sec;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct exfat_dentry *ep;
-	int num_entries;
-	enum exfat_validate_dentry_mode mode = ES_MODE_STARTED;
 	struct buffer_head *bh;
 
 	if (p_dir->dir == DIR_DELETED) {
@@ -880,12 +876,16 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		return -EIO;
 	es->bh[es->num_bh++] = bh;
 
-	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
-	if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
-		goto put_es;
+	if (num_entries == ES_ALL_ENTRIES) {
+		struct exfat_dentry *ep;
+
+		ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
+		if (ep->type == EXFAT_FILE)
+			num_entries = ep->dentry.file.num_ext + 1;
+		else
+			goto put_es;
+	}
 
-	num_entries = type == ES_ALL_ENTRIES ?
-		ep->dentry.file.num_ext + 1 : type;
 	es->num_entries = num_entries;
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
@@ -918,8 +918,27 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		es->bh[es->num_bh++] = bh;
 	}
 
+	return 0;
+
+put_es:
+	exfat_put_dentry_set(es, false);
+	return -EIO;
+}
+
+int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
+		struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, unsigned int type)
+{
+	int ret, i;
+	struct exfat_dentry *ep;
+	enum exfat_validate_dentry_mode mode = ES_MODE_GET_FILE_ENTRY;
+
+	ret = __exfat_get_dentry_set(es, sb, p_dir, entry, type);
+	if (ret < 0)
+		return ret;
+
 	/* validate cached dentries */
-	for (i = ES_IDX_STREAM; i < num_entries; i++) {
+	for (i = ES_IDX_STREAM; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
 			goto put_es;
-- 
2.25.1


