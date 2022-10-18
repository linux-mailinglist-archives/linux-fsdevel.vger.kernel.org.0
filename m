Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC160232E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 06:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJREMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 00:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJREMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:12:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF189CC0;
        Mon, 17 Oct 2022 21:12:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYRBV028823;
        Tue, 18 Oct 2022 04:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EoPDz7SHNnc8/VHYvCgMBz6YOkq1tx8CVnYdSlXCcqU=;
 b=va/dHIGxefvu0E7a9vR65tCLO3bdXzYMgLtrGaACmjvauDtPwSRk+e8EjXjSKnI5g9QX
 xbOtwkjQVRQ8jvZTl++uOU7vO3aNx5k0Is2BwS2pT2XRPTLAQbmUtEbA8hFvEWD+jwKR
 DPsMiqdasoTlA3kuLY9c5WzK0mAv145VKgUo76K/ZQgmRp1b6tCbAOAhu44+4+TzY82L
 OB3K1OKMtZUnA3DTVk6IgGD/s2+8geu2VxiPkNOX2WBlqIq3KU2xZXpZoA7H++zETBnp
 gp97Yg/LsVABN3/1/1LaYsPgtERSQvv+V65I0eZbvbgcCOCUPG52Npwf5Dpmsuxxrq+b AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nt9m15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:12:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29I0f8Zk017332;
        Tue, 18 Oct 2022 04:12:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6qbqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK+i0ZnsRFbSJc8P4toSThNJ5v2clJtQIBD23U4baQ/sZ2/DccnnDzoOt4DyhZTTP50HtTlS5gMieTaquKqn6DH7sZOJ9ysuDeYXBXKwpZPL1pk6kFD+kY+cGAo5ov0J91igO6V3Z31BG4siqu9VQR1Flhmybdp4BezmpSOqrcLWFR+csjK1Pm4sK2wAloJ2mWL6/CeW9B2RBQmTXE1rv1WDr4H01rOk5503RQyowEUsHr0N9hm/jhtVmBexR91wGaIoFR1HoASTPvOQeMu8cKgYFCN34yjk0be4dgXQga70eHi2YobJRCCYW21CJYRtcPpBXoh6zIT8PvWifMEMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoPDz7SHNnc8/VHYvCgMBz6YOkq1tx8CVnYdSlXCcqU=;
 b=OGYp+7zhKgG+vLVbT9KdhebMNmGvGE41XVBperGSVBLK6Pg8HLTQdZ0iI+nSmRzFBEZHv9TFTecryN15e1VzLzV7GHuUMdMYDi6DTyl250On7pzd8aL3dZtUvROh8UP5yo8jXXUeHxBPGyF59Lt9SUgnrS5Iu52TUefz795I1uw9plhg0zW8gdZDPs1P3kY9TaH//erTPlPloitsVUnmov3ITtImQHXuYussUXS/aE89vpYoyGp1+Jr1qx0MfpjOKcswDbfDG1j8eKW1Ea7zCgoH4lzJgxBFESbbBDR7POYXWAEYtnH130RF5mOHtF0Yy49MbAz6JMhaCQyPoLCbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoPDz7SHNnc8/VHYvCgMBz6YOkq1tx8CVnYdSlXCcqU=;
 b=C5dXo/9XI13RmzMj9jPy0Vtjehopd3kMjuMLMHNtboJLvuUIyNtG5mglIFTb3xDWD8LzpyjG9yP3kDowup3+K43AkFZMcRn+tGU0k8RIU1RqnivJWEdDJyxjS8aqqmqqH3P8cOwhX/+J7pyWAyREtl25e67bFTPDlDKKWlFubDE=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 04:12:38 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 04:12:38 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 2/2] fsnotify: allow sleepable child flag update
Date:   Mon, 17 Oct 2022 21:12:33 -0700
Message-Id: <20221018041233.376977-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3df2a1-5cbc-46e3-707e-08dab0befe65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1+BqB8oC31fmNidx5OzgHLO99RebofHeJq6zpAUb5WR/Kl/yRQMbbuImkJo31Q4PfPlJc7HuAGiQEWD1EHJGHVElzA2jHS5QEgX3v2eZBcxGZOrjVQncd506ahaww02Yb4onxMpyFKim/NyNqmr9/j7zLaGAvwWUSKbSL0H1sOUZJCkdE/5Nbh5N4SJlpIYrkZUNCY9wNTijWyqoTXfxphCGqUSWwoZVhWfebFXe7EVdAQj6gIVkQe8Dhij99aVzhAmeF/5C5STynGiRjgWTovDSbmdppXaYtUQwCZaXzAbm8Ec0PpwOFkx/uuYjXLapWU8ewORV3Ga/A+T7qgAIlINJ/KjCOlMk1LN6EBQ5umjWSsKwrpnBIZeuKTdjR5qETjSAf2CcsSIBytr+1jZN7OKU7E8B6UtpVcQTZaPGIjz38+UczCRaMNG6qH6cL81iIWAD/Xo+E1sWpA9Seomb/pBErOcFUz89yoKQEiEF9KxFG1x7kYNXbQouFkii2ZvlYLI0LXiMR1W0Rz3qpz2DhzRv/UB0rbYGubsduFu7UqRgt1bb0ob14cQg/+eNwhubm9cXx1cnPZCMdokAgURTWqXZccYgRnsOejQP61SYGI6V4ulGU9xDTwsOJxNdhI6FJNQjLrhgqdS0ZY4w2wDngsdafrrYlZBJWEYlu3eI+I17HKe56I3yYIFzZyhLSRXIkALN12m9BXqhX8u4QJtIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(54906003)(110136005)(66476007)(66556008)(4326008)(66946007)(8676002)(107886003)(6666004)(2616005)(316002)(1076003)(186003)(2906002)(103116003)(86362001)(83380400001)(41300700001)(5660300002)(6506007)(36756003)(26005)(8936002)(6486002)(478600001)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4q7AH11isz7V+EpsANO9k2KKIcjE3+hIgXl0z3XlMySTDdqIWEFke9l9bvif?=
 =?us-ascii?Q?ROpYWxZgvia0kF3tWXofc0/A66FzxneDzeLiXmXnVXi+16KH7EVNXmBSeh+4?=
 =?us-ascii?Q?DnCkcbVd4MMlL64EWf5JOBceyQkGVKFo6ol1lZ9XDytol8BnB1euKzFjN2Vf?=
 =?us-ascii?Q?E9crGJyEOkkzBkSZ0y2pyhDoKV2J4bYk72lNdbJoRMBKOmic4FSUc7du8zsg?=
 =?us-ascii?Q?3yWEf2ipHUiMTDYmwjA1l0Danuq1yzRYNauBSs6b1HBcCgHU4bfFFk2LANp6?=
 =?us-ascii?Q?6Z6SlXEyWcUYP7aYP57tBCCwF6TcK/aaubkvFnIaZIPcm8WLWphAXQgxVqzu?=
 =?us-ascii?Q?VwO3Cr6r8kMRkp1VrySPv/bXo6Fx0RCns16ljkFgg8Mlvm3S8FoaxbCfSQg/?=
 =?us-ascii?Q?/5EieFKUWKJ9R7AXD9hTkx6ZXFuM7zovG3qamdjeHsr2Ig4TPyZEItACrqKC?=
 =?us-ascii?Q?3DpXjT+JGTY+bjTGQZiTNi1qm/7S+jEH0Uu6fH3pf2GKrlTQ7xJP6GSnopbW?=
 =?us-ascii?Q?bq98izBjBkzktfjI7hivJsWPaBrScsyJ82l2u1RfBTs8k2loIHDfbGpNpi1m?=
 =?us-ascii?Q?XGGR9nb5DCIGARaEdJed0LYi9tt5B7La603ohnFGE/bh/unITRy3LtDIaaXh?=
 =?us-ascii?Q?AdJEPtuR7H8u/ElxsmUy5ThHoJq6c4/XuPj/LzYV6A2NlVW10ZDWJBMhbgoO?=
 =?us-ascii?Q?zbNx74sDjS4hVD7Ve4rUpL7vD41kzQXobAK135THkXRc7ynRPEpvcWZ2E99Z?=
 =?us-ascii?Q?edQzZX9x+7NEqqUs9+rxBt0R+LRur/czMBRXu0gagWSbISqvI/nXnDwMVGHz?=
 =?us-ascii?Q?Gr8R1xhRhoSc7ywD0z00ZqzI0d4fvF4FUr0WpCWAU9GA5NpmtPPviFIkWbHu?=
 =?us-ascii?Q?/94p/MQTW4ICfS19CxIK8rqH/S/lVG3mSoNrr/GEVToAM8swVTDf6exF1oi0?=
 =?us-ascii?Q?85ao84Nl5bZ82Ef0+IYM1x/0P5s63xZwd8CCSrYPgISBpQGIG+uojjSroDHT?=
 =?us-ascii?Q?DT9f3GmVYEYnEpsorzrf1M2HJewBErUEKEHOUnr/AYiGrErSXREHYulr01LB?=
 =?us-ascii?Q?Rttcd0J/MNJiLMezkdlqKzIrxe88/S9h6HRsYkJ4/2ZGlk+nC/WNvScWxxuv?=
 =?us-ascii?Q?QvdOinfYBvZGsWVdGJ4u0FnKqiQFmzVXI503vGf3aKlfnBrHyn4uaWpV+OOm?=
 =?us-ascii?Q?7kS/9e4lKTHsM9VSUy0CVvTJq4E9tKpAROiArKnyhukd79i5mC49lC1gJri9?=
 =?us-ascii?Q?igv6X9/oT+2w9m1BLwF4l3wipwxeg5xhzUlpdb3CSIOFH5hijbZTmwgVcJsK?=
 =?us-ascii?Q?Yh70MntPKS39UkqIACckV+zZ1v+bXjdmj+UyMxQ2130Yxk7oL2thbJWQUwtM?=
 =?us-ascii?Q?b0NGxrKh7PT/vRie5qIv1eT+64GPAbdmlb9s9uaqJoW8ym9qzErcATneiuRU?=
 =?us-ascii?Q?dVTDWELoh0NfayCSSsBHnxT5MgjR9rte+Q0bkk1B1x2HrmdsKqedcgyVb/8w?=
 =?us-ascii?Q?ZqJ+n+sYJcGKk2OTKAXy2DHRttw6R4gopeQEcajVRN501sdkdrXrYzzTs3Am?=
 =?us-ascii?Q?uvfX16IgKVVhGKkI3+/JgOrwArWc5oW7ZVnyEdtwRs9dC9nWQ3poE1+Jc24+?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3df2a1-5cbc-46e3-707e-08dab0befe65
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 04:12:38.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F49K0fWqHl24ld/fdh0dU6qqjrjQITogcytWSjwwsrDg+3VxgLy8JR/m6zVx2qFzzH9c2xDrPrZ3a34OgS7dLyQ/wTw+1rcthqmVDKqQ+7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180022
X-Proofpoint-ORIG-GUID: uHVjTIAz4b_Cv31BNQlUmH9Eq0K5Ig-N
X-Proofpoint-GUID: uHVjTIAz4b_Cv31BNQlUmH9Eq0K5Ig-N
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
 fs/notify/fsnotify.c | 72 ++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index e887a195983b..499b19272b32 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -102,10 +102,13 @@ void fsnotify_sb_delete(struct super_block *sb)
  * on a child we run all of our children and set a dentry flag saying that the
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
+ *
+ * Context: inode locked exclusive
  */
 void __fsnotify_update_child_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias;
+	struct dentry *child, *alias, *last_ref = NULL;
+	struct list_head *p;
 	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
@@ -114,30 +117,55 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
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
+	alias = d_find_any_alias(inode);
+
+	/*
+	 * These lists can get very long, so we may need to sleep during
+	 * iteration. Normally this would be impossible without a cursor,
+	 * but since we have the inode locked exclusive, we're guaranteed
+	 * that the directory won't be modified, so whichever dentry we
+	 * pick to sleep on won't get moved. So, start a manual iteration
+	 * over d_subdirs which will allow us to sleep.
+	 */
+	spin_lock(&alias->d_lock);
+	p = alias->d_subdirs.next;
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
+	while (p != &alias->d_subdirs) {
+		child = list_entry(p, struct dentry, d_child);
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
+			if (last_ref)
+				dput(last_ref);
+			last_ref = child;
+			cond_resched();
+			spin_lock(&alias->d_lock);
 		}
-		spin_unlock(&alias->d_lock);
+		p = p->next;
+
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
+	if (last_ref)
+		dput(last_ref);
 }
 
 /* Are inode/sb/mount interested in parent and name info with this event? */
-- 
2.34.1

