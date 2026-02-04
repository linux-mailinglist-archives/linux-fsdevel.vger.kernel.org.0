Return-Path: <linux-fsdevel+bounces-76274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF2sKeEEg2njggMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:35:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B037E333C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4313045A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ECF39446C;
	Wed,  4 Feb 2026 08:33:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC11393DF9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194003; cv=none; b=nOCRnSgJd1i9um3yiY5ryQD4qlMTG48CHaSBOKv+cWtvMooU3ybEfevsvCDdB6FJFGAvoSwvVd5o4mR58SWsSBTKidcUtzNZacECi+rGLP8DJPSrJjP/xr1qeVOO7xDLGobsEZ/fHY1yLQdsap5R9kMr0lDj4Td8+M11UbfkmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194003; c=relaxed/simple;
	bh=kbcOV/6QcQXosOVb/kYnmczZIIbazol1Xw4so2doLDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjfsY4MPHHVt5+8Oc1gwwFd6ya2XbBC2XhiwUWmhRfkAivAbnv4B+pkXIacAR8sA5xLWXZ9Kmi1kK4bc7OFGvmvquPMkLkRA4lF6QSZG1G9L69rJXNInH2/LOyASQHjpGNKXzAknHItIhJ1OIUYmWfAFRVueOFBkjJSyKPjN0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6c45a843f7so157111a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 00:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770194002; x=1770798802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgV//1wifMQx8DWc1kqJsH8XCVKk4uWaLyVeoKmarPQ=;
        b=hCkVuULIzzrQyT+ZVf3Q/ARoCbAsB9ygw9eGWrmYasen9zsFyeM5y3SVSIqGgs/8IK
         cZ7AR3fQ0B360UfTcy5MXqHCnretSGiL8zWzdyQL3GprG7xHh2OdSSiV6ykg06l1aMu5
         lzNq9WJCrw6QwOiKkXVPbxd6576d9mKjD3O86VXWrSV+hei4VmQali1xMrWl+P+NF00e
         JM6TI3H1wKpnZw2NwuCu4JwlNQ9yb9cxDtGw2UjgweW837uFEfl3WwXvbpPpFxwUUV2D
         d1kMrW6ICxClpaXUDiwKyBHvo+klbw1Y7Ghr0pM32cjO4E+8fVwr6C6168EEXdtH7MBm
         2bBg==
X-Gm-Message-State: AOJu0YwcZ7P2WETJJOYcF3D9ltAULm44sXp/Y6yG8Mvg/0w6GH5m1hKf
	wHL3ZGksbwk3BNjkwfEz5kBm+OnYft2CARCV0sYoBTbL3uoptYem+LNP
X-Gm-Gg: AZuq6aJNiL5fv1D/tGx/e+eAX58DLZS7jyPfpyLaCeBPmVqZU9o8vA2UcbKr72b4ORf
	g5Sjhjs3ZUnBv0guER4PaEHz2BKQUl9ngN0doZpas49AqefJZ5PA3kza9deTkfBrpueevkXOpBx
	uGgvmUIB6dqaGwrVQ5nwl8MdbdmSK3LPozAQ88rAiR2y2VUwalf/bOn8f2qODVuN0obFTt7UHf/
	dKTD60OdrhqerNvhRfaJUJZXu/UI7o+XnuSb4Q3dM2Tb0bQ3mBuMF0U1js1ESEspMo2duQU0wj9
	lnGc6xgn1brL2HroiH+Wrdj+vve7CGFV/Oztc4WeI0Be0P4VB3MVRnrP+OjnJsmnbAdrU6a4hky
	hcHnpL8ZIo+xsxq/IvAYK/jVDFJQSRC0WKxW/FlRJwdvc4DZgSd7F1Pxhr6XQfsl5w8Y4AbXjcE
	A2U6qkbwcyN2q2kcmD20JIa0dVbXnGblwNVJ19
X-Received: by 2002:a17:902:e54b:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a933b9cd21mr22398535ad.6.1770194002634;
        Wed, 04 Feb 2026 00:33:22 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851270sm16847735ad.2.2026.02.04.00.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:33:21 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH RESEND v7 02/17] fs: add generic FS_IOC_SHUTDOWN definitions
Date: Wed,  4 Feb 2026 17:29:16 +0900
Message-Id: <20260204082931.13915-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204082931.13915-1-linkinjeon@kernel.org>
References: <20260204082931.13915-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76274-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 1B037E333C
X-Rspamd-Action: no action

Currently, several filesystems (e.g., xfs, ext4, btrfs) implement
a "shutdown" or "going down" ioctl to simulate filesystem force a shutdown.
While they often use the same underlying numeric value, the definition is
duplicated across filesystem headers or private definitions.

Add generic definitions for FS_IOC_SHUTDOWN in uapi/linux/fs.h.
This allows new filesystems (like ntfs) to implement this feature using
a standard VFS definition and paves the way for existing filesystems
to unify their definitions later.

The flag names are standardized as FS_SHUTDOWN_* to be consistent with
the ioctl name, replacing the historical GOING_DOWN naming convention.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 include/uapi/linux/fs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 66ca526cf786..32e24778c9e5 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -656,4 +656,16 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+/*
+ * Shutdown the filesystem.
+ */
+#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
+
+/*
+ * Flags for FS_IOC_SHUTDOWN
+ */
+#define FS_SHUTDOWN_FLAGS_DEFAULT	0x0
+#define FS_SHUTDOWN_FLAGS_LOGFLUSH	0x1	/* flush log but not data*/
+#define FS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2	/* don't flush log nor data */
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.25.1


