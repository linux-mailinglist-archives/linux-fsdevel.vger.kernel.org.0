Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1514650C51B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiDVXQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 19:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiDVXQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:16:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A28D6BB;
        Fri, 22 Apr 2022 15:46:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MKtDxV012431;
        Fri, 22 Apr 2022 22:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=cATgQLCoqzRFADgF4RJWQ3tog8kYVTvKNf0LafX0m+Q=;
 b=mPugK8rbqiSQOj+njDHPwx5N0mZRaEchHT0JnKzSntrELu7x/O2SScM0NpL+cFrhsqXY
 4JVHcoxauRyGOVxjj57I7TlQepHm+cHmuzQSwk2SV28HbqPxAYaRLj7eeXWFHPs3MPVj
 v4PQY+UHFSe86LchUtfO27mcnmBIhIhQRlbQ3nyfPn2jRnLEHqkqCJB7UjshKCdXPCYW
 9zK4BM0Y5TsitUUO6Jf8SCmDSgvrwPAGXy9fXTlfb1S7M/CaR7K6JYQAfHjDmTj509vn
 ZrzUxVYYhxfYEO1oVtU6z24AoaNpHbE0eiMZq4xszkvn+M9Cjox57egx2Dt/GXCbhsCG 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbvg737-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:45:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MMew5N005357;
        Fri, 22 Apr 2022 22:45:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8bpsqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 22:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEgCa5TtRXuJr3Tg70vzF89nVY3bI1O6zfgGicPVymymK1H06F5CRdz1AfrKCdF0dC30uDhvbWNPfV6s5qopUGTQ7TC1gdtH1X2uW4DcwwqXZcbpsKRJD73KbZPdpzNeyiV3UhGZbesaJYu2gZzEoe9JTWIrZ0JfMEItS5aXqkw+mUJqR3I6wZPsixJMt6PIE8X3uQJLkK59jHPPYfdIy26estQmlshQBf/ZDiL3pxfY6sn0F4DicUtPPUc0qtynOiSOwkQpTd23CntktMRMH5M8O8FbO1eFyEyPJsTuFcns1eGcSwDGYxJG5AWus+5pKxG5k5xSqWyUelyEKakXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cATgQLCoqzRFADgF4RJWQ3tog8kYVTvKNf0LafX0m+Q=;
 b=kfRUZThIUoiuLfevxOIKM2xiS2afJu+VQxu29So5F7UldK2ZDE7s7UVQOWLq17Nv9W926Gimfxo8eJXuPj5v5QXDTVXCTON2d/wUohzSws6bqqQpiGOQCY9wRnVyjph/73HufgdIKecmJtstRlHYS3aIvnxd4DVTFNkibIMqgO8Kwm32NkSuwHiddRzxGBDXsSUisjLmBCaQ4LXpytMolUE4DzDFgH7a/gMu+p30TvqX24ZltFsFJL16DOzuGTVkCiuJB8RHqTj0wMVMFrjJeGL5/XtaJKMdX6svmJncjfwzyTsDUrzxFAcjard5AcwoMRrpeSjoiVvoO0SRYd/yfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cATgQLCoqzRFADgF4RJWQ3tog8kYVTvKNf0LafX0m+Q=;
 b=b97b2dRrDo9KQQuDRszu9XBfnnN9ppCDiwWXahU6H6KptY0zIREs+yWPDqnWE2EC91NKPDOhqZd2E9LYD/sTZ4hPVhxemOUQOSNZh9GsIb5CYKxO+Q9KUTGSsmdhliourYWErkr2TblOW+GLHueY+2Mg6ykXa04Qte7dviVBPRM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:45:41 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:45:40 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v9 0/7] DAX poison recovery
Date:   Fri, 22 Apr 2022 16:45:01 -0600
Message-Id: <20220422224508.440670-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0057.namprd12.prod.outlook.com
 (2603:10b6:802:20::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e4aa33-ae59-453b-dace-08da24b1d3c1
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB255013373936BF157BF8B3ACF3F79@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SERBtAAEN0Jt6qRouQmGqEWSdesnOk40BG07zKmTuLHuZLNW+jYJL2sYThbD8MjTvfgKsBNGIGm1UusM/V3QcGKKqvZkoSa5YhR1CqUI8Xw6KtbsJN0mJ0tjiLUsGM8gz1uaROoLYl3pxeAt0lcka1sul5M+l35nOyIAmFnCO+zqT9MS4LAbpceb+I5XmT0i4jHupxOHoWjD4ZF0kMA69ueNjBxaiQXRcH9nfHMS45e7Gen6HO/7YOj+L1nvIysaesQ5wfZWBC7V01r+i/Amlnqonle5Ew6BLBNtUsX8HekuneFTv9YBzEuzLGRjqAhkFnOfjLkUmhl9bR7O+hF/jBqlCxz6hCg0qLiciR4atdV/ZO7K9wGFsGYExNEUkff9PDU5sW4O6xP2hplZxX6L1iORSMTCkjjQivQ/gTYiEEEf+Wb/LT4rouuGmc6UYWtQEQ76A065dt+mCEhu79JDTLWsJDPnxBu/Fs1cVWyLWw+sNo2Fgh5hIpyRrD0KHxpufMC1jd8AQVIKfNLv+6CI8TIGPzVECb0VQvdSQVyUP8SwUDs/vO7Mz06DCNHqkg5IUKPCStq0K0uW4WOyH248gMTabzlVlgRcaEhaYIqqYFx3guLCgp6q9C2PDaYHuXXMv4VTY3PGxGuCpaYTMNF/BVr9Aj4UNyUNlEYL0eACmea4ZPI/KtroRyJdv4AbxFx0rorqwr96Yc14RuSjPRCp3pbajtSA8eCeno4UqbDnEV/HuZdRCG1qVhL3Nf8Naz2G95d1FQbqYYJoh5L3SxKhTwQo/Tz68dvLd2arP25PMU0WqM+dPoOkwayrGZqzJTel
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(6486002)(8936002)(508600001)(966005)(52116002)(83380400001)(36756003)(316002)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(38100700002)(2616005)(86362001)(5660300002)(44832011)(186003)(6512007)(1076003)(7416002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dZs/qAOqS83+Y1Fq9hlRjFOD+smVlDQEK+uGoqvZW++rG6xaPuw+I8hjciI/?=
 =?us-ascii?Q?dloDo3HucxhTUfOTxL5q3U5OItd7pfOQ7kFww6Te02BCnIFArvJedBqoFjEW?=
 =?us-ascii?Q?ZfxKq5io/PoJaYXrdyZF22kAaJVlDAdl8l97fY43hn41zplDiToQUz6v+fu8?=
 =?us-ascii?Q?16ilQXZtVyCgIeSZqXe7d3usVza16U28y1LPM+/H9bG/vZTL4IH58IarGZlc?=
 =?us-ascii?Q?fRl4a5GGayfTMvnKaWyZcIQdtozjbWldoia3Oz5vOoNa0P0kB/VxuDUhAlbF?=
 =?us-ascii?Q?jMgtlL0CHtaRy4SDCySqH6Fy/w2biqcAgEkVYDgOkzE3W0yw+gtDhS7AUd8d?=
 =?us-ascii?Q?6CI2LYjmFZSaMLmBhBsUB0zyUDuzkU03iww1n7Y08lDswVQI4OyTqhtLg9B5?=
 =?us-ascii?Q?h1vfrDl2jyzLCUAD9AmUxZiP2kcAgyCzsQeAgRgqPBIyAH4qIGPoDJ6qwrQN?=
 =?us-ascii?Q?9ZuEGdkGZWaFdNYs65U66HH1K2M3EPVkqrkw6NKX1t9kjz55tdVyXjyvZP0V?=
 =?us-ascii?Q?KcqLLOqduQlcUeEKtBaqzHSJxV9g7x7Af8OLcoTKkOzbIi6IhHknWyE37gIu?=
 =?us-ascii?Q?JmVcgyNaWmrUoR+sN3VQD7N5blRri8FbtkPyxwsSuO0hOmLZYO+kdDvW/9VE?=
 =?us-ascii?Q?LApbwDKoDqwbfKgEx1hTc1+p3kMy7zaG8cnnCkWtOa03y8D/VFxaPpo1mpZJ?=
 =?us-ascii?Q?J+sNdl/pVG9mGNhZCSPACDvkgQaOeUBWYK2bfPBVExx/adq0yU8eWJdZQmlU?=
 =?us-ascii?Q?fk/GfaymN2yFBf0AvM+H5kfTbrHOBzkN8+f75mVJmWOJKMdV9qikxQ3r2oZ5?=
 =?us-ascii?Q?MWsFz+p1yziCGdQwd4uScBJvmKRJboaC0IFuM0oHIl7RbOecVehwLmkasrnc?=
 =?us-ascii?Q?t1fHeZ8UNwR/4pXMEiUipDnbYyWPIuBQfe65jzbEfxj5QwWfasYI5MDitIGe?=
 =?us-ascii?Q?4rm1iF3d0+BdyzT1AeARTgiF0YsSp63qAmGVwAyApxW+Hm6ejT6acsSxuTTr?=
 =?us-ascii?Q?SXHneAxN7wHl2nfy/NOsUc55nkq3Ff9x8Zw7WMifvwEDh4YOdSk3Pjw/qGNA?=
 =?us-ascii?Q?rInRB5qecD6bRdT+YS5vQ5Lvuhx1aSjdW1T8Uqp6zvkwtIcUTn9ZEoSc6nLc?=
 =?us-ascii?Q?3Q4I7HbqkFqwaXLC4gCOW3WBH3RwgQTpGRtbVvB5jQPoeeOAjZwRIyh8m08J?=
 =?us-ascii?Q?7Pt7Np2q+K7QDoQaYWXl/nK+OveuEMYGBju1qK+VgoHvelUDTsam0G6QRA0a?=
 =?us-ascii?Q?x4krJMkHRWKV3omRT5SRjKNWptpeqZxcNMGc2x5ryJv1fn0djCyiTr41EQpU?=
 =?us-ascii?Q?OyEyvQLZorZQNU5TyE2XfeDHTHJnzpKp7suAW7zPh2FwYzpSbY10zu5Fnyxl?=
 =?us-ascii?Q?AC3K61TJYv8xx0d8J35g/FDkhZgn+cyDTFBAKd+DFdirU4Ocj0OWNe1A/Upk?=
 =?us-ascii?Q?iVNXKYSplEiwbAMNzJre+f4jpQosqDfVkARfELsXPs7kHORKRbppg/A2Mgd+?=
 =?us-ascii?Q?aWPTxv6rYfwuRd6wkMStmwkSZqzelVBs+aa4eusk4r+I6XPhzh4s3fHA9qdy?=
 =?us-ascii?Q?1WKxOmxoF307ErgjGvuKLwUZQNaSZe+GretSoOb2gG2SJzBgVBgQ6b19HPed?=
 =?us-ascii?Q?77JQ80OsBWSAZxhq5ZF9h+0tovQbil7b+RsJ47+oeq7BFRNx6uXE7kWc6Si2?=
 =?us-ascii?Q?KsjuEUChlvBxNOHT3VC3EsHQ1A35XfiIFPjwK6BZ3Y9kfR4h9Qgw+x3ng2Cm?=
 =?us-ascii?Q?pwtxq27dBVGcKTOVy9I2/CqIA7QyrOU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e4aa33-ae59-453b-dace-08da24b1d3c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:45:40.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHA4t/aIpYQv6+9fISCZfKVv0GsYVagM8zb0W3VMo63F9Qdw4k0almiMY4YzepBQhKdmDC13NrqNDrlFXFRnMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_07:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204220095
X-Proofpoint-GUID: 6pfItZVj7vlRtlTTV5h4Vn-bZJdgb_0c
X-Proofpoint-ORIG-GUID: 6pfItZVj7vlRtlTTV5h4Vn-bZJdgb_0c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this series, dax recovery code path is independent of that of
normal write. Competing dax recovery threads are serialized,
racing read threads are guaranteed not overlapping with the
recovery process.

In this phase, the recovery granularity is page, future patch
will explore recovery in finer granularity.

Changelog:
v8 -> v9:
- collect R-Bs from Christoph and Dan
- move the actual DAX_RECOVERY_WRITE part of the work out of the
  dax access mode plumbing patch and into the next patch that
  introduces .recovery_write

v7 -> v8:
  - add a patch to teach the nfit driver to rely on mce->misc for poison
    granularity, suggested by Dan
  - add set_memory_present() helper to be invoked by set_mce_nospec() for
    better readibility, suggested by Dan
  - folded a trivial fix to comments in patch 2/NN, suggested by Boris,
    and more commit message comments from Boris
  - mode .recovery_write to dax_operation as dev_pagemap_ops is meant for
    device agnostic operations, suggested by Christoph
  - replace DAX_RECOVERY flag with enum dax_access_mode suggested by Dan
  - re-organized __pmem_direct_access as provided by Christoph
  - split [PATCH v7 4/6] into two patches: one introduces
    DAX_RECOVERY_WRITE, and the other introduces .recovery_write operation

v6 -> v7:
 . incorporated comments from Christoph, and picked up a reviewed-by
 . add x86@kernel.org per Boris
 . discovered pmem firmware doesn't reliably handle a request to clear
   poison over a large range (such as 2M), hence worked around the
   the feature by limiting the size of the requested range to kernel
   page size.

v5->v6:
  . per Christoph, move set{clear}_mce_nospec() inline functions out
    of include/linux/set_memory.h and into arch/x86/mm/pat/set_memory.c
    file, so that no need to export _set_memory_present().
  . per Christoph, ratelimit warning message in pmem_do_write()
  . per both Christoph and Dan, switch back to adding a flag to
    dax_direct_access() instead of embedding the flag in kvaddr
  . suggestions from Christoph for improving code structure and
    readability
  . per Dan, add .recovery_write to dev_pagemap.ops instead of adding
    it to dax_operations, such that, the DM layer doesn't need to be
    involved explicitly in dax recoovery write
  . per Dan, is_bad_pmem() takes a seqlock, so no need to place it
    under recovery_lock.
  Many thanks for both reviewers!

v4->v5:
  Fixed build errors reported by kernel test robot

v3->v4:
  Rebased to v5.17-rc1-81-g0280e3c58f92

References:
v4 https://lore.kernel.org/lkml/20220126211116.860012-1-jane.chu@oracle.com/T/
v3 https://lkml.org/lkml/2022/1/11/900
v2 https://lore.kernel.org/all/20211106011638.2613039-1-jane.chu@oracle.com/
Disussions about marking poisoned page as 'np'
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Jane Chu (7):
  acpi/nfit: rely on mce->misc to determine poison granularity
  x86/mce: relocate set{clear}_mce_nospec() functions
  mce: fix set_mce_nospec to always unmap the whole page
  dax: introduce DAX_RECOVERY_WRITE dax access mode
  dax: add .recovery_write dax_operation
  pmem: refactor pmem_clear_poison()
  pmem: implement pmem_recovery_write()

 arch/x86/include/asm/set_memory.h |  52 --------
 arch/x86/kernel/cpu/mce/core.c    |   6 +-
 arch/x86/mm/pat/set_memory.c      |  48 ++++++-
 drivers/acpi/nfit/mce.c           |   4 +-
 drivers/dax/super.c               |  14 ++-
 drivers/md/dm-linear.c            |  15 ++-
 drivers/md/dm-log-writes.c        |  15 ++-
 drivers/md/dm-stripe.c            |  15 ++-
 drivers/md/dm-target.c            |   4 +-
 drivers/md/dm-writecache.c        |   7 +-
 drivers/md/dm.c                   |  25 +++-
 drivers/nvdimm/pmem.c             | 203 +++++++++++++++++++++---------
 drivers/nvdimm/pmem.h             |   5 +-
 drivers/s390/block/dcssblk.c      |   9 +-
 fs/dax.c                          |  22 +++-
 fs/fuse/dax.c                     |   4 +-
 include/linux/dax.h               |  22 +++-
 include/linux/device-mapper.h     |  13 +-
 include/linux/set_memory.h        |  10 +-
 tools/testing/nvdimm/pmem-dax.c   |   3 +-
 20 files changed, 346 insertions(+), 150 deletions(-)


base-commit: 028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
-- 
2.18.4

