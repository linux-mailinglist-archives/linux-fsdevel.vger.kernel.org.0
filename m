Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5734F326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhC3V1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhC3V1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNs0f130344;
        Tue, 30 Mar 2021 21:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=TqYQOsMOO41jCmvDvp7/h3hU+25HSuj3RbvPOn1iPac=;
 b=M5mt9jswrUqP/UBmzvnbI9F92h6+wcQZEy90DnWlSpDP1NOT80kkifuY4PODWEmSw7Yc
 POsOxu2wsdXyJ7mZOxDgz4uXlXf/BYOyJo7gUNyPpfEDwjrsLMN2f+k2keewMcoLUcYY
 rr6K/s8eNvHLSZzALuudBmy9gqxxcEgIdFJ1kTDTjTwKXzBgNc+RyprtPlyJrduRzSuk
 lFpCA2VHSL32uM9jbTKK4b9+yFHyCwP02MTf0rySin6Fe8DxiqpXztwg//ynS0ia+Y/4
 FAyhhO1VuDyK1WI9U1dUi42GF388YzBqqOjU65whq/V85gNhT2dzAR3IaOQKkeK27t2R mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37mabqr8p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULObBP149810;
        Tue, 30 Mar 2021 21:26:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 37mac4ke2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix5H+GrtrJ5NWN1hx4a6kjfYidCgWndHNe9UvO5HIt4nkEce/N0+3E1zAd23kHLOuEGuf+9srzGkuyp4fpp6n4Uqw8gWxcxYXWLR7Aj9v4Q38OqVQ7hzTAQdKRENO7SBCjPOjXqBmOZHskQPgHMWdL6qBUNy8a1rsSCzqUbf8eNknlZdPpdWdKogoPTtjGmOYbvO6Y3TL7/UX4qMfH4M0YxA59f0eD3C69I83XXhg0Q1rjp3bKaUefF05jOoeZg9WM8ZC+yhf2fWFrsko66QZkgnuk7V0NQR4n8G3krdvxX+hQR57oTeRpEiKCqwtiP1mo/YIlmrSUedMJzIoJ0lVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqYQOsMOO41jCmvDvp7/h3hU+25HSuj3RbvPOn1iPac=;
 b=flPzo9u+yzB8Xi8wajFjFUjIFLSRsGQORr1IvBzRKLOfq2wZ22cXNGe4Yia3uD0G0UZgtnexougL6xKfQfW3ISkMJvM8Dp22sEuNIu1OUSdRjCJZcWDima21WdmNtEnKsWcc/q7y2cSup/SwL/ftwjA5wxBW5V0lvC3taN+Vs1WLvErz7iGFgNiWWc186ogrvehQSOsYwVynHoh2sVgl+83iad7o2pjpSiTSSzU5Rh4ufJlXOcIPM6hftZG2HxvRgGRVrxC+nFqtLHytjwyXPEMFWluFwkDDCq4C7bBTmtpPc3RHVvBQyPRNVaHmhH0TZX/LtaqoGs6AWPKXRQmEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqYQOsMOO41jCmvDvp7/h3hU+25HSuj3RbvPOn1iPac=;
 b=XDn+y5FyqbhjHE8m97Ti33i4ALLXKshXOrKKsKJVeArk7sHIQjeO5uN6X+LWBXOCIPOvqPvOd29p1HnO3KTMB+aQTk4eDp4ZNATzms4r9/TOkdDlUD7z1pBULSU/KcB2PpwrumDuANjcfNIEiz78iHdnuuQQH/zr7Ex38dkcRe8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:26:17 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:17 +0000
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
Subject: [RFC v2 18/43] kexec: PKRAM: avoid clobbering already preserved pages
Date:   Tue, 30 Mar 2021 14:35:53 -0700
Message-Id: <1617140178-8773-19-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db216ab1-8c19-4d5c-2265-08d8f3c27466
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613037187205C35314851CCEC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHBppfrhlXzHZZYHnD/QhOxMceqsQboPIIr4Z6hraPIIGzvvG2aKvuRxXTM5zE6xZ5tLft7RLbcPXNiYoD/pRD5ha+6s+5hFHoF2RodrN6QRQU0NWbJobDQAosTjrUgBn3kfsSNkLOm3fzs50yPjZwPVHUH4/xdETU1Q5NvXqk0dIpJ5OZvp/nW44sY7SInCNQkBQvKbRtA3TNmsY5nz0BXsHqd3nTjk1cbwQEk4urL3A3IRa4bCdbXpzWItaQxeBD9NcxX9MvEDdq88jCaGA4VVgOQfgk+pd0ix3KV7b2ebB1iaFbPxXdYB2XOoUJSA6jZO1VYd5wTM4VobYAgXZyJEzsCCH+P2WI4GLEmufdb2r5+HtEDMyzvkOpzHusAg84rrpY2yN6Z7U5eIWuh69qxkPY/yb5IavZHN/P6uFCxXWFXvY7vdhDk3B8dFvxObnvRWemD62Ova6jGqxE6vN2Z7E5bt2wlX86td2IDI0B0cNXYJ7QoccowOMf263X0N6M1iS47CorGXEhDiTRar1OPahl4n7SyMeHoB2dgshfeSAtft99Jap96VXGhnyv9MSisU9Z5IiWj82XADjffEHS45Pt6Ape/FSKji4H08S5ARQBEyuv7KQaXDyTnjghATHhBvht6ypuy+OAqaNlDM1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8FUbDs3YhWwwUkSiyNFYP6RRBgou/MiQ0ri/huH6fa9zL5cBjyHsf/6jFzUu?=
 =?us-ascii?Q?Qtl/jlKT17qszfAJoZBjkL+U1A3IdGLe5/FCffjLvkPLSoIUXb47XVnsncdm?=
 =?us-ascii?Q?uuob17686x+8bbt++zaHBhYSHtOpjBugncHKjxEPmNn6hgR/pnmBlaxDk5g5?=
 =?us-ascii?Q?gKdnB4aLf64Yga7/qQq+D/LiB+xL1E+5hB7Woos0xaj+QrR73/DCw59al7Fn?=
 =?us-ascii?Q?eD6sKbfqAWQUJol0SnDUy5hXpV1U6opX8KxRt5/AjUYAxGHtiJXUCIsROKpB?=
 =?us-ascii?Q?9BSYPgxhrCbaEI2ajBDSPFm/j/+xb0OL8oIBqHtFe+MfJtz3foT455Oo3Ar6?=
 =?us-ascii?Q?0nNTve0dhoEIyUC44b67btY89+HXZrGCCu1Wp+ADGF9d5X6inwJJbkM+5RRI?=
 =?us-ascii?Q?OCI/DZ0mrEVabfNDGKdLFNMJy3TlCMoqUmVLNT0H2+Eoh+Vn/skl0W6N8D+1?=
 =?us-ascii?Q?8xGpULQUC9w4dKJ2gMw10v7S8Dy6+DHrukKe4GM4zMLdYKvEZ4uH+9Z9KkBt?=
 =?us-ascii?Q?JC3/BRUuIer/VqIX20EwPzWIizMCnB7njiU+JtGjwtuupl9umVIbuW4Kuccg?=
 =?us-ascii?Q?W70Ex6KHBjmDzHf4OcOMHH53YAl5W96bqZif2zulCbHmL4oMz5ckKSCtsSW7?=
 =?us-ascii?Q?Iho+XqcUVO95555SyQxGzFQ+4RqEVUZK8al/0AAid+HyN9hMvKo3oRqoDMop?=
 =?us-ascii?Q?OowBqCUDdgFX/ofZWU3xo/n+fBtzO7nHfLmL+nR8C2ENr81aApG7lD0uGYxv?=
 =?us-ascii?Q?4SPuqWe/YncdbfREg2GgQrMkWYLSXwSwOsz9vwrUZpj/kOYW+Dyc+t2/673L?=
 =?us-ascii?Q?XGYk3U2LcQyvrL/mtBijlE0Kxi5sIbSZxgI5ssM71uDazQEa2NJugnvEc0oA?=
 =?us-ascii?Q?B29FCGriGzzaVF+wpSMJjQOjksOxZD6x9obkJBDEHBhB6WZhxV+ZFqfjNQKi?=
 =?us-ascii?Q?EoNgzYjl/NY04VlYFDaV5NFzsSor4XeVTxfHUS4B9CcoXiCCyf4vK/UH86q4?=
 =?us-ascii?Q?ZBhJRDqqLTCP6XjU5dtMFTmTFP7xAvo25Qyy0G5t+CdLRIXS+yjK8edZhJYG?=
 =?us-ascii?Q?f4HX9WWCaU3RhhELBLwseGqZCJ+oqhBKnrIHJLfGTqcFynyQnTT6Ybmb3jaR?=
 =?us-ascii?Q?KwrDFmYV/d1Z26wJarUL0+0Yrru6Vdrs7L1+f+UPTv8AJBwX6ZYnn9AQXUzR?=
 =?us-ascii?Q?WXFN9PY+x8//a9pxvuc7irhBmW/1jBVswzj0APX26BChG7U8WoYyBWecAoOE?=
 =?us-ascii?Q?TFEY/5N3VnZWP4hm5YPK7nUbT+i4iMjx3Ip8AAnYg/RElO8i/jWzOzWm/Xh8?=
 =?us-ascii?Q?iYgdYr3PHHuz7TA5IY/nT+7x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db216ab1-8c19-4d5c-2265-08d8f3c27466
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:17.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAP8vukwnKNZHLwXyyzb7FFycp9YUKBtVWUFTYgh/nW/wll/FP4dK+nP/t1sJNsVk+Z5B6EbHrEbHnFV8f/uERhZ+5yTekTSWyuRTbAQiU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 5DBEe8JZBf-F4VqmMycDIcibzkt4Vii1
X-Proofpoint-GUID: 5DBEe8JZBf-F4VqmMycDIcibzkt4Vii1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure destination ranges of the kexec segments do not overlap
with any kernel pages marked to be preserved across kexec.

For kexec_load, return EADDRNOTAVAIL if overlap is detected.

For kexec_file_load, skip ranges containing preserved pages when
seaching for available ranges to use.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 kernel/kexec_core.c | 3 +++
 kernel/kexec_file.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a0b6780740c8..fda4abb865ff 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
+#include <linux/pkram.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -175,6 +176,8 @@ int sanity_check_segment_list(struct kimage *image)
 			return -EADDRNOTAVAIL;
 		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
 			return -EADDRNOTAVAIL;
+		if (pkram_has_preserved_pages(mstart, mend))
+			return -EADDRNOTAVAIL;
 	}
 
 	/* Verify our destination addresses do not overlap.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1ec47a3c60dd..94109bcdbeff 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -516,6 +516,11 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 			continue;
 		}
 
+		if (pkram_has_preserved_pages(temp_start, temp_end + 1)) {
+			temp_start = temp_start - PAGE_SIZE;
+			continue;
+		}
+
 		/* We found a suitable memory range */
 		break;
 	} while (1);
-- 
1.8.3.1

