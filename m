Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387F58EAF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiHJLLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiHJLKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF8491E5;
        Wed, 10 Aug 2022 04:10:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8i0tH018850;
        Wed, 10 Aug 2022 11:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zKis7ue4ZsFG7GTZK4ig7mmUTRzeClTrSiOgusnW8bI=;
 b=Ook+amNdFJZnhhAC4pLk4SSfjGpBCB7N+YMAUy/v+2whLQQhvp8CkYjhEOK5fil99oXe
 sRRoOVkFE4BDc11v9IOphHZbW5CqyLr0El9JNJnvR1GcfaWcG/Mt0Msmq0BFOM8cqwbw
 kmNp7BV3GNWzmTH/MSOOhjtcVJYS0wbQa3f0xdsdxk2mciuZeJfcNKSUVxQgr6rJdtbX
 xdmTE2FyoBgKTVDUFYt92ACnpIb1wW/hXaas64NDLpmLioIg9RqLGyXCNwrOaIuaML17
 W5DSrO45+xGVyr+DHcwGxV1KQNGJSxDU5g9UvRYMDIXfAn+W19Tze3YZBUiMm0Moj4+M jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj1gxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9LfgR037406;
        Wed, 10 Aug 2022 11:10:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj1w9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH86GMCb9PRPXARPHuK36PGAzl1bo2/zMUbZ9/Xwi++vRR8oztMsNIXpjTvhzuPEssSQrlq6whBiE5ai+0N7J/J1O1u44tW8I2wDdfh7M8pLlDj3n8OpVrLB3IrPl2YHyKRe5xzBCvUs4wvBk7qFnCl8sFNPJF+cf6JAu3NIj89dIgOPB43eusXP1q8zhp0o7e8+mwepdVkNj9zhczMb4yXSoKnWcdmfXrbetHtlhCkRFH+1ww7yWoBkfnrOJDbNnQQMyuoOhOwu9lSzFM32nCqO5rtUtR4ByV40C42o7zIVxi7y3DBTEk33JGHwu17OyNWFBasNGoBnzbskORwpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKis7ue4ZsFG7GTZK4ig7mmUTRzeClTrSiOgusnW8bI=;
 b=Ng+4iO4b8secSm7jpEjSCSbGmDOwLXs0Hwt5VdlwmLAD00lIIkiY8KIncCZi7IeY792fQ1a4jLkcas74d/CjYbJF/904uWY98/2zjW2NmduxFZlEvBz+gYyJz98g/EwWx+YaH0gtqH9/ZIogcrxOK9Jgzm6ls1hYgkZ5SJmZ10i0gM8PzwP+ovsTdfYC/ayyeK8BtdGaHOKQdagoI5gW1fFbPygv/DM4Y/zxnbydTVIWi5hpsVueOTIhzGTW7Wdg2vuuw+iHwkpG2eEh0bnQUXhFAiht5fq2hpes1JfRauZ05X7zguIrWylrsPQrfIxols5tQVt9MGux4s8K4K4l9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKis7ue4ZsFG7GTZK4ig7mmUTRzeClTrSiOgusnW8bI=;
 b=z4o6yX/T+fePl2ILWCG3bROcKIXC2KD7e5UVj/6rM0UiEijPcHWqqytv/iCiVXROZJBlpzs23o426GZok1TsMzmt8o/GCMU47fIe9bn61VVDXlQEBI9/dFUQF3KhnZYx8CAKFBhtKPQtfwxzW3e7z9DxpKAwNissd+e9VP0I150=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 11:10:31 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:10:31 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH 1/5] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
Date:   Wed, 10 Aug 2022 21:10:13 +1000
Message-Id: <20220810111017.2267160-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810111017.2267160-1-imran.f.khan@oracle.com>
References: <20220810111017.2267160-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 327a1a9d-3915-4571-45d8-08da7ac0f03d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLsRfYZu4wnWz2y414zM81IXYjTbRX/XMejRKGj9w+1tCDLqnOTpBvIGu88j0ZpAcfBwudpJkQiErDhyi0nPZfYFV1nset4RHdMWWkrz99OwQjkHsbL9UAbJi0WeTtft0mBxluwXiKFuKiVJd9rqMw13zDTKlgTTJqAjV+bNEyucZUMxlVY3Z7WIHmabvdM4pHWNImYAtH1+gH7A+UngmdsABTQbruI6bAR20ZJUB0gvwkzwhoDHOc2ih1q3XnszgV90fc5q9Xqy3pssT7h4uO5ZDWvBqppxKU6Hs/T4bur6vhVDwkPHMUaRkTvua/QDqW4bk5obo1WKZ6XpVNDCKzxP+k8EsATQcZYG//6X2Ei2DciGUNEiUZCpEVR/sUNuNtkgZHAvHYk0rqUt4VhoF+++b7NVAIW7qXw+RJk3nJ1d68l+jGQRyEawVKvUw8R+t6HHb0mRtksw51pnWyp4hraglyYqT4oiw7eKjLEyKMv0KmQzUAE2XZk1A+F0a0btoI8iwrGFK0y7nmOgFjBjnJ9R6m0LAkVpNbkNW0NB7zb7PLcco1T4OFh1z9Bm7MEqR5uEF+L9mPJ/Bp5Z9+bL0A8DSkbKzJflQOOMnGodUqa8mr7cOCKSn+x1ot+rZya10yE0lDsiJvkuS1Ma6MsRlDphBtlnK6ZFeMwP6Hkz459LckShSHFxcPRLb578z/za00fCR5AZE5jR0Ka8JEgSuvqvZPfXULWKytx43LI89KkcfgqDgiSteGX3C9vRimE9okZVkMPHgj5AkfCYOoJtsVovYT0onXY6imAKOQknoPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(8936002)(66556008)(4326008)(186003)(66476007)(36756003)(1076003)(103116003)(316002)(5660300002)(8676002)(6486002)(86362001)(66946007)(478600001)(2616005)(41300700001)(83380400001)(6512007)(26005)(6666004)(2906002)(6506007)(38350700002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9BcnBl5EXDjne9eKIK3w5DHsDTVkI+gZWv8+w7wcwQFNidsfHxcdpxUTZnO?=
 =?us-ascii?Q?lW2ky/4h9c3QGBYR4bsyH0HQS38U2wOijBi4TX8Q6jK9RaHh6XbqzoQp+QgP?=
 =?us-ascii?Q?lJcPkWTCNOU6M0bx+Z/GjJzJ6TZpNBccXyP4uKlerIWimXgMIZcdphCZd9tq?=
 =?us-ascii?Q?pNhlVzBiKYw6BwnhVUk+M9GacBl0QUjudAgpFsb9BlI9/S4MaLXfNPFRz8ZO?=
 =?us-ascii?Q?WUtWY0jR43iiQPkb55L7SFn4kjOr685XPk8it/9BvcEUQUdKq1hkf4jZJfP0?=
 =?us-ascii?Q?DZWcNdTadtqy/a/uMoBzBFZijy1RHicczVk8zlIebYvAA3P7DTok5Lbx0VRU?=
 =?us-ascii?Q?EieA1b9gtet2JvccKU823PmXk4JMPKITh8eWigy8AgQWy77Hc9sj/+vaEfc6?=
 =?us-ascii?Q?E18F0V06IozZPfD7wsP+LSIPDbX2ncZXcj9GqGu9lYvxyRocfQFA3BcxFjQm?=
 =?us-ascii?Q?v/iTjfyonG4A3vYEFCDkn2+2uL+Z6JLj/rQuP8A5RU5rlrQLqtXfAthBLs6V?=
 =?us-ascii?Q?bbq29Y5lxl+zfP39HHunN6wFinnV8IJMyWITRaEgGAUP0sY0y5g/nC+54PJb?=
 =?us-ascii?Q?LXuRFxXa6WtdANyKN//g5zy4WM3IdkOTNcjFwAIFPS2Zp6i8+Ds1HImKtH6Y?=
 =?us-ascii?Q?k4GVE0TY7XMlhHPMto/IPjLvdVUtnPNowkqhOiH2hLuvjo24C80dEqfDgY/t?=
 =?us-ascii?Q?3c38xaB8gvs4sqvm1IUbsUtUUy+KUCtOEkv2Q4SC3MI0c8WMNczZBjuXMyOZ?=
 =?us-ascii?Q?Dhaz4JQfat54EYK5nziWYZewEslaSN2+F2AqzVbyrF7RuDM0FRsx1rP6ACcN?=
 =?us-ascii?Q?Ye9xBCx0B8ayIwBDbi/94179P8dj1nKE63Sd71TeGI7gabAfH5ku+ZGQrxMr?=
 =?us-ascii?Q?//T9Pz5seunXi1SJs55JnE27OmWOQl4ABv6RelalSX8JTy8VQjlhmSKuTqym?=
 =?us-ascii?Q?ie+lGNVBjsga6cilyi1OiI8hN2o5bJuZnT3EzNxbp7CQwthkmFaiWbr3xT/H?=
 =?us-ascii?Q?wNZB8eY6IygptGc7OmvOm4n2Vf273cCadcl37ukytr2oXZaxQ1hLytFhJzAl?=
 =?us-ascii?Q?WKgyyvqxbzevEa5pdtpP+Ns4/qpny5AWmNuSK3WXxdLHwxASi45hCilxE1GI?=
 =?us-ascii?Q?KdeYhn006hOLJYBBAgiJezYJl1Qm4NTW7xtgVc8B8+elfJJ4hTsVK4UR9X47?=
 =?us-ascii?Q?OzxO2Jgc6+xYW9OKIk3XN3Q+aeU7t4x/XG7BMXsWEVKyCNu/ugSf+IQPuvpb?=
 =?us-ascii?Q?CEmyV/vmxqJ6EDyRHoaV/BbO3DPQ4nKv2L0ZttS8Um/KCkO6T3hpdqDPNR8R?=
 =?us-ascii?Q?gV9Ad3kctf8Te1k33fmjsc2cjJFvD60LCmPfDNjx1kAaLkCZc7nZF3VTf4yL?=
 =?us-ascii?Q?+HeXz9LqR0SoA/z+tUzTzqIhuKPDfZ1NGDfkQP867oWXWSqx1iBG4CoYnoNm?=
 =?us-ascii?Q?NTPuQmftRc2mdVSNXSSO4aDNhBV6FAIRWHjtoTQRrBZ+hCFX1ImtJvt7Rsjj?=
 =?us-ascii?Q?4yePY4DTP6Nro6xY7toOOGk9j1euZBVjONj3aeBOY0TtbkaNr4O6nV7gKnrG?=
 =?us-ascii?Q?QRT7SFE19U1gBJ0CGjB1UzvkLYeJn8xtJv2kDHLHxPpNTJsp6B3LMD4X+0tH?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327a1a9d-3915-4571-45d8-08da7ac0f03d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:10:31.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oI9uk0bGRQ74ETpeSHdsvdbnUWmbFzKwMPTH3jyHgAkyIcUI5S0dewLU2qhYPGvqAXDQiMt4b432OSfl4LR31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100034
X-Proofpoint-ORIG-GUID: w5B6FBsvseLeYQcVW_U0ANWaK631u4oV
X-Proofpoint-GUID: w5B6FBsvseLeYQcVW_U0ANWaK631u4oV
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
index 1cc88ba6de90..45e1882bd51f 100644
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
index b3ec34386b43..812165d8ab4f 100644
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
index 3ae214d02d44..3cd17c100d10 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,6 +47,7 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
+	struct rw_semaphore     supers_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d0859f72d2d6..d2be1c304715 100644
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

