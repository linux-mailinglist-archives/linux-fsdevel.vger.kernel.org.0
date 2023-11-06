Return-Path: <linux-fsdevel+bounces-2172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75C7E2F81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0865280D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A132EB1E;
	Mon,  6 Nov 2023 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1g7H7Gtr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488E2F507
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:46 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19ED47
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:45 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d11fec9a5so27857336d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308524; x=1699913324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi9EDPpqsP1S+XlZ8gl3BYRn+cxn6q4J+q4swfwHv2I=;
        b=1g7H7GtrZ9mm41v3RmDCdjUIvd/CMTTYIF/68OYqF8p9wWjddWfyA9JHRYxPOgo5qd
         kv7f5n7KRUNSlZfM51DLxGYx0/j7NLyakDoLwHvfEIGGCgpJWBHGVuHyGMEBwd+vC7uw
         Utj8cpVDsQ/2Y619rghIcOKgW37WdhBvLSgqeoqxgUsNNS409MwjZy9faUtvxRSnQ3PE
         DBjzNlSuQ7winLJqu/SsCUZUbA+k3gg7gz6xihdHoNfL5U03APu7Vxogk5v6pTidulfg
         ZWine5WZS25BuRl2VZODB749Z/uYaGFb4ZRZUjutB1FNK9JziE7y7VmLNMj8NTHxxU/F
         NhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308524; x=1699913324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi9EDPpqsP1S+XlZ8gl3BYRn+cxn6q4J+q4swfwHv2I=;
        b=f7SgGrSbmorjwjzXH45ios8Sak57aXZAJILiBwjJekk5c/q9VVELAPcS7vmj2kcsCy
         AhGjXUYlH4JwdqjAPs5qJxSV0eGXRSZ1gRtxOTlg4mOQ/Hb5x+93d9YQwspnKBBtfQBA
         X/2sRttX/OQkJoN6oxh5gw6FjT8F9R421HeI8Cw5S4FvdHSkNjPzhN54xbylVlkqRiiS
         qWcG8vOXEk9pr1mM9MDgzW7Hb7fBUzgy9mKpsRfKKj+uIkIOyvqhb2gYuc2JHhMVEJHL
         L/4eUfcIiiTywCeO7N2k9VxTAbvKxaX6v6vv7CVR6zmxSXAEkCigIPV0BNXtFNUh1f5n
         A4Tw==
X-Gm-Message-State: AOJu0YzxeW6VPo7bxc1hbkTiXrxFr1/W53WrfHA/LVYJRan9jCwYc6Wq
	hmAMtVNOzbDVUAZq0YWyO+qLVg==
X-Google-Smtp-Source: AGHT+IFPiDb7JWisYnS006hixYyoYr8loyt9iXIWTDKC1Q9M+sYaNa6Us9AC6cgYW9NSl0YLlbyKDA==
X-Received: by 2002:ad4:5ca1:0:b0:66d:6af7:4571 with SMTP id q1-20020ad45ca1000000b0066d6af74571mr32971369qvh.17.1699308524086;
        Mon, 06 Nov 2023 14:08:44 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c10-20020a0cfb0a000000b0065af9d1203dsm3809217qvp.121.2023.11.06.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 08/18] btrfs: add fs_parameter definitions
Date: Mon,  6 Nov 2023 17:08:16 -0500
Message-ID: <9d0173eef0e37f321da8945cfcfa7d5c923280c3.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to convert to the new mount api we have to change how we do the
mount option parsing.  For now we're going to duplicate these helpers to
make it easier to follow, and then remove the old code once everything
is in place.  This patch contains the re-definiton of all of our mount
options into the new fs_parameter_spec format.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d7070269e3ea..0e9cb9ed6508 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -27,6 +27,7 @@
 #include <linux/crc32c.h>
 #include <linux/btrfs.h>
 #include <linux/security.h>
+#include <linux/fs_parser.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -132,7 +133,7 @@ enum {
 	/* Debugging options */
 	Opt_enospc_debug, Opt_noenospc_debug,
 #ifdef CONFIG_BTRFS_DEBUG
-	Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
+	Opt_fragment, Opt_fragment_data, Opt_fragment_metadata, Opt_fragment_all,
 #endif
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
@@ -222,6 +223,131 @@ static const match_table_t rescue_tokens = {
 	{Opt_err, NULL},
 };
 
+enum {
+	Opt_fatal_errors_panic,
+	Opt_fatal_errors_bug,
+};
+
+static const struct constant_table btrfs_parameter_fatal_errors[] = {
+	{ "panic", Opt_fatal_errors_panic },
+	{ "bug", Opt_fatal_errors_bug },
+	{}
+};
+
+enum {
+	Opt_discard_sync,
+	Opt_discard_async,
+};
+
+static const struct constant_table btrfs_parameter_discard[] = {
+	{ "sync", Opt_discard_sync },
+	{ "async", Opt_discard_async },
+	{}
+};
+
+enum {
+	Opt_space_cache_v1,
+	Opt_space_cache_v2,
+};
+
+static const struct constant_table btrfs_parameter_space_cache[] = {
+	{ "v1", Opt_space_cache_v1 },
+	{ "v2", Opt_space_cache_v2 },
+	{}
+};
+
+enum {
+	Opt_rescue_usebackuproot,
+	Opt_rescue_nologreplay,
+	Opt_rescue_ignorebadroots,
+	Opt_rescue_ignoredatacsums,
+	Opt_rescue_parameter_all,
+};
+
+static const struct constant_table btrfs_parameter_rescue[] = {
+	{ "usebackuproot", Opt_rescue_usebackuproot },
+	{ "nologreplay", Opt_rescue_nologreplay },
+	{ "ignorebadroots", Opt_rescue_ignorebadroots },
+	{ "ibadroots", Opt_rescue_ignorebadroots },
+	{ "ignoredatacsums", Opt_rescue_ignoredatacsums },
+	{ "idatacsums", Opt_rescue_ignoredatacsums },
+	{ "all", Opt_rescue_parameter_all },
+	{}
+};
+
+#ifdef CONFIG_BTRFS_DEBUG
+enum {
+	Opt_fragment_parameter_data,
+	Opt_fragment_parameter_metadata,
+	Opt_fragment_parameter_all,
+};
+
+static const struct constant_table btrfs_parameter_fragment[] = {
+	{ "data", Opt_fragment_parameter_data },
+	{ "metadata", Opt_fragment_parameter_metadata },
+	{ "all", Opt_fragment_parameter_all },
+	{}
+};
+#endif
+
+static const struct fs_parameter_spec btrfs_fs_parameters[] __maybe_unused = {
+	fsparam_flag_no("acl", Opt_acl),
+	fsparam_flag("clear_cache", Opt_clear_cache),
+	fsparam_u32("commit", Opt_commit_interval),
+	fsparam_flag("compress", Opt_compress),
+	fsparam_string("compress", Opt_compress_type),
+	fsparam_flag("compress-force", Opt_compress_force),
+	fsparam_string("compress-force", Opt_compress_force_type),
+	fsparam_flag("degraded", Opt_degraded),
+	fsparam_string("device", Opt_device),
+	fsparam_enum("fatal_errors", Opt_fatal_errors, btrfs_parameter_fatal_errors),
+	fsparam_flag_no("flushoncommit", Opt_flushoncommit),
+	fsparam_flag_no("inode_cache", Opt_inode_cache),
+	fsparam_string("max_inline", Opt_max_inline),
+	fsparam_flag_no("barrier", Opt_barrier),
+	fsparam_flag_no("datacow", Opt_datacow),
+	fsparam_flag_no("datasum", Opt_datasum),
+	fsparam_flag_no("autodefrag", Opt_defrag),
+	fsparam_flag_no("discard", Opt_discard),
+	fsparam_enum("discard", Opt_discard_mode, btrfs_parameter_discard),
+	fsparam_u32("metadata_ratio", Opt_ratio),
+	fsparam_flag("rescan_uuid_tree", Opt_rescan_uuid_tree),
+	fsparam_flag("skip_balance", Opt_skip_balance),
+	fsparam_flag_no("space_cache", Opt_space_cache),
+	fsparam_enum("space_cache", Opt_space_cache_version, btrfs_parameter_space_cache),
+	fsparam_flag_no("ssd", Opt_ssd),
+	fsparam_flag_no("ssd_spread", Opt_ssd_spread),
+	fsparam_string("subvol", Opt_subvol),
+	fsparam_flag("subvol=", Opt_subvol_empty),
+	fsparam_u64("subvolid", Opt_subvolid),
+	fsparam_u32("thread_pool", Opt_thread_pool),
+	fsparam_flag_no("treelog", Opt_treelog),
+	fsparam_flag("user_subvol_rm_allowed", Opt_user_subvol_rm_allowed),
+
+	/* Rescue options */
+	fsparam_enum("rescue", Opt_rescue, btrfs_parameter_rescue),
+	/* Deprecated, with alias rescue=nologreplay */
+	__fsparam(NULL, "nologreplay", Opt_nologreplay, fs_param_deprecated,
+		  NULL),
+	/* Deprecated, with alias rescue=usebackuproot */
+	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated,
+		  NULL),
+
+	/* Deprecated options */
+	__fsparam(NULL, "recovery", Opt_recovery,
+		  fs_param_neg_with_no|fs_param_deprecated, NULL),
+
+	/* Debugging options */
+	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
+#ifdef CONFIG_BTRFS_DEBUG
+	fsparam_enum("fragment", Opt_fragment, btrfs_parameter_fragment),
+#endif
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	fsparam_flag("ref_verify", Opt_ref_verify),
+#endif
+	{}
+};
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 			    const char *opt_name)
 {
-- 
2.41.0


