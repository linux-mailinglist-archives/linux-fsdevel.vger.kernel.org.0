Return-Path: <linux-fsdevel+bounces-70461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29886C9BF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 609654E4279
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69009312810;
	Tue,  2 Dec 2025 15:29:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E0266EE9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689365; cv=none; b=Zy6CLZcjfvnQEcfR4xLxCFu05pg8quFOL3JyyrfEYss7SiXtjfDLw9Dt7EoCXPxDHIkrg96m3tUlnXuFOIpzeQIYixdjkttk4gD5tlxB/i1m38zMUJaXm97M9T5/uXOtAxOskcefbLfaTpcU/gUFM6RM+FPNALcMYLZlymnvass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689365; c=relaxed/simple;
	bh=eyYtZnjgmSj7N6JyucblyUpRgv9xinjZ9fEmb5Ogg7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Di4htW+a6dU/Oiy+aIanBgd4dx82K7cKcLldnNJRLB4y/oxBSlpYT7HyypPSBMG4ZDRoVAuIndd3Dl2Kdbx3SGbzGlW+9O4gNfDlW2RQCQgmf9UjEg1POFoyEvOagqrErpqQhCGq4U19L/tOp8VnhhJEherSCj/HUcqhSFchXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6da42fbd4so2345393a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689363; x=1765294163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ugK9BzfdKEv5MeXevEgE8TqgctuA+qOiYTiah6FP+Do=;
        b=R0ZYkSQFRDV7dlOGEXm2asXIfLJY5IJH41KC5XCCae+Arbm64krrZEyPIsyM1/3Iov
         MMfxn10dzAp2WVihxRtNV+ZoeqXEA0xyJfUW2vmk6UbBGpiDqR2yVF1pFkW3OIfvkmAr
         wIQ3rVS8AACxk1C/CxImX5EskFDTCszBs0+oCirJxHXuu4SsA9f4R3npJfHiKOhxsSTb
         I/XXZveOxbKQuCGfWif5M0/lxE6Ld+OpZkvcp4eU/ERr6vwb4mAM0OZCkCKA6kB7pldd
         YGmNjTyNqahh96MunzpLhfFKx4AaB85REgDDPvLtKgR9xHL+6uvi6iZW1FH3BvNhaUnk
         eMig==
X-Forwarded-Encrypted: i=1; AJvYcCVdSjXb+pXm+t/N+RFshuD3dkyYX/DXjH0HvNwleobFTT3UMM4mVBXQnLJQonrC5uqKOH5yI8MT/gd3Dm44@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQhW+MBwxePdWbtLpnCILAGj3dTvVLUJxqliOxlLc7xxhy4iz
	ZBEzlF3rV5Gdz0z5m6jKPQgYCLAMdKYqQnVQoEIMQfLZZBlYDjfHMen3
X-Gm-Gg: ASbGncvkLnaNvVmCn5uX/RdBU5dwF7fbUQyss6rxph9xZGh7HkUyupTy6zoJgiB6Yjn
	KELh+vsDMd+Z0lCkR1umWV1Zsadq3QxkwFs6VU+UUrpH5gF6rVNpLUq/Cfhlnv2o2SenmZ44TF9
	pjzImy3qwH73s7i67Zajd47NO1M4oDsQGiQrKQggrgRctOAuVxWM0ZCPTrYrLzLMc3xHjV4dEC5
	8ci5gatFLItP1r9B+JGvWfCNSO0kv/WBqhlPE0fWlHUBGuU8IOFTp755st7imntAs8PztssBIm/
	9Mhf4qvUJF7nSAOpZ4rXnEHYaQ4wClpD4VXbQTBegRyNDpvOUaI8GIS2VlpA+oeSqCLmrtjDxJ1
	oo2O1SCQOQ0dkgfoRsv5cAz5GnVeBX0RvckpUkdXAjb44F2pXN18HovEX2unqwFers/HuJHHNt+
	AUmNNBXGjpT4kXmw==
X-Google-Smtp-Source: AGHT+IErDABErrz8eCfGq5kVn5Kh7bP3XcLtMbb4d6/GE178cI+lptwmXUf80rsCHF5p4DJECTSpvw==
X-Received: by 2002:a05:6830:2707:b0:7c7:6cc3:c3f2 with SMTP id 46e09a7af769-7c7990754a2mr22586092a34.18.1764689363417;
        Tue, 02 Dec 2025 07:29:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc2b36sm4259177eaf.12.2025.12.02.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:29:23 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Dec 2025 07:29:02 -0800
Subject: [PATCH RFC 2/2] netconsole: Plug to dynamic configfs item
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-configfs_netcon-v1-2-b4738ead8ee8@debian.org>
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
In-Reply-To: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org, 
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, 
 calvin@wbinvd.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5215; i=leitao@debian.org;
 h=from:subject:message-id; bh=eyYtZnjgmSj7N6JyucblyUpRgv9xinjZ9fEmb5Ogg7E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpLwXQ3amUSE+HhXNp0GO31IVPZZ+8x+ktGazRa
 D+XVOIxXu6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaS8F0AAKCRA1o5Of/Hh3
 bc5HEACRuXykG8FbGOoj3HGZt9DAr2MUb9t3kLnZdPKAfjAYgsdp7cLV9M6LiRHm5q2w3GdAOaN
 OfefGSTflmDd0anPvxBziInSd3MAESRFoUtC26/deD3EoYL6n3T4xTrVCLMOUljNrmZ5k0geVJj
 8u2yEZkrSw+twT8Ck+d45YsyivPmnguZWpOJ3dF5u86fjSqOV5KcNDgs0rz3RaaruryLkCwIXGU
 +dyyH06fTJ+/L9aTBGwrRllN/KIsXNOZThXoBZvAbrgw0dTNwUxp6PrjqyTiuYaIQGodTZrkdCQ
 zS2SUSfvjrRU99As4PL5k+F1iPUpl52P4MhCHiI4d7jtLEJ9QZ9FRHGxaUvLOcxwsnur4eL6KXz
 Gbh7A0C/C8n7xEAeNJAxa3CvW0qK6LaAjIpquF2Ed9tZJtFSjBaCkswLgPPwGVJKOFoQx012ZPn
 9cQlkV41sJ5ry6rllTmVkYpQbfBPu5DfLyY4NkT//YhCpJaJen3PVOPsTuKCyO2oIJH740xTaHH
 7u7TQ0mOvEoN5qEJ+MI6dlKLoAxezqY6P0WowbXFGANzTw+vNcIJKNSf5dgC6enD3Pt+Bl3dL8D
 xuFD7RWUSH/aGaLfOmc/N2A4q+3ZI7sNeZuuIs2DuOTUab1IXggte8dUIFoEPLxOm8CE2fAPTU7
 s870h6Uat1ccKXg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert netconsole to use the new configfs kernel-space item
registration API for command-line configured targets.

Previously, netconsole created boot-time targets by searching for them
when userspace tried to create an item with the a special name. This
approach was fragile and hard for users to deal with.

This change refactors netconsole to:
  - Call configfs_register_item() directly from populate_configfs_item()
    to properly register boot/module parameter targets.

  - Remove the find_cmdline_target() logic and the special handling in
    make_netconsole_target() that intercepted userspace operations (aka
    the ugly workaround)

This makes the management of netconsole easier, simplifies the code
(removing ~40 lines) and properly separates kernel-created items from
userspace-created items, making the code more maintainable and robust.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 63 +++++++++++++++++++++------------------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..d3c720a2f9ef 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -225,8 +225,8 @@ static void netconsole_target_put(struct netconsole_target *nt)
 {
 }
 
-static void populate_configfs_item(struct netconsole_target *nt,
-				   int cmdline_count)
+static int populate_configfs_item(struct netconsole_target *nt,
+				  int cmdline_count)
 {
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
@@ -1256,23 +1256,6 @@ static void init_target_config_group(struct netconsole_target *nt,
 	configfs_add_default_group(&nt->userdata_group, &nt->group);
 }
 
-static struct netconsole_target *find_cmdline_target(const char *name)
-{
-	struct netconsole_target *nt, *ret = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list) {
-		if (!strcmp(nt->group.cg_item.ci_name, name)) {
-			ret = nt;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&target_list_lock, flags);
-
-	return ret;
-}
-
 /*
  * Group operations and type for netconsole_subsys.
  */
@@ -1283,19 +1266,6 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 	struct netconsole_target *nt;
 	unsigned long flags;
 
-	/* Checking if a target by this name was created at boot time.  If so,
-	 * attach a configfs entry to that target.  This enables dynamic
-	 * control.
-	 */
-	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
-		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
-		nt = find_cmdline_target(name);
-		if (nt) {
-			init_target_config_group(nt, name);
-			return &nt->group;
-		}
-	}
-
 	nt = alloc_and_init();
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
@@ -1351,14 +1321,20 @@ static struct configfs_subsystem netconsole_subsys = {
 	},
 };
 
-static void populate_configfs_item(struct netconsole_target *nt,
-				   int cmdline_count)
+static int populate_configfs_item(struct netconsole_target *nt,
+				  int cmdline_count)
 {
 	char target_name[16];
+	int ret;
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
+
 	init_target_config_group(nt, target_name);
+
+	ret = configfs_register_item(&netconsole_subsys.su_group,
+				     &nt->group.cg_item);
+	return ret;
 }
 
 static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
@@ -1899,7 +1875,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	} else {
 		nt->enabled = true;
 	}
-	populate_configfs_item(nt, cmdline_count);
+	err = populate_configfs_item(nt, cmdline_count);
+	if (err)
+		goto fail;
 
 	return nt;
 
@@ -1911,6 +1889,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	if (nt->group.cg_item.ci_dentry)
+		configfs_unregister_item(&nt->group.cg_item);
 	netpoll_cleanup(&nt->np);
 	kfree(nt);
 }
@@ -1937,6 +1917,10 @@ static int __init init_netconsole(void)
 	char *target_config;
 	char *input = config;
 
+	err = dynamic_netconsole_init();
+	if (err)
+		goto exit;
+
 	if (strnlen(input, MAX_PARAM_LENGTH)) {
 		while ((target_config = strsep(&input, ";"))) {
 			nt = alloc_param_target(target_config, count);
@@ -1966,10 +1950,6 @@ static int __init init_netconsole(void)
 	if (err)
 		goto fail;
 
-	err = dynamic_netconsole_init();
-	if (err)
-		goto undonotifier;
-
 	if (console_type_needed & CONS_EXTENDED)
 		register_console(&netconsole_ext);
 	if (console_type_needed & CONS_BASIC)
@@ -1978,10 +1958,8 @@ static int __init init_netconsole(void)
 
 	return err;
 
-undonotifier:
-	unregister_netdevice_notifier(&netconsole_netdev_notifier);
-
 fail:
+	dynamic_netconsole_exit();
 	pr_err("cleaning up\n");
 
 	/*
@@ -1993,6 +1971,7 @@ static int __init init_netconsole(void)
 		list_del(&nt->list);
 		free_param_target(nt);
 	}
+exit:
 
 	return err;
 }

-- 
2.47.3


