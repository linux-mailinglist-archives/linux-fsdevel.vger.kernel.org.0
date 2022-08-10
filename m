Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2D58EAF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiHJLLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiHJLKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AAD55094;
        Wed, 10 Aug 2022 04:10:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hwiO013166;
        Wed, 10 Aug 2022 11:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hHg7sSi+XB0DPN8wQPEPOmCi3Orh8EvgcK/kzjIuAFU=;
 b=pL9mkFORVijjAQJXd6j8q/Uf9pvDaj20uCo2MrtEFrTecRtUJZsYaRDx1fFSwQSle43/
 eA5iR8VT9FTxpwExdTjP81cjqF8IL7hPMEqLo2/PqvebbQh3avtSaBCMuBh0a4BL9vSQ
 gLU+gMVKdniYpcBm8taf6PmX5wfo5hqPtiTkm3lA5XRp1nxFVIqjED3iKtEmxSENxZhc
 TlJF/Ksv5fMv3hM4/8WkiWJXOL2Otfm3J+8egA3Q9QcSKaCEJX3iVgLm69+Ne52d+QQY
 5vh3qRm3jbm5b2AfDnj9n532W1QRjG/5RDgCGPtlZ0iwEISyHlbWZxKVWIttf9QIEnOQ kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqghgrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9LeD6037384;
        Wed, 10 Aug 2022 11:10:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj1wam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHDuVJK1G1gYqXSRRa0yXcRz0WQhLyL/LOIj/ZYlJbS05qElkqbf5xw1RAqFZfX8zgJxXCWbwu+irygBFjB5v1rKBzkv1gUmgSVRJR++hlG8J+j3jObmi11y6pyV2J9LBb2IOOtCBv93YJpElEk6bcKh0J/yIOU9pYB/xsA2Q2eGtThsfv4Zd/pbXP6hdKs4PE2YlzjM/O5MrQPcHwP/FcNR1z2ukyzde7YoQKQHlt3mAdoHd2MGqnSvLGClT8Z+Hx1E6qw5mFLPV9EX2Z6xPLECPsXU+KxWZ0nEUVy+Kv49hzHHI4MHaDk7Qqad5q3noYYT5Qj29uynCHGZDDEY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHg7sSi+XB0DPN8wQPEPOmCi3Orh8EvgcK/kzjIuAFU=;
 b=PivhpxxmDDYnAOnWrHOYcGhc8vnROWB0CSnAuSAbLrux7lYyM+P7gbhegBuna72vbu6+1H9qaApRKLN05xA8RwsmGGt7xrPQ0+C3vJOOJKikx7YkB/TwbgpkrhrHR7QtMUhHEHc/NUiD8omUEMRqk92UW7BBAFjW4iQB4eS/X8lybZ2b8ou576P6tzd/4GTst8ts3lvTK9Lq3DhkgEY1rB9uDtG5ulrqnc4//TOlLfe/rdKnjBh/trhHq0J0394shZeEJy6q8Jgh54rE0jONmEN8v3epEzf2FRUDe1I7SkaWkznJvfGh09kVqx8FqI7dDO/aAUFPij2uki9v/5kOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHg7sSi+XB0DPN8wQPEPOmCi3Orh8EvgcK/kzjIuAFU=;
 b=YjBjG2xH9T3xg4tulQRdCWwbkNQ1gy0Ux47b89bl03YCdSNXnPnoadmRgNje6P7i8r4+kP+Iw3vlS2ZgW4Qgh3laqwAkmbQkN+SDK4WnCasUKc/NOchp2IWyrQbU70MV/8kSXb213OR2DAorYfI9IRkn6vqp3RO+zFTWhdybyms=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 11:10:33 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:10:33 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH 2/5] kernfs: Change kernfs_rename_lock into a read-write lock.
Date:   Wed, 10 Aug 2022 21:10:14 +1000
Message-Id: <20220810111017.2267160-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 755f95cc-c148-46bd-1f0b-08da7ac0f159
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGXEN35uleuH2RhdqjCYcR7CqTVSPFgJefQVmaEBQJCDMEKZF02wcNZyxobWoAk2/LwZlr75rgc4IBm9qcJ7V7kufYASd2P/sVIxB5A47vBIefzeSa6qWNcDjyT1P+mJBkL68RqlIlVQxZSoMhOloDqBL++ssIKiP3mBzgfzAr684HK0reBosAOdzY9dovrdA+tyDy7LAgBvKLs7Gg9/BVtlJN4T4MDA5TBtqPTQjOpcKDzMeQn8Lypr165GExmuwewMIaixVccNir5SiF24pYcNRWJ+w+DgYRkkf9SG3/zaJv7UL9nbn0LEhsyj/1CLxAh1aQjCrOFEmX1Qje1WnkZFEawGfZDVAf8FDrEJN6EvvEMEu0hlqSVPtFP9LkpsvyHw4Tjzj3DhQ4aUCFM3n1JhoBT7b18YKhakwKStgkzU820xAjJyQ6xCowpnJZIywiELmbwOd03gj6jdddG7Y3ursYyGk8Jhd669F7njYLBOzyd4K4cT3Tp91wV+hXT+o/ce2JtGOz8ApwUQGZVgErXL/y+u6DqhyWcaY6XYkwnCHuCdB6WnZk9G7mjS8k1ghOJTrt43BcF9wCHaY3cqMEaiVxpWl6v6SjNCXnLsGTGqxorTRahBZBvKpQnFdR4GEx6VqOL5plxYQl7CB4tpRoM6QJhzPIi/vjXycy6Gw2vRr7kXCruH54f0RZ+mfa8TX9GqZdyDg84Uh/3SxwbiaEm8n7P3u9m9EclbHpLlAvxYJ67Z25LZPTBVQcTS0ZOlHCrtXk+8hmcBRvdVWl5zXpTEYohMWuSm0ETX2ngS15o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(8936002)(66556008)(4326008)(186003)(66476007)(36756003)(1076003)(103116003)(316002)(5660300002)(8676002)(6486002)(86362001)(66946007)(478600001)(2616005)(41300700001)(83380400001)(6512007)(26005)(6666004)(2906002)(6506007)(38350700002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lub3F2YIV0EKGBsQ5TjdXHZQL0fC+7aMem+K7vEE7UkdjO6oeILXM6Oq3bnf?=
 =?us-ascii?Q?iU1g05qAL6UWe6e/zBbdvN+RBpRXmRjnLJpO3L7Q7JRZFjX8EW9wFBU5kc5v?=
 =?us-ascii?Q?FFmIjblYW/nslwawMKronEkxdESr5+Ky/MsWTJteD+jIdlNo+GtG/8J2mHv3?=
 =?us-ascii?Q?PWoI5TrnE4UJBrwfp6ZJYv+OQ7XdZXPsiE8OPqhlzvAdCBFJYK8gPvO7qI/k?=
 =?us-ascii?Q?EcR4f9Cdugy8T7PN1C3FBB1jLpUeJaHJndPuarWD+kdLG2tlCT1RHTdiT3R3?=
 =?us-ascii?Q?XiKB7r4HuvRkxbZTUAYYal3/xpFtwy7GYdgX/jAcAn6txCs7NTGRps2OdncF?=
 =?us-ascii?Q?3w8wkCxuWn7GF4JSXoaav5Z6fVIiH0/lvSJalNB+KPgQX5WdFAlavNmcB2D7?=
 =?us-ascii?Q?4Dd5xzzlHXUUFaoDS9Tk15nYAPE1q4xK6XkF9vYnX8Tt8DIHzUYexaQNH7Ql?=
 =?us-ascii?Q?hz3Q9KQ1oLGaaxG2e3z66kLKNkj+NLM+c/Gv2ql5QLlTVcqqBtTfK+jZyLVs?=
 =?us-ascii?Q?EKfFOF06b8x1vhnnvYs5+wMwceF3W+kWcHWv9erFvMLM6vh/2l/q4di3nMVe?=
 =?us-ascii?Q?dvfATTcZ/kuyr7c+ehGkvqAM0aLJYaKM7kgGnr1PgAxKlE+doV+r0ZSfwcBQ?=
 =?us-ascii?Q?weJCM+Fx3uqLNklGVvXHZYSERS05UAWDOtBuf5TPDtbYvaI1CpcmFXVeLKle?=
 =?us-ascii?Q?fUY5K1iOmpLqgdwB8sZLVGZzpZ1Lxb3tYBuqr/TgQvmn9yGeRQu5oc8mXk0x?=
 =?us-ascii?Q?0FdG1JPxtTaFtxGBsnl3Z7rm6UP3okyHX31fVaSk+0ZrYasZnucvtn0nS2ZM?=
 =?us-ascii?Q?wFDioy6/Evb8x+kR4VgaWSBXjYUKEKP7YTtcmM/Bvc4+HCE2wy++DNbMHg+y?=
 =?us-ascii?Q?hJ8bqlqD+LiIogXBb4VGET5JdVwdWIUm0wXgTtEHWAC8W4kxcuNpblQVPIaT?=
 =?us-ascii?Q?lLt+EPL6wZrA4NVwQ6X785izSCAV/31RwQKnbKUUP7wRzUf1NovI1K7Elkql?=
 =?us-ascii?Q?i2ncI6halZJrsHkTTpsh8N4lv2UECrOt908GO1pNnF0erjn893fVaJcA24n4?=
 =?us-ascii?Q?+gIxizOd7rpJx3mr9IZU6nzYXHznFnGYMJ5PqTSsB70GINYF8eOeRUW2pjVl?=
 =?us-ascii?Q?Rt1LKkdnCjh+ics+6vEhERawxvqVlkIPHsTYPQ0bdVtf1vwCudtl0jZMkkAW?=
 =?us-ascii?Q?4Azh84760wDJqlMBKeza9aNYWNGVG7mBSbkr9o3+ApkMMcW5jenaW2+mirgU?=
 =?us-ascii?Q?hGEz02Hq/+Ran98pLBqlvilRkTu0mhl+vTbxI2mjQiIB+KPj6Tyn6wrSAY0G?=
 =?us-ascii?Q?4r6xn/mwj8yvEm8Nz4pKvGLEh8Tq1cAtuNtoghIuuqP/FyIcEZYW8O88Ex2X?=
 =?us-ascii?Q?Yr7c4nBXVmEnThjMcLniB8trR6zKkLQYUueozlxY68ig4Cj/wD3BDuilh164?=
 =?us-ascii?Q?+i8F54n8EQALsQdIuvZlUNXo804fSUyDF/VWNgQuYol1BIxrvgOjRmPrAzrV?=
 =?us-ascii?Q?BiO1mFUUrOQn5H4uH6YmgfPVeEoPrWlIea6guXTRrFTxTZuyF4/taFbT85RJ?=
 =?us-ascii?Q?x2A9sEu4B+Ke0unkzszHuBF9J+5IP40w6CfLqvjvMo9WOVK7RpEQsDCTrlIA?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755f95cc-c148-46bd-1f0b-08da7ac0f159
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:10:32.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi7EScctoDLqXyjC9zbU4jgxGcepZVIM0ggYKjdue4KRClXxQWdn/WksSpkK6s3eDJ31AbYim2unGubXxaSvhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100034
X-Proofpoint-GUID: FqLJYN4rvNhPGRourCnCpbGao5laxq25
X-Proofpoint-ORIG-GUID: FqLJYN4rvNhPGRourCnCpbGao5laxq25
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernfs_rename_lock protects a node's ->parent and thus kernfs topology.
Thus it can be used in cases that rely on a stable kernfs topology.
Change it to a read-write lock for better scalability.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 45e1882bd51f..d2a0b4acd073 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
+static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
  * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
@@ -192,9 +192,9 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_name_locked(kn, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 
@@ -220,9 +220,9 @@ int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
@@ -288,10 +288,10 @@ struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 	struct kernfs_node *parent;
 	unsigned long flags;
 
-	spin_lock_irqsave(&kernfs_rename_lock, flags);
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	parent = kn->parent;
 	kernfs_get(parent);
-	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
 	return parent;
 }
@@ -1650,7 +1650,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_get(new_parent);
 
 	/* rename_lock protects ->parent and ->name accessors */
-	spin_lock_irq(&kernfs_rename_lock);
+	write_lock_irq(&kernfs_rename_lock);
 
 	old_parent = kn->parent;
 	kn->parent = new_parent;
@@ -1661,7 +1661,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		kn->name = new_name;
 	}
 
-	spin_unlock_irq(&kernfs_rename_lock);
+	write_unlock_irq(&kernfs_rename_lock);
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
 	kernfs_link_sibling(kn);
-- 
2.30.2

