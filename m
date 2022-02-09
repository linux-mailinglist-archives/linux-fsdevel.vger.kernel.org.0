Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C44B0104
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiBIXOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:14:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiBIXOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:14:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F0CE00FA52;
        Wed,  9 Feb 2022 15:14:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KHRkH013515;
        Wed, 9 Feb 2022 23:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MDaJPMYx1J2RPymtQvDWDIW7V7lnUSXVpeOxhsEcfEI=;
 b=Pz/Aiy3MIGjyn2Av7NGUvrPBarpYziSp/7Q7uzz6IzGhLjLuP5nxWYAbL8YeL9FHIPAo
 NynsxsossNMIzqeBuMlcdG0IdZoadAtPPkzM9rbQUb0FqV8VsSMBujeNUmSlGQtiPIWW
 cs1NajTBNaUuUetfZbR45ggUoVILIxCiKlV58ZVV4IVv+3usLDMLhkXNPn7aFYLvPOvp
 cyY76l80CWoSFRKoc8bwyP4KS7AZJscD2N4s+br7HivrUPIfps9aB1Z7Uvt2xTapC908
 /hMhL+Vlp+QMbCdviMk3zI71M4kTltmuEWao2CvTNgE0VEBueqAeZwIQ2Ghq6iqKry3Y 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sr034-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NAAZ4141612;
        Wed, 9 Feb 2022 23:14:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3e1f9j6spa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKns04JMu1qUcSHZyG0OGCSGvW7YRhSnXYeIjk4nyMKp2HiuSzvg3K9qRt32QgpYhkFJxVrzrEDq8LjqMO0AhU3W6jDuQ7pwBPQWgxZBCmOjqC0jGtVQ4Ixq7YdV9FhaM32iH9NREwN1dRTyt5nUzcuLJuc9Mkwqfakwj8ArfI9gELdiZKBK0alPiJT7iK/m8b5QkhTOVYHHBQVuq0Rzr+Pooqwg0cK9pyyKhG6Iyaelv55R4+FysVoS9YyvRjq93YQh9hABm4Bsblh1WUOjQRBQlH4khsWMAGy63Ongc7Ahi8DYMQ6F6Wh5n8a4oOvhVDO4cYMmG8vT4+tssCOLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDaJPMYx1J2RPymtQvDWDIW7V7lnUSXVpeOxhsEcfEI=;
 b=isGndDwYvw02uyVDsKD1jtqazWUFWJSwtHJvksqriflTav4H1PdFtfZTp3t6OCcX1Vw89M9STvLXd9PDcwkTYH9Rq+GOT9vjA6Hb4VTUDoWtCts2ZxOtQGhuyHG7FGUJzSwDFAUeqbbBi3+4oaAHfOpG/Zu9IVIm4W6G4wz49/+fJlwrwh38YFSej9slIYB8pRKqNZHHcvk/eb3Cm/7nvKlxcHRIHxrOMF2xZXh68QR9YSdWB5VC5yc3Ndy35m82CTKctomCj0hWOeOwHlC5geEj2ztLk1JnZB2Lkq3mBxM5cFewFduUWvcN+uN/n11viKtNpCkXh9c7pYQChlV/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDaJPMYx1J2RPymtQvDWDIW7V7lnUSXVpeOxhsEcfEI=;
 b=COta/DC+0WL2/7TTQ27Gp5XQEqoJgIWemhM/2fvvL5pcDQ+NmwJZG4zTDjBQOpXtdIdir/DPoVJw/ojJUxBxnNNWfdn10uaLocUg2lEJAmNrxr4UTsG0HMFSbrbq9wKsOWcRqANWhQ+ET6sQw0VFzEooVCMixoXYl/HrzzHw15E=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 23:14:11 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 23:14:11 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 1/4] dcache: sweep cached negative dentries to the end of list of siblings
Date:   Wed,  9 Feb 2022 15:14:03 -0800
Message-Id: <20220209231406.187668-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:20::18) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e61368a-705c-4b0a-821b-08d9ec21e178
X-MS-TrafficTypeDiagnostic: BLAPR10MB4884:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4884E163DD03517593586E71DB2E9@BLAPR10MB4884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGEdAStFCuRmpZkvlJeQUPWx8LbHVsJuQi9oRCpFwd4So3674qvzLFTKZ33puxzJXHN34mrRW2yhRX2LUENLISYyLGvbeCGqerY3Dmxb236+Zs8vJcdOeNdduSpTtjUreKEN5FwhC5XvcCgTNuH7y/ungrDzgbu8xt9TpUMybFXT5H4/o4zThHR8EYAzdCGj7YE/xu0cd00koDCEOTO3TDZn/iSBLm6111QX+IQHf9laLkbXnNIL1KPJtHDO0w4TmTGS/C5czciEJu3eLl7GvygCfFbN0KJzj0IBmqZZ7+9PhA4DUQgVTxONMwNy6P0Y++9n+hvmU4ZIe3ojIH9ezKq8uD0MhHqJm6xmZScnkrjisgOOOaEg6nKldOwzCkmvutTZFjvek2YZCKpttT8TJb4m9An7KIiD7dZgXTFm9U4eUX5Hfdt9fg6zgKSFUqGdwN0gQoYy7ujTPllpY5ZaoiBJ4wEuyi9eZ+R6DQVhHzamoG8Af7rQs2/CIYvmKqw6V1sA2FvpkxQQFidwljyf+ZPRqR5gB5giKOgI+wFWLFzD3gu9GnPa41dbHdN7PsJOsvmlTNM1bdGW9IeiI/A2kaG6N0MjGmBtdBs/6Rp0Qh8qDQXdwQkvAOxQFGUm4tvxz4oWM+Kvr6bry9mXhrAGXOTcXM81GDqfIJ6hZtNt4VkYUFh87SddInY8GLJkwJvNx1OPzpzsXnuUa2g4P+NpUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(86362001)(52116002)(8676002)(6666004)(6506007)(8936002)(103116003)(66946007)(83380400001)(66556008)(508600001)(4326008)(2616005)(38100700002)(1076003)(186003)(26005)(54906003)(2906002)(5660300002)(6486002)(38350700002)(6916009)(36756003)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6LdJAB+YrcusCmKhLYPE/B6yHmcK9dwL1f7YphdJeexY+njyPu6al3ZjPG0?=
 =?us-ascii?Q?uaTFdqSghEbjUlbA2coJ1DuCwhs/HgVDqqEkDQVFvNFBeTTndKLOWnc5ZkA3?=
 =?us-ascii?Q?GYCl4qeb2lsgsr0VK20zP6wPD3bdum4gbguw9bKvGT7AiL25pW9BmP/NC8Gl?=
 =?us-ascii?Q?8SWaWy43ibY0gKMkHnffxumORr+9A01kOgUU70FfCTihzm7EMpbgSWMjtzDD?=
 =?us-ascii?Q?+T6/Fs1il37XOg8i4CbtrhfxcLn8gpfpUVTiil4toNli96LKVJAb0UJ5/Bvx?=
 =?us-ascii?Q?FtlxlhGHlL/vt0dTAcCh4Y/HzDxxyO0JOqIbr2gXzbIVy47EhCuu0x/gK5ON?=
 =?us-ascii?Q?7eNckSQ1uU7cuLZO+tJRUAmP/mKFvaBzIz+iw7z0an2lTBUwBhJEdKMGuVn7?=
 =?us-ascii?Q?Ao7r4kkgXhza5HbYTSJr7v86SoY/hvtRfdllV/AMkbGJMCPKVGGIybFncHB4?=
 =?us-ascii?Q?N+I5hEhTlCW2gSWPoTiAOYHy1JBalglht/BXnCsxQ3SRbMSdBAp0ox4tXjt/?=
 =?us-ascii?Q?yUyR4RojtVyJoJZnhJtnMKuftg/jKn8CRAl9zPYBV6eUtOK7T4HAfeNsld91?=
 =?us-ascii?Q?ybwlGByeESzo10sqzp4s5B5lnfbdbVWJmp0pXgyyKo0C7gqGbTVBSIwuqn75?=
 =?us-ascii?Q?77O9gulOeB/wBEIUaMYFVjvoPcmxSpp08r9MjTpl5Dm7JNgrPrguj/0ZD6Co?=
 =?us-ascii?Q?mxTndmktzr+JkDwHCAm3tFKlWPDAZpKJTXvWCLm11ElyR6QCbXCMLa2SCKhx?=
 =?us-ascii?Q?mYAnRMABfDKrWirs2Ru0tTCNFBMefOxoFtyLSl41TL9+URvdF45EkwgtsD7h?=
 =?us-ascii?Q?565QeU3ntz/KhHDjjOfAPFxkfAZgyIaiahhGiFb8LGf7a4rCeGbK8FjugX4M?=
 =?us-ascii?Q?5vheTdGQZgsUHyB2gB+uJNQglcczPwMzlbR+JSxidG7cYGDwVQ64cgk84gMS?=
 =?us-ascii?Q?aKW1D85P5pDRizpU1OWPl45TD5tCsOY5zPCrfFucotcvv+4G/kqvCbr8DdZ1?=
 =?us-ascii?Q?ORFpNd98AgBGVsD0rEEiSkzKyGae8Bdf3CnG2X97zNFtzJ8euh+940kM6RAP?=
 =?us-ascii?Q?25CusZcjMN6v6qmo8Q7ylBgUYsAI2b0IHcLyWhvZiqhSUTdQDRlXo9XOuh/R?=
 =?us-ascii?Q?4aes3ctbMut1KFHWeLKTJlZCo+KHbB5M+tYbTLOQFZqlqYmii3J/XW9d+bfR?=
 =?us-ascii?Q?5E4w4b31ywaEizQfS/GHjcw6JBMS/IHXNJsFMu5V+5BkD3WUkRG6CHXXnu+r?=
 =?us-ascii?Q?6ygldMdHiTw+VVzE0w2s/hTBDTTjsOTbNNJQ9cLINW6cLlWThSUyfhYUnfNE?=
 =?us-ascii?Q?fa2yXomZgmYcrzLhqFuETUPfqHe9V+lF49s6OlAef2/s8AQBe7ORVBKMuj8a?=
 =?us-ascii?Q?DFfTWqE5wNBegRXNKdMu6GSAcIXQ8ulT3q5LdCSVajjSDDy9dmTKka+XJ7LI?=
 =?us-ascii?Q?XijupIXEPzr9f8HmoTgMDaHbbH5so2iD3zRcFplFKuYnvefSwaV/bwBiYXiG?=
 =?us-ascii?Q?cnqv8JXUBrp1kytjUfUIvwzbTsm9va5brMA5NK+gNMcS9zDw6nMZB6TwhuE3?=
 =?us-ascii?Q?aNQY850PtJOx+Qc1p6MUk/D4s23fFoRoO0pCklwS6lVVq714lve9VMp6ey7F?=
 =?us-ascii?Q?ECgudvs11v0aN/1mc5+a7j9nUJDEp1ukbDkU8fs8XKibH7CJkku8waQnMSye?=
 =?us-ascii?Q?Dw6ahA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e61368a-705c-4b0a-821b-08d9ec21e178
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:14:11.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGi78ykHEDxhJhm554VqHGQDewRxbM1XbtasB9QD11oZ/nHk9bctOAHSeJ7tOsPnBWdt7sfX29ogLWNT77TxaiZcNYTe5vPzcnJOmQZYawc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=783 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090121
X-Proofpoint-GUID: MKfrETwLELtsFyA-ZRthyh_WxSJ-PWhB
X-Proofpoint-ORIG-GUID: MKfrETwLELtsFyA-ZRthyh_WxSJ-PWhB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For disk filesystems result of every negative lookup is cached, content
of directories is usually cached too. Production of negative dentries
isn't limited with disk speed. It's really easy to generate millions of
them if system has enough memory. Negative dentries are linked into
siblings list along with normal positive dentries. Some operations walks
dcache tree but looks only for positive dentries: most important is
fsnotify/inotify.

This patch sweeps negative dentries to the end of list at final dput()
and marks with flag which tells that all following dentries are negative
too. We do this carefully to avoid corruption in case the dentry is
killed when we try to lock its parent. Reverse operation (recycle) is
required before instantiating tail negative dentry, or calling d_add()
with non-NULL inode.

Co-authored-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Co-authored-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v2: Remove the sweep_negative() call in __d_add() when inode is NULL.

 fs/dcache.c            | 85 +++++++++++++++++++++++++++++++++++++++---
 include/linux/dcache.h |  6 +++
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..0960de9b9c36 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -660,6 +660,58 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	return __lock_parent(dentry);
 }
 
+/*
+ * Move cached negative dentry to the tail of parent->d_subdirs.
+ * This lets walkers skip them all together at first sight.
+ * Must be called at dput of negative dentry with d_lock held.
+ * Releases d_lock.
+ */
+static void sweep_negative(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	rcu_read_lock();
+	parent = lock_parent(dentry);
+	if (!parent) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/*
+	 * If we did not hold a reference to dentry (as in the case of dput),
+	 * and dentry->d_lock was dropped in lock_parent(), then we could now be
+	 * holding onto a dead dentry. Be careful to check d_count and unlock
+	 * before dropping RCU lock, otherwise we could corrupt freed memory.
+	 */
+	if (!d_count(dentry) && d_is_negative(dentry) &&
+		!d_is_tail_negative(dentry)) {
+		dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
+		list_move_tail(&dentry->d_child, &parent->d_subdirs);
+	}
+
+	spin_unlock(&parent->d_lock);
+	spin_unlock(&dentry->d_lock);
+	rcu_read_unlock();
+}
+
+/*
+ * Undo sweep_negative() and move to the head of parent->d_subdirs.
+ * Must be called before converting negative dentry into positive.
+ * Must hold dentry->d_lock, we may drop and re-grab it via lock_parent().
+ * Must be hold a reference or be otherwise sure the dentry cannot be killed.
+ */
+static void recycle_negative(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	parent = lock_parent(dentry);
+	dentry->d_flags &= ~DCACHE_TAIL_NEGATIVE;
+	if (parent) {
+		list_move(&dentry->d_child, &parent->d_subdirs);
+		spin_unlock(&parent->d_lock);
+	}
+}
+
 static inline bool retain_dentry(struct dentry *dentry)
 {
 	WARN_ON(d_in_lookup(dentry));
@@ -765,7 +817,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 static inline bool fast_dput(struct dentry *dentry)
 {
 	int ret;
-	unsigned int d_flags;
+	unsigned int d_flags, required;
 
 	/*
 	 * If we have a d_op->d_delete() operation, we sould not
@@ -813,6 +865,8 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * a 'delete' op, and it's referenced and already on
 	 * the LRU list.
 	 *
+	 * Cached negative dentry must be swept to the tail.
+	 *
 	 * NOTE! Since we aren't locked, these values are
 	 * not "stable". However, it is sufficient that at
 	 * some point after we dropped the reference the
@@ -830,11 +884,16 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
+
+	required = DCACHE_REFERENCED | DCACHE_LRU_LIST |
+		(d_flags_negative(d_flags) ? DCACHE_TAIL_NEGATIVE : 0);
+
 	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
-			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
+			DCACHE_DISCONNECTED | DCACHE_DONTCACHE |
+			DCACHE_TAIL_NEGATIVE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
-	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
+	if (d_flags == required && !d_unhashed(dentry))
 		return true;
 
 	/*
@@ -906,7 +965,10 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
-			spin_unlock(&dentry->d_lock);
+			if (d_is_negative(dentry) && !d_is_tail_negative(dentry))
+				sweep_negative(dentry); /* drops d_lock */
+			else
+				spin_unlock(&dentry->d_lock);
 			return;
 		}
 
@@ -1998,6 +2060,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	WARN_ON(d_in_lookup(dentry));
 
 	spin_lock(&dentry->d_lock);
+	if (d_is_tail_negative(dentry))
+		recycle_negative(dentry);
 	/*
 	 * Decrement negative dentry count if it was in the LRU list.
 	 */
@@ -2722,6 +2786,13 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	struct inode *dir = NULL;
 	unsigned n;
 	spin_lock(&dentry->d_lock);
+	/*
+	 * Tail negative dentries must become positive before associating an
+	 * inode. recycle_negative() is safe to use because we hold a reference
+	 * to dentry.
+	 */
+	if (inode && d_is_tail_negative(dentry))
+		recycle_negative(dentry);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
 		n = start_dir_add(dir);
@@ -2738,7 +2809,11 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	__d_rehash(dentry);
 	if (dir)
 		end_dir_add(dir, n);
-	spin_unlock(&dentry->d_lock);
+
+	if (!inode && !d_is_tail_negative(dentry))
+		sweep_negative(dentry); /* drops d_lock */
+	else
+		spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2..7cc1bd384912 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -211,6 +211,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_TAIL_NEGATIVE		0x80000000 /* All following siblings are negative */
 
 extern seqlock_t rename_lock;
 
@@ -489,6 +490,11 @@ static inline int simple_positive(const struct dentry *dentry)
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
 
+static inline bool d_is_tail_negative(const struct dentry *dentry)
+{
+	return unlikely(dentry->d_flags & DCACHE_TAIL_NEGATIVE);
+}
+
 extern void d_set_fallthru(struct dentry *dentry);
 
 static inline bool d_is_fallthru(const struct dentry *dentry)
-- 
2.30.2

