Return-Path: <linux-fsdevel+bounces-7312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5EA823862
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90EA1C245CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69EC20330;
	Wed,  3 Jan 2024 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwyi7Tax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91322032B;
	Wed,  3 Jan 2024 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1d4a2526a7eso22819625ad.3;
        Wed, 03 Jan 2024 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321774; x=1704926574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOV0W7hivfDnJ4gd5lhXDZU7r1NQAk/nZjV64KhDSvs=;
        b=Pwyi7TaxhJsSPk3aBmbjdsmWL5GG0JKucPXkgrgfGrNBZ8+WGdUGj6WQ5mAkkzn5OA
         BUJ7dJoUY0wNAqzGcC8idy5HXGdfZEayk29VsRMOFPsEJdwtx4kPc/gyycVFpqIfrRo5
         PMKPTYMyetszNcHMOuqhkB6Qkbp8Kg6L4Y1MXnnrj5lggJU152wASxYDVh/CEAQcO5tm
         4CSeJBvfd2Jta7Tt412InbytUBD5QR9CQ0anS9GljvOe8Z2vmzkWqrASerCHFoTCuxay
         U0mNJiwF3umZYMpkq5KBFGMnfV5y4ZyXqaOoWDD6oOQ0EwrLffFeYCcCpS0Rc4cpGPic
         hlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321774; x=1704926574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOV0W7hivfDnJ4gd5lhXDZU7r1NQAk/nZjV64KhDSvs=;
        b=s8n2d3ZSAdonl/RcyqDAo82Iarfl09P5jOSKaRrmydwh6p8dTxLtn6rxFIJ+XPOQaZ
         S7ns0i4i4MznggpFzz658TuH19EODOFVJQboflMNcQSPDh7CSWkOp90Fy4LBemx5CMOL
         +Ca7C8tgyFoRTyJhk+j8tOajsGsEeRaZ3XYVFHiwEZwN21ZV4eKarS5jXh7ErjHKJ//j
         ssw+QEZrqQTxbbQdDahei6Xb4a+ctNtLQiBidIgSXREf/C2fCXgc+jmP4Z9ZfOlcTvYM
         dbJFtFj9BqVXnxFvnS+s/8oarpbzbkEkXZr2Z/lC0/OIbbt/1QTu3IUf7mXUxxv9BRM5
         mzFQ==
X-Gm-Message-State: AOJu0YzvfQ2NKIDUTaLDRPpT2b7xRsxslvNl4SzGvrc+HAS14fDAX/3a
	DBzXxoVMBqs6t81QKzL6uA==
X-Google-Smtp-Source: AGHT+IFh+qcxXaiogx+miqhx0SFpy/RI3hbA28LBl0CE6Pvd/A72N4h+GBcyXApCM4Y4r2iGXqWlmQ==
X-Received: by 2002:a17:903:2450:b0:1d4:ab6b:f102 with SMTP id l16-20020a170903245000b001d4ab6bf102mr3418120pls.85.1704321773969;
        Wed, 03 Jan 2024 14:42:53 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:42:53 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
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
Subject: [PATCH v6 04/12] mm/mempolicy: refactor sanitize_mpol_flags for reuse
Date: Wed,  3 Jan 2024 17:42:01 -0500
Message-Id: <20240103224209.2541-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240103224209.2541-1-gregory.price@memverge.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
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
 mm/mempolicy.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 46e6b6f36a10..6e2ea94c0f31 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1478,24 +1478,35 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
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
+ */
+static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
+{
+	*flags = *mode & MPOL_MODE_FLAGS;
+	*mode = *mode & ~MPOL_MODE_FLAGS;
+
+	return validate_mpol_flags(*mode, flags);
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
-- 
2.39.1


