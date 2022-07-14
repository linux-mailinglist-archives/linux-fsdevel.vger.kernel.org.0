Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E43574079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiGNAXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiGNAXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:23:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3C17AB5;
        Wed, 13 Jul 2022 17:22:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E09RZg021473;
        Thu, 14 Jul 2022 00:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=TQcsHYOiQzrFR86kwcDg5R/L0gioZBwzsHJI+4HDMvA=;
 b=aFbysCsIYDLkuYE2RqDr921h0RA9gg01OHi90HhtHRBItrtsuMFAQeNHQnx6IHe3cB8M
 2spoKXuFdWevLywbnCRqlFwh5RnsDCc+h+iEujs8AtqKg/7OTMTaeCl/1BKmwUUyoH/L
 193E2sydJN0DCMVFy+VxG2qHppz54e07tjjMRWMBUiVmnjNR+31Z807aZIcFYtD0WkVm
 hxM4NFCxUXBEPQvMXfVliv8cSYj/TfUiJ42ZTYrQc+B0RTGWC6XzXZw2lGAvcbvzdn1i
 yWTppV1GiubpDP8Y8kh/db/jq3XEYu4QhmmY/oKOFSOkKwWmvst/dVdstXD0CfFqwRXG 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg3j6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E0GteL031842;
        Thu, 14 Jul 2022 00:22:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70457bqh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmLKOHsYSDB+lWX43GrtfKa+KuqwdrwAFicEnNmR7vxefH5+uRvGvsCk0MYF+vRivu0fD77OFqJDuH+pkVbr0sUN5TKwYzoRINVP5vvoE6QVBXJmFBgj3PRt7R9kzzbxoTGQsFoeYKJBscerXZupHRmzq1vqi9Sf+lCkVxwnl8tWqkfyv1SM9Atn62iNrObtwyLZ4OMawMIC4G3BipLoohXvnaYDkidaY2QrdetAxxSkKO51FScABbcX5rpnRQKVYbntT0AwSVEAUOTNt/6VQjukKmDxPs1Vimrjm/0JnilH3J5LkbEnBeWZPKYOjSQnlNc3gu0RfBApItec4f8Xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQcsHYOiQzrFR86kwcDg5R/L0gioZBwzsHJI+4HDMvA=;
 b=U/Zw2z9M2kWjrAo/iidxvrPhINLOsi9l2qnnIChp5tINN7p4pMMFyc5Wiqf5Iu7Pw3/wgo7U5si74OqlWUuh6A6FWIe30BOvR48iQX/vdqJvyB/fliq4Lu4BUYaID7y3AA2s5yKnHKJxcZUm06cUyKHImV/xy+/Iuf9cdF6n/B2mEynYlgiVOoE8/0Q73BoSMcXKIKqbNIza0ADI7mu00WXiiPGiFkyJtfOH43q7N9wbPRDlRUTj0TZin7OzxuSJo5OJXxhiALxyUExg9a1n0wGaGxNBjJFAw4sXU8WzmyXaYsjudTsKh2hTO+iQSj60p8yjpYel5HfCp1e9wPT4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQcsHYOiQzrFR86kwcDg5R/L0gioZBwzsHJI+4HDMvA=;
 b=U2DkH7L+k9pJT6ogYrJM/BStBNYHRRX60dHxZOGv8nqiDFJFH0RwA5W61tqsi1aUEgNyCzZS+g9uaRhXmh4scDghjpolyekrVyvzvlcyGG9lA+c3zxUJIb0gL+Wyn15qKifSLE2q0w58S0ujVlv7UnDs8gQRXbVZqdfI237wnmg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 00:22:45 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%7]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 00:22:45 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] kernfs: Add a document to describe hashed locks used in kernfs.
Date:   Thu, 14 Jul 2022 10:22:24 +1000
Message-Id: <20220714002224.3641629-6-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714002224.3641629-1-imran.f.khan@oracle.com>
References: <20220714002224.3641629-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51970c65-7765-43fb-5775-08da652ef994
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tQrEtlEV1I/ivvsQEg0hMvtycPmzUqwrpeoH8FyEVSgat4GmIRYqOlhdSpt+l5rUlfKMUeJI3coTmKPVNyUrCD/7K2+v40KntjD94mn8HvncQ8INkg+M80vsNHFnQp1yxkwCtIG+yFx4oDkg2SsiDIdfYLyM3jMw8YGZuZ7MqWpwvB97ITY97X19ujHHc0eoaaW6cz99S1BtbQ7IYwo2817KYlNTHbLeDEe30K/V2Y7VwQ4fH5og2xmCi8n2Hrp8uXvJOKBfANC7s3VxEtskwNhgyBOTvCe3ob1iZlzmXUi67dnUOH8nxa1SNj+U/70LM2BuKgsmhOzde0Doz6QNo867TLWoH3SSfQCdVaPQm9YxWW8A7tAYwBtxO41ISrZZmROGDerRLbpQXHOZcP0ZyYdDUtP4BHBNDPc5ADrX2loIoGUpAnBofpDK1rgdDKKsYgMly2TWEYC9oPHCXsW31/wuPOIUt1qZk9b2ezXcTMMLf19EUmrhPyigXCGg8DbhUd3vmxqmfwV7hmzor9JWuHNRRiogEwVNskf7VswlzQuWb5GkcBe7WnTWD1qrOocnya8erjNfIDy7i9gm/fv5KmwLKsLxRtAlRo6UlZqu1LP6HFlS9O3W/9IMK1jYkHNVQxry8s3AQPm2i4euhxUR4gMLL8ddPcywNbZGJOxDrXiE3khH29vpMsoeOkjIqp8xxnd5tdFSTtnFqkv08hY8zmvP+yx1PsS0aJqkLKkbGD0YvDlnWnh6Y17gZPvwR8GMmtsAjpU4qeUtDYT45BU+i/Ye4H3B0SEFWviTR+Z8Rp9RjdxVDb0Z4pyG4nQf4Lf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(396003)(376002)(26005)(478600001)(6666004)(52116002)(6506007)(6486002)(6512007)(66946007)(41300700001)(66476007)(8676002)(66556008)(86362001)(316002)(4326008)(83380400001)(38350700002)(1076003)(38100700002)(2616005)(186003)(36756003)(8936002)(5660300002)(103116003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhsNMf9Vbsc32H//rHFQf/XKbyiLk3gjY24Xo/+yVvLhQrczD8P2SF3B1AW5?=
 =?us-ascii?Q?G51OkNjyUh1FgpcU9ZsSViV57oYCZR8IgqsSSGz8IKGWq5fVhvf/OArWOTXD?=
 =?us-ascii?Q?m7pcWKfDRKxmEL5nb9Yj2Gn3x/7a/z0lt2qfN4KyteqQ7r09d9rCdsjrQbIk?=
 =?us-ascii?Q?ub5BZ8ZGmfCVEvwCFAwNOf0eJ0Bodk4XJGaPjbLtxB61tAxlfpiNgVPhyGB6?=
 =?us-ascii?Q?F+9BH/PO0nfuLG43svH1z9fm57ijaF+Azn2zIwtvvwEvet5HlNzrBPF3zC0m?=
 =?us-ascii?Q?addzRUg/bC3whxCL7MvGDREXtHqApv6HGzL04JvLSmply9x0rLB2W2CrMITL?=
 =?us-ascii?Q?wxk0z7R2RsFQdBJJGOrYrnoLJPJVgiNmzqyj0qa5C34j9TrPxIMQNZ6bdNBu?=
 =?us-ascii?Q?Lb1PmzJ4Zx8K7E25jjuPQ7AWkDjk9Mhmv9TbygwflMrh5nbYOlEXZJtOhnDO?=
 =?us-ascii?Q?xjmixcNjRP7oWIOh5TDiluSrVtFVECsgiNGhL4tFAHpOAX85tXPSYQyt8Wrb?=
 =?us-ascii?Q?M8JABrlP2AIz02CNWIRca5O9Em1A+dfK8zrpz08dYRkaA6Ft2dA3sEGx8Ml0?=
 =?us-ascii?Q?9s5By3T688ZMl5qO6TZs2ENU+sWyrAcBoKstzJ7WuYBiBzXzO5wmwwckpw/L?=
 =?us-ascii?Q?vEygcEdM0FGzlna5unmhkPqAp9nzf9e0M0cx4fBY/B8MdTKRCU3Sl+4h+vtq?=
 =?us-ascii?Q?Bzc8zmr+xBX+xUsXw3KXvsmZK/63dkEhVG3pQrlBW4Qe9CvWjafPWD8nMPi3?=
 =?us-ascii?Q?Ivnh69NII/Up1S7Sa20bl35A/JbZW2pRndYC/BxuY7AjhohE/2Yanpt7r0ED?=
 =?us-ascii?Q?96r8NTs45dOmn3IyJGvhovR0b+3YR13co+btgX7p3ByzXdR+D9J2CEKZo6wb?=
 =?us-ascii?Q?h5t/8avON/fdnMOoqDI68NE/Wkm/ZSmywzCVW5F4CByZfJaS8qXmlrJcSry6?=
 =?us-ascii?Q?rk3SBOd8HsbxYMXE0RtLYtDE99ENcw48QPUc5mC/yygTBzChWU872+2vJMIN?=
 =?us-ascii?Q?vIglt/4hVMKPs68X2ClnVmHC6KMxpe+teS9dDzHgARc0GJWYKcB+zQ1NVDq5?=
 =?us-ascii?Q?IIUxzdWVVQKppiY5UHcNHH31snlz402Kl/8D1cAq7QUz75Nff4LJi7uXzl4f?=
 =?us-ascii?Q?LX3E6U9kLUsqYsG1r7JfOhuOSzT5FD0ba0ZPEbE1E62n7JUn+IWNWS/+bfa0?=
 =?us-ascii?Q?SYWxaP4hfhG7mJQ72YkYI8C7uX7j7XrwNGpNclaA72AwtOJtI/FI0N7RYvw7?=
 =?us-ascii?Q?+cA0hDTLgasymLImZp/ms7NxoAatDzWPI7AbBhXqrbBp1VHNxAc4tOWpCWDQ?=
 =?us-ascii?Q?+PCwc1tIiOlC+laV7dol0C9hY5En8UhzfMMWLJ9Wdlx55VKstfs4OMwlYOod?=
 =?us-ascii?Q?mii1T98ySOj4TjPKyr6dQmwtGgSn0xmRoFfKJhDmrjiCbMmMctc+VBLUImjI?=
 =?us-ascii?Q?8dbcaUWr1d92zmmRZyWK2+QuE3lCdNz+8RSmEghLdgRjptnSRR+Jf31j6Rqt?=
 =?us-ascii?Q?Feal/pCVp+qor0dJgxrrUHNTf8KmlkQi4IUxoNHKqtLPKBGmLHsI8nAI5jdD?=
 =?us-ascii?Q?HlexYafY2/g4mWGcZg7ILW1jydnogPUbvlVJDL/5QkLUp2uAv2omKyP2e4HH?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51970c65-7765-43fb-5775-08da652ef994
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 00:22:45.7277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgedZBM7oquJnLwHT0UV/4kBEGTOAJ5KmckLJWCb6FVcVd7El5lEXhAJielCQtYcU94EtIu1tUhXnONP0VMNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140000
X-Proofpoint-GUID: 8vOw77miQM3a3dKQhrL77nV1UtK5QGTg
X-Proofpoint-ORIG-GUID: 8vOw77miQM3a3dKQhrL77nV1UtK5QGTg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This document describes usage and proof of various hashed locks
introduced in this patch set.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 .../filesystems/kernfs-hashed-locks.rst       | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst

diff --git a/Documentation/filesystems/kernfs-hashed-locks.rst b/Documentation/filesystems/kernfs-hashed-locks.rst
new file mode 100644
index 0000000000000..a000e6fcf78ca
--- /dev/null
+++ b/Documentation/filesystems/kernfs-hashed-locks.rst
@@ -0,0 +1,214 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+===================
+kernfs hashed locks
+===================
+
+kernfs uses following hashed locks
+
+1. Hashed mutexes
+2. Hashed rwsem
+
+In certain cases hashed rwsem needs to work in conjunction with a per-fs mutex
+(Described further below).So this document describes this mutex as well.
+
+A kernfs_global_locks object (defined below) provides hashed mutexes,
+hashed spinlocks and hashed rwsems.
+
+	struct kernfs_global_locks {
+		struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+		struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
+	};
+
+For all hashed locks address of a kernfs_node object acts as hashing key.
+
+For the remainder of this document a node means a kernfs_node object. The
+node can refer to a file, directory or symlink of a kernfs based file system.
+Also a node's mutex or rwsem refers to hashed mutex, or hashed rwsem
+corresponding to the node. It does not mean any locking construct embedded in
+the kernfs_node itself.
+
+What is protected by hashed locks
+=================================
+
+(1) There's one kernfs_open_file for each open file and all kernfs_open_file
+    instances corresponding to a kernfs_node are maintained in a list.
+    hashed mutexes or kernfs_global_locks.open_file_mutex[index]  protects
+    this list.
+
+(2) Hashed rwsems or kernfs_global_locks.kernfs_rwsem[index] protects node's
+    state and synchronizes operations that change state of a node or depend on
+    the state of a node.
+
+(3) per-fs mutex (mentioned earlier) provides synchronization between lookup
+    and remove operations. It also protects against topology change.
+    While looking for a node we will not have address of corresponding node
+    so we can't acquire node's rwsem right from the beginning.
+    On the other hand a parallel remove operation for the same node can acquire
+    corresponding rwsem and go ahead with node removal. So it may happen that
+    search operation for the node finds and returns it but before it can be
+    pinned or used, the remove operation, that was going on in parallel, removes
+    the node and hence makes its any future use wrong.
+    per-fs mutex ensures that for competing search and remove operations only
+    one proceeds at a time and since object returned by search is pinned before
+    releasing the per-fs mutex, it will be available for subsequent usage.
+
+    This per-fs mutex also protects against topology change during path walks.
+    During path walks we need to acquire and release rwsems corresponding to
+    directories so that these directories don't move and their children RB tree
+    does not change. Since these rwsems can't be taken under a spinlock,
+    kernfs_rename_lock can't be used and needed protection against topology
+    change is provided by per-fs mutex.
+
+Lock usage and proof
+=======================
+
+(1) Hashed mutexes
+
+    Since hashed mutexes protect the list of kernfs_open_file instances
+    corresponding to a kernfs_node, ->open and ->release backends of
+    file_operations need to acquire hashed mutex corresponding to kernfs_node.
+    Also when a kernfs_node is removed, all of its kernfs_open_file instances
+    are drained after deactivating the node. This drain operation acquires
+    hashed mutex to traverse list of kernfs_open_file instances.
+    So addition (via ->open), deletion (via ->release) and traversal
+    (during kernfs_drain) of kernfs_open_file list occurs in a synchronous
+    manner.
+
+(2) Hashed rwsems
+
+	3.1. A node's rwsem protects its state and needs to be acquired to:
+		3.1.a. Remove the node
+		3.1.b. Move the node
+		3.1.c. Travers or modify a node's children RB tree (for
+		       directories), i.e to add/remove files/subdirectories
+		       within/from a directory.
+		3.1.d. Modify or access node's inode attributes
+
+	3.2. Hashed rwsems are used in following operations:
+
+		3.2.a. Addition of a new node
+
+		While adding a new kernfs_node under a kernfs directory
+		kernfs_add_one acquires directory node's rwsem for
+		writing. Clause 3.1.a ensures that directory exists
+		throughout the operation. Clause 3.1.c ensures proper
+		updation of children rb tree (i.e ->dir.children).
+		Clause 3.1.d ensures correct modification of inode
+		attribute to reflect timestamp of this operation.
+		If the directory gets removed while waiting for semaphore,
+		the subsequent checks in kernfs_add_one will fail resulting
+		in early bail out from kernfs_add_one.
+
+		3.2.b. Removal of a node
+
+		Removal of a node involves recursive removal of all of its
+		descendants as well. per-fs mutex (i.e kernfs_rm_mutex) avoids
+		concurrent node removals even if the nodes are different.
+
+		At first node's rwsem is acquired. Clause 3.1.c avoids parallel
+		modification of descendant tree and while holding this rwsem
+		each of the descendants are deactivated.
+
+		Once a descendant has been deactivated and drained, its parent's
+		rwsem is taken. Clause 3.1.c ensures proper unlinking of this
+		descendant from its siblings. Clause 3.1.d ensures that parent's
+		inode attributes are correctly updated to record time stamp of
+		removal.
+
+		3.2.c. Movement of a node
+
+		Moving or renaming a node (kernfs_rename_ns) acquires rwsem for
+		node and its old and new parents. Clauses 3.1.b and 3.1.c avoid
+		concurrent move operations for the same node.
+		Also if old parent of a node changes while waiting for rwsem,
+		the acquisition of rwsem for 3 involved nodes is attempted
+		again. It is always ensured that as far as old parent is
+		concerned, rwsem corresponding to current parent is acquired.
+
+		3.2.d. Reading a directory
+
+		For diectory reading kernfs_fop_readdir acquires directory
+		node's rwsem for reading. Clause 3.1.c ensures a consistent view
+		of children RB tree.
+		As far as directroy being read is concerned, if it gets removed
+		while waiting for semaphore, the for loop that iterates through
+		children will be ineffective. So for this operation acquiring
+		directory node's rwsem for reading is enough.
+
+		3.2.e. Dentry revalidation
+
+		A dentry revalidation (kernfs_dop_revalidate) can happen for a
+		negative or for a normal dentry.
+		For negative dentries we just need to check parent change, so in
+		this case acquiring parent kernfs_node's rwsem for reading is
+		enough.
+		For a normal dentry acquiring node's rwsem for reading is enough
+		(Clause 3.1.a and 3.1.b).
+		If node gets removed while waiting for the lock subsequent checks
+		in kernfs_dop_revalidate will fail and kernfs_dop_revalidate will
+		exit early.
+
+		3.2.f. kernfs_node lookup
+
+		While searching for a node under a given parent
+		(kernfs_find_and_get_ns, kernfs_walk_and_get_ns) rwsem of parent
+		node is acquired for reading. Clause 3.1.c ensures a consistent
+		view of parent's children RB tree. To avoid parallel removal of
+		found node before it gets pinned, these operation make use of
+		per-fs mutex (kernfs_rm_mutex) as explained earlier.
+		This per-fs mutex is also taken during kernfs_node removal
+		(__kernfs_remove).
+
+		If the node being searched gets removed while waiting for the
+		mutex or rwsem, the subsequent kernfs_find_ns or kernfs_walk_ns
+		will fail.
+
+		3.2.g. kenfs_node's inode lookup
+
+		Looking up for inode instances via kernfs_iop_lookup involves
+		node lookup. So locks acquired are same as ones required in 3.2.f.
+		Also once node lookup is complete parent's rwsem is released and
+		rwsem of found node is acquired to get corresponding inode.
+		Since we are operating under per-fs kernfs_rm_mutex the found node
+		will not disappear in the middle.
+
+		3.2.h. Updating or reading inode attribute
+
+		Interfaces that change inode attributes(i.e kernfs_setattr and
+		kernfs_iop_setattr) acquire node's rwsem for writing.
+		If the kernfs_node gets removed while waiting for the semaphore
+		the subsequent __kernfs_setattr will fail.
+		From 3.2.a and 3.2.b we know that updates due to addition or
+		removal of nodes will not happen in parallel.
+		So just locking the kernfs_node in these cases is enough to
+		guarantee correct modification of inode attributes.
+		Similarly the interfaces that read inode attributes
+		(i.e kernfs_iop_getattr, kernfs_iop_permission) just need to
+		acquire involved node's rwsem for reading.
+
+		3.2.i. kernfs file event generation
+
+		kernfs_notify pins involved node before scheduling
+		kernfs_notify_work and kernfs_notify_workfn acquires node's
+		rwsem. Clauses in 3.1 ensure a consistent view of node state
+		throughout execution of work handler.
+
+		3.2.j. mount
+
+		kernfs_fill_super, invoked during mount operation, acquires root
+		node's rwsem. During mount process there can't be other execution
+		contexts trying to move or delete the node so just locking the
+		involved node(i.e the root node) is enough.
+
+		3.2.k. while activating a node
+
+		For a node that started as deactivated, kernfs_activate
+		activates the node. In this case acquiring node's rwsem is
+		enough. Since the node is not active yet any parallel removal
+		that wins the race for rwsem will skip this node and its
+		descendents. Also user space can't see a deactivated node so we
+		don't have any parallel access emanating from their as well.
+
+	3.3  For operations that involve locking multiple nodes at the same time
+	     locks are acquired in order of their addresses.
-- 
2.30.2

