Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66D4B010B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 00:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiBIXOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 18:14:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiBIXO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:14:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FFEE050B81;
        Wed,  9 Feb 2022 15:14:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KYQum020178;
        Wed, 9 Feb 2022 23:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ejzW0VqgQdVY08sCESJZErpFCOudvGY9O+7ETievUYY=;
 b=orttwnEgjYH7p6Az1IvNTU61x4nQ4j1NR6J5Q/meTrOnqN5FyBh9IVOrIWoqmlrWiwHw
 YYhvlxy0fMzBy6w1JwRA7JFMbYA9dnIT0w87veDTNc/IG/2RSkI9ft6iDKtV7FR+V69d
 2VYuSsy4ojMuaCojP210e2xO2ZSbTDZK9ySoFj9zRJX8w8vVHcLRrcJpGm35dHFXbWKO
 Onwxo0CYgaWVzLzqEbBS5CQvJFm+EjjFppxRsWKnVbYmwKVmlHM1epAE/wdCJBRZp1fK
 OXDbzkALLifSXqwXUVQLxhmJyINl+X21X2RR6/HkqliiomcOiyoNsu52H5FAivYMKThH 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wybq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NAQr7039265;
        Wed, 9 Feb 2022 23:14:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3e1jptxr01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iotmn/2fo/RFlhI0IY7w+mQJ1SawUzErwear5UcIBxhppVuCdinNroxdMWowsK+ZxzmcQdZpwZL6oqVKhPr/9jbqGY7uLqMUDlz+AAHPW3PhRksHMnHvJ8xf0npkM29qQaktMThE12k9GnlKMpAlyK3/ARrZ+zf7p4e02aCoDVTvbkKHRQQvRcZAFbV1kGL6HkFChoE52z5RnryzPj0xocdzYDCfcz2/dI+q4JYX+V4RzKlqavYCCpJpk678JYydbjmtGmxmSjLJHkEOYBPEKfYyvRWW7o7KlXIjws7E9m0EQZivDIu/JeJYZA/YQCuHq9MMd6F75f4nT74PCET9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejzW0VqgQdVY08sCESJZErpFCOudvGY9O+7ETievUYY=;
 b=Kh5fCTzzVZ8YNZMNh3zX9RtFhsfyPSFCbHY0XAXPt8U7pDtoB30tIUcwuALzNHXdQJfNpMR6oTjA4/IvxF517sdjbGgBc19d1fx0vBx6MPh13Ma5hFY8nRR6T3JozIwIZVO2kNRT28OjB5pNHWp9D+axLVSNEnrzg8f8fwLSb6ErxmMGHKFVXibWUeE+USkratBzKxJ9w/OhrmbinllpCCK0ZItDyTWO+OCpzeGkyLnx/nCnbyayno2PQIzPCdgEHxw8L0em604Y5exyvcVf7n8bhcGgzpYTOX3UIi/tBiZnkvuQkLL9Tv8hjRUynHJWNEgtNNlFlH81ixYKOm+9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejzW0VqgQdVY08sCESJZErpFCOudvGY9O+7ETievUYY=;
 b=x0cN7SH4+RH+xXWIETkYlfhfePmFZ4pxKAmzYPOuMLqcvYR4iqVVFVuzemwU0X51R5nn39enofIIa1Sifwbi5tZ1By+WSN97BRBTnTTS3kn7xBki6v/dt8Sb38lJcB8yTdFfrB8us1lPUA/1TBt5qTB7jogzIHDH7cIVqWyXAIo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 23:14:18 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 23:14:18 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 4/4] dcache: stop walking siblings if remaining dentries all negative
Date:   Wed,  9 Feb 2022 15:14:06 -0800
Message-Id: <20220209231406.187668-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a31cfea-42a2-4e54-95ff-08d9ec21e610
X-MS-TrafficTypeDiagnostic: BLAPR10MB4884:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB48842EB7715C81DB70435E95DB2E9@BLAPR10MB4884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucxoMeSg03HfKvQ74qt/5pnCb7DqKhU5eUWXos0SgXTVJiEkAZFp1CWCSJFx1pMG4QnCy19B5RacG2Cn9RFVBQ+l7//dYAAifG7/ZkWCC7anjYJcb/Zm6H0xIVH0u4Dh+vag6DTzvYFQEgjH0Hx3JYFrLzCi1I8+HjHIqBvn+p+Q1g+4B6nWilCausT5F4gf5EIs7hzbMWeuRyJzRHpGklvSp8x2ix52lFyjFnwJBe6DY2Lo3HLqdQRt7YGUeWoluoq6aOaBd1/B8vGQJt3oJAqTMwJVqlurhQSmGMzHAj4vti6XDrb+VcHQZcyFeGTZ09iX4w6dIo7jWf1wHopmFog4sZ8j6+44mBGiyOtHgS7guwoU33OrpCJfTmtfOaOoOPI9v9XT3ivpswbq2igsS4nFcCGW9HZgtezMVye2sHw0E1gmwYry+bxa5w8MkVwqOfHk94rj+ENcFZ/I0SPAs1eIEgAa/Mtx+XmckmwODv+6CMPMWle1vPhtKT6LyNlccVG93X5O1de819MjhHzjMeYSVU0KrQYBXcU4ztst5bd7dM1oQE+WeP99U4gMvf2BqTaXenGiCmqm9+JxhUN0boShCFS978bxuUHUuhmL45MzjTNFOB3EpBoBXxslkIpAXK0CObifmvsfPQTOp39wGXS0Vnp0hgCvBWgBc6TooXwhAvNPG9qcE73SGPSXMi671xoe96pQrsOpe3+JqRxReA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(86362001)(52116002)(8676002)(6666004)(6506007)(8936002)(103116003)(66946007)(83380400001)(66556008)(508600001)(4326008)(2616005)(38100700002)(1076003)(186003)(26005)(54906003)(2906002)(5660300002)(6486002)(38350700002)(6916009)(36756003)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nO6rmJCpwVgiNVBJc6HkOKarNnUJ2w43PuCQIbIAaLB3rsQ42qW7xzxqly0g?=
 =?us-ascii?Q?aCL4TRNrfT9w1I1VlopJwpvlprGrZdjSR/F6ZifMsGu+TM8Q2u1g+sa3XR57?=
 =?us-ascii?Q?k3KqgEdOgBS32i/h9XsCVAfd0ntnk/J2jTWG7W+YuhrQQzUCADvJiUu5DGfN?=
 =?us-ascii?Q?JruacZ5ajsgM++Zrm9ld/8S/XIqvkpOWfKFDw0U412wryVbfT/NRc9twofPe?=
 =?us-ascii?Q?ta2XDPGYGs3IDsvWAw1s2YMrYxiAFm3KWCoDjceocKIAYS+gmsVrfEQycxHJ?=
 =?us-ascii?Q?EjTsAuyzu5q9ZobYALXaA9LoE+5/1VeFj8g9SGQAVaSxVBhZ52cqMWl/KBYO?=
 =?us-ascii?Q?uTx5A9/Q0uMt2pjZ2PLxQtTGQjJ9LwdrNdTjGSdIGNjgmatr5REtc6wUA67I?=
 =?us-ascii?Q?FrIhuVw2pWq3a05x3xQ9pNK7vWldxt1UWWg6GKrvwXHAfdEZoXmXHLM9tG9M?=
 =?us-ascii?Q?QcnT/WcgOg0czchcvbgV8XEmxAuw3B0aFfs2spptHV9vuWR8VIxZwWynl0Tc?=
 =?us-ascii?Q?d3twJCwLK23hunJUF18Sw2Lb4qcGpPuTqCUSlbPt7QEdpcYa+SngH+wFfoYq?=
 =?us-ascii?Q?xjD27/loeFaqzHKAJPkCXfBZUs/dg+q5tjjS5jIYF9Fq7YhaBp0oTu8ZTNN1?=
 =?us-ascii?Q?YGVDHqZIIIVkwWNqIk8SkpJbE7OoPQgNqndaxXxG3NPY1f5hOU/t6LxfLnHk?=
 =?us-ascii?Q?8bS992575vXdLH9k6NIYvm/EILn2uooWLKiJ7T3dYRLias8oa4UyjES6e06D?=
 =?us-ascii?Q?oefu1ZTEb8vo19W/EqJZ0pdY5D89F1dqfyvW4KpHAwWVYi2xnKka+ao49ZLD?=
 =?us-ascii?Q?eEPdK+ss8cf3aVvUHMdU3f3O6dySlhNEe/SKtsPwsmWn6b+NhlkRybWC82Vj?=
 =?us-ascii?Q?pzLEBQ0E1Hb4Msfw3F/J6gEsIiOcon64eLN09JkH3Nasw1Y3DKIN+SsH9Uw0?=
 =?us-ascii?Q?XFwekEsrWXeaO4c8tedDNi/lXYUPJzprt3/KtjR/5nzccy9tGk82yjtx0Dwa?=
 =?us-ascii?Q?0zdNKiBnRcW6uv5/WpFT9xzDpXroRoyP7JWVuwCOM2L3tM6a7INQV/rhburO?=
 =?us-ascii?Q?Fg6T7UlsLiyXAjVSvMMnyJ6y+LkexTcG70LJ09djukQ4EiAjOVg7g5VbvNqa?=
 =?us-ascii?Q?nQ6MjagenqqN5M5xnu/vP2XYaLmBSygSyZ9t1PlElJqdXLfK2CK0Xm2t/Uyt?=
 =?us-ascii?Q?sNrqRbXu9F9xmqMJurYoY09nHXdrquqzdYV4LDwqZH5SFgJL4TZDUZmVKtC6?=
 =?us-ascii?Q?sjlFCOMsZY5lqaucZ6xnqbbi4BIAP9wqo/m8ijmG2lMbZscOAJr1EIjlHBQy?=
 =?us-ascii?Q?H0wi9qb4pOjjfAt5/xjolM+fQ2a3bTFmj6raatGYyiZgx+m8oJBRjusWI14G?=
 =?us-ascii?Q?QaOVeP5G5AuIGfIy0ykzhlYV3y7b5Ek+BmKU+Lg0wbDlDH4jYpMuG/FCZmON?=
 =?us-ascii?Q?PfWt3UQcOsdo/fEJVbDrIMIFP6E7YqqlOK/N6IL1X57puS/Ef0EeFf71g69d?=
 =?us-ascii?Q?w+8OQ7f9TmMzpOsnnqRXZVbc7EBluMvJkSljZaq5WBRahEydD7cKuIDEePKA?=
 =?us-ascii?Q?IEDrfXuTJ8Gfu28212Ik/gclTihzr0RZjSs99AT4Adsj3rzVYlpKdS/IDVvR?=
 =?us-ascii?Q?wE6sGvk0ABnHqusaoNxzNATk9jglKHe9NZxrUDLra1r6PMpP8BNPTGYJDiO9?=
 =?us-ascii?Q?deTj8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a31cfea-42a2-4e54-95ff-08d9ec21e610
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:14:18.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6S0zAcyCq3CYjRMRUQ7NO6ncJe5QnVil3EO75o2MsWbEMG4N4chiNKmJx/nIoI6ydAnb2OnVNKueQPMbtX0bT/RNoQQKnHYnPDa/enZGzTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090121
X-Proofpoint-GUID: zibqtQpcc6YnNWemx6tb3GRAy9FmN7rv
X-Proofpoint-ORIG-GUID: zibqtQpcc6YnNWemx6tb3GRAy9FmN7rv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Most walkers are interested only in positive dentries.

Changes in simple_* libfs helpers are mostly cosmetic: it shouldn't cache
negative dentries unless uses d_delete other than always_delete_dentry().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/dcache.c | 9 +++++++++
 fs/libfs.c  | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8809643a4d5b..e98079ed86be 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1530,6 +1530,8 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 	struct check_mount *info = data;
 	struct path path = { .mnt = info->mnt, .dentry = dentry };
 
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
 	if (likely(!d_mountpoint(dentry)))
 		return D_WALK_CONTINUE;
 	if (__path_is_mountpoint(&path)) {
@@ -1776,6 +1778,10 @@ void shrink_dcache_for_umount(struct super_block *sb)
 static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
+
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
+
 	if (d_mountpoint(dentry)) {
 		__dget_dlock(dentry);
 		*victim = dentry;
@@ -3256,6 +3262,9 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 {
 	struct dentry *root = data;
 	if (dentry != root) {
+		if (d_is_tail_negative(dentry))
+			return D_WALK_SKIP_SIBLINGS;
+
 		if (d_unhashed(dentry) || !dentry->d_inode)
 			return D_WALK_SKIP;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index ba7438ab9371..13cb44cf158e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -411,6 +411,9 @@ int simple_empty(struct dentry *dentry)
 
 	spin_lock(&dentry->d_lock);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
+		if (d_is_tail_negative(child))
+			break;
+
 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
-- 
2.30.2

