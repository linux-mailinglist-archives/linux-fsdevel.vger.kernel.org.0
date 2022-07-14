Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113F8574076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGNAWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGNAWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0D15FF8;
        Wed, 13 Jul 2022 17:22:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNQHpj006654;
        Thu, 14 Jul 2022 00:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wtPv/41bUIsMzjDg6c9NQmzcUAxI1Qg9wBfkypVrCOY=;
 b=NphYbOYV//2yIWYNt3CdY7y1kYPyh2u21LkW1N/Etkqz8EA6IMa7cfXZvOi2tX3Qgqr0
 JIxfei7xltu2f+z3BK7QLl/sqYgWUw2aDm7/hA3mODZYAU4D2S0d7KMNGSTqMtLEpkC3
 ckYJFwzHEAb7Y50x3w4TY8AWdzh1C19jZzHVmuMFQc2yV4zkBvVnau36iEPzD8UeBuCf
 K0F3W11nuuqAlSgBPLT470xk0Ajkwmsc391tCL3OOA5lfTqEMS+be+zt/f/unFFkNcsM
 vw884vQ8annHDF7qFtp98xtmyfvoShQf+AWrObiFbNBOZFvM1BsBdTlq9UfwMan7ZcdD HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sm35v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E0FcD7023320;
        Thu, 14 Jul 2022 00:22:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045pes3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPO7MR3YrhM9fxnFdJd7Ru6JP1nhCdFy7BqO4Hbz8J4E7rcUcqGJmbJwDY+nwb4EozJ4nLZ/dEcalf3XkWJteDhPsRXf/Dqpjy1KJuM0835OIj8DTLadcaiJwGgKPGfghw+sfGk70HF3lNzDxE2UYBgDvVcOA22zWyUbgaEaib9uSFEpkbVaDpTMsZAzwQGZDftikmeWBeWmlBBZ2+lMRSVOD3KJz135iCAngTKwdXZ2t4B8KzQiTXy2qVbU5IRFnRi5t8lBsOT4tiY6aNvMoivHVx+EIHubJ1mw5eTHCQfcPuKlSRKSVfM9M0wyRUTBtcakfnwCiXKjDAHLsvX+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtPv/41bUIsMzjDg6c9NQmzcUAxI1Qg9wBfkypVrCOY=;
 b=iSDSBp4FabAw4wC4p9W2+hAMtxbwRO40fqcUVj8K5HlYe2vM3LU5yJt+JFCMFUV4ieKLKD0jpZ09YltqVqErADzj+Cerrp9K3jGMwp174oIKWNDpVIp6KSMLM05V4mhWmoM1mNezWX8Ndns+opENE/sUnNo0basAhkbnYns0ZPg7u8vX+thIIYKm1GpY8n0DAu+/EiwYp+UjG84ut3HQC8YuKh2KFH9svPxKv2GQjYwwP4vJPlQAiCsb1uh+BbqjMihfQuM7FqJZD7QMQQNw49CvUoBVEd8q3TKAWCLbsMFRJ6ohaCum7PMcJrQ8KA+cWwjMQvdSP3HX6DI3gIqQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtPv/41bUIsMzjDg6c9NQmzcUAxI1Qg9wBfkypVrCOY=;
 b=bFqglzIfDBSPxpKjI3gmueW4EHCdlYhAJnak5TjeS/yrWA+/a2E51mDYxKupZMJW5olmuhGUDdh1t6k8Ch+wu2WzUn7uL37j3IPDQUnKY+2pSFmF1xuG90ow5J3fTGVZlumA/neHvu3khR5kK8QayfjHFKX9KsS95tVXo3k7puI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 00:22:38 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%7]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 00:22:38 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Thu, 14 Jul 2022 10:22:20 +1000
Message-Id: <20220714002224.3641629-2-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 488e2ba5-c316-4262-eef7-08da652ef4fe
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDOzEK7Vgewh+9L8N8HhZoKqG2yZoae7BEn0GEK+NToZE6/hriXgYITYoVW4WAlijXyG5AyVAU8t/YwbXybwuBXDzgIDbk66gFJ2L4p9J7dIE8CGqs9YgV/isC08pVoEqzq4QUi+QEo1c2fksAhI83cAymfLbWqKxJYydfIkxDvzioULYxgqqf1lmGn8LVhpjiHiCiIeKZbdl3/E5F4Pxsg+bHo/6Tl7WMTwcR5E4yeZmhD6n24+n7on0ojd5qa+/i13mnB9WLsL/EK2d5olED8o3K4TvTmobV445j4NlRtPHzzNxHoVhJz/OA4WF4qQwsQT70o7fhaViCgrIdwUJVJE8MkksutYnY2ZAYEbPVEiOK99x3nnyicSlaCGiIQ8DgQYhHQIol59VsGAYihQVE/U9xvdb1Xjbe7HRjktgq5j42lu53Z+1Hociuj8T3xkuNicqcYciBsW2EfMSbNyJrXJLOUdik3RlXdM4TfjwK+RTjmm08X3uCmkXNi2L6N2VgWM7ylLMvyVRywGllIqCB4kuENrL0y4CjQm1XFKwNazQfBaFFqnAcvrf6Y1NDzHXpfCHYGO1GFN/1O2HnfyKV3Jr0NVERk6ui6UPSxn6JoAv9YQvFurM9Hy2KvjLHfpeHodhjZlINTBGR6Z03Bc8MzGvIuySOnDOQh2O4vIXql213fJ5EgK/Di7MpzSTqC6X5WXiSe1C+xkPBsFqVj1llARtyvpBoU3b3blFJrckUZIbv8+qn6yEn79TWopRDfKypVwEFNJ3BJrS7Dc8VeCdMnpksGhrYUGjg7N8jZEyZ9fXZWQq1g1gFWwSjhzF/Wz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(396003)(376002)(26005)(478600001)(6666004)(52116002)(6506007)(6486002)(6512007)(66946007)(41300700001)(66476007)(8676002)(66556008)(86362001)(316002)(4326008)(83380400001)(38350700002)(1076003)(38100700002)(2616005)(186003)(36756003)(8936002)(5660300002)(103116003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isN7T9dq8hJtdco9GktbeWTPJChnYRLxIyfQGung5uQT0Z2QpG8WCFikCtdg?=
 =?us-ascii?Q?Uhw6ovMv3ziL+DUHsxgdu68OyXwhICx5rNF51CR3eLAHtvX5bJt72IYfW9kp?=
 =?us-ascii?Q?WEn83us3hF2rRQLXLquGtSF5U0kO27/gbF0sTUoauGxUWdymjrzg4+GFqFYG?=
 =?us-ascii?Q?Ex53nYa9h/B4GDD2lKpmDYk4CO9lwP9wU2RX2fVyj4qMk5PrMHRMsIoUAubI?=
 =?us-ascii?Q?IYz9kQwbST2KHSivdnMN8Cwb2AWdiR2QKSj85pr5NYQkAy/FxPTqd4BFCelD?=
 =?us-ascii?Q?4Vp68zMwDs+A8W/Wq/WrZ8q7snGotx8lf0BfeB4dmIHgjmNzhwNc3eYxVSLk?=
 =?us-ascii?Q?C5Fpt/ALFAc+8oTGF7fMlCv0wiylcpG7SYjfEfXJUQqW3ltDu1UJA0owqZBi?=
 =?us-ascii?Q?Tu9iLpUpiFZWeaJtZiDq0HnfimaNeEGvJVwV171/qfDeFRpCJBTChmzzmF65?=
 =?us-ascii?Q?jpSCu0shBZMgqtF2VKGQs6wk+HQijC+MSuzvAsCKKtzT+kdh2J1flzQLMZmk?=
 =?us-ascii?Q?GoNeB/j3yNlZcntJslsdl9b9GVraD2KYYEFUJYfvY+bW/0JoDK6szGg08Hcu?=
 =?us-ascii?Q?QmJJQAgRql1VzWLFh2rxlRu7qrxp7BQzRjY2Yhzv01dUJluuYhfMT3WYHKCw?=
 =?us-ascii?Q?snY4SpzummtJNJwHyo8xgoRKR1uXBtqIRUhGi0EfKHeJA8hfCnRxSXfJjNEF?=
 =?us-ascii?Q?WWF6VBfgEK+l7RCa7A5oRBwyuUAXjQ/MamVu+CwN7lwIrjuhPc1t+YlasKE/?=
 =?us-ascii?Q?2/v7ODItOlPyNSqBdmfAGu2uRjRZlhntTDCa7AzVVy8txzOilUzGLxHvOzCP?=
 =?us-ascii?Q?3pllla+W5kncXIuITrKXH2QoHP59FzwWz/8eEArlK+DuG9cfhPCPFFnA5M0P?=
 =?us-ascii?Q?MxKNO0PvHiWQaVjuWhWC18MosHYWKyg7HOPC16oKtSfB4lRcGtLe3XfoHl6R?=
 =?us-ascii?Q?gRwESSnga6GnKOB5ex/targKAS94cN9Fze2k5iaG/9DgKUzLET0pQ5I9wiPf?=
 =?us-ascii?Q?uKGHqB7Q/H25ocsUWdnzZv5WkYL7RRpiIfuYXnml5yyFu5Z4vLTvxTqhQxW5?=
 =?us-ascii?Q?082KNGCbajcHnBn42ZIVe+sLMZh1SbBEQCmBIe7YtzzJz3qlJuMvv4vx4P3c?=
 =?us-ascii?Q?a7wYmnpvk15eshZX+dj8TrTw1gmRpFn4hArDnjfV55vbrLhxTpZ6d8Itd16Z?=
 =?us-ascii?Q?FaBXyTB+Db3X0ybriR+gRuR3twxR0eNp+EeAWHG7z7rVhyCqg/lUFtAERNH/?=
 =?us-ascii?Q?cgReYrn+r6rqVlgPnoU4RSLZzWL3DWcRkIC7lPIbaTGFc6KrUTlr8BHXi/Oy?=
 =?us-ascii?Q?Ut2CIYYJ/Rr5Bl7HiztMHB5Lkq9w3nG1hs6tw4S2Ub1eXrOLpRyRJqOK00zg?=
 =?us-ascii?Q?KX+MlbwG5S9qn4yVMgosok8uuHM6lUvRx+n9ZjsWDK9fIjcb0w4MR4wbyNtr?=
 =?us-ascii?Q?ee+Ly4WLuZrkTyMYSgt4UKFbxUf/+sLD24pnbT78/g+AEvPRiQt9givP+VBa?=
 =?us-ascii?Q?j3dn3a9T9hfVhjvdkaeU52CEXP/sApsshOyq+SB0XghTa41U4WPC1ROwzpk8?=
 =?us-ascii?Q?S50SYjwpffaOOHqHLkF/GnK0txQO62XbefX3Av+v6unc1AflaPJ/3dxIcWVX?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488e2ba5-c316-4262-eef7-08da652ef4fe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 00:22:38.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLxelA0cFN4u0kcLv0wY8ivxKaPa86lIVQ0a/5z/YNe58tpLzNCfLynohplSar/2R3jVGb9KNkY0rkheN95pHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140000
X-Proofpoint-ORIG-GUID: 9lZeNpbxf_VgxmlarJpbgdx32stvyYPx
X-Proofpoint-GUID: 9lZeNpbxf_VgxmlarJpbgdx32stvyYPx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now per-fs kernfs_rwsem protects list of kernfs_super_info instances
for a kernfs_root. Since kernfs_rwsem is used to synchronize several other
operations across kernfs and since most of these operations don't impact
kernfs_super_info, we can use a separate per-fs rwsem to synchronize access
to list of kernfs_super_info.
This helps in reducing contention around kernfs_rwsem and also allows
operations that change/access list of kernfs_super_info to proceed without
contending for kernfs_rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 1 +
 fs/kernfs/file.c            | 2 ++
 fs/kernfs/kernfs-internal.h | 1 +
 fs/kernfs/mount.c           | 8 ++++----
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1cc88ba6de907..45e1882bd51fb 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -924,6 +924,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
+	init_rwsem(&root->supers_rwsem);
 
 	/*
 	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index baff4b1d40c76..77c3e34a6c7da 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -927,6 +927,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 	down_write(&root->kernfs_rwsem);
 
+	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
@@ -962,6 +963,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 		iput(inode);
 	}
+	up_write(&root->supers_rwsem);
 
 	up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3ae214d02d441..3cd17c100d10e 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,6 +47,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore     supers_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d0859f72d2d64..d2be1c3047157 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -347,9 +347,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&root->kernfs_rwsem);
+		down_write(&root->supers_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&root->kernfs_rwsem);
+		up_write(&root->supers_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -376,9 +376,9 @@ void kernfs_kill_sb(struct super_block *sb)
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_root *root = info->root;
 
-	down_write(&root->kernfs_rwsem);
+	down_write(&root->supers_rwsem);
 	list_del(&info->node);
-	up_write(&root->kernfs_rwsem);
+	up_write(&root->supers_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
-- 
2.30.2

