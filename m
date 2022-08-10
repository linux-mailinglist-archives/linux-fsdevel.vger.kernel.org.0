Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17158EAF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiHJLK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiHJLKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27A3122A;
        Wed, 10 Aug 2022 04:10:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hs4B031943;
        Wed, 10 Aug 2022 11:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HenYNfEQ+SNT9MEjUix7QAkWAlWEVWHc8NRXGzeH3DM=;
 b=QDlAJo/z16tAfSzcjZ46wKYsQphvS9CunlCpipk7yrnMcrMbf9+XNkB2RPF9WK+Dywuh
 aNMI7JK2GCKIqOn9BhF62C8UNHjGNDhy6TcDlXqyqWkbzEAXsNmIE/J4bAh4VvgLpwJB
 2iqyvxM9v8/DgDnoXHBhF0ednK227tnaNzSBMPJ4wd/G8elsz05iKPQL1RLMDhozEcwP
 iVkT87Ww1EOwN8CrZ/p665UJw3Ni/8qsKGwtv+FqGLKz1Zx8lUM1vVhlVZAJC0oR+LeV
 Ii5eaTTm+xI9PGDGf1t2q7UumRoFM37+VX+wyfE1Qgm2IL0uBbZFK6gbBpc+HyT6SAeX Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdsj4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9LfAn037505;
        Wed, 10 Aug 2022 11:10:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj1wbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hatv9+KHO0U8g3NWTQwjcIlWgGGWPx7Tm207pduQpLbt93i6nbwLCZKcoG/R3cnDOEvd5VCwlMCJBM4IAk8a95lksx6UUkUUCh9IUN7MgV+tcXhoEBtcLTvO72j0iI0OkgZnty6rtBi7NZyd35E2uG5D+hpyeZGqsAv0PKr8Bbvs6Ub3UMrVPGwqphPTPXyQqMaXpJgnXyIGWvE+mWjOPS8/HtGhb89L/AVjVjaJocr9ruK4S0cTWtyI9Vbnn5PQefKXHdvKNKZQ/cF0MAtBoSdA1Hj3/ctTHO0UWrnsmmH7o2pBSbIf9KpFqqcET11Wup1GlUIxDyyrDMZypJ8w2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HenYNfEQ+SNT9MEjUix7QAkWAlWEVWHc8NRXGzeH3DM=;
 b=RgxMPDacdhATR2bOUQ7YSj2DCOILVnN/iWSQ8tA6LS/SgaFiheuU7+lmPJ86as1W+4x4d4QKqd5ELBJabeg9Px+/jbsCh9yyTjdKt64TjIU4NxBhbvRrM0YnYsOYYKwHvpZIptLWs1moTf9iy7ZGx8Cv60zUmAYmftZJxRVjPo/kDObYIBuKM+wxvyXdzNuDlU1CgLyBnp5e1okwOri1kU+t/hcSfkzAwcyKdtsUT+0UKS06jRIHleGsYadQY9E//cajLXcG4NMky5UxdyqZ9fv43eiXfm5cYfr9SeCmhL6yxkDpqP+unxi26ofSV71ds+bSlf8RRSb6vpjr019U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HenYNfEQ+SNT9MEjUix7QAkWAlWEVWHc8NRXGzeH3DM=;
 b=MQBtWiv8GzQtjCy+4iR/rg7Rx+FHiF3NvrhGByD34oFG29AnuV5Z3mcLmvNWCfY50pxZPCe0vcvJZbm/vOAPmtLeLCjG9Gn5kchThBECVit1Lw7ufC8k2vUvy6Pl5AS2nmZsH3yrmNpmrKaVdEms7UOr6TQXAjO3WY6VzXAfBz8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 11:10:34 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:10:34 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH 3/5] kernfs: Introduce interface to access per-fs rwsem.
Date:   Wed, 10 Aug 2022 21:10:15 +1000
Message-Id: <20220810111017.2267160-4-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8c05e13-ac6a-47a0-0bab-08da7ac0f270
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCUM2p3eqx1P48GKKt0hGRGSEh6H7ATwXpMLIqHCFv2Hdu88osopo/c2dPLufdCarJGlKRotG+qOPx1kOfe/3r+Pk9ZkbE3LNTZNjW1tYI6Cnv76Vi6Jx7jsABhOxbOS2GZ216WiiplT8G+v19zPOkhj5Tf58lxgdYBHWUJm5OlGaX9j5E8hKTYSAxoQxJoRowFidXS/jOgE4j+qO2RMWw8XMKZWAVkHv4becN7gatQFudusjIdCQ8S1AR5oN3qZUu+KuSOnge0/+ZFzI1SzfBVtgr230tu/6xH0ewrBQiFRcrFAnGEACvPXLiRs9OrFCaZ/hIKUe2rJ/CI8yPic6qOS0g9DRbT+0jopINBZBA9knLckUkkb+b1JIpPB7ojPlee0T7TqVTIAcbVngzYxqA/RrTBfCVyFq4lqud3om6nfY2f+3laiCKJkNXKGs/5ySP23DbQBPvto7eSotYLYwT5QexptCB2h7XMM4W8ZgDJOsC7vGCW0PdPRgxXN3HwkvUEcbRH3vQj5p7z6idXk6oimRJWAlTUy3qG5vG/beoK18ZjXI5MsULQ2QnqR72kBHuD3by/Tmj6L2rFI+nL5rDQp0V11eOndDNkj2ph1/JT6M/rdizKDKt14VjsCkpmGKEijLT+GrDwBTETAAnH4X/tGx6SQcNX2+pR+XUsu0CdP/nOUUtyFuAefqbiZUgZL5xS4cOmarSR4jt2lsty2Be6m24CiHG+A2zfTu+D5mJtPcjkaLGBDXF18/RDVQABQGYrTA1knhkpqZur4sHuFyCzzNlDQdBKLti4aP3H4xMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(8936002)(66556008)(4326008)(186003)(66476007)(36756003)(1076003)(103116003)(316002)(5660300002)(8676002)(6486002)(86362001)(66946007)(478600001)(30864003)(2616005)(41300700001)(83380400001)(6512007)(26005)(6666004)(2906002)(6506007)(38350700002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xyJLxnlP41JCun7DHYRxSnd1ZW2OR0xV3edcvvYq3D3/Ig8ZHqVG7OucDCu?=
 =?us-ascii?Q?vY4neqJD7cUKWtbn/CD0nvKUMMiAPtFD5zT0E7Mc0V67zcIBfp3EPq3zE168?=
 =?us-ascii?Q?uxfcbWFCV347LLtcFnBwofCBC0a0Ro95UKSb3dG9OP2Yae/0SQrZ68fAYB3q?=
 =?us-ascii?Q?9jEVVxH+XEbHKszct76yNJoX2tbWas+KBy6MM7CdqpXy7kBClmVO1yZb/rmm?=
 =?us-ascii?Q?SfgaI6SOACwWwtK2/yk0YjuotBJcZpo2ta/HjPZqvQSKtRHT2cVYZZgT+YtH?=
 =?us-ascii?Q?7JsmD73Ex+K5fb6w8U/hcHZM8QX3sU06u7INYpXg3OG0zUMZlex3jTT07ftv?=
 =?us-ascii?Q?N0kwxwaStRnFydSKdP/NHsrsv2pUpmq+yeQw2Xy+9TkIytcre1IQS2ZHAkep?=
 =?us-ascii?Q?MD4DPTjJPXCZ2tGosEfXXS/osOX6Rxi2WmFfcWhOtFoRNVXq477X8onoeJ30?=
 =?us-ascii?Q?QaxNtLPS7QL2VIgCyvz083kDSwYWsE0vEInP7Y/OlQ4spMDI0rEueoVPHGW9?=
 =?us-ascii?Q?f6EyQGwdywfNaCeVK1VVK3psBekDgKNGJBrvriDvGjF7xlHF7Q5VvdcX9WcI?=
 =?us-ascii?Q?a1PYr7zdbYCnjd5xBeZF9IbSSxnQ8HB8IASRO2xA/I3tXmLXFno2P3uQrRWB?=
 =?us-ascii?Q?3K7xoMu7p8U7p8qdm8ABJXDd3vz8dtFySfjTqv8htxpOs8rnmcFr9hU5i0QD?=
 =?us-ascii?Q?5PARHU0mqWBJ9U3re40TMKrJuFb9CU3bbSUKQIi6BfS2Kx0ENuhZLoFz5sne?=
 =?us-ascii?Q?+P9zmUl3ZheSyMxvxbjOLZsNpZeoUASKzRPiwRiyxzUyhRsk0UODI6+S9fM7?=
 =?us-ascii?Q?X2KktqDME2FcgYtmHLPaLPS/NZCEsMvDu3pkr+Mbw5Z2RT8XCuxWRjEGmyRF?=
 =?us-ascii?Q?bCiSkcukGLI9wIBHxFn+Y60f+k0cDZSTkWFZf1YXx92qLz6d9T5OyTyYt9d7?=
 =?us-ascii?Q?Zn3Tamolzl2+0gI86oAP73RYvCTuQACNk18OEGWtgfcV5x1M8ncDHKP11bz1?=
 =?us-ascii?Q?jm+09BTj4Muxg/ti7lhmqCuC9fR0z7dMjC+r5F+U1N07rbqkBwsFa1g4pCyz?=
 =?us-ascii?Q?lpujqZh404YYPGQM8ffyROAcODiQpNf9vIn/w2z0Im3chclVHDfcEVCvyyzX?=
 =?us-ascii?Q?RqenPF3TFA0wzaF685mONbmSYNq+wj4RtyCl+A5H0WGlAic96Hu9JCL5YgxH?=
 =?us-ascii?Q?hNNuAdlxgb/60LqOagbthpBY5qdaG28NlmonCB/z8MEpNYId8O/7CBLiJNlz?=
 =?us-ascii?Q?gch5TFS3tkEVyTlT1YxPi9kcv78CI3V3KaYRx4Tgl8E6E9NQ0rB0Bx9QZ3yR?=
 =?us-ascii?Q?wS8ZWouMottiprB+NH/2YPhErbkBQ5/frUVJ/4MJER1njXtvVXV8DazkU1nI?=
 =?us-ascii?Q?fRE8LIDKhtOyJmcASYFiheFHaXUkKzUlB3GlDjWuqYLXKFGjxHY/I93yDh6y?=
 =?us-ascii?Q?ggN3+Ioop/vPDH6GTwOdOtgSP+5BoKic1xZ5fQznYx9QzyYzZEdrBS07TibP?=
 =?us-ascii?Q?UV3OFB4p75FjG5RGHEOvyyFkcZycvKTBRDNMJXfYE090AF4C1BBVhIB3jNRc?=
 =?us-ascii?Q?AJ7YIor1G3mb4auyZ6DSfxSuEUEqIvAuuWPdRmk7Lv63dxuJyfQyI9G0u6xC?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c05e13-ac6a-47a0-0bab-08da7ac0f270
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:10:34.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3/cE1zCLuCU1OupthzSZQps1whJBZNB3jocatp0P0T3Q5IAvmuKCS91KiYtDYTBFvx9KyiLu3Z9QYdJrxHl+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100034
X-Proofpoint-GUID: lYGSBdhF63kIvhQynnDrR8etESegyTXZ
X-Proofpoint-ORIG-GUID: lYGSBdhF63kIvhQynnDrR8etESegyTXZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

per-fs rwsem is used across kernfs for synchronization purposes.
Having an interface to access it not only avoids code duplication, it
can also help in changing the underlying locking mechanism without needing
to change the lock users. For example next patch modifies this interface
to make use of hashed rwsems in place of per-fs rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 119 ++++++++++++++++++------------------
 fs/kernfs/file.c            |   5 +-
 fs/kernfs/inode.c           |  26 ++++----
 fs/kernfs/kernfs-internal.h |  78 +++++++++++++++++++++++
 fs/kernfs/mount.c           |   6 +-
 fs/kernfs/symlink.c         |   6 +-
 6 files changed, 159 insertions(+), 81 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d2a0b4acd073..73f4ebc1464e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -33,7 +33,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -467,12 +467,20 @@ static void kernfs_drain(struct kernfs_node *kn)
 	__releases(&kernfs_root(kn)->kernfs_rwsem)
 	__acquires(&kernfs_root(kn)->kernfs_rwsem)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
+	/**
+	 * kn has the same root as its ancestor, so it can be used to get
+	 * per-fs rwsem.
+	 */
+	rwsem = kernfs_rwsem_ptr(kn);
+
+	kernfs_rwsem_assert_held_write(kn);
+
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -491,7 +499,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_down_write(kn);
 }
 
 /**
@@ -726,12 +734,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
+	struct rw_semaphore *rwsem;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -762,7 +770,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -776,7 +784,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -797,7 +805,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(parent);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -829,7 +837,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_read(parent);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
@@ -867,12 +875,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -892,12 +900,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -1062,7 +1070,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1078,13 +1086,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			rwsem = kernfs_down_read(parent);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				kernfs_up_read(rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1095,8 +1102,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1115,10 +1121,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 0;
 }
 
@@ -1132,12 +1138,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1148,7 +1153,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1163,7 +1168,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1286,7 +1291,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(root);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1321,9 +1326,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1337,7 +1342,7 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
@@ -1348,7 +1353,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	if (!kn)
 		return;
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(kn);
 
 	/*
 	 * This is for kernfs_remove_self() which plays with active ref
@@ -1417,16 +1422,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!kn)
 		return;
 
-	root = kernfs_root(kn);
-
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1512,9 +1515,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1542,9 +1545,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			kernfs_up_write(rwsem);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			rwsem = kernfs_down_write(kn);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1557,7 +1560,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -1574,7 +1577,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1582,14 +1585,14 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+
+	rwsem = kernfs_down_write(parent);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kn)
 		return 0;
@@ -1608,16 +1611,15 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1671,7 +1673,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -1742,14 +1744,13 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1766,12 +1767,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		kernfs_up_read(rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		rwsem = kernfs_down_read(parent);
 	}
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 812165d8ab4f..669619e01be2 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -911,6 +911,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -925,7 +926,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
@@ -965,7 +966,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5da..efe5ae98abf4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -112,14 +112,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +131,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -187,14 +186,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return 0;
 }
@@ -277,22 +276,21 @@ void kernfs_evict_inode(struct inode *inode)
 int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3cd17c100d10..0babc3dc4f4a 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -169,4 +169,82 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+
+static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	return &root->kernfs_rwsem;
+}
+
+static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
+{
+	lockdep_assert_held(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(kernfs_rwsem_ptr(kn));
+}
+
+/**
+ * kernfs_down_write() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_write(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_write(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_write - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_write(struct rw_semaphore *rwsem)
+{
+	up_write(rwsem);
+}
+
+/**
+ * kernfs_down_read() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_read(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_read(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_read - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_read(struct rw_semaphore *rwsem)
+{
+	up_read(rwsem);
+}
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d2be1c304715..3c5334b74f36 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -237,9 +237,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
+	struct rw_semaphore *rwsem;
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
@@ -257,9 +257,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	rwsem = kernfs_down_read(info->root->kn);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f..9d4103602554 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return error;
 }
-- 
2.30.2

