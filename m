Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F67507EA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358874AbiDTCIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358842AbiDTCIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:08:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E4822BFC;
        Tue, 19 Apr 2022 19:05:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JMYKLu019412;
        Wed, 20 Apr 2022 02:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pk+JYY5VVKRZ6aBx88b7r5i76JgcB1Gq4MoTI+rhGlA=;
 b=oJx1sH2Kls/76buCvIWCgt9vMC7FkEOy9h0CCjtBrv0FiJfO4b6FZOEGjBLi13RnYjZE
 y9f3zZBHkBByWvxB9d7xx/O5UMNvZ2DpXd2cS056BFqspZv9jPeAJB4RLI4uVGz6iGLl
 5XAvt7eDrNz3ucFJm79qwVdPVyY4LcZhXdiUb/K7EQoHFnHRUvCemoz1qAy0LB9U1U6r
 SsLrrZtYXpUMzsFK315Vtp3vq9JU2SimQQX0OE3yDtUjgAML6WYojG07fS1dohhoBijs
 SUU8Mr361frzI8/TCoKMXwteqNjburunYcPtT2nS+IkptR0LXLj8f2SMVnLX1S/cS1nA Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cqh32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K20grK037450;
        Wed, 20 Apr 2022 02:05:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm843twf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 02:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmoEETuVbL8BNspRu12x0PYQ/KgQnrthlfIRniTdZ6Oc7szMj6GsFcFZR/i3ZDxuIX/6UtkYm99wrWyxGc1UFtDrbOZ7jBDKyD4D4zQmq8KH79tIc26t1yFgC7Oo/RDVHRLndBcjGBEUHwMihxIrwczixjPMzvHFv0mgsooksy5gGcGkB3lx23NL7OjyfPnVgF7768qSEElHl0yFxNb442DvlZXI7eS/dNPuljWpRwn79cSHX4YPsbbtc66o9ijO5XyHleF3beHECg7u1FFu3wa+ZwrZ8NTKFlpfjmjc7Q8C/CxHxYx8cbqrlGxSz3T3My4VLN/UGEvGZbZWbDvozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk+JYY5VVKRZ6aBx88b7r5i76JgcB1Gq4MoTI+rhGlA=;
 b=J7T+C3F3PWDTDW8AVqpEknOqwdS9TAb2O81eEn+X5FfCykCtL/O+ksHMo84gs6CIy+R2qOlwmw2eCi0B6qX7VsNsP6KZ7coVO92hf/oRg4SQtxaNiQsbxWlSWGMSuwPOBhsIktONTx4UX4vv12+wY39tBh6Fq411Gxks6NXsyxZZ0gKxnePqkiTpd4iulxflfpDT8WdXkNU2x22a584BB06xHnEFkylURLSZPSh9IIA5kRPCyfXTn3m4hVb+WvefUFU50uDvAB7B/RhEuBPLVSVImYHhJiCmZhE1HGQWjrMvp9e6+kPZNgsHvbLX/26Mx2CkZ1RO6/+INjP5NfCwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk+JYY5VVKRZ6aBx88b7r5i76JgcB1Gq4MoTI+rhGlA=;
 b=rLK7z2Jo4+wvR5+H8DZMPKdDdegubBjUZQnLLszCtUW+DeSz0wJxjn3LUElxqtAg6H8fYIcHrk46I50fkneaJJskxmckT+zejmTLjeHMrlIllwDO6NNUXKgfZh+kKYZBHFgxNvPREuH6mXUX854qROZ/++51u7zH4+Hl7ucvomo=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 02:05:00 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 02:05:00 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, bp@alien8.de, hch@infradead.org,
        dave.hansen@intel.com, peterz@infradead.org, luto@kernel.org,
        david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com, ira.weiny@intel.com,
        willy@infradead.org, vgoyal@redhat.com
Subject: [PATCH v8 1/7] acpi/nfit: rely on mce->misc to determine poison granularity
Date:   Tue, 19 Apr 2022 20:04:29 -0600
Message-Id: <20220420020435.90326-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220420020435.90326-1-jane.chu@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d48990-a8e4-4d49-f883-08da22722c79
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4557:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB455700AE1D705D421CB8C57AF3F59@SJ0PR10MB4557.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkFgsxeJSrnrDLYPv78FAmi5RzYwbqxGZDmGt9QkvEaDqMs8fX1blEMk0WJkFWKOGzbWDEi5gf1s0ZVGDo1+35q031qcPS+89dey+u6fPkkXGdOhSsLcr4MC9w2Y4uxVaVdBaDj85bmPP/4eVAL6E37IgZ8C8+VaOMdxuShOTSexIyS0c3+omZdfenfcrmlivTYKNlEPbWyOOJMD5F3T7jumt52QST7VdtSf4Yo9WWWK6HBYSx2V9txnUkjMMZo/fKdlL7SH7Adn+IMmQnhAfSeOQVzV6Ygjxnh9C+xAfhvPYl7Blw9EukGYtj1PQ0zR53sg09UYgqmxgfNans4sSvbdsJLqFlccvNHo8fyV34ArxtXZ8jLj/MSv93aprl2jgeyKKI4mYuFN/XAiKx9RY1mh45ZV0cPbzUln1paz75Fq9ZVjcVcv2AJi6Nhz0nIdVSC5Xd1FAoIjywXjjmMTlmcW50UqNzNTE3zQvWdQYKKipp0PvItM0K0ON82AlJhelSNQW/Jqh6U0ZhI2jL49OcGVtW04kYNftTmiJUGAa58vYOHmtJN+/y8Tgpk3NbcKP9C7qEFH5dEKsO+UkfhJS4Ml6oGGrIyQiIt5mwl4yy82Fj4roUVBV6fIiQcopyAKWpPltDFUWwSIBRNSvd4touzZlwaa7KKrK7pxvBHRV4Jrxc0yMAgNrvP/9eupjWxb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(83380400001)(86362001)(4326008)(66556008)(316002)(2906002)(508600001)(1076003)(36756003)(66946007)(186003)(44832011)(6486002)(6512007)(8676002)(2616005)(921005)(7416002)(6666004)(52116002)(38100700002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKFoPMwrg2wdl3hrgu7kaw9B/f7ZCwkxKY3YNzZjhRH+Klz3953uWx9cYmoc?=
 =?us-ascii?Q?Liv6eCUaTR6Lk6k200N3XlNDNir4mnqFegIzan/OQO5WZexyo8K8L3v5UZUE?=
 =?us-ascii?Q?/dci3B4T6CPSNH40bI9wHie7kuYljVqMc3PrjPTO/kA8YL+6+JCPWWw7JReQ?=
 =?us-ascii?Q?JxpggWfx0kpypcdgLGN9XfSN23kEXIOQYQG0d5I/bjNVFLXW71BEGd984szb?=
 =?us-ascii?Q?204O62fhdliHZ+FWR8mdrf/pbNnCuccZr23JG+JaszB32qNHcC6egPhb88HT?=
 =?us-ascii?Q?YfYc3zP9KakLkN3l50IfKEfXfv2BthzdEHeTk+y62mTJfeF2nD8PNI59nZWS?=
 =?us-ascii?Q?PJp0VhkYXfcZF53tiFHcRYi4wOrrQMnFibYtf/4ZTj9nvsExUFw44tlj9F5u?=
 =?us-ascii?Q?82eVAisZ+40G3kcom2eqxD5tbwN3H9EmVo1l46UNDl2Ed9d8zjzEAuTxSmK2?=
 =?us-ascii?Q?mFSSsN4dXayLozClWmX5CmKF0PVuFWQqRzctB3DaaY+j61ql7h3CEqwQtIMg?=
 =?us-ascii?Q?m7hrcU3N9ywnezFrDNj3abstaKhpl48tU17gKEwODleSSnUH1AlF46VLum40?=
 =?us-ascii?Q?qcnL0kc5oxal2RGru8euH1u0W44q1G7SjNGwjyOLycvZInc79Zw1DJ9aEn51?=
 =?us-ascii?Q?rYFMP22T7dRERlCw/4MK84AEvxvsNkjZimuQ69gRRqgwofTGInV3b987E1Qn?=
 =?us-ascii?Q?PcBP2egrmNyG48H014p1Y7QasIbnMWBAkNcq3nknODxYunOpflm6WDsIHOuN?=
 =?us-ascii?Q?i0PTCJLFm0Ggco4NwyGBCNqoiXrEcgMNiL48QXFsPOIrFV4VMb7eP2IeX6jE?=
 =?us-ascii?Q?a8IHxNrLtlLmo4/q1sqbzz3KBeH7jibQ3kMCWOoDVAjar8fz7rqvpxQZmEoQ?=
 =?us-ascii?Q?sPTAzI1bxDo8/DBZoXbruqbhIEMUDg7TrT3nvPLmECvTlrk+GBmtdNfycUlw?=
 =?us-ascii?Q?ohCDF0IYLzspJ9Lk59AvuSMDRq1fAMR1cyR2Qrie9iIJuzFZpODZWfJGFeCB?=
 =?us-ascii?Q?95GYD0417BA9V/kfPnlxLVHbJFFVflPev3VqDp3LwJsN/YMSBwfgChgQXYVc?=
 =?us-ascii?Q?oyXMnFdkP01ufh79D7OuESAh8ArRZBgZ2Kbp9HFmjjQyx+6IuNe0qxe5s0b/?=
 =?us-ascii?Q?z06k8JzuHS9qblWsdHu3vly8Ty6HtAJsKifGe0wWSElnxpHc/wyJdwVI7blS?=
 =?us-ascii?Q?wKlUiax4GGwOeAJTmfTnfvc7WjSPtREeq6lTb60XLNeUpx5d65gqhDbOM0tZ?=
 =?us-ascii?Q?U+tfXtNra0i1K77Kpxcqk051OcJmIhSDosv5qKlzdNSitsALdJMN39Dn+tOp?=
 =?us-ascii?Q?hTXZuyLqF5L5eXgVmJJFClbuVALtaiXXPEbtcESu4xM7YBVUIbBpwg3JUFvq?=
 =?us-ascii?Q?RMTwDdDnXmReinpHb3DAZSqzdD/qFcdlc/Yywd+Lyb3iZ4z3fGAhSzh6Yx14?=
 =?us-ascii?Q?wHgsD+LT06QszjPRRf2gUf9M6UcH6GmeB3U/iRZKyvDpV7+gMGCL0oUZymcH?=
 =?us-ascii?Q?UOFJWrnyzxGFq36K/QLgBsgUs7Kc/6lpHv4qOfYKToI/Swq5fNj5SxUxeF8O?=
 =?us-ascii?Q?fu/CkP732fRLrdBMcvarjYchJFZYB3GCCLRXIuZtGlIsfupO5w1VW6+j97dc?=
 =?us-ascii?Q?0fR8yZQDgfOedJ1sfH4wxy+1M2oJZe/c+mWR3OTUc5677EBm6j3cUdAMKdm3?=
 =?us-ascii?Q?Fnlq91Yz2mWgAMf9G1upptiab19GQ75XFoboZQ6LZBfjIhv8R26GMh14hgMn?=
 =?us-ascii?Q?s57dth+Jtb44ChvgE1KZUQLHiJoxL8M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d48990-a8e4-4d49-f883-08da22722c79
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 02:04:59.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9okA32EIfG/nLytrqLdf+rBBn2moceoZHakPJdCb3EBMr14UY6VgyuPFdhUoqBpknsTU+jAF7YZKXYh5EYRhWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200008
X-Proofpoint-GUID: TPF3GHbqNR-zZ2v2WWQNeapTBB3Uony9
X-Proofpoint-ORIG-GUID: TPF3GHbqNR-zZ2v2WWQNeapTBB3Uony9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nfit_handle_mec() hardcode poison granularity at L1_CACHE_BYTES.
Instead, let the driver rely on mce->misc register to determine
the poison granularity.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/acpi/nfit/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index ee8d9973f60b..d48a388b796e 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -32,6 +32,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	 */
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
+		unsigned int align = 1UL << MCI_MISC_ADDR_LSB(mce->misc);
 		struct device *dev = acpi_desc->dev;
 		int found_match = 0;
 
@@ -63,8 +64,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 
 		/* If this fails due to an -ENOMEM, there is little we can do */
 		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
-				ALIGN(mce->addr, L1_CACHE_BYTES),
-				L1_CACHE_BYTES);
+				ALIGN_DOWN(mce->addr, align), align);
 		nvdimm_region_notify(nfit_spa->nd_region,
 				NVDIMM_REVALIDATE_POISON);
 
-- 
2.18.4

