Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAAB50C51C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiDVXRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiDVXQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:16:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1515CEA8;
        Fri, 22 Apr 2022 15:46:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MK9YMg013493;
        Fri, 22 Apr 2022 22:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IHhSB9rC/ITJAjPIc6g1lJg0i8M4cMw7xJTu55a52Q8=;
 b=lVtX8U+EePzCM82K/eaS8xfHeJ7qL7ItGspIIdNLajokZPRvvVi7+PfLUGY9BRjYYnKy
 GAWUpfVVdGv6WCw1mfejoRm2lfOTe+WC8BlJHuzHDQAYTH28/XnDebKnVUrnraSRfUTh
 PG4cJCTRi7CULdogjmL/THfg9mEDblZ4DPwlGIENYH9NwdXBOYDsRZAsIR9BLgDjpVAT
 SqY26wd+ZIw8oUiMsEF/2NusXSmAaCVRt/ywyuRDSuX5aUDdkfVin88g+9NSGXEe8XiN
 2UGszaaiD9p1TNltL2AbzmS9hexBIoLXRG1cFn7Lk4qaeK/W1H60mlWJgXNcJE4nvPqk pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffndtqxcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MMg0Ws008543;
        Fri, 22 Apr 2022 22:46:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8e9mg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2x/Bl/x0abmLrex6k/Gls3TaYtQe0bPzFPw/zK4BdEMDd2HmAPfR7g+JBfWTGrndo1QdNEc10EUbHdz8Rsi7+vC7cWeWQr4IKgSpiUboQsr3EtX1Zl8lSxd08Jkagx66X8qds4+Aw5jKNQX41l/r8RjN9OFBQVkPHG3V3wz0ZlAW/m/EzCdq/wnzRwDuMPLwx9X90vOgjqNM9En5VvQ9+5gDoNkr1SHOyiEdpQOGI7iBJAs6tEwqD/2ZBQqaxYugC4/iGkFv0VxLFuXc5VNCoiGx7Ghmithtwu5mHyWdraAfKCIawb0BxcVHKS3wkQ89IvUj2qHMsxKFmGjKDri2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHhSB9rC/ITJAjPIc6g1lJg0i8M4cMw7xJTu55a52Q8=;
 b=hhMmuvbAyjeeXMEqlxWlLb1C8aQqLDIRD6Sv1GLDeDJ5m6wXXohtoCZA1dprXbEZzqyS64NdEWvi9QM1cY5EJvgLjYHjcZbYE6WbHNHUzEobGJwuu/24iH0Nf/382ZXdHmfezK+E3ehLAiwZGWG93+0adXZ4XlH7GOeTxftMz1QnN9fZxgYI1IlQjzeVD05G8ELW7jPI2wxSDGh1S4OuYoyNGf/4BxoO8AzUpfKaFj1tZh6nybtMJODSXt0cqaLG7h/hQ11KH5cDVoAv3yiXSsnPDUmQT/cx8sZkuyCTttDei503eAh9Grf22h+TpSla2yRx9eLrJ/jflNIg+GPhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHhSB9rC/ITJAjPIc6g1lJg0i8M4cMw7xJTu55a52Q8=;
 b=blG16PPcIbXVem/cVDoN3nWKyyG6FkR13VUtzT1O8zq5oajrVUM8gbXBAuPmFlYkM5OxsTV1lZzel83HWqz7ASrtb4Ei0y0Q2yGlX0cbmDzR+KhTjfcco0y57WbKEHQBKPTFUfpnHhvoI8XC5wv0Iv8ZtdW2G01P/R/R1/aXHBw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:46:04 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:46:03 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v9 2/7] x86/mce: relocate set{clear}_mce_nospec() functions
Date:   Fri, 22 Apr 2022 16:45:03 -0600
Message-Id: <20220422224508.440670-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220422224508.440670-1-jane.chu@oracle.com>
References: <20220422224508.440670-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f35f2d23-539f-4561-9ac3-08da24b1e17d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB25504DD1FA1953F105F4B9FDF3F79@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4We+QocWOwZALHDH0dZz7sw+Sn/8fQEDe+shYQW0tdJ8ws7Wd9y3eEpOxfjKu7h4f9mrLudvMS0fzZuQDLmjvfuAYE5I853iGNv0p+/jdqnJfMm5vAI052R62fGsvP8bjmHoXGsPsBbr75lL+Vso+mV0RPcNnRCsgF7UnceU8k+tCmWrnAQN3qnw25ku3tkopKEk835lYwzAp34//tPehOw0AiTYyxU7zUIwPCMDkzNScLl6HUD+HmE7WXyIwVoNY8LTRiEDz54cwaO8gSZoGkal5Q9Kr4D9UvEtot7YaqwhyVs3YVTeNFizR612vS8dmCGZtaw9rgnLjP0KpfdKofbgW4rQNICPPmCYCofRlcaEf/O8ARBQBWFiEJVwVN3zLzreavX9kT0XtB1AWRGxNFoSX+cavuEfsEj8aOTAbAMNXEzO+m6+L13wlS17ExWulY+ApDaK2bfkQ3H0wOnNjfgJJQxKecE9eoZivE5mGuxavVBs5Ck6iI6D+AJM4IthQLohNRB1JfLhc1az8rbCQCM0yEyyB97kb1Fn/FkjDzENvTPr/Tag1ebNRCz9z+a7PRoPCrf2sY10fjrkhyxEoR+VSygUW2Vs3HAmJrOLk4zWi4jw/mpIcz6ZyJ+cYzeAkn7tYpzbu7DdbUkMeyS+Gb37IYuKELl/8TB7J1jn/8WMqQcS8B+u5tlztmMqZEKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6486002)(8936002)(508600001)(52116002)(83380400001)(36756003)(316002)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(38100700002)(2616005)(86362001)(5660300002)(44832011)(186003)(6512007)(1076003)(7416002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?id/VrT+U1SyDhRZydrWy7QJ/dDIKreY2u1anPyLWhr00KaBcyZmkVkcNrIt3?=
 =?us-ascii?Q?UuqhvuVO1HLVRBqRUdAONuRKOCf89oKMuA4z7IQHPRtMY2SjCCu1M+T21KaE?=
 =?us-ascii?Q?zZMin4oGpRh/irKYNeqKU2Uz9cRqqHXAocKtMlNDtz5tRON5pcocrR+vP8cF?=
 =?us-ascii?Q?CfM2b1RoTkdGTxzN56QdeOg6y4BSUL412PWa2Stsv3HW5rYp5Ul17Alw33Dw?=
 =?us-ascii?Q?vOzyBu5zc9MV6cm0/z+fuhLeFE97+FYAz8t+mP5PWaouIaUTAE6xBg4LCYnJ?=
 =?us-ascii?Q?ScpTFSIELW3wKFPk+okT8yE+q2Abxn2H5ApwzDugrnwjTKTeav7nxcaakHeD?=
 =?us-ascii?Q?nuWcC6MNUCxAajhKrI7KI+8ghP2pP2GA4BplkWLnKEA5YylqFMXpk8QKCRZ7?=
 =?us-ascii?Q?TcKrPg30ln56txvk/2BnDNaooMNegQjbLTxgrVQJUX9VWMm4E6SVlBIksz9m?=
 =?us-ascii?Q?hgBoB9HHRSJWHQqi5UJ920MZLEtXZxRwS7HgPalyX3oY9MHvVTEJsytgKqMZ?=
 =?us-ascii?Q?CQTaGyuBD4zgy3ekE9mhoBAaSilRIuRxAe5ECvc6PVdXparTQRwNL/D2AtFY?=
 =?us-ascii?Q?IlW/w2rJtUe+tZGGPq/dkGkHVyLOxvulVUNwe7eraVyeFadwGHFOXIRdcuaZ?=
 =?us-ascii?Q?85n3kOkX8kWhrga/JfSlcyxiyhdy95/02qd991lznmaKj53AxgEpyt1ftpug?=
 =?us-ascii?Q?WSDkVqzfTmwhUedmdmBifRWvjO7/k39dkwMyeHBszA055BOYkp12P4prlel9?=
 =?us-ascii?Q?T0j+PhxfiQ0o/s8dNwUS5XWSOG473U3eveYNEfVjUFWBHP4UobckSuXXFLfh?=
 =?us-ascii?Q?msUbWtl1Bn72TTK2Cqo/oGksoeyTMvj+AWPcoI3qjVDLXEUnIBk2jH8X/vZz?=
 =?us-ascii?Q?aAmjq/PGvCjpHJ5eZCptVcJn3kMn/tTSzGM82jVt3+A8OdwkBfhUud6SZtxA?=
 =?us-ascii?Q?yaooxrMA4a+FSaiseqImVqSm8m5DC4JNG05EjWB19FNZImx3nY7wJ7/GGVjV?=
 =?us-ascii?Q?IARIO6PLDKyhMwLX3UKjXBkfx5p5hTTYcLdi4qsXQd8210KWlyFfgKP8PGb2?=
 =?us-ascii?Q?L8meOtiNABYKh6RGDchzN/OvwF8BdXrbqOoIkNN8mKR7wqb8btlGh/GhRLo1?=
 =?us-ascii?Q?OmZbixbs0MOSJNMNl+szASy7cRkbo2aXWykH39NA/TkpJEHBiADu7q0grn/4?=
 =?us-ascii?Q?E/QPXZbdb7LM/IHVd14Eiz50Vwtnd0riTXgKZQjLdG4AgDPouRZQHoM+jgv+?=
 =?us-ascii?Q?GUErpDYnP7fiiOTO+XLsp3cFesg2gsLCs0ktxFCZ9cY3rdrefs5OYEP70vI9?=
 =?us-ascii?Q?mo2O1uyYEermsY7FkoSwWszqNqwmTgDY9xhDFPlg3BwT5ioEb2LME+mJM9cJ?=
 =?us-ascii?Q?bYXK8QpGuw1I78LxjxNloMTcholdOMq2//u4FloDTFYDLwMfB/5al3H1UQj8?=
 =?us-ascii?Q?rjwGnYu92BvmjzGz9yNiq2fGaQA0FHfoHzxlpb1AjpHv0IrDFcTtSbIO/X/B?=
 =?us-ascii?Q?/mztYdkfEWabup9nrEzUcmmCuN1nzBkhsGN1ONzmElPuS/FtQwGR7xxDlttN?=
 =?us-ascii?Q?T40ZgtSJvtY/hvhOLm88yWan/2De2Kjj8D4/22T41aDhb1tV8sdnqi/4kOLL?=
 =?us-ascii?Q?XB0YGULYCSwMGufdT//Csy8zTAZHtXzv3R2OCR8h1oNm/lmIwNO7nZWMzLUV?=
 =?us-ascii?Q?Gd3kGmpn5yWCGdv0aWLYhzZKaBcbT0A9OMVwAssdtamHR0IT7OvDNAVhtSaS?=
 =?us-ascii?Q?pScgr8wgHkGDU492qry5zwIz0b5ontk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35f2d23-539f-4561-9ac3-08da24b1e17d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:46:03.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuaaULRiDxBRRgvkBWiJJp7E5K1qnqVrzQPJNlV90nTicGlTz6I+z//S8z1DXGz7vFDp+MKrGySgLPixGi+e7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_07:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220095
X-Proofpoint-ORIG-GUID: UfUbv9M8Bs3zm5Soq_hiqXyIelEP5Wy_
X-Proofpoint-GUID: UfUbv9M8Bs3zm5Soq_hiqXyIelEP5Wy_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Relocate the twin mce functions to arch/x86/mm/pat/set_memory.c
file where they belong.

While at it, fixup a function name in a comment.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/include/asm/set_memory.h | 52 -------------------------------
 arch/x86/mm/pat/set_memory.c      | 49 ++++++++++++++++++++++++++++-
 include/linux/set_memory.h        |  8 ++---
 3 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 78ca53512486..b45c4d27fd46 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -86,56 +86,4 @@ bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
 
-#ifdef CONFIG_X86_64
-/*
- * Prevent speculative access to the page by either unmapping
- * it (if we do not require access to any part of the page) or
- * marking it uncacheable (if we want to try to retrieve data
- * from non-poisoned lines in the page).
- */
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
-{
-	unsigned long decoy_addr;
-	int rc;
-
-	/* SGX pages are not in the 1:1 map */
-	if (arch_is_platform_page(pfn << PAGE_SHIFT))
-		return 0;
-	/*
-	 * We would like to just call:
-	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
-	 * but doing that would radically increase the odds of a
-	 * speculative access to the poison page because we'd have
-	 * the virtual address of the kernel 1:1 mapping sitting
-	 * around in registers.
-	 * Instead we get tricky.  We create a non-canonical address
-	 * that looks just like the one we want, but has bit 63 flipped.
-	 * This relies on set_memory_XX() properly sanitizing any __pa()
-	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
-	 */
-	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
-
-	if (unmap)
-		rc = set_memory_np(decoy_addr, 1);
-	else
-		rc = set_memory_uc(decoy_addr, 1);
-	if (rc)
-		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
-	return rc;
-}
-#define set_mce_nospec set_mce_nospec
-
-/* Restore full speculative operation to the pfn. */
-static inline int clear_mce_nospec(unsigned long pfn)
-{
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
-}
-#define clear_mce_nospec clear_mce_nospec
-#else
-/*
- * Few people would run a 32-bit kernel on a machine that supports
- * recoverable errors because they have too much memory to boot 32-bit.
- */
-#endif
-
 #endif /* _ASM_X86_SET_MEMORY_H */
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..978cf5bd2ab6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1816,7 +1816,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 }
 
 /*
- * _set_memory_prot is an internal helper for callers that have been passed
+ * __set_memory_prot is an internal helper for callers that have been passed
  * a pgprot_t value from upper layers and a reservation has already been taken.
  * If you want to set the pgprot to a specific page protocol, use the
  * set_memory_xx() functions.
@@ -1925,6 +1925,53 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
+/*
+ * Prevent speculative access to the page by either unmapping
+ * it (if we do not require access to any part of the page) or
+ * marking it uncacheable (if we want to try to retrieve data
+ * from non-poisoned lines in the page).
+ */
+int set_mce_nospec(unsigned long pfn, bool unmap)
+{
+	unsigned long decoy_addr;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_64BIT))
+		return 0;
+
+	/* SGX pages are not in the 1:1 map */
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		return 0;
+	/*
+	 * We would like to just call:
+	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
+	 * but doing that would radically increase the odds of a
+	 * speculative access to the poison page because we'd have
+	 * the virtual address of the kernel 1:1 mapping sitting
+	 * around in registers.
+	 * Instead we get tricky.  We create a non-canonical address
+	 * that looks just like the one we want, but has bit 63 flipped.
+	 * This relies on set_memory_XX() properly sanitizing any __pa()
+	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
+	 */
+	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
+
+	if (unmap)
+		rc = set_memory_np(decoy_addr, 1);
+	else
+		rc = set_memory_uc(decoy_addr, 1);
+	if (rc)
+		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
+	return rc;
+}
+
+/* Restore full speculative operation to the pfn. */
+int clear_mce_nospec(unsigned long pfn)
+{
+	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+}
+EXPORT_SYMBOL_GPL(clear_mce_nospec);
+
 int set_memory_x(unsigned long addr, int numpages)
 {
 	if (!(__supported_pte_mask & _PAGE_NX))
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index f36be5166c19..683a6c3f7179 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -42,14 +42,14 @@ static inline bool can_set_direct_map(void)
 #endif
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
-#ifndef set_mce_nospec
+#ifdef CONFIG_X86_64
+int set_mce_nospec(unsigned long pfn, bool unmap);
+int clear_mce_nospec(unsigned long pfn);
+#else
 static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 {
 	return 0;
 }
-#endif
-
-#ifndef clear_mce_nospec
 static inline int clear_mce_nospec(unsigned long pfn)
 {
 	return 0;
-- 
2.18.4

