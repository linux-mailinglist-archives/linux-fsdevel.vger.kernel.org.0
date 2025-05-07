Return-Path: <linux-fsdevel+bounces-48317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469EEAAD414
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CFC4A66AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 03:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24B1B4223;
	Wed,  7 May 2025 03:29:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66E4B1E6E;
	Wed,  7 May 2025 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746588594; cv=none; b=KcEYv+rIdZJ/GfZjs1bGBnx7VpItvhSGqh4uIcp+zmG4FyEQIWc9VPMTwPHeEFN0wtWoEricNcf4zM9YmyaeSGopMVdNgFg0x7wWGiMIlsZg44DzVI3C1yomonaKpLomkVP4J1CNwuDfZwUDh/UzZc2oQk/PiNrATVPl3wIFszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746588594; c=relaxed/simple;
	bh=SsOjyC0fSoz0aUaIwyLLRPpSr+ECLIqRCAOgAdzFcig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8DzPEINiXMMUom8RDAq8yO9REhogH7QBQdPS431ogUxmX4J50Ld2Xud8PZuXCEzKQS9eWJIwxdLUKYbz1rj5cwbgeL1RIsuxT8XP69TcARjkwGftITrlGDT1hxMryYUQNTxOe+790qxO83wCa5Vdm6ykkHZwjY6b70kyPcygn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476b89782c3so77171401cf.1;
        Tue, 06 May 2025 20:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746588591; x=1747193391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhyJoa33VSlr8DNl92n1JgDZJE/qHuGtkq4qYZ1ObzU=;
        b=jh/hMCUH/T3zQgG+FuRgHW2oWz/Hy2kRsbzKRBdH9uNSRO/16kEOH1tJ0Xxl4Ov6RG
         uVyGRR/19ryvu6WfNVafMGSu7C6WQo2trWYvyExe7FZWjSEwyefVZs1A11lLditSS9xa
         fa0QmfGmJk0NNoTj9GydFHRE7l0lGahP0UdznzRihcSUMndWjUxBHconSv7lV7lp5Fm1
         WHduP4boUlx0RYcFx3iTyQeOH3rYAB2Jzh5/58PI5g/Il1Nxa7HJwh1R+M/kwLxeGDGe
         X0bvRLNdZiN5mmqu1JTDVLL07hLr1DSUukquHL3rKw3TlrC5u48eut9eUBZdxIZJ9aMN
         8kzA==
X-Forwarded-Encrypted: i=1; AJvYcCXiXOHykyRDHfmw5lZPPB4VMV84e4bAwfyyx2V2rIsQV+6RC+BLBgtz/sxxdjb5QQHeV1rwAzYehybi1d2J@vger.kernel.org, AJvYcCXyiqFgd5ncnL7NPougFqqqMD2YflJYHNfk1Yz1WniN01NwTp2EDkFAaKMKBaQxqa+lVVKp7+0eFHa6V56u@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8mxNbvW4/Zz26w1nNmJ7luP51QHMkKlFKL8s/MN2I/p4birY
	V0izyQKoyIQqFEIUJipBrzwfpGtbOER/cMDfCOGE9Z/nxFxtG0HzaXF663+SciPyiw==
X-Gm-Gg: ASbGncvlSBgneG7Cg2adp47+KOIBEv4LdTlwcd+E7HRerLjEpcLVMcEj+JL+NhgnVnl
	+KjpBBDxJV+BP5Whk6tk46a+IFP9dGMSSngR9Pr4x0v72gJxCMmAwZgQHzYuks1WOeXbHnoNye9
	z0dZ882CccV1j9NJvzSlW8+eEIHrDAz4Yx1cCvjXGFsq1/leT51P0YA6t5fYh5DtNX8D9GmPFJE
	4DizWxXgZnikH2p7/ztIGp0/iXjPsaxDzTyzLlv4hOw0Jy2PSgsH1I0JY5IhuM4OU70k9LECMxc
	6cf/HZWgmlx6hIYc8Qx8ew+L7hiO2BhV4BqAMO8z1IKQw1D/hyiW1W3qyRs1v1e8XcvJXTYw2As
	u
X-Google-Smtp-Source: AGHT+IGFepTvcsM374DSJfuhV05DGBUPjhEEx5ODx9BYqFHSFHlSAMB9YVmKKthuQAKepKRuj4XJiw==
X-Received: by 2002:a05:622a:191c:b0:48d:cac2:9432 with SMTP id d75a77b69052e-49225d25179mr28122361cf.21.1746588591006;
        Tue, 06 May 2025 20:29:51 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49222e9580dsm7438011cf.57.2025.05.06.20.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:29:50 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] fs: fuse: add backing_files control file
Date: Wed,  7 May 2025 11:29:26 +0800
Message-ID: <20250507032926.377076-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
that exposes the paths of all backing files currently being used in
FUSE mount points. This is particularly valuable for tracking and
debugging files used in FUSE passthrough mode.

This approach is similar to how fixed files in io_uring expose their
status through fdinfo, providing administrators with visibility into
backing file usage. By making backing files visible through the FUSE
control filesystem, administrators can monitor which files are being
used for passthrough operations and can force-close them if needed by
aborting the connection.

This exposure of backing files information is an important step towards
potentially relaxing CAP_SYS_ADMIN requirements for certain passthrough
operations in the future, allowing for better security analysis of
passthrough usage patterns.

The control file is implemented using the seq_file interface for
efficient handling of potentially large numbers of backing files.
Access permissions are set to read-only (0400) as this is an
informational interface.

FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate the
additional control file.

Some related discussions can be found at:

Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca519@fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/

Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

---
Please review this patch carefully. I am new to kernel development and
I am not quite sure if I have followed the best practices, especially
in terms of seq_file, error handling and locking. I would appreciate
any feedback.

I have do some simply testing using libfuse example [1]. It seems to
work well.

[1]: https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.cc
---
 fs/fuse/control.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h  |   2 +-
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2a730d88cc3bd..4d1e0acc5030f 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs_context.h>
+#include <linux/seq_file.h>
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
 
@@ -180,6 +181,129 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	return ret;
 }
 
+struct fuse_backing_files_seq_state {
+	struct fuse_conn *fc;
+	int pos;
+};
+
+static void *fuse_backing_files_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct fuse_backing_files_seq_state *state = seq->private;
+	struct fuse_conn *fc = state->fc;
+
+	if (!fc)
+		return NULL;
+
+	spin_lock(&fc->lock);
+
+	if (*pos > idr_get_cursor(&fc->backing_files_map)) {
+		spin_unlock(&fc->lock);
+		return NULL;
+	}
+
+	state->pos = *pos;
+	return state;
+}
+
+static void *fuse_backing_files_seq_next(struct seq_file *seq, void *v,
+					 loff_t *pos)
+{
+	struct fuse_backing_files_seq_state *state = seq->private;
+
+	(*pos)++;
+	state->pos = *pos;
+
+	if (state->pos > idr_get_cursor(&state->fc->backing_files_map)) {
+		spin_unlock(&state->fc->lock);
+		return NULL;
+	}
+
+	return state;
+}
+
+static int fuse_backing_files_seq_show(struct seq_file *seq, void *v)
+{
+	struct fuse_backing_files_seq_state *state = seq->private;
+	struct fuse_conn *fc = state->fc;
+	struct fuse_backing *fb;
+
+	fb = idr_find(&fc->backing_files_map, state->pos);
+	if (!fb || !fb->file)
+		return 0;
+
+	seq_file_path(seq, fb->file, " \t\n\\");
+	seq_puts(seq, "\n");
+
+	return 0;
+}
+
+static void fuse_backing_files_seq_stop(struct seq_file *seq, void *v)
+{
+	struct fuse_backing_files_seq_state *state = seq->private;
+
+	if (v)
+		spin_unlock(&state->fc->lock);
+}
+
+static const struct seq_operations fuse_backing_files_seq_ops = {
+	.start = fuse_backing_files_seq_start,
+	.next = fuse_backing_files_seq_next,
+	.stop = fuse_backing_files_seq_stop,
+	.show = fuse_backing_files_seq_show,
+};
+
+static int fuse_backing_files_seq_open(struct inode *inode, struct file *file)
+{
+	struct fuse_conn *fc;
+	struct fuse_backing_files_seq_state *state;
+	int err;
+
+	fc = fuse_ctl_file_conn_get(file);
+	if (!fc)
+		return -ENOTCONN;
+
+	err = seq_open(file, &fuse_backing_files_seq_ops);
+	if (err) {
+		fuse_conn_put(fc);
+		return err;
+	}
+
+	state = kmalloc(sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		seq_release(file->f_inode, file);
+		fuse_conn_put(fc);
+		return -ENOMEM;
+	}
+
+	state->fc = fc;
+	state->pos = 0;
+	((struct seq_file *)file->private_data)->private = state;
+
+	return 0;
+}
+
+static int fuse_backing_files_seq_release(struct inode *inode,
+					  struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct fuse_backing_files_seq_state *state = seq->private;
+
+	if (state) {
+		fuse_conn_put(state->fc);
+		kfree(state);
+		seq->private = NULL;
+	}
+
+	return seq_release(inode, file);
+}
+
+static const struct file_operations fuse_conn_passthrough_backing_files_ops = {
+	.open = fuse_backing_files_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = fuse_backing_files_seq_release,
+};
+
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
 	.write = fuse_conn_abort_write,
@@ -270,7 +394,10 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
 				 S_IFREG | 0600, 1, NULL,
-				 &fuse_conn_congestion_threshold_ops))
+				 &fuse_conn_congestion_threshold_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "backing_files", S_IFREG | 0400, 1,
+				 NULL,
+				 &fuse_conn_passthrough_backing_files_ops))
 		goto err;
 
 	return 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d56d4fd956db9..2830b05bb0928 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -46,7 +46,7 @@
 #define FUSE_NAME_MAX (PATH_MAX - 1)
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /* Frequency (in seconds) of request timeout checks, if opted into */
 #define FUSE_TIMEOUT_TIMER_FREQ 15
-- 
2.43.0


