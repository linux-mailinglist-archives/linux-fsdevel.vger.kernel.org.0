Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A64FC1DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348421AbiDKQKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348431AbiDKQKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9A2C133;
        Mon, 11 Apr 2022 09:08:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFOHmb012645;
        Mon, 11 Apr 2022 16:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nBCu2FInS4WSs/ZQOC/7AruAxxNj1FoZwFPC3KqxaF8=;
 b=aqy947/x+vaFNRfBWE7S3GLatOqNk3a593vQNo1m+u/lOubkfC0Uwpfl+/qcW0zKCtxY
 SLImPLREtHqYLFQnL6/TO538M1foIycXDQ9pYEvuV3mfW1C7QkaXKvdZlh15c9yckNRU
 fKX8RU164YvfYveT9AVU5jkKXxL1k3+bSPvuseQ8VrzHDAWBTz04C+aggq7vhLgIrmBE
 TBCWd8wJcQ8OcLueCN10OkUlnH6BGqK+I56qgXchaRpy80c6/x/ymBJmuK6QZvEX15Ko
 BaTsOZSVHZnFcMj3Q8sGyUX3EmJQjESfjRvny/EX/FNIWza4L1hdyuAHNGECMSAUI0Q4 IQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2ptv6ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG1euk009845;
        Mon, 11 Apr 2022 16:07:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k205re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZh0xN540CcphPrfLDayWF+4NZN3M2cwo1//LcG9cBKkuhuMZ8iBJiiB66cZFstiu8GV/rJMjtggDMgTiDaFRNP3fqlg9R9C5gzcadxeL+KmYg6D8yyHSqwxgPo+s7jDVrLNDyHqvuYTgU8oIfkJ7khnQTUfqwX8dXOqhRM1qq3rqi4EMZhOk764PROoLNJ461LgT0Dd3QF9uJQ8FNEfYFM3FW3XHwNGnGx8Nid3oiffpXpfNc/CKH5YJFz/GwCY/otfSKkw/8cI0f1j1n+N5BO4tRMf2kD0FJz8AXFsWJM0zC9sogEJAZfJyJXBrI0S05oRLY4W4ysgT+qYxtcS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBCu2FInS4WSs/ZQOC/7AruAxxNj1FoZwFPC3KqxaF8=;
 b=awZLKAy9DQ+efSRPYLDFbQLfEo0PhiCMX7mTLZHjoUT4jblcC3soLnNjusDoWU6n2MdtWEbhZTKZjjAN9OWa6W1KgzVciiHLTiqgpJqZimRKWaX3ZBq0gcU4kBc9HRqMYvhWUw7mP1URbRCMnAb1aUCQ3ABkqhBaOPkO2aqTAAjD/KK+3zLaiDi0/W7RLPhrA4Y2CW28Cup3R3w1Haqo5Zn9T4kEmOcU8kSAkn9RqMnM/kQ54oQ57w0d6xoUvejyFx64/VUI8Pg3eCJOhf/iMUN6sCs51sFyZiCFN9zthTd1AFv955uUaFWLGxNMh1UKWs2JJiKOKoOsy2nOSb2YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBCu2FInS4WSs/ZQOC/7AruAxxNj1FoZwFPC3KqxaF8=;
 b=PfnQnRHd31kWbYMronu1hzTYmHS1TJhuSA3CfNDBfto4yaDNMuvxkGEcGspJYdSgN+Fvd5nvuJvo77tNtEBbApvHgl+KCDcrs+8YglcmBOciHGjQmWytkFCsS/vlGXAQBeSsLlsbJ10q2vQlpwfCDZyGXhkjtZxU00gF4YT/Rfc=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:27 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:27 +0000
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
Subject: [PATCH v1 10/14] mm/mshare: Check for mapped vma when mshare'ing existing mshare'd range
Date:   Mon, 11 Apr 2022 10:05:54 -0600
Message-Id: <96066024c5bc0aff1d3818ec508be5901aaf15b1.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c5439e5-c76b-4f12-f87e-08da1bd55f84
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4564FD9E1E8312BBD565D7B386EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru/sCGITrAh13ifiV9R7FfWe5nmp1TmgvCueL/uU1ieemY9E6frzEG5B4bkU6bP9JoD6n+bcNagQX7O+bP2DY9799QAVhEoEcJm5clkWTUk4Db5nLPCQgAtCrxaXyLxggQK4DpyGH1JZbISQqhEyI+KWp1IQ1KU76ImlPOvdYhM9FkznK+qbQaSzb3yGFsNfTuLM86+HrkyLoKLlDS6of7ZGKle8jMNs+G5DW/V0ARzE/MkvyP4NHVej9NoHfHlaWrYeQwqajrR/0SNaC6OMu34vy+yYPSk0madx+Iab7bPGfIEAH72olwSGRE7TsU6knpqsh7Dqo9av8UvYPUpRBSVtrEiGTnICklYmqe8HKdzuAzdjbP1DcSmn731LvYKjoTfQZsC+QoxnVDnFUVaTgFiiZvhZrbMJOo5LtSi28mnlKHjLpnyo9R70U5NaTxdaIyOBolIyfJ9ipMpeciIJoyWH6zpwXYRlG4Ox902P/JRdYOU2I1PZ0kflbLqQGNMG/iBDGaPibRuMNw3xmcxopRPeGg4wnO3hA1fgW5Q1miSEiBqQw0baOPgVnyDuin0OOI9WSn+RF+0cfpRB1XyNFKi+rD16f7lchIaihhpFJ6Qq7N4NoSljyWOqRNeiNCR2fQv2PUUdeY4fVH9axtW3/3hMTzJtuaKonSe0eF1D6e6HW8eoJGOf0+zNv9rfkrkSbc5GRHU9ovZtu1FTNU8Kdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJtVQXuAK6K3bxuVsHAvXrN54CtIDnVceu0w7Nm83oTZrByfnTK7wShUpx3Y?=
 =?us-ascii?Q?nm2tSdmB4lEaLMSekuvHPgS3axeCc4egiLp8wfc8dEXonNpCRII8rnhOM5vi?=
 =?us-ascii?Q?yu7PFwvyA8uFR1Q4Y9QDBhj+ajpe5kHxBFEKoX2S/IQfwmFYabBr3tD67hmJ?=
 =?us-ascii?Q?Da/eazotNUeRtENh9AxxFSLYqqZ6XEBtOVUk8ZVwNbgDRxGWVgGNX7dXnnGj?=
 =?us-ascii?Q?xinyaRkdTc1d6MF5aOi98xyWJF0UKoxsyfLOMfZcRpBb8Q8oknkHwfhod7c7?=
 =?us-ascii?Q?0AA1zGnbTyOU7RtpiRTDfJOvsti81RkZtzFi321HsdNdvERTV/0FBVWoV5it?=
 =?us-ascii?Q?rZMj+quE93sN1LYxthrefHUiqmwisNyvatSdgIbWHv9I7MaR5gssAJKWnPet?=
 =?us-ascii?Q?EIfTUK9gTFfqLOjU1h+UakNFVBFcPNlirrRnmqpgOiaFqiaaOg19hwNUn+cF?=
 =?us-ascii?Q?5IGHCI6lKNcurAcgoa+V+1LngNowapIDDa0u/OIr809Nq8uz1k6PMxQrnmMw?=
 =?us-ascii?Q?2vaMi4j76O3d89DMx7JNFupHtEiTR2c4wyQvJyPV+J6d2EPnFVXq9nEmCyAb?=
 =?us-ascii?Q?ar5CeLNXcReR0JL7RNUMVI44oEgvu0UgZ1Us7Y8eo8NIC4jXXWqKptwjM8dp?=
 =?us-ascii?Q?Oc7cAMczjNLfEia0O/deKNQLTckp4Ht9oYiIDBKthZi2PAnVKX4xV1ZWof4m?=
 =?us-ascii?Q?Lbg4iwywWg50O4ws25Z9NglVyUACpsP6XIKE6f6L2GdImnATLhTV6v9dCV/J?=
 =?us-ascii?Q?9ax3yAU9krk/J48Qh1xUfxEakNHmsLz9fpS0T5TsZ+42tHIFGFM2OuCnapMN?=
 =?us-ascii?Q?6dHyrSul2WLFZHFZrZ7MfPB62blvKGMaoRpk9ZsZWJC0MhD18icZgyVLEXnY?=
 =?us-ascii?Q?eRyJWMDdrFwiRvSRWso5wSvr+BHRrscxpdei/gUcU2P8ycH3MHgMo33MLo20?=
 =?us-ascii?Q?iH3ebog7HLC3U0vKaZU77AtRu/td6Zv7Kb1WtgFVElUi97e5m7E/XKWwTPTI?=
 =?us-ascii?Q?RWJqvLUJ1TFLnN+zpHobrLbLIGsZLFGwXGZ57JF0p4Gtf6co2TAh2bF9oL4S?=
 =?us-ascii?Q?Lk9+5nyQmAfM/I0lbz4QukMux+r/bpzO0hRbfroevVIL8YE/7LbnQK/R92CH?=
 =?us-ascii?Q?RNeK7AbIaaTkTmFe916tAbNqEHH7aAnHER15IFDTFowptuFEvt2jUfGIm1jW?=
 =?us-ascii?Q?GAvSEtl9BZSmIhN77/dPAoFeA2E7UhZNe697vtC+UuoYhPQOkgp3kcsga/a3?=
 =?us-ascii?Q?c4ApzAoRmw/ICFgrCveCwjSG7VlaHoozvjUlko7U71hTDpTcYC7NNEf/WL7v?=
 =?us-ascii?Q?O88zbluXfaapdSz6vTli/KBqFqtwvwd0ROhUVVNEzVQPx9mvXXHawlDkPuTR?=
 =?us-ascii?Q?8iTWAvoxJOo43vj1hW6K0g9ps/4ZWvIW0PV7ZuN3h4wdp8EI9HxjdtdiZoDT?=
 =?us-ascii?Q?vaQ6XjYhvxegDJntAqpfppPI2sXjQByWiWdWWHYgtd3nkuCz2glJnGhsNnvW?=
 =?us-ascii?Q?u82k+pSkoZZPOQ13aCqlxp/bZec2Cfx2patYrGn6JNeXq3KjWdCShJ97xbaa?=
 =?us-ascii?Q?SXgqsg6qFh0C3QkuJj8r9FFqVpOP65odbyjvpByoV9bwDpXd6X+Oh0lClowH?=
 =?us-ascii?Q?pKFFtSNbycrydtyvxUx7y66PwCotirUh31G1xOMjxKAKW2PawkqWbzrKnW3g?=
 =?us-ascii?Q?Hspls5pllMRWe9q9hBRvTNbNHH1aN6IwmDxLHhHzIYLxxKKw72trweUWy64L?=
 =?us-ascii?Q?3wQkLFFeoMF9wJpnJgOsla7iBDRtmSo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5439e5-c76b-4f12-f87e-08da1bd55f84
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:27.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3ItAGj0hgr32xc7DUAhejqfvdEgFIMP5KGUlT0sf9OMpjJGY+fDBLIT5jEOT/VNG4PJStqnjm3iLD4XLt676Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=885 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: hbrUVbkOVquPKQ22CTZk7nMfxwqTcT6j
X-Proofpoint-GUID: hbrUVbkOVquPKQ22CTZk7nMfxwqTcT6j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a task calls mshare() to map in an existing mshare'd region,
make sure this mapping does not overlap any existing mappings in
calling task. Ensure mmap locks are taken and released in correct
order and in correct read/write mode.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 62 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index d1896adcb00f..40c495ffc0ca 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -249,11 +249,24 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	if (dentry) {
 		unsigned long mapaddr, prot = PROT_NONE;
 
+		/*
+		 * If a task is trying to map in an existing mshare'd
+		 * range, make sure there are no overlapping mappings
+		 * in calling process already
+		 */
+		mmap_read_lock(current->mm);
+		vma = find_vma_intersection(current->mm, addr, end);
+		if (vma) {
+			mmap_read_unlock(current->mm);
+			err = -EINVAL;
+			goto err_unlock_inode;
+		}
+		mmap_read_unlock(current->mm);
+
 		inode = d_inode(dentry);
 		if (inode == NULL) {
-			mmap_write_unlock(current->mm);
 			err = -EINVAL;
-			goto err_out;
+			goto err_unlock_inode;
 		}
 		info = inode->i_private;
 		dput(dentry);
@@ -272,7 +285,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 				MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
 		if (IS_ERR((void *)mapaddr)) {
 			err = -EINVAL;
-			goto err_out;
+			goto err_unlock_inode;
 		}
 
 		refcount_inc(&info->refcnt);
@@ -286,7 +299,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		if (vma && vma->vm_start < addr) {
 			mmap_write_unlock(current->mm);
 			err = -EINVAL;
-			goto err_out;
+			goto err_unlock_inode;
 		}
 
 		while (vma && vma->vm_start < (addr + len)) {
@@ -296,6 +309,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 			next = vma->vm_next;
 			vma = next;
 		}
+		mmap_write_unlock(current->mm);
 	} else {
 		unsigned long myaddr;
 		struct mm_struct *old_mm;
@@ -325,11 +339,12 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		 * over to newly created mm_struct. TODO: If VMAs do not
 		 * exist, create them and mark them as shared.
 		 */
-		mmap_write_lock(old_mm);
+		mmap_read_lock(old_mm);
 		vma = find_vma_intersection(old_mm, addr, end);
 		if (!vma) {
+			mmap_read_unlock(old_mm);
 			err = -EINVAL;
-			goto unlock;
+			goto free_info;
 		}
 		/*
 		 * TODO: If the currently allocated VMA goes beyond the
@@ -340,17 +355,21 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		 */
 		vma = find_vma(old_mm, addr + len);
 		if (vma && vma->vm_start < (addr + len)) {
+			mmap_read_unlock(old_mm);
 			err = -EINVAL;
-			goto unlock;
+			goto free_info;
 		}
 
 		vma = find_vma(old_mm, addr);
 		if (vma && vma->vm_start < addr) {
+			mmap_read_unlock(old_mm);
 			err = -EINVAL;
-			goto unlock;
+			goto free_info;
 		}
+		mmap_read_unlock(old_mm);
 
 		mmap_write_lock(new_mm);
+		mmap_write_lock(old_mm);
 		while (vma && vma->vm_start < (addr + len)) {
 			/*
 			 * Copy this vma over to host mm
@@ -360,20 +379,21 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 			vma->vm_flags |= VM_SHARED_PT;
 			new_vma = vm_area_dup(vma);
 			if (!new_vma) {
+				mmap_write_unlock(new_mm);
+				mmap_write_unlock(old_mm);
 				err = -ENOMEM;
-				goto unlock;
+				goto free_info;
 			}
 			err = insert_vm_struct(new_mm, new_vma);
-			if (err)
-				goto unlock;
+			if (err) {
+				mmap_write_unlock(new_mm);
+				mmap_write_unlock(old_mm);
+				err = -ENOMEM;
+				goto free_info;
+			}
 
 			vma = vma->vm_next;
 		}
-		mmap_write_unlock(new_mm);
-
-		err = mshare_file_create(fname, oflag, info);
-		if (err)
-			goto unlock;
 
 		/*
 		 * Copy over current PTEs
@@ -387,15 +407,19 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 		 * TODO: Free the corresponding page table in calling
 		 * process
 		 */
+		mmap_write_unlock(old_mm);
+		mmap_write_unlock(new_mm);
+
+		err = mshare_file_create(fname, oflag, info);
+		if (err)
+			goto free_info;
 	}
 
-	mmap_write_unlock(current->mm);
 	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
-unlock:
-	mmap_write_unlock(current->mm);
+free_info:
 	kfree(info);
 err_relmm:
 	mmput(new_mm);
-- 
2.32.0

