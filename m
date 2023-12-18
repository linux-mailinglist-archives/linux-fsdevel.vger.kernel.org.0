Return-Path: <linux-fsdevel+bounces-6421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F958817B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC331C22E51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE37346E;
	Mon, 18 Dec 2023 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnn43iUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3C73462;
	Mon, 18 Dec 2023 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1d2f1cecf89so16785235ad.1;
        Mon, 18 Dec 2023 11:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928832; x=1703533632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHAGnEescBI+H6+nuN2AFaKvkx/2sXtk6C+MWO0ta0k=;
        b=Hnn43iUCKwrasE8qM/G94Hx8ENvjXq34zmbVPAtdZ/L1l5JEyHknrZnW1Jp2zvV2RN
         MoOKYuz024qFcypRHtz5yWs5LMf17v1nLSs6yavjXhKirIORBrNWmeB8oeiZV4qBJJ6l
         w2xIbzowFQ7FcPGeh1cuFnP61T+0V/ODasIO1qILO0jss/Y7NSeX/2w3GbYncc8Ax9Ht
         IL7gYiLK41ZJwDlK+FXLzKAQd6DW6Mw74HkhTnwUHIW8HxwI2D8YVdAcD3wxkQ7ZNSmY
         65lyGvuBdatOXQnT2FhBBqvVMiMfx9V7ht68QYlaum/PdYjKbxQfqiXIwIX3czoFprzL
         qNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928832; x=1703533632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHAGnEescBI+H6+nuN2AFaKvkx/2sXtk6C+MWO0ta0k=;
        b=AoApucTZb0cHQuPWTY6I5qp4S9nitvs6BEiIG9vRdCqQQ2DCcDrRI+Hv874GYdtQym
         vCmlc4TBPGa04IeisKTBzjcpdWl1lqRdsdnTwHStJEtbCrpKQ63uG+Aab4mF3oAY2hS+
         ldvn4MT/vZY/AQQo9cquNBrgbCLs+Omqn2kMXvLczJZRTQHAxLqD47bD82J+daWV1SYf
         vaGQ2ov5ejxRbPkDeTMwuScYyHg9wK77jUdpv3ed7DoP8T2hHnKYYPkXFNtubaRDx2ur
         0gZarkklGpnOVsLNZBSkJGfMomzNoyQ4lxWLiUseTx354rb4DxSNdmHxi3y24tqkz8RQ
         Hw/w==
X-Gm-Message-State: AOJu0YxMEl+D930W1gl+Go3L+8qX6zgtZJuv8jxun//riCNkWjwyeyUA
	tZktszcZBgoVqzWDJcqStPxBUFJLSNNa1NU=
X-Google-Smtp-Source: AGHT+IH68lABBd7MdPlJz2f1cHXOHBSvwu1StwzNvbHAn7HqW2kB3VG59ByjU9BE7WtdrkFq/zNRBg==
X-Received: by 2002:a17:903:2442:b0:1d3:b684:fc0c with SMTP id l2-20020a170903244200b001d3b684fc0cmr1144510pls.104.1702928832513;
        Mon, 18 Dec 2023 11:47:12 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:47:12 -0800 (PST)
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
	seungjun.ha@samsung.com,
	Frank van der Linden <fvdl@google.com>
Subject: [PATCH v4 07/11] mm/mempolicy: add userland mempolicy arg structure
Date: Mon, 18 Dec 2023 14:46:27 -0500
Message-Id: <20231218194631.21667-8-gregory.price@memverge.com>
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

This patch adds the new user-api argument structure intended for
set_mempolicy2 and mbind2.

struct mpol_args {
  __u16 mode;
  __u16 mode_flags;
  __s32 home_node;          /* mbind2: policy home node */
  __aligned_u64 *pol_nodes;
  __u64 pol_maxnodes;
  __s32 policy_node;        /* get_mempolicy: policy node info */
};

This structure is intended to be extensible as new mempolicy extensions
are added.

For example, set_mempolicy_home_node was added to allow vma mempolicies
to have a preferred/home node assigned.  This structure allows the
addition of that setting at the time the mempolicy is set, rather
than requiring additional calls to modify the policy.

Full breakdown of arguments as of this patch:
    mode:         Mempolicy mode (MPOL_DEFAULT, MPOL_INTERLEAVE)

    mode_flags:   Flags previously or'd into mode in set_mempolicy
                  (e.g.: MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES)

    home_node:    for mbind2.  Allows the setting of a policy's home
                  with the use of MPOL_MF_HOME_NODE

    pol_nodes:    Policy nodemask

    pol_maxnodes: Max number of nodes in the policy nodemask

    policy_node:  for get_mempolicy2.  Returns extended information
                  about a policy that was previously reported by
                  passing MPOL_F_NODE to get_mempolicy.  Instead of
                  overriding the mode value, simply add a field.

Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst      | 18 ++++++++++++++++++
 include/linux/syscalls.h                       |  1 +
 include/uapi/linux/mempolicy.h                 | 10 ++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index d2c8e712785b..d5fcebdd7996 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -482,6 +482,24 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Extended Mempolicy Arguments::
+
+	struct mpol_args {
+		__u16 mode;
+		__u16 mode_flags;
+		__s32 home_node; /* mbind2: policy home node */
+		__aligned_u64 pol_nodes; /* nodemask pointer */
+		__u64 pol_maxnodes;
+		__s32 policy_node; /* get_mempolicy2: policy node information */
+	};
+
+The extended mempolicy argument structure is defined to allow the mempolicy
+interfaces future extensibility without the need for additional system calls.
+
+The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
+all interfaces relative to their non-extended counterparts. Each additional
+field may only apply to specific extended interfaces.  See the respective
+extended interface man page for more details.
 
 Memory Policy Command Line Interface
 ====================================
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..a52395ca3f00 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -74,6 +74,7 @@ struct landlock_ruleset_attr;
 enum landlock_rule_type;
 struct cachestat_range;
 struct cachestat;
+struct mpol_args;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..c06f2afa7fe3 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -27,6 +27,16 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mpol_args {
+	/* Basic mempolicy settings */
+	__u16 mode;
+	__u16 mode_flags;
+	__s32 home_node;	/* mbind2: policy home node */
+	__aligned_u64 pol_nodes;
+	__u64 pol_maxnodes;
+	__s32 policy_node;	/* get_mempolicy: policy node info */
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
-- 
2.39.1


