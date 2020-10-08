Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E128704B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgJHH4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbgJHH41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:56:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A253C0613DC;
        Thu,  8 Oct 2020 00:56:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so3563537pgo.13;
        Thu, 08 Oct 2020 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2BnfFJzyK/ObYmFl6qjjvD95MAX5noA3ThIztEgoaE0=;
        b=sD5at9h1ul8tK2eGhC10aT7eu1ACuvM8pX0UClSoOBqsWnd8ZLKBG21Or5ujlsSO4r
         ZcSP94jhTlJ88RZsOP3erYbPjNfZZ+XJV13wDvViB10BsEc7+wwzeX5ngETPK0AzznVh
         WhaVc55dAnhOG0gv1GJzH2TCaJ1rhgbsk4LmqTeQVRFjQ3hIczSrI6SQqNvwPnABDU6s
         FP8l4ZgVXEIoX5hqiBtlmgXrH9XlMNG3EtoY0tPObqBPsqr62osd5A86auhcTjL7TLrZ
         +dJRfZ8CQc6eSephIBvs2EBuVvTMTEGtKRR5UbvkYVR5BkJe9ido8lbljwqBnCt3qfBE
         8Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2BnfFJzyK/ObYmFl6qjjvD95MAX5noA3ThIztEgoaE0=;
        b=uLOzqg+GDrzZtbnXkRSpesLhB9psHVG7yXFyTU6zzwyUsGBI+9pTUMzwBlTFOBr2Gg
         wgACGHqDbr7zwJZvw/v4VrKFoZI6CjIUqcsCK0cyvnponme+5qxRo1nxTQRbB4ZNJlmL
         jsbMOWhcBC06Q7aFRjqoAX1mCzhapZDvivKZy6VZLTfNwUzbfhJJQdkVi77FttbgbY7H
         1B/plINpLg+OVrUTsy6Mk0XbxWKv+c1CAdEHiwz1KUvSZHe+SmGkY6vpcBuhPgyb6xh5
         Qq6nwQYkVGOC0YmDr/3bRNnJdIXfY2xST0wjtJwTAwF27ZCzYwbhtelX/G/vJMTYF9Yd
         8caQ==
X-Gm-Message-State: AOAM533P9+stwrENgcd1fzgHYHCs3znk+Z0T2CNoTquZ8UG7XYGYoDFB
        w9F9QxA1paD3LQP5oi/ewW0=
X-Google-Smtp-Source: ABdhPJydbIfkN0fEyXGB0jM4KFOYE2spk9nEprX0Wp7N/fpC/X8oW8XY/9iFxzAbdDrLYJ2uam3ogQ==
X-Received: by 2002:a17:90a:a09:: with SMTP id o9mr6438714pjo.134.1602143778213;
        Thu, 08 Oct 2020 00:56:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:56:17 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [PATCH 35/35] Add documentation for dmemfs
Date:   Thu,  8 Oct 2020 15:54:25 +0800
Message-Id: <4d1bc80e93134fb0f5691db5c4bb8bcbc1e716dd.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Introduce dmemfs.rst to document the basic usage of dmemfs.

Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 Documentation/filesystems/dmemfs.rst | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/filesystems/dmemfs.rst

diff --git a/Documentation/filesystems/dmemfs.rst b/Documentation/filesystems/dmemfs.rst
new file mode 100644
index 000000000000..cbb4cc1ed31d
--- /dev/null
+++ b/Documentation/filesystems/dmemfs.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+The Direct Memory Filesystem - DMEMFS
+=====================================
+
+
+.. Table of contents
+
+   - Overview
+   - Compilation
+   - Usage
+
+Overview
+========
+
+Dmemfs (Direct Memory filesystem) is device memory or reserved
+memory based filesystem. This kind of memory is special as it
+is not managed by kernel and it is without 'struct page'. Therefore
+it can save extra memory from the host system for various usage,
+especially for guest virtual machines.
+
+It uses a kernel boot parameter ``dmem=`` to reserve the system
+memory when the host system boots up, the details can be checked
+in /Documentation/admin-guide/kernel-parameters.txt.
+
+Compilation
+===========
+
+The filesystem should be enabled by turning on the kernel configuration
+options::
+
+        CONFIG_DMEM_FS          - Direct Memory filesystem support
+        CONFIG_DMEM             - Allow reservation of memory for dmem
+
+
+Additionally, the following can be turned on to aid debugging::
+
+        CONFIG_DMEM_DEBUG_FS    - Enable debug information for dmem
+
+Usage
+========
+
+Dmemfs supports mapping ``4K``, ``2M`` and ``1G`` size of pages to
+the userspace, for example ::
+
+    # mount -t dmemfs none -o pagesize=4K /mnt/
+
+The it can create the backing storage with 4G size ::
+
+    # truncate /mnt/dmemfs-uuid --size 4G
+
+To use as backing storage for virtual machine starts with qemu, just need
+to specify the memory-backed-file in the qemu command line like this ::
+
+    # -object memory-backend-file,id=ram-node0,mem-path=/mnt/dmemfs-uuid \
+        share=yes,size=4G,host-nodes=0,policy=preferred -numa node,nodeid=0,memdev=ram-node0
-- 
2.28.0

