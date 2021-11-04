Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F61444DE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 05:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhKDEXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 00:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhKDEXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:23:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCFCC061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Nov 2021 21:20:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s5so4629698pfg.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Nov 2021 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KUODgu3W4FcAvayfaJlfGS9hr1Jt/95YZDXl59Il7DU=;
        b=CsghQpHWIiv5MGiO1rC46d7NF245fDoL78JMHz6hkeVvjG8/Qi+MOSKm3PwyExJTBE
         1ztvP2uInLeq/GciGhijezE6oZiKuC5qNqVn5EI3MvpQwaW9GPHdDzndvELq+wJg4Yz6
         WSRPySKhS2rxLf9jVAWXzV5wnw7v9rcTs9TEEOydipRF3bBr47UbSpF+LcG2mIxVSIZv
         9Jypkyq1q8nW90X2pxauuWC+2tati8npIr26bhHIR9qoDs15df+qEgoA9/3wlAZXlaJe
         3Q8sndFoTDndOxXXaG9xTY6Wz0VJtPXhnXZUAX4pEzUzWbIr67DRjcegFXqSLzjspwiF
         aveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KUODgu3W4FcAvayfaJlfGS9hr1Jt/95YZDXl59Il7DU=;
        b=hWo6qQZSNJWrBC/fueQ1q7bGKxCmTMAngx9Fe7DvuMweEd4I6NLmDsRsuFYi4xZkKW
         zk45R/8d31/L90iKGEyjK/QKOrGOhxU/g426RqiE8XrK5Bw6Oe6N+1xT9KdALxIxFb9B
         zcDOA6lQ7wdyCc0u6hsUV0nUl0008B0MpqwfFSFRf5XllwTrdWYVl9b7ow0TwNo5pYkk
         sKE64ltar14XzxI713U3GwpsQA1WPd8AME+jeVDziHlssB+gu2saQ9mZOid4Wu1+foQT
         uuItXAX83Ny8pzUjfbrEtffASpJ6l0RB0saFwiPZYTbuQxlVNOGVTZYNfkfXjB/4cZRz
         n31A==
X-Gm-Message-State: AOAM5338NHqABfOzz/Q+2sOSBhbvCuy+DmFECcCKH6dH4ZuD/oUMY585
        PjOoJK5OnE9Wz4wse8G8DxI=
X-Google-Smtp-Source: ABdhPJySJltqcd3wEE0VCXEFx7ozoW1b6gxVLcEZpWI4yWx199qfrNdxZ3+4QZr5bO4BDV33KTFHJA==
X-Received: by 2002:a63:c103:: with SMTP id w3mr3822309pgf.101.1635999640336;
        Wed, 03 Nov 2021 21:20:40 -0700 (PDT)
Received: from localhost ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id y4sm3995436pfi.178.2021.11.03.21.20.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Nov 2021 21:20:40 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:20:37 +0800
From:   Lianjun Huang <hljhnu@gmail.com>
To:     miklos@szeredi.hu
Cc:     hljhnu@gmail.com, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH] fuse: add tracepoints for request
Message-ID: <20211104042037.GA7088@ubuntu-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change-Id: I361d582f30a04040969f1774064d5d1a4b646389
Signed-off-by: Lianjun Huang <hljhnu@gmail.com>
---
 fs/fuse/dev.c               |  4 ++++
 include/trace/events/fuse.h | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 include/trace/events/fuse.h

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9d2d321bd60b..83f20799683d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -23,6 +23,8 @@
 #include <linux/splice.h>
 #include <linux/sched.h>
 #include <linux/freezer.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/fuse.h>
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -323,6 +325,7 @@ static u64 fuse_get_unique(struct fuse_iqueue *fiq)
 
 static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
+	trace_fuse_info(req->in.h.opcode, req->in.h.unique, req->in.h.nodeid, "queue request");
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	list_add_tail(&req->list, &fiq->pending);
@@ -417,6 +420,7 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 	if (req->end)
 		req->end(fc, req);
 put_request:
+	trace_fuse_info(req->in.h.opcode, req->in.h.unique, req->in.h.nodeid, "request end");
 	fuse_put_request(fc, req);
 }
 
diff --git a/include/trace/events/fuse.h b/include/trace/events/fuse.h
new file mode 100644
index 000000000000..da471c0db9b6
--- /dev/null
+++ b/include/trace/events/fuse.h
@@ -0,0 +1,27 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fuse
+#if !defined(_TRACE_FUSE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FUSE_H
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(fuse_info,
+		TP_PROTO(uint32_t opcode, uint64_t unique, uint64_t nodeid, const char *info),
+		TP_ARGS(opcode, unique, nodeid, info),
+		TP_STRUCT__entry(
+			__field(uint32_t, opcode)
+			__field(uint64_t, unique)
+			__field(uint64_t, nodeid)
+			__string(info, info)
+			),
+		TP_fast_assign(
+			__entry->opcode	= opcode;
+			__entry->unique = unique;
+			__entry->nodeid = nodeid;
+			__assign_str(info, info);
+			),
+		TP_printk("fuse: opcode %u, unique %lu, nodeid %lu %s\n",
+			__entry->opcode, __entry->unique, __entry->nodeid, __get_str(info))
+	   );
+#endif
+
+#include <trace/define_trace.h>
-- 
2.17.1

