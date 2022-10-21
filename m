Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFEF606CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 03:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJUBD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 21:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJUBD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:03:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0526623081F;
        Thu, 20 Oct 2022 18:03:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0FYRC006828;
        Fri, 21 Oct 2022 01:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0WOghY6ZIKv7cRpCv/K161JkS/g/KW77oLuKKhjFVco=;
 b=kCj17FdMIR5X9rviZ17uymsC5B2TaDdXEZEDovFlEth8MXe1jhjv8hcWZ8QPRbYJC2cz
 672t2YqNQ/qHBamoj9BglMj7V09bZCkzXUrKy6PNK2WUrTMVc0HWw1YRV7nf26Ye8Nob
 KnfF7XlL/+pphsR8GEHE/Oes5xmkeGDlp13r5j8cUuLgSyp1EW8M4C6Pn5nLoMBeGAfW
 Jn/HwqnuHIICBXfFt8atWGFvhvDKMfxpV8T9gVw/voBQ+JPRMMROa2awM3WUGZeTdMiX
 vbmU3aVqEwmoZgpFPcOdh92E/s829g5KLikbYIBX7ZIwVUymR8D5FArnwoX84SdCU233 Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntk4n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KKxtHV017110;
        Fri, 21 Oct 2022 01:03:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8huacft0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 01:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsZTZHCP0xrNZvXeHwKOJZyI5GrghwUyjhHtmI0HFBSazY2sgm9JNcWsypauhBb/9I0vlCXWprUxR3KB6LZJJSH02bvsMYtoIQVNmEHdR8ERAdvaIRKwqg4d5G6eyfihnb5+DkHIw/FGkLXMTHziCm7bazo7/f6DOrnOn7McpuwC8hb+7luu/Vb9lAswgjnf2m6yDftaR+f9K1nbOI+nB55eEx7dKyrDWdWBJAzKBpTf2tS7sJBsZbouT5QhVjZx77OfFVHt3Ss2tG+7vSU1XAV21aOF5/WpRzPXIigiY4jU5wdLR+TxXUVzqQqRpuc77E1t5vQWQvR6cGLj53b4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WOghY6ZIKv7cRpCv/K161JkS/g/KW77oLuKKhjFVco=;
 b=MGaP/0IoCu27uNvvyk8athyr70/cN4UbPLtx5gnchFWNpFYshryApUi552dxdcchk2AtNfumBGcruRRaBtnb3xkw2Bq+gM8HKa0uYHN5kiWSXsQPJhS6KGpPRiHF7r/WE+RCFDUDizInRBdAHVN7QywvC03k3H36UM+wtNMyIWidAxEU4Grfesxpqb79QGI35Aksr9ggU1JMMIVD6fe0YYikQXF4ZGygIfbZxpCIhp6hEh9N7yl/sCHVHvKUNorXqQZMBs2e/cNYYQv/rWjajkXvbH+x2M6OXekVrWiWWwO+nSOJU5WnAYLcp0KDUsJSm1YiLv06mH5N6yomyTpiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WOghY6ZIKv7cRpCv/K161JkS/g/KW77oLuKKhjFVco=;
 b=siBR6jTbWtyI4go+4fyUo16hlcj+17ZT2Otlg3PJ23Iz7byMl7Soiz8VZU+BR5RlJEKAt3+3x5TCSvKocp0WlrQB9F/OIGlvULT9hBLzyP5cDYbaqx/M1/QEhc04hMfLdVif2YTPACrcoN1wEUKWui0nDnVUjzKYCnTiBzyXuxU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 01:03:17 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 01:03:17 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem
Date:   Thu, 20 Oct 2022 18:03:09 -0700
Message-Id: <20221021010310.29521-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::37) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0501ac-5b35-4aa3-e435-08dab30009dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmX0wShInbZFFaGo5vrWpNpuBPrhGX0A7ptPwlPYCqRn80AA4IvO5YlzAKeTMbbcT0agquW4D30IHwjYU8Gg7+PU33QXpyp6z5Z/KcZeJqxAdj9Q1N+0FpFcTsDw37CntXuF8W0TAw7PeBE9AZmfEqhaFJ2eV1P7pUi8PRpXHmLszgQzvJ+e6mvcTX+DBO5c91zXSpReoU8UF7jxmubN84OzXFb7NNNoUgSuG/zsUxCsZ6Ib0UfdyhmtcrwTyAJngw/6OJz/ytDo5bhoRbibHAzz8x0jET7YLNEiLAiAtqiRA5NYDHkQzbyaKRg4uB/QQtfiJko3+ScLOPbxO+IOnWQPCJzYhhbIl2t+smkXtXrySHWrGjxbn2Rsq6FlQbsviAYz/VdRO6sUJ7KgfZo9aw5fC3aEgGNCCI65G8C1bMXEQIugTeX1Pgs2M6PIsMclQ5dWk1n0JK5sHlkWbN32BQjFP/QQuH4EMDAPJfUAm7dOBTQA+XqEqOJ70wJDZotpx8d5FfHLMGMjMPEYpZ6oXcWcQlXFUF6uT5DXUadg+CDDqpFO8PAbtz4oRq9jufnKaqdK/pyMOdGLUWetgUV9iXwOnbC/1PkoUOJ513jrD3E8OxIUpEzb3Jupe7Jo93U4Bc5fM7U7ff9GqdFVUT9aM0lwfvlkLynZNxA/FkCQSwHhUealJottsZZDvYWOT3bkDVlsJZoEHPoKY2Qa4h1SvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6506007)(36756003)(86362001)(38100700002)(316002)(2906002)(83380400001)(103116003)(1076003)(110136005)(478600001)(107886003)(6666004)(26005)(186003)(6512007)(30864003)(8936002)(2616005)(66556008)(4326008)(66476007)(66946007)(5660300002)(8676002)(41300700001)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YWULr8ULvyPQYvVxYl1laLmMLqP5G7viEPMizsSSHW048PEJh7OlKbjQ0bGN?=
 =?us-ascii?Q?o98QDNw5Q5f64k5AUN0P9Vpl5x2F7UNxAs76yLleVFJfxdjRGmOAwjjDxXKF?=
 =?us-ascii?Q?9muq8bu9w8tU8KxOv+oMBO+UtIMq9IkV15NGKrXGkHODkqq/KAH00BBmJOLV?=
 =?us-ascii?Q?X6kQlxB11IsjEQmZ5bc9qY5AF/bdhlBGtiQWPPJs8h2R/wsR8V/H3rh2m3Wd?=
 =?us-ascii?Q?cUdX18GiUBmOl6q69T+srcUCfyDtcrg9mAysCmu+dfs78B7j+lOz3VW9Cxtt?=
 =?us-ascii?Q?4+K/gf8Hx2NkCK9Q9ad/V5ekYwjzJuY6QWIH2BLzljVyn1wzElvDdDzPL8cq?=
 =?us-ascii?Q?UzpgJq4D5WHVnynSMYm8n1Lk4vFIDp7aHGx1OvSoMumvgwGcXKncmNPLPOs5?=
 =?us-ascii?Q?Fa4LYxJ4GHR1eL3W7ob1jKdf0aZPhB6vFcLruq9nEnaPHnKhzGXf65IqzwYg?=
 =?us-ascii?Q?mbSgr8L7wQCvdG1yUnsh2PYAYs1xgzW673fCssMC8Xf/hnhD7sTRK/c7o2Wn?=
 =?us-ascii?Q?u91BV/hMVfp1MeffDgagR1MPhkG1iSI2Lu7IKen1oK7YoStpYbcnJs/41kFs?=
 =?us-ascii?Q?joJUNr4Ajp3JILkFByDc+A3dlyUL1LbXFSe9ip4S5B277HgtFTHR4U5IYKSp?=
 =?us-ascii?Q?PZZ5gyKzzAFbPrWvHJhtkYVXkFYt/lwCb6PMb8i8Tbln5Xifz1M15QYcUT0t?=
 =?us-ascii?Q?tBLoLlTxt+JEuEN2dmQwrMvbAvjCrcDrITI5q/SW8Oy+LzFJOMqGQZ4xhst7?=
 =?us-ascii?Q?36nAEbjPrIHCYtfYz7WKNpYDRg+CSQiQvywWQuiNaDzgAD1NY39c3lM43WbP?=
 =?us-ascii?Q?iivl34v1cSNHf11dyEa0DwCpXejbPX5OzeCD+54gG5Wt48+MdpNiA12rhezV?=
 =?us-ascii?Q?5j3lkWNDGtVMs/CpeB7nzIbtD21YExT8+uGBLyecGeL8rLd0tewF1BZ8TEkr?=
 =?us-ascii?Q?B5QMmjSxfdxd/zzML0zCd2SaRaBrttJpX1FrFiuv9M765+rHhuGlKLTC48ZM?=
 =?us-ascii?Q?56s+r7dbq0VIn0MNqptokLwHpwi8HhbNImhAAPXyS3U6CX6Ad4alH0Va+0tc?=
 =?us-ascii?Q?EYMisMPMgadUJM5Mri+HMiw5Dxw96ZXOWiHYeE4DrcoUd1Qi86WecRS8VUJC?=
 =?us-ascii?Q?fZ4Af4slNXT3gdnCo791GypQuBwy8Pu+EcLeMq43mSahxccvqNniye3zGUIb?=
 =?us-ascii?Q?OQngwaKjWD8OYQb8vcA2YgzvriW1wfprvjwqK8WpeNSBJF1VaDJXQ5k7Sbhq?=
 =?us-ascii?Q?0Rxs1grdR2h1AzTYK88EJqXtbTA8xzyVoH4POw4WpDlQ7hV13d+gWHm6SNdT?=
 =?us-ascii?Q?WXQygVhjP/Y4fwjKzvR23XBp+wNnbrzHhkjnth2xuZV0tL0ESe0aGjkk+i1G?=
 =?us-ascii?Q?BAd3lieTsU7M0YRV5vZmeNr+CxSnKK2ialNojJMcSYStULb/67IdspegJIC7?=
 =?us-ascii?Q?AdvBpV/Qr96btpk3mH7/ECD4cSaIb2/FRK/6se1DGutpEANxDHNQ7YOm3mBd?=
 =?us-ascii?Q?EXzpMJcbKjHj9pwx7pL2+sxqaUiFnkYAaLksl2jpNeNvPtftUoMEykq3+DYA?=
 =?us-ascii?Q?JiPAXqTJunlzxsoyqZf6oyfZWYJoLHylXcrdX03glog94BJx0h1hMyqfRSkm?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0501ac-5b35-4aa3-e435-08dab30009dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 01:03:17.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhnZeaAPuz3z+tAugMulBRKyvmTkrUxXLp3vvZ9gXMb/6obv7TMwYIUfVhXVjnUeuFImKHdlICPI59CgQYy41Yu1NR9jaWjF8o1UdNyI7I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210004
X-Proofpoint-ORIG-GUID: Soumt0Sm6JGvDplm3v264gPdykMAnNyu
X-Proofpoint-GUID: Soumt0Sm6JGvDplm3v264gPdykMAnNyu
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
Instead, update flags when we disconnect a mark connector. Remember the
state of the children flags in the fsnotify_mark_connector flags.
Provide mutual exclusion by holding i_rwsem exclusive while we update
children, and use the cached state to avoid updating flags
unnecessarily.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

 fs/notify/fsnotify.c             |  22 ++++++-
 fs/notify/fsnotify.h             |  31 ++++++++-
 fs/notify/mark.c                 | 106 ++++++++++++++++++++-----------
 include/linux/fsnotify_backend.h |   8 +++
 4 files changed, 127 insertions(+), 40 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 6c338322f0c3..f83eca4fb841 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,13 +103,15 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+bool __fsnotify_update_children_dentry_flags(struct inode *inode)
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
@@ -133,6 +135,20 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 		spin_unlock(&child->d_lock);
 	}
 	spin_unlock(&alias->d_lock);
+	return watched;
+}
+
+void __fsnotify_update_child_dentry_flags(struct inode *inode, struct dentry *dentry)
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
@@ -203,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	p_inode = parent->d_inode;
 	p_mask = fsnotify_inode_watches_children(p_inode);
 	if (unlikely(parent_watched && !p_mask))
-		__fsnotify_update_child_dentry_flags(p_inode);
+		__fsnotify_update_child_dentry_flags(p_inode, dentry);
 
 	/*
 	 * Include parent/name in notification either if some notification
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index fde74eb333cc..182d93014c6b 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -70,11 +70,40 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 	fsnotify_destroy_marks(&sb->s_fsnotify_marks);
 }
 
+static inline bool fsnotify_children_need_update(struct fsnotify_mark_connector *conn,
+                                                 struct inode *inode)
+{
+	bool watched, flags_set;
+	watched = fsnotify_inode_watches_children(inode);
+	flags_set = conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
+	return (watched && !flags_set) || (!watched && flags_set);
+}
+
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern bool __fsnotify_update_children_dentry_flags(struct inode *inode);
+
+static inline void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
+                                                         struct inode *inode)
+{
+	bool need_update;
+	inode_lock(inode);
+	spin_lock(&conn->lock);
+	need_update = fsnotify_children_need_update(conn, inode);
+	spin_unlock(&conn->lock);
+	if (need_update) {
+		bool watched = __fsnotify_update_children_dentry_flags(inode);
+		spin_lock(&conn->lock);
+		if (watched)
+			conn->flags |= FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
+		else
+			conn->flags &= ~FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
+		spin_unlock(&conn->lock);
+	}
+	inode_unlock(inode);
+}
 
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..ecfd355a93f2 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -130,30 +130,39 @@ static void fsnotify_get_inode_ref(struct inode *inode)
  * iput() outside of spinlocks. This happens when last mark that wanted iref is
  * detached.
  */
-static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
-					  bool want_iref)
+static struct inode *fsnotify_update_inode_conn_flags(struct fsnotify_mark_connector *conn,
+						      bool want_iref, int *flags)
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
+			*flags |= FSNOTIFY_OBJ_FLAG_NEED_IPUT;
+		}
+	}
+	if (fsnotify_children_need_update(conn, inode)) {
+		ret = inode;
+		*flags |= FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN;
 	}
 
-	return inode;
+	return ret;
 }
 
-static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
+static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn,
+                                    int *flags)
 {
 	u32 new_mask = 0;
 	bool want_iref = false;
@@ -173,7 +182,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
 
-	return fsnotify_update_iref(conn, want_iref);
+	return fsnotify_update_inode_conn_flags(conn, want_iref, flags);
 }
 
 /*
@@ -184,15 +193,19 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
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
+	if (flags & FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN)
+		fsnotify_update_children_dentry_flags(conn, inode);
+	WARN_ON_ONCE(flags & FSNOTIFY_OBJ_FLAG_NEED_IPUT);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
@@ -240,7 +253,8 @@ static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
 
 static void *fsnotify_detach_connector_from_object(
 					struct fsnotify_mark_connector *conn,
-					unsigned int *type)
+					unsigned int *type,
+					unsigned int *flags)
 {
 	struct inode *inode = NULL;
 
@@ -252,8 +266,11 @@ static void *fsnotify_detach_connector_from_object(
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
 
-		/* Unpin inode when detaching from connector */
-		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
+		if (conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN)
+			*flags |= FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN;
+		if (conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF)
+			*flags |= ~FSNOTIFY_OBJ_FLAG_NEED_IPUT;
+		if (!*flags)
 			inode = NULL;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
@@ -280,14 +297,35 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
 }
 
 /* Drop object reference originally held by a connector */
-static void fsnotify_drop_object(unsigned int type, void *objp)
+static void fsnotify_drop_object(struct fsnotify_mark_connector *conn,
+                                 unsigned int type, void *objp, int flags)
 {
 	if (!objp)
 		return;
 	/* Currently only inode references are passed to be dropped */
 	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
 		return;
-	fsnotify_put_inode_ref(objp);
+
+	if (flags & FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN)
+		/*
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
+	if (flags & FSNOTIFY_OBJ_FLAG_NEED_IPUT)
+		fsnotify_put_inode_ref(objp);
 }
 
 void fsnotify_put_mark(struct fsnotify_mark *mark)
@@ -296,6 +334,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 	void *objp = NULL;
 	unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
 	bool free_conn = false;
+	int flags = 0;
 
 	/* Catch marks that were actually never attached to object */
 	if (!conn) {
@@ -313,16 +352,16 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 
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
+	fsnotify_drop_object(conn, type, objp, flags);
 
 	if (free_conn) {
 		spin_lock(&destroy_lock);
@@ -331,12 +370,6 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
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
@@ -834,6 +867,7 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	struct fsnotify_mark *mark, *old_mark = NULL;
 	void *objp;
 	unsigned int type;
+	int flags = 0;
 
 	conn = fsnotify_grab_connector(connp);
 	if (!conn)
@@ -859,11 +893,11 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	 * mark references get dropped. It would lead to strange results such
 	 * as delaying inode deletion or blocking unmount.
 	 */
-	objp = fsnotify_detach_connector_from_object(conn, &type);
+	objp = fsnotify_detach_connector_from_object(conn, &type, &flags);
 	spin_unlock(&conn->lock);
 	if (old_mark)
 		fsnotify_put_mark(old_mark);
-	fsnotify_drop_object(type, objp);
+	fsnotify_drop_object(conn, type, objp, flags);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d7d96c806bff..942fbcc34286 100644
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
@@ -485,6 +486,13 @@ struct fsnotify_mark_connector {
 	struct hlist_head list;
 };
 
+/*
+ * Objects may need some additional actions to be taken when the last reference
+ * is dropped. Define flags to indicate which actions are necessary.
+ */
+#define FSNOTIFY_OBJ_FLAG_NEED_IPUT		0x01
+#define FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN	0x02
+
 /*
  * A mark is simply an object attached to an in core inode which allows an
  * fsnotify listener to indicate they are either no longer interested in events
-- 
2.34.1

