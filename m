Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316397053C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjEPQ3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjEPQ3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE899EDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:20 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162919euoutp02be92d556990a10246249c486be073005~frJkONhbW2468724687euoutp02J
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230516162919euoutp02be92d556990a10246249c486be073005~frJkONhbW2468724687euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254559;
        bh=I5QUMQHQyMuHfDAt3DHmxyhsM2ENc2fVzedUE32vBM0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=e7qfqGqxdqrvY0X2s6m4RLfBmXbBl6vt+NLNopsAn4O0xctdm181LIOL0jqG3mWFO
         z6ECmuOJinBwjy4rNTMuklqOftW4d2jlw53p19ssVL79N91SlbPe7dLLhthPSuu7za
         zzQk6Kg+7CIvcuZeHnwQ+ngsw1nUbaGpD67vH2ik=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230516162918eucas1p1c5a1f8835312bd4863e898001e5b552c~frJkAzC602238322383eucas1p1P;
        Tue, 16 May 2023 16:29:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.A8.37758.E5FA3646; Tue, 16
        May 2023 17:29:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162918eucas1p155eda7abb5a41fcb82f299698a88db65~frJjv09Vi3099430994eucas1p1I;
        Tue, 16 May 2023 16:29:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516162918eusmtrp1d052e2ccf6bf4f8fcb59fa7802ef646c~frJjvSfB21955419554eusmtrp1j;
        Tue, 16 May 2023 16:29:18 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-92-6463af5ea1d5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.47.10549.E5FA3646; Tue, 16
        May 2023 17:29:18 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230516162918eusmtip2ee1a399ee43ccb72bd20ffae6a9ff6c7~frJjl4aIO2307723077eusmtip2j;
        Tue, 16 May 2023 16:29:18 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:17 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 2/6] parport: Remove register_sysctl_table from
 parport_proc_register
Date:   Tue, 16 May 2023 18:28:59 +0200
Message-ID: <20230516162903.3208880-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd249ckpBmfma1uc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJWxfcsLloIz6hWzN/5na2Dcq9DFyMkhIWAicWrTSpYuRi4OIYEVjBIv395ghnC+
        MEr0vu1ih3A+M0osPvSBCabl396DrBCJ5YwSO7t/scBVre34BNWyhVHiwvM+dpAWNgEdifNv
        7jCD2CIC4hInTm9mBCliFnjKKHFv72o2kISwQJTE2Z5XrCA2i4CqxM+Xj8CaeQVsJfqa57JB
        7JaXaLs+nRHE5hSwk3i/ZhMTRI2gxMmZT1hAbGagmuats5khbAmJgy9eMEP0Kkm0T3zACmHX
        SpzacosJ5AgJgQccErf33Yd6zkWi/ehSRghbWOLV8S3sELaMxOnJPSwQDZMZJfb/+8AO4axm
        lFjW+BWq21qi5coTqA5Hif3L1wGdzQFk80nceCsIcRGfxKRt05khwrwSHW1CExhVZiH5YRaS
        H2Yh+WEBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwDRz+t/xrzsYV7z6qHeIkYmD
        8RCjBAezkghvYF9yihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZ
        Jg5OqQamrSaq9+Q9Ht28eybDdXWlwOdGBt33rkrbND8zmoUaOqce9cn6kMN7tfiKtl7InWVd
        J47NrmSW8v53WaSnICQk/lafsNomyQPe07t9ZK5trNnz4cay1svG25bG2r5IS0ufInNf+YtT
        xAOlm6zdsZYbd4dli2n51f8NnGtr1vG0rf1cUVmRk/ap7+3ZD4WFv0fOiMrx+yP7XO+C8S1/
        3oxPf859VgtKPul2zTmmsOmuSVue2wpTBznPRtsO/wuqV015wnbvUghTFo67rNQ+yXCKoJzk
        k8Ozf5yf3jDtbbvOUjn5T5Pd2esYkgUecP/yvWMrZX1x0vscn9IdFhoSH9pzpK1+f9q1JXh9
        rb1XkhJLcUaioRZzUXEiALFq30qiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7px65NTDN72yFic6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexfcsLloIz6hWz
        N/5na2Dcq9DFyMkhIWAi8W/vQdYuRi4OIYGljBK998+zQyRkJDZ+ucoKYQtL/LnWxQZR9JFR
        YvrjTewQzhZGiWNNp8A62AR0JM6/ucMMYosIiEucOL2ZEcRmFnjMKDHnoGwXIweHsECExOuP
        TCBhFgFViZ8vH4G18grYSvQ1z2WDWCYv0XZ9Olgrp4CdxPs1m8DqhYBqJi7vYYGoF5Q4OfMJ
        C8R4eYnmrbOZIWwJiYMvXjBDzFGSaJ/4AOqBWonPf58xTmAUmYWkfRaS9llI2hcwMq9iFEkt
        Lc5Nzy021CtOzC0uzUvXS87P3cQIjL5tx35u3sE479VHvUOMTByMhxglOJiVRHgD+5JThHhT
        EiurUovy44tKc1KLDzGaAv05kVlKNDkfGP95JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Ykl
        qdmpqQWpRTB9TBycUg1MDjlV0r7sn+9sfvnLPpd13fMJDjyJ7ClTmeQO7tI2L91eecFfdtXF
        JalMKxe/tGTp3ZuRZqI4Zdeu9KR1gjdk9uT41jr1L5IyuL2gR+n1hUlzuGardhomNZw4IbPE
        t21OzJ+3Xk+d16n8E5UWtV35hN+5Y2bDK7mIbJ8J3xMdBP/u97Jb+ds6rVhGPvD6opqUvIZj
        sRdiug8dPfytuWmO2RPWr64We77rnhW1V2a9Wnx5nVCxnWcr5/eCjEg1udWzZu8xrojvbn5U
        p/ltYc2xzH9nEjh0ow/fPn/3qDhrSuU+Le1ouZdZUmzf15dx2tfl5ExNy5u45Nohzp0Fyud2
        2b38p/llLU9E76ewE1+UWIozEg21mIuKEwEnyB2RRwMAAA==
X-CMS-MailID: 20230516162918eucas1p155eda7abb5a41fcb82f299698a88db65
X-Msg-Generator: CA
X-RootMTR: 20230516162918eucas1p155eda7abb5a41fcb82f299698a88db65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162918eucas1p155eda7abb5a41fcb82f299698a88db65
References: <20230516162903.3208880-1-j.granados@samsung.com>
        <CGME20230516162918eucas1p155eda7abb5a41fcb82f299698a88db65@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. Register dev/parport/PORTNAME and
dev/parport/PORTNAME/devices. Temporary allocation for name is freed at
the end of the function. Remove all the struct elements that are no
longer used in the parport_device_sysctl_template struct. Add parport
specific defines that hide the base path sizes.

To make sure the resulting directory structure did not change we
made sure that `find /proc/sys/dev/ | sha1sum` was the same before and
after the change.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202305150948.pHgIh7Ql-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305150948.pHgIh7Ql-lkp@intel.com/
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/procfs.c | 88 +++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index d740eba3c099..02c52de6e640 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -32,6 +32,13 @@
 #define PARPORT_MAX_TIMESLICE_VALUE ((unsigned long) HZ)
 #define PARPORT_MIN_SPINTIME_VALUE 1
 #define PARPORT_MAX_SPINTIME_VALUE 1000
+/*
+ * PARPORT_BASE_* is the size of the known parts of the sysctl path
+ * in dev/partport/%s/devices/%s. "dev/parport/"(12), "/devices/"(9
+ * and null char(1).
+ */
+#define PARPORT_BASE_PATH_SIZE 13
+#define PARPORT_BASE_DEVICES_PATH_SIZE 22
 
 static int do_active_device(struct ctl_table *table, int write,
 		      void *result, size_t *lenp, loff_t *ppos)
@@ -260,9 +267,6 @@ struct parport_sysctl_table {
 	struct ctl_table_header *sysctl_header;
 	struct ctl_table vars[12];
 	struct ctl_table device_dir[2];
-	struct ctl_table port_dir[2];
-	struct ctl_table parport_dir[2];
-	struct ctl_table dev_dir[2];
 };
 
 static const struct parport_sysctl_table parport_sysctl_template = {
@@ -305,7 +309,6 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.mode		= 0444,
 			.proc_handler	= do_hardware_modes
 		},
-		PARPORT_DEVICES_ROOT_DIR,
 #ifdef CONFIG_PARPORT_1284
 		{
 			.procname	= "autoprobe",
@@ -355,18 +358,6 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 		},
 		{}
 	},
-	{
-		PARPORT_PORT_DIR(NULL),
-		{}
-	},
-	{
-		PARPORT_PARPORT_DIR(NULL),
-		{}
-	},
-	{
-		PARPORT_DEV_DIR(NULL),
-		{}
-	}
 };
 
 struct parport_device_sysctl_table
@@ -473,11 +464,12 @@ parport_default_sysctl_table = {
 	}
 };
 
-
 int parport_proc_register(struct parport *port)
 {
 	struct parport_sysctl_table *t;
-	int i;
+	char *tmp_dir_path;
+	size_t tmp_path_len, port_name_len;
+	int bytes_written, i, err = 0;
 
 	t = kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
@@ -485,28 +477,60 @@ int parport_proc_register(struct parport *port)
 
 	t->device_dir[0].extra1 = port;
 
-	for (i = 0; i < 5; i++)
-		t->vars[i].extra1 = port;
-
 	t->vars[0].data = &port->spintime;
-	t->vars[5].child = t->device_dir;
-	
-	for (i = 0; i < 5; i++)
-		t->vars[6 + i].extra2 = &port->probe_info[i];
+	for (i = 0; i < 5; i++) {
+		t->vars[i].extra1 = port;
+		t->vars[5 + i].extra2 = &port->probe_info[i];
+	}
 
-	t->port_dir[0].procname = port->name;
+	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
+	/*
+	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/PORT/devices.
+	 * We calculate for the second as that will give us enough for the first.
+	 */
+	tmp_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
+	tmp_dir_path = kzalloc(tmp_path_len, GFP_KERNEL);
+	if (!tmp_dir_path) {
+		err = -ENOMEM;
+		goto exit_free_t;
+	}
 
-	t->port_dir[0].child = t->vars;
-	t->parport_dir[0].child = t->port_dir;
-	t->dev_dir[0].child = t->parport_dir;
+	bytes_written = snprintf(tmp_dir_path, tmp_path_len,
+				 "dev/parport/%s/devices", port->name);
+	if (tmp_path_len <= bytes_written) {
+		err = -ENOENT;
+		goto exit_free_tmp_dir_path;
+	}
+	if (register_sysctl(tmp_dir_path, t->device_dir) == NULL) {
+		err = -ENOENT;
+		goto  exit_free_tmp_dir_path;
+	}
 
-	t->sysctl_header = register_sysctl_table(t->dev_dir);
+	tmp_path_len = PARPORT_BASE_PATH_SIZE + port_name_len;
+	bytes_written = snprintf(tmp_dir_path, tmp_path_len,
+				 "dev/parport/%s", port->name);
+	if (tmp_path_len <= bytes_written) {
+		err = -ENOENT;
+		goto exit_free_tmp_dir_path;
+	}
+
+	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
 	if (t->sysctl_header == NULL) {
-		kfree(t);
-		t = NULL;
+		err = -ENOENT;
+		goto exit_free_tmp_dir_path;
 	}
+
 	port->sysctl_table = t;
+
+	kfree(tmp_dir_path);
 	return 0;
+
+exit_free_tmp_dir_path:
+	kfree(tmp_dir_path);
+
+exit_free_t:
+	kfree(t);
+	return err;
 }
 
 int parport_proc_unregister(struct parport *port)
-- 
2.30.2

