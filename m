Return-Path: <linux-fsdevel+bounces-1170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508A7D6DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A45D1C20DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8406B28E15;
	Wed, 25 Oct 2023 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT2LfIBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13AF28E02
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:02:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1C193
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698242534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOOGhallOPxnWGST34MdPR6LpOdkhm6q6XmykKHjQ0c=;
	b=gT2LfIBMmQ8sCCKPzUxLcI7wq6s2aIyE98U06NzNmSIBPseLsePeYNdg0v+gQLgIfTPJrB
	/1l4qyt0AHF8g42FLc/sqvnLyp8/2gdWLk02P+24+3DCkyTCA+TMMuuWnwhrc6PHOpY4Iw
	YPsKfm28BeQ4F8Gu4THGbG0qUtFTkh8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-6CrO1vKKPAa9FzFD3GOaPA-1; Wed, 25 Oct 2023 10:02:13 -0400
X-MC-Unique: 6CrO1vKKPAa9FzFD3GOaPA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso288770066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242531; x=1698847331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOOGhallOPxnWGST34MdPR6LpOdkhm6q6XmykKHjQ0c=;
        b=cZ1Ae00DVnTBhERBkTsl0Ih+Eu0Y3Z+0WdhaXLibgKdh4ZZmnXre8JqHzAFB/e+xgS
         UkT+pVBSKb6MWkTIC7aOx7RAH5aiqqryzheLcDPUaiR8tgohcbUKcXDuyVm8tNYups/C
         sT338QM1aZlHYZZ/kaApxmKHDlJWdnpqbUlBoLB3tWjT2mhfzoc55yvA20Qi7q3sG0zk
         xoI1LgScADzF4lDm5DysqPuPTNkn4Ceo55yySZVUTmcb1kIX9WJyQgBjRyMHPMjR92Hp
         EzH9pnKRWYlnMAN6SzgcQfNT6g3k0L+1NUkNP+QbwjpvRjTx+lIYUZ8FY9enJXck2XlS
         7SXw==
X-Gm-Message-State: AOJu0Yzz5YyNY7NJtgNGHI2uYxfYyRsFpOHzQ8f0dYFus9ag8l7I52IK
	KUaSNYCahUQIdZhBj6mF8EUi+zYe9eyv254g2AT9A7flIoBIVF6S8MxDFRO8/W+CL7n+qGXO30d
	m8a0O1INh9RpnmaeaHNO0/vtffO3f5RtEBOHp3CbxrKd6ABa+tA0IPSxp0dGephjcUcRL0D5PmO
	sjykLjGIJUNw==
X-Received: by 2002:a17:907:7214:b0:9c5:64f2:eaba with SMTP id dr20-20020a170907721400b009c564f2eabamr12173178ejc.53.1698242531705;
        Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjFyLKoZkQVe5WJ8FMZvmHP9TlGwCthXsPC2ClyGzG4V59SQ3WuYohHWjLbekPtDQTXUhMwQ==
X-Received: by 2002:a17:907:7214:b0:9c5:64f2:eaba with SMTP id dr20-20020a170907721400b009c564f2eabamr12173147ejc.53.1698242531456;
        Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:10 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 3/6] namespace: extract show_path() helper
Date: Wed, 25 Oct 2023 16:02:01 +0200
Message-ID: <20231025140205.3586473-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be used by the statmount(2) syscall as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/internal.h       |  2 ++
 fs/namespace.c      |  9 +++++++++
 fs/proc_namespace.c | 10 +++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..0c4f4cf2ff5a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -83,6 +83,8 @@ int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
+int show_path(struct seq_file *m, struct dentry *root);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 0eab47ffc76c..7a33ea391a02 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4672,6 +4672,15 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+int show_path(struct seq_file *m, struct dentry *root)
+{
+	if (root->d_sb->s_op->show_path)
+		return root->d_sb->s_op->show_path(m, root);
+
+	seq_dentry(m, root, " \t\n\\");
+	return 0;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 73d2274d5f59..0a808951b7d3 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -142,13 +142,9 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
 		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
-	if (sb->s_op->show_path) {
-		err = sb->s_op->show_path(m, mnt->mnt_root);
-		if (err)
-			goto out;
-	} else {
-		seq_dentry(m, mnt->mnt_root, " \t\n\\");
-	}
+	err = show_path(m, mnt->mnt_root);
+	if (err)
+		goto out;
 	seq_putc(m, ' ');
 
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
-- 
2.41.0


