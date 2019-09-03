Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A270A67A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfICLmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfICLmI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:08 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3155183F42
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:08 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so6871177wma.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ydFLCcq0ciOZyr1APkM5OIxojvSPh3+JfyuTKS+43s=;
        b=LgXNbBZR1VFH5SDSj9PxUFOsf6pFgxBeOb+HAr0X2glC3XqpeK8yjrgFsusR2zr/12
         NmoSNH5ygyKgNoNrCpbhY4kWV2+//0WVgjF6wjlJHjbHsL6hwjilEGS5G3wDkWbKo9GX
         zZAAFTMk8ZNUW9dAESwqLwnxtLiUygtlHVK1zMBRPAbeE58mWIDyr9Aizp3uL2AX/pf1
         NoiseH2XJuBoY8Jt74iN4XSWOP3IZN8eU0Ep3lO0khL3NTm3Oa7T+FFpZsOMHp4ih0rb
         ip5cxX0sdmXtphcHGoTxN16gn7n0LcCZ3/626oDmmPi/3+lu/QXc3GyOz0ehYWKbTevv
         CDlg==
X-Gm-Message-State: APjAAAVZss0CFruEmIjRdUUJg5WeX7c7LmguqWmZ5SF13JhfM792yqSf
        wHxXz7wkW31nM9+lN3lo3PZpjSJq7Ach2U75szxtQnI0n6d+VLjKa0+ooPYnFOpD9e26Aw/iPn7
        elZhK7VUCmrAT22GzqQFQnFm5lA==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr43660040wml.77.1567510926813;
        Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwVaQwtVBh/GvNyluxkYOtecnAIB1sEbYcsQqfpoYMUCYSVMPO87Fhv/znnSgCVILBxIAMhQ==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr43660009wml.77.1567510926604;
        Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 07/16] fuse: export fuse_get_unique()
Date:   Tue,  3 Sep 2019 13:41:54 +0200
Message-Id: <20190903114203.8278-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need unique IDs for FORGET requests from outside
fs/fuse/dev.c.  Make the symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 3 ++-
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index bd2e5958d2f9..167f476fbe16 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -363,11 +363,12 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-static u64 fuse_get_unique(struct fuse_iqueue *fiq)
+u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
 	fiq->reqctr += FUSE_REQ_ID_STEP;
 	return fiq->reqctr;
 }
+EXPORT_SYMBOL_GPL(fuse_get_unique);
 
 static unsigned int fuse_req_hash(u64 unique)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8ced5e74e5a8..7e19c936ece8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1104,4 +1104,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 
+/**
+ * Get the next unique ID for a request
+ */
+u64 fuse_get_unique(struct fuse_iqueue *fiq);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.21.0

