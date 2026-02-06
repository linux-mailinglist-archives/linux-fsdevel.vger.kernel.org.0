Return-Path: <linux-fsdevel+bounces-76554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NFjGLOWhWk7DwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:22:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC3FAEA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 08:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614163019522
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B930B51B;
	Fri,  6 Feb 2026 07:22:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D59303A05
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362532; cv=none; b=OXHKmWc0m72+d4Qxt5/gNP0TiqUDojXLJoz83ZHbZhnctSUqRZfmtJ1+LTiVYmLQXMsSx115RtpiVWA1u+TmCMBA2ekrkHbCt46fxhp4xsDAdQg8QKKqcbiRgiSFwxgH7fdbLJJOG3l1q7CsDY6NRAzfe3fsTLnOmWdsdqiCxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362532; c=relaxed/simple;
	bh=kbcOV/6QcQXosOVb/kYnmczZIIbazol1Xw4so2doLDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2YEO8gk+tFmpvohJ36zjUvmOCkX33y6HK9ciQ1StG2hLQ2pYFvJECbILWGLFOhgxCjzF7qzqbGfFWB7wLPVSkUyibIJIGqSq3bAcU35K7JPQpkF72+2SavhxD+NvYycGut36oRzVgfx0lm0F/aHeJptvWgk/ZJ8Br5Tayp+BZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7bced39cfso19412705ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 23:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770362531; x=1770967331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgV//1wifMQx8DWc1kqJsH8XCVKk4uWaLyVeoKmarPQ=;
        b=NwCu4vEgCqrJUIbOh2ajFGo8D1hnbpx0V6UYAGTqF0uMwzS5qwohZc9OwYAIj8B3to
         JGmvXEkETSecNMGbmTcbcBmbVBe0t2mQxAqF+Qjxi62jOxPgosoR/FsfxSo/0m3pmpJF
         uNq0E1r+2/ZmDHsZ9ofNx1nRRYN0xCuFv8IJgQC099djFSQPmj6bHqOPisNdRkxLb1r2
         juHXb0mMjTBU62CjCOc/td9PHC6rp9aK6IndVXdUQv8GfXT12HEbNLm2Ux13oWe09Y6E
         I3e6AP+x1bWIDaA17y1P8WKlQc5MYcb7pTvEef1pCjEA+3xdm8Q1aihpcU21boddow5A
         SIHg==
X-Gm-Message-State: AOJu0Yyv8pC4NzlUlcQe28zwjCnjIlcjVkn2jNWeKll4kyfH9NeSBcl8
	4i3gTUOm+zC0m4G1KBGh7TrOLGfBzo32OmnLWAe9DOL/bNmVMkoEH0cN
X-Gm-Gg: AZuq6aIn5VUEcxw7nkULz10/bjI5pvNJm754ERI9gHUp+kjbyb5W/Lul6XBKqhmIJed
	nV2lzp19Fc9lWulmI0wbXnHc9Jl6Ky2jOPFagEcDqh20o5KnSMTR9YIlX4WbdaS2BZgq1JFW1+E
	yvU/A0P6BSrpEapBKOPw3eqPzh2PrNLxrYxxMSdWeQeTzNWN/XflLjIS/WCrPb8FDoDmACZZxzg
	WFQuXN8yBrNQME+NGrAyR/n4BJHExjvg/dcO+oNOzOQCZieyZG6bKyqJKusIhP5cQaTLLM7b9ci
	EY/tVstmTc1siJNQLX5vYspBZLwmvuT/lUPQIYNziGXKF4eDWVyBi6koiSbWj+EfAKPhl6dfbe5
	EypEgyWiSloRN8nDyHbfHEMMF1wPnB06/K4iOoL8cKzo+DiKAdwcvEiwH+yaXnyfHm+eZRNncps
	rG+KUrXQW/iqpN0Dda4BD8jfpZ+A==
X-Received: by 2002:a17:903:2f8d:b0:2a1:14dd:573 with SMTP id d9443c01a7336-2a9516ceacemr19084045ad.23.1770362531441;
        Thu, 05 Feb 2026 23:22:11 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c7a047sm13575125ad.27.2026.02.05.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:22:10 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	amir73il@gmail.com,
	xiang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v8 02/17] fs: add generic FS_IOC_SHUTDOWN definitions
Date: Fri,  6 Feb 2026 16:18:45 +0900
Message-Id: <20260206071900.6800-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260206071900.6800-1-linkinjeon@kernel.org>
References: <20260206071900.6800-1-linkinjeon@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76554-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8AC3FAEA4
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


