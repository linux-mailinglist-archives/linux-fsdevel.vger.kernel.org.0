Return-Path: <linux-fsdevel+bounces-6848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7C81D5A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279A21C20F02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163022060;
	Sat, 23 Dec 2023 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhdtfXD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5F224CD;
	Sat, 23 Dec 2023 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-7ba7c845e1aso138922739f.2;
        Sat, 23 Dec 2023 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703355101; x=1703959901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxtEsEea8M2tXpOIXXydNAgz6njKrExc/jYMN+DERr8=;
        b=UhdtfXD0jAMMk6t9viMWp3sX2/dziWeXszsa2T/JJRdVfJDJtAC/WNU5kVMkxkgAnV
         bSBjtBOwgNyIq5qoiwgiwowJYwNs3fVKQ8mYFs0OnkcetUMBNVqWM/4+Sk5r6eA8TxSJ
         btfYBCT5n+vKVwnodfwYoxQE87EF0CikxYys/5egAcaYN2X6XJZyKfwd9rtWEmdnHg0/
         olz36+DEd3jul3KsOrQLNz7rIinO7qWhbJeh/NH4yGuWP22wt8bFCuxqsX+PmRb8OKlk
         ++Ok/JaZ0gTJSGIaJ1/JO0LYUO9RJgAPKpkYqbR/NMPQjgCKway+ovfPc4z/wE7f3S1G
         bTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703355101; x=1703959901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxtEsEea8M2tXpOIXXydNAgz6njKrExc/jYMN+DERr8=;
        b=W8X2cxURvDwoNIAQbCHlogo171tVmfQeADMdfDrVA4WyWcaDGKFVUZvRIwOi9OZukX
         gOK1nuaJqnCApVQcMDCk6AmGfRZBLGbp372YDU7lYqPdMboeLR5AILVzn7VYZZu2pMWp
         E3bWl95vDCbYkWFO3Yda/kI7An+2sT+L1n6BhsHhWJJgHze8dTfh0xY07glYWOHYl1gR
         uA9xOXokNuxPSlMkdyLjp40kyFO9bsK96LZvlYm2YMopfbJuXCsSf1UgeK42UNnsuIoW
         yf58bechRSR+JLkSxcTapH/2JGCkBIHEmQ25VZ5eNYePCDb14Eu5Ua4qb6sJbreUMwtg
         juGw==
X-Gm-Message-State: AOJu0Yxh5IhZdDQ4OIjMNWbWPAHcW+LY1SmkrHu5DdpxyJpLsAUI73ui
	icn/o40nFiTNxPrXnwRfuNeW+gzKc8osnKw=
X-Google-Smtp-Source: AGHT+IEIIK5nnQRVINOQp5Dwg3gMHuxAX94IyAoS97JCyCdhV9IOLTWfMybT9a4QCLjoSGJGFFoGtg==
X-Received: by 2002:a6b:7006:0:b0:7b7:bbbe:ede6 with SMTP id l6-20020a6b7006000000b007b7bbbeede6mr4464552ioc.6.1703355101217;
        Sat, 23 Dec 2023 10:11:41 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001d3bfd30886sm4316396plq.37.2023.12.23.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:11:40 -0800 (PST)
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
Subject: [PATCH v5 06/11] mm/mempolicy: allow home_node to be set by mpol_new
Date: Sat, 23 Dec 2023 13:10:56 -0500
Message-Id: <20231223181101.1954-7-gregory.price@memverge.com>
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
index da84dc33a645..35a0f8630ead 100644
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
@@ -1623,6 +1623,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
 	args.policy_nodes = &nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	return do_set_mempolicy(&args);
 }
@@ -2984,6 +2985,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode = mpol->mode;
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
+		margs.home_node = NUMA_NO_NODE;
+
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
 		if (IS_ERR(npol))
@@ -3142,6 +3145,7 @@ void __init numa_policy_init(void)
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_INTERLEAVE;
 	args.policy_nodes = &interleave_nodes;
+	args.home_node = NUMA_NO_NODE;
 
 	if (do_set_mempolicy(&args))
 		pr_err("%s: interleaving failed\n", __func__);
@@ -3156,6 +3160,7 @@ void numa_default_policy(void)
 
 	memset(&args, 0, sizeof(args));
 	args.mode = MPOL_DEFAULT;
+	args.home_node = NUMA_NO_NODE;
 
 	do_set_mempolicy(&args);
 }
@@ -3278,6 +3283,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
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


