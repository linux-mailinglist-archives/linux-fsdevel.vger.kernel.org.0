Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAF5BD39B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiISRZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiISRZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:25:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DD1E3C0;
        Mon, 19 Sep 2022 10:25:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so27363789pgb.4;
        Mon, 19 Sep 2022 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=euAaknLa+h5zIEMESHSd9vMo0x33lOPRlPldQOSO1tY=;
        b=ShNlkKcjQX74zNjF0cFpDDUgQjKD8DIkh4EVc7Mv0LXsJafE4SY2OEYjaXtaX6yg8Z
         8PJonHc9SvScgzKL+dfAAtAzN5E0QOm7TMiGh2Ekv8ph4CTYvq458StXhFk/3SPwMm3F
         pBPxy2kCWa/AcGmxcGJKEWMGDaIOsTcrM8xaBFKZCvGgwW/IdONn/pVcY4Fow5+4aJSw
         0cPtz24cRa12OPlbcMKQngJjGnF67wogF9OE5broq9HuQhZ3ydOxsJpbUfpIjX0ugOuw
         N27BvSJhGKXz03wnL1LZqtd0vyEKXZjs3SigU8Kfz8DrsmsoOySbz9GKYKX7CBuDtB/Q
         lnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=euAaknLa+h5zIEMESHSd9vMo0x33lOPRlPldQOSO1tY=;
        b=23UQn5e3Aua4IwfPxPJe0jVDodaXO/0MFLAyLkVyii6rFwg59qTWJdqwhVYxotOOfl
         SR5bpWUCGdear9c0LbUcu8J8eETh3lHNOE2slv2z2m7gtvDW0rs9PypU4Dpdko+8QHSQ
         bHjh6dwrRFHGQwvtHHYud0Q5XkV6+VBuh3+pogzSD6hSR/mCpVV0y88OYcQENdp8JAoV
         tJEmSanSBEomeWUa3K6OhBhHhozfxVi+0dvXZLePwcRzt8H02j9X+Y2Md5UMGWDY3GgR
         v+u8LT/K9MmNSyYiG0acD/V+DcdDjgfT+TeAur9N9239GCRiC+Of8Px74+DB+CTQ9wfC
         4vRw==
X-Gm-Message-State: ACrzQf0dczm7oHhkpRZVL9Lt4IOU5CEny4LaLYFTlaaM1DVTfgVklC5w
        0+cnziL+XlYNk5WdenPMtZ+9JpKa6nA=
X-Google-Smtp-Source: AMsMyM6OTf8JGt0/2O1PiJjtsm9iJk3G5nddptF65VkDZixrBOW+hXa9Ea4CpUGY12LhhkBrwX/ErA==
X-Received: by 2002:a63:b64:0:b0:439:8143:c184 with SMTP id a36-20020a630b64000000b004398143c184mr16377617pgl.22.1663608301881;
        Mon, 19 Sep 2022 10:25:01 -0700 (PDT)
Received: from localhost.localdomain (KD027092233113.ppp-bb.dion.ne.jp. [27.92.233.113])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b0053f2505318asm21226480pfq.142.2022.09.19.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:25:01 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 3/3] debugfs: fix error when writing negative value to atomic_t debugfs file
Date:   Tue, 20 Sep 2022 02:24:18 +0900
Message-Id: <20220919172418.45257-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919172418.45257-1-akinobu.mita@gmail.com>
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The simple attribute files do not accept a negative value since the
commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), so we have to use a 64-bit value to write a
negative value for a debugfs file created by debugfs_create_atomic_t().

This restores the previous behaviour by introducing
DEFINE_DEBUGFS_ATTRIBUTE_SIGNED for a signed value.

Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 .../fault-injection/fault-injection.rst       | 10 +++----
 fs/debugfs/file.c                             | 28 +++++++++++++++----
 include/linux/debugfs.h                       | 19 +++++++++++--
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 17779a2772e5..5f6454b9dbd4 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -83,9 +83,7 @@ configuration of fault-injection capabilities.
 - /sys/kernel/debug/fail*/times:
 
 	specifies how many times failures may happen at most. A value of -1
-	means "no limit". Note, though, that this file only accepts unsigned
-	values. So, if you want to specify -1, you better use 'printf' instead
-	of 'echo', e.g.: $ printf %#x -1 > times
+	means "no limit".
 
 - /sys/kernel/debug/fail*/space:
 
@@ -284,7 +282,7 @@ Application Examples
     echo Y > /sys/kernel/debug/$FAILTYPE/task-filter
     echo 10 > /sys/kernel/debug/$FAILTYPE/probability
     echo 100 > /sys/kernel/debug/$FAILTYPE/interval
-    printf %#x -1 > /sys/kernel/debug/$FAILTYPE/times
+    echo -1 > /sys/kernel/debug/$FAILTYPE/times
     echo 0 > /sys/kernel/debug/$FAILTYPE/space
     echo 2 > /sys/kernel/debug/$FAILTYPE/verbose
     echo Y > /sys/kernel/debug/$FAILTYPE/ignore-gfp-wait
@@ -338,7 +336,7 @@ Application Examples
     echo N > /sys/kernel/debug/$FAILTYPE/task-filter
     echo 10 > /sys/kernel/debug/$FAILTYPE/probability
     echo 100 > /sys/kernel/debug/$FAILTYPE/interval
-    printf %#x -1 > /sys/kernel/debug/$FAILTYPE/times
+    echo -1 > /sys/kernel/debug/$FAILTYPE/times
     echo 0 > /sys/kernel/debug/$FAILTYPE/space
     echo 2 > /sys/kernel/debug/$FAILTYPE/verbose
     echo Y > /sys/kernel/debug/$FAILTYPE/ignore-gfp-wait
@@ -369,7 +367,7 @@ Application Examples
     echo N > /sys/kernel/debug/$FAILTYPE/task-filter
     echo 100 > /sys/kernel/debug/$FAILTYPE/probability
     echo 0 > /sys/kernel/debug/$FAILTYPE/interval
-    printf %#x -1 > /sys/kernel/debug/$FAILTYPE/times
+    echo -1 > /sys/kernel/debug/$FAILTYPE/times
     echo 0 > /sys/kernel/debug/$FAILTYPE/space
     echo 1 > /sys/kernel/debug/$FAILTYPE/verbose
 
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 950c63fa4d0b..38930d9b0bb7 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -378,8 +378,8 @@ ssize_t debugfs_attr_read(struct file *file, char __user *buf,
 }
 EXPORT_SYMBOL_GPL(debugfs_attr_read);
 
-ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
-			 size_t len, loff_t *ppos)
+static ssize_t debugfs_attr_write_xsigned(struct file *file, const char __user *buf,
+			 size_t len, loff_t *ppos, bool is_signed)
 {
 	struct dentry *dentry = F_DENTRY(file);
 	ssize_t ret;
@@ -387,12 +387,28 @@ ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 	ret = debugfs_file_get(dentry);
 	if (unlikely(ret))
 		return ret;
-	ret = simple_attr_write(file, buf, len, ppos);
+	if (is_signed)
+		ret = simple_attr_write_signed(file, buf, len, ppos);
+	else
+		ret = simple_attr_write(file, buf, len, ppos);
 	debugfs_file_put(dentry);
 	return ret;
 }
+
+ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
+			 size_t len, loff_t *ppos)
+{
+	return debugfs_attr_write_xsigned(file, buf, len, ppos, false);
+}
 EXPORT_SYMBOL_GPL(debugfs_attr_write);
 
+ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
+			 size_t len, loff_t *ppos)
+{
+	return debugfs_attr_write_xsigned(file, buf, len, ppos, true);
+}
+EXPORT_SYMBOL_GPL(debugfs_attr_write_signed);
+
 static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
 					struct dentry *parent, void *value,
 					const struct file_operations *fops,
@@ -738,11 +754,11 @@ static int debugfs_atomic_t_get(void *data, u64 *val)
 	*val = atomic_read((atomic_t *)data);
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t, debugfs_atomic_t_get,
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic_t, debugfs_atomic_t_get,
 			debugfs_atomic_t_set, "%lld\n");
-DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t_ro, debugfs_atomic_t_get, NULL,
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic_t_ro, debugfs_atomic_t_get, NULL,
 			"%lld\n");
-DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic_t_wo, NULL, debugfs_atomic_t_set,
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(fops_atomic_t_wo, NULL, debugfs_atomic_t_set,
 			"%lld\n");
 
 /**
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index f60674692d36..ea2d919fd9c7 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -45,7 +45,7 @@ struct debugfs_u32_array {
 
 extern struct dentry *arch_debugfs_dir;
 
-#define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt)		\
+#define DEFINE_DEBUGFS_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, __is_signed)	\
 static int __fops ## _open(struct inode *inode, struct file *file)	\
 {									\
 	__simple_attr_check_format(__fmt, 0ull);			\
@@ -56,10 +56,16 @@ static const struct file_operations __fops = {				\
 	.open	 = __fops ## _open,					\
 	.release = simple_attr_release,					\
 	.read	 = debugfs_attr_read,					\
-	.write	 = debugfs_attr_write,					\
+	.write	 = (__is_signed) ? debugfs_attr_write_signed : debugfs_attr_write,	\
 	.llseek  = no_llseek,						\
 }
 
+#define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt)		\
+	DEFINE_DEBUGFS_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, false)
+
+#define DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(__fops, __get, __set, __fmt)	\
+	DEFINE_DEBUGFS_ATTRIBUTE_XSIGNED(__fops, __get, __set, __fmt, true)
+
 typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
 
 #if defined(CONFIG_DEBUG_FS)
@@ -102,6 +108,8 @@ ssize_t debugfs_attr_read(struct file *file, char __user *buf,
 			size_t len, loff_t *ppos);
 ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *ppos);
+ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
+			size_t len, loff_t *ppos);
 
 struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, const char *new_name);
@@ -254,6 +262,13 @@ static inline ssize_t debugfs_attr_write(struct file *file,
 	return -ENODEV;
 }
 
+static inline ssize_t debugfs_attr_write_signed(struct file *file,
+					const char __user *buf,
+					size_t len, loff_t *ppos)
+{
+	return -ENODEV;
+}
+
 static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, char *new_name)
 {
-- 
2.34.1

