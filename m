Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191706106B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 02:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiJ1AKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiJ1AKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:10:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B18F3FA0C;
        Thu, 27 Oct 2022 17:10:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMOQtd030564;
        Fri, 28 Oct 2022 00:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Bs8sc4GC1kdnQEvjC1SQPPl1ML6CgN50zb3nAdCF7cI=;
 b=yA7ix755QgKbEYx8v9t/KESnIX7uo3OVNrwnCwU/wDOOW7VFK7WYTzjNUvIuHNxEB2FD
 PA//APjBmdYPyrSrHGNBxr4aTWrSp1rsezDEq+4hoNcSpED0ktg/LG2Sl36wvDYY0X0/
 NzXxzkA6C91Es44qBgvlQ1aX7YP3nhSrys4ex7G+uUJ1phyc3h7pK7gappFb+9QbdC0G
 UevYKf28j5G7vk+t0+SfI00mXDD7DH9R1FXnK0h61pfl2QXQFNcGIjkawvh4R39zMLM/
 DU6EQrTAEpg/1S/hTsMXa6Ly+CB7jrZNOPQMDK2E4fvb8GTCl3Sf4DS63NijC3Wbe0CW og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahec161-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKugpf009531;
        Fri, 28 Oct 2022 00:10:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagfh6y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCVW3eF+veYCYMNXljXmW5nwhUPf+6pEKkpt2AIgkAbBU2h2C/1z723GZ0EkL8HgRMqHm4wsJz0uNej2P9c0ApBuJaVQ3/2Gpq7PuW4vbl+bylbEGPw040uqLMrgiZfI2pwkYrPCMrBKula9qjsB5O6N5cfyGOu1f3dB94cPg3Jo7NUiIBRUP/BB3QGNkQZaIWdK+bonpSu0tKgqjYCpK+r0KcfdkguIvr6E1iV7DsBhwRFeNf4D4XLLv5Y7HYheMSqDW6DrdKZdrpwz+hRXZwepnlijPJZKh9eIHw5pyM4x7G/3Y/do2ZbRi75xEAPDZLMG335S/JvjLziUmwv+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs8sc4GC1kdnQEvjC1SQPPl1ML6CgN50zb3nAdCF7cI=;
 b=P2+yaG/314uILHpYDN9NXZ0V0LCvcfltBp3RchPJmsnvXSldTJWfw0B+FEcRAIsOJD+7Yf34emOjWMM0Jy3aJeW1oCc5wzYunncc/qWMYi3/6BOeVdlEtNkaD9pt8ZPRozBEvfQkhuw6k4y3qZHgjP+oSd4ucTeeRsCcUN37LMmJZ3idRmC2g0ea648zybk/WxVFy6+PwG7V41LsbS88Fvzu9BGhviQvhMNKAHMkB1/EATUlKtMgS1zwWahk9FFtWJV6Y08U23CgIHZQAIPJbmrpBMH1is0XDllDbyvPuzG6lwskaFZrOG7FaAZSEqiZvlIpPL7M1erbzlO8Bl8HYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs8sc4GC1kdnQEvjC1SQPPl1ML6CgN50zb3nAdCF7cI=;
 b=Pc+qcmI0QoZxocVTVcdrNHZ442AIsZ8QYd9ucsXphzUAmTC2oy7W6lOyzfgL9nbtYSn+VuH0kk1Q7bHC45zoG2q14+Dh8S4BJ8/T3cnLaSjdjlh9pBs1nusY/bwwYAcs30GbeaOyXFdynlLlPkulASP/TBhKD2OXVmxhTpwM7+c=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 00:10:26 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 00:10:26 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 3/3] fsnotify: allow sleepable child flag update
Date:   Thu, 27 Oct 2022 17:10:16 -0700
Message-Id: <20221028001016.332663-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f7719e-94bb-4dfa-bcad-08dab878d094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWRzeQhBhkvoSMIXEywxTDcii5LwlYidq1gpDRIdjfByOj1R2BoE3L9kAH9EuXHPDPeBZRcQqWgYGXFQrm/zBtKLahYsCrMs7rGyZyXJPTx5oueR3TepykO2VcNrA3EtfxjsEeVk/afYc7+chLD+UTqvVnp1we2k0/CcroOOL1qy1jddufU3XIyTAXKQF2rSh0PbWTaKHypGQ0qkEre5MSImO5dojvuwLykEvvSNp+Kf1/0wnzPzrOYj0zrcF5ZjMf7NzEyhfHbJHaEKAvrRSkyVDf56qMeujd4fURCBSUV2cFPROWnOuCQVq+jxRSwtAzVKDmXEjxvljenCPtT5smnbPBzRCACriachY1LXBdA0iZJ44ydILCTcjkjLXgjFu1nq+9dMAvbVEizw4M3DE5wQEEkbGJWCaFIb7mZ3dwQN3yxX8g2nUzLKu2xiYuxShBXsqoGJCbVRRnGc7BbzjpZzbkkxMsdGMvbJMKHR/h7p9vQGi3uBtAb1ElCE2A5T//+1MtdwAOXAkhULuUiOVWzj/SiEBDQPWHF17QwdGABfwx3UusjugLCphAhUvE3KEnC1PXN9JwgWm9WxmkZaNsxe9OLACRwqJ5L2Lv5/gig0rnPHGHroYgnZ+GOuBmJXiHVg125L3OPcg2Z/NdlO0IDyx5l49R9GK2xS9vFhMEw1i0BdQUhA+a2rPqNhWO9bnrscRBJHoDSjpD10/VOurQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(83380400001)(103116003)(36756003)(6486002)(107886003)(6666004)(478600001)(5660300002)(66946007)(4326008)(8676002)(66476007)(8936002)(66556008)(41300700001)(54906003)(6916009)(316002)(6506007)(1076003)(2616005)(38100700002)(186003)(6512007)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bIdq1f3V9ig0Yn9HH1aenPrjNuRF8YuvILfUPkIF+d9phnMeNiBwZskwYvJS?=
 =?us-ascii?Q?BQHept4aEZuLrgjp5g5ZQasogopTbeUKketmwu0FrYkFAJX2f1ZVhlBMXPwJ?=
 =?us-ascii?Q?rAWJKlRxW3WLgD3tRHyjcXz3fkxParroKw++JT2Iok11+VO7/tprrOOX0hOB?=
 =?us-ascii?Q?CzIwj+vhWAqHK78g29PnBw2LVaq4f5L9kA0rCRNNlriREAN83E/CZnzNmKhB?=
 =?us-ascii?Q?uwsJwOMpXKJt0XjZutVtdyNJJOZwtWwPlgMcz/PTtLp3BnJVcHeThjJaZs4w?=
 =?us-ascii?Q?9UhFV9Dd9C6Xf49J3IM8MDi9Gmg4NhdIIGoUYt0RffQ4rkKo/qqAzC4zYK6+?=
 =?us-ascii?Q?cXw9mJh/Ruthj3bSeQsf/DoT1LO56ZCh6CyBLntTRP+iXGYJB6ZFrHsDczyz?=
 =?us-ascii?Q?jTKb56s0ZAK8xv0f+nxLyxVx5Lt6EoLI0X/KyS7SzuSd5zh+2mdE58P0QtC8?=
 =?us-ascii?Q?nHrFPUBYbY502BSxRHMK2ZCV0+EaSP2s7nkmy0YSkawyiR+jo1Ek/DFvD4oJ?=
 =?us-ascii?Q?ur2Wlm+kYlj1O11OAWPsN1DyQcGm56l8yfD6y2orhcYrakuj288ctxQiqAaj?=
 =?us-ascii?Q?xu8Ore62GBJ38+eRajsbGcyiDCLO5r33JtHkX+OJguCMM1T1IL7wvwPnW6Lb?=
 =?us-ascii?Q?oUYCJLiZy7P6OKhjz8IEqdvTtgIYVGxuTxFRzaLZEqm1eWEAT7FYOn6K76zP?=
 =?us-ascii?Q?Nw10oF7dAHESrG+TwNhYvAtEZ0kujbMCwHSdVKaUnicP0Mwr3mNDE8McQotD?=
 =?us-ascii?Q?nF/Rru4Tlzn4V3/wmc8DBD2FFOoBVzk0QomAMJp5qf8eiYvyTATJD5mKm2SY?=
 =?us-ascii?Q?WIIjNdNWxCnWvo0sBpnIs24zaa6gWeHn2WY7OV7FxS1TKgUoDUwPBUTFZS9X?=
 =?us-ascii?Q?nvKSLRijVtm4AI9edr8Z92H7uu3ex6h4O+FaJDrnU7hsi/djnfTxgNiTNoec?=
 =?us-ascii?Q?EpwOlR7OSU6aSYu3FCHNYxGcE0hfoHCq8fo8z5t7Zi7hahLYAyKFKqQ4hPQE?=
 =?us-ascii?Q?z6nLXGQAr42CXOR5sN8dhhzey0WnLTh6v4eJMzrsBQjxG2+w5J1gvHGYqnjx?=
 =?us-ascii?Q?FAbZDPoapoesGmVFCZbW1oOrK9K5AHRxyc9rMSxVNpU48PaD5aFFQ3BFbY2w?=
 =?us-ascii?Q?/SBHmsE7tr+q6z4hlHnKqX9S9vR6jjin/+BLy79nnTtpbRUmjL7W8o/NnyYZ?=
 =?us-ascii?Q?eKFfivcD19+INyfw7LsuBxONFtb7IQZ5bzth8Hz0ELX4A1fkbDWEUiyYzsIq?=
 =?us-ascii?Q?U+NVa8GW/boncN5Cbs6nGoEMHKIsIumWJv5NcyiKZIsdtOwppx1sa3cdGWv5?=
 =?us-ascii?Q?ivINHtxaY3KdX50bHc/Q4yI2x/v59k/ZG21LVa1TM0P6F7huE2CPda36fMfa?=
 =?us-ascii?Q?oVfQHjm0MKXsRPVan1km3h7HkhrBn3Ot117EUslv6P7Gnh0YSapWHiPixlq/?=
 =?us-ascii?Q?vkOy3HpztzwRXiOEuz/CULlbkTZKplkczaY+p4V8xuVMtEDmOMFG1K0/jeQZ?=
 =?us-ascii?Q?HbJiQWpUIaf0tGjHoqC5/Voi1QJ+T4bfxyWpZMdP/VzMMy+cYNGZfjM8wxSg?=
 =?us-ascii?Q?SqA67QB2+Sd5qgt6OcsXI+2GvugXLQxT0P+VRTIARjRM+EYrhQ1kjVnQ+OTl?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f7719e-94bb-4dfa-bcad-08dab878d094
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 00:10:26.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vcpEOhcbzXykz1naLG50HEHOyXLfv7SVMKlgOmU0l8gDPhG+u8fQfdZMSEt8ri4BBz46Gxaln6dpMjwg0dDo0xPQ/2dL6Jm+pclvKzISqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270138
X-Proofpoint-GUID: AV33PWdkUCZRRun01IvCxU5IVK3chsLM
X-Proofpoint-ORIG-GUID: AV33PWdkUCZRRun01IvCxU5IVK3chsLM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With very large d_subdirs lists, iteration can take a long time. Since
iteration needs to hold parent->d_lock, this can trigger soft lockups.
It would be best to make this iteration sleepable. Since we have the
inode locked exclusive, we can drop the parent->d_lock and sleep,
holding a reference to a child dentry, and continue iteration once we
wake.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v3:
    - removed if statements around dput()
    v2:
    - added a check for child->d_parent != alias and retry logic

 fs/notify/fsnotify.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ccb8a3a6c522..34e5d18235a7 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -102,10 +102,12 @@ void fsnotify_sb_delete(struct super_block *sb)
  * on a child we run all of our children and set a dentry flag saying that the
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
+ *
+ * Context: inode locked exclusive
  */
 static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias, *child;
+	struct dentry *child, *alias, *last_ref = NULL;
 	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
@@ -120,12 +122,37 @@ static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 	alias = d_find_any_alias(inode);
 
 	/*
-	 * run all of the children of the original inode and fix their
-	 * d_flags to indicate parental interest (their parent is the
-	 * original inode)
+	 * These lists can get very long, so we may need to sleep during
+	 * iteration. Normally this would be impossible without a cursor,
+	 * but since we have the inode locked exclusive, we're guaranteed
+	 * that the directory won't be modified, so whichever dentry we
+	 * pick to sleep on won't get moved. So, start a manual iteration
+	 * over d_subdirs which will allow us to sleep.
 	 */
 	spin_lock(&alias->d_lock);
+retry:
 	list_for_each_entry(child, &alias->d_subdirs, d_child) {
+		if (need_resched()) {
+			/*
+			 * We need to hold a reference while we sleep. But when
+			 * we wake, dput() could free the dentry, invalidating
+			 * the list pointers. We can't look at the list pointers
+			 * until we re-lock the parent, and we can't dput() once
+			 * we have the parent locked. So the solution is to hold
+			 * onto our reference and free it the *next* time we drop
+			 * alias->d_lock: either at the end of the function, or
+			 * at the time of the next sleep.
+			 */
+			dget(child);
+			spin_unlock(&alias->d_lock);
+			dput(last_ref);
+			last_ref = child;
+			cond_resched();
+			spin_lock(&alias->d_lock);
+			if (child->d_parent != alias)
+				goto retry;
+		}
+
 		if (!child->d_inode)
 			continue;
 
@@ -137,6 +164,7 @@ static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 		spin_unlock(&child->d_lock);
 	}
 	spin_unlock(&alias->d_lock);
+	dput(last_ref);
 	dput(alias);
 	return watched;
 }
-- 
2.34.1

