Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB976386A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGZOIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjGZOHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:15 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE592D57
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140700euoutp010ef241bfe1b15ac5e47fe479dd0f5cb6~1cAlcfW6k3202132021euoutp01W
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230726140700euoutp010ef241bfe1b15ac5e47fe479dd0f5cb6~1cAlcfW6k3202132021euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380420;
        bh=l0L9NM3baww7PVLEXdKvMFx2kXphPK9z7x02k5Zm7P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GaZxoBUp0wCR4r6ry2u8S1nlpqI/0qhL2+zbvIjyGJR+l3toEsBx2lbuszRlVdZuN
         a7u5sBbS7gNqEgWKaE7fYAt2x2czxScQ+8Qw80/uY3XSteIXks2Mt84KNlWh0SSdmw
         dolELmm/P+GgX1xIbOffGwpWjeDTt3xHs9OVnbUA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140659eucas1p1999364497c41da742f5a590178eed9e0~1cAkx_DyJ2259322593eucas1p1k;
        Wed, 26 Jul 2023 14:06:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 27.F6.11320.38821C46; Wed, 26
        Jul 2023 15:06:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72~1cAkRDtvl0079900799eucas1p2w;
        Wed, 26 Jul 2023 14:06:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140659eusmtrp23f74b881de77cedcdbb407cdb337d489~1cAkQSJFE2014720147eusmtrp2e;
        Wed, 26 Jul 2023 14:06:59 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-36-64c12883b123
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.57.14344.38821C46; Wed, 26
        Jul 2023 15:06:59 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140659eusmtip26b7013f9921e15f7a7bc21417164a14d~1cAj_0AFI2113521135eusmtip2C;
        Wed, 26 Jul 2023 14:06:59 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 06/14] sysctl: Add size to register_sysctl
Date:   Wed, 26 Jul 2023 16:06:26 +0200
Message-Id: <20230726140635.2059334-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djPc7rNGgdTDA6v1bfYePolm8Xjv4fY
        LN4v62G0mHO+hcXi6bFH7BYXZn1jtXg9bxWjxdL9Dxkt/i/ItzjTnWtxYVsfq8Wmx9dYLfbs
        PclicXnXHDaLCQubmS1uTHjKaHFsgZjFt9NvGC2WrV/LbtFyx9Ti9w+ggmU7/RzEPNbMW8Po
        MbvhIovHlpU3mTwWbCr12LxCy+PWa1uPTas62TwmLDrA6LF5Sb3H+31X2Tz6tqxi9Pi8SS6A
        J4rLJiU1J7MstUjfLoErY/qtDWwFHWYVz9efZmlgfK7TxcjJISFgIrH10EHWLkYuDiGBFYwS
        c/YtY4NwvjBKHNy+kQnC+cwosfvdPXaYlhenW6ESyxklnqzpYQZJCAm8ZJS4c9sGxGYT0JE4
        /+YOM0iRiMAmZom73xaCOcwCZ5kkjq+fDDZKWMBKYtvfCUwgNouAqsTrvpdgk3gFbCWOrH3G
        ArFOXqLt+nRGEJtTwE5i5drvrBA1ghInZz4Bq2EGqmneOpsZov4ap8SE6WpdjBxAtovEtPPF
        EGFhiVfHt0B9ICPxf+d8sA8kBCYzSuz/94EdwlnNKLGs8SsTRJW1RMuVJ+wgg5gFNCXW79KH
        CDtKrPk5kw1iPp/EjbeCECfwSUzaNp0ZIswr0dEmBFGtItG3dArUJ1IS1y/vZIOwPSTWrj/H
        PoFRcRaSZ2YheWYWwt4FjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAtPm6X/Hv+xg
        XP7qo94hRiYOxkOMEhzMSiK8hjH7UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8s
        Sc1OTS1ILYLJMnFwSjUwybLfYGLboKaxyqR+t/alhPmsW/ftWhnZasfU9c98W7zOVNPOTlZp
        MZ7jF367FxR/OP6rulQxZ7+s4mo7tojvie42/1UXLbPs/mrjNfnOwjfnXWQuyuQGss/rZY87
        euOJuNrsjUkFR83evL884/8GtxTp7qiItWn1pqc4vpa9ig1sz9xRt5rBLnPSAQVjGzXW4rkJ
        q2qWcE/S9f8zQVfo47mlG37MYT9/KPTr6fcfA+8sP21gt697tbuT8c+AfVKfK6vdOJVe8Eyy
        891RsWifY8+BGpuq83d9GmUTzPXXn7uaslx8TtCy1aaPjnjtv3N30hN9r9quFq3PN4/b7ls0
        +V8mY5DWId75vnklfMbrlViKMxINtZiLihMBhi2VBgoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7rNGgdTDK5e4rPYePolm8Xjv4fY
        LN4v62G0mHO+hcXi6bFH7BYXZn1jtXg9bxWjxdL9Dxkt/i/ItzjTnWtxYVsfq8Wmx9dYLfbs
        PclicXnXHDaLCQubmS1uTHjKaHFsgZjFt9NvGC2WrV/LbtFyx9Ti9w+ggmU7/RzEPNbMW8Po
        MbvhIovHlpU3mTwWbCr12LxCy+PWa1uPTas62TwmLDrA6LF5Sb3H+31X2Tz6tqxi9Pi8SS6A
        J0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY/qt
        DWwFHWYVz9efZmlgfK7TxcjJISFgIvHidCtTFyMXh5DAUkaJ3ntH2boYOYASUhLfl3FC1AhL
        /LnWxQZR85xRYmrvdBaQBJuAjsT5N3eYQRIiAvuYJaZ+OsUKkmAWuM4kMfltEIgtLGAlse3v
        BCYQm0VAVeJ130tmEJtXwFbiyNpnLBAb5CXark9nBLE5BewkVq79DjZHCKimZ+pTdoh6QYmT
        M5+wQMyXl2jeOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG97Zj
        P7fsYFz56qPeIUYmDsZDjBIczEoivIYx+1KEeFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+Y
        YPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiinPWzzRwXTTw/
        73dG9sPzC6ct69rAHnGEZdtlV56fL45f6pKYN5lx5+ot1/zTbYu2vLc2a714qPL//5/T/63k
        328/LenmJ58lepr/3oquurK1S2rzuVvhznpzrF40eXZ6NWzTs5NUznmd91vN+/QOhaIN94XX
        HLl47v6qp5nnYh6kBx5X+C80b6qlwXLps0lJyaFzD/p8atlwTjAq+T1HT0P6ph3t3qlflD+d
        v/mAIcolOP1B8JTJ784/uZR/4sBlG0a/tZMZVmjp6jPXzm2s+l2UtfHxtQoLz/UuK1hmNswN
        aF1/YcYEplgW24aVQnc1N6suX//1qqZmneq015HHbZbIzmN77PCGm/X2/cTgqUosxRmJhlrM
        RcWJAB+R3qZ4AwAA
X-CMS-MailID: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to remove the end element from the ctl_table struct arrays, we
replace the register_syctl function with a macro that will add the
ARRAY_SIZE to the new register_sysctl_sz function. In this way the
callers that are already using an array of ctl_table structs do not have
to change. We *do* change the callers that pass the ctl_table array as a
pointer.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/arm64/kernel/armv8_deprecated.c |  2 +-
 arch/s390/appldata/appldata_base.c   |  2 +-
 fs/proc/proc_sysctl.c                | 30 +++++++++++++++-------------
 include/linux/sysctl.h               | 10 ++++++++--
 kernel/ucount.c                      |  2 +-
 net/sysctl_net.c                     |  2 +-
 6 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 1febd412b4d2..e459cfd33711 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -569,7 +569,7 @@ static void __init register_insn_emulation(struct insn_emulation *insn)
 		sysctl->extra2 = &insn->max;
 		sysctl->proc_handler = emulation_proc_handler;
 
-		register_sysctl("abi", sysctl);
+		register_sysctl_sz("abi", sysctl, 1);
 	}
 }
 
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index bbefe5e86bdf..3b0994625652 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -365,7 +365,7 @@ int appldata_register_ops(struct appldata_ops *ops)
 	ops->ctl_table[0].proc_handler = appldata_generic_handler;
 	ops->ctl_table[0].data = ops;
 
-	ops->sysctl_header = register_sysctl(appldata_proc_name, ops->ctl_table);
+	ops->sysctl_header = register_sysctl_sz(appldata_proc_name, ops->ctl_table, 1);
 	if (!ops->sysctl_header)
 		goto out;
 	return 0;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8d04f01a89c1..c04293911e7e 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -43,7 +43,7 @@ static struct ctl_table sysctl_mount_point[] = {
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl(path, sysctl_mount_point);
+	return register_sysctl_sz(path, sysctl_mount_point, 0);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
@@ -1398,7 +1398,7 @@ struct ctl_table_header *__register_sysctl_table(
 }
 
 /**
- * register_sysctl - register a sysctl table
+ * register_sysctl_sz - register a sysctl table
  * @path: The path to the directory the sysctl table is in. If the path
  * 	doesn't exist we will create it for you.
  * @table: the table structure. The calller must ensure the life of the @table
@@ -1408,25 +1408,20 @@ struct ctl_table_header *__register_sysctl_table(
  * 	to call unregister_sysctl_table() and can instead use something like
  * 	register_sysctl_init() which does not care for the result of the syctl
  * 	registration.
+ * @table_size: The number of elements in table.
  *
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+					    size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
 	return __register_sysctl_table(&sysctl_table_root.default_set,
-					path, table, count);
+					path, table, table_size);
 }
-EXPORT_SYMBOL(register_sysctl);
+EXPORT_SYMBOL(register_sysctl_sz);
 
 /**
  * __register_sysctl_init() - register sysctl table to path
@@ -1451,10 +1446,17 @@ EXPORT_SYMBOL(register_sysctl);
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
 {
-	struct ctl_table_header *hdr = register_sysctl(path, table);
+	int count = 0;
+	struct ctl_table *entry;
+	struct ctl_table_header t_hdr, *hdr;
+
+	t_hdr.ctl_table = table;
+	list_for_each_table_entry(entry, (&t_hdr))
+		count++;
+	hdr = register_sysctl_sz(path, table, count);
 
 	if (unlikely(!hdr)) {
-		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
+		pr_err("failed when register_sysctl_sz %s to %s\n", table_name, path);
 		return;
 	}
 	kmemleak_not_leak(hdr);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 0495c858989f..b1168ae281c9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -215,6 +215,9 @@ struct ctl_path {
 	const char *procname;
 };
 
+#define register_sysctl(path, table)	\
+	register_sysctl_sz(path, table, ARRAY_SIZE(table))
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
@@ -227,7 +230,8 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table, size_t table_size);
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
+struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+					    size_t table_size);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -262,7 +266,9 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 	return NULL;
 }
 
-static inline struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+static inline struct ctl_table_header *register_sysctl_sz(const char *path,
+							  struct ctl_table *table,
+							  size_t table_size)
 {
 	return NULL;
 }
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 2b80264bb79f..4aa6166cb856 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -365,7 +365,7 @@ static __init int user_namespace_sysctl_init(void)
 	 * default set so that registrations in the child sets work
 	 * properly.
 	 */
-	user_header = register_sysctl("user", empty);
+	user_header = register_sysctl_sz("user", empty, 0);
 	kmemleak_ignore(user_header);
 	BUG_ON(!user_header);
 	BUG_ON(!setup_userns_sysctls(&init_user_ns));
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 8ee4b74bc009..d9cbbb51b143 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -101,7 +101,7 @@ __init int net_sysctl_init(void)
 	 * registering "/proc/sys/net" as an empty directory not in a
 	 * network namespace.
 	 */
-	net_header = register_sysctl("net", empty);
+	net_header = register_sysctl_sz("net", empty, 0);
 	if (!net_header)
 		goto out;
 	ret = register_pernet_subsys(&sysctl_pernet_ops);
-- 
2.30.2

