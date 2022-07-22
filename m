Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC12F57D899
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiGVCZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 22:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiGVCY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999E97A2C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:45 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E2E3E3F132
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 02:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456682;
        bh=21lfF1OMKLeXFtULRWjRtXARMWFjMfI3d/p5JlAEia8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=j7ypn63L/VZft1Xt+AoQ482eB7JitZn+eM2kBk8QMadfswfT/mLTK6SvKcH3JwDkz
         nM120srDsJ/L1UR9dQ65B4t/4DabA+thQAq3w9btgSI+baFtysaOyHxngjPfiTz2vr
         ZBqMR3zUL4zFoELRQiD3pM8Yxu54+ZECTm8eyM4jXjL9zFHBrJIfKRb9vbuc6ULzzW
         NwSTiH5cGN+38TF7TlwSGkOg26CisYbRndE3CneAy4YLrbPWvtl/Ct7NH7+wLSH90x
         bFlt+nfV3Kyo/Wtn6XkhxYu0UFJv3MOhBqLQ9iB/Ocv523zotPglJFYBQKHS0MXaFu
         mX2nbWUXIFdPQ==
Received: by mail-oi1-f200.google.com with SMTP id i128-20020acaea86000000b00335a8dbcdd7so1679835oih.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21lfF1OMKLeXFtULRWjRtXARMWFjMfI3d/p5JlAEia8=;
        b=3QZxi/vMVvOLqXbSMO/6oJkqDloVuTbRQceAu14KpMCvpvpLs52cWJPxxnFAYL/P5d
         2iHXjPOlsO2iXSXAVG6W/YlDm30oIT5bL4wBTfgBCJsJIgJQkK6tamVky77axwXInOMi
         vq3bWLdraYCeESuZP2mJ/v9PhEgiZaSIh4uxyABp3+zFZJO72d7J5+Yyb9YDiGhYqD1V
         d1nMC2gyO02HUKldmRkMch/oJbJgBV/RuTL2msM7JgMoW9mEcG4ezX/mpv8ff9KHmG7+
         iM4yJErxmcsKHxe3IBZmF9tLzuNq47IO5aLp+DcbDwnOLuGPmhI7buSbKiQ4hEsKFBiO
         +DtA==
X-Gm-Message-State: AJIora91Wv7sV44cEMm35W6tmuo8xPHa/o67lXkxhfPGv9baH37lSA9Z
        LrQgGCRm81CMGkCVURk2gPp0DQflR58CYMBoNaaD2Nq7EtJyD4iGMbsD7w77BewMzqDCdkBI/KY
        S2KZFyKV35V95iNvf1ALtcduz6fSwkSrpsHIQoz3m+I0=
X-Received: by 2002:a05:6870:9691:b0:10d:4e09:6d0d with SMTP id o17-20020a056870969100b0010d4e096d0dmr620837oaq.54.1658456682544;
        Thu, 21 Jul 2022 19:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uvU9qJw3xZdY8qLtAMfrO1WVNCSVRdNA2PSo7g3N3dxoTLVc+Yd1R+zm9uxw3Fm3r+ZL9hVg==
X-Received: by 2002:a05:6870:9691:b0:10d:4e09:6d0d with SMTP id o17-20020a056870969100b0010d4e096d0dmr620824oaq.54.1658456682346;
        Thu, 21 Jul 2022 19:24:42 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:41 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 6/6] sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias
Date:   Thu, 21 Jul 2022 23:24:16 -0300
Message-Id: <20220722022416.137548-7-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal of the earlier patches is to let sysctl userspace tools
load the kernel module with a sysctl entry that is not available
yet in /proc/sys/ when the tool runs (so it can become available).

Let's expose this file for userspace for two reasons:

1) Allow such tools to identify that the running kernel has the
   code which produces sysctl module aliases, so they could run
   'modprobe sysctl:<entry>' only when it may actually help.

2) Allow an administrator to hint such tools not to do that, if
   that is desired for some reason (e.g., rather have the tools
   fail if something is misconfigured in a critical deployment).

Also add a module parameter for that (proc.modprobe_sysctl_alias),
for another method that doesn't depend on sysctl tools to be set
(that wouldn't fail them to try and set it if it's not there yet).

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/proc/proc_sysctl.c  | 8 ++++++++
 include/linux/module.h | 1 +
 kernel/sysctl.c        | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index ebbf8702387e..1e63819fcda8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -33,6 +33,14 @@ static void check_struct_sysctl_device_id(void)
 	BUILD_BUG_ON(offsetof(struct sysctl_device_id, procname)
 			!= offsetof(struct ctl_table, procname));
 }
+
+/*
+ * Hint sysctl userspace tools whether or not to run modprobe with sysctl alias
+ * ('modprobe sysctl:entry') if they cannot find the file '/proc/sys/.../entry'
+ */
+int modprobe_sysctl_alias = 1;
+module_param(modprobe_sysctl_alias, int, 0644);
+
 #else
 static void check_struct_sysctl_device_id(void) {}
 #endif
diff --git a/include/linux/module.h b/include/linux/module.h
index 3010f687df19..5f565491c596 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -304,6 +304,7 @@ struct notifier_block;
 #ifdef CONFIG_MODULES
 
 extern int modules_disabled; /* for sysctl */
+extern int modprobe_sysctl_alias; /* for proc sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 15073621cfa8..b396cfcb55fc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1763,6 +1763,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dostring,
 	},
+#ifdef CONFIG_PROC_SYSCTL
+	{
+		.procname	= "modprobe_sysctl_alias",
+		.data		= &modprobe_sysctl_alias,
+		.maxlen		= sizeof(modprobe_sysctl_alias),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif
 	{
 		.procname	= "modules_disabled",
 		.data		= &modules_disabled,
-- 
2.25.1

