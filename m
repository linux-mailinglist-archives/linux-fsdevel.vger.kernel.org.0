Return-Path: <linux-fsdevel+bounces-5313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AF80A353
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CA11F213B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCAD1C6B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="acOekIFX"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 03:27:51 PST
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC01728
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034869;
	bh=TDEZcW+cN/QurCXzzKrh9Kdn/eQHaLdTHk6ikecN9jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=acOekIFXudarl2rCUh66HxQ/SyQzrq7dHqh0dlrZyxhcPC2jk47RCiL63kG5t9gv0
	 c+fu8QhXYyPjqDeFuhBqY4vQo/Qc/YZUME7DSbt6cPz0L03023tDZnTdoAqasWtvpr
	 LrZUUfYIHQZtzSdRiuTKBiCUqU2W7xZg1ccFeDa0=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034488tqmn5g0kc
Message-ID: <tencent_ACDA02351A05A74A2E0CA9617EC5E960E208@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ57SBF37mfK0Skp1T+DiVBWvWEqWx5AvkzQ8rGN7wzc2g5MjxXN6n
	 ZwVaU9VmUp5GZmFXcd4Ze66Lk+XLRtp/ueAlwK4PyefjYylWq31MCN7JeFKdT8DPCY/4IMixqwr2
	 V7pwl2pZyzGm5Y2vXFxdInjAvIdgm7OOCu3wBhtKtMYXln5kJMxAAVNc9irIoNLxkL1MIRNbXqHj
	 3uV7NReOa3vAEnfG0w4BwRrWKt9hd7vu5I+VTZcmOgup4+Ei4Rr82+sdAGFkl5AqWIQ34xwEmg8t
	 LnqheWPNA815dfs4w/tYlt8x/CcL4HJdcV2qtaJoKLc5ozBptc/M/1PnCkTIYiLyq/wzQEcxLmK3
	 DgU2JHunVTsUuC7TN6Iztqrot2dcW7wdNQ/pN18TFE9s09tqni1hLT/MFphTson/krJid6Zg9GuY
	 OuM9EkM0k0qUszm8MUQ2THKQjXHrlLS0i4O305iJVWX3t9kU0hnDnAIwk6xM64IJt89VDFoBYEpu
	 aF8bTcH2H9Eorycz9citpHYcXvMUpCKej+uDiJeXrpeCcjZpBPr5jnGRWJ2iKsogVa9bYE0MEqNi
	 Os3o2NwtZ1WVoAQ7qdICOEJpctIYmYLhwNj/Yic5pxh0HWaixwemogowb1HXsu7d0SIgF+h1mbTX
	 ncBywhOszIImr8D8vZGmsSgLZQLMIN6aUYaBPyW8v6Q6fsNnae3pP7c7UtWjBnGKNzfnvIKI3/zU
	 2NrOHL4BkL8Qrs3mjK+yTitaAGcL6c4XrJaHFo1PxhTHO6BTcwkVpmckAmPuWrnd7PyMiFk4W3aq
	 /HlxU93Sxhqg5WMMPMtpXgtm5LNrmCFuf+fH2039Pj+avibkxHPdww+K0iQ5kWGdiuwxU4ETgisT
	 cfTWfR4wmp+fb2BsSDy5EgfXSattiRvxiD9/GfUwuevrbT1LdSqohGlYlt9L+QjJN21r3+jK6IFL
	 e6jgBxeSpMPIKRkwFX8x+cMlVC1MLtJw2bTBeuWSlT0UDA7nUXho+8h/vmCNtW
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 02/11] exfat: add exfat_get_empty_dentry_set() helper
Date: Fri,  8 Dec 2023 19:23:11 +0800
X-OQ-MSGID: <20231208112318.1135649-3-yuezhang.mo@foxmail.com>
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

This helper is used to lookup empty dentry set. If there are
enough empty dentries at the input location, this helper will
return the number of dentries that need to be skipped for the
next lookup.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c      | 77 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index f33e40aad276..bb23585c6e7c 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -950,6 +950,83 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 	return -EIO;
 }
 
+static int exfat_validate_empty_dentry_set(struct exfat_entry_set_cache *es)
+{
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+	int i, off;
+	bool unused_hit = false;
+
+	for (i = 0; i < es->num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		if (ep->type == EXFAT_UNUSED)
+			unused_hit = true;
+		else if (IS_EXFAT_DELETED(ep->type)) {
+			if (unused_hit)
+				goto out;
+		} else {
+			if (unused_hit)
+				goto out;
+
+			i++;
+			goto count_skip_entries;
+		}
+	}
+
+	return 0;
+
+out:
+	off = es->start_off + (i << DENTRY_SIZE_BITS);
+	bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
+
+	exfat_fs_error(es->sb,
+		"in sector %lld, dentry %d should be unused, but 0x%x",
+		bh->b_blocknr, off >> DENTRY_SIZE_BITS, ep->type);
+
+	return -EIO;
+
+count_skip_entries:
+	es->num_entries = EXFAT_B_TO_DEN(EXFAT_BLK_TO_B(es->num_bh, es->sb) - es->start_off);
+	for (; i < es->num_entries; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		if (IS_EXFAT_DELETED(ep->type))
+			break;
+	}
+
+	return i;
+}
+
+/*
+ * Get an empty dentry set.
+ *
+ * in:
+ *   sb+p_dir+entry: indicates the empty dentry location
+ *   num_entries: specifies how many empty dentries should be included.
+ * out:
+ *   es: pointer of empty dentry set on success.
+ * return:
+ *   0   : on success
+ *   >= 0: the dentries are not empty, the return value is the number of
+ *         dentries to be skipped for the next lookup.
+ *   <0  : on failure
+ */
+int exfat_get_empty_dentry_set(struct exfat_entry_set_cache *es,
+		struct super_block *sb, struct exfat_chain *p_dir,
+		int entry, unsigned int num_entries)
+{
+	int ret;
+
+	ret = __exfat_get_dentry_set(es, sb, p_dir, entry, num_entries);
+	if (ret < 0)
+		return ret;
+
+	ret = exfat_validate_empty_dentry_set(es);
+	if (ret)
+		exfat_put_dentry_set(es, false);
+
+	return ret;
+}
+
 static inline void exfat_reset_empty_hint(struct exfat_hint_femp *hint_femp)
 {
 	hint_femp->eidx = EXFAT_HINT_NONE;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index e3b1f8e022df..6dc76b3f4945 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -502,6 +502,9 @@ struct exfat_dentry *exfat_get_dentry_cached(struct exfat_entry_set_cache *es,
 int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 		struct super_block *sb, struct exfat_chain *p_dir, int entry,
 		unsigned int type);
+int exfat_get_empty_dentry_set(struct exfat_entry_set_cache *es,
+		struct super_block *sb, struct exfat_chain *p_dir, int entry,
+		unsigned int num_entries);
 int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
 
-- 
2.25.1


