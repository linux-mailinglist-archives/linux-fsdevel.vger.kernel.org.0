Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17B34F320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhC3V1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhC3V05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP9x2145305;
        Tue, 30 Mar 2021 21:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=anR3JuhOf2/kaCECJEGMHmimb81ITGwiAVS+xEPtF6M=;
 b=dOfVSRZLmdgwabn2pZONARFU7FGHUM1HEcW14B8nVrBZ0FJ3oyc1cZt9q2ogKAZPL5uS
 YS1r6BV5AWdO+5iA4ObYSQFu7OChbl4Ij+ihHU31j8LVGql83n7t66Y35qmBeSWvcKCI
 FC3T/DQX+AHL/Iq+H2zbbfgt0TJsliiZbalu8bh7uPbBvCS/xH49zxP6m5FL2A+IhhS3
 EvZUbNfc0w190TwRTq+Y8FJYD3IxL1mq492QDSu94x7vPO3DVlrN7UDATxGEW86+fQQc
 Sh2YsyF7He7gcjKcp2ZgTkrclqmdOSVPhhvxZcGu1DiMjcdfzxJUdBiSq5NSv6I3+hls tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37mad9r8ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOblx149856;
        Tue, 30 Mar 2021 21:25:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 37mac4kc6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMnBEyPyoyYn7HLnk2jOaisP6aZJs1SiOaKRl5iHlleYfruE9R/f6dc+WscDmaBoc7Dbvm1nXEmtZpHMNWaOx/yCyFL7i55jzXOwojf6dD4IY7PHI0X73l1OPruYsKCww+T5ji/S6b/xczpqCCEO32ZGyk/bd1w+rkEAQGTXeV4a1nulxcYbXh7Vug/m7ZBslljlepot1SPtlzewVmt4LUKK3p9x/YTnNzY8TGX8euHLezEUmPQB5XbwjBSPM8xlvmVyd5Spi5SZFR2JG4TeBPjRzDm2HPvY6g253rYQ2Omgf7K08BU4Jh38XDsgX+ckkIij7eDs4mPugCptDmTQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anR3JuhOf2/kaCECJEGMHmimb81ITGwiAVS+xEPtF6M=;
 b=dRwnIRdaVvkWBMHlwi8lYHpZxVJ0a0V7ial8IYPmWzOEtUsFToFEEAOBnBDbAAeEL6oy3ypnHha9Y7GE/Hu6RbGRG7awXI3se+a6W5v1UfBCVpTWv6srkddXooV5fa1SYzLpSuHA4omAivcU/wT5JJYimqHg27sBJWGlwxJ9kuEytZIwJvdRB124qknE5cSB6P0UBcMl+lXB5BvHNbFW0T2olWcDvYYzpOpaQUmW4SwInUT1QeK2ZK41glJvymEfTNXkIwvqoQqkorj4XETQPpPid49UQKQV6CU6z+10O1Bhs0aSiSNoyUFNeu9Siwn/I3ZIFX659cWDifjSyYM+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anR3JuhOf2/kaCECJEGMHmimb81ITGwiAVS+xEPtF6M=;
 b=RKYdKXCKO/teL6ersbZb/sgruguN1kC6tUVSlkKzFnqt39lZMYUx7thnpBmYuNO724hUtEA2Rl9h8spIwA+mL34yP/luscSwKPUpi5+HrqB8Vp79ovN0bNAjgcpxNwgg7dLoIo8GgsPpRnkuMDydStcmDczOltm6Gh2IYlqasyU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:12 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:12 +0000
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
Subject: [RFC v2 03/43] mm: PKRAM: implement object load and save functions
Date:   Tue, 30 Mar 2021 14:35:38 -0700
Message-Id: <1617140178-8773-4-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84624cf4-e76b-473d-946c-08d8f3c24db2
X-MS-TrafficTypeDiagnostic: MN2PR10MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB31205C279102FEF31D6455DCEC7D9@MN2PR10MB3120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK1u7bhbLzniP866Jt/ifhzhVfWcUUDu8KAefS7+eYVjmZSILyCnhJKjsxkS+nb/X0fLrLBR7akgpjtSYwb1bIgwrrDcpUa9won4DJnmfZGz4tHbdsyuxOAnjo4EmT7sUhtScVS3Z4ZM/FdFjGRrPIeQ4mnSWt5gDxbCCprkfW/AdFp8sqyhM9Mv0CiZfslG5iIpplJiyc/PBgiCsuLBFUdTJ82728l0uMggFqNmWGC9di2WN8VeTCqTx5t3p4HQ7ru6WGah4wXbCX4C76GFECDtskLo2mF5EatceBkJEdgaFGiIfuYapMHSXmsZ0glipCzNPEQrBC7F146nMQQAMU4fToAPDvKxLxPKtNSCZaVPnMi0nQiCYWFGUhFQTM+oy4UYCZRACDqA+5QOomD+5/Zkz0rh/3bVLQQ5OIFniSOELmJN7KhrS2/p1OvKy/JoB2jH9bynCSXKACbjjzk5QSSb5eDQOtEhtaDp5L0qIav0gDpPLe9yuFsJC+XGQ74JlSTME5UIgw54K1H8dZxEieO+H2N4hgJharYhQCGrHrk94HAHeCCgMo404yMwfiPDSbladsA6V4dNJc6ZuL4YijU+1o3SCZZ7H9pn7oWpr+W5FtA7tLYkLBPwUIJ/ia4JNO/IuwoCY5wSmM/8V68wrbXndmBij73K09AlCJD2LKAS8HMEckoONhi/i8WXVPyi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(52116002)(316002)(186003)(6486002)(16526019)(5660300002)(2616005)(956004)(6666004)(8676002)(66556008)(44832011)(478600001)(83380400001)(7406005)(38100700001)(86362001)(7696005)(66476007)(66946007)(4326008)(2906002)(26005)(7416002)(36756003)(8936002)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mUdEfLqk1UcJ4n+VNMunRH1K6bg4BCk4dI1J0JJKK3IBdziwcVE0yu3Tu51F?=
 =?us-ascii?Q?b1CWgeM4mnD4xSMemxXhEfMqkx1bj5QzlumgWvJ5XtwDXU9zomN7WIDWIhkw?=
 =?us-ascii?Q?N6A/xnIXtL9TNXU73C3RsAD33sm80sSMSxmQnA+M07h4NI6nRVlDcg/yI2iC?=
 =?us-ascii?Q?WAVs68t98qhn6OJL616qOxXyG2iMZ5rDE8HbGW43qQEB0tZJy/CsoCNQ/ZRy?=
 =?us-ascii?Q?HJ+cQ6oDekt7VISQRxOTnjPeFZNfE2HDwJHtl00+UFSKkn0y7aaFOVlWFKP1?=
 =?us-ascii?Q?ggLBGQFAgrTCtCa8f8YbvZSc0atLlL7Ldzmcu4w9nK4xVSzkmjte7gzCx6rI?=
 =?us-ascii?Q?HXRtdES0WKSKT7QMAwdQl1BbF6F8amiq/web+O08867LxSoUanXqP2debfgW?=
 =?us-ascii?Q?Vfl9APwT4vx8k2aUPulplxd5ArzesiYth875K21NueHlVolZzaaTUmJ11CUo?=
 =?us-ascii?Q?UV7EwFYMAXWPw9yl7F/1yZeTd/FpzMmEs3aLci9Bhkb16FNAvD+fVB2Y2V5E?=
 =?us-ascii?Q?Ke2C0LsEAA5mmi7RscKE6tFCHYfyr2RUI/iu4eDO8PviiIxPT5NM3cG2nbIT?=
 =?us-ascii?Q?W1VFKyArdZiCNmw7d8TlkrgLAZBexmcJ/LG7XWTcNo9yWYPxQx2FncelF+C2?=
 =?us-ascii?Q?1USe4dR5/8Xr1oqQR5j0HGgMWKP4+j1Xm/iLIKiQJCuk8t0MpltCR4ZdtZqF?=
 =?us-ascii?Q?KXDXC38uYFKFddJ2wI1o9Rw6wyoFP6iOiGkYKczUSb+2J+SpywV07QMrE63p?=
 =?us-ascii?Q?OOYsgyd1X7J8KNVI7D3QSQNvgynxyRi/8PPIaSiJgtaEgJQY04kYgCTEExQd?=
 =?us-ascii?Q?Rs0XB1MH9ybeG8PpoodzhaegPRd4Iyq6nt0sg3OmAp88+vEOrrW4tO00VC7K?=
 =?us-ascii?Q?9Ps+HB2t2t/eu+r57mt9xI8421rLg0xQ+cm15N9kXW9MoOxupJEboEGCxSwb?=
 =?us-ascii?Q?j54kAb8aZpUAkEkh+r67H8+mUtFCHzbRXav8RVbJIkDionmnYALyobHlruJR?=
 =?us-ascii?Q?4A8K/nrb76Ns13Md3imS4r9sFZG6vbRxKMJf0F8Le6hPCxo5MhI7a9De8RYl?=
 =?us-ascii?Q?JgVeH7Sqn/rTs4xgD7CBKGVFXBUDfJRSqcNsromD8OvOVwv8UIAHLeT39nRU?=
 =?us-ascii?Q?ORPWrF/PBVOtK4Q06CiH1bgF8nA++qInQciZg8403w6D1lxefQ0Wpc5PaUd2?=
 =?us-ascii?Q?yTJkEZI2e7ro7tMpC04MTkkB9Xp2SqyTrkeys2hIdUS0lchtqF/tXFsLaE01?=
 =?us-ascii?Q?OxMW0lqaLVT7H6JQxn3tPQWBTS3VVACtxgCpbDRPESGNa99R5xsq7+grAjLF?=
 =?us-ascii?Q?1ctMRdFHqRg7o2+yjaUBuaEH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84624cf4-e76b-473d-946c-08d8f3c24db2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:12.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKXDpl8Almwx6/03PHwtomxWUmCVmgG5Aqx0OVLHudtK2mtwU+DsD67OupkHQ8TSKzsfcnXfbyJduY5BWQak5bLoIeIvTKF0+6oQOCq+fuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: UfBCMuY7yXcBH0vh78GwREoMME8RVcAi
X-Proofpoint-GUID: UfBCMuY7yXcBH0vh78GwREoMME8RVcAi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PKRAM nodes are further divided into a list of objects. After a save
operation has been initiated for a node, a save operation for an object
associated with the node is initiated by calling pkram_prepare_save_obj().
A new object is created and linked to the node.  The save operation for
the object is committed by calling pkram_finish_save_obj().  After a load
operation has been initiated, pkram_prepare_load_obj() is called to
delete the next object from the node and prepare the corresponding
stream for loading data from it.  After the load of object has been
finished, pkram_finish_load_obj() is called to free the object.  Objects
are also deleted when a save operation is discarded.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 72 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 01055a876450..a4d55af392c0 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -7,6 +7,7 @@
 #include <linux/mm_types.h>
 
 struct pkram_node;
+struct pkram_obj;
 
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
@@ -19,6 +20,7 @@ enum pkram_data_flags {
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
+	struct pkram_obj *obj;
 };
 
 struct pkram_access;
diff --git a/mm/pkram.c b/mm/pkram.c
index 21976df6e0ea..7c977c5982f8 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -6,9 +6,14 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
+struct pkram_obj {
+	__u64   obj_pfn;	/* points to the next object in the list */
+};
+
 /*
  * Preserved memory is divided into nodes that can be saved or loaded
  * independently of each other. The nodes are identified by unique name
@@ -18,6 +23,7 @@
  */
 struct pkram_node {
 	__u32	flags;
+	__u64	obj_pfn;	/* points to the first obj of the node */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -62,6 +68,21 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_node(struct pkram_node *node)
+{
+	unsigned long obj_pfn;
+	struct pkram_obj *obj;
+
+	obj_pfn = node->obj_pfn;
+	while (obj_pfn) {
+		obj = pfn_to_kaddr(obj_pfn);
+		obj_pfn = obj->obj_pfn;
+		pkram_free_page(obj);
+		cond_resched();
+	}
+	node->obj_pfn = 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -124,12 +145,31 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOMEM: insufficient memory available
+ *
  * After the save has finished, pkram_finish_save_obj() (or pkram_discard_save()
  * in case of failure) is to be called.
  */
 int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+	struct page *page;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	obj = page_address(page);
+
+	if (node->obj_pfn)
+		obj->obj_pfn = node->obj_pfn;
+	node->obj_pfn = page_to_pfn(page);
+
+	ps->obj = obj;
+	return 0;
 }
 
 /**
@@ -137,7 +177,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
  */
 void pkram_finish_save_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 }
 
 /**
@@ -169,6 +211,7 @@ void pkram_discard_save(struct pkram_stream *ps)
 	pkram_delete_node(node);
 	mutex_unlock(&pkram_mutex);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
@@ -216,11 +259,26 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENODATA: Stream @ps has no preserved memory objects
+ *
  * After the load has finished, pkram_finish_load_obj() is to be called.
  */
 int pkram_prepare_load_obj(struct pkram_stream *ps)
 {
-	return -ENOSYS;
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	if (!node->obj_pfn)
+		return -ENODATA;
+
+	obj = pfn_to_kaddr(node->obj_pfn);
+	node->obj_pfn = obj->obj_pfn;
+
+	ps->obj = obj;
+	return 0;
 }
 
 /**
@@ -230,7 +288,12 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load_obj(struct pkram_stream *ps)
 {
-	BUG();
+	struct pkram_node *node = ps->node;
+	struct pkram_obj *obj = ps->obj;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(obj);
 }
 
 /**
@@ -244,6 +307,7 @@ void pkram_finish_load(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_node(node);
 	pkram_free_page(node);
 }
 
-- 
1.8.3.1

