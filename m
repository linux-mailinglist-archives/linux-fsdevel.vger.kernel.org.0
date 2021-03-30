Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8034F352
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhC3V23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhC3V2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPTdN123025;
        Tue, 30 Mar 2021 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=v4aKNqr6h6mbPJap5xgsm98rRBX6spVn3y1s4HGYwxw=;
 b=uHhTjxfkhabtES0WCndF0Tl3/vgIf+yWZg/NZWYJEKGk576w2VkEgfE0DMmYn/PfMO+e
 MEMInYG5Vg8YLci5BVt8HzEgMldMaD+BvKF9i7pC+qEATWv1J3UCStADWG0+tiVs8x7e
 /QFP/UDfdFHp67BlsYWPMnH3ShkYvb5UJzTlPPPO+zSA6mjnD9DvNt9FRnpBjdAdP7vR
 5KWpFeBgvOgYIf7VY0+SVc9y6RibNil8Ay+uKi0c7Y7SnxgNiuVM5SaHA96jaBixiUYj
 crc+VzGhzVKeHbCbwI3g+48DBf7czsLQbeTkExGE/jhBc2033OkhcExoExH4bi2XLZRS TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37mafv084g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOlEe183911;
        Tue, 30 Mar 2021 21:27:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 37mac7u57j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E37sln1YcQligx1p0HZmFGCQ4DgCqgejxCx4beitFDTg/nDdIxV3LEgCt+edrWEyzeC7hTjfo4ak0l/enIPeAfbj+zpp7xRvG8aKHUhod0qM4mB1neJASnStdLkdDy4KY2R4NFxnWPIZuCxYavHGwxVLQmxaeMlEsegCZw+puDjS/a9HrsQD/6UX7IODBllJrSoL2YVoObBd7/k5+ZPsRE7p6OD5G9NvFcOD8LGBZS6SeuYGiPcfUPR+xcwO3pC+FuT0BTpathTNHmVs0+lV/2BPCEhoihA/HGyMPHlByDg2USencUtFOSZPSSPvL1aEVLVziFQGtJvTeUD1xlSUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4aKNqr6h6mbPJap5xgsm98rRBX6spVn3y1s4HGYwxw=;
 b=TRy/XAksuZUUZxVrDP93/CWb3cBvkg933LMqLMCri98W55mi2qYCIjcZmh00YisZG3FMwY2DofAPt2lHZ1IxGhBk/SBxw6Um1I675zi2MAH48W+HUDefboWMx2pkvaYV6mlnBvEdxLwBkqJrECvpd23KM/y20SKlbwUTD+AT3B0iMq7Qg6BqDg+jd1a1A6e9Tzny6XLFMckN/Kg2Ud0+Is+lFW7RErsslv6P6SY3E+5vHyKPj1KSjfEJwpuREMCTgIDAwrwmcCwJKbc3N288oLHXLsS2evVNy+nJHADRlDaE6WVZVIqUmM+GEd4dD/5VZYGRHMEe9f1yr/PX7IzTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4aKNqr6h6mbPJap5xgsm98rRBX6spVn3y1s4HGYwxw=;
 b=Q7B63SbalXIgjafKegNv/iI41vB/9H6fQp0fzOUPJD+dczm3UI7x0BPgAGXoXU8dwbfutSFI8m9QGM02awakvO91jFNg2w4TDI8nKemIctU++WmXBqzQsFFsxjazo1ElHRZm5MktRjeTN0kO5XRpjJ+YOvTyyEFemFkhcezUNKQ=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:19 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:19 +0000
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
Subject: [RFC v2 32/43] shmem: preserve shmem files a chunk at a time
Date:   Tue, 30 Mar 2021 14:36:07 -0700
Message-Id: <1617140178-8773-33-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8c43d14-9128-477e-d56b-08d8f3c298e5
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB36791343FDDDED98E6A6534AEC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvo7lyHuuIXIIe1qWDdizLIbK9zx+GioIRkjmQB9UeAn6M1kneNpA9C4bUpKpHRks4vPrCB0n90zHPtLfBCfI1q5rLV+wUibEgBnlwppmmlKlc0MB3+tYvlPlRpDS7GNB0tdmdmL+/dQFVF+uv12HNWN5cHVlZVvZUzQ/l3E2UPpTE/9xeZp1CIiHhmt6nnTI/e9xtjgPp9CZIBgJvdpxxYn0LyiTrgelZQaizBTBOhOpQElgniSdcxaiA+SGEd3xnjie9oszmS353uI3gbArJ1O85zJZMRGDD1WrdrF0o4+g4/8bCdWHSKegMpdh1bq0Ir0JZuq23D4/43yPF7OoPrN9wEaoKQDfi9l72XB/AYYd6lqlbiej3YwcPNi4lXFzrVUeVc6h81xXMENcA3gpmozJvI6jvqFTvpvHXMVgufAMaJZOufw0PLBEO2w0iyVy+5XIHsKy1RP/MIqggNSkYkJalLa496hZpQQh//Ygq/ZVufcktlUv4Q1qa5CqtA7YUzLV+nv5W6cox6mXbn24aBR7jCm607ZCBDduqc0B68qeco15QryeuAxEAq5WOqYz0SdqlL4l3HN63NweOoA+a6tim58tHX997DXG2nJGOUg9Dh+kPD4jAroQdSOZBUEMvRzXMpKfyzuYT+/jNNTSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(956004)(2906002)(66476007)(16526019)(8676002)(316002)(2616005)(7406005)(8936002)(44832011)(83380400001)(38100700001)(6486002)(26005)(66946007)(66556008)(7416002)(186003)(6666004)(4326008)(86362001)(52116002)(36756003)(5660300002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0lWEkjh7OIxFueF3uRv6OC9n/BznyxvEpMioJmfWSGs/5rBb3quti4tihvnG?=
 =?us-ascii?Q?BYpyE+57atv0wXu/E02K4fZ4u5rM7pUnDspX0XchLk+y5FOWq3Lrbo1gzi6+?=
 =?us-ascii?Q?WMaZMPUWItr0Id4ENYm5pCec9/DO2j36+oTGUS1/NXhN0WsfJTozyeQeuGAg?=
 =?us-ascii?Q?hKX/YPBRWgy5TM3SY60iB6SWH3Dzt1Ts49GxCtrXyJpAT4m/oHRsgY+eygDU?=
 =?us-ascii?Q?9nSl7aSC+H7AYOr1E2GN84EcnmbVQTPnafvx0xPH9dfMUwSbM4aU3UU/fKPs?=
 =?us-ascii?Q?28+C63FB9T5OMUQDuKPWSbnKbfAEZ24NtCHhhAnq2F1XQSrOFUuR0YVCSpjP?=
 =?us-ascii?Q?xdjlgz5Na+GzDozYElInRC/HT2mzoLdtsOqvN7qDvJ2QBjI/W374EuZqO2uK?=
 =?us-ascii?Q?LQqHpyLPOwH8+mHDKYIzTNrAR4AK89kmaC3PpXBj2ZuuJwmROZ/JWeJQeppQ?=
 =?us-ascii?Q?6clqDabxUAgDZJIY/b6Vt9PNMgXU2D4nNSMDrA862p9QAUpKJY5F7/mqKyB2?=
 =?us-ascii?Q?1C8WTwz3gsdpeuSndW9U7ZcCaRjVQeHGbljfFB+cFnLUOScMBd9CtgH1REaf?=
 =?us-ascii?Q?HuPSbLYLXXabmzq/ygW3wUG5qp1M0om+ojN5ANdYFkozIxxkCf+Yrb/uc26R?=
 =?us-ascii?Q?ouw1DQzxtnj3ehW4D1vPyeS40DkAEC/2SGTlXIQHfUb++bUizaNIb1pbyQ/d?=
 =?us-ascii?Q?MX/MaySl4RLnx5XxUUz989wzyChLqsSOceQQMPreKE508pBSDXCbDu4urP3V?=
 =?us-ascii?Q?GTxygjE6hnVCcPCDDwK7YNUoY9wpPNXblJmK6AzVU8Hnn4l1DXW8BBw99V/J?=
 =?us-ascii?Q?sb9+tQKMEYndnAEqpAs8BL0n+rjs9/Vh2cluvFRpWauV5HVNQGkBvWgMhGsZ?=
 =?us-ascii?Q?7h/ptr7PHlkm/rDDyeVpkAWejLN1tUjylZ+ED9HdBuGpkTe31uUTsIzQuASL?=
 =?us-ascii?Q?hcpAQnGqnE9LxeLXadjm7eiVfoPgbs/mb0nHw1+XfI8lUT16li/aSlUh+o3K?=
 =?us-ascii?Q?7ggFIySVsuqfnZynzbjIFyyt3goxX7jnFsWrpv8UsxUe0d94/B0XHE0U+d1p?=
 =?us-ascii?Q?tsf1wnIEfciKuqWbIr6f/8PcwBfFi2bfOU8VieMJAlrpVHEjz+rpDQr79rYs?=
 =?us-ascii?Q?WZprquej/M2JHtVMUKKrkqshQzTugsQZuWKl8P4TmMe3VTBr+slsGA1RLJIQ?=
 =?us-ascii?Q?AC27V89+sKkXJF/MKI1i97B59kRF+TtLmFUeapwZ4fUdIllIRvtiIH+ElAh+?=
 =?us-ascii?Q?wmzfEYPJ79FWD0PccWHYd3z50XjdUe72HwgjdyowzwNbvKD62EbLjuk4Qn6C?=
 =?us-ascii?Q?d2xoghJiExZSWO2ND39M/asX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c43d14-9128-477e-d56b-08d8f3c298e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:18.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6NXyjsqO9feeZ7dgNmEGj6KaQvnopnUba1TOi3AQ2yb+HfHHdNOVXrzBqCgtnP9yqgS2586VdF43GhHejSUCwhf+tbPaY4phy+4hMbAMYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: knRDIKqlIw1uoWbdPLSxBR9rvW_buTlb
X-Proofpoint-GUID: knRDIKqlIw1uoWbdPLSxBR9rvW_buTlb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To prepare for multithreading the work to preserve a shmem file,
divide the work into subranges of the total index range of the file.
The chunk size is a rather arbitrary 256k indices.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 8682b0c002c0..e52722b3a709 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -74,16 +74,14 @@ static int save_page(struct page *page, struct pkram_access *pa)
 	return err;
 }
 
-static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+static int save_file_content_range(struct pkram_access *pa,
+				   struct address_space *mapping,
+				   unsigned long start, unsigned long end)
 {
-	PKRAM_ACCESS(pa, ps, pages);
 	struct pagevec pvec;
-	unsigned long start, end;
 	int err = 0;
 	int i;
 
-	start = 0;
-	end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 	pagevec_init(&pvec);
 	for ( ; ; ) {
 		pvec.nr = find_get_pages_range(mapping, &start, end,
@@ -95,7 +93,7 @@ static int save_file_content(struct pkram_stream *ps, struct address_space *mapp
 
 			lock_page(page);
 			BUG_ON(page->mapping != mapping);
-			err = save_page(page, &pa);
+			err = save_page(page, pa);
 			if (PageCompound(page)) {
 				start = page->index + compound_nr(page);
 				i += compound_nr(page);
@@ -113,10 +111,62 @@ static int save_file_content(struct pkram_stream *ps, struct address_space *mapp
 		cond_resched();
 	}
 
-	pkram_finish_access(&pa, err == 0);
 	return err;
 }
 
+struct shmem_pkram_arg {
+	struct pkram_stream *ps;
+	struct address_space *mapping;
+	struct mm_struct *mm;
+	atomic64_t next;
+};
+
+unsigned long shmem_pkram_max_index_range = 512 * 512;
+
+static int get_save_range(unsigned long max, atomic64_t *next, unsigned long *start, unsigned long *end)
+{
+	unsigned long index;
+ 
+	index = atomic64_fetch_add(shmem_pkram_max_index_range, next);
+	if (index >= max)
+		return -ENODATA;
+ 
+	*start = index;
+	*end = index + shmem_pkram_max_index_range - 1;
+ 
+	return 0;
+}
+
+static int do_save_file_content(struct pkram_stream *ps,
+				struct address_space *mapping,
+				atomic64_t *next)
+{
+	PKRAM_ACCESS(pa, ps, pages);
+	unsigned long start, end, max;
+	int ret;
+ 
+	max = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+ 
+	do {
+		ret = get_save_range(max, next, &start, &end);
+		if (!ret)
+			ret = save_file_content_range(&pa, mapping, start, end);
+	} while (!ret);
+ 
+	if (ret == -ENODATA)
+		ret = 0;
+ 
+	pkram_finish_access(&pa, ret == 0);
+	return ret;
+}
+
+static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+{
+	struct shmem_pkram_arg arg = { ps, mapping, NULL, ATOMIC64_INIT(0) };
+ 
+	return do_save_file_content(arg.ps, arg.mapping, &arg.next);
+}
+
 static int save_file(struct dentry *dentry, struct pkram_stream *ps)
 {
 	PKRAM_ACCESS(pa_bytes, ps, bytes);
-- 
1.8.3.1

