Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A134F376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhC3V3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:29:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52280 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhC3V2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPHwI145355;
        Tue, 30 Mar 2021 21:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MfqUNVuTZH17wEzrzvOmISttF92wGuYIZhlq/gCT0PM=;
 b=oEiWCD0oJbRxTK1qzWGzMGr9wwVhX8qX9EnQj1JdmBKiPRId35l3eqRygr9OcUQz/8Yz
 0F2f+TIO02fnueVt5PTBp8igeupNR4XjckTcA91bfRUaB4908XZM+TimaPXM2iin26xn
 9T8gz0RGAzDFnbbnJrwryUjki06KT6E/27MuzdPmwOKocvTe6dhUdVI30nOhL6LsD/j1
 x51fEFy5tOrySJ77mDXu9Sw2x7Rz/EQA1bV2fgb3RJ3uLX18NqShU27JNhnLDdscUCA+
 bs5uC9ElyDjwc6+hbPJuz8Ge4pGHHqen6gJevZETUXarFa/hIfrK4I0qFfYvM40/YDAG Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37mad9r8jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOa1V149731;
        Tue, 30 Mar 2021 21:27:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 37mac4kgkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLrmciJi2i1/MUPuqsQuO0QUcVvHtMJC2zlk0FJoBFVR6srFzhobF7Aj69XLnDzy1Cgv29Whdc6sH5IB0HAZXOzkLiswnncLG2l8yZhW/TXKOsSZLKSu/D+RPbk6G/IWT55OqDP+0yDQ8JiIHYMeh+JIuldLiaKy+/HhI5CQ7eK+dz1nsTX/Kfpe064lmDiFQkrA3on6qBX2Ijnz7cuuQGFzA1/WmHwhjzqDFiIWMRpDJyzeyspDt6qHgwDbxFQsUg45YhDs3RSPIR8UlXN0bIuSYmZtxASpGkvBkVIDqzeRFvpuBps2fqVZEQFsq/YQnDrX0oyzpMIJwIJz5ypjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfqUNVuTZH17wEzrzvOmISttF92wGuYIZhlq/gCT0PM=;
 b=VnV7NRVvm22T5bklS/yjIfsZTYHwwR7pV6cyaf87/HdewIG2/wlqj6FtvXEXpmq5qufyraxJS1tlwmtYGaN2Q8NdnyK73DZwPPTemQlV2y9ZgWIyYpf3l4DAAfSZ3H+ZJ7jQMLVZafMzNXT6xyhEAkxMPovjBWaEyDONfPsXFJkWhorw0YgoOdxiVnE749lRLFfagJjLcZVwjoH6dbZlCve4h/KUqZ4uH/RPCF1brxuNhAicgTpwFmmmlyPJ2zX5t6mrWQwjnFochrPfmTmiU0+oeQ9xuKaD/AKJr+IMCj667nX2ffyxnNHporPU12rYIVcmzvpr/K7EdBC7L8DlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfqUNVuTZH17wEzrzvOmISttF92wGuYIZhlq/gCT0PM=;
 b=fuiXK7as7vXE8QbRQH03DVtN+fxjx0nPIicGkjHtN6bV0zvY5uGMXO734G2lheakNLv/gsOBu9KlsaDBAg9v2l5myP/sujAgBh4oklBudTB2wixYMc/7rXe9xizzIsbynS9YeU+qx8Bp9fNbiOSNYvhqWNS/WdfwH3XCl6ZT7U4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:54 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:54 +0000
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
Subject: [RFC v2 40/43] shmem: initial support for adding multiple pages to pagecache
Date:   Tue, 30 Mar 2021 14:36:15 -0700
Message-Id: <1617140178-8773-41-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba1fe498-4abc-4f85-e360-08d8f3c2add0
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB5265DECCF4BB71D3CC00A28CEC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Iey2YuNQvFEH+OfRYKCcI/wdKSG4Y0lPKgi6RuSiihWJ9jZDtGH9YHI46lOeVssLo+hPJ55crOQLp1Fy7+Ds4nNRxJeS8+wO5nDdbznvo4zmJM4QxanZSxAt3GEhi11PLN6Ap8BriJtszui/7fCEXMRxayWzg7BXBQcjFxpyJVhoNyx205u7prA0o5j85AUpCenB2BB5lPM1qyvZyEGS4cgYb9xIVNWGvgHanv0QBCIYpkkLFTOFn4rzCFEjftshwCC+KRlu1QNxyx1XzSuR09HBJLvzCUJ+cRNUU8/be5xbKQIh8b9Vyk9B/RrDGR5ylT9XXkA0pvU4CvmsfaHoiMW0xzLF36SqlEusBBYa+1dZ/gOGBwHaY5Ddt1pzf+cOJZd/xvF/hkuefLW6i0zSUq7Yu04y6JrKrO5JHcbZlGltPee6QqxCyqmtuOIIx/FpQ/QR8lCojW+a+eIhlkGqoINs4x0JDX5Ah0uVKI3ko1vn+4WPJd+ex4KLeLu4MxKEJsLehmhszOGQUD+GHRjOFI43kSIiXUXDE3SmnUog1lP8lujmrVE7Nfdac6gSZLC1umgt9qEN+raGuBbqpU24cwoQQRJ+eAgsjg281eYMMvQzrT4hvQyGIhYWABz8+QnE8BOp3aL9lUKk5LBwdW3fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nRI8UzovRGKm74IwWNHVtw61Zq32B36pQwRn4CwKxs5k0pO05HcV4QFPWCPs?=
 =?us-ascii?Q?Y8gBbm5BWySitXTbt3viEtDOtATQe3soFFc3VfJwbAia+FV+QL0g/KPr2zIo?=
 =?us-ascii?Q?eLsQy2BIi3iRd4Yk1d7HAN+64WCvIahAx0BpEjdE+jHQYBuh7OdbVsWkLPI7?=
 =?us-ascii?Q?5WpKA9E3T/fAwq4n6C72Pozs0O244ZGXw38vq4mJiD/nkFG8A9A1t+krngNa?=
 =?us-ascii?Q?gbVrqodjPz4/WH14hKbZbUt9UcWvPh7sOgEEMwwL5ZRF34ZFCRKKWijJOUsp?=
 =?us-ascii?Q?q6EwV8IYEUwmegydJOudt5fTgTEbJzpiw1Gh9lyBG4QGqUICwC2hG8ip3Znd?=
 =?us-ascii?Q?xU60DG4MiuRPxuZPFhjU+JqWFW2Pzp0j+kwOBkq5t+B4BGsnEXo4UDDrkqY0?=
 =?us-ascii?Q?OJgkG2yY+XG2SSYnSjXnOah++oAWKenGooHAOr/ymU7FQsuwbLgaeFVEhkJG?=
 =?us-ascii?Q?YNN83nNZ4ejyFuhwUm7x48GfuVqgj54PtNh2nvvIeX++0Sc0ldywBDlNd0lE?=
 =?us-ascii?Q?+qpQsOmlVHCymivSD4rlOfy2m3CgxJSILIfzoMxkX0z2kxw5IoKYEsy1zVms?=
 =?us-ascii?Q?ThEMwEHU4ECI953ifGfCrvnIS6Tu7fSLXA0MYvbGJEnomTZaKhxcegmw/RWU?=
 =?us-ascii?Q?ReGUgr/wZoZKtT2iP6aYJmmxGxsvt+9e0ohHz/K9QyeumH84kHu3tEg57XIJ?=
 =?us-ascii?Q?BFZsW/QOdZL7dTUwQ3L7W63as0rDgLBsxYqPEiI5f+0dSgmsCtD2ogUZiw+w?=
 =?us-ascii?Q?6fdhHMeo6z8yOwY0uA+h5H0je9uUMQ0XUv303qMtTgDEo+AH1uySofp9/G3T?=
 =?us-ascii?Q?HfAVL0hmpZgFm3d7ZFeIm12JaP3s7RnChvM7B3aCJdxf24p7TKZfUW8r0f/1?=
 =?us-ascii?Q?UBRrfg49Qi/pnBnJxh2S63ot8p/n5Z1xRqbaz1No9Suqop9EWFvvqpbYTZDw?=
 =?us-ascii?Q?LRQKNFoqx99ciY2MOGPUYjRAE3kgumi2UYy1DH+x5uQTT9KzwJuWTMKLTv9b?=
 =?us-ascii?Q?UgVI0HmBp1k3opwMSMHAfmyTT70A+iML3/8MsRKpwomICS5YQ7GKKCDaaw3c?=
 =?us-ascii?Q?EDUABUsY/UiRQM6tAxUER/WmLsf+ECyeqXRvKL60msn9co9Trx8A1eDBf/T2?=
 =?us-ascii?Q?OoYsWxUIkO2TSt3R+fFPNS7rDhnyEaDH5t9irr+CsO2RlAfLdSwDgKZ67ebE?=
 =?us-ascii?Q?NdQT4y0rQqH+pwdaxMaLlL6dPNJtfqeoKDfQ1yPDWYfC4EOl8xLPpC0voej7?=
 =?us-ascii?Q?DTNOXFCqcGm3OEiwmdbjcG8xdAEf7I4qPqZdf+MDwUVzBKCgxyIgk5B0HHnm?=
 =?us-ascii?Q?M3CQFJ2ZylTv+4/k3sqDggYK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1fe498-4abc-4f85-e360-08d8f3c2add0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:54.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2qpNosNOoY1nGg/7PzeTm6ZIILF5w5/3d/VdluFmrpX6ILJG9abIDfj5GHN49mmD6iRB18zIW20WX2RExUU1dS0pUW3WGIUPJMXogU8V+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: WbnzDWW1Fov0WSyMuYuZkGF5hBKIsxtl
X-Proofpoint-GUID: WbnzDWW1Fov0WSyMuYuZkGF5hBKIsxtl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

shmem_insert_pages() currently loops over the array of pages passed
to it and calls shmem_add_to_page_cache() for each one. Prepare
for adding pages to the pagecache in bulk by adding and using a
shmem_add_pages_to_cache() call.  For now it just iterates over
an array and adds pages individually, but improvements in performance
when multiple threads are adding to the same pagecache are achieved
by calling a new shmem_add_to_page_cache_fast() function that does
not check for conflicts and drops the xarray lock before updating stats.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 15 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 63299da75166..f495af51042e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -738,6 +738,74 @@ static int shmem_add_to_page_cache(struct page *page,
 	return error;
 }
 
+static int shmem_add_to_page_cache_fast(struct page *page,
+				   struct address_space *mapping,
+				   pgoff_t index, gfp_t gfp,
+				   struct mm_struct *charge_mm, bool skipcharge)
+{
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, thp_order(page));
+	unsigned long nr = thp_nr_pages(page);
+	unsigned long i = 0;
+	int error;
+
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PAGE(index != round_down(index, nr), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+
+	page_ref_add(page, nr);
+	page->mapping = mapping;
+	page->index = index;
+
+	if (!skipcharge && !PageSwapCache(page)) {
+		error = mem_cgroup_charge(page, charge_mm, gfp);
+		if (error) {
+			if (PageTransHuge(page)) {
+				count_vm_event(THP_FILE_FALLBACK);
+				count_vm_event(THP_FILE_FALLBACK_CHARGE);
+			}
+			goto error;
+		}
+	}
+	cgroup_throttle_swaprate(page, gfp);
+
+	do {
+		xas_lock_irq(&xas);
+		xas_create_range(&xas);
+		if (xas_error(&xas))
+			goto unlock;
+next:
+		xas_store(&xas, page);
+		if (++i < nr) {
+			xas_next(&xas);
+			goto next;
+		}
+		mapping->nrpages += nr;
+		xas_unlock(&xas);
+		if (PageTransHuge(page)) {
+			count_vm_event(THP_FILE_ALLOC);
+			__inc_node_page_state(page, NR_SHMEM_THPS);
+		}
+		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
+		__mod_lruvec_page_state(page, NR_SHMEM, nr);
+		local_irq_enable();
+		break;
+unlock:
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
+	page->mapping = NULL;
+	page_ref_sub(page, nr);
+	return error;
+}
+
 /*
  * Like delete_from_page_cache, but substitutes swap for page.
  */
@@ -759,6 +827,41 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 	BUG_ON(error);
 }
 
+static int shmem_add_pages_to_cache(struct page *pages[], int npages,
+				struct address_space *mapping,
+				pgoff_t start, gfp_t gfp,
+				struct mm_struct *charge_mm)
+{
+	pgoff_t index = start;
+	int i, err;
+
+	i = 0;
+	while (i < npages) {
+		if (PageTransHuge(pages[i])) {
+			err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
+			if (err)
+				goto out_release;
+			index += thp_nr_pages(pages[i]);
+			i++;
+			continue;
+		}
+
+		err = shmem_add_to_page_cache_fast(pages[i], mapping, index, gfp, charge_mm, page_memcg(pages[i]) ? true : false);
+		if (err)
+			goto out_release;
+		index++;
+		i++;
+	}
+	return 0;
+
+out_release:
+	while (i < npages) {
+		delete_from_page_cache(pages[i]);
+		i--;
+	}
+	return err;
+}
+
 int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		      struct page *page)
 {
@@ -889,17 +992,10 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 		__SetPageReferenced(pages[i]);
 	}
 
-	for (i = 0; i < npages; i++) {
-		bool ischarged = page_memcg(pages[i]) ? true : false;
-
-		err = shmem_add_to_page_cache(pages[i], mapping, index,
-					NULL, gfp & GFP_RECLAIM_MASK,
-					charge_mm, ischarged);
-		if (err)
-			goto out_release;
-
-		index += thp_nr_pages(pages[i]);
-	}
+	err = shmem_add_pages_to_cache(pages, npages, mapping, index,
+					gfp & GFP_RECLAIM_MASK, charge_mm);
+	if (err)
+		goto out_unlock;
 
 	spin_lock(&info->lock);
 	info->alloced += nr;
@@ -922,10 +1018,7 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 
 	return 0;
 
-out_release:
-	while (--i >= 0)
-		delete_from_page_cache(pages[i]);
-
+out_unlock:
 	for (i = 0; i < npages; i++)
 		unlock_page(pages[i]);
 
-- 
1.8.3.1

