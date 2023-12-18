Return-Path: <linux-fsdevel+bounces-6417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F8817B34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E992849E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B5740A6;
	Mon, 18 Dec 2023 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgi3YmB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6174097;
	Mon, 18 Dec 2023 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d337dc9697so29726495ad.3;
        Mon, 18 Dec 2023 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928813; x=1703533613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7pmxfeZqglD0vnlUxD8yjybFz/b8pMpATnV83Z/Zpk=;
        b=Sgi3YmB2444jz6igsZh+B+nmDuNskONPZ1QrqAdHKQXq9z/4cS4hmBcpVtEutV1ZJl
         GFIc9YnbZzgiVcolrvJiGBcBEyvW0Da/aqGJZEZVSsNXN0lWgJu2t2JPubknKescAiUW
         f6TY068UVh3Vydy+xoT7RrMiJ6uIm8d5VJzDBJ0Aj1c4uFbm1+aZtJYNXoRs0sxyNd4P
         pQfutJNjXzOxK66ibBn9xL/Efuf8xgrNjJyihI+gD8e58Y4zbm1oANvYAM+pYFXtXd5j
         C4dFjGQU5CKHvmD35qQDEY9wbwYPpCRJ9uvR43n32hUad2b3UmYNyNSEcN6hpBQfjPPP
         HbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928813; x=1703533613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7pmxfeZqglD0vnlUxD8yjybFz/b8pMpATnV83Z/Zpk=;
        b=ZqW8dAqqGfad/2kgvzsQBR+G5kdJ/ZBEGA5QrI7C2w1F8AbQNvGvW3eDu3LIaHztK/
         2I2NTXCIAPYidGhMgTtbA6togKYkAyr+vLE3hXo0x8cJV5maFo20Yah1m/lx+ipfOOhl
         kHmhdvsYQ2CmGQmDb7wzihmCrKg8C5+Y0zoI7/v2dbolCNKUiuB2yZ8NzVrpdc3F/8+Z
         E2PiDSQ+Uk5M1RpF5KKxowf/7j/2VhRjbtJ+/6Xr9a7m22440B780ov/kOfQKgbhpHSB
         TzduCkf0SCl1xBUhEl9tUFgFcom1KI7F0E2c2O1AMqs8tiEGgcGE981Em+PlXTkaere+
         8fVg==
X-Gm-Message-State: AOJu0YwXMtqXA2ymrpmBq3e3IqHCRzY71g9dTd/2yAdss+En87VSN8HF
	7tCIKALmMJWsNEMUKlczLg==
X-Google-Smtp-Source: AGHT+IHWBSwQevH72f8SxzvajryyspJ7hMUHu1VYL52umwdTTEsqToXU97NkdKoC89YzWNT1N90zFA==
X-Received: by 2002:a17:902:dace:b0:1d3:d9d3:6a4d with SMTP id q14-20020a170902dace00b001d3d9d36a4dmr271727plx.83.1702928813313;
        Mon, 18 Dec 2023 11:46:53 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:46:52 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v4 03/11] mm/mempolicy: refactor sanitize_mpol_flags for reuse
Date: Mon, 18 Dec 2023 14:46:23 -0500
Message-Id: <20231218194631.21667-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218194631.21667-1-gregory.price@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

split sanitize_mpol_flags into sanitize and validate.

Sanitize is used by set_mempolicy to split (int mode) into mode
and mode_flags, and then validates them.

Validate validates already split flags.

Validate will be reused for new syscalls that accept already
split mode and mode_flags.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0a180c670f0c..59ac0da24f56 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1463,24 +1463,39 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
-/* Basic parameter sanity check used by both mbind() and set_mempolicy() */
-static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
+/*
+ * Basic parameter sanity check used by mbind/set_mempolicy
+ * May modify flags to include internal flags (e.g. MPOL_F_MOF/F_MORON)
+ */
+static inline int validate_mpol_flags(unsigned short mode, unsigned short *flags)
 {
-	*flags = *mode & MPOL_MODE_FLAGS;
-	*mode &= ~MPOL_MODE_FLAGS;
-
-	if ((unsigned int)(*mode) >=  MPOL_MAX)
+	if ((unsigned int)(mode) >= MPOL_MAX)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
 	if (*flags & MPOL_F_NUMA_BALANCING) {
-		if (*mode != MPOL_BIND)
+		if (mode != MPOL_BIND)
 			return -EINVAL;
 		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
 	}
 	return 0;
 }
 
+/*
+ * Used by mbind/set_memplicy to split and validate mode/flags
+ * set_mempolicy combines (mode | flags), split them out into separate
+ * fields and return just the mode in mode_arg and flags in flags.
+ */
+static inline int sanitize_mpol_flags(int *mode_arg, unsigned short *flags)
+{
+	unsigned short mode = (*mode_arg & ~MPOL_MODE_FLAGS);
+
+	*flags = *mode_arg & MPOL_MODE_FLAGS;
+	*mode_arg = mode;
+
+	return validate_mpol_flags(mode, flags);
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
-- 
2.39.1


