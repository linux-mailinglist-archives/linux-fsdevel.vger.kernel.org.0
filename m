Return-Path: <linux-fsdevel+bounces-6845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D276F81D59A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9DDB21D12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3B1A28F;
	Sat, 23 Dec 2023 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoKeneyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A221D681;
	Sat, 23 Dec 2023 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-6dba02a162aso2107178a34.0;
        Sat, 23 Dec 2023 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703355088; x=1703959888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7pmxfeZqglD0vnlUxD8yjybFz/b8pMpATnV83Z/Zpk=;
        b=eoKeneygMMdYA26gwZyhLLyx9qPIzcg5wn8l6Us/ew9g2x89mH0jVftCKCtn36OUJd
         DDrYnEGA5fHMNR09PDj1m3Msxs9laViRX0Zji2NRf3dh5f+JQTx/OqBM3jF88gjWvUjW
         MmDE/BJLyjSm9tA154c4AxMiZkLuPziB3FNVjSLvaAvXiTP0e1MddF9ekLg/ewjuD3wQ
         ftC6Rw5CYfav6+H1YYrIHM6FecW5pELcVMFLc+dOX7ut8nzOUaxAYKKizJYLZPgRLOdG
         a3J2y7IJBteCZffAW8osGQd7NRwSQXQWP0nytV4FA21pHpcOE1Ck+y3g48Hbn3gBdaM/
         txCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703355088; x=1703959888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7pmxfeZqglD0vnlUxD8yjybFz/b8pMpATnV83Z/Zpk=;
        b=Bi3vAHfkEL3o9XKYRo2aR3NsvI88Az+CJBn6cR1Hw1DaaaKqQJfAWuVr+U0Pcb1ojD
         WNZ3roq9M889FrEBL5EC6454FupBFf6athOAuYHyVJaSue+lfiOGPySvak+BRuTGpO2r
         BxlAaQNAFlhCYqciYaanzppbrKXGdtNw4EY8Nh+mkCbCSdbjzsi4ySqyow8vOUjZ5vUe
         gWaFoRyqJf2PA2Td3g80Oev11QE0tjcyrOEsW0VQOkhWC1RdnUy8Yz0Dgf9B2ity6fJY
         23eZH8wZ0yOkhN+aK9pvJ+w0ts0w684202bxTugwNjTGySS634n4nV9GfTQ+S/K7+6Zr
         No1w==
X-Gm-Message-State: AOJu0Yxmcn5XEC8yuducEd9SnvFFORVY4JeTFy6jzbZmfNCIGLNzKiqU
	Wk4N5wV9NgZGDVXi/bl7xA==
X-Google-Smtp-Source: AGHT+IGduDJamDKHmR+aQaOtBDinjtfu7pRzN+JQ8ZvU2VnXEa8xH+EQdgRFEdxiiUKgsn5BH0VfBQ==
X-Received: by 2002:a05:6808:3703:b0:3b9:e5d5:a69e with SMTP id cq3-20020a056808370300b003b9e5d5a69emr3283728oib.119.1703355087849;
        Sat, 23 Dec 2023 10:11:27 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001d3bfd30886sm4316396plq.37.2023.12.23.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:11:27 -0800 (PST)
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
Subject: [PATCH v5 03/11] mm/mempolicy: refactor sanitize_mpol_flags for reuse
Date: Sat, 23 Dec 2023 13:10:53 -0500
Message-Id: <20231223181101.1954-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231223181101.1954-1-gregory.price@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
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


