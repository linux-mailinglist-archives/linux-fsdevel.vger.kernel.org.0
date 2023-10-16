Return-Path: <linux-fsdevel+bounces-433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADCA7CAE87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE88CB2116D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63A30D01;
	Mon, 16 Oct 2023 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHomGn4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2030F9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:28 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D7B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4228541f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472565; x=1698077365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKXfiN0pnOwmujsst9VVwRItdmOPozlrCMRAew1BHfE=;
        b=kHomGn4d+HCbLbbud+I/qp/pNIB480PeQkyVV5qpLIWtxPjxRfQxw1javT5Aq0UmP4
         ZNkvHWqtSHKDdUddxdHqmARqp4x2volpdCcfRvuzmAnj+98rkKinJJyBjiyYmpFx4UgX
         nrkUfi8RjRtzYClAIRNSupuIWi3X5S6XMZbxgbN3yV70/9F/tm83ekfa1rmbEM8oZrGC
         cKKr+WOtFVICuc1HubBbW8O2w2jupafvVMfR2Y6/C5fquTYAq57YOWSkmn46aQZ+guwZ
         pTBdypKV/GTDpNH6nY5lQaYb2TE4ilm1dBq4N7fdRwPlu/YwXoe61B3D38fS5yqpudoH
         XlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472565; x=1698077365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKXfiN0pnOwmujsst9VVwRItdmOPozlrCMRAew1BHfE=;
        b=Zc62zp37KsUbU3KuI/+u6Rk3p4I8RsxWV2+ZN9Azw73MkryTy2Sy0J7gegntO2XD2E
         LPzq2ioeNekTvXd3R6iNGpEM2eAk1vXmVnV3pkaPzshQN4pyI+MmtOsWdeFBo0cs+/Me
         0QLnav2asux+hN43SleqROI4JjzWeewBF/N8okVKMrY5oZv68PqKHoj7dPENPUSZfZgV
         MNClFSbNdn2bZ35elL56UorrSWYhWHq4Zd1Fy3g/anSUfKMjHAh9frtV1ZOV4Ww0Ux91
         hXUtaCYSFJdRSVFA+2rBIDcacmxEWudt3afALcppAk9MKVhREkjNl6eubmULJM8dehKD
         aFWg==
X-Gm-Message-State: AOJu0YxGJGRLYnV9UMxpWc4nlN8bPTBeDu7v1PQrObsExLwEkNUQ/cSQ
	rcDoKaHNc+L8MaS0s0NRlWo=
X-Google-Smtp-Source: AGHT+IGbRNy0ghFQM+S72wp6aLRIqdDOVWW0mUKgW8lTiFjPGZwiR7tqas/krCZmXdtPzQYFu8/5AQ==
X-Received: by 2002:adf:cd06:0:b0:32d:9789:6066 with SMTP id w6-20020adfcd06000000b0032d97896066mr8293155wrm.5.1697472565562;
        Mon, 16 Oct 2023 09:09:25 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:24 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 11/12] fuse: implement passthrough for mmap
Date: Mon, 16 Oct 2023 19:09:01 +0300
Message-Id: <20231016160902.2316986-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160902.2316986-1-amir73il@gmail.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enabling FUSE passthrough for mmap-ed operations not only affects
performance, but has also been shown as mandatory for the correct
functioning of FUSE passthrough.

yanwu noticed [1] that a FUSE file with passthrough enabled may suffer
data inconsistencies if the same file is also accessed with mmap.
What happens is that read/write operations are directly applied to the
backing file's page cache, while mmap-ed operations are affecting the
FUSE file's page cache.

Extend the FUSE passthrough implementation to also handle memory-mapped
FUSE file, to both fix the cache inconsistencies and extend the
passthrough performance benefits to mmap-ed operations.

[1] https://lore.kernel.org/lkml/20210119110654.11817-1-wu-yan@tcl.com/

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        |  3 +++
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/passthrough.c | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d6fc99245a61..bae1137426a9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2499,6 +2499,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_mmap(file, vma);
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED
 		 * if FUSE_DIRECT_IO_RELAX isn't set.
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7dd770efceba..6fee4c33678f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1403,5 +1403,6 @@ ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
 ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index fa5b41a4cdc1..a05280ceba83 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -148,6 +148,22 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 	return ret;
 }
 
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = file,
+		.accessed = fuse_file_accessed,
+	};
+
+	pr_debug("%s: backing_file=0x%p, start=%lu, end=%lu\n", __func__,
+		 backing_file, vma->vm_start, vma->vm_end);
+
+	return backing_file_mmap(backing_file, vma, &ctx);
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
-- 
2.34.1


