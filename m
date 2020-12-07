Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7A2D0F37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgLGLeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgLGLet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:49 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77498C061A56;
        Mon,  7 Dec 2020 03:34:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id f9so9014379pfc.11;
        Mon, 07 Dec 2020 03:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTNI65Ra3SvOxRqRKBzegtUpucaZ64C3XLV6YdV+FWI=;
        b=WZ7Du0ULB95oU81wnLc5gl3z/aytDZ/R8hi+jxeHPvL3Uj6qbl1w6qJYy8PYblreD7
         KkS3EAfoEHij1nALKdPH1U4pxPS0IyvqqemIQiGQMyDBC7uDpffb/MAkinfFKdVcbzW+
         ccqmpEumCFtRql9bw4TNMZX2lqp8gs6naZPHyGLUqJUJGO5hakqfFrv5eThcK9prsbyq
         rA5jkLCAuckYLJvmJ/7JoZy+hde7C1WAvWqFV42rW7dKwCVNU9p/OVP/OE9bqgO1xMQS
         M+Ap2sPI4y9/jiLNfsu4126AgBFlUfyiLrevHYALZF4wOYdHEUv5qkHHoVqj09LrY8u0
         OGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTNI65Ra3SvOxRqRKBzegtUpucaZ64C3XLV6YdV+FWI=;
        b=JQ+8VJ8wZqNoIcp0eQC6nBfq333YBWE75c3UrxegZ9fN80uIbvBxjYnQqxvG5EYMTi
         jIxvIYJ8+4J/85cMjUrRjCmVx2mp8417EAxl1mAtf/Ic/ZPw6walXm3JPq41Ntg8xwAp
         EWAOaFo6eHahxiklUAOSAh7DuDXkVsHYTOqmf5co0GjshmqahmasGHNo7I+mbYYkJ1hu
         WUHxT4tq9yp8Lx0G35o7WLjrWo5jW9xetzwj0CSVikT8CFkkrrHeCsoPVbnHaqHLVcry
         bbm3DpUAGBVpVNgOqQIcG5pjSIbVmbBJ30gpNAOHalGqsToQLEWYPjA/NvtvFwoD1IH3
         otdQ==
X-Gm-Message-State: AOAM530XFEnAQwlfQabe6phLV40gyCobXLeI3kUrtez3st0N+Vv2+cqc
        +R0jnMBWoJME8o/gZOtNUOs=
X-Google-Smtp-Source: ABdhPJzLlbx7N/WW+brtTZmzWtaMEPGG1TMIRCFOt3UUqUvhW972s9iQVTyzpcnADKQPTclv8/zM4g==
X-Received: by 2002:a62:5205:0:b029:19e:a0f:2c81 with SMTP id g5-20020a6252050000b029019e0a0f2c81mr4652442pfb.50.1607340844089;
        Mon, 07 Dec 2020 03:34:04 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:34:03 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 10/37] dmemfs: introduce max_alloc_try_dpages parameter
Date:   Mon,  7 Dec 2020 19:31:03 +0800
Message-Id: <08ff7e40806a2342720835b95f9be24d5778c703.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

It specifies the dmem page number allocated at one time, then
multiple radix entries can be created. That will relief the
allocation pressure and make page fault more fast.

However that could cause no dmem page mmapped to userspace
even if there are some free dmem pages.

Set it to 1 to completely disable this behavior.

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/dmemfs/inode.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
index 3192f31..443f2e1 100644
--- a/fs/dmemfs/inode.c
+++ b/fs/dmemfs/inode.c
@@ -34,6 +34,8 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+static uint __read_mostly max_alloc_try_dpages = 1;
+
 struct dmemfs_mount_opts {
 	unsigned long dpage_size;
 };
@@ -46,6 +48,44 @@ enum dmemfs_param {
 	Opt_dpagesize,
 };
 
+static int
+max_alloc_try_dpages_set(const char *val, const struct kernel_param *kp)
+{
+	uint sval;
+	int ret;
+
+	ret = kstrtouint(val, 0, &sval);
+	if (ret)
+		return ret;
+
+	/* should be 1 at least */
+	if (!sval)
+		return -EINVAL;
+
+	max_alloc_try_dpages = sval;
+	return 0;
+}
+
+static struct kernel_param_ops alloc_max_try_dpages_ops = {
+	.set = max_alloc_try_dpages_set,
+	.get = param_get_uint,
+};
+
+/*
+ * it specifies the dmem page number allocated at one time, then
+ * multiple radix entries can be created. That will relief the
+ * allocation pressure and make page fault more fast.
+ *
+ * however that could cause no dmem page mmapped to userspace
+ * even if there are some free dmem pages
+ *
+ * set it to 1 to completely disable this behavior
+ */
+fs_param_cb(max_alloc_try_dpages, &alloc_max_try_dpages_ops,
+	    &max_alloc_try_dpages, 0644);
+__MODULE_PARM_TYPE(max_alloc_try_dpages, "uint");
+MODULE_PARM_DESC(max_alloc_try_dpages, "Set the dmem page number allocated at one time, should be 1 at least");
+
 const struct fs_parameter_spec dmemfs_fs_parameters[] = {
 	fsparam_string("pagesize", Opt_dpagesize),
 	{}
@@ -314,6 +354,7 @@ static void *find_radix_entry_or_next(struct address_space *mapping,
 	}
 	rcu_read_unlock();
 
+	try_dpages = min(try_dpages, max_alloc_try_dpages);
 	/* entry does not exist, create it */
 	addr = dmem_alloc_pages_vma(vma, fault_addr, try_dpages, &dpages);
 	if (!addr) {
-- 
1.8.3.1

