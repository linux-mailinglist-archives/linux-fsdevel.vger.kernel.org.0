Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC57560CC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiF2W4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiF2Wzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496F40E78;
        Wed, 29 Jun 2022 15:55:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4FJC014302;
        Wed, 29 Jun 2022 22:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+ZwP+XVit+nEQkoxtxba0giR3shxsD8YmnIgagKvZfw=;
 b=uG5gpTkmc6X8x+/N8e5Pl3aXzVhWeUbKYZA6N/7xPDtlRWig+04r9MPl/sWVqoxuCWrr
 kx9gm9b9bQe4DYcFlGJorhK9Ny7LTVSU723JU7En2eizOaEVPx4PGCBMP9Dej9ogFBwd
 EQV5UFGc5YnuV5cbRAg10BiThfvfKd3ZZ9x1xOeSBICXm69L/V9sK2xPf644ZSHtB0lU
 EOTFBkHAPmgCeVo7RLR5JEbce/kUJz7JBhlGy6NlMYEbvc22IQEGFdE0gst3I4XghhEZ
 RfKtOow4knikTCzD81Au1OT5A4FK+bAovG3TJ3Fb/ftOsiLWyoxfbD7MjQgerU92/iwC Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysjgug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMexmb033590;
        Wed, 29 Jun 2022 22:54:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3wyy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8w9Z9NjJf2adh4OgJSh+hrp/YAoNy9AijPKlAbamrRTSZ2xZGLgWI7uGvD44nhoFKIlTyeSuB+BgJaPKzTCXwX2pvJRrarmcjEHzOVv6gFQLIJaJTpza0ZMoZQTfKu8FB8XBgC+52ZAiZ2Z+lqLCbt6S//jZsKy64nDNkhSQ5SVGG2ABXQYNVOiDv4TDODpPgbJRJAPjybf948vCygl8pneW/IvWfDIDLK8EiOkBXpXYay5bvXJKhFb1cdAp1xF+TPjl+nnzEEkuyM/zysrFWZnyMMyIOSmYjeSPiTF7ahDxtYRMc+OseMok1b7HBsFb1NhqeQynGwT3mRMWhhAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZwP+XVit+nEQkoxtxba0giR3shxsD8YmnIgagKvZfw=;
 b=aGkYixFq1NIYKGgIFyvFexsNXIxY+V27/WM/SjGIIYwj2rM7TmPcShYcOMJKfiOfpJF9MbVoDjDAcdn4S53MdSeTP6MY/r+KEA035k+7cyyf640CPEJW1+nl1jZphxnuglF61T56ZtL4yYyYGsHf6TINrLmfj/MbIMI8/vWywjyoGll4IHQQMQWDpje3dxrRcw8M0CemtIEALJM69FSwN0FC6hcoUH+HXdZQkUOfqhtZEnuQtHZ8uCzIBYAlp4zrvd2XUwPZ1c05j/5lcTgrhIrSY9jzOEFV1frpw8HWDd1FZUz6cTeIYcJfXpLTvLlAb7L2vUXSrSWqu8H4nvGEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZwP+XVit+nEQkoxtxba0giR3shxsD8YmnIgagKvZfw=;
 b=tdtk/QBw0yxzyQ9uDS7MTY3VPXvYxeuBqSIYAuTzVpijio6aTMnBjLXpdaoBDT4cdA8LyjqFkBTXxqFwyRX7gFPH8SFwy/4piKavMLzorXQaYR5eqL34MbUEKwC13jkdq9wBvkOrzeOrf2TQds6tT1EbW0gmID1nshiTEewqB8g=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:29 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:29 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v2 6/9] mm/mshare: Add mmap operation
Date:   Wed, 29 Jun 2022 16:53:57 -0600
Message-Id: <d7ae3b880dc3a26129486d5680db672289d2695c.1656531090.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1656531090.git.khalid.aziz@oracle.com>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::6) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d5b35b-6ca6-488d-bbae-08da5a22528b
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z274RsqRpcKiz6IaYl73EgzXuqT4KbLA+4GeiLyLqu4rxlY3J+NXGakwoCFzz/RbkM4WcffmQGgOhrJeeYg3MgqPiw2/QXupy30BLv1SbHP1EMR1wCNzK/btNs0ZCRCNT3ho2ZN86/op8zfowAA76DedBoucR4vFXjCO6IUOmBRGIdhRcAf/vgGOGz+o9fJLn8QbTjILHWj9w+X2K2WtLo2UKE9jbgS9x/uY18+ZLEPAWwPQLWhJxV/350nathGDiozmaXkKj6x7jW58WRyI0eSAhQc7gyWo1Ne0upigPZT/8897t8J84COSrgXe9P6ZxLvvGPbK1daUPvpxtheu1IgiSDhkCPt6dHRSDE11KRYfruEyr97edLyvnc8kLEDPNUoiVPXBAAEZaIaZ1uAk9Pr1lI6U3e+iGxtepEfrc+uHwXn+EMRdj0sRcsyLf/5FsiJKBD4bsTyMyNvkYcsmLOcSKWeHh9FYj/RbZ/aYspUnegD4jM3syN4iuJPoWeeH3FGvfqhfzCw9dULuBJPazhF7FNuMBCC1MSPSZFujhzoAeuoe4If8t4cOZiC34P1xqAd2DzRS8SCTuZK1sESTggAYpzeej0hqedm0MvttuTOQMiPxm0lKSLFYSSK7J4y5gatYMVPAkRS76kuSc00uRQUsWdRVxOERXe492xk2bj3YvQlFjDFJuL5ZB7ZNLvRzEB7hjsLfd/tU2jP7faBmOL2qIh7IGMXbZjAcH+NVVLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N98ikKuorsWIAnGCzMIK2yy2uusc9VY6hl5AWloOEFB4Hv/tGhF8vAfLt1tu?=
 =?us-ascii?Q?Px+BKlhohGUY5q5h+dOfHSA9Sh6oKA1Di2/JGUgITu5RhWxXOs2chQxnKIu1?=
 =?us-ascii?Q?GnwhhSa0RgMjwoknjGRxPLRR6Ri5lMcvPnp6+357ACMrLiAlxzsVMGdqM5tS?=
 =?us-ascii?Q?mEXggTMGt5ZDcJVRwH87708iyH4b1IqQVAeGX+Pb8CVx7YSlqggaz238A+jP?=
 =?us-ascii?Q?Zo2viKY5KQaDxwf3FSJKUjao5mZfwH/DDgHnZOqTDU0tVMDf7zqgVnQ4RpdK?=
 =?us-ascii?Q?cke+a1w4Rbi6Vvwdmbh6+1lkWrwP3hp16ylkjihS/lIulmJ/OgmzqdXj8BDV?=
 =?us-ascii?Q?+iSHPepMW4hgQKUUFiAtXwEE+H6QQdal1UIyJ76YV5qklIdgGz8PokkuRmJg?=
 =?us-ascii?Q?qIzVQDev6jFr62CCkMtp2h4+BKdnrJAnzoBozgkm0rX4HaWYcn5yKTOTUGc5?=
 =?us-ascii?Q?JjPcRjR8vDQ3gveQKy2ycBAd7TbFidTgPnIap8VcbiQglmNQu/HOm20oNpn6?=
 =?us-ascii?Q?pvkkgd55CYjR5C919GNVppcSrRB3ycXLGhDJ/3NXrX1FyxyNkaoKeKdK+7sl?=
 =?us-ascii?Q?CWozDeYVfe9Jnf89ldXY1yFXDDmJc3OrvWUshso6LxYAk+Z/mAFzn0qrpddt?=
 =?us-ascii?Q?fDoZ0DdqPrFv7L7F31jEqVIJdYY6XS1nft6T4Eq7KHueb6IAORSZ5dsogLx+?=
 =?us-ascii?Q?eBbOIkE2wqEF1wK6eojbTk8QriBipV/Tum76BCNMOgIFV+vyKMZ7dBdY3hnK?=
 =?us-ascii?Q?c4NhKCxxOoTyHhL5Y3I43Yz1IiudCDGX5UsQ2+aYsNbV6UgdjdP/PeQHovGQ?=
 =?us-ascii?Q?8l6Qkr5knMi2DX9SEcIJoiiLilr3w8PJOfiVFoF5YJFrkNDDo60hcDiBSBRY?=
 =?us-ascii?Q?CJyYTk6NrrrxtGt1enfKEepXDY3UFsRyCf+GyaCA1eNPCbN9GKzpQOLTO7E5?=
 =?us-ascii?Q?9evIuswN9xwdwYGzl5hRESiCk8EFJC+6LbfQZXrCx51dpRquIj22LIbV5qL7?=
 =?us-ascii?Q?olEOey1Ipmftr9vB7VwjvAGjtbhc1uDZbkmVjEuWHDrRg0BE+X4fKgz0vxJv?=
 =?us-ascii?Q?AHhO39fjqydJuPth7rsEOywzQgL0WINhHoJf70S64xYZ0RijYsPEC3dW0Qp1?=
 =?us-ascii?Q?7y/iSMu87YsMCE+oErFF6vTvpnLc1BHYTz3J/XWnCaYtkEWPmQOvLe3iU7OI?=
 =?us-ascii?Q?Q/N9BFqklv8xR6/8+/dhfsA3mtZQboeWky87k+zlDVCG5B05FyqO7rsB224p?=
 =?us-ascii?Q?3zrnjtI9R2y0hpunkcgg3/T3E7Oud9vrp6EYMJRiyOF8df+US/CwyR5ERgsS?=
 =?us-ascii?Q?O2ag3gg+r7yMU/g16Q8QcMMZd/SSY23WBVF3NeLJoMxMix7XmMgHLfxMGoBX?=
 =?us-ascii?Q?ukRkJUd9nRk0Cvrp0lB+CuHsHkt3bxGhRvb0OcGtf34QnBT2VUGAxYxEnog2?=
 =?us-ascii?Q?JsMSne8JrJ5K5mSW2dW6HEGKCqXJbHJdqTGsn8wcqD3WIbks0cS2t+yp056h?=
 =?us-ascii?Q?p9UQd+toBD9JRflfkGxkb66/sf/02zesitqbEW1DLEjQ+HXy0sXsfDMCRmDv?=
 =?us-ascii?Q?FQ8QmWIlxICkcPIO7EZaS9jyJYdoLvdal2Dp0tkW0vNEnVk2dQy+WbYM/hW6?=
 =?us-ascii?Q?2sxUwhNs3663CB6rXHnWOZ4OeRqVZO9/sUOG1OHGQEd0qHHCvaWmIlxgULEN?=
 =?us-ascii?Q?NVtd/Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d5b35b-6ca6-488d-bbae-08da5a22528b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:28.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: is7W/4RpK+LME/ERJg9ogCFlhDiFLFEeF/YtDo9lshqE14503fkvaIE98/gMp/rqHCjFVBL6QSMEPJ03nQAT2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: Q6OADERyjJVXaWx6uFCk5ZwTLwJtbpqu
X-Proofpoint-GUID: Q6OADERyjJVXaWx6uFCk5ZwTLwJtbpqu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mmap is used to establish address range for mshare region and map the
region into process's address space. Add basic mmap operation that
supports setting address range. Also fix code to not allocate new
mm_struct for files in msharefs that exist for information and not
for defining a new mshare region.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mshare.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index d238b68b0576..088a6cab1e93 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -9,7 +9,8 @@
  *
  *
  * Copyright (C) 2022 Oracle Corp. All rights reserved.
- * Author:	Khalid Aziz <khalid.aziz@oracle.com>
+ * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
+ *		Matthew Wilcox <willy@infradead.org>
  *
  */
 
@@ -60,9 +61,36 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
 	return ret;
 }
 
+static int
+msharefs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct mshare_data *info = file->private_data;
+	struct mm_struct *mm = info->mm;
+
+	/*
+	 * If this mshare region has been set up once already, bail out
+	 */
+	if (mm->mmap_base != 0)
+		return -EINVAL;
+
+	if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
+		return -EINVAL;
+
+	mm->mmap_base = vma->vm_start;
+	mm->task_size = vma->vm_end - vma->vm_start;
+	if (!mm->task_size)
+		mm->task_size--;
+	info->minfo->start = mm->mmap_base;
+	info->minfo->size = mm->task_size;
+	vma->vm_flags |= VM_SHARED_PT;
+	vma->vm_private_data = info;
+	return 0;
+}
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= msharefs_open,
 	.read_iter	= msharefs_read,
+	.mmap		= msharefs_mmap,
 	.llseek		= no_llseek,
 };
 
@@ -119,7 +147,12 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 	info->mm = mm;
-	info->minfo = NULL;
+	info->minfo = kzalloc(sizeof(struct mshare_info), GFP_KERNEL);
+	if (info->minfo == NULL) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+
 	refcount_set(&info->refcnt, 1);
 	inode->i_private = info;
 
@@ -128,13 +161,14 @@ msharefs_fill_mm(struct inode *inode)
 err_free:
 	if (mm)
 		mmput(mm);
+	kfree(info->minfo);
 	kfree(info);
 	return retval;
 }
 
 static struct inode
 *msharefs_get_inode(struct super_block *sb, const struct inode *dir,
-			umode_t mode)
+			umode_t mode, bool newmm)
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
@@ -147,7 +181,7 @@ static struct inode
 		case S_IFREG:
 			inode->i_op = &msharefs_file_inode_ops;
 			inode->i_fop = &msharefs_file_operations;
-			if (msharefs_fill_mm(inode) != 0) {
+			if (newmm && msharefs_fill_mm(inode) != 0) {
 				discard_new_inode(inode);
 				inode = ERR_PTR(-ENOMEM);
 			}
@@ -177,7 +211,7 @@ msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	struct inode *inode;
 	int err = 0;
 
-	inode = msharefs_get_inode(dir->i_sb, dir, mode);
+	inode = msharefs_get_inode(dir->i_sb, dir, mode, true);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -267,7 +301,7 @@ prepopulate_files(struct super_block *s, struct inode *dir,
 		if (!dentry)
 			return -ENOMEM;
 
-		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
+		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode, false);
 		if (!inode) {
 			dput(dentry);
 			return -ENOMEM;
@@ -301,7 +335,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op		= &msharefs_d_ops;
 	sb->s_time_gran		= 1;
 
-	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777);
+	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777, false);
 	if (!inode) {
 		err = -ENOMEM;
 		goto out;
-- 
2.32.0

