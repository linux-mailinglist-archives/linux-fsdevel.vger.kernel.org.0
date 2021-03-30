Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE8C34F383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhC3VaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:30:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50814 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhC3V2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNsLF130340;
        Tue, 30 Mar 2021 21:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=W+2R26l/jbQHknYkilwgK0LZFItVSlSZ+UXGymf9uJM=;
 b=txt5SPlN1eDtVstaB+GVMVo9RJhry++cPXEjDowMs2dPT/C62xfmWeXBsgHPj2AHwuvv
 +uI9JbdlHmRzSUC+mIX1RfvhbaUBmyyaNFa1QbV0p+1oNwoM/I9FXObgCGREGlb/l9Vq
 Dg1ouJFInqmx2jFg1qq2rz1NI1un1CFArVGVu4VWbloGcjJWSwCATs+Sq+fqcDDUdGcg
 U9D1P0Cjb+K2hWKFfajlbDeqW3u7P924ib1DNEfEQPlLuiOPQqfpzcU1fWwsHuc7qKAM
 OyvkRIEWtqeZaeoJIGqpWWx81Hxky3mudz6oWLVvFZWGIkiTXP69kPzM2YVCrzMuFe4j IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37mabqr8rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:28:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZb0124960;
        Tue, 30 Mar 2021 21:28:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 37mabnk8gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsPjDv1VMCV4qNQIw79EDl4hcMAXXEpDGzJmttoCF5EUF5i3mO0e/bEWOWqUMl1oOwAZ2D3kJvMQ6GFk7er3jbpvlwiKf4l6ZyISE0eud1NmC8uTN85/lm2Rf9KfIxV/FWpClC6QdXf0LQSn3DYz8QRpt2b0E7pjT64o7wbYun9zQNpbdJCV/q/JSHAMIjKbDnnyu/DPFM+6sG6jGq+H89HbJxyUWAQx134eFemXAmUoJAXG4+NPkwUNlyXBgD98GmlwiIjQkVau9g0ZUiWl67HXQSWt97gX0T0jxQ7xNBq6NvejBHpvEHsBdC6g/A67bNt2hnzJxP0VxixCVlVaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+2R26l/jbQHknYkilwgK0LZFItVSlSZ+UXGymf9uJM=;
 b=mwiylNCkOluAyc7mFLaXHCNE6yudxQXmxgceChvA/3pvI+MLBrxFFa07HxNFkKyj4QqHEDLFRQRoPxMKarkoV/nSAHqpj8GKATXusVztLbDgc1sqib5LOYjENO0WaukhcsPmzGpmn/qkMkTA0QmT92//DPmrzJO2/cAxGZAPtD+eE2v+pngBbm36sGMa2ommFzPzt1hZohMHUbwmpw9YqAK6odD9RfOcHkxpNaslpU6rtHbvtOEu0w37+EPVPwCA3AV8qnNXLe+qPLg0fdsg9MsLPezwWWHX9/Vrdttog7McBZ4cWpnQlpMGuY7KQbtBbuX4Dpp22xUGcaIrhsfZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+2R26l/jbQHknYkilwgK0LZFItVSlSZ+UXGymf9uJM=;
 b=KkouIs0/g7IFiU9V2G0ermIa92u/o1taKxlwn3fYe5fssq/QFb4EER5hJLbspirUoEhp5BNCOmxW1dUV+C8EdXS8wNjSjhkLCfUM+GYYS2KlSL/1q37FX0Z7E1uEjlxUzjiA0dfCEkd6HQOfwplCsHzcZD10Beuyd3pm9HVkG7g=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:28:02 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:28:02 +0000
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
Subject: [RFC v2 42/43] shmem: reduce time holding xa_lock when inserting pages
Date:   Tue, 30 Mar 2021 14:36:17 -0700
Message-Id: <1617140178-8773-43-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2968816c-fbad-40c1-a7d9-08d8f3c2b30b
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB526573F732CA583FA0965EA1EC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zl3A8O/dAkiKli2SgzMfqMMmurty71GgTXHimiE2DEJ0BFWLBlCdAieDS93Bl7vmtzVRVXIjJdeySlQxztUdhhldIuePDdvleQO+Ee7OQYCYIqypqMHH1B0iYr3eJmrQCvxwlsKrM8L/5iYjXAR/TOI91ufcrskBoRFZ1apynPOP2I1h8W5D185telCFzMp19/K/G81KKmCKajCp+cyriOUJ2YKxAjh6H6EbI5+zmMSMaW1qbu7Irni4ZKAWdkxxQK1V0T51Te8KiUjtxM/CMQWfMsSM6CHQd+IEkNXI1E6LwtO5JdBF0fV/rhav3bJaWEiuiDLV7PUtKvFawkYahASV0caJwDec71NDhZ+TbpKKJH5+4FIV3/pGHBxNs6XbM+/d1QPJVU/jIgTvELNZjYlTh+aAFxNr2kQj25thZGwjEJOreLDJEaEOUQtFy1DAKetpMCG2x1KTXbpQRBBuxxCYMm+ATmT2Hg7OISyLFCtbst8p44N3wDUWR/U/tMDCd3cuGECk2meZ2QFSV3NnmCzgqNjhhLNZtPai5ZXuRIY2gVBT9bSVXm0vQTJ9wPQPhZV7jmVAdF6iUzk13x7TGIimDn2IzIaaCZ+M2Qxbj3fQNnZvOAPtiV8QgRG4WQflNvsM0qdRLrWOJ+lWrnxXyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U1uXoOr8ojdDFkag3sklQ3PfJ7XE/YT9Ywts+DuiLeNaKxbDFcJbceeqwMYJ?=
 =?us-ascii?Q?T/8FWJA5MJ0fhuRUdTFY7RfW/GnGsFYfXXNLEoVDy6N9mSCvl+Y3FhJjMFYO?=
 =?us-ascii?Q?e+w+V0e4fGamE+ewtnT8c6AGc5ZtxML7XWnXl6QZ1FwIZZY+JYfHqpEs6rDv?=
 =?us-ascii?Q?rdFPBpaDEothgI6wiazZVJzSh9Cq7jtzwqcJxwFO0+6+jshmNod5UQGfvd6H?=
 =?us-ascii?Q?1+YOKiLesJ3l0x/rnVcaOX5dC8t9j1xVBtTCprXlCBYQzwsFo0kjNz/p3FOp?=
 =?us-ascii?Q?ULe2twf9gr+84/zkEC3L3a2HibQ64LJhJUkKbKUNDs0xbb1DxwwVtaVdi0d0?=
 =?us-ascii?Q?W5UY6y2CoXSL1EciMI1kcQHcUrD+Emi+2PlqqFhz9R7iqI94VcaA+2EkCqO4?=
 =?us-ascii?Q?sukoeE2g1ZKamPq9CdiydLJgOVsRAqcS/TgQUSLod2Sz3QBirfJWFEVVkeGs?=
 =?us-ascii?Q?dCeOqxRtQVp/h9pIo5cRlrEHVNtvgEI7fzCSQ1CyPSxhCF7+CrcLS4Ce/8et?=
 =?us-ascii?Q?jw4Vu8c4oodw9zMcz/idqPEJlj7tae/j+QCM34nprisS/Gd9ntiE0zu2O54S?=
 =?us-ascii?Q?lZvriD79mG89mBoajD7GyDH8kdwiIRwrKMxrc6VCnZsfNVFQ63fz83Xx5KOr?=
 =?us-ascii?Q?VuyMUXuhoL9Pd34Q2hHKR+HEB4fsHUWU6i1Q/aEQ+Ph8mFXWg0x4QbQJp3ZO?=
 =?us-ascii?Q?/iXmGydfIggJVQ/4Rv9H38cIRI4GYZ5wkiwbKK5lUQ9EAVPJYBq2mIXju1Dk?=
 =?us-ascii?Q?kDh26XH6iaeblrEN+sK9Lo8+VFfuTqt0MZVQjLQclag5+R3Ng12+YL1XRev9?=
 =?us-ascii?Q?nTftSd0iZvTxP2OwoI1p/iTo3AyPwD5SI9nf7XXYUCjbuLgNdUxxo9Epmjlv?=
 =?us-ascii?Q?hyOKgwRHe7EpYhlRA6KOqO44Kvn6jiIlevWBzqHy4PgVTSHcFtiJzDhNF2yY?=
 =?us-ascii?Q?H5rwXWRB9dsLoJ0Ea/oh8C0nrrB5yUpmEMf9PsdeJzrw9866JSvoQ/sqlzbx?=
 =?us-ascii?Q?qxSJXPqCn9pE9aCbh9cbl9KqYyxs08MIjKRpjo7tWgOoMR8SKPTg3P4K3nTv?=
 =?us-ascii?Q?ntGCxe1+A2wH55ktCxvOPJcdGSXddlpjkgKW6nZfImP8aLYbdQH1LW9D2ySZ?=
 =?us-ascii?Q?52LdSbcnLnDLiXCQTwWSr/te+oCIApGRgcFbKkBZKUl08yCAmBpWvf43XaNn?=
 =?us-ascii?Q?QgiWmpOUMHk5LaDSMv+UQW34O4TqCOgwi9HD6poTNBrdCtvPa3hx72CGi+y7?=
 =?us-ascii?Q?3OIXux6wk0IpCcEideg43DbevXtxf97RnC35VkBjZk8qUO1tFYtyNYP8tR8a?=
 =?us-ascii?Q?85l4a7/8kSJl5vDcmWzqU22J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2968816c-fbad-40c1-a7d9-08d8f3c2b30b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:28:02.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvHTgmyMOGLTu8z6eBYEXfwjhYXVJyhn53hzcenuA6hEAbUnUeCixQ4PaVp08pdNSoXabtgVCeyF+Y1lScCOmqbZrldMpcbwUnBNYnsDlEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 8CgPjS41eBgvje_ZLWd54FkTPChxd2ux
X-Proofpoint-GUID: 8CgPjS41eBgvje_ZLWd54FkTPChxd2ux
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than adding one page at a time to the page cache and taking the
page cache xarray lock each time, where possible add pages in bulk by
first populating an xarray node outside of the page cache before taking
the lock to insert it.
When a group of pages to be inserted will fill an xarray node, add them
to a local xarray, export the xarray node, and then take the lock on the
page cache xarray and insert the node.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f495af51042e..a7c23b43b57f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -827,17 +827,149 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_aligned_to_page_cache(struct page *pages[], int npages,
+					   struct address_space *mapping,
+					   pgoff_t index, gfp_t gfp, int order,
+					   struct mm_struct *charge_mm)
+{
+	int xa_shift = order + XA_CHUNK_SHIFT - (order % XA_CHUNK_SHIFT);
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, xa_shift);
+	struct xarray xa_tmp;
+	/*
+	 * Specify order so xas_create_range() only needs to be called once
+	 * to allocate the entire range.  This guarantees that xas_store()
+	 * will not fail due to lack of memory.
+	 * Specify index == 0 so the minimum necessary nodes are allocated.
+	 */
+	XA_STATE_ORDER(xas_tmp, &xa_tmp, 0, xa_shift);
+	unsigned long nr = 1UL << order;
+	struct xa_node *node;
+	int i, error;
+
+	if (npages * nr != 1 << xa_shift) {
+		WARN_ONCE(1, "npages (%d) not aligned to xa_shift\n", npages);
+		return -EINVAL;
+	}
+	if (!IS_ALIGNED(index, 1 << xa_shift)) {
+		WARN_ONCE(1, "index (%lu) not aligned to xa_shift\n", index);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < npages; i++) {
+		bool skipcharge = page_memcg(pages[i]) ? true : false;
+
+		VM_BUG_ON_PAGE(PageTail(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageLocked(pages[i]), pages[i]);
+		VM_BUG_ON_PAGE(!PageSwapBacked(pages[i]), pages[i]);
+
+		page_ref_add(pages[i], nr);
+		pages[i]->mapping = mapping;
+		pages[i]->index = index + (i * nr);
+
+		if (!skipcharge && !PageSwapCache(pages[i])) {
+			error = mem_cgroup_charge(pages[i], charge_mm, gfp);
+			if (error) {
+				if (PageTransHuge(pages[i])) {
+					count_vm_event(THP_FILE_FALLBACK);
+					count_vm_event(THP_FILE_FALLBACK_CHARGE);
+				}
+				goto error;
+			}
+		}
+		cgroup_throttle_swaprate(pages[i], gfp);
+	}
+
+	xa_init(&xa_tmp);
+	do {
+		xas_lock(&xas_tmp);
+		xas_create_range(&xas_tmp);
+		if (xas_error(&xas_tmp))
+			goto unlock;
+		for (i = 0; i < npages; i++) {
+			int j = 0;
+next:
+			xas_store(&xas_tmp, pages[i]);
+			if (++j < nr) {
+				xas_next(&xas_tmp);
+				goto next;
+			}
+			if (i < npages - 1)
+				xas_next(&xas_tmp);
+		}
+		xas_set_order(&xas_tmp, 0, xa_shift);
+		node = xas_export_node(&xas_tmp);
+unlock:
+		xas_unlock(&xas_tmp);
+	} while (xas_nomem(&xas_tmp, gfp));
+
+	if (xas_error(&xas_tmp)) {
+		error = xas_error(&xas_tmp);
+		i = npages - 1;
+		goto error;
+	}
+
+	do {
+		xas_lock_irq(&xas);
+		xas_import_node(&xas, node);
+		if (xas_error(&xas))
+			goto unlock1;
+		mapping->nrpages += nr * npages;
+		xas_unlock(&xas);
+		for (i = 0; i < npages; i++) {
+			__mod_lruvec_page_state(pages[i], NR_FILE_PAGES, nr);
+			__mod_lruvec_page_state(pages[i], NR_SHMEM, nr);
+			if (PageTransHuge(pages[i])) {
+				count_vm_event(THP_FILE_ALLOC);
+				__inc_node_page_state(pages[i], NR_SHMEM_THPS);
+			}
+		}
+		local_irq_enable();
+		break;
+unlock1:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
+
+	if (xas_error(&xas)) {
+		error = xas_error(&xas);
+		goto error;
+	}
+
+	return 0;
+error:
+	while (i != 0) {
+		pages[i]->mapping = NULL;
+		page_ref_sub(pages[i], nr);
+		i--;
+	}
+	return error;
+}
+
 static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 				struct address_space *mapping,
 				pgoff_t start, gfp_t gfp,
 				struct mm_struct *charge_mm)
 {
 	pgoff_t index = start;
-	int i, err;
+	int i, j, err;
 
 	i = 0;
 	while (i < npages) {
 		if (PageTransHuge(pages[i])) {
+			if (IS_ALIGNED(index, 4096) && i+8 <= npages) {
+				for (j = 1; j < 8; j++) {
+					if (!PageTransHuge(pages[i+j]))
+						break;
+				}
+				if (j == 8) {
+					err = shmem_add_aligned_to_page_cache(&pages[i], 8, mapping, index, gfp, HPAGE_PMD_ORDER, charge_mm);
+					if (err)
+						goto out_release;
+					index += HPAGE_PMD_NR * 8;
+					i += 8;
+					continue;
+				}
+			}
+
 			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
 			if (err)
 				goto out_release;
@@ -846,11 +978,29 @@ static int shmem_add_pages_to_cache(struct page *pages[], int npages,
 			continue;
 		}
 
-		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
-		if (err)
-			goto out_release;
-		index++;
-		i++;
+		for (j = 1; i + j < npages; j++) {
+			if (PageTransHuge(pages[i + j]))
+				break;
+		}
+
+		while (j > 0) {
+			if (IS_ALIGNED(index, 64) && j >= 64) {
+				err = shmem_add_aligned_to_page_cache(&pages[i], 64, mapping, index, gfp, 0, charge_mm);
+				if (err)
+					goto out_release;
+				index += 64;
+				i += 64;
+				j -= 64;
+				continue;
+			}
+
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
+			if (err)
+				goto out_release;
+			index++;
+			i++;
+			j--;
+		}
 	}
 	return 0;
 
-- 
1.8.3.1

