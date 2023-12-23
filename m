Return-Path: <linux-fsdevel+bounces-6849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80D81D5A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 19:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31371C21521
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B58224F1;
	Sat, 23 Dec 2023 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFZf2LVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C62224F5;
	Sat, 23 Dec 2023 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-7b7fe0ae57bso139829339f.0;
        Sat, 23 Dec 2023 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703355105; x=1703959905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISxTalquAz27/WYFKI+kbLPuYM6OIDaSuIU1FtMlimc=;
        b=NFZf2LVCtMfiMUFaBiZBvvxgg1/Drrrzk9GDp75fl4wMMKICGwVXXHYLfg/AT1t+Qh
         kCL+JrMvxSODXYoGsRBStu6vIBePCG0cs0gSqwBQpmLonXfWzgNwuI89owQWAB3+UX8U
         CF3RO6nU+wL5FyrT2tVoLcAPu4qs+ClLxyfdoNBJqDppCfKjE5qrF18EW7y1u8SClXmI
         KQKssq2QxKjvkXjIhZuLxnbsJj+wCnBChadD7SJ8JCtA5BV10tvgZBYrnRT24GpYA8Y7
         2pBYF+t5T2x3IibNa/prFy74EBFY0UFTdjRehLWfpVqA+wWvvQDlqQ+nbcSAoqFyRDVx
         YSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703355105; x=1703959905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISxTalquAz27/WYFKI+kbLPuYM6OIDaSuIU1FtMlimc=;
        b=rbIJo1aqjfImOHH+D2NWGVlr7hGXAmNQtNMTxvTHG8uuUlgzprnkFODVBHaEe6qKsR
         4f31Q8LXWR3GNZe50RmzGAz5fB7MxW80ohJwqppLFT0n1pFpzs876JhZ0bg/mgbR365c
         EspAFAZCvupPn0RutjsPNjvnWtVJp1ESOg2WnT6f4fM0KL3XgNZX5xAAYFhHpsWCukz2
         qrhgqjCn3URwnRPZHGBxo6F6S5/eE4ufJN6E5+HyiMzmb4iXwBhqt41vDxbsWCAgTlP1
         TKCdPEiE/cxPfDJW3p5c3NgPFMd7g2Zz5DB3W7RL3L6scG/yuqsiAXlpTwzfOTyHdodU
         v+PQ==
X-Gm-Message-State: AOJu0Yx+d3RguqkHzJxj6AUROS+9C9g0ro6YwdMkV2dXWmVTW7N4CsHB
	4jTzdNj7yLFWHMrg8+K2PQ==
X-Google-Smtp-Source: AGHT+IG9pV+0w/aMA3mSXFm4w9DO8STGhMZGdvT0rddVOrZR2ExfQgVDkFTg1RD225ANbkhnPt84zw==
X-Received: by 2002:a05:6e02:388f:b0:35f:e308:5287 with SMTP id cn15-20020a056e02388f00b0035fe3085287mr3363382ilb.21.1703355105621;
        Sat, 23 Dec 2023 10:11:45 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001d3bfd30886sm4316396plq.37.2023.12.23.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:11:45 -0800 (PST)
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
Subject: [PATCH v5 07/11] mm/mempolicy: add userland mempolicy arg structure
Date: Sat, 23 Dec 2023 13:10:57 -0500
Message-Id: <20231223181101.1954-8-gregory.price@memverge.com>
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

This patch adds the new user-api argument structure intended for
set_mempolicy2 and mbind2.

struct mpol_args {
  __u16 mode;
  __u16 mode_flags;
  __s32 home_node;          /* mbind2: policy home node */
  __u64 pol_maxnodes;
  __aligned_u64 *pol_nodes;
};

This structure is intended to be extensible as new mempolicy extensions
are added.

For example, set_mempolicy_home_node was added to allow vma mempolicies
to have a preferred/home node assigned.  This structure allows the
setting the home node at the time mempolicy is set, rather than
requiring an additional syscalls.

Full breakdown of arguments as of this patch:
    mode:         Mempolicy mode (MPOL_DEFAULT, MPOL_INTERLEAVE)

    mode_flags:   Flags previously or'd into mode in set_mempolicy
                  (e.g.: MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES)

    home_node:    for mbind2.  Allows the setting of a policy's home
                  with the use of MPOL_MF_HOME_NODE

    pol_maxnodes: Max number of nodes in the policy nodemask

    pol_nodes:    Policy nodemask

Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst       | 17 +++++++++++++++++
 include/linux/syscalls.h                        |  1 +
 include/uapi/linux/mempolicy.h                  |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index d2c8e712785b..5ee047b0d981 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -482,6 +482,23 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Extended Mempolicy Arguments::
+
+	struct mpol_args {
+		__u16 mode;
+		__u16 mode_flags;
+		__s32 home_node;	 /* mbind2: set home node */
+		__u64 pol_maxnodes;
+		__aligned_u64 pol_nodes; /* nodemask pointer */
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
index 1f9bb10d1a47..4dd2d2e0d2ed 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -27,6 +27,14 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mpol_args {
+	__u16 mode;
+	__u16 mode_flags;
+	__s32 home_node;	/* mbind2: policy home node */
+	__u64 pol_maxnodes;
+	__aligned_u64 pol_nodes;
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
-- 
2.39.1


