Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE434F307
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhC3V1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60782 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhC3V0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOe4T122849;
        Tue, 30 Mar 2021 21:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=AxqWT1rxHcU/XXNYUpQ7s9IYct8dM1BqesJ/k3PzW/g=;
 b=QHl2GQI+nsi42x0JX4AArt0mZ31DluWQjYcxLtAxr0nvyqzrml9ED0+tIjwjFDB9h75a
 Dj1yUJbSX18jwYej+OEZGK+6QZeCTeB8cf0DZCbEYqiEOBXD4Scmw81MxcH5dAtHgXmo
 31SnuozpGKs4zZ9GYDFDaXotayQM5CNShwr1AySc/dpe2FwV7JtQutw5ypXE7ZvW+cDh
 6FQQ8Ymab5hEOLS4GmKB2xFhKpE3EIKgRVYIwemroe26bw3DDgzrsBse+8+GRovP3WRv
 Knx3cxsYLbzdlWJGdKpaURxF/clWeczzdoKTltI6SmK496LXWyZhth6P9/RLKSmme3cl 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37mafv081b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOmgq183961;
        Tue, 30 Mar 2021 21:25:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 37mac7u3x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDJ8jGpN3LFyWzgJuBsQ261ZrdAU3q28tPL7yZ2RFrOeDDzpwPRfAw1pfvo7Xwd0g1GxpEdaGJqpOtjeTVfHr7pNZHy3MXd8r1DblH6ORadpAcvZON9MGKMrSSQPDsJCQ+hbSQip1qXGNVfc2sRbbRfGJO1VZAa0dvitpDKIt2/CPiQ1xILdZmrUmoj1MIvtQcyW3CfiSx5rjOXHQROiPLSoFjvcjchQlgwUx9tk0r8f4GLY4zL8tXfCSdW3/dEyHRGqZmDjEMu6v9c5kk2ekZgxWiXtj22FUcYjC4U97U9Og/uggr9pHL4fN2skMuB22aVJmxyQfG3ov65Zy6Lf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxqWT1rxHcU/XXNYUpQ7s9IYct8dM1BqesJ/k3PzW/g=;
 b=MuthlqeaVTRJ24s5/RnIqWu3JbjSyseai2goRcFBp0hUYvEF0HE5AfNPCIyqRxPe2Jynid/kKaRsui9/HSzIPAqc+ODcfVm0t7giBnOgN8QJ1s0U50H4FnEhRa8uiadZQlJDYUhJ5p+Zpyeob7+IJUiq4Zf82nV7r+MDExfRyyRIezZWylCc7mLDrfjnEM5gnMjzhYz91pnCPagMiIt+Ke6Y91G2FvyN1+00W0gvL977mBTc4Tssbc7J5MbQDqhzacVZLv6I0viMEPBVwuJQ3kpwC16nbgwtrCwVBPWoSAcYNs81wFb4aquV1BMlbLMv3U4rKbZIY2eNZkpXKaaG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxqWT1rxHcU/XXNYUpQ7s9IYct8dM1BqesJ/k3PzW/g=;
 b=GkmZFhzQ6of8T3OoYOJzKG9pqNl0A02WKCHAKyr0EjqM30Vz5BNlbA0sO/xig8cE4xQMJa8YvVfhvPMVCo1ul/x0rJTqg8vEa9JxGpZ36ibk6Uwp3xcJPd6gc/hbLwforgFSiPN16xtEgFXHBddLJaPluOOxOASKhaJYh1vzalQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:17 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:17 +0000
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
Subject: [RFC v2 04/43] mm: PKRAM: implement page stream operations
Date:   Tue, 30 Mar 2021 14:35:39 -0700
Message-Id: <1617140178-8773-5-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b155224a-f0c4-4133-dc48-08d8f3c25043
X-MS-TrafficTypeDiagnostic: MN2PR10MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB31208259D7B530EE60A64700EC7D9@MN2PR10MB3120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqyr0Ig/r1lLnhDSIHtcP97++NlP50F5v7uv9dH/ziMveZ4ZQp8kILQ22T6UbgrwTWlhzF7mxg6EqXDeZf7JxgUi1Uq/skUChd0b55I1ZMG3Ytn+rUmr/GX+M6RwOCrX7lDtTj5J16yj0ybt8Z0plcZpEt6h0spSgNQ1NlMyPY+axDMaiZZC0rrWe1UsSzSsS1FteUCjl9+tZHX/j7AaZWIxB0DitvCg8kxkwCqfoYCW5of7leZVlHcGKndT1GggK6UtN9g4VPItJLNEH2iIiKVm9BacP50fX9rpbL9PACDs+PjZFTfZyAh8graT+zn5LpesFwlXpv6+NgCwohFi0MtVDxtfpnId+nefotYNeRg+intc+uiviOdN+efPW6xSZKW3zbEHtpnK91eqTJY2DN2CoQO4kHVlFXgOb9htS0FC/tvMgpSc4uKvN3Qv/Jm88Q1psDRJYGCAsm6q+AsqI/yDYster/4QmWYfcLYBDJs79nqf+C0MXeWaK6q2F62EXd2Hy22XaQESIYExTSzmNDd3MmSkKqvJoK2nPde7zN3mPw8QdDhO16h1VsBQMojPV7+b2bQcDAXx32dc8FQxIaC/Zt+JBqfks3UoyJMpAXd10qOyg+9kCbiljW1YHbJxEJzFFgme1eAW6rjXtz0Pl3yMMAAc8FsKabVhk4uJlAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(52116002)(316002)(186003)(6486002)(16526019)(5660300002)(2616005)(956004)(6666004)(8676002)(66556008)(44832011)(478600001)(83380400001)(7406005)(38100700001)(86362001)(7696005)(30864003)(66476007)(66946007)(4326008)(2906002)(26005)(7416002)(36756003)(8936002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j4lMNZD9ALExZXGOG7DTi/OQ8kKcQZozG3Ki1JnjQClGVqL996hkLlQEi94P?=
 =?us-ascii?Q?pIXR4vajHKVWLwXcoIaw49OT0bCeOoLmLwfXw9M2xlbruyelJoLR7tS9FPOT?=
 =?us-ascii?Q?lPVQm7PTeKB4HclvWvyfXOUxfNTLzi7mB06W0DSJHfi8dM1682cmI4HoRAce?=
 =?us-ascii?Q?lt7YDMOo4KcHSKqUdCp6q7OEQb/XMYHZoqHSg5BNNw+2sbsMZpVbmVojHR00?=
 =?us-ascii?Q?cijpo7pZFQGztK88MmROchsH1R+wFnMF4MB/RrYiFGwW1Wxg5i2CFnxnfPig?=
 =?us-ascii?Q?Ck4Hni/R0izajhSu+qiONPtmNiud0z+UHUEBsJ71b2ktSIGNpMXz3s/mFQGT?=
 =?us-ascii?Q?cWvmIDG8PkuVG/ekOw1MXhyk2ROQuZLnfKKBY0zEGPOkklSlTFPPBxGEJvlU?=
 =?us-ascii?Q?15IyFMTpZzZHzoHaNeZcQKQL9Wroc/nhhENpiJS5rhQjw+46d+xCHB/zXXn/?=
 =?us-ascii?Q?r+pfHMo2c9pbHaIjjv/hAkZtz8wB9uqUekJokOI0Z2IoHLrsir1Zwopy54hX?=
 =?us-ascii?Q?7Ky6fQnSJCrfW+vruX9U2Q3CYZ2lkzRFkOEuWdLgVk0GYu+h9iBQEwVAhtbA?=
 =?us-ascii?Q?HprI72hkxbJ3Rt1okC3uPevEpcK2D8bC7DznZ0QXAI9vG9tuSGW8QUzoR+xJ?=
 =?us-ascii?Q?zY+Rm9mH+wHgGDopnI6YlrneBwiXLFp0pmMa3BycpFAFCsC4k7W0mUaVx3PI?=
 =?us-ascii?Q?Xy+xZW0HcB2qvX+kv/WGKw2goE8wufowNQKu8JN13YKUIGmdAe0jZkRttbzd?=
 =?us-ascii?Q?uEfxSGuAR4QG71gb+LQeXnbatjhGIi7+eYMJK6m/alyMtQsNtYbiKwAKHnVo?=
 =?us-ascii?Q?QSwi4fjRHiLFIcVash/8OwihapUmVbSnOshfE+NVhLIKfpUXVGCvv+j0KmBB?=
 =?us-ascii?Q?qYlnOtGEbK4JriQDS29s1wwLgDpil5UPwglVrXBVSSkuj6PecMMp6ecqJlsw?=
 =?us-ascii?Q?wLHbRjqHxoR1/GPwKQz3oXgLzJjDkY3eckD7/qIo0mkYLmGmCQWbstiKc7u6?=
 =?us-ascii?Q?wr4//sBIFy0TYNVlDjY6Z8076kITpKg2+ObwNCTnBocjtOyDSJO5AinDN/cp?=
 =?us-ascii?Q?jKvPQE/yZpc85OfbbFBcqobePu7BzvE1jPPJ67eHzRDCDxukdF9KJDE1bfb6?=
 =?us-ascii?Q?tsNgVQLFIWbrtUmQ1xdU1uPrbjh+hj6deJAlfGvjA0sVl6D81nhyyZHYatxX?=
 =?us-ascii?Q?i/6JSKUkKe1lPZ8CMvFIVnCi6YVhQwD68RlTPxiRHNdoYPN23160Y1bR5vQd?=
 =?us-ascii?Q?E8SQ0E2xSwAsphQgqrPPwgrwaMzwB6jx/UhpvVkSCUUEcHNna145Xq+epUuy?=
 =?us-ascii?Q?lgafeT7XmY2VkybwsauJl6KW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b155224a-f0c4-4133-dc48-08d8f3c25043
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:17.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipqDJOMz3CCh+vJADVSqBkJfGtmYS8LQXUs0HOVIxGPsZOhJF4XLHu7fJ1fXQ2oGE4BzPG0i60Frv0azVYShnewXNhurh8g9wMi1CMOXNRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: W7j8EXabPEzyqVZ-WpFAhKeiVGDRRETF
X-Proofpoint-GUID: W7j8EXabPEzyqVZ-WpFAhKeiVGDRRETF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using the pkram_save_file_page() function, one can populate PKRAM objects
with in-memory pages which can later be loaded using the pkram_load_file_page()
function. Saving a page to PKRAM is accomplished by recording its pfn and
mapping index and incrementing its refcount so that it will not be freed
after the last user puts it.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  42 +++++++-
 mm/pkram.c            | 282 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 317 insertions(+), 7 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index a4d55af392c0..9d8a6fd96dd9 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -8,22 +8,47 @@
 
 struct pkram_node;
 struct pkram_obj;
+struct pkram_link;
 
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
+ * @PKRAM_DATA_pages: obj contains file page data
  */
 enum pkram_data_flags {
-	PKRAM_DATA_none		= 0x0,  /* No data types configured */
+	PKRAM_DATA_none		= 0x0,	/* No data types configured */
+	PKRAM_DATA_pages	= 0x1,	/* Contains file page data */
+};
+
+struct pkram_data_stream {
+	/* List of link pages to add/remove from */
+	__u64 *head_link_pfnp;
+	__u64 *tail_link_pfnp;
+
+	struct pkram_link *link;	/* current link */
+	unsigned int entry_idx;		/* next entry in link */
 };
 
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
 	struct pkram_obj *obj;
+
+	__u64 *pages_head_link_pfnp;
+	__u64 *pages_tail_link_pfnp;
+};
+
+struct pkram_pages_access {
+	unsigned long next_index;
 };
 
-struct pkram_access;
+struct pkram_access {
+	enum pkram_data_flags dtype;
+	struct pkram_stream *ps;
+	struct pkram_data_stream pds;
+
+	struct pkram_pages_access pages;
+};
 
 #define PKRAM_NAME_MAX		256	/* including nul */
 
@@ -41,8 +66,19 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
 
+#define PKRAM_PDS_INIT(name, stream, type) {			\
+	.head_link_pfnp=(stream)->type##_head_link_pfnp,	\
+	.tail_link_pfnp=(stream)->type##_tail_link_pfnp,	\
+	}
+
+#define PKRAM_ACCESS_INIT(name, stream, type) {			\
+	.dtype = PKRAM_DATA_##type,				\
+	.ps = (stream),						\
+	.pds = PKRAM_PDS_INIT(name, stream, type),		\
+	}
+
 #define PKRAM_ACCESS(name, stream, type)			\
-	struct pkram_access name
+	struct pkram_access name = PKRAM_ACCESS_INIT(name, stream, type)
 
 void pkram_finish_access(struct pkram_access *pa, bool status_ok);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index 7c977c5982f8..9c42db66d022 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
@@ -10,8 +11,39 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#include "internal.h"
+
+
+/*
+ * Represents a reference to a data page saved to PKRAM.
+ */
+typedef __u64 pkram_entry_t;
+
+#define PKRAM_ENTRY_FLAGS_SHIFT	0x5
+#define PKRAM_ENTRY_FLAGS_MASK	0x7f
+
+/*
+ * Keeps references to data pages saved to PKRAM.
+ * The structure occupies a memory page.
+ */
+struct pkram_link {
+	__u64	link_pfn;	/* points to the next link of the object */
+	__u64	index;		/* mapping index of first pkram_entry_t */
+
+	/*
+	 * the array occupies the rest of the link page; if the link is not
+	 * full, the rest of the array must be filled with zeros
+	 */
+	pkram_entry_t entry[0];
+};
+
+#define PKRAM_LINK_ENTRIES_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_link))/sizeof(pkram_entry_t))
+
 struct pkram_obj {
-	__u64   obj_pfn;	/* points to the next object in the list */
+	__u64	pages_head_link_pfn;	/* the first pages link of the object */
+	__u64	pages_tail_link_pfn;	/* the last pages link of the object */
+	__u64	obj_pfn;	/* points to the next object in the list */
 };
 
 /*
@@ -19,6 +51,10 @@ struct pkram_obj {
  * independently of each other. The nodes are identified by unique name
  * strings.
  *
+ * References to data pages saved to a preserved memory node are kept in a
+ * singly-linked list of PKRAM link structures (see above), the node has a
+ * pointer to the head of.
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
@@ -68,6 +104,41 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_link(struct pkram_link *link)
+{
+	struct page *page;
+	pkram_entry_t p;
+	int i;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		p = link->entry[i];
+		if (!p)
+			continue;
+		page = pfn_to_page(PHYS_PFN(p));
+		put_page(page);
+	}
+}
+
+static void pkram_truncate_links(unsigned long link_pfn)
+{
+	struct pkram_link *link;
+
+	while (link_pfn) {
+		link = pfn_to_kaddr(link_pfn);
+		pkram_truncate_link(link);
+		link_pfn = link->link_pfn;
+		pkram_free_page(link);
+		cond_resched();
+	}
+}
+
+static void pkram_truncate_obj(struct pkram_obj *obj)
+{
+	pkram_truncate_links(obj->pages_head_link_pfn);
+	obj->pages_head_link_pfn = 0;
+	obj->pages_tail_link_pfn = 0;
+}
+
 static void pkram_truncate_node(struct pkram_node *node)
 {
 	unsigned long obj_pfn;
@@ -76,6 +147,7 @@ static void pkram_truncate_node(struct pkram_node *node)
 	obj_pfn = node->obj_pfn;
 	while (obj_pfn) {
 		obj = pfn_to_kaddr(obj_pfn);
+		pkram_truncate_obj(obj);
 		obj_pfn = obj->obj_pfn;
 		pkram_free_page(obj);
 		cond_resched();
@@ -83,6 +155,83 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
+{
+	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+
+	if (!*pds->head_link_pfnp) {
+		*pds->head_link_pfnp = link_pfn;
+		*pds->tail_link_pfnp = link_pfn;
+	} else {
+		struct pkram_link *tail = pfn_to_kaddr(*pds->tail_link_pfnp);
+
+		tail->link_pfn = link_pfn;
+		*pds->tail_link_pfnp = link_pfn;
+	}
+}
+
+static struct pkram_link *pkram_remove_link(struct pkram_data_stream *pds)
+{
+	struct pkram_link *link;
+
+	if (!*pds->head_link_pfnp)
+		return NULL;
+
+	link = pfn_to_kaddr(*pds->head_link_pfnp);
+	*pds->head_link_pfnp = link->link_pfn;
+	if (!*pds->head_link_pfnp)
+		*pds->tail_link_pfnp = 0;
+	else
+		link->link_pfn = 0;
+
+	return link;
+}
+
+static struct pkram_link *pkram_new_link(struct pkram_data_stream *pds, gfp_t gfp_mask)
+{
+	struct pkram_link *link;
+	struct page *link_page;
+
+	link_page = pkram_alloc_page((gfp_mask & GFP_RECLAIM_MASK) |
+				    __GFP_ZERO);
+	if (!link_page)
+		return NULL;
+
+	link = page_address(link_page);
+	pkram_add_link(link, pds);
+	pds->link = link;
+	pds->entry_idx = 0;
+
+	return link;
+}
+
+static void pkram_add_link_entry(struct pkram_data_stream *pds, struct page *page)
+{
+	struct pkram_link *link = pds->link;
+	pkram_entry_t p;
+	short flags = 0;
+
+	p = page_to_phys(page);
+	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
+	link->entry[pds->entry_idx] = p;
+	pds->entry_idx++;
+}
+
+static int pkram_next_link(struct pkram_data_stream *pds, struct pkram_link **linkp)
+{
+	struct pkram_link *link;
+
+	link = pkram_remove_link(pds);
+	if (!link)
+		return -ENODATA;
+
+	pds->link = link;
+	pds->entry_idx = 0;
+	*linkp = link;
+
+	return 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -159,6 +308,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	if (flags & ~PKRAM_DATA_pages)
+		return -EINVAL;
+
 	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
 	if (!page)
 		return -ENOMEM;
@@ -168,6 +320,10 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 		obj->obj_pfn = node->obj_pfn;
 	node->obj_pfn = page_to_pfn(page);
 
+	if (flags & PKRAM_DATA_pages) {
+		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
+		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -275,8 +431,17 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		return -ENODATA;
 
 	obj = pfn_to_kaddr(node->obj_pfn);
+	if (!obj->pages_head_link_pfn) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	node->obj_pfn = obj->obj_pfn;
 
+	if (obj->pages_head_link_pfn) {
+		ps->pages_head_link_pfnp = &obj->pages_head_link_pfn;
+		ps->pages_tail_link_pfnp = &obj->pages_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -293,6 +458,7 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_obj(obj);
 	pkram_free_page(obj);
 }
 
@@ -318,7 +484,41 @@ void pkram_finish_load(struct pkram_stream *ps)
  */
 void pkram_finish_access(struct pkram_access *pa, bool status_ok)
 {
-	BUG();
+	if (status_ok)
+		return;
+
+	if (pa->ps->node->flags == PKRAM_SAVE)
+		return;
+
+	if (pa->pds.link)
+		pkram_truncate_link(pa->pds.link);
+}
+
+/*
+ * Add file page to a PKRAM obj allocating a new PKRAM link if necessary.
+ */
+static int __pkram_save_page(struct pkram_access *pa, struct page *page,
+			     unsigned long index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+
+	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
+	    index != pa->pages.next_index) {
+		link = pkram_new_link(pds, pa->ps->gfp_mask);
+		if (!link)
+			return -ENOMEM;
+
+		pa->pages.next_index = link->index = index;
+	}
+
+	get_page(page);
+
+	pkram_add_link_entry(pds, page);
+
+	pa->pages.next_index++;
+
+	return 0;
 }
 
 /**
@@ -328,10 +528,80 @@ void pkram_finish_access(struct pkram_access *pa, bool status_ok)
  * with PKRAM_ACCESS().
  *
  * Returns 0 on success, -errno on failure.
+ *
+ * Error values:
+ *	%ENOMEM: insufficient amount of memory available
+ *
+ * Saving a page to preserved memory is simply incrementing its refcount so
+ * that it will not get freed after the last user puts it. That means it is
+ * safe to use the page as usual after it has been saved.
  */
 int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 {
-	return -ENOSYS;
+	struct pkram_node *node = pa->ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	BUG_ON(PageCompound(page));
+
+	return __pkram_save_page(pa, page, page->index);
+}
+
+static struct page *__pkram_prep_load_page(pkram_entry_t p)
+{
+	struct page *page;
+	short flags;
+
+	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+	page = pfn_to_page(PHYS_PFN(p));
+
+	return page;
+}
+
+/*
+ * Extract the next page from preserved memory freeing a PKRAM link if it
+ * becomes empty.
+ */
+static struct page *__pkram_load_page(struct pkram_access *pa, unsigned long *index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+	struct page *page;
+	pkram_entry_t p;
+	int ret;
+
+	if (!link) {
+		ret = pkram_next_link(pds, &link);
+		if (ret)
+			return NULL;	// XXX return error value?
+
+		if (index)
+			pa->pages.next_index = link->index;
+	}
+
+	BUG_ON(pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX);
+
+	p = link->entry[pds->entry_idx];
+	BUG_ON(!p);
+
+	page = __pkram_prep_load_page(p);
+
+	if (index) {
+		*index = pa->pages.next_index;
+		pa->pages.next_index++;
+	}
+
+	/* clear to avoid double free (see pkram_truncate_link()) */
+	link->entry[pds->entry_idx] = 0;
+
+	pds->entry_idx++;
+	if (pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
+	    !link->entry[pds->entry_idx]) {
+		pds->link = NULL;
+		pkram_free_page(link);
+	}
+
+	return page;
 }
 
 /**
@@ -349,7 +619,11 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
  */
 struct page *pkram_load_file_page(struct pkram_access *pa, unsigned long *index)
 {
-	return NULL;
+	struct pkram_node *node = pa->ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	return __pkram_load_page(pa, index);
 }
 
 /**
-- 
1.8.3.1

