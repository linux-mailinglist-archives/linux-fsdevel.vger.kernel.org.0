Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76C4FC1EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348486AbiDKQLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348474AbiDKQKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C00167E7;
        Mon, 11 Apr 2022 09:08:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BE9Uu9003034;
        Mon, 11 Apr 2022 16:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bstN5vNsxMv1kOoMK4ovp90qAGzL8wDP/+3UgSW6nPo=;
 b=ygWhrqKohQQtUiRPhOp8YBlAfx5C05dibCdhohdajEcbDmOJ6nOJsP/+AmxeMWyelePX
 YI+Z8f0OdZ1YgdeOgotf5CCy7VgtM3n6eXXvXNM6DYETG/YF3z/H4vamlWXc+CUDYMMI
 tWZe7FCmoDxFZ7r+FhJt1/o7hSpHII6Hk59zHgqKYIRLDZC+dyi4nZfNGmnOc6VrJr7i
 IK6B/IpifdduAABlKZ4ORj39JRWMcQg7C0IxCStjHY7BdeXgVh1wYCuBrN+JSsvvuBuc
 wSDGAvCP17ElP/ghpy4ag4CN7EgRdQGqNDwglxm6zkz69fDiI7dIynx6KVHsbp/koOgr 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2c75k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1Eg1031269;
        Mon, 11 Apr 2022 16:07:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k27pmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDBnXENP7t+YbUrTi12rS+lSUH8DIi07uTVL5bgdM4h2XKmQi3rlPobFc4VpgWOlMt4Tf0EG4wh0QmRvEGe+zoDG/+r+L9gAgy8YoZA90/eEOcX+L0qKMdWoGYWDnqf9Rb8Pt2bIAJCvXdfOWMq1bmmjSR1u+SkftKq+u2IOvCOXAI/s/VjApGmozuxgZxKt7Z1LeKhA7usIoYq5UFZli/5QY+jMRtPZRCDT9CJ+TmHTm5QbryppjpW+tOdg+LjT6kCCS3opDJZ5AXmn1Q3q9EpMfG4LsQHE/fQ5+j2lO+23Ebvh/W5kfrwyHAhjSXEy2FnxZgQ0cApUWaOpGUD3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bstN5vNsxMv1kOoMK4ovp90qAGzL8wDP/+3UgSW6nPo=;
 b=ZBZjgSpJ5afaZMIdgKZbLn6k0PyMvBzXyOhmtjt1Yqjj/qhW72V9j/cVmKEVXzW4ZHsULJdsQajTEpk6kynCx82rWz9E4FfzH0lpGv8qySBwAeCkZKk/nUSSrW1n8s0QSieoblDxXkFzgPyQnOqwlErKre1lw57KFJGk2aj4PV0k7hPxgJmkVo0ce0fI2runeiC8z1szThB2BZxmpCGCXEblvo3IR3N9NL3uF1YBEGWsGzCA5N4iiev7BGUsCMSr7foe8JYoKYdbm/Sv9A3eDdkSmwGafzi09K5CjnJhCQxOiSzyNkk9wTSCXFOJEutQB4qfavyhmQhDSUPVd5Ql+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bstN5vNsxMv1kOoMK4ovp90qAGzL8wDP/+3UgSW6nPo=;
 b=Y5h6TMS0diiHIzVWBGO+PV8KcuQV7gQ0xbhOXUBqHt40jFw3ERjzY3lX4LlVh/dK61/xsr9oshnWGs3Y90ZEQLwv0djd+uPk7+HyhI6N/7yOMe5oXx1U9UUMS+UpJPgUIEYcj27YwEI+NtxfzSdTXVyrpEix06lsVIXGX/3Ik1Y=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:42 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:42 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v1 13/14] mm/mshare: Enforce mshare'd region permissions
Date:   Mon, 11 Apr 2022 10:05:57 -0600
Message-Id: <40cfc1e065f27d1d119371c54b6e80421078c791.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4dd10dd-7438-44cf-ca03-08da1bd5689b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB456413E38BE1753FA0C1884486EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dan3t0Ziid/VAEvmsN/rrwY+xxoG4NpXBq+B+pJ/wGvbdA4KknDdYVGp+KrdlBVvc0iB5wlp6YcheOAw8mihbc+WTO4kpASH9EzqBrAKMbZ6Wr0IVszKct1jkhR5Sq70Sd+ExoSe6gZVfTUfx5C8R3O8+AgVO9CHTngL4gfnt8WRBKNuONYFpDaRsu+wxy3rCmNGI+ip4UAL8uVaHOtnMNCL8IQJ61WG1/1HLb1Nq7BWxTEExbYJ5KTILN3BfGdtTXvNiyxBzly5oAPamDNKEHWwFzGVG1bt83Dizwq7PCv2EP1IE9/sSTSm28At5G7Cf3x8+FGqPu2v3hYZkPV2tzCkrSQX9BXlK8JQk1QeAarMy2MQHrmJq/Wk1XOCpksUpe+Omy9li7IqsaJ1bdr17/Q0yEgZ3Oa+vuKGJ3jtkXTxMS8fdl943hlI3zAVZs5pgjVhYXEt3bIEMRqWlcaCEqtjjFPzpinRYt/5kboPDW8b9bNttKW4d23jTCDrCNS/IZWHZfds8p5yjKF5OIqiy038DadNCojn2BNxmnv9buhhKVdpNgmuVQjxtX8CgfkQbJtB7BWSE0P5W/ulYvaoXKo+peXXQanCww4oZHa7AZEEFLR/YGHGkcdh79qNwEVRaQP7nyoIZx52OhTu86UqG7BPsDZJhGbfYYvmgtLdTAqtbL5R+OBclkXNWfQKKuOa1Ly6qv1E8yxcDyfI4MPeZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkMh9fUKcK/0xrGyAJYTyw6NBdrK+b4cKngXQYU3FfiomdBEln28En0TDtjU?=
 =?us-ascii?Q?60sMjADfHRFe0VOysTh/rfUvwaOdXxziIQthHN1wO64i2lmBGEMYyaHy1OD3?=
 =?us-ascii?Q?DKhz7M54V9FQiVHvrJZ/GrjG5WDGZoycvQKAgE1LFwv4cvF+x37KCngum9Q6?=
 =?us-ascii?Q?z0Dzelhk56UZgEMlDFEiF7oyBL0lII1OJFPt2nA4FSezaIUOkZnXFUvsLfD0?=
 =?us-ascii?Q?R2wzNySBvZhm0u1/oUZmzYyeMNiyAailSuoZYRdwYjFddfQa+sOsk5at5gny?=
 =?us-ascii?Q?jJzJHQqZlzzNcHmgyutM/hZaM6ggY1+kwL8mHUhtiERp0wcwG+ch0/o7VnQ6?=
 =?us-ascii?Q?QDtoj3HkCxsqCqTcGcisAyNXDM8mgUlXE/xuJsmhiP9Dm+/1Q2vGaWPfJii6?=
 =?us-ascii?Q?kHYuXy/lTNRCbV6EbNgbFvz2BCkQpqUGTfKz7mJq7AikqzBKZRk6Efk44Qri?=
 =?us-ascii?Q?GKZXyv9zax8GZn3PZuTPE9tiO7/B/haoBnnT+dZMY6Anro4QH5Qzw26nakaO?=
 =?us-ascii?Q?wuikaD3nLJaPJr4D3XFOGPTslDr9c4VLA5ZWc143tMZoq6sgND2R1f2TX57H?=
 =?us-ascii?Q?U+HpFjTaXBtyv8MtxqDkyqI6TNIThbdhH3+EBvhfOSMNqOt5/uFXP7P4ZrbT?=
 =?us-ascii?Q?GWZLPjgjPvSATX8W9ooIZujvYswCJBV0YcFXPBsQH1NvrSEjpqrZT/QwSSyv?=
 =?us-ascii?Q?IkxO6t8GIpYyfs+b6H6Ug7jRmb4eDJo1sxlwMd1UEn0+vaDl4pLd+fJVdcvA?=
 =?us-ascii?Q?UDCHBrrJPinl/TQP/NGFwdNuNKHqNb3IOmWpOBmGGMW/GMR+PQsyQbFGdhkG?=
 =?us-ascii?Q?lY0YYAhBMtkJoePUdNoQrKSFJZyYhfkM8Rb4KFg6S/ia+pN3Xty9T+MixVXS?=
 =?us-ascii?Q?oeEbvA/t1mTacEzvRyKQ/L1OSK8JWYKJ1Uq4d1OfLF2Bo9RUa5ZB5mKzBuMf?=
 =?us-ascii?Q?ESJDIoayYGwRwqwOrpD2yWxGGLLJVU/DdamhL6TKQtMiCBfQo5v1THHb24rH?=
 =?us-ascii?Q?O28pcZ5eXvabaZtqlghcuF0baw+xactuO0BjGx5F7HrtxbGhRGMV9Rknxfvv?=
 =?us-ascii?Q?n3MZ/hYdBPPHCls+Ulf1aKVKCfphLBPUVTA1JJS68hdxSOzWN6ealbB3oWiz?=
 =?us-ascii?Q?vzfTqU+rdH+DrPy5hw0VcdNW2rebOputBfla3akaWplE0lwqsLuoT5dlRXQ6?=
 =?us-ascii?Q?Et8QglHLmkMYlEbMrDUTZmAB+lndr58NAzsBQxkv2PmqtLJiO4L7QDbvjqea?=
 =?us-ascii?Q?uhq8KZxTNxm59eaQrokup6y3vUd+xkzrro48skp1slwL4n7kiRdpImXY+RsS?=
 =?us-ascii?Q?daYjaDMt00zE/QKxk8hPor5DbDpeSMZtB/Ozvo4Xi8GM9X+Jd6yZ0JkOi4V0?=
 =?us-ascii?Q?PURNAu9oYkUTfTfTqXy+G7ycvELXqWV2aZW9WC38jaldLJzC5vd2YORbNdyA?=
 =?us-ascii?Q?XKDceJXgXMDxNPSowILLcdWak2gI4d3fo4wWRR2tSRK+sR+JyxnB5/lSSurk?=
 =?us-ascii?Q?ZBW2zqTLzHPAxSla4/Zw90odlrBHSWAkJi+H01+vbdR8aGWtnNTYr+maCqNC?=
 =?us-ascii?Q?95lD44MTXvLPRADttepZslYaX2AXeCyU3UgTPo7pzF/iw1cT5LTgu/6H0hiM?=
 =?us-ascii?Q?xYukJRfAv4TO4FQtu0dwh4OwtvpJ7EWb0ltxTyW70gVh76vI3BA7+d8UhfEB?=
 =?us-ascii?Q?qrMwZiJccqUjbK3wCYAuKZnusSCLxaH8c+8iYvdTPBtQhl/dzVS5Zfnnma4c?=
 =?us-ascii?Q?YFYEibjYVYp8nBPfothaUAZ7UWjbKWg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dd10dd-7438-44cf-ca03-08da1bd5689b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:42.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL/2WKgOkyo7scLQmIbyr18UdgVQUKfUiCZ+oTHo0kO3wKvwQKfYRnHBWBkqEIJdr7OJWUTegH7nsO6dRBIVHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=917 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: hhFVpB-tQ-N169IxUB2SQW617P72RFql
X-Proofpoint-GUID: hhFVpB-tQ-N169IxUB2SQW617P72RFql
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a process creates an mshare region, it specifies permissions
allowed for others to access this region as well as permissions
for the file to be created in msharefs that allows other processes
to get information on mshare'd region. Ensure those permissions
are enforced for other tasks accessing this region.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 88c7cefc933d..fba31f3c190f 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -24,7 +24,7 @@
 
 struct mshare_data {
 	struct mm_struct *mm, *host_mm;
-	mode_t mode;
+	int flags;
 	refcount_t refcnt;
 };
 
@@ -131,7 +131,7 @@ static struct dentry
 }
 
 static struct inode
-*msharefs_get_inode(struct super_block *sb, int mode)
+*msharefs_get_inode(struct super_block *sb, mode_t mode)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -161,19 +161,22 @@ static struct inode
 }
 
 static int
-mshare_file_create(struct filename *fname, int flags,
+mshare_file_create(struct filename *fname, mode_t mode,
 			struct mshare_data *info)
 {
 	struct inode *inode;
 	struct dentry *root, *dentry;
 	int err = 0;
+	mode_t fmode;
 
 	root = msharefs_sb->s_root;
 
 	/*
-	 * This is a read only file.
+	 * This is a read only file so mask out all other bits. Make sure
+	 * it is readable by owner at least.
 	 */
-	inode = msharefs_get_inode(msharefs_sb, S_IFREG | 0400);
+	fmode = (mode & 0444) | S_IFREG | 0400;
+	inode = msharefs_get_inode(msharefs_sb, fmode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -247,6 +250,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		dput(dentry);
 		goto err_unlock_inode;
 	}
+	oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
 
 	if (dentry) {
 		unsigned long mapaddr, prot = PROT_NONE;
@@ -276,7 +280,11 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		/*
 		 * Map in the address range as anonymous mappings
 		 */
-		oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
+		if (oflag != (oflag & info->flags)) {
+			err = -EPERM;
+			goto err_unlock_inode;
+		}
+
 		if (oflag & O_RDONLY)
 			prot |= PROT_READ;
 		else if (oflag & O_WRONLY)
@@ -331,7 +339,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 			new_mm->task_size--;
 		info->mm = new_mm;
 		info->host_mm = old_mm;
-		info->mode = mode;
+		info->flags = oflag;
 		refcount_set(&info->refcnt, 1);
 
 		/*
@@ -412,7 +420,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		mmap_write_unlock(old_mm);
 		mmap_write_unlock(new_mm);
 
-		err = mshare_file_create(fname, oflag, info);
+		err = mshare_file_create(fname, mode, info);
 		if (err)
 			goto free_info;
 	}
-- 
2.32.0

