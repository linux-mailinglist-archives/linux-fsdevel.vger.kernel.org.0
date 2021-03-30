Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD14434F368
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhC3V3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:29:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50678 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhC3V2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULO0Nh130359;
        Tue, 30 Mar 2021 21:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Ht/hcmXkFVk5Xsg6Wh3LNQplzl18papsAaDctd4NMw8=;
 b=B3P53XYHXBqt3TMT6JMzEIsflEE6jzSBQA8IGt0+7OGOrrT460Mhb8L7Hfi3Gmf/aey4
 4+xfDD262nT33uXpgOaqJOjy++JGQVYlryRFDh4tol9ICxHgIJMLwimnZek/sWvdHxXF
 ubRznpPfwqijnXsqQtVcX/oKs4i/7z/SFpI3QfTAU6iLqSxO1/G1ajY+AYdXPwYC2+8K
 /Mhx8ubR0D1LAN4YXLJxWuPsfxUIB9PgzRLVv2W5lhB/M5yjxwAjFnjWFpphXJyc3nrm
 fAAxBA0sEyfVEu7s8OKAoRFzw+INnQENOBAU9gAGpXIIVWNKj2drioJekk6FlQe6KRvA lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqr8pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPRpp105741;
        Tue, 30 Mar 2021 21:26:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 37mabkbcr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY6L/nhxD1V2hCe0TFnVJ+7G2t6XvKgLeq7mRQWVfw7Y6Q2hy2lLEUg70cj5LUKA6RrqCDJWcOX7ZP3oVjYY+ysZ0wvlftjDXQh6Pbyxwq/XZghOSICXcmJNtChlRVmrWPULJ4fBkzbOB2mfcHFlvF/vY8p7TAOJLhv6Frb1zyw702dVd5AfeMQspkc3EWPtyOglshh2CKxUA5OSZk4aVyEg96Ux0uqYTUeCneqLGkLAN8cYFWZN6xYuA8VlTIlJJrcOniDGOMg3JUmOaTuNFp7z+ncgGFS/nY33vSArK49wcyyOsKyt2Pt9HMUSpsjBOEBYKO9JzgsaxgstBvb6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht/hcmXkFVk5Xsg6Wh3LNQplzl18papsAaDctd4NMw8=;
 b=lcCmUPokj1xoJL2zoMBbkrFQYWCWrVKkLAni5VIgaJvgUN0+wZH/PZs8F1lFLiWKk/jeN1cwS71dI7kkSGa6NaiJYCXNMoZiojrOF7dtCwKcWJZwf8ZFvQs4VTQYWDxdQ+z3gRMNmTd+/wsTGABSXvg89/7zRWXcKJavg8bwlIa1GSLImkma4hLGygsdwlgwMXAMsBtZ8RPe7KBo08NkMQGUQQcezk1tF5+Bo6LdOe4N+6gzKgu/HWJhjmblpOTww0VKHIyjo26AJHcqnqKk7ZAbyE/5cSHFJmL3v8++k/oywcmqTnRDpdD3uYSWo9K/9m72M7y+aWWqI0hFneCD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht/hcmXkFVk5Xsg6Wh3LNQplzl18papsAaDctd4NMw8=;
 b=U91gtlwwESPy+U8riPbruEUXXEfc7pJlGALW4AzIqcoHYA9qqI+TZWkhDhDDjZKKZi+84qfMxv8Aijistv47uV2YxkdUntErsAvPKNMox/m5MOQh0ubE0EIIXWpXYbMk43rFurQ9UEA0dAmfIwP4OVrEk5bewiJRZNa10KhfoKQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:48 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:48 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 25/43] mm: shmem: prevent swapping of PKRAM-enabled tmpfs pages
Date:   Tue, 30 Mar 2021 14:36:00 -0700
Message-Id: <1617140178-8773-26-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eadf0edc-4eac-40a5-09c6-08d8f3c28663
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB36006B39081A7AA3BADF0D22EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/PDxGMwVnlG7BOn+lor3oCxBfJ689HdrfGAVxVCsWSuoX+GB6zj7Pdlb3p8IAwJuIsVwssV5E3X6SwZIoKShfmY57QiX2v+aTBfVK73CXVgmj/+aACpWqM0VD2D7hs1FHbuRRsY8e/SBdR44n+EKDMqE31iT0pge9vWltjq+Jeb8Fd1VxPJ6CQrJaw+G8JCue44xhMWi4v5jkB88b2v06M+qDmh0zGO1iOyXyYePUX9oV6zABXG42udhbx4aaMmKaup1tnA67DSvxmf9Aca5NWfFjqG671h5ilrehldROueytGGSPG8cYWjgshBf7fc7qjfYCEdMLGulRuAfKpMFsUk64Cjdfk/L2GOqFh+BMlvdb+5JqO+xv7nyOdTrClnXDamjY5mweXCOnaE5rSVsSZ235McZjdu8eGzzL3tOpOSKVFbeFOY6TBP+x7EIlxtG9M0vEBvN2hNq3ak2OPrBOw+GSIPMfzRvL9cySCiVmyZT6if+9esZpuPLmDhM9UWLKKpf73KCvbsE9Okp1VH8Ed2yglifG2e1bKEvgizfNQlUX5WHzz+xtiYnihL/6C5F5MpRhXrCsjthpbcGCqXT2iG2vXLzu/OLRU1aDxAT7gABGr/6A/yt//CArcySct4la87re5RYAq71U/kyUrA0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(4744005)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UzXgEaSYcN/83m5e0XLJV9BbC9MH0wkGy8YIxsKYq37LgfhCzVC2XreTudLl?=
 =?us-ascii?Q?wP2MQIOx2H8d4+FewMvIplKEOfByuPzGH6A4lQj/pna7ruEEH0VjaA+ZCMpX?=
 =?us-ascii?Q?KwnkLPq39D72LTZO1qJ2CV2dGFFxhm9cDNCd9HU+4UofCHCTjBKUGqmDPLzO?=
 =?us-ascii?Q?rLskDN0d1rxF+A1uIZCglSwHuErUz4quX+ERN/u7FzQDzNU1rErJ8QylIdnf?=
 =?us-ascii?Q?bwswvaRXJJzH962XSVJQDtDFkU767N/hDseObQlN/1Bazoopkejt4OvqpiR0?=
 =?us-ascii?Q?LmZ7MPgBHLf6pQzYYXKcR32+uZzm75hhXb0wdaFVoxu2QfPgQ8EmeTEUXCBn?=
 =?us-ascii?Q?bNw+NYLlMlejCrDUsHxYdHGda0Q8cqzPNHc+IFdNLV/EJo9Rm7pKnW/3G4t5?=
 =?us-ascii?Q?sN8z2KWJVjNywSX6JfauW5SAZ/c7boQ42ix7hB1kavo1KegrT1ZV+VviG0ag?=
 =?us-ascii?Q?HwGBcplTN5MomLF4y2pS/GiWef5H6pykXG7FTXEJBeiyLswj6lzvt4HkpEYs?=
 =?us-ascii?Q?WrM5xnSZ3uY6I9dtkD++KZGTLaIv5KUNK6YK3MOM+NO4sdCGtGo0PjrDeMm7?=
 =?us-ascii?Q?WTAMfNT67NZb1zOuru2tlFX6ER10nePziGWm5xGZFo2lxuV58wWbarb8DIoN?=
 =?us-ascii?Q?s/Hz+BI3to5QVqH13fX9XKcXixEJ1x5TvlnhfRZWrfhDKrX2vtpJlJjqlL95?=
 =?us-ascii?Q?uI7CRPO2B3qGBcQ/5kSvOho9txL8MRXarzogcGf3xLWj8d7XvlwilJ5Y3Glo?=
 =?us-ascii?Q?TX1TzCnAd0V2owjC1Q/sRn2BVpQp76qR4XbA7tTq6yefjwHhoUoFji+1mjMo?=
 =?us-ascii?Q?OdfPUOYCw9oi+8SRQbNgv/BFx8Wbl+GpEwpIQYP7QwdZlUS2UFIOfqP/6uTY?=
 =?us-ascii?Q?n1fnaftHQh9jWBaRlXSNgoDrIsoxNIPeKJ1ad0CQE3HmvyRvgVWcg6WcX4xj?=
 =?us-ascii?Q?XF/nrmxtpsWfe2FkQk5ByBx0JsK/fAUi1evkheVrlNc07JvRzT1Y9WcElxcp?=
 =?us-ascii?Q?JW4V/QY+ItQRmrudC993KF9rOQC3XqgQNHFUjQj73DNuRCfmbCYmefskrprA?=
 =?us-ascii?Q?gQ98HrGDwL4ZlyKaU7sUYiQogRD8X+IOvzTu57kBSONrFEMiVhTkcsD+O3Tv?=
 =?us-ascii?Q?+e0DmziGyGQ3wFKyasPBJTzzlUclFP1HxBEYruPZeN/ejeq3lEU0h9x19ous?=
 =?us-ascii?Q?F6n3GIA9IqH7FbSgDoUaKHnq5vksBVnPcbxjTlBYFcldxvEOEIG40+k2GMFD?=
 =?us-ascii?Q?JevMDF1goSTxfFsdWXA7Fps9yhKHamVYKINQrpezdMvqU0dP1R324NGrvqKX?=
 =?us-ascii?Q?BHAROzbz4Qlf/FgOvbJfVlAg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf0edc-4eac-40a5-09c6-08d8f3c28663
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:47.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qdt/hmZY7+RvVxOHqzbfGbND8KMk/2DaQemfxcdYLd3HkTRMs1IuJ944e1vW5KU9y6c3FN5LsdLjKbFriQe6ah7CKUZ/Wt6rVnG+kEnNydU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 0odOQw-sJZWu2EsDzUQTn_53PPDuOgpD
X-Proofpoint-GUID: 0odOQw-sJZWu2EsDzUQTn_53PPDuOgpD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Work around the limitation that shmem pages must be in memory in order
to be preserved by preventing them from being swapped out in the first
place.  Do this by marking shmem pages associated with a PKRAM node
as unevictable.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index c1c5760465f2..8dfe80aeee97 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2400,6 +2400,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
+		if (sbinfo->pkram)
+			mapping_set_unevictable(inode->i_mapping);
 
 		switch (mode & S_IFMT) {
 		default:
-- 
1.8.3.1

