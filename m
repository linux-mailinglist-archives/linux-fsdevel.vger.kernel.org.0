Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC67025D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbjEOHPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjEOHOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:14:55 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F301706
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071452euoutp0109951fb7830e884d26f7ffe868f6e4b0~fP8MiKquM1728617286euoutp01J
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230515071452euoutp0109951fb7830e884d26f7ffe868f6e4b0~fP8MiKquM1728617286euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134893;
        bh=pPeOSNpDerzdo/FVgNwvDrLtKcZvo6bRygcnqynFxfQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=r9rmFihlVwaRGesybwZCaM4ZInmYHptRYNEbXG5a0U7kiAqFpsCZ8q3/I6tUS54TK
         8MSMU3m9wqQ3Jj5lZg5su3gQG2yf66sAwJ0sdyWTYfO7egxmLwY5TCA6N8v4ICyQy0
         LnwZd8zlostG/ZU1y9yQwzkR70aTP3amoupWoFY8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230515071452eucas1p251025117b061f9d4d3f3c84daa2e17d8~fP8MP6ujt2288622886eucas1p25;
        Mon, 15 May 2023 07:14:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.86.37758.CEBD1646; Mon, 15
        May 2023 08:14:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071452eucas1p1d535f6636b45c193b6b24fa59ff100a6~fP8L9KcZN0787607876eucas1p1R;
        Mon, 15 May 2023 07:14:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230515071452eusmtrp13fa7e979424c539e5e5d7d31a9a89e68~fP8L7XKca2273622736eusmtrp1w;
        Mon, 15 May 2023 07:14:52 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-d5-6461dbecbde0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.07.10549.CEBD1646; Mon, 15
        May 2023 08:14:52 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071452eusmtip18031777c491eae90940c46db488c7711~fP8Lucy-S0864508645eusmtip1q;
        Mon, 15 May 2023 07:14:52 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:51 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 3/6] parport: Remove register_sysctl_table from
 parport_device_proc_register
Date:   Mon, 15 May 2023 09:14:43 +0200
Message-ID: <20230515071446.2277292-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd03txNTDHZsULY4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1issmJTUn
        syy1SN8ugSvj5rajzAWLxCv23O1gbGD8LdTFyMkhIWAiMW/nP7YuRi4OIYEVjBInlm9mhnC+
        MEpce/WYBcL5zCgxfXEvE0zLqeN7WSESyxklFrbeZwZJgFXtWisEYW9hlLj1kwPEZhPQkTj/
        5g5YjYiAuMSJ05sZQZqZBZ4ySsz9BzFVWCBO4vacCYwgNouAqkTLi/ksIDavgK3E7hlnmCE2
        y0u0XZ8OVsMpYCexbv9RJogaQYmTM5+A1TMD1TRvnc0MYUtIHHzxAqpXSeLrm15WCLtW4tSW
        W0wgR0gIPOCQOPnxElAzB5DjInHzrztEjbDEq+Nb2CFsGYnTk3tYIOonM0rs//eBHcJZzSix
        rPErNFysJVquPIHqcJTY8n8iK8RQPokbbwUhDuKTmLRtOjNEmFeio01oAqPKLCQvzELywiwk
        LyxgZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmGBO/zv+dQfjilcf9Q4xMnEwHmKU
        4GBWEuFtnxmfIsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFqEUyWiYNT
        qoGJa99KD4Xja6/KJjkcv3P5UfNEqUOhkd5vvviLmpR9ON+1+NPcQrXE/9uedW+5Idja43Sy
        6OEt75Xsu5qPBU7meNf1Ny0u+kxXB8OWnasv7tH881fg0e+jewI5urpEY1iO7hORW8nNlqh4
        emdsR+y9K8KPHl8pE98i1SCY4xS/SUgyo5YxQeFUy814QZXeTN9nGprvVXjlln37Gn77DoOR
        2V6/2/UV8+Ne7PRbxtyvLBBQt+2fv8UE78+VjWc3OEyYz3k3yyB0pc1G2ZCV/4LW5Kgb3X2p
        LjL3jvjkRNb1gqV3D66Y8z5Yz+7QR/0/bH6zf6YtuVA+6fD77SesWhL+aL7UUAybqOuxLTZm
        wVMTJZbijERDLeai4kQALdJbz58DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7pvbiemGHTNE7I4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j5rajzAWLxCv2
        3O1gbGD8LdTFyMkhIWAicer4XtYuRi4OIYGljBIPPj5lhUjISGz8chXKFpb4c62LDaLoI6NE
        x6FGZghnC6PEwgf72EGq2AR0JM6/ucMMYosIiEucOL2ZEaSIWeApo8TMQ0+ZQBLCAjESj+Ze
        BytiEVCVaHkxnwXE5hWwldg94wwzxDp5ibbr0xlBbE4BO4l1+4+C9QoB1ZzetY0Vol5Q4uTM
        J2C9zED1zVtnM0PYEhIHX7yAmqMk8fVNL9QLtRKf/z5jnMAoMgtJ+ywk7bOQtC9gZF7FKJJa
        WpybnltsqFecmFtcmpeul5yfu4kRGIHbjv3cvINx3quPeocYmTgYDzFKcDArifC2z4xPEeJN
        SaysSi3Kjy8qzUktPsRoCvTnRGYp0eR8YArIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8s
        Sc1OTS1ILYLpY+LglGpgWuUWf4jzn8ryg1/k97gGflq+rzQjY/L3mXEvBPtun+X45SG+/95i
        YdmKV7OS300+tDGlPiqy81nT+haXExp7ZmxqMiyPrVkXMJ0zxWZqsWTPrH19cVdcDq1iY/gm
        P9vFOJU12GW/kIxOiMXF9XvdYzQtXxwosmTS7GhodjzDY75y8rrzW7XCDz5++nKOupoad3lY
        RH+OXcL/zlPvrvHPeGS0iqvt3Xr5bRczhIVWdl3P1HBmUZpao7CqILsvQ8dLcy/fcVmVjTOD
        GD89r/1/YpJ29qqrR7oOX1vG9tNoddXZu39z/qSlZnkHiX82i9t4a8a9jZ29wSmHlk2yWH/q
        0GXfEEvZo7vcvk10+hzupsRSnJFoqMVcVJwIAG4s7JtJAwAA
X-CMS-MailID: 20230515071452eucas1p1d535f6636b45c193b6b24fa59ff100a6
X-Msg-Generator: CA
X-RootMTR: 20230515071452eucas1p1d535f6636b45c193b6b24fa59ff100a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071452eucas1p1d535f6636b45c193b6b24fa59ff100a6
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071452eucas1p1d535f6636b45c193b6b24fa59ff100a6@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. We use a temp allocation to include both port and
device name in proc. Allocated mem is freed at the end. The unused
parport_device_sysctl_template struct elements that are not used are
removed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c | 57 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 53ae5cb98190..902547eb045c 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -384,6 +384,7 @@ parport_device_sysctl_template = {
 			.extra1		= (void*) &parport_min_timeslice_value,
 			.extra2		= (void*) &parport_max_timeslice_value
 		},
+		{}
 	},
 	{
 		{
@@ -394,22 +395,6 @@ parport_device_sysctl_template = {
 			.child		= NULL
 		},
 		{}
-	},
-	{
-		PARPORT_DEVICES_ROOT_DIR,
-		{}
-	},
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
 	}
 };
 
@@ -547,30 +532,54 @@ int parport_proc_unregister(struct parport *port)
 
 int parport_device_proc_register(struct pardevice *device)
 {
+	int err = 0;
 	struct parport_device_sysctl_table *t;
 	struct parport * port = device->port;
+	size_t port_name_len, device_name_len, tmp_dir_path_len;
+	char *tmp_dir_path;
 	
 	t = kmemdup(&parport_device_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
 		return -ENOMEM;
 
-	t->dev_dir[0].child = t->parport_dir;
-	t->parport_dir[0].child = t->port_dir;
-	t->port_dir[0].procname = port->name;
-	t->port_dir[0].child = t->devices_root_dir;
-	t->devices_root_dir[0].child = t->device_dir;
+	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
+	device_name_len = strnlen(device->name, PATH_MAX);
+
+	/* Allocate a buffer for two paths: dev/parport/PORT/devices/DEVICE. */
+	tmp_dir_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len + device_name_len;
+	tmp_dir_path = kmalloc(tmp_dir_path_len, GFP_KERNEL);
+	if (!tmp_dir_path) {
+		err = -ENOMEM;
+		goto exit_free_t;
+	}
+
+	if (tmp_dir_path_len
+	    <= snprintf(tmp_dir_path, tmp_dir_path_len, "dev/parport/%s/devices/%s",
+			port->name, device->name)) {
+		err = -ENOENT;
+		goto exit_free_path;
+	}
 
-	t->device_dir[0].procname = device->name;
-	t->device_dir[0].child = t->vars;
 	t->vars[0].data = &device->timeslice;
 
-	t->sysctl_header = register_sysctl_table(t->dev_dir);
+	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
 	if (t->sysctl_header == NULL) {
 		kfree(t);
 		t = NULL;
 	}
 	device->sysctl_table = t;
+
+	kfree(tmp_dir_path);
 	return 0;
+
+exit_free_path:
+	kfree(tmp_dir_path);
+
+exit_free_t:
+	kfree(t);
+	t = NULL;
+
+	return err;
 }
 
 int parport_device_proc_unregister(struct pardevice *device)
-- 
2.30.2

