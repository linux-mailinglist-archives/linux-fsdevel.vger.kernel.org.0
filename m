Return-Path: <linux-fsdevel+bounces-77093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHHLGPnejmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:21:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D0133F35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CC2304C942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521231AF33;
	Fri, 13 Feb 2026 08:20:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5B31AF2C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970856; cv=none; b=StNoM/p7UQ5/ErowfqY5rDhD/JTIWSs8xRUO7yXpcz/YDCrBTUPYTP5RZ+7DBcM+TNvfFDPLCTxQ9rzzxoZh8Q5sDPFg6qzgImMs4130GmDSsmlAxUfvnDTVao2C99XmPUievKcEvVx5mtKiFkM+lNmyFGBDGg5RoWo1ARzH00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970856; c=relaxed/simple;
	bh=kbcOV/6QcQXosOVb/kYnmczZIIbazol1Xw4so2doLDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiF1vzsuqYWYfs/7B2T4HkCOW2lVBCLIAsHQlM+5rzZTcpmDdi0mFBrNiDVoEbc/42rJrAm9zPU/rd3pqukLlQta0ouKFLLoy4IkT3DDuDJ8rwKkPNFwA8UgemBfAOEoMGTGwh1eMea8M1MKbP6Si3XjbPxah1GQ+VAbROolmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7b47a5460so15759305ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770970855; x=1771575655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgV//1wifMQx8DWc1kqJsH8XCVKk4uWaLyVeoKmarPQ=;
        b=AcQGhNea7DSQBeMhmKAWBOnga+ZJhyN/MX+6YhjR+1ASDNbymNVJRvn0RYXldCUMfz
         OAnFCEqBdkYy2GRYvvb1bdwkTdD74WU8nSUFu2CnBxOLzN2pXCfZfBghs41w18I0mVka
         pzk5cv8wsghcOHOe5EQgUYd1xvdx8rcmtntwNsHz4djXSdQ4rrHB+iB1YkRNlG7BfcgB
         W8vTe5b8yvEWoBSpmTO6edvHmW5l9C3NrRzfGmIyC9VHiJiqGjBGwQkIpumRp8NKVVtu
         G4rzrJEZl2Uyr08m0v3i1Eq43VpUdbxfFy8E++aF7XMEBSrWKd2ULzwLIlp4cCc8BPsz
         HkQQ==
X-Gm-Message-State: AOJu0YwoyxL/pgtFlrIwmKRJW76C5PrlBKlC+g2oirnbkC/nlopO6wBm
	XmDrVjf0EW6NM/26/Obv5dvd5RI6be083jb+g+DhrHXqXO0I2OeCTCIlMDNB1A==
X-Gm-Gg: AZuq6aLAyGGk2sfqwjBMo/Wezvp9O2OCORJ+u84JwBu0CXm9DgSJ85tGeO+lTNyUZuu
	0gwhbRWosO9ZRbecIC+ho4/UVLH/ixGTZv3z8oUBzFR9/AromIhmx9ZoUHCu/0JO61x3m3WD+6d
	prG29aAQ4Qtkebt1/h6AxUL5nOBjtCjZi5I/Xq6iEI4liXjcFDMJujD/mfTWUdai6m2sIUGPIOt
	3axPNIPNBO878HBb7CF4hNCMp0JxPhg0//swU5grUGVgRKOQIIrv1NKsDzU2y7ZvH4uWeVB9yZK
	L7I4LHlMpY+7EhT79BBRWijYcYpci+QjkYVDa/lHmWcqXmrD67YJEy26VOqMxy8jZ2H4LC5rwkD
	a8mtkmyASJ2sf5hBMxdj69TBzhvo13DSXLhLSLgKKxkY+65Rcyk18jX2SK3DZqDrpi7gAb3azRV
	lKy4o5ezpDA2Fb+1VWcAJs0FM4W5zP5mhthbqeqg==
X-Received: by 2002:a17:903:2a8c:b0:2a0:d454:5372 with SMTP id d9443c01a7336-2ab4ffd1741mr10187905ad.22.1770970854719;
        Fri, 13 Feb 2026 00:20:54 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm75236495ad.6.2026.02.13.00.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 00:20:53 -0800 (PST)
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
Subject: [PATCH v9 02/17] fs: add generic FS_IOC_SHUTDOWN definitions
Date: Fri, 13 Feb 2026 17:17:49 +0900
Message-Id: <20260213081804.13351-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213081804.13351-1-linkinjeon@kernel.org>
References: <20260213081804.13351-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-77093-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C92D0133F35
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


