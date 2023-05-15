Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2157025D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjEOHO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbjEOHOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:14:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0650E76
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:52 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071451euoutp02ebabd84cb2badccc913d513c1155dac6~fP8LC-vej1681316813euoutp02B
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230515071451euoutp02ebabd84cb2badccc913d513c1155dac6~fP8LC-vej1681316813euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134891;
        bh=PDU9jqEs8417s9sxrU7lh3cS+FBJYDs7iRwM4PSqxjk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=NZvcG6txfKlALnmoGaVSt9TgWjC4sNfXlVEjymrJmfLZjYd3mSP3OWsWHv3JX7adV
         Cy5aHSw67LOmXoIdjOfmJkyQFT0SKMfNLImZMI1VeKgRX85LPFjvPZltVgV2YkOVUu
         IbaIoRFeAPtfnuzKSSz8hCgRSj5wEBCkTKVrFvxQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515071451eucas1p132717dca0137ef15506aa989d1fe48cc~fP8K1UiQL1417814178eucas1p1q;
        Mon, 15 May 2023 07:14:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.71.42423.AEBD1646; Mon, 15
        May 2023 08:14:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8~fP8Kf7ZEv0313203132eucas1p1j;
        Mon, 15 May 2023 07:14:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515071450eusmtrp2d0828b702e0a9f3c6141673ac46d8aa5~fP8KfIRdp2610526105eusmtrp2H;
        Mon, 15 May 2023 07:14:50 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-8e-6461dbea09a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.D9.14344.AEBD1646; Mon, 15
        May 2023 08:14:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071450eusmtip19478c10b8a19fdd7ccc945b06d0b0a33~fP8KQPBLz3240832408eusmtip1E;
        Mon, 15 May 2023 07:14:50 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:49 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 2/6] parport: Remove register_sysctl_table from
 parport_proc_register
Date:   Mon, 15 May 2023 09:14:42 +0200
Message-ID: <20230515071446.2277292-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned3XtxNTDGZ9ZbQ4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1issmJTUn
        syy1SN8ugSvjxru7bAWTVSo65u5nb2DcIdvFyMkhIWAiceXiR2YQW0hgBaPE5zsCXYxcQPYX
        Rol1U9exQDifGSV+/n7ACtPx4ctidojEckaJBxPOscNVbX4wmxXC2cIo8XJhPyNIC5uAjsT5
        N3fAlogIiEucOL2ZEaSIWeApo8Tcf71MIAlhgXCJ0x/uAXVzcLAIqEocP+gBEuYVsJVo6LgP
        tVpeou36dLCZnAJ2Euv2H2WCqBGUODnzCQuIzQxU07x1NjOELSFx8MULZoheJYmvb3qh5tRK
        nNpyiwnkBgmBBxwSp98sZYNIuEjsu7SYEcIWlnh1fAs7hC0j8X/nfKiGyYwS+/99YIdwVjNK
        LGv8ygRRZS3RcuUJVIejxOr1d9lBvpEQ4JO48VYQ4iI+iUnbpjNDhHklOtqEJjCqzELywywk
        P8xC8sMCRuZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgSnm9L/jn3Ywzn31Ue8QIxMH
        4yFGCQ5mJRHe9pnxKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFk
        mTg4pRqYnFdqdJ70XW8/14i9aA/PY6dZ91ZEfZErfnC8geNmRv5h4yLNVTPzq1bmS3l+u9LS
        dubEMlZ93krWqzLLr+il6PBee73oYkbhyr5yT6PbV8yr9eSX7F2xxPA8/yG3SYZrj85x1ljj
        0MLT8N3ZTeJM+oOk9ER9dWV9memqv2fd+XszP1Fw18ZbD0r5bu5tl/ZJ+/Hur/oHyfIcXoeD
        J1gO8nzz/vc2PKF1S/NEx32piilTMmMUpp1emBrudIHzkOOttY/v/oz+87hk1bMbf4PvK5gt
        fJWq9OnvGmc5NxuL0o8vt5yvSH70J9HDe20KH+sR9/2vSg8e6de9979C/9w183exbJ2uuxTd
        X+rN93jfpcRSnJFoqMVcVJwIADyi8oSgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7qvbiemGBxq17E4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jxru7bAWTVSo6
        5u5nb2DcIdvFyMkhIWAi8eHLYvYuRi4OIYGljBKLnp9khkjISGz8cpUVwhaW+HOtiw2i6COj
        RMvaT8wQzhZGiZ1797KAVLEJ6Eicf3MHrFtEQFzixOnNjCBFzAJPGSVmHnrKBJIQFgiVeN6z
        BKiIg4NFQFXi+EEPkDCvgK1EQ8d9qG3yEm3XpzOC2JwCdhLr9h8FaxUCqjm9axsrRL2gxMmZ
        T8D2MgPVN2+dzQxhS0gcfPEC6gMlia9veqFm1kp8/vuMcQKjyCwk7bOQtM9C0r6AkXkVo0hq
        aXFuem6xkV5xYm5xaV66XnJ+7iZGYPxtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMLbPjM+RYg3
        JbGyKrUoP76oNCe1+BCjKdCbE5mlRJPzgQkgryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2x
        JDU7NbUgtQimj4mDU6qBSdFPlLlMpmt1xdy4d/YTHY7V2asL7f474+P+yHOrfzj6sXD+snkU
        /03kScI0k4U3BSty11cZaJZO+pLBcWV93g3Go4duznlUw1SZJ7uz/tDnZxkdRqf3+9fF8cxR
        Pi0uKFLP7zTVO+22x/HZi5ueKnx6sKK+foHP+qX5wf5m57aFuDX/WSqb8SWy4PLNBYfCdkgV
        PDtiYL9kYiC/a2eQe8zlD2enTDhhb2VY++NoqptIe8Gysr7tlivdA2uCbZ6fmiLGNOvG49Ar
        Xb/EWe5oqx44eD6zw7Xtfeyb58WCb5uPhjCl9iZzli199FElflVJTn/10wscQsUfjLN/xtis
        23ztDtM5S/YUn9ofhjfalFiKMxINtZiLihMBjL9PN0gDAAA=
X-CMS-MailID: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
X-Msg-Generator: CA
X-RootMTR: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c | 89 +++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index d740eba3c099..53ae5cb98190 100644
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
@@ -477,7 +468,9 @@ parport_default_sysctl_table = {
 int parport_proc_register(struct parport *port)
 {
 	struct parport_sysctl_table *t;
-	int i;
+	char *tmp_dir_path;
+	size_t tmp_path_len, port_name_len;
+	int i, err = 0;
 
 	t = kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
@@ -485,28 +478,60 @@ int parport_proc_register(struct parport *port)
 
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
+
+	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
+	/*
+	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/PORT/devices.
+	 * We calculate for the second as that will give us enough for the first.
+	 */
+	tmp_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
+	tmp_dir_path = kmalloc(tmp_path_len, GFP_KERNEL);
+	if (!tmp_dir_path) {
+		err = -ENOMEM;
+		goto exit_free_t;
+	}
 
-	t->port_dir[0].procname = port->name;
+	if (tmp_path_len
+	    <= snprintf(tmp_dir_path, tmp_path_len, "dev/parport/%s/devices", port->name)) {
+		kfree(tmp_dir_path);
+		return -ENOENT;
+	}
+	if (register_sysctl(tmp_dir_path, t->device_dir) == NULL)
+		/*
+		 * We keep the original behavior of parport where failure to register
+		 * does not return error.
+		 */
+		goto  exit_free_tmp_dir_path;
 
-	t->port_dir[0].child = t->vars;
-	t->parport_dir[0].child = t->port_dir;
-	t->dev_dir[0].child = t->parport_dir;
 
-	t->sysctl_header = register_sysctl_table(t->dev_dir);
-	if (t->sysctl_header == NULL) {
-		kfree(t);
-		t = NULL;
+	tmp_path_len = PARPORT_BASE_PATH_SIZE + port_name_len;
+	if (tmp_path_len
+	   <= snprintf(tmp_dir_path, tmp_path_len, "dev/parport/%s", port->name)) {
+		err = -ENOENT;
+		goto exit_free_tmp_dir_path;
 	}
+
+	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
+	if (t->sysctl_header == NULL)
+		goto exit_free_tmp_dir_path;
+
 	port->sysctl_table = t;
+
+	kfree(tmp_dir_path);
 	return 0;
+
+exit_free_tmp_dir_path:
+	kfree(tmp_dir_path);
+exit_free_t:
+	kfree(t);
+	t = NULL;
+	return err;
+
 }
 
 int parport_proc_unregister(struct parport *port)
-- 
2.30.2

