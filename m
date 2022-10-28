Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25B76106B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiJ1AKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 20:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiJ1AKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:10:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DF33ED6A;
        Thu, 27 Oct 2022 17:10:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMOJIh007722;
        Fri, 28 Oct 2022 00:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pStEeV/8oUEZKkb5r4ne5L2BPTh6o3Ej2omKROBzmdw=;
 b=NHw+qPYqEBGI1V8ki5IX/hkJfQWp+bWiCYROGbCsBQ/P8VuZOHoJc/Zl9hzahajJN3Pv
 taCOXIz3XvW5HPPIreNRHK5bIyXitDQQpOA2fCgQWqoq5LlCSTL0vqMQbEnE5U5Rl33o
 ytB9to0SqVutM7gxLK7qElKjWVAgFtC8HYL0gnxta7RdupjB6iivDcePxw18L/K0b9eB
 dQnJLmr6McxNBDDD5n629rBLTOXCWUGMrdsN9wYFd5kjcfODr9t4CWqiETpI12hMFycT
 FQIySxuuNTyT2PMRYyWXauP8sTM+HDkRaccSRVRXE6gGdxUP7QFPlaWjlRV7SMsk+wKL 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0akq5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLahii026367;
        Fri, 28 Oct 2022 00:10:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqj1vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLTp4PSQs5hENakqA6QSpbziD6X1ZR24T23Gwinh40QsBEBYfKMbgsRsHa73UvyLaH1Few7NCH8ywTi0qWb6Kdk1+/gCmPeHiwklwaNfhBL07hEXmJX/uHCfosdmOQf/OHf4lclDJp3Gu9lAs24bVJQS+jSG0n9bJPZ79tvAbXi932U4eEEJS0GEoUp10DDRwH7pLcuSGAUiLSkGddaJ4fIQMDwcqlxSKYKMSxSIZl2nJrpPy99qaulx/qSDSw+gfKE5IuYflqlgJe8q8olUN+2Voc8foWFZBx8oISyBP6azJKQ5mi/3zfk4AXb+yxWEEjEU9px907lDSPblsWn/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pStEeV/8oUEZKkb5r4ne5L2BPTh6o3Ej2omKROBzmdw=;
 b=dHxZCxJu9yEqRDS5JGV2Klow7KpPug972CN36Ub24UVg2sqtA8lbnUA1369A5e41D4YK6qvGLMVwxvZe6E4myBm/zxObrI3iSyzN/sAOkF2+jKxnZ1fmbcnFg69bve5OeH5WCq88dadkS04cpKMedPUtb4Cqw1DQ4m/+Y75KvyJA48MD9sfSYwJ1cCAnExJxjeUx0QFk2n8uU0jM2fpeemGHtORBz2M/u0//K7+aSzmLl/FVyDJMWC+dYrx1fgGJe0ZwFwEG6vBasYgx/oCYDpbvE0iISdAnLo7GdUEEPZNDLmE1aifLCAmsVsmqMpOYsY0zV8VlovEdfUcR52O2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pStEeV/8oUEZKkb5r4ne5L2BPTh6o3Ej2omKROBzmdw=;
 b=Uv+qu7BeDo1AcyiYdzlqIn98q8xRCzjSMg1Wg0roUSfXwdPz/1Sl1DiOUVQeAMisvk8EumzI9Cx8q2cbJ7QDQwfL36oilAAyB35vM423yBJBkZnkn7GJJywYDZxdfPNawVF2iE+0bIvAtMdIRBVWvyTfwz/5nNgrOH0g1QETe+g=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 00:10:24 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 00:10:24 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 2/3] fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
Date:   Thu, 27 Oct 2022 17:10:15 -0700
Message-Id: <20221028001016.332663-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0115.namprd11.prod.outlook.com
 (2603:10b6:806:d1::30) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a810bb-b9b2-4adb-d782-08dab878cf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWWF/QdFtUSJofGz+WTpc1W2ANRPeutZ6m8ZWtXArq9gw5k4RXmydKrBgW5P5N2qAH59IKp68d0D02NSujrU0Wm2MShIYbD+9gHCoRq23zTxcEFZCxXh9O5aQsVDvufErzg6XP9rNP5CP8YybBzRBE4weCyCTf4AkCgtvmWs+LsKYOIRghDMmwVlOa41ahVGXWgkSRrVN+z6NLnYo3wIK15XJMMl/NcewjJGl/M75vKZ/aSd5asd5XEjlVaBUX80byUOrc3y0MwrS+SbxdoQOkLU9R2w9t1IvrMTGnrd2CuSN4mu+h0OlzEXJ8L1M76m2Wg+sL8MkVy39aHy7AQXxmfsugo/wQeIpXPGITUrTmleFgLQHCEkQl1YJIHm/ZEZ1olyuGnnsjMuqCqdc2nJ9FvAVt5xc5h6C66b8TswivWw31+9Ul1dfyEp//W0Wp+aqnJDDRziPVJLxn79aqr3j4+entN+OiD8tuaEknkpXbJq0IZ1DygUjpytVffEKoLJlGfHOt/HcXV78DJkexYZ/QkB9Op+j16JmWFWaHQeykIeO31cj51YL64V3EJyPbQAC/j3CNSykJkWBjBIWVhYRWZnUFlob9z3w3GTSPza0OJxFLIaq16Apsb2d5schUTO4n9dq5q+9R8jmnWDbn5BxKpAstBwgyQy5rM0asokyXHWJFh3FDLkOkt4rWPv9/PuDhAzSJO+p5jcVu03AMbNWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(83380400001)(103116003)(36756003)(6486002)(107886003)(6666004)(478600001)(5660300002)(66946007)(4326008)(8676002)(66476007)(8936002)(66556008)(41300700001)(30864003)(54906003)(6916009)(316002)(6506007)(1076003)(2616005)(38100700002)(186003)(6512007)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/eyNIyc0HzaN1lFlL7A6ZKiVqIWzyCr9lzw0F807fROfdDrQOI0S+t7VwvFH?=
 =?us-ascii?Q?EgbAav+/OxHJ0r+9QH74f9Qh/KpGabc9LOp/F0WAWqymEIxDUgeuo41coMgV?=
 =?us-ascii?Q?vVAnLjWPcQC9CfCEt4x46A/9A5dAy2cn9XANZlYw4dsdYw8lJdm6A671nXvc?=
 =?us-ascii?Q?O7mYTuZraOHD12fpalRKNYyykomQ8sKkeYwizBYoGw/9wIwgvDTngMO77IuJ?=
 =?us-ascii?Q?3VNY1moPhOPvuMD1+EJH4fPorodo4GjUQMOv9V1eqfFSwWiBBqz2HAQjfUEY?=
 =?us-ascii?Q?fKLl1P7S/v/IbxTTpkS+BJi2i5XGLumdFXoAYI26SO02i38dUrVPVWY6kVpp?=
 =?us-ascii?Q?jcW1GQ2NPh1PMj5OyLmmuVKlKaDuEzPZzMe0P/jnANJAuF2hPEh2+r0FLnBJ?=
 =?us-ascii?Q?GAgAEoBzPrubkrvRx8/ZMZt0Bjt2Rg5ihn9q0RxHIq9TCp+xBzhmiuF6MoOP?=
 =?us-ascii?Q?eAXXGy+AKQ7aZDiw2LHvhv2K/uKacaDZ1HFK3NwDmdZbp80QwvoFaiLtdrqz?=
 =?us-ascii?Q?lCN03zz+LJTx8mhtZVjpVZmKM9repBo7FpD5xMFECqLAnk4efr45OZRzw5/G?=
 =?us-ascii?Q?Gt43OR1B4EFIgZdqvcYzNWtdk/bIBHocBDRTfhbMvykWh4k9UDu4wIrKo7Dc?=
 =?us-ascii?Q?MPWm2L70FHa9F8/Nf/5ACN/k5wDjRdXfDQ2IL7HTSNxDtlOb7ne0WuW18JYD?=
 =?us-ascii?Q?D3frI6UQmz7cnmSBrIJG1UuoU5iedj5i0oNOOCD9c324L9YiowM1rEMr76ek?=
 =?us-ascii?Q?AH814ma0RnDppv9omrhVFWxMVql5AM3yANvaoEs0NCC9dK7+1JoyWEeOmZ71?=
 =?us-ascii?Q?E5cgKFnjibNF3dxwC1Sh0f5C3xJRMrRVCAnMcbLhI9wwMfSoySabBjHO8VZR?=
 =?us-ascii?Q?fNgx//ZaGiqigo3tLeOOst65MXQknPPZDGQq2mT9bhMMycnPVBTrSBvbkc5s?=
 =?us-ascii?Q?GnvaxYTsGJBC6SP1+PCxG/ENeUsvCz+qyVzn3YISRJUrL6546XS6uCcvKUMH?=
 =?us-ascii?Q?VGkUcLMnTHzBSZIlT1kELg9lfHtQZ3r/Nd+nH1wesl+RzqkDhvWdUOeN2HMB?=
 =?us-ascii?Q?2i3iFSuO1S0U5sl/1oxi7k8l3ZwodoaRhzFMNDS7zy71YV/cCl8Wzi+9ZPwq?=
 =?us-ascii?Q?pfQd7m27rsbOXyv/vHQ6PSJvxNgd20koKHsiun/0eY4YOoXI+3AKXY51avS0?=
 =?us-ascii?Q?DKmmHANXvf7hnul9Hs3tebYpsYl/KoJa7FqfP240N6UxuQAFmc2Ha+1eM2y7?=
 =?us-ascii?Q?mIvIgtY4quwHGAPjwPfttqUfTfS+wW2auGEPC9BXK9+SR3Csdqdkk2HfZgJ/?=
 =?us-ascii?Q?yrwz4agozDxQVcUcLehytEXImXgu8VwJrUSpQyub3isRBLePA53YnlakC8dc?=
 =?us-ascii?Q?hFZ2TauGEZGeICUtAF+jOTQNJbk9B60JeuCPY1lkr2N0YhmelwXl4jYOVt3l?=
 =?us-ascii?Q?3yH1VnnbxC9Qp5igecp21AGNkIZasrDvo6NnusfHEcoNyL7E1E8SBxV4sHXX?=
 =?us-ascii?Q?TvyLd1J6e08t5VhYGeubspEd9dmYPBMp+Hq1E8KnV4fJljKkcD7AG1j2Naxp?=
 =?us-ascii?Q?FsZ9eC/qUZMo1ITyDGWet36qVSDYHWFKFZV5NNUoIECvrUD12HEAyvJowcmX?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a810bb-b9b2-4adb-d782-08dab878cf38
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 00:10:23.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6qgmTFtGXWWfGY4baW5Fc20K8axBrPpXvKGMgf1RcoDxPsY0nIbRhES6c0JbZC/Z1VhLBgqMt3gekevZ0xoSpHnNIcZZAkOOY5IRVp2hfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270138
X-Proofpoint-GUID: BJVvorZks6FPWNuJz09jMYmbuWr1H93E
X-Proofpoint-ORIG-GUID: BJVvorZks6FPWNuJz09jMYmbuWr1H93E
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
    v3 changes:
    
    * Moved fsnotify_update_children_dentry_flags() into fsnotify.c,
      declared it in the header. Made
      __fsnotify_update_children_dentry_flags() static since it has no
      external callers except fsnotify_update...().
    * Use bitwise xor operator in children_need_update()
    * Eliminated FSNOTIFY_OBJ_FLAG_* constants, reused CONN_FLAG_*
    * Updated documentation of fsnotify_update_inode_conn_flags() to
      reflect its behavior
    * Renamed "flags" to "update_flags" in all its uses, so that it's a
      clear pattern and matches renamed fsnotify_update_object().

 fs/notify/fsnotify.c             |  45 ++++++++++-
 fs/notify/fsnotify.h             |  13 +++-
 fs/notify/mark.c                 | 124 ++++++++++++++++++++-----------
 include/linux/fsnotify_backend.h |   1 +
 4 files changed, 137 insertions(+), 46 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7939aa911931..ccb8a3a6c522 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,13 +103,15 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
 {
 	struct dentry *alias, *child;
 	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
-		return;
+		return false;
+
+	lockdep_assert_held_write(&inode->i_rwsem);
 
 	/* determine if the children should tell inode about their events */
 	watched = fsnotify_inode_watches_children(inode);
@@ -136,6 +138,43 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	}
 	spin_unlock(&alias->d_lock);
 	dput(alias);
+	return watched;
+}
+
+void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
+					   struct inode *inode)
+{
+	bool need_update;
+
+	inode_lock(inode);
+	spin_lock(&conn->lock);
+	need_update = fsnotify_children_need_update(conn, inode);
+	spin_unlock(&conn->lock);
+	if (need_update) {
+		bool watched = __fsnotify_update_children_dentry_flags(inode);
+
+		spin_lock(&conn->lock);
+		if (watched)
+			conn->flags |= FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
+		else
+			conn->flags &= ~FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
+		spin_unlock(&conn->lock);
+	}
+	inode_unlock(inode);
+}
+
+
+static void fsnotify_update_child_dentry_flags(struct inode *inode, struct dentry *dentry)
+{
+	/*
+	 * Flag would be cleared soon by
+	 * __fsnotify_update_child_dentry_flags(), but as an
+	 * optimization, clear it now.
+	 */
+	spin_lock(&dentry->d_lock);
+	if (!fsnotify_inode_watches_children(inode))
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+	spin_unlock(&dentry->d_lock);
 }
 
 /* Are inode/sb/mount interested in parent and name info with this event? */
@@ -206,7 +245,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
 	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+		fsnotify_update_child_dentry_flags(p_inode, dentry);
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc..621e78a6f0fb 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -70,11 +70,22 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
 }
 
+static inline bool fsnotify_children_need_update(struct fsnotify_mark_connector *conn,
+						 struct inode *inode)
+{
+	bool watched, flags_set;
+
+	watched = fsnotify_inode_watches_children(inode);
+	flags_set = conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
+	return watched ^ flags_set;
+}
+
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
+						  struct inode *inode);
 
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..8969128dacc1 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -123,37 +123,52 @@ static void fsnotify_get_inode_ref(struct inode *inode)
 }
 
 /*
- * Grab or drop inode reference for the connector if needed.
+ * Determine the connector flags that it is necessary to update
  *
- * When it's time to drop the reference, we only clear the HAS_IREF flag and
- * return the inode object. fsnotify_drop_object() will be resonsible for doing
- * iput() outside of spinlocks. This happens when last mark that wanted iref is
- * detached.
+ * If any action needs to be taken on the connector's inode outside of a spinlock,
+ * we return the inode and set *update_flags accordingly.
+ *
+ * If FSNOTIFY_CONN_FLAG_HAS_IREF is set in *update_flags, then the caller needs
+ * to drop the last inode reference using fsnotify_put_inode_ref().
+ *
+ * If FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN is set in *update_flags, then the
+ * caller needs to update the children dentry flags so that their
+ * DCACHE_FSNOTIFY_PARENT_WATCHED flag matches the i_fsnotify_mask value, using
+ * fsnotify_update_children_dentry_flags().
  */
-static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
-					  bool want_iref)
+static struct inode *fsnotify_update_inode_conn_flags(struct fsnotify_mark_connector *conn,
+						      bool want_iref, int *update_flags)
 {
 	bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
-	struct inode *inode = NULL;
+	struct inode *inode = NULL, *ret = NULL;
 
-	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE ||
-	    want_iref == has_iref)
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
 		return NULL;
 
-	if (want_iref) {
-		/* Pin inode if any mark wants inode refcount held */
-		fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
-		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
-	} else {
-		/* Unpin inode after detach of last mark that wanted iref */
-		inode = fsnotify_conn_inode(conn);
-		conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
+	inode = fsnotify_conn_inode(conn);
+
+	if (want_iref != has_iref) {
+		if (want_iref) {
+			/* Pin inode if any mark wants inode refcount held */
+			fsnotify_get_inode_ref(inode);
+			conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
+		} else {
+			/* Unpin inode after detach of last mark that wanted iref */
+			conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
+			ret = inode;
+			*update_flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
+		}
+	}
+	if (fsnotify_children_need_update(conn, inode)) {
+		ret = inode;
+		*update_flags |= FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
 	}
 
-	return inode;
+	return ret;
 }
 
-static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
+static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn,
+				    int *update_flags)
 {
 	u32 new_mask = 0;
 	bool want_iref = false;
@@ -173,7 +188,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
 
-	return fsnotify_update_iref(conn, want_iref);
+	return fsnotify_update_inode_conn_flags(conn, want_iref, update_flags);
 }
 
 /*
@@ -184,15 +199,19 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	struct inode *inode = NULL;
+	int flags = 0;
+
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
-	__fsnotify_recalc_mask(conn);
+	inode = __fsnotify_recalc_mask(conn, &flags);
 	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+
+	if (flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN)
+		fsnotify_update_children_dentry_flags(conn, inode);
+	WARN_ON_ONCE(flags & FSNOTIFY_CONN_FLAG_HAS_IREF);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
@@ -240,7 +259,8 @@ static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
 
 static void *fsnotify_detach_connector_from_object(
 					struct fsnotify_mark_connector *conn,
-					unsigned int *type)
+					unsigned int *type,
+					unsigned int *update_flags)
 {
 	struct inode *inode = NULL;
 
@@ -252,8 +272,10 @@ static void *fsnotify_detach_connector_from_object(
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
 
-		/* Unpin inode when detaching from connector */
-		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
+		*update_flags = conn->flags &
+			(FSNOTIFY_CONN_FLAG_HAS_IREF |
+			 FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN);
+		if (!*update_flags)
 			inode = NULL;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
@@ -279,15 +301,37 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
 	fsnotify_put_group(group);
 }
 
-/* Drop object reference originally held by a connector */
-static void fsnotify_drop_object(unsigned int type, void *objp)
+/* Apply the update_flags for a connector after recalculating mask */
+static void fsnotify_update_object(struct fsnotify_mark_connector *conn,
+				   unsigned int type, void *objp,
+				   int update_flags)
 {
 	if (!objp)
 		return;
 	/* Currently only inode references are passed to be dropped */
 	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
 		return;
-	fsnotify_put_inode_ref(objp);
+
+	if (update_flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN)
+		/*.
+		 * At this point, we've already detached the connector from the
+		 * inode. It's entirely possible that another connector has been
+		 * attached, and that connector would assume that the children's
+		 * flags are all clear. There are two possibilities:
+		 * (a) The connector has not yet attached a mark that watches its
+		 * children. In this case, we will properly clear out the flags,
+		 * and the connector's flags will be consistent with the
+		 * children.
+		 * (b) The connector attaches a mark that watches its children.
+		 * It may have even already altered i_fsnotify_mask and/or
+		 * altered the child dentry flags. In this case, our call here
+		 * will read the correct value of i_fsnotify_mask and apply it
+		 * to the children, which duplicates some work, but isn't
+		 * harmful.
+		 */
+		fsnotify_update_children_dentry_flags(conn, objp);
+	if (update_flags & FSNOTIFY_CONN_FLAG_HAS_IREF)
+		fsnotify_put_inode_ref(objp);
 }
 
 void fsnotify_put_mark(struct fsnotify_mark *mark)
@@ -296,6 +340,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	void *objp = NULL;
 	unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
 	bool free_conn = false;
+	int flags = 0;
 
 	/* Catch marks that were actually never attached to object */
 	if (!conn) {
@@ -313,16 +358,16 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 
 	hlist_del_init_rcu(&mark->obj_list);
 	if (hlist_empty(&conn->list)) {
-		objp = fsnotify_detach_connector_from_object(conn, &type);
+		objp = fsnotify_detach_connector_from_object(conn, &type, &flags);
 		free_conn = true;
 	} else {
-		objp = __fsnotify_recalc_mask(conn);
+		objp = __fsnotify_recalc_mask(conn, &flags);
 		type = conn->type;
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
 
-	fsnotify_drop_object(type, objp);
+	fsnotify_update_object(conn, type, objp, flags);
 
 	if (free_conn) {
 		spin_lock(&destroy_lock);
@@ -331,12 +376,6 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
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
@@ -834,6 +873,7 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	struct fsnotify_mark *mark, *old_mark = NULL;
 	void *objp;
 	unsigned int type;
+	int update_flags = 0;
 
 	conn = fsnotify_grab_connector(connp);
 	if (!conn)
@@ -859,11 +899,11 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	 * mark references get dropped. It would lead to strange results such
 	 * as delaying inode deletion or blocking unmount.
 	 */
-	objp = fsnotify_detach_connector_from_object(conn, &type);
+	objp = fsnotify_detach_connector_from_object(conn, &type, &update_flags);
 	spin_unlock(&conn->lock);
 	if (old_mark)
 		fsnotify_put_mark(old_mark);
-	fsnotify_drop_object(type, objp);
+	fsnotify_update_object(conn, type, objp, update_flags);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d7d96c806bff..7b8d1cdac0ce 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -474,6 +474,7 @@ struct fsnotify_mark_connector {
 	unsigned short type;	/* Type of object [lock] */
 #define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
+#define FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN	0x04
 	unsigned short flags;	/* flags [lock] */
 	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
-- 
2.34.1

