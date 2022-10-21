Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC7606CC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 03:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJUBDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 21:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJUBDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:03:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78487229E44;
        Thu, 20 Oct 2022 18:03:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0EBqI012288;
        Fri, 21 Oct 2022 01:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=tu7DynKVPxM0ueG7tyGzCY+i0KOKgPMaDN3fSXT56HQ=;
 b=HN65lLupuMRRcHz7l9wxBQMysVrE8bdgM0TylKtyVck+/XU1nn0uLD84TzzaIPoKrfpH
 fvapwLbpgJ4s8oKJtYWx1+F6ASH02xwQDkfOQZ4mByVsbt0ZJhXPbZyUcBOgWC9S6wAw
 Jyyc+oblhbvGQzyKlQe8F8gSTkfL2Mjt7nGGGAk9AfYOqNNTvAP31jn9QKICLQU9q4mU
 ah5MqCTWKDVXbdApbXN8ZQaz0jIOwDCiwjrYIX7Kv/ci4XUu+guikHVKtE+KX0z6gXVz
 nWzPNEJWfprvJagnHlh0aWHNDqm8SXsiWr1wqSywTPMrc+aBCo0t0/Nfe5vRmjUBizKn 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9awwaaxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0CrJi014702;
        Fri, 21 Oct 2022 01:03:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu99feg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5k8zWEh4H2TTb4laN5yF8dgCRPSTqHRRWpu4lr6my39W3bL0OgPz3yzHyuyBmirj3FlnajAYx0lTDyPzxWzmKTDT6QF269DiA+NoLVbc2Q5/cLawDi60bEouM9AlZTW1IglSS0Qn5Et92xSq3L7cbEouoG6wcljD9C4Lca5exPTqhixlzDSxs7aVmmljcfhOtTabxrP9nLle54pPl3ou7jWdkCklh+lYac83QnF4llxoDD4LyTA/kZlPC3e0/r1VOX2UaQoaoCPzKH9ME1Zj3NYWHjzRG/QUTROQQCG3jU2H+INRwLBRrpCGBZIbSHtDut5V4Fw6kyqIBENQ2Ip7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu7DynKVPxM0ueG7tyGzCY+i0KOKgPMaDN3fSXT56HQ=;
 b=Haz196K2wjJgOyQfgIj2KfzX6DI7++VynJ5pknDec5upuY4YZYb5tkCno9pfQShoB9yTifFpmXsNfKA06/j8tIEx91GhV6Ugpae2ObqGmlbcyJDOaktaeoYrAu41pWS/9kwxNeibqJuMc8+KPeQtmVfMxJm3tymLT6f7obYW4Eub14boMijf1Zg0WTaGnW7sXRItOLvl5zML3PEygQBsHX6SjL20e5NnkfuBFbL6DIotmI/1q8+l7oyO8aT16r6niYYKnL0eRnxr10jHzOxJd5a+EZ3wuE7hN5Nu+zcy4+uzxXHDjx5zxhR9K1oVDhkWH5Qg5tXe/hIjy6ZIgPXNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu7DynKVPxM0ueG7tyGzCY+i0KOKgPMaDN3fSXT56HQ=;
 b=dpgIjqFzlQFjnPJFssV4SM1hYavkxGE03/xj/x0O1i+4aMTnsYakt8aNtSuwwPE/5JwZp0aqh+LqXl5dmXDmle+lH8IU4ZeptN0Ku4BsOkilO1SmD9CJ8hDWnHFW53nf83+kwWu6FiYmlghVIUHUGcL2lT34FXPKOApsXPbNMa8=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 01:03:15 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 01:03:15 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v2 1/3] fsnotify: Use d_find_any_alias to get dentry associated with inode
Date:   Thu, 20 Oct 2022 18:03:08 -0700
Message-Id: <20221021010310.29521-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::47) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4a2573-6465-4d27-f209-08dab30008ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWmK0DAkLaJ3Rb+cX6+WCHc0CQHM6u5eYhojKk1JHExrk9mYDqf4J4/A70lZBHcmkKzp0YxZtxb/ANNEMDtyHOENUrCayORQvMYZfll2yZcC2pPatCKf0n2/QFXnWsa8vhlNphQw/qxS6k9RiMs5pOqA2tLfqrgl0X1AkNEijO3xIhIymEHCXKgJISFQigr9FWtGNUBDFWuhA/KYLTa5CiUvq7CaLOIYgXKzLfzbasaNQ4mwVST49eNBJwOnFSLNJRtkn0mmfHNOzI6G5Su8BuiLwdi3xKzgPx7JcYUN9ZF88xphl/mD7QupaKbjobC5/qaei5JwQpZPsDtbm2tkEYyOB/KtQnDRNc0Mr24jqE+ZvUDBwRBNcInTHemNfUikJphXFyLn5lDbR1DF6vRI2pLwxCQ00AjxFHkWDI+kiI3/Bl0X1v6vBczQ+3+eNZ2MdoYkI4gyCW6r40Onl9XGDwIW7d39wpVu0MWvtVbr8VDOAtZcHgxONz5IBTGUmxeIKdOgnhDDLSNLKjUG3VsEsHOsujA95n5FMGRthqu+q1fO1IbQc2pvR8oOWzaaPDTbfP6OuhrHpDGPcfUUbR8PVA842vJqnp2OmUZVKNyJiKl/q6B7TEfkpqf8kGkn4NxLk1RABN1Y/HR7iLnFROqq2WiuAQ5Es/lpCpKJWE+f7xdQQOGPIEZdVY7XiIJ6p/Cr2jNOoUzNx7c3Hhmq25Rudg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6506007)(36756003)(86362001)(38100700002)(316002)(2906002)(83380400001)(103116003)(1076003)(110136005)(478600001)(107886003)(6666004)(26005)(186003)(6512007)(8936002)(2616005)(66556008)(4326008)(66476007)(66946007)(5660300002)(8676002)(41300700001)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kjw9E91OUgpn1LgT4+nSrZZ+OfizDzSi+Yb8s+h9FLzUIGzIibP3im78S4Bt?=
 =?us-ascii?Q?+iatJGP1uBPjYhKHCYnZigPyovyIQE0HMZYbsR6BklF9nhCgkikRDCjKzzyE?=
 =?us-ascii?Q?mGr+6y9S3dCVydSv+GS66ONFlmrN18tIvQCQ1Ui+VdATQj4MFEi+qcbW+dHU?=
 =?us-ascii?Q?erk0JuReJCmVyNckKREusHMGcrowVcCrNlwM/Dhway4zx7b+cNAeHG9Ncjs+?=
 =?us-ascii?Q?u5kXrtiN6248tNApjh+weacWcG1miV3XKfaQUpoI0S6pSYpz4koZePkwpfop?=
 =?us-ascii?Q?gX1kXFXBLFuDi3mQdeYLxeM4TsA0MkSmQxXXKMD2+iEVmwC8Lp6w5ruQ8zBi?=
 =?us-ascii?Q?VyssGt97wjRCOA/GdoHgoleyg4c0lQr39Fwg3wThJgOn/H1FO3dQ0ZIUGYHr?=
 =?us-ascii?Q?TOkq1pWejv8Rux28FeaF09e2UpWgXANNvP4FwV4EAhMswtQm9j9xM6c3B+MS?=
 =?us-ascii?Q?mZo31BcJwoEBZ5XaMCESWqByjsI/4AdWVAYm/EADgAKEyILiLBNDlrcGCPuO?=
 =?us-ascii?Q?Ohc8ZoIyEP7DSMIUfapLFvAca48IkmZimtLhOo+G+ydXdwFYxo4L1mDEeac3?=
 =?us-ascii?Q?OmwwzEdDyKak2GyvaZIgK6DQsTzkAx4pjnRW1kVagvUUWh6ap8Z2JuLuDyA7?=
 =?us-ascii?Q?ywnZNwPFIDHmuVyx6K8WLAbzCifP9Gi4T+LlhRxfI4AKJodezUpQd9evvAca?=
 =?us-ascii?Q?vojexWroc4ixHXKXmfGpdgt2SkeZwG9M9kY/e99dcniWeP9MUcDWdETxyVaQ?=
 =?us-ascii?Q?6UHgI9GlLirMy8uUyYCgjYOW1jrRWSZtKppDfs+MG+D7CsAB2F1oTgUKvdN/?=
 =?us-ascii?Q?tpx3IT79htxeS0KD94/fGmdwSoDgtaDtj2tvxAfNvGSwrBq6LIEw8gSMVLEU?=
 =?us-ascii?Q?l3LljYZmvwnOdoAoh9zvG+lDtMx21c21Hz5w9h4y0TEbDXWRvkhLS3dUfAuP?=
 =?us-ascii?Q?zPmcIUPbuh4VM2aruk4dH61om5YjFNQSvFm+hQjOWWGUkqnnh8pfwUWy3yJ/?=
 =?us-ascii?Q?EGH81P/l3JcP+tsXFBqqyQxbUTvpzMCZusrBGXw/8AAU+7p6mtt96SC2HiUt?=
 =?us-ascii?Q?2x1zKrj4MxjiSBhk9EiqCvP5keglfYiF+LaKVCJzozRkXBJ0qvreEfTeTNlf?=
 =?us-ascii?Q?daeswZmhv91vJ23S/9rXzXRwVj3BEDkoGSDXehzocNfreMsHls68dlzQviz+?=
 =?us-ascii?Q?0ZygW0ylPEKbGJ3IWBt+LVCmrKZvBhlIbGlo/S6aS5Qpc1ZFiAgsF/oy3Fmw?=
 =?us-ascii?Q?voOYjQC54QThGlwA26EnrzWsAF1QNKYWQEC2KzzZLiD5JOgMd7lIjnh0rqra?=
 =?us-ascii?Q?P8xOapkeOvMdYfb927iG97nxSC9bHlC+BWOB+dkR3EuG6Z33k4m0iY+g0rS+?=
 =?us-ascii?Q?Ly4kv4qGP2hQEuw0lZY2/CowYhbS3TKHBapHFTEaGK2/v9xWIkEr+v3R+X8Q?=
 =?us-ascii?Q?99vNkT2bNT4bPtxi2bi0KjgCBMijQTIowyZaACnzzw0RD2V5doG+FE1kAkB3?=
 =?us-ascii?Q?xQbZQMOck8Rhbj/v1CRfUaqsf2hH+2PWiBKjxtCHjlcTn5G7ZrHepEu28HK6?=
 =?us-ascii?Q?1HFYqjV63kUh5BepBF+JTiRZ0/0VQ9U62NjEVss1NFmLPeH6sLhQiBTdtPTU?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4a2573-6465-4d27-f209-08dab30008ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 01:03:15.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aY9T35If4tut+pIrY2DFxTpejahUirE0hPHUBIIOq3smAnuDgLBg4ztCSA2LfzwV65tH5KVtKhIMTApuu5yE7sd3pkjtL431XSRfuzypkoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210004
X-Proofpoint-GUID: He38wPzaC4Gr-ks9JgJV1p0TrYcT7fka
X-Proofpoint-ORIG-GUID: He38wPzaC4Gr-ks9JgJV1p0TrYcT7fka
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than iterating over the inode's i_dentry (requiring holding the
i_lock for the entire duration of the function), we know that there
should be only one item in the list. Use d_find_any_alias() and no
longer hold i_lock.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/notify/fsnotify.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..6c338322f0c3 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -105,7 +105,7 @@ void fsnotify_sb_delete(struct super_block *sb)
  */
 void __fsnotify_update_child_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias;
+	struct dentry *alias, *child;
 	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
@@ -114,30 +114,25 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	/* determine if the children should tell inode about their events */
 	watched = fsnotify_inode_watches_children(inode);
 
-	spin_lock(&inode->i_lock);
-	/* run all of the dentries associated with this inode.  Since this is a
-	 * directory, there damn well better only be one item on this list */
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		struct dentry *child;
-
-		/* run all of the children of the original inode and fix their
-		 * d_flags to indicate parental interest (their parent is the
-		 * original inode) */
-		spin_lock(&alias->d_lock);
-		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
-				continue;
+	/* Since this is a directory, there damn well better only be one child */
+	alias = d_find_any_alias(inode);
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
-		}
-		spin_unlock(&alias->d_lock);
+	/* run all of the children of the original inode and fix their
+	 * d_flags to indicate parental interest (their parent is the
+	 * original inode) */
+	spin_lock(&alias->d_lock);
+	list_for_each_entry(child, &alias->d_subdirs, d_child) {
+		if (!child->d_inode)
+			continue;
+
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		if (watched)
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
+		else
+			child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+		spin_unlock(&child->d_lock);
 	}
-	spin_unlock(&inode->i_lock);
+	spin_unlock(&alias->d_lock);
 }
 
 /* Are inode/sb/mount interested in parent and name info with this event? */
-- 
2.34.1

