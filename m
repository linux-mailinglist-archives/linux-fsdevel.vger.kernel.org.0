Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2C4FC1D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348477AbiDKQKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348401AbiDKQKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79D1B791;
        Mon, 11 Apr 2022 09:08:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFdIBI008887;
        Mon, 11 Apr 2022 16:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qgqm9y1TOCO2CnDqhxzRfjgnFASSEF5K68HB+lhriDg=;
 b=pxnwAjcZ1UIjSDJ0gKp80tn4Afci5+9KOgh+HUAI0JmFT3y0ZKfBOEadqvdfPtOqubLh
 I7earrUJXCpJtLiWgSeVD2SOyHdIHddDLHkJzbLgf7Cm6c1lDKVmH8BNIzE4HYP2Q8k4
 NZ0JpIvA48KGVJB/J8SU/xLq3kNWG2nakmjcS78gyxXbjBoGTGSyi1chE/jJ2uBr6+fk
 6GFE8bMLKgAOBmPAHXMldWhOpo3Tg9NuB9nNfQGcloTmmSa00OssyMExsBHOeJ9xswAp
 WaputyOHpe/jbWeRggzUiodvtItX7dbdNNv83Ru9G04tyVU9DVoZlxotFqkqcDjjabc7 Ig== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2c74a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1K7Q006050;
        Mon, 11 Apr 2022 16:07:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1uvqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU2YH3KqabHeYIQ3A0YEwIJJYSWUiDHkvdB8gVIvCTkCm3RJUmPXNxBrMqmfD1dLV8iXF3YK4PI3dpudYmm5H2Z0808xyYXy330IxZne3V2+CWP34v+8M0TVEv8jlenChRZfyiExjjb/2xXNDYb27GdWh8zMAxZj7tHUZwDKPHN7LzuImJmspSCmW4/KKHo9AB4Og0fypdeNIgVy0Z5IL25bHKw5uUeL6pO487YWt+1Sqj5+AQkGi2pGj/wGd3bC0MdXPFprXKLj1v1ue1/0JlNOlL+dObCz2fpbqq6JlFooLLKUelV95cQ/jv/uu11SFpFrocssCi2VunSkKLJI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgqm9y1TOCO2CnDqhxzRfjgnFASSEF5K68HB+lhriDg=;
 b=lqjfBxrWgLjNKrLLQirvha9coIXwPcEm4Zg7b+eNf5evma2rChO8FWO0jPegCiR3SIdurUjkLfP4Q1/ZmRvrg1Qoq0KNV3dsOM6FqWjlZ4x1dY6a4eKuD1tAmfsT4jPlPlO6yfNZVOdkfFQVx5iCIHUgmJXCEHmjz4LF+ELNMQxDj5N/hIiamD+qxHL4xFjaNFw7fM8Cfcl1nnsDRxpsZDYAavXqTHKU7aWRZ8IMpkbTNLY3t0/XTWqncm0d2BulKboWTQ+fML/6RMKg0TTiCy0rH1o5mNhHebhEstZUP3Nrurx4nfQRwc38+fk+w5Ewjf4Q3jVZpkhC4N3shExMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgqm9y1TOCO2CnDqhxzRfjgnFASSEF5K68HB+lhriDg=;
 b=NZU2n2uAQ8FhalHUBXQlorvcl2+8PmHt3S3+eWfCAPZzUDf/dVTUmk2vWcFAewXbzO+EdcyYB5+DWf4mTpVuEqUGfTpQNfwEKWGqwFPOHBZ/s92o4NTN2aKeqyOTEUZfwhpYcui1jOjsOYOxFZx6ZduxD94UVIjhfxx/p0rOx18=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:21 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:21 +0000
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
Subject: [PATCH v1 09/14] mm/mshare: Do not free PTEs for mshare'd PTEs
Date:   Mon, 11 Apr 2022 10:05:53 -0600
Message-Id: <f96de8e7757aabc8e38af8aacbce4c144133d42d.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 70f0bed3-43d6-4b5d-308c-08da1bd55c02
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45648998E6F9B7B00D62BEBA86EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHeec3W6l7UtRFrAJRZNHhDR5tWp4FM9jP0BQyqSEixLThUKpIALnouHhT73wXl4nQ+tSJ3wTkEVZZDuMF3yPdgJBR1cFHw1XN7lSpFfTwkB9kjDHEBEuTfKF/F2145b5MxSj4xsBHc95vGgmPxTv5XMCfJy+biCnRMzTl3cF7GNIYpw6CdoAwq9CbaP+1i1Vh7PYN9ijd0iBLaQvz8BGz4NHUBgmIqWLfhRcuAq2VcMaE+ymgtXu02IbvWBpQS6zD+MQbrQXF+V11cQ5ZY32+JtsMb9cRUWK/FFwGg2gZxAPgAAQetGC2+2E73m27ej9DvyIzm/jL4d9HBou0ApgBxSyBD5Vk+uEc+/6VEG0j8FiaSzN38iOmh39D8UtndWJmlrGXzNFWca8uskHxL49toKsaBiNPpQ9x+ZIKVnsM9tsulxp1EVDC1/JpEV5aX/cBTiOxagzq8OSK0sEBmtbuPqjDenGoWgzygTG8dm76Ec4UXVKM0KgL01qH8NedVLhcC3Z4tuxjJYry8/jam+y2pcfm3f+c99QGxVEw+kStCxoWQ9Iuu/9VhyN6X4UIiq6rFXlBGtfVlvyujvAKbXUtMkLTxVz+La1cVr5QBP+Ej2OoVPPe64lZo3fHEPMKEJN7JW47fruJ4r8WczRWrfbFqnk44HEfqXvo6fc8xVAyFuvcS/eTnULP8pEHfdyV3N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EH8zDaVjPrD3YUUC8pJykt92ngq5zgo/WjTkyTa1CRxgUSI7RqscSKxo09Q2?=
 =?us-ascii?Q?ErQN9GlGa1CEmk9vwddQoFCIy7uDncqKkROGtkOj30eW+et9kCgztmmLZkaA?=
 =?us-ascii?Q?aIzz+gZFCFcrmDcg7rtqJokoM0KAC/S6VdTFv6E9sYoWLnAMuAFLm5gB7GwQ?=
 =?us-ascii?Q?n9wMgdVZ3hzfD7JDyob7rTFUYrb47cFUkiUDhs8tAyNMINAk1wbN9kjURbPc?=
 =?us-ascii?Q?VZhXMhVmr5Z6TN/9O1eLsBLzg1X4glOODwp0STjCS0sJ52MgvwNp+Kl3E3Yb?=
 =?us-ascii?Q?PLHUxQzKBgfqCGVsDQAZhzx7KmB9kimYnVxRdFn7K+phYRFqOxZfsQt5FJ7W?=
 =?us-ascii?Q?8W1CV0vJP1BtgiJ22qq5wkJnyEL5Mb0NH3zvEmlTodoZDAyN5j7MKhNts+D0?=
 =?us-ascii?Q?aP/kHDHI7tlEM6He8zDY23/2ErUFuKHAVg8HDMUndY/oPFQAh1dtiSy4dkGl?=
 =?us-ascii?Q?UyGaZBYjwsz6jx4jCF5tUpJWgDpQLMtW7An12xBWNkH5MdMI/G+y9b/H7cK1?=
 =?us-ascii?Q?4/WTShM3YEjxgQU8ZG7lnuEwBLqbPsuEcIY40p9+obSiGsc1gXMV0N4Kk/wt?=
 =?us-ascii?Q?7WgBNtH7qWGVec9y9q6MOAit5pwx8r0cJhGKv8kPusnodarsEh/kkT4jSI2S?=
 =?us-ascii?Q?m5F5tvvibpdibX8u7hAhzisNsUc2/eIEwptbAy9rvPNU+Do/pZSNxbkJBf7q?=
 =?us-ascii?Q?AdgfKqdQDzPWOX7IOlU556VPyu+bANRqH5IJ1cuNVRwbGWR9b9XGu54ppuUt?=
 =?us-ascii?Q?GNWOBFID96RcxbS4c9v0yl7hz2GGsiIi8ijpi8cobjp9V1mU1LLY+uHSHK3d?=
 =?us-ascii?Q?jvJ+MiMpV+Eb3LWuutEaPSPukhGFZGIBJdLc/y1T9HCmdkpdmVZye9JOfC2T?=
 =?us-ascii?Q?xYW0WqAh2Pnwuw/RcjQ3zADiaaHRcd+fgVeT/kF+0i7bhOIJUDRZaj7UTSFm?=
 =?us-ascii?Q?Yg3DLA+uVUBz3pqMS5AEa8Bw4ahLVMjaYy86u7x134Si6fBe/0T5Z93u/PhO?=
 =?us-ascii?Q?sg7GOY96k5HweNVhVqxQKTUNvaaF7yS82mzgkf6U14I0/uWN0NOiY6DqhaBO?=
 =?us-ascii?Q?rXLcfn6n8+eR3obQ6Dd+Ruma2lfnQilNb0hpWI2UoVB9foRM8g0Vl9oLwSMP?=
 =?us-ascii?Q?K51K3IAH+3duZViZjMuue11oN8wP4GDTYuRB6/7lPT9vbejnStfOz54j3nTB?=
 =?us-ascii?Q?HiiU6IM62byI/vhAV/Yu8FIQyq0NUIxsYZ6gLITWF2RjXur0duYKrUuqZ4u1?=
 =?us-ascii?Q?FM71/dG6hh9ZqxNtFryWZXLVAwVBqVysbXVgiX8oCLe1qdl3Gc1+X2UKB85b?=
 =?us-ascii?Q?KRzAxHVhFZV9mHfzpkPY00w+soq8E6nfPU/50Kj3MK5dE/iFIi+RX+/lTF1z?=
 =?us-ascii?Q?1AnTbCWJdVE1xtHUDAo+UDRk8HFzFPpFIjA8j8ZK4XttaE0RtKRi1Akhew7p?=
 =?us-ascii?Q?NyM7TQ7XSkjmVwDYQqReLpWfLrSEgCQJBn3qKvf9PECod5ZxddVz5PanKu9T?=
 =?us-ascii?Q?zQh4hWZ6dCa8K0DjFCgdBtXwoMITYBkxsXwZi888xKLFZ9+KndJjIGEapA+O?=
 =?us-ascii?Q?BXCl2H+Bz8Rk757qvK/B/sC0N9Zg2eN9ACdQmJ+qOXXkDBfHUhumzOsP+a4U?=
 =?us-ascii?Q?iCvWLxIzQemR+hibCRQYtEw2Avj5l2qn85RYBTxqY+xHfkjszrFHC31MeHu/?=
 =?us-ascii?Q?vEOpdSljCdDBs7dQfQRFsVM27Dj5nqFvzjJiZh2lyE9DfPvyZ5MecB4wqKtT?=
 =?us-ascii?Q?A1WUKDFeSQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f0bed3-43d6-4b5d-308c-08da1bd55c02
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:21.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgDvpTxdISB7yChkh7FpzPoMdNKYNyOn5iRUBxld3njY422QIf+25O37sRcnxTEFqZoN7Ehec9mMyM0VVjvVjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=985 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: VRTRdpnCIcMu99bEmce5XNYtkeNCO7oL
X-Proofpoint-GUID: VRTRdpnCIcMu99bEmce5XNYtkeNCO7oL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mshare'd PTEs should not be removed when a task exits. These PTEs
are removed when the last task sharing the PTEs exits. Add a check
for shared PTEs and skip them.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/memory.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c77c0d643ea8..e7c5bc6f8836 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -419,16 +419,25 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		} else {
 			/*
 			 * Optimization: gather nearby vmas into one call down
+			 * as long as they all belong to the same mm (that
+			 * may not be the case if a vma is part of mshare'd
+			 * range
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && vma->vm_mm == tlb->mm) {
 				vma = next;
 				next = vma->vm_next;
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
-			free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next ? next->vm_start : ceiling);
+			/*
+			 * Free pgd only if pgd is not allocated for an
+			 * mshare'd range
+			 */
+			if (vma->vm_mm == tlb->mm)
+				free_pgd_range(tlb, addr, vma->vm_end,
+					floor, next ? next->vm_start : ceiling);
 		}
 		vma = next;
 	}
@@ -1551,6 +1560,13 @@ void unmap_page_range(struct mmu_gather *tlb,
 	pgd_t *pgd;
 	unsigned long next;
 
+	/*
+	 * If this is an mshare'd page, do not unmap it since it might
+	 * still be in use.
+	 */
+	if (vma->vm_mm != tlb->mm)
+		return;
+
 	BUG_ON(addr >= end);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
-- 
2.32.0

