Return-Path: <linux-fsdevel+bounces-76266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCaQDoz6gmm2fwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 08:51:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A94A0E2D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 08:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4F5301A15A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A738F22B;
	Wed,  4 Feb 2026 07:50:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E838E12E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191447; cv=none; b=Bi4EaNrK++8nU9vHfh/l5phn+uu5Yk3+u0GiZ61RzGgQCtFV0B04MTBCi8BLMkIAS/smLh9bptXpRX+xhWxZVye6s31q6EcBblHvUe6cVjYKPHhwn35BOuJEs0ez3N6vR6EKntZ7owPO2TZTKWAMCsoWyECZ02Pr2XYX5ElTwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191447; c=relaxed/simple;
	bh=kbcOV/6QcQXosOVb/kYnmczZIIbazol1Xw4so2doLDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFRsYu2OmvBvdoakbALQ66eBFNZ0xRv+pn/2KadVXsnL0jlixPXYk9wdNNAowsYD+pCfXONIulRm81dV6BE1hyRGTbhAbhOvFZK73M8QDYZeOwtKfm93IbZwtIgfWm/0LJ1yLqF9lJgnp5KsoPsWYKysfcjvXl3lvjNZ3GMOiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso46163865ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 23:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191447; x=1770796247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgV//1wifMQx8DWc1kqJsH8XCVKk4uWaLyVeoKmarPQ=;
        b=TGjifpw3vkW10mXMdNmn/f7gqXmyMeqH4eqXUio8IzoZktCb5Gp0bfELunLDm//9Gt
         0pRNqvpOhyR3da7VcSpIPk9t4gvBHQzo6jdGzeEVF8XJJ0WV7zSHNamJzvHdO/e/fzLe
         mXSyHqdx7pcZYuCaQ4i5DZBkXuZIYgvFn0qI02cOWpJfjkv2Fm9MXv8f7oF/zzbjM4s7
         7JrSvv4Z55BJ0tQ6E/Jddp+u+EjvpWR+Cd0mQrZj7oKO920vs2AU6oud4nxdNJ1/dUMf
         TOhrMjpQ5wlobFPr4jZqnngYoJg6SG+kHuV5d4b5wq/DpwrcDhUXoH9BdVj9I0LaUEy2
         tAtA==
X-Gm-Message-State: AOJu0YxUR0SDLIyjTjZgHA20A40parVFRQmcguCNQTBDQwEn/PCIlixT
	A+CtVIaexsj6wHNQ2jNQENdyGPM0nAzFI77ilsQHyC2kAM0H9cIS6NB2
X-Gm-Gg: AZuq6aKoKy2VWUV2WbnMYJWBC1vIksCqZ/hHIFYlgpWGC2fCVMxIppJNDPZRV0A4Rh6
	wEJfDeXXGnW/4V7nTe9raZQhc+LariZ4CVfkrqaiAGD5IRVx06B/7qkdqlXYDtpAxcf/OWQ+POm
	yR2tX1uoHMzV9LgAbVLVLA7rV9isQ9iKUZaudcrVA8dR+D2Lv1GLR0vItkBmIzoxFNGKCyvokan
	q/bcSM6992Q2YMYdMbb20YAG9VmKzORMXh1qid6Bu2FdFE2qU9FwV80fztWlCtFY9zW2fDuzJqb
	ThSEII1DoCATTk/ckxNoTB1d2nwo0VzJUQia3uZxZJvOfmuLCzjWVApafeg+tp2KiuXkPPgUOR6
	6pAESeOs/JmJtZSuo8UG36H7Wvs7oOxieHghPrfnBB+DaIwzZ4jYuPw8B1LbHLcXvrPguOyu9dW
	oqIxzFYR//mfUNp+uRGYroqV3QLQ==
X-Received: by 2002:a17:902:eb83:b0:2a0:fb1c:143d with SMTP id d9443c01a7336-2a933b89ed8mr21250935ad.1.1770191446827;
        Tue, 03 Feb 2026 23:50:46 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933967771sm14554875ad.82.2026.02.03.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:50:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v7 02/17] fs: add generic FS_IOC_SHUTDOWN definitions
Date: Wed,  4 Feb 2026 16:47:40 +0900
Message-Id: <20260204074755.9058-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204074755.9058-1-linkinjeon@kernel.org>
References: <20260204074755.9058-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76266-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: A94A0E2D79
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


