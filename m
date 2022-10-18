Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC26A60232C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 06:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJREMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 00:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJREMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:12:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC71B8A7C3;
        Mon, 17 Oct 2022 21:12:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYIC3029594;
        Tue, 18 Oct 2022 04:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=iCvkMCU/jylQ+ALpEDdsaggsn4HPn7lmO+cIKQC8Oss=;
 b=Sjwz+r8H5agAEpW6OPNjfaeWbtj7NJV5IfnVAvfmtXLIfScIWQJsOdGSM2I1WHqybndp
 jnnbWZ+KvHwPTkP3UoZC46gFRcNjr28r3d5zSBXRINiwXJwmsmvFDwYH+nDCJ2Q6K/DO
 ZyPgrkq5wNMO5WxXGwBDY9VFsO1VAIXEToCFmExhO9h5foqiuGiguuBoPqM3jyCTTaoS
 UfBC7DkGEe2x4ZzJRDRtSbmIq6lExZxXaQDwTUcisMLsf+I0TuWkNi8B41JNuJIa4WBB
 Gn97pBUoXSwFE5ZAaK/nh/82pZoLVIasAV6nNPF1cE5fWJbV32fszWqx0FYO4bs1CSVW 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtywj1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:12:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29I3puF7015903;
        Tue, 18 Oct 2022 04:12:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqy6fdk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 04:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWAnh3k2tTsTyED+XSUbcxa0wbbZ2wKSipCP/GqubRWnGMXiTqLQlCRiydrNfqwhlALCIWNuTnQ4sTRyqOMAbOzdThSCINh0yPqJ6wkl7n7t9hidSNYPo+/yN6P4ofXBxPTW7A0eJTnvW9W73Vdgm9irzGTWfwjU9u1t1BzvjXMeNA/wJFglQkZ9hvClyHmbjfeoPc/3c/We4BvvD9cDHZ6NYvt47yuvLb80PyhC4JYA8/20kSo9LNidpmimsRHszea+SjzEAwzabxGULs7YQLgb2HCSa3CwsG/KSm8J+JIT6Yj8udhivqcZTKcwereE0VqbPCKSex6ZgXKIEWV3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCvkMCU/jylQ+ALpEDdsaggsn4HPn7lmO+cIKQC8Oss=;
 b=U+7trZt3eeSV0xBLV9+j3FWNK77B4MvY7pBIAyDRMjRlXOWC5HYb6aUplDwgJIjD818khvcZszUHrEu922ObxAc9qYNnd4/eHTKhP5K3NEg9SevJAVQO8qbFcbnRf5THa1TjbxyCq9zxMj+dMhbPBd0svq02TsL6QOuunxIofMqRHVd8hXIQ4RUuHoSYMnw2d/hnCUSx8MpaRRFB/ndHSBwQEtCcCswo9bTvGycH/Q8Q0M/CP0fmIYo73sIRglqsYIcPf7rqsp3n52MiL2wDt/kEidwa+Z2lKa7oSsVR1/MmSC29co0lNc1w57fx6EHEFcK+aR324MoS97t33ISA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCvkMCU/jylQ+ALpEDdsaggsn4HPn7lmO+cIKQC8Oss=;
 b=GUrdzuosKh5ka7ESplM0yp4Nsih7tWYTEQ6byltvtehk86o8FR8emd5SCgoShekDFNfjMWHOCvpEVDgd411XhhOXG/UABfMoU6Hy6Iwi97uMY2P4Y0kxr0QrtophnwZRc3/3XChnzCUru6hRYdYdzShrvuxJ28RhDNkrIs3eeSc=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 04:12:36 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 04:12:36 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 1/2] fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
Date:   Mon, 17 Oct 2022 21:12:32 -0700
Message-Id: <20221018041233.376977-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 606e2529-1e30-42bf-ce09-08dab0befd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: as5Lg12inIXFgNzBiTfk5NPbs4CpnXG7TkDNQOQNpSLoxtCz7KiDbgdKld/nxCnx3jrP2WITPbXRqs8w8CNYfDKpBRVZkKgXxg6hCcoGMUWN5Io37Wyho4pmqhOAYPbfjz535s0jCXr2dnFAvSBZ+8xjeGMMbGOaKJc0rgo0zboEw+YCLprZlin6Q0ZyS4Uuyk4JnQj3kIK4vgZFyIfzj2KO/4WibN8SlXFhf4u30zXKwyFefjcvUQyAPu5cHW8TX9yfP8d1PFK7LjYadldGzUQfO5qtljGD6YeC5GRGErMRgUlEC/RqRwsGhZBMs5bm5+lAyLdQ0DVTYn6fI03TCwGhrYlq0/S+hYvwORo9MPBqLNGXDoOKM5h9LZtW4gaZWbVE5pry7yjOHyKuYJyYnfM1XRW5k6A5MojKiLVza/WnjClMHgeU2lWPwIHuO3UyqDXNkyudAqwYIphIRlwaRj+z4Y3ycnSXSVXUly5ZZmAyBgV0MzQFxiguLY/rH80mrFoVIt2Vo1Eocv18Y/WANMnUrEv89nwBQJqjmoPy0NQlZh/q1wE8qh18UlSiv3JruxcagBnJL4M3Mq9xNHOZyFuzGsHKfsSzCv99Eb74da1WNoRAR4bWV8uQEHBIZ9TzKY78gqEyAcxGt/63dRmqiNC/BgJ9Jb67+S60lokedgbKrteRK/sVe7EarJ+cmNpVqhmoxEy0u59hfCkaItXSrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(54906003)(110136005)(66476007)(66556008)(4326008)(66946007)(8676002)(107886003)(6666004)(2616005)(316002)(1076003)(186003)(2906002)(103116003)(86362001)(83380400001)(41300700001)(5660300002)(6506007)(36756003)(26005)(8936002)(6486002)(478600001)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ctcxDY6qKAkd4XYhUo2FYRHdZK5EbMtzaAUpVA5QNks6F8cUPp+jdA/sELMG?=
 =?us-ascii?Q?EpCLUoVHWLDtdmvkE+1iX6jCfzM3siLVZ9c+vvZyXxoNkcroVDyFZ1RDsHBc?=
 =?us-ascii?Q?KNX1JlRiP+Tojwep+7cW3pEaT7PyEti6xmCgvpTt3Z+6fScWpWbJy5p7DMdD?=
 =?us-ascii?Q?1dWxiXt9UNz/wLKIfxTS4glNB+NqwkWWSsuWMuZ1c8bReRpTRqIyB96ZzPWK?=
 =?us-ascii?Q?EfDXyAYLKFLCL0LlbZiCtcEhOUBuiYkQGbfwLDz0p2bfp5DCcNzbaUVt64nJ?=
 =?us-ascii?Q?IV9MMucRZbBQFkAdwskY/SvKwvKmrhululo2TsFK29ce11EuphJr1sVQCWjD?=
 =?us-ascii?Q?nHE57L8CyJztAdcLqaPTX2jGIlpnkvzZBJjvHL7pLEbFuLcEKOEJRQv2gaEC?=
 =?us-ascii?Q?yYd/Im6+GoHwM5LCEdk5OqzteiKD1FXrJsDWcBmv8pAJaGeVRU3SQTlGT5Q/?=
 =?us-ascii?Q?5DMSxMW5ePjwt+GfhZgTEJVbd0kEe0r6bKfzmZ6NaoKy7oMJ5RPYTIsep9rK?=
 =?us-ascii?Q?IvfTovPOJWnmVfKGWtvFWfgAVpLBsfIv2tQB6kFqSD2aEEJ/A0C67+JF1Vow?=
 =?us-ascii?Q?DVUBFIhJbwSsEF5ixNQjC7nlKGDw3KKv87Qk1xcTDaI0F1Di9pvi59b1omlJ?=
 =?us-ascii?Q?FJuLEQB//uSQ86O1voQiDHfflGmcJVIWtkcJJgE0xC7AEJ96QzRth2PRPiDO?=
 =?us-ascii?Q?2d5l0Z8n4qBlMTiWKHQKhaqQtd+QCpWwjPf45auOkpLqULONZ1hojbaRuFVO?=
 =?us-ascii?Q?PNQQnlfFgPBtzxqgaf8A/DfcC7YjSycbGz2UGyFl4ifV2keHf2Kv7uPA7NFq?=
 =?us-ascii?Q?nxyHDbmwvhgFIdDc60LMkxq8X1lyfA253OP+4xMPoaZ83qudu4B5JGLFKGx+?=
 =?us-ascii?Q?+oDKC9PHaXZJcX1+IbFbJSBGTv+eOw6VtKFGqeZK1dFFL7YvcWdP7ZC7T9zE?=
 =?us-ascii?Q?CXtYZq9/lCRH9hapkPAXAQEyap1w04s+hxYiNWZjdbaTb3pVzuPLAnws2Ugv?=
 =?us-ascii?Q?jOOZZVhbpFrHrSGPV2SSXdEwLQWQekUOB60w3wszEGIl9zu2H+tuLyzLcSO8?=
 =?us-ascii?Q?UJkN9I1WX/gN8+ei/iD9DE4LLQ5Tq86JWXNltnW+5R1DknM92Dl3/4t2kWKz?=
 =?us-ascii?Q?IDq3yCkEV9KnIZEGq4kTEJNyruUWpeHDILVnWUyNq01TjhYidmGashbvHNYp?=
 =?us-ascii?Q?MZx36FD4J9meFbBye9Alv9TH6LBJZX5LWfdeiT5b5b6me1nfU2Xm3P1CogJL?=
 =?us-ascii?Q?DPQc7Zkwe6zU+coennt4JBd1gwcam0XPLk2fGoruEI5J6vWL0+3CDp3BgMm/?=
 =?us-ascii?Q?zoWKaiBHpk+tpxDiQcZjykR8DduCBn2gb8dSFpYb+x6Fmy3M7qjpxK/qlIVw?=
 =?us-ascii?Q?7uDRzikooGlWW77h4G3Z2zdeBr73TIsjq2ph74PLdB9Egdsbuu694+uFpEr+?=
 =?us-ascii?Q?wMagFlg6Idqtg4Up93BKWXoM03BpvPqtl/TXUBkPs0j6hDsw2+XZ08UKYBZy?=
 =?us-ascii?Q?bEh9N57Sf67qYj7CE654bHrCYIyW1YI/WD6zxjE4t3vfJ278KVMexM1zuo5g?=
 =?us-ascii?Q?9ZzORmjIMP6aEHfFkFM2sWQmRBDK2iLETZdOSZFt13HDd/msX5yR7usOxdM0?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606e2529-1e30-42bf-ce09-08dab0befd1e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 04:12:36.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9oUkbtSLu/mnZpqiMoO5mNZhPO4hTN1SytDJFSU7+HM7x3xF+I8iA26jUinBQYpj4+FXrdmPIrrHFplw7UBgz30yphH1qLR4BIRaQ9slZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180022
X-Proofpoint-ORIG-GUID: Wej28yRvfJB63sqGzOKOsKimxwAjcCi-
X-Proofpoint-GUID: Wej28yRvfJB63sqGzOKOsKimxwAjcCi-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an inode is interested in events on its children, it must set
DCACHE_FSNOTIFY_PARENT_WATCHED flag on all its children. Currently, when
the fsnotify connector is removed and i_fsnotify_mask becomes zero, we
lazily allow __fsnotify_parent() to do this the next time we see an
event on a child.

However, if the list of children is very long (e.g., in the millions),
and lots of activity is occurring on the directory, then it's possible
for many CPUs to end up blocked on the inode spinlock in
__fsnotify_update_child_flags(). Each CPU will then redundantly iterate
over the very long list of children. This situation can cause soft
lockups.

To avoid this, stop lazily updating child flags in __fsnotify_parent().
Protect the child flag update with i_rwsem held exclusive, to ensure
that we only iterate over the child list when it's absolutely necessary,
and even then, only once.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:

It seems that there are two implementation options for this, regarding
what i_rwsem protects:

1. Both updates to i_fsnotify_mask, and the child dentry flags, or
2. Only updates to the child dentry flags

I wanted to do #1, but it got really tricky with fsnotify_put_mark(). We
don't want to hold the inode lock whenever we decrement the refcount,
but if we don't, then we're stuck holding a spinlock when the refcount
goes to zero, and we need to grab the inode rwsem to synchronize the
update to the child flags. I'm sure there's a way around this, but I
didn't keep going with it.

With #1, as currently implemented, we have the unfortunate effect of
that a mark can be added, can see that no update is required, and
return, despite the fact that the flag update is still in progress on a
different CPU/thread. From our discussion, that seems to be the current
status quo, but I wanted to explicitly point that out. If we want to
move to #1, it should be possible with some work.

 fs/notify/fsnotify.c | 12 ++++++++--
 fs/notify/mark.c     | 55 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..e887a195983b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -207,8 +207,16 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
-	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+	if (unlikely(parent_watched && !p_mask)) {
+		/*
+		 * Flag would be cleared soon by
+		 * __fsnotify_update_child_dentry_flags(), but as an
+		 * optimization, clear it now.
+		 */
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+		spin_unlock(&dentry->d_lock);
+	}
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..da9f944fcbbb 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -184,15 +184,36 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	struct inode *inode = NULL;
+	int watched_before, watched_after;
+
 	if (!conn)
 		return;
 
-	spin_lock(&conn->lock);
-	__fsnotify_recalc_mask(conn);
-	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
+		/*
+		 * For inodes, we may need to update flags on the child
+		 * dentries. To ensure these updates occur exactly once,
+		 * synchronize the recalculation with the inode mutex.
+		 */
+		inode = fsnotify_conn_inode(conn);
+		spin_lock(&conn->lock);
+		watched_before = fsnotify_inode_watches_children(inode);
+		__fsnotify_recalc_mask(conn);
+		watched_after = fsnotify_inode_watches_children(inode);
+		spin_unlock(&conn->lock);
+
+		inode_lock(inode);
+		if ((watched_before && !watched_after) ||
+		    (!watched_before && watched_after)) {
+			__fsnotify_update_child_dentry_flags(inode);
+		}
+		inode_unlock(inode);
+	} else {
+		spin_lock(&conn->lock);
+		__fsnotify_recalc_mask(conn);
+		spin_unlock(&conn->lock);
+	}
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
@@ -295,6 +316,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	struct fsnotify_mark_connector *conn = READ_ONCE(mark->connector);
 	void *objp = NULL;
 	unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
+	struct inode *inode = NULL;
+	int watched_before, watched_after;
 	bool free_conn = false;
 
 	/* Catch marks that were actually never attached to object */
@@ -311,17 +334,31 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	if (!refcount_dec_and_lock(&mark->refcnt, &conn->lock))
 		return;
 
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
+		inode = fsnotify_conn_inode(conn);
+		watched_before = fsnotify_inode_watches_children(inode);
+	}
+
 	hlist_del_init_rcu(&mark->obj_list);
 	if (hlist_empty(&conn->list)) {
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
+		watched_after = 0;
 	} else {
 		objp = __fsnotify_recalc_mask(conn);
 		type = conn->type;
+		watched_after = fsnotify_inode_watches_children(inode);
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
 
+	if (inode) {
+		inode_lock(inode);
+		if (watched_before && !watched_after)
+			__fsnotify_update_child_dentry_flags(inode);
+		inode_unlock(inode);
+	}
+
 	fsnotify_drop_object(type, objp);
 
 	if (free_conn) {
@@ -331,12 +368,6 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		spin_unlock(&destroy_lock);
 		queue_work(system_unbound_wq, &connector_reaper_work);
 	}
-	/*
-	 * Note that we didn't update flags telling whether inode cares about
-	 * what's happening with children. We update these flags from
-	 * __fsnotify_parent() lazily when next event happens on one of our
-	 * children.
-	 */
 	spin_lock(&destroy_lock);
 	list_add(&mark->g_list, &destroy_list);
 	spin_unlock(&destroy_lock);
-- 
2.34.1

