Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77144EE16A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiCaTLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbiCaTLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:11:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280CC9969C;
        Thu, 31 Mar 2022 12:09:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VHe3EU030419;
        Thu, 31 Mar 2022 19:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=HY65+16Zps/dpcltFkHOttyuBPjIeHmnz6h8+YBKs9Q=;
 b=GgP42O5RQvdlDjxelHvqqnmWYYPge9tznksiUWuoerTsTInX2nBmlhuPRNR9LANKmEqj
 a+gKIZAFn7Ld/JnjtgCmnlOlp4MxGOmfAzITWlRgoh0PtuODjN9+jIPlJsCxw0/Su8cw
 LNz2hGMJZYJrwKV4CVG/1zVYbx3b83zQqv/IjoKqblng4NwSpPz/6PAOC9M5MB3D5LAn
 zXurMWymn8OAm8mwmfWYUJn6C+vQQTPjlUzyLEnJC53t9QwaQ4DGOo4vqF78Xd1bVjDO
 2PlyxRMC2CRQtkSmwm8zmeUklJRgENc8HhrclC6hSrzXWRiEfi7LPGsla5WDuJ9wLgrk eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0n8w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:08:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VJ0buF011531;
        Thu, 31 Mar 2022 19:08:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s95scqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 19:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQNXlsVHblyXn9vXJYopw+PieQ9rHp6ErFTQme4dm9Nf/ai6p8Z39KRdbA0d1hmDMXA3w68t+ICAK6+iF28KFiK1Y+KCoZ04b0/y3ZSJvBrAsPbH0g3foBdDIWn920fK+rFxa8mTljAvwTPq172TQnlvzUxn/SoXkyTdeONSkUQXW2VPill1WUrQkKTlJv0Q8KsCNnLEPDdnA6wVocTkdMlR077KNZzLcRdAqDlDfxpjwehF71hLApGcFXBi5+TzJ0pecgnW0vkZg8vfosFNbRlUtkHf2Ex4v+bi9KWWypKVRndLmpgUYnY0+f3l1tlccXIF6vXscBz9rKq2aerlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY65+16Zps/dpcltFkHOttyuBPjIeHmnz6h8+YBKs9Q=;
 b=BfUO/0tSuAjsGvYG8XKyHfMK6NF+VcX595Td77nnn3rHDkKVgCECS/7iJHtfN2r+1VXx+nhhmph9Siim78Bqst/d9dNVJy1NDgqqj47R2ip3yMEwU9O/C+woLY89K+DumTqFvXoKLvfCWLLnM6HJgA2k3a9UEEa1Q6ShQHnrihfc3TEWE+j1KgpO1hot8OVsi8L63sZKBLqJND9RFK+GvtK9B7xLe1MdfNz8vyuCCcdVqZ5+odYmtjvmU1UwHJ3S4DF7t7OhpzHhDuGdpKsRwf+C3SDEh7vMfhum/KVQpPvl7xc6A5TUwOjeCEFlUpL/LAvHfFOYBv1SDLQL4GIeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY65+16Zps/dpcltFkHOttyuBPjIeHmnz6h8+YBKs9Q=;
 b=ltRIWLTobyv5tkmAhm+ItpzkfdR+MvxDOhxb+lZkwrMHi9e7Z8vf3kSl6seXb850JL90rB4v2tUynGZgnFR7pKBny+KGfrv6pJzlF+vo00LEjNqq79C3cftCC+ZtpvFz78vKpGVYiBsZtSkKYL8/Y4KoA7HtD4hdEpy1nhPGGJ8=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN7PR10MB2529.namprd10.prod.outlook.com (2603:10b6:406:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 19:08:35 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::9ca1:a713:90c3:b5b3%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 19:08:35 +0000
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
Subject: [RFC PATCH 2/2] fs/dcache: Add negative-dentry-ratio config
Date:   Thu, 31 Mar 2022 12:08:27 -0700
Message-Id: <20220331190827.48241-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
References: <20220331190827.48241-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:0:55::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce6c0000-bf64-4768-a1ae-08da1349daa5
X-MS-TrafficTypeDiagnostic: BN7PR10MB2529:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2529D47E7EA665A709179210DBE19@BN7PR10MB2529.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZnIwWda2JX6SUbLQooB2zsw6n6vuk1tB0uTafBtjZyS/hMASfKGSmYVFQAOFyfe0NPyr/RpqkzEz5WNTbDYt5z5AkYuHhfN8FCa8U99AUZ6g+zNTI8uUvPxUlyjR+m/aan7WEOWkAg9dmiFbx48/yfHwdUW8DH2nmCOWF0s+Z9fLxBvFbJrYtJkPdKSIwtNjsqu3vuzY1VN3kbYB/YoC9QlkvcsAyhuaYj8jp+/P2l7DyiJm+ISlPxuzAPkaGNoJ1zcIKPZ+2s179zUL7pcWxFBqiZXZKOJF9VD7x1DaLQM+3ndxFsNpk3noEl3MlwY8Qv7eaHGtsThmPXrutQhC3TwpCqByd7FwQmKL1F/jUy986e51uctx08d/L62ba+uqITMZQbeLmrAy9tu4Dy11XEnSeeW5AOZCyMv2jKLGhODKhnxNubEn0wu0G4WAVR/q884I6ZCUHi95rw/J+Hu6w2ivzfpw7xk5NFJDhe26LhcW5GdKk91xQDKwxeryKtN1/uPGmgD1wjzuAdlxEA891s8CyTt1L/DB5R/SqYjoESjg1j99c4IqQmZJaYfR0YTQm9SuRcYSNPHQAvvpV6VbiTZpYwuU5phH3WZDTIRoM9OQ4TNYDhGMb9Rsqr+wBDkb+6YBOfO+S/O+ln3iUP9lSBOLFXXZfOh8C3Iei4QCns+Lc2kmo092r68W2LAbubxxZtVU7bUiH6JPmlTIb6R5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(2616005)(6486002)(2906002)(6666004)(26005)(86362001)(5660300002)(8936002)(508600001)(54906003)(6916009)(66556008)(38100700002)(186003)(4326008)(8676002)(66476007)(7416002)(52116002)(36756003)(6512007)(38350700002)(66946007)(6506007)(103116003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hb+Up24J4Ph414XkWMH3Pi8ZQyjCeGF6bxWLN/PTz37owc3zRJagypnVEpRL?=
 =?us-ascii?Q?eJUIf49CXW7G9mEwx2FkGV3chc9lNHrFj+IyTY97B9EheSPXmAcxGz69SaYh?=
 =?us-ascii?Q?E05OOGei2xTEC4zPghCOA4FJ7F6VoTUZsdrzlx7hRI3aIjjCkcCZc2ounkc8?=
 =?us-ascii?Q?pVnTu04qKXlkvmVaHN9aSm7vMjzcJkNThzXNBq92h8jeXSaLTG3zy7tBtXVy?=
 =?us-ascii?Q?cWTM1C9meNcOZgl7u1btDepAUzERsv5PK56C571zQfqOMruoYCiuLj4l0LXM?=
 =?us-ascii?Q?Ony0U0QM/uEceN2rqSpeigAhvpLh3r6dg0xaL77HvSvYifTvUxfQFoAkUTlL?=
 =?us-ascii?Q?vZcEAEDlPO8U/fOb5E8/JwzN8IkN0cp4UbaJs2DfiAcCny28Chci+yrxvVSR?=
 =?us-ascii?Q?5NcV8g7CwY4BfHXGAPHIS0WQQrwLKYupJqawXssPasmGLffWra4zGtLHQ0Jx?=
 =?us-ascii?Q?Z0IK7iUnKS6G9M+yKd9M+EnC0bzXao6u3lmaARsTDo9g6WNfDXTbHFBXZFdW?=
 =?us-ascii?Q?pVmuHeJ2Lu7dkvFZGUKnOwNMX/eeRNaEnM3pFgx9ORg1WUt7m3PEaxfJUw/X?=
 =?us-ascii?Q?frJWx3YYwhYE9nLxDwuTrzk6PWVyGo3ZkOsonMVYfsOm+80JsUdy8k0RyWri?=
 =?us-ascii?Q?vKUE73FJKyrK7k0g3/DSsreVPRag4FelywBAV+cuapVrWjjESe+g11LPGQJa?=
 =?us-ascii?Q?Aj7F5Oo4Sq0xUnPD/+HkAkem8ABK7PP8zKeifdS2if+sC5ijYESsFt1iJQv1?=
 =?us-ascii?Q?r5uvzzR1sGwL9xNJKadyoraw16OO1CVY6G89N4kQ45/kWJDwiXrkdbI+UggV?=
 =?us-ascii?Q?O1++Wa4mlUGFeBU/SbJbeZ2d3r/EsGgn26WmwDV+1trwEmY90Bf1UOABTgx4?=
 =?us-ascii?Q?5xRYdXg1gbpSLAp/Qehpc+vPJcQvMRV0k7Z7aANt1kVV9L1evEdbFF7j0zHY?=
 =?us-ascii?Q?0eUR/CiUD/EtR472l3U/w0ulsZc+1Doustzszk19ZFBZqjDK2Lj3xzlIzvOp?=
 =?us-ascii?Q?BxpXsxzTOCgYHukR0Rd5z9Rj5Gp+IXe3Ohhkdt/EMbppS5muHmgizV3wt+wR?=
 =?us-ascii?Q?SbqaAqCZqlgnunyp5DERW1lpEuhcBCs/S+CpCQRDCTM9PkZD7JouIJ6vFiEx?=
 =?us-ascii?Q?/lzdXqamFbLWnWxAPTfOvpq9g0pId8dds2gAzr3bJlppnl1VWJ38nvqeZmjw?=
 =?us-ascii?Q?VKlgGhejGOjFCS+TS1vH1rNGaStzN0lptpJLfazT2dBZlOwI057DdZZ4Jq6O?=
 =?us-ascii?Q?0SEc9/E98iqYy2au+yWuphgCM+Av8JXPMZvGMoopcPgONuYoi69tDNZi2c0/?=
 =?us-ascii?Q?uNaFOPxgDnUmpb7WkXL3YH1jCVHirfAVNwQIXPouDCJN+Tju7Q+GoZAA5kyI?=
 =?us-ascii?Q?8QSuc6uXZmhsCOmoYR9dAOLOTb+E9UOJYQoFRYgH61bG4XwmYRNIjxjCIgD7?=
 =?us-ascii?Q?5HqwLoxZQMHbxYYGVPD4InOWdCOM2c+N+0P9nnWNBvslbXCYwNV3q+lZwe9f?=
 =?us-ascii?Q?qPGLTREHNUzXPvULbqNZzDmtYOD7/jlKWfU7s7DFnkB+in5NlvDgkYSFLHjv?=
 =?us-ascii?Q?i1P+gYQPsDljkypmuupha2Y8ZmHoFO6f9xr4K8hvY7x9FLkmUOK9K9QGXsVo?=
 =?us-ascii?Q?DkJ5lessbg0t/yrEGqONKaJk5qdcF4FRuqdHX1mh2Y2EgCZwl4DIC/7hl3jV?=
 =?us-ascii?Q?AXKnDAJO5DxesRzf0NJhqE98A8PZTLpoG5kmuspYRdahYclZdiQPHpimL0qg?=
 =?us-ascii?Q?QQOHkjwVZknE0MbBd1TrKhuoJkRMpnZUTI2JZHWHmraiwIqnz5K7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c0000-bf64-4768-a1ae-08da1349daa5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 19:08:34.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HVHPhFj79M3upF1efxMvsivrd6nbFy8vGWyTptf0rC806fMvvPvIvTMSoRMoIhwLCH/h5n0AIm1JksVn+WGH7WsmMF8UAFu8o7Oc18fq0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2529
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=879
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310101
X-Proofpoint-ORIG-GUID: U6JdAxqeR-t9LuZT6f0emTAdR0k2KZaA
X-Proofpoint-GUID: U6JdAxqeR-t9LuZT6f0emTAdR0k2KZaA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Negative dentry bloat is a well-known problem. For systems without
memory pressure, some workloads (like repeated stat calls) can create an
unbounded amount of negative dentries quite quickly. In the best case,
these dentries could speed up a subsequent name lookup, but in the worst
case, they are never used and their memory never freed.

While systems without memory pressure may not need that memory for other
purposes, negative dentry bloat can have other side-effects, such as
soft lockups when traversing the d_subdirs list or general slowness with
managing them. It is a good idea to have some sort of mechanism for
controlling negative dentries, even outside memory pressure.

This patch attempts to do so in a fair way. Workloads which create many
negative dentries must create many dentries, or convert dentries from
positive to negative. Thus, negative dentry management is best done
during these same operations, as it will amortize its cost, and
distribute the cost to the perpetrators of the dentry bloat. We
introduce a sysctl "negative-dentry-ratio" which sets a maximum number
of negative dentries per positive dentry, N:1. When a dentry is created
or unlinked, the next N+1 dentries of the parent are scanned. If no
positive dentries are found, then a candidate negative dentry is killed.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/dcache.c            | 93 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/dcache.h |  1 +
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b1480433ddc5..ba79107a8268 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -74,6 +74,8 @@
 int sysctl_vfs_cache_pressure __read_mostly = 100;
 EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
 
+unsigned int sysctl_negative_dentry_ratio = 5;
+
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
@@ -183,6 +185,7 @@ static int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+const unsigned int max_negative_dentry_ratio = 20;
 static struct ctl_table fs_dcache_sysctls[] = {
 	{
 		.procname	= "dentry-state",
@@ -191,6 +194,15 @@ static struct ctl_table fs_dcache_sysctls[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
 	},
+	{
+		.procname	= "negative-dentry-ratio",
+		.data		= &sysctl_negative_dentry_ratio,
+		.maxlen	= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1	= SYSCTL_ZERO,
+		.extra2	= (void *)&max_negative_dentry_ratio,
+	},
 	{ }
 };
 
@@ -547,6 +559,8 @@ static inline void dentry_unlist(struct dentry *dentry, struct dentry *parent)
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
 	if (unlikely(list_empty(&dentry->d_child)))
 		return;
+	if (!IS_ROOT(dentry) && unlikely(dentry->d_parent->d_scan_cursor == &dentry->d_child))
+		dentry->d_parent->d_scan_cursor = dentry->d_child.next;
 	__list_del_entry(&dentry->d_child);
 	/*
 	 * Cursors can move around the list of children.  While we'd been
@@ -1751,6 +1765,71 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+/**
+ * Enforce a requirement that a directory never contains more than N negative
+ * dentries per positive dentry. Scan N + 1 dentries. If no positive dentries
+ * are found, then kill one negative dentry. parent's lock must be held, and it
+ * will be released by this function.
+ */
+static void dentry_incremental_scan(struct dentry *parent)
+{
+	struct dentry *dentry, *candidate = NULL;
+	struct list_head *cursor, *start;
+	unsigned int flags;
+	int refcount;
+	int nr_to_scan = sysctl_negative_dentry_ratio + 1;
+	int nr_positive = 0;
+
+	if (nr_to_scan == 1)
+		goto out_unlock;
+
+	cursor = start = parent->d_scan_cursor ?: parent->d_subdirs.next;
+
+	rcu_read_lock();
+	while (nr_to_scan--) {
+		if (cursor == &parent->d_subdirs)
+			goto next;
+		dentry = container_of(cursor, struct dentry, d_child);
+		flags = READ_ONCE(dentry->d_flags);
+		refcount = READ_ONCE(dentry->d_lockref.count);
+		if (d_flags_negative(flags)) {
+			if (!refcount && !dentry->d_inode && !candidate)
+				candidate = dentry;
+		} else {
+			nr_positive++;
+		}
+	next:
+		cursor = cursor->next;
+		if (cursor == start) {
+			rcu_read_unlock();
+			goto out_unlock;
+		}
+	}
+
+	parent->d_scan_cursor = cursor;
+	if (nr_positive || !candidate) {
+		rcu_read_unlock();
+		goto out_unlock;
+	}
+
+	spin_lock(&candidate->d_lock);
+	rcu_read_unlock();
+
+	/* Need to re-read candidate's flags and inode. */
+	if (!d_is_negative(candidate) || candidate->d_inode ||
+	    candidate->d_lockref.count) {
+		spin_unlock(&candidate->d_lock);
+		goto out_unlock;
+	}
+	/* No need to cond_resched(); we're not repeating this operation */
+	__dentry_kill(candidate, false);
+	/* parent->d_lock is now unlocked */
+	return;
+
+out_unlock:
+	spin_unlock(&parent->d_lock);
+}
+
 /**
  * __d_alloc	-	allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1814,6 +1893,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->d_sb = sb;
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
+	dentry->d_scan_cursor = NULL;
 	INIT_HLIST_BL_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
@@ -1858,7 +1938,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
-	spin_unlock(&parent->d_lock);
+	dentry_incremental_scan(parent); /* unlocks parent */
 
 	return dentry;
 }
@@ -2521,6 +2601,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
+	struct dentry *parent = NULL;
 
 	spin_lock(&inode->i_lock);
 	spin_lock(&dentry->d_lock);
@@ -2529,7 +2610,17 @@ void d_delete(struct dentry * dentry)
 	 */
 	if (dentry->d_lockref.count == 1) {
 		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
+		if (!IS_ROOT(dentry))
+			parent = dentry->d_parent;
 		dentry_unlink_inode(dentry);
+		/*
+		 * Since we have created a negative dentry, continue the
+		 * incremental scan to keep enforcing negative dentry ratio.
+		 */
+		if (parent) {
+			spin_lock(&parent->d_lock);
+			dentry_incremental_scan(parent); /* unlocks parent */
+		}
 	} else {
 		__d_drop(dentry);
 		spin_unlock(&dentry->d_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480b2..59c240d8c493 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -102,6 +102,7 @@ struct dentry {
 	};
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
+	struct list_head *d_scan_cursor;
 	/*
 	 * d_alias and d_rcu can share memory
 	 */
-- 
2.30.2

