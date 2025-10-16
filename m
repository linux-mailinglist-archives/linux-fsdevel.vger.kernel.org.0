Return-Path: <linux-fsdevel+bounces-64363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6556FBE3384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B5F1A64280
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3F31D398;
	Thu, 16 Oct 2025 12:04:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5502727F5;
	Thu, 16 Oct 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616271; cv=none; b=W+emzVJOCtJdrfOxpCKSCWGFCNhdMPgOx7R4S8m6m6stFV1eKgH678mq0TWWqTU+ysebAPKwwB+ssQPImXDpHFuK5nJHhFL4CUWxZJNhyZLuuJjIRJ0qteSyDrNbUnMWvcGzEqyjJvq5Lnu//7jIawO8RAEAU13okXUvLxF+5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616271; c=relaxed/simple;
	bh=GfMvBuRPu2U/8L9l1xaD/b5zEdFhLlLj7Y4SCyzQOh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SxrRkw7gMydUlDBD8UPAHulmd+sY0ql/HlrvPZIeIHlndh3qHfveowP7EDd8CRn0KtOVxsSL9BfNzkK2yyMfqqjcLTnLwxzvbpNa8iSWI92K0iaP8yx7YWrylySpjuT0ZtphuKG9jSX/aNiRMhFw6MK8m3i0wvKEFlpM5nknNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cfbc168aa8811f0a38c85956e01ac42-20251016
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4fda0ac9-d3ba-4e53-9134-f2d02d531496,IP:15,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-INFO: VERSION:1.3.6,REQID:4fda0ac9-d3ba-4e53-9134-f2d02d531496,IP:15,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-50
X-CID-META: VersionHash:a9d874c,CLOUDID:b20b19e2422d0212c105edcaca3d4655,BulkI
	D:251016200416GA5QH87Q,BulkQuantity:0,Recheck:0,SF:10|24|38|44|66|78|102|8
	50,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3cfbc168aa8811f0a38c85956e01ac42-20251016
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1282000596; Thu, 16 Oct 2025 20:04:16 +0800
From: Can Peng <pengcan@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH 1/1] init/initramfs_test: add NULL check after kmalloc
Date: Thu, 16 Oct 2025 20:02:47 +0800
Message-Id: <20251016120247.373515-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocation may return NULL on failure. Add NULL pointer check
after kmalloc() to prevent kernel NULL pointer dereference.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 init/initramfs_test.c | 54 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 5d2db455e60c..7a1386df98a5 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -102,7 +102,16 @@ static void __init initramfs_test_extract(struct kunit *test)
 	/* +3 to cater for any 4-byte end-alignment */
 	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
+	if (!cpio_srcbuf) {
+		KUNIT_FAIL(test, "Failed to allocate cpio buffer");
+		return;
+	}
+
 	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	if (len == 0) {
+		KUNIT_FAIL(test, "Failed to fill cpio");
+		goto out;
+	}
 
 	ktime_get_real_ts64(&ts_before);
 	err = unpack_to_rootfs(cpio_srcbuf, len);
@@ -173,6 +182,11 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 	 * are already available (e.g. no compression).
 	 */
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + PATH_MAX + 3, GFP_KERNEL);
+	if (!cpio_srcbuf) {
+		KUNIT_FAIL(test, "kmalloc failed for cpio_srcbuf");
+		return;
+	}
+
 	memset(cpio_srcbuf, 'B', CPIO_HDRLEN + PATH_MAX + 3);
 	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
 	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
@@ -218,6 +232,10 @@ static void __init initramfs_test_data(struct kunit *test)
 	/* +6 for max name and data 4-byte padding */
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
 			      GFP_KERNEL);
+	if (!cpio_srcbuf) {
+		KUNIT_FAIL(test, "kmalloc failed for cpio_srcbuf");
+		return;
+	}
 
 	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
 
@@ -273,8 +291,16 @@ static void __init initramfs_test_csum(struct kunit *test)
 	} };
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
+	if (!cpio_srcbuf) {
+		KUNIT_FAIL(test, "kmalloc failed for cpio_srcbuf");
+		return;
+	}
 
 	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	if (len == 0) {
+		KUNIT_FAIL(test, "Failed to fill cpio");
+		goto out;
+	}
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -295,6 +321,8 @@ static void __init initramfs_test_csum(struct kunit *test)
 	 */
 	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
 	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), -ENOENT);
+
+out:
 	kfree(cpio_srcbuf);
 }
 
@@ -329,8 +357,16 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 	} };
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
+	if (!cpio_srcbuf) {
+		KUNIT_FAIL(test, "kmalloc failed for cpio_srcbuf");
+		return;
+	}
 
 	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	if (len == 0) {
+		KUNIT_FAIL(test, "Failed to fill cpio");
+		goto out;
+	}
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -344,6 +380,7 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
 	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
 
+out:
 	kfree(cpio_srcbuf);
 }
 
@@ -358,7 +395,13 @@ static void __init initramfs_test_many(struct kunit *test)
 	char thispath[INITRAMFS_TEST_MANY_PATH_MAX];
 	int i;
 
-	p = cpio_srcbuf = kmalloc(len, GFP_KERNEL);
+	cpio_srcbuf = kmalloc(len, GFP_KERNEL);
+	if (!cpio_srcbuf) {
+		KUNIT_FAIL(test, "kmalloc failed for cpio_srcbuf");
+		return;
+	}
+
+	p = cpio_srcbuf;
 
 	for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
 		struct initramfs_test_cpio c = {
@@ -403,7 +446,14 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	struct test_fname_pad {
 		char padded_fname[4096 - CPIO_HDRLEN];
 		char cpio_srcbuf[CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)];
-	} *tbufs = kzalloc(sizeof(struct test_fname_pad), GFP_KERNEL);
+	} *tbufs;
+
+	tbufs = kzalloc(sizeof(struct test_fname_pad), GFP_KERNEL);
+	if (!tbufs) {
+		KUNIT_FAIL(test, "Failed to allocate memory for tbufs");
+		return;
+	}
+
 	struct initramfs_test_cpio c[] = { {
 		.magic = "070701",
 		.ino = 1,
-- 
2.25.1


