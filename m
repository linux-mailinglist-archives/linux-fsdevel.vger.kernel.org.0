Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B8CF2F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfJHGoY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 8 Oct 2019 02:44:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729693AbfJHGoY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:44:24 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id F2842D9559FCC1541F18;
        Tue,  8 Oct 2019 14:44:18 +0800 (CST)
Received: from dggeme716-chm.china.huawei.com (10.1.199.112) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 8 Oct 2019 14:44:18 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme716-chm.china.huawei.com (10.1.199.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 8 Oct 2019 14:44:18 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Tue, 8 Oct 2019 14:44:18 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>
CC:     Mingfangsen <mingfangsen@huawei.com>,
        linmiaohe <linmiaohe@huawei.com>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc:fix confusing macro arg name
Thread-Topic: [PATCH] proc:fix confusing macro arg name
Thread-Index: AdV9gOdeS5V1IJ1hQmaaEj6tyX7o5A==
Date:   Tue, 8 Oct 2019 06:44:18 +0000
Message-ID: <165631b964b644dfa933653def533e41@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add suitable additional cc's as Andrew Morton suggested.
Get cc list from get_maintainer script:
[root@localhost mm]# ./scripts/get_maintainer.pl 0001-proc-fix-confusing-macro-arg-name.patch 
Alexey Dobriyan <adobriyan@gmail.com> (reviewer:PROC FILESYSTEM)
linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM)
linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)

------------------------------------------------------
From: Miaohe Lin <linmiaohe@huawei.com>
Subject: fix confusing macro arg name

state_size and ops are in the wrong position, fix it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/proc_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h index a705aa2d03f9..0640be56dcbd 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -58,8 +58,8 @@ extern int remove_proc_subtree(const char *, struct proc_dir_entry *);  struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent, const struct seq_operations *ops,
 		unsigned int state_size, void *data);
-#define proc_create_net(name, mode, parent, state_size, ops) \
-	proc_create_net_data(name, mode, parent, state_size, ops, NULL)
+#define proc_create_net(name, mode, parent, ops, state_size) \
+	proc_create_net_data(name, mode, parent, ops, state_size, NULL)
 struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		int (*show)(struct seq_file *, void *), void *data);
--
2.21.GIT

