Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5895F34F346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhC3V2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhC3V1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOjpx011609;
        Tue, 30 Mar 2021 21:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ETuALoFduXRIGxrnolIc0B04gfH9EfZlHyE4qLXkimg=;
 b=NIiekFRLqRpDo9VCL0UqJayJUrICywilxplFn/mUgi9PogETP16jcsYIq/64qqxSQI8E
 IrwH/2H9ZfHcPjXzigg7pOkEqmzRY0luTQ1fKoyH26RyO5bGsRYS9RfuHhi6nfByrUxh
 Swmk8zQk0uOWY1vCHZZvO8+xYjx3RA52Ld08vC0tNMhdV44GrkwxoptdylxtBk7sdDrs
 qfuWGzg2lJMyTYFAL3t84gIGWqMeS+5IpqiwK61vfPdSiUIwBVqgFOFBQmCl95LDdilw
 OL12ZWd0tBgZ7uSyPANqeyHY9EtcJTmMD0EalBwlETwQDJmrj+Q8tEMdcYJCEIvh1J3C WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37mab3g8y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOaIw149715;
        Tue, 30 Mar 2021 21:26:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 37mac4kf7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6QO96squBbAJSuX7C4MZ6SjUwX4PNcC7c9VCziCD2wMHPblty2eeyFvuDdP8rFERz1P97VlI5Qr2eSTG4Iub2Oq8rxZ0i+NESjgSCKk+6XARzPtrqh3O7ZdRrCvxz0d+U/jtcnjIkNS8kSkTELJA9Q7GQtpXIgDACLNIi6qb2zOMTJL++1FHSRbtkrtxRvqagrdrm1Qe+yKO6W6bEh/WLr3wg5aHEI/dsdYx9gbyFweooiJWJTHCKrRQhxHvRmM+fUMfQuCFUMjBJbRjPV0oi+VP8KjqDaa8SYej2hch4Df8BwkMlSPV9695KRiX7IRiFqRP9G//wmAevdD/KKL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETuALoFduXRIGxrnolIc0B04gfH9EfZlHyE4qLXkimg=;
 b=ZkOygGOVisaKfzGzW2aaYK7u3ADTxmEtGujbfRfPYblfhKZaVLZeWhlLdcwdVpyOh0eZBSIUMgCpBvY+cEHbpCsa5Nt/7qcHX973c0SN+CoW8eov3SRD8TazJAG9tnN5FkDZCBN/7o9R9WpTsFg66NZ37O7QPfrMCgQpFM0bbZsmQTJuYzEHzDeWAVyUlCRw6L+BZ0Q84yOKbFG7kQalaHs127CI9W8mwsw6auHicDaRXdoz/Rb+x8zy+lQXhlkS2JLIYjCw7OfYcFVf8UiaceiAvxo3vwOmuMXOgBMUUHP3q0TeHaCv59VPK8nAPCTOKLyC1Rl02zmwKu4Kdq8piA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETuALoFduXRIGxrnolIc0B04gfH9EfZlHyE4qLXkimg=;
 b=zIFBjWbeotmDfwU3bEd3j8MqDRmCIN9SnqwxQ68Nw1QpHU0tjmmFbUpYxFMksMo7NCJJX+QVJZX9RENrZB/T6UMI8pxVfgZnTyTBU+NecuBlyP9IC3TPh+IbbNIpyaJTo5cF3e00o345ADroXVOBuaO4hmKCPL00ei5Hnp7jtI4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3600.namprd10.prod.outlook.com (2603:10b6:208:114::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:26:56 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:56 +0000
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
Subject: [RFC v2 27/43] mm: shmem: when inserting, handle pages already charged to a memcg
Date:   Tue, 30 Mar 2021 14:36:02 -0700
Message-Id: <1617140178-8773-28-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60c9fb9a-9ce1-424d-10de-08d8f3c28b99
X-MS-TrafficTypeDiagnostic: MN2PR10MB3600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3600928A2E66F39F66CCDAD6EC7D9@MN2PR10MB3600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvPH2ja5qrv58hmLQE7Wx3kQAw7judrTiSyyLuug0Gi2MDPLWwI7tNfQdfvdv7hq7ZcANdlXW3TMsHReCIsvHnS560CUz1Zew0eowqu73R6O/x89m1jiWdu/VERtY0I9o6L+DW4fAK2mUbRbLJ3JbOT/HlaA1+aacL0oh/qonx999XAxgu2OSDIPYu/QrsGtX+JT4GBePtJJ3UFj8Y7oKROKbxil5++yCZ7IBpGaJD4Zo7P7FeVwZ+vaxpNbF91ZA/mHg+1OjEoaFgRv69gFEbaV0nai28x9E5HkYeXZKvByk7Lv+8bVgl9ffKzscotfQ4ylSeLHzFEijQ5lgf4EDQZGp/j7+x1wOHCtDFSeF08LyOb8ilGSB0/OAx1H0kGdbfpd3AoFA8rpSaysNClMCvUAtvPUMhFptk9/wJ83mPm0piuSzetyjMPRs8mEEtNkLpY6eOoJLGqm+eCtciR0wE5YK9AptIY26aCtd90+i3/AtltSqifp3Ft8wDLEKEOKEHAXRn/x+xJN1Vya9cBpjh06QE9T8vFbhqhbwrcmlmwArPGoo14FTQ5Myr/wFrtGab89Q3ev7WIPX6pbjhL4NUoLgh2nhEUnPHZoMC3WP6lhh1d+8e7KNkkjPVS3Kbe+X48K/O+aF3BjGx79igBOSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(6666004)(7696005)(316002)(36756003)(44832011)(8936002)(2616005)(956004)(5660300002)(16526019)(186003)(4326008)(6486002)(86362001)(38100700001)(83380400001)(26005)(66476007)(7406005)(7416002)(66556008)(8676002)(478600001)(52116002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?evsms6gqdy3s152iHzpEQ+Mt84fn8+VZ6czyydKHq1kgw1gF6Dn1EDsWVu3T?=
 =?us-ascii?Q?aHy8iNw9U/OG7YLtQP8ABIBx7YjIhBElPuC5+nQvkP9XX6MitAOnGyLAJm4L?=
 =?us-ascii?Q?k70PUZO+pyLGlGEMscgaGtXewnnt2JWCe4fzXswjrxH9rfda0rigqe3fPlFA?=
 =?us-ascii?Q?OORnuWXUxeyZifk68IpiX5DYEIaI3qd+KaQQM1QcN5+a+dXfQdoNqmSMmREt?=
 =?us-ascii?Q?Op2KY2U6aop9jWqkWG/BjGpRPTUSGHt5itsyZPl+nE6c/DKflNcJBeWXdvFm?=
 =?us-ascii?Q?xB2c94jgH98AsxFh45hBJVelfg48NDciO3VGJK1x37vC3o60DRP0otA434h6?=
 =?us-ascii?Q?5dkDPPaR/AsHAvBZpR9JnlnLYizqoVdx3zmCRu5Fu4+SDx8sBOnhhRe3szGS?=
 =?us-ascii?Q?hHhYekY3NRxCM5EnXqeDAjNqNVpQ2wBKTqB6An/HgKDfOKoopux26i5PN692?=
 =?us-ascii?Q?y31zkjBIaHpLR4OOYWaRpSMhcnXN+oU5Sov+GAhUmmFj/pIrMy90F1MF+if8?=
 =?us-ascii?Q?NkHeh6a+Q+o6uI4ZW6zexIUlQTAMM17Yn9i93k1kg4+gtOtLfAnoL/Upnrp9?=
 =?us-ascii?Q?XHqDvaN1wNoUpAALRwG8ZYbDh5Myge07pUy5CUgVQTI08EsMLBHBhWXR5t/b?=
 =?us-ascii?Q?P7rWHuNKphQ6cbPr635Y58AX619Og3q39j7kS/mxmrTVkAh0H8GOQbcQh0kt?=
 =?us-ascii?Q?kNNtwRCHB+gKw/oMxz48q6j1oyrdB+sQm1Jqtl8spFMt4l+DdUNmz6nn27xa?=
 =?us-ascii?Q?d8tpmcUh4NHdUwq5TahvA2pt5efoiRWW+vT1fSdvC1n0bn4bmZnOKFsmWLsR?=
 =?us-ascii?Q?M4/Dmh916TDVFPt7wC1LOCp0gYwZytCoTE/n7dCr6WpqHnW5/IlfHgvFbPBE?=
 =?us-ascii?Q?8kK14YVqbctWYbyg4u0/PBA7YZq4u2HVGA9+/qnK7HX6fgBwhGPWPzs+W5+G?=
 =?us-ascii?Q?g87lu+WSEt4gcH1OVW0Gl1/VYw3vSzlprS1eJwQFeUBrde8P+R+E7TNCRevS?=
 =?us-ascii?Q?6oh/Wqujo6hncaP6eW/MmlfWRv3+L9/JOhCyQ+2o1mUXgFA5i6mav863KpCB?=
 =?us-ascii?Q?GTbnlGjSVpaKNHi2Ktz8xJoBpUEBsNNT2CoLPvX96WCTdILWuJ3MAB172WKG?=
 =?us-ascii?Q?sZOJUuxTXl17TTfcBklQD/5X4bmK0oPFAPKEDY8yg0PV3Tfuq7OXhYwwkRhW?=
 =?us-ascii?Q?JA2eDWbro6o4Y2esyhTuel+u2UyeGbuTfJTZDSJYbtUQf4HSdnPgLGLrqoud?=
 =?us-ascii?Q?yrz08yQL4byL/zjM/oy1Y33qexRe6MlV7pt/5BpeZuzkmFWfW/I5HgjyrmTS?=
 =?us-ascii?Q?K2NTdP31xSC7Gw86I3IceI/G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c9fb9a-9ce1-424d-10de-08d8f3c28b99
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:56.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwAl6JGCUJ3Y81DVRX2Y3HNZZuiFNcSmDrgPy8bYAx/qcgIvOKHlK60Q+QxSu8ZSQz2WQayIJz54N6hBAyl0O6i2xtCt6fWvqXFqbxBaG30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 5ZKc5wafv4K_xPnnBbmbNutToVZsJ3iX
X-Proofpoint-GUID: 5ZKc5wafv4K_xPnnBbmbNutToVZsJ3iX
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If shmem_insert_page() is called to insert a page that was preserved
using PKRAM on the current boot (i.e. preserved page is restored without
an intervening kexec boot), the page will still be charged to a memory
cgroup because it is never freed. Don't try to charge it again.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8dfe80aeee97..44cc158ab34d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -671,7 +671,7 @@ static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
 static int shmem_add_to_page_cache(struct page *page,
 				   struct address_space *mapping,
 				   pgoff_t index, void *expected, gfp_t gfp,
-				   struct mm_struct *charge_mm)
+				   struct mm_struct *charge_mm, bool skipcharge)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
 	unsigned long i = 0;
@@ -688,7 +688,7 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->mapping = mapping;
 	page->index = index;
 
-	if (!PageSwapCache(page)) {
+	if (!skipcharge && !PageSwapCache(page)) {
 		error = mem_cgroup_charge(page, charge_mm, gfp);
 		if (error) {
 			if (PageTransHuge(page)) {
@@ -770,6 +770,7 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	int nr;
 	pgoff_t hindex = index;
 	bool on_lru = PageLRU(page);
+	bool ischarged = page_memcg(page) ? true : false;
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
@@ -809,7 +810,8 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	__SetPageReferenced(page);
 
 	err = shmem_add_to_page_cache(page, mapping, hindex,
-				      NULL, gfp & GFP_RECLAIM_MASK, mm);
+				      NULL, gfp & GFP_RECLAIM_MASK,
+				      mm, ischarged);
 	if (err)
 		goto out_unlock;
 
@@ -1829,7 +1831,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 
 	error = shmem_add_to_page_cache(page, mapping, index,
 					swp_to_radix_entry(swap), gfp,
-					charge_mm);
+					charge_mm, false);
 	if (error)
 		goto failed;
 
@@ -2009,7 +2011,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	error = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK,
-					charge_mm);
+					charge_mm, false);
 	if (error)
 		goto unacct;
 	lru_cache_add(page);
@@ -2500,7 +2502,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
-				      gfp & GFP_RECLAIM_MASK, dst_mm);
+				      gfp & GFP_RECLAIM_MASK, dst_mm, false);
 	if (ret)
 		goto out_release;
 
-- 
1.8.3.1

