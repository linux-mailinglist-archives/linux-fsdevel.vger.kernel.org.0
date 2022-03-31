Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D14EE16F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiCaTLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiCaTLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:11:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19F58E4A;
        Thu, 31 Mar 2022 12:09:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VHkOWa007047;
        Thu, 31 Mar 2022 19:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=CWh6wty0T9Uj2qikxBKAGxX7C47IhSdI7DMHG4AQBDA=;
 b=Dbhbow2p3N92d+9MggYpBa3Yt23aS+5cfEPeaLvlYABICAEpE5F96YC0kKRTUbtht+7y
 3LFnNdaRfWXfFLSu346IFz65GJ+/ZB0MPinstEcBeJKUierm6SpnB0CrPepmXMpqx9Gs
 PWbUzrbGm1FzTGBiJ2276r+iERuA2VJWBryDWQviZYp0GBU7SnyBHpOcGSrmCIbpFDVJ
 fBKJw1X4T277hbXnYMe7tLRAe6qypw00lK2Hk5b5HqKZVhRxMyhvb1zo/ffaaZrs4PSf
 43otIW0ZuU0lcX7b9383NqDCw61SGrzf313M08nHYuZRVMBxpk007gYa+ZymDz6o8hpx Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes56mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:08:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VJ2Pa1024848;
        Thu, 31 Mar 2022 19:08:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s989x9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9WqkKIfNaD6HZU9hWQvXvbAkoYaw+z1df07S8S+Y0mWLdBXj0P2KlzPH0T4zLya0/Vj7Lqf6wzHF2oeguZpX5xo/Kn8nAXYRquRd9ZU1hfuTfE93MmAA8XGNVw/ehBktdwNfGn4KtVq7MS9tkQXbQWg+Xev4hQsl8qXcKZum2CV2C2fg6AftYmy3p/+90IPHWw4evinEAXeFAVq/XoBa7rRwSJmKeaAZEYmGxE6txJ7iogU/eaO+X6Y/OQZDv00Fq1zEzPnK79s5xCw62Isr799TsPrRrlvscpchN3DwKKy8UrceF3Lw03n656L1LllhzfAjN2WHBhGpj7HJ+AxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWh6wty0T9Uj2qikxBKAGxX7C47IhSdI7DMHG4AQBDA=;
 b=GyXuskLhDyNj2ZWm1rLAPzTgWJ5W0YtbB6TMDbhoPWhp6V6M/nAhqrumP3FoUJ/Za7XnAV2v5UBdcKB+8ciw2tYwdWLp/ATgea1auPjo2D4vnd78X8bTKxp5GAKt4PJ/BXPsL8vr2nPp2l5Ag67u7qiEZATgObuHlbbwBet8bVn/EnZwsKJRB6ZS/ekuEk3bUW/xY/cMQGAFaC44IWV9mq581C5e3j0jqTNMfDeXS4ED9YcD++w1Jv6+S3vk4Pm6sygRAR6X6+LeMttr9p1sGAdoBDgcjAdCK5NLCOHTYKi6b7X1/GIHrUSe+a30hi+BpsoBsEXXhxeOO+Eg9nHSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWh6wty0T9Uj2qikxBKAGxX7C47IhSdI7DMHG4AQBDA=;
 b=bVL6Ggqnq2Eu7ibUf0a1c+N/ZSXP86dJ7NvwT8A+RH75WBqpFXQWfLgqZUYf0FAzgA5vz1OnPegOD9uMrYbJwoIOSBfnkNevYooHHdk8SSocGxGF9/SBFEtdrAOGzhTYQ1XV8qFjLYbleR/yxTLA44OLXOXsvvMRWoXBxnNTs40=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN7PR10MB2529.namprd10.prod.outlook.com (2603:10b6:406:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 19:08:33 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 19:08:32 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Colin Walters <walters@verbum.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] fs/dcache: make cond_resched in __dentry_kill optional
Date:   Thu, 31 Mar 2022 12:08:26 -0700
Message-Id: <20220331190827.48241-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
References: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:5:337::12) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a997d9fe-ddd3-4d9d-dfd1-08da1349d957
X-MS-TrafficTypeDiagnostic: BN7PR10MB2529:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2529E0108C36D4F00314072ADBE19@BN7PR10MB2529.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXjxZ5z5fJRN8MGiiciLEPo/s0VyDEUaEWTzBoS4C8lJHHguwK9cva26efMByvxfeBqnQzuNkjbinIkjnISKRb3Sh/Ptr5KfnGsrTTtCblGCqf+F7hqPo3JKed6QKeYjUj5hCqhXVlvf2WS/rqcUcNupud13/HT98udauhSaF714VInZYebSVedoZec8GzLgPCy+QLW08Z8c/eixr24E2YUCb4jw/D79QLNFfctczjqyV/11oLyE84rXCbormM8hWMpXBoGdOkX6rFsmkQWlJbG7K6nifEVjDBM9hsgq7TyDN5gEw0MOYDiK101PM8jpE/nGTKFiPU6EFJYsGhnemdYC4AeRK3qLQaKJJhnaetdNgtJnvketpEaloA1pnYOobT9TQZTOGodtqZyzqCs43bU2IRZaIBKnZbCv1l31PEEVhDSP5unD1J8JxOsYkZflGvJ1406lXX04HcmLs74DFcZKPR3Jl5vHWGA6EfpPhueFKdHyT0wEvGDMWxhpeXeavi9gG+N43u36lRhi7OnK9iNtIJ5U4uEsGIR3ygFWwGPw7dnJo2IkCr6jjB1KKOs64+lFLhKH/OuEBxNBEWh/Gg8k5E8+Al+itOM/tNjUbHb3s7uj05kRn7qss6TFyNZM8p3n1Hvu17wJAWRcuD5+/+lqDxNDWq7qxmmu3yZsgco56Y6IyxAQvuBsoAEpqgqeg1SYIkoG/N3PVbTXJmYZ0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(2616005)(6486002)(2906002)(6666004)(26005)(86362001)(5660300002)(8936002)(508600001)(54906003)(6916009)(66556008)(38100700002)(186003)(4326008)(8676002)(66476007)(7416002)(52116002)(36756003)(6512007)(38350700002)(66946007)(6506007)(103116003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2EzjXiQlHgmoS6NBOmtNJdWhWzCVfJHYnTaDyQ9Zukb3rgLoGfiS8AIkLyhA?=
 =?us-ascii?Q?ZP+NKcWGXvvz7WH0V2FxUcKBXZcAVwimxiKtHhz7myY68wpEwc5AEfM7Gpel?=
 =?us-ascii?Q?Lwzf6pV0SwqayzX+D+0IBGPyipNEj5qa2mqvbvj9jIt8mjLhrHKn24ybYdah?=
 =?us-ascii?Q?U1JuLYOeY3D+A2HThK1mwcomp9CU+QOv/4tTbGxCShwxc2hZkegmol9on/Ge?=
 =?us-ascii?Q?lMmVkc8CGLBZM56mZTqJVTZkG10ZojeoCqf7LPsIIPIeL8xlCoHvOno88NF3?=
 =?us-ascii?Q?gNG01mYvBtoghX58wpOajz6SUPsePcleXspltAc7Vtda/1rb7X78FPKyogHa?=
 =?us-ascii?Q?+VSZjCUDchWrr4GwWHZOO7q+wDzNhvSMnmn1F4I2HDFV+oZ0tWLc7uggcs81?=
 =?us-ascii?Q?sCA4tGxapFcuuksQmlzO5RgV49GtOGqp39z2HXi9xsatXl2/cH1OauFR5kKP?=
 =?us-ascii?Q?RDRbrfUs4VuzppUmmyR7DgVsqz5A4aJzEgP1tsre8SqdT94YQqLngsDe4+pX?=
 =?us-ascii?Q?wvF+QXo/9xMqkyD9tN2j+EBa8g6QwJ50PT8eyXeUfHN6jtoXP5aI4bDkFfb3?=
 =?us-ascii?Q?OX11MAg3cDoM31EFeNjiXXj/Glg1MkEUth8YwF2COzsKX+GKtchxlZZtS8Gc?=
 =?us-ascii?Q?1yHnLgLnm4xBKT/MWMpC9Zd1X7csGul8AOKjTTWoEo4GQBo+i2FEft9jQa8l?=
 =?us-ascii?Q?4vHCGdyc7f1p7LammWwKpCL8c3CoAcCuCD/OSmJwS+Z4XnbMA/1Q8/xhWqOC?=
 =?us-ascii?Q?QHE8KskrxNw0PtT8Gv3TKpWddwtZYEptuxMj9QMRZN7aHUzcbm9DLuTbBuVa?=
 =?us-ascii?Q?13tBp0LnrKGsPzciz+dEJkYxiI35V3df/aYF2XptS1vfLXnsOYU7hVBPjK4O?=
 =?us-ascii?Q?O5hb5sHJC70QVWDi74W06Xu962kUq0/GQLEdH3WhWW4ImxG8hD+d8Z5SwIrh?=
 =?us-ascii?Q?h3fQNq0yBAvmZ67l//sKTYMpBAeM2+JYo2Z6NYv+nhQHruMIynQTE/uqRIjA?=
 =?us-ascii?Q?7E8kFzKMoPqqBkzmi893h0QZiEFE7teAvtHFKjgwn7featGT8fN01QfNEH0w?=
 =?us-ascii?Q?hKPvulZC+hJX/uTlgXT6Lv5wHqok1KmMXBIEGqik00oOz34Uts2np3TVXz72?=
 =?us-ascii?Q?gp7H45j1erUE80OH0848CFU8SrnwPuRLJ/KKw9cJK7b9htLOjLm/POvX6KKk?=
 =?us-ascii?Q?AY5LQaKbuhcwh75rBZh94gEstYkwxsMLqr3pFvqmOwbZZnOz9y35OipH64HD?=
 =?us-ascii?Q?HNet83gSpWr5wOi4lAwRLtj21NvFSc/v8HEGABYhPv9Tx1huoI6DeMGAHvB/?=
 =?us-ascii?Q?PT6wMw+Byyn6Cxq3CZkbIvsA3hSrjNL7pUUmMnkDh//kZ1syl4DocOMVuKwK?=
 =?us-ascii?Q?dY6STPwXxlAgMmlGlxThrvUcx+BZLSjpY2OW7Sx+ZV+JaQhZMjwPkrWd5XX2?=
 =?us-ascii?Q?IixpkB9SZobSiGBZvhTgMzLrCnrEiG2Ifhp1MZEHGB338z2qTL2LSooHb4R3?=
 =?us-ascii?Q?qm8q2ib6vps71JdEXuPEJmHoKFqRzsVbH/Z80Oi44DhffchUReBSSM7bYzSh?=
 =?us-ascii?Q?X9b/OBHpqImd22LAdM6fx2KcTFb/603WKmGrnyHQPJePcvHgZvQ3Iyl65j3d?=
 =?us-ascii?Q?3NkyzcGMtxaAxcw4DfxnWx3F6imqQ4v6syF29OgRecjt5BaToSwSnxrOeX0E?=
 =?us-ascii?Q?us4lkqbSbT7xmkuwYxP0pt5loFlpVQ12dvX9c9sDsEHkaWoB4Hk7C7BZQw2j?=
 =?us-ascii?Q?+PAW2p3fqyKZx2NzLVqBnhKmvgMyPYY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a997d9fe-ddd3-4d9d-dfd1-08da1349d957
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 19:08:32.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9bd6sMIoOcVEPEEe0xDRRB37FEvIGqZyOFQEJqR2PRUJfe+E43SMWrjF1GBrdddjJwviNBg6DLVLSpYmY9Jjp6N1kIgbfAKIAh3ILPoL6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2529
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310101
X-Proofpoint-GUID: 8tdz1qk_txRsRJC_kzKDbkC1IrReA91I
X-Proofpoint-ORIG-GUID: 8tdz1qk_txRsRJC_kzKDbkC1IrReA91I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some callers of __dentry_kill may be killing single dentries, where a
cond_resched is not strictly necessary (and may result in undesirable
sleeps). Add a check_resched flag so the caller may request that we
do not call cond_resched().

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/dcache.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..b1480433ddc5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -575,7 +575,7 @@ static inline void dentry_unlist(struct dentry *dentry, struct dentry *parent)
 	}
 }
 
-static void __dentry_kill(struct dentry *dentry)
+static void __dentry_kill(struct dentry *dentry, bool check_resched)
 {
 	struct dentry *parent = NULL;
 	bool can_free = true;
@@ -619,7 +619,8 @@ static void __dentry_kill(struct dentry *dentry)
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
-	cond_resched();
+	if (check_resched)
+		cond_resched();
 }
 
 static struct dentry *__lock_parent(struct dentry *dentry)
@@ -730,7 +731,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 			goto slow_positive;
 		}
 	}
-	__dentry_kill(dentry);
+	__dentry_kill(dentry, true);
 	return parent;
 
 slow_positive:
@@ -742,7 +743,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	if (unlikely(dentry->d_lockref.count != 1)) {
 		dentry->d_lockref.count--;
 	} else if (likely(!retain_dentry(dentry))) {
-		__dentry_kill(dentry);
+		__dentry_kill(dentry, true);
 		return parent;
 	}
 	/* we are keeping it, after all */
@@ -1109,7 +1110,7 @@ void d_prune_aliases(struct inode *inode)
 		if (!dentry->d_lockref.count) {
 			struct dentry *parent = lock_parent(dentry);
 			if (likely(!dentry->d_lockref.count)) {
-				__dentry_kill(dentry);
+				__dentry_kill(dentry, true);
 				dput(parent);
 				goto restart;
 			}
@@ -1198,7 +1199,7 @@ void shrink_dentry_list(struct list_head *list)
 		parent = dentry->d_parent;
 		if (parent != dentry)
 			__dput_to_list(parent, list);
-		__dentry_kill(dentry);
+		__dentry_kill(dentry, true);
 	}
 }
 
@@ -1645,7 +1646,7 @@ void shrink_dcache_parent(struct dentry *parent)
 				parent = data.victim->d_parent;
 				if (parent != data.victim)
 					__dput_to_list(parent, &data.dispose);
-				__dentry_kill(data.victim);
+				__dentry_kill(data.victim, true);
 			}
 		}
 		if (!list_empty(&data.dispose))
-- 
2.30.2

