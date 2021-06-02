Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB1398D73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhFBOuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 10:50:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42528 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhFBOt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:49:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id v13so1214537ple.9;
        Wed, 02 Jun 2021 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVbiioOCcOcyQ1wfFSkXAav6hw3gHoT6PQtqxVwJtos=;
        b=Ed3Ts1RN+DIPGKvDGNZ63Q2q9KbJdlj50HkhcgroPktbcIy7kRj+I27WbaUyjtGK4C
         lmhuhGjQ4v3kPADCOc2zMs0gPqVL2t4axB0dTtq9JmobkotB+sgFelgkDe0vMOiRoyQ7
         RuHZr+shnzLJzlxBnnN0DrGouICaEwtfVOUzhvWQB4yhH2o25LUhH+az/5x+9FW5i1f8
         fAcvoNyjS72IqLwE8oQqiwJXSb/IofTuQMmKSOGxLvFDUoj00Q7Ua05aXpCEuZJ99xWW
         rOruciGtHPTCSJztAashQzkbL2qOMFW92U6GeT8sYAD/FEp3k4XKBbNAXgsc25iWXVMk
         0Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVbiioOCcOcyQ1wfFSkXAav6hw3gHoT6PQtqxVwJtos=;
        b=a0DzDr5Gc6wqtd7+KSzSdHD1sqs2II0aKTMBGZVLWVXzZj7/3jnt6C+kZ0ZOR3VmlW
         w8PkJ3OiypGUfoXYE9AIB4GlvMRXNJRT/Tpy3Dv8HyjGbhJ+DQb0q/EeWYCfiTYLn2w0
         Os4cBHGhfLaW2Z/S2MC5jQ5RsozOaSjsrW0IpqwwIHc6tOewLJVLZaSVqRNXRDdmjtB9
         N+Wia2VJdCG+xvLJFDvXy5YCpdPjavkQYXqlh6cp8Y7ahAhfNWrxecWlfdXkNpv6Dfco
         oPJbSN+0sz9QWOc3AsTUyqLFBdo+NYXURoly5W6agXkSBwx+AHugkJ7xzk2DlMD95Ncb
         qHRw==
X-Gm-Message-State: AOAM5316/fuV3dwM8xOsQudWbHzUJx1DGHsbCdnGOqwJKhf/E2WhlS7A
        vZdLGqLtPiV0StiTWHo31BU=
X-Google-Smtp-Source: ABdhPJxl+7iCOUsaiyRv/SFrxt248HFsWs3hiUFr5CmaTJKN7SYNd+BpRcthFwjAdtgiMxQkixsr7w==
X-Received: by 2002:a17:902:eb05:b029:fe:e0fa:e1f1 with SMTP id l5-20020a170902eb05b02900fee0fae1f1mr18555789plb.10.1622645236725;
        Wed, 02 Jun 2021 07:47:16 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id r135sm7315441pfc.184.2021.06.02.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:47:16 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        akpm@linux-foundation.org, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, joe@perches.com, hare@suse.de,
        axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        brho@google.com, mcgrof@kernel.org, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, pmladek@suse.com,
        glider@google.com, chris@chrisdown.name, ebiederm@xmission.com,
        jojing64@gmail.com, mingo@kernel.org, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v4 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Date:   Wed,  2 Jun 2021 22:46:30 +0800
Message-Id: <20210602144630.161982-4-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210602144630.161982-1-dong.menglong@zte.com.cn>
References: <20210602144630.161982-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

As for the existence of second mount which is introduced in previous
patch, 'rootfs_fs_type', which is used as the root of mount tree, is
not used directly any more. So it make no sense to make it tmpfs
while 'CONFIG_INITRAMFS_MOUNT' is enabled.

Make 'rootfs_fs_type' ramfs when 'CONFIG_INITRAMFS_MOUNT' enabled.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 include/linux/init.h |  4 ++++
 init/do_mounts.c     | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 045ad1650ed1..45ab6970851f 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -148,7 +148,11 @@ extern unsigned int reset_devices;
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
+#ifndef CONFIG_INITRAMFS_MOUNT
 void __init init_rootfs(void);
+#else
+static inline void __init init_rootfs(void) { }
+#endif
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5f82db43ac0f..fcdc849a102a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -700,7 +700,10 @@ void __init finish_mount_rootfs(bool success)
 	init_chdir("/");
 	init_umount(".", 0);
 }
-#endif
+
+#define rootfs_init_fs_context ramfs_init_fs_context
+
+#else
 
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
@@ -711,13 +714,14 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 	return ramfs_init_fs_context(fc);
 }
 
+void __init init_rootfs(void)
+{
+	is_tmpfs = check_tmpfs_enabled();
+}
+#endif
+
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
 	.init_fs_context = rootfs_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
-
-void __init init_rootfs(void)
-{
-	is_tmpfs = check_tmpfs_enabled();
-}
-- 
2.32.0.rc0

