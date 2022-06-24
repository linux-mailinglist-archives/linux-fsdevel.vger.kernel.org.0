Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD885594D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiFXIEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFXIEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:04:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E696DB1F;
        Fri, 24 Jun 2022 01:04:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c13so2291785eds.10;
        Fri, 24 Jun 2022 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltQpZ7oW1QsVH1f1jCapXhBdDu/pMzI69BR3W0aWJiY=;
        b=BCLBGzCDM3dicFZ1OGIFkOsdf2V521mMysBEJ9iinveVKjuPTsLrqFdJi734Z1uZvp
         BrIl/Z9vn8vFkyDOHWmnKxo21xK+tLMDYTST34w4v8TV5nWFn9JLHMcOYZM1aHPYbEeD
         282A6fO+GqmoGy5VHzTzkXXC9jDOLaPtweOGDMSO0oqWtHIb7gpQJUaCuMu88rOwe2BD
         crWt+l2Vv9WpcgtJbnfxcqiFAzAJtXlpuRnoAfr2x/1dRrw8Nn1n/TUXtsDtfcmdgOF3
         YGwme/GeeP+MA8N7frvR6cGiLzhNFciaj5ku28X9lFYuS1JLv1ymQIO3PkoxpTVbMdZb
         ASwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltQpZ7oW1QsVH1f1jCapXhBdDu/pMzI69BR3W0aWJiY=;
        b=HsnKklqGansfj6eK746gbdtvmKUy2bgIyfHJlKIBzNDQa9RxUayF8ROtsCXYtcSa8g
         V0Ws6MGYGy0wp/5E+ZZTpkUp8s5DEYt9ucGHEttuSMsPSUMieKabDqY4JchwezTJxQ6R
         PTf1PMyMjU/rpXZWzr3GH8vosLzAQ2UXj7P9pwq6C61odaK+gwJaQZRIdYt+597pKP/X
         0fO5xgwrJ0G+8aQIrPVu7579hcEAQjFiUZNvCYSUbUbUyWwKmNCpo1/4neZ8EIhcWefD
         rxzljUS+gJ4u2T9dvpY9DPseB/GGI3twXBvluBl/6GHA9SK4SDHtcSSFVNPzoy69VyJw
         M9Sg==
X-Gm-Message-State: AJIora90tcyC23kMhQQ00EsBOAKgNRhNGkudk8NSmdvTkwNqcYYCCVsk
        sKvF5MGCxa5IOAwLeGBQBKT9zdnUahM=
X-Google-Smtp-Source: AGRyM1vqTm2oWNscqLmlMW8s9dcXBhWIE7N6JaZpirobITGNlD2rMAul00q8pM0x95n+ay4p5Kh9SQ==
X-Received: by 2002:a05:6402:358c:b0:435:9daf:e825 with SMTP id y12-20020a056402358c00b004359dafe825mr16018406edc.375.1656057889076;
        Fri, 24 Jun 2022 01:04:49 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:48 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 01/14] fs: add per file RSS
Date:   Fri, 24 Jun 2022 10:04:31 +0200
Message-Id: <20220624080444.7619-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080444.7619-1-christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Some files allocate large amounts of memory on behalf of userspace without
any on disk backing store. This memory isn't necessarily mapped into the
address space, but should still accounts towards the RSS of a process just
like mapped shared pages do.

That information can then be used by the OOM killer to make better
decisions which process to reap.

For easy debugging this also adds printing of the per file RSS to fdinfo.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 fs/file.c               | 23 +++++++++++++++++++++++
 fs/proc/fd.c            |  3 +++
 include/linux/fdtable.h |  1 +
 include/linux/fs.h      |  1 +
 4 files changed, 28 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 3bcc1ecc314a..b58730a513be 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1307,3 +1307,26 @@ int iterate_fd(struct files_struct *files, unsigned n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+static int sumup_file_rss(const void *sum, struct file *file, unsigned n)
+{
+	if (!file->f_op->file_rss)
+		return 0;
+
+	*((unsigned long *)sum) += file->f_op->file_rss(file);
+	return 0;
+}
+
+/**
+ * files_rss- how much resources are bound by opened files
+ * @files: opened files
+ *
+ * Returns sum of all resources bound by files not accounted in file systems.
+ */
+unsigned long files_rss(struct files_struct *files)
+{
+	unsigned long sum = 0;
+
+	iterate_fd(files, 0, sumup_file_rss, &sum);
+	return sum;
+}
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 913bef0d2a36..9943bfca74f7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -59,6 +59,9 @@ static int seq_show(struct seq_file *m, void *v)
 		   real_mount(file->f_path.mnt)->mnt_id,
 		   file_inode(file)->i_ino);
 
+	if (file->f_op->file_rss)
+		seq_printf(m, "rss:\t%lu\n", file->f_op->file_rss(file));
+
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..101770266f38 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -122,6 +122,7 @@ void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
+unsigned long files_rss(struct files_struct *files);
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..edacbdce5e4c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2003,6 +2003,7 @@ struct file_operations {
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
+	long (*file_rss)(struct file *);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.25.1

