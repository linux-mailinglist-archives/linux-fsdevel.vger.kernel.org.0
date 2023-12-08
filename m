Return-Path: <linux-fsdevel+bounces-5315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E397080A359
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584F4280CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD781C698
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fA3uF2D9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D7171F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1702034869;
	bh=nUoXBiMK9GjTeJ57U1BCOL/XGHy02XwaHGE2p0xi2K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fA3uF2D9D2RfCPyAcfM+TW1mq/iGRjca4TUGIZBETcNSa6g/MvI4M/PociiIEZaXO
	 UK3mvI/QZ6pK0Qcwngom6uqHDSu3B1RBd7nb+aMI0/A5tkNYCZ8WZzPDWKfsBQ1A+6
	 tbwSMwq69FZHxiREPDnbOd7azalpa3BgkNk8OH1c=
Received: from localhost.localdomain ([180.164.182.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 530B9A94; Fri, 08 Dec 2023 19:20:48 +0800
X-QQ-mid: xmsmtpt1702034497tl7orebkx
Message-ID: <tencent_777CD22FC5C304A635264E8F5D6653C7FC09@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9lBseoUVoM6+7sWh/JjCRu9axUiEM516VajAtc0l5bwBWWVDAwK
	 pOwNTPz7cYHMBJplVc7myNRMYlmNh4bL1el6+RzMcIk2A1u6Ts7CB7680DQnYts2ktoa0Lau1nOj
	 Wg41JibmCxoOg8FxpXkkQv3p9Xb6HjzLcUlhoh/WN6Hd7dXYOmrxZ9ewzmmcuOdYRaLuoO3yL9aH
	 knSnbfbI1VWmAkGqFKFlF5+rvfL6SbsenlVkvccxCJJknFOwJ5+ndJgvfqzAjOpGmGGVh8lYO1st
	 /mV9x2tPcNocpJvkB8jat33ylEEGaLkf7y2TATo+dj3Ub+T8F9tiSdBON68wxjjFsJujQG9hgNnC
	 nTO0Fw36JouHspAQXeCgBaYx+FD0rbw00EsDMCS9qm2LCVftzwdZlAXZQUSKy2aChUPDpdBP3EiL
	 q82CDhpDZ22S4jZSYXhXVqStKCWQLj1ocJjvTj1SI/TrNdICcPfCRrA1M9OIr8utWnwlpfns2OLC
	 OVVhOJdT4ZMdQZPQxr2cM9og1h1Wv8vGiQY+McVuAJatAG7zS40v6P6F2eGcbfsvncklXeRAa2pd
	 G+l4dCV+uKwbQgQqWoD5XK22AZS0wpXxg7+tct4hrpGfudhBn4yCOzMMMnDZXgNOAsQ4BBDvQWVa
	 sDArSFxxmwkOfv1/Q7yw1UlLD2wNCnJ/bpAXmCdrG7i9Y9a5dS44lm9aW1uhRNgez3FdW4zaNd8z
	 4rKI0iXNXuO+j0H9x3gfCexC33hRQYUKAxnLl0vZpK3vmffp+ugOObK5DWO6BHavN5cKaPXQs+my
	 qDystvnvge3E4ec0vLIv8wEoskHbKxW4fejBfp8HPNmvj6aIL47DAJNwSjEFvVB1tTnWsWs+T5Ci
	 O0hBRtNvQHlLMzr4xd2l2obk/L3M5zdObS5n7+7tQKdQ37LHRRyqC6MBYH3M8Uq2NvTRqBneHxnI
	 4Xe6JjTmFIM+lNvNf6jYC/WtgjQ/q5
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: yuezhang.mo@foxmail.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	wataru.aoyama@sony.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1 06/11] exfat: move free cluster out of exfat_init_ext_entry()
Date: Fri,  8 Dec 2023 19:23:15 +0800
X-OQ-MSGID: <20231208112318.1135649-7-yuezhang.mo@foxmail.com>
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

exfat_init_ext_entry() is an init function, it's a bit strange
to free cluster in it. And the argument 'inode' will be removed
from exfat_init_ext_entry(). So this commit changes to free the
cluster in exfat_remove_entries().

Code refinement, no functional changes.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Andy Wu <Andy.Wu@sony.com>
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
---
 fs/exfat/dir.c   | 3 ---
 fs/exfat/namei.c | 5 +++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 2a002b01f1dc..8965bb2c99ae 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -564,9 +564,6 @@ int exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
 		if (!ep)
 			return -EIO;
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
-			exfat_free_benign_secondary_clusters(inode, ep);
-
 		exfat_init_name_entry(ep, uniname);
 		exfat_update_bh(bh, sync);
 		brelse(bh);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 6a85b6707a7e..9a0d8f2deea6 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1065,12 +1065,13 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			epold->dentry.file.attr |= cpu_to_le16(EXFAT_ATTR_ARCHIVE);
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
+
+		exfat_remove_entries(inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
+
 		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
 			num_new_entries, p_uniname);
 		if (ret)
 			goto put_old_es;
-
-		exfat_remove_entries(inode, &old_es, num_new_entries);
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
-- 
2.25.1


