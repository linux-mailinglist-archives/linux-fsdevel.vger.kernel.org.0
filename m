Return-Path: <linux-fsdevel+bounces-6420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC2817B41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8A21F25191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5B7207F;
	Mon, 18 Dec 2023 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUGZwS5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4217608E;
	Mon, 18 Dec 2023 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1d39e2f1089so18979955ad.1;
        Mon, 18 Dec 2023 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928828; x=1703533628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HdbfjrUNXuDoTm+qDnoLliIoy9y0PH4Q8y6qoN4vRo=;
        b=BUGZwS5BuLtnGKLJ20jD9Se++Wq2gx3jGUipTPW6GC62ZBdy3UdkpLXCSV+lXT/aho
         y0Dt/j/FjDf++kz3FiPFFcCLRpxBA7bm6uW1hzLXP84tcnCOL9b1q+A+PxlsxixTXGy3
         2nYueyJAvS8JL0TnbFwE+CAxAYlxju7JATnXnRsPFC4LiT83EzQZKfsnX9kc3xaOjE/B
         ce+nUZ8QmZIen3qh0ZWWVnRa1yiCkJCtqibF/nPuTYTYCUn43d0uxui/7x38XFr/LLzJ
         NzPFD3OVQQ+Lqtj1Ff8ldtojQrq3Ilbdt8rMSy0iTKQ/ZvhnUvaJuhU+IYNb4riS2+VQ
         //+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928828; x=1703533628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HdbfjrUNXuDoTm+qDnoLliIoy9y0PH4Q8y6qoN4vRo=;
        b=oXqwr8jelZJZ0C4HqMT7SAHztX1qeeL/h9QP4Kz/hji5GMxQeiJl5Xw8Hze32gjn2E
         9/E6MjwWI8oVHOclD0QwBmRCtx3q0O7moUf568Rjqu/YogFFBGxi+5I31x+njsngHs3M
         yl7D88p0j5EOtg/8HM0cjnwYfAdXPxqiD4UNyq/3YnKoSQsg2cNsE194n7PMwqj/nZl3
         yA2Mt3QhVKA52NAQ5QLmgef61uTStAlz5s6Lb52eW7AzRZ8Dd+kbaJejfilWTOjcgh7z
         4/MKTibIY7HlmCxdKOZLYBhMpKLLE76cATmk8DUASm4fK93ZmFO/MGfJlRvAIlg5tgpr
         nxbw==
X-Gm-Message-State: AOJu0YwKJj9MeO1TG0+0KDqH6blRkiB3eBF/Bs67HQD7iZiMxwsGmUJ8
	IdPH71sTSIjoU1uAwr4wPQ==
X-Google-Smtp-Source: AGHT+IFFELTMN7anDySBQ6xg3aJOuW+1fBiU4AjT1h7wEnplFVcEhIUtJlqRaBhHprORVyr+ExKmAA==
X-Received: by 2002:a17:902:6844:b0:1cf:7683:93e with SMTP id f4-20020a170902684400b001cf7683093emr16850857pln.24.1702928827983;
        Mon, 18 Dec 2023 11:47:07 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:47:07 -0800 (PST)
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
Subject: [PATCH v4 06/11] mm/mempolicy: allow home_node to be set by mpol_new
Date: Mon, 18 Dec 2023 14:46:26 -0500
Message-Id: <20231218194631.21667-7-gregory.price@memverge.com>
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

This patch adds the plumbing into mpol_new() to allow the argument
structure's home_node field to be set during mempolicy creation.

The syscall sys_set_mempolicy_home_node was added to allow a home
node to be registered for a vma.

For set_mempolicy2 and mbind2 syscalls, it would be useful to add
this as an extension to allow the user to submit a fully formed
mempolicy configuration in a single call, rather than require
multiple calls to configure a mempolicy.

This will become particularly useful if/when pidfd interfaces to
change process mempolicies from outside the task appear, as each
call to change the mempolicy does an atomic swap of that policy
in the task, rather than mutate the policy.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4426365a353d..fe340480e296 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -306,7 +306,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
-	policy->home_node = NUMA_NO_NODE;
+	policy->home_node = args->home_node;
 	policy->wil.cur_weight = 0;
 
 	return policy;
@@ -1625,6 +1625,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
 	args.policy_nodes = &nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	return do_set_mempolicy(&args);
 }
@@ -2985,6 +2986,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode = mpol->mode;
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
+		margs.home_node = NUMA_NO_NODE;
+
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
 		if (IS_ERR(npol))
@@ -3143,6 +3146,7 @@ void __init numa_policy_init(void)
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_INTERLEAVE;
 	args.policy_nodes = &interleave_nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	if (do_set_mempolicy(&args))
 		pr_err("%s: interleaving failed\n", __func__);
@@ -3157,6 +3161,7 @@ void numa_default_policy(void)
 
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_DEFAULT;
+	args.home_node = NUMA_NO_NODE;
 
 	do_set_mempolicy(&args);
 }
@@ -3279,6 +3284,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	margs.mode = mode;
 	margs.mode_flags = mode_flags;
 	margs.policy_nodes = &nodes;
+	margs.home_node = NUMA_NO_NODE;
+
 	new = mpol_new(&margs);
 	if (IS_ERR(new))
 		goto out;
-- 
2.39.1


