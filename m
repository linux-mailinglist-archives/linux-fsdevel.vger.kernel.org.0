Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABA04FC1F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbiDKQM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348579AbiDKQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:12:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DA1F629;
        Mon, 11 Apr 2022 09:09:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BF2KeH022836;
        Mon, 11 Apr 2022 16:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=n/bDvD0sv1Kt69nE346NeZGzyJMbyg2LSEytf8HnGJA=;
 b=f+oD3U2lDYxDEhi13Jl5YZYvLvE5Dh41+fM50mLh5pwl+Z7ECL5F3LLazo4cj/ibeKsM
 5HsOkE+ZAhK6ARVb4RRCg/Ds+QulWLvmCqt5ctnMW38Ub8MenhmUc/vrJLPgdUwCstTx
 CXOjQBe9Bh3LvIl5KrLPnsdCMPtvy+GnA1vmkUaWD7jCxQZEoxd415y/3wVbsqXheRbN
 fT7OKy2qxNdztCS8f2NZZ9QsIe7UZ1nP871sX1dgxn+Gy3DncWw1fa1yrQ5ZgH37pC+j
 I2el44aNAd6UWcsXE1GxXuGLcLTXU44wJyRvXffmd8F2/ehXKXSo3DGBDvLdVy9dnA0O lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd442c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG28gP022300;
        Mon, 11 Apr 2022 16:07:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9gdxds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSNMKpzVwdF6IyqeoCEn77JEoDcxH6xU+T6t8wHucpaT6aOPE4Z0dj8Z7UwUSw+dvPV0A099Nxp/+2W8vzhCqmrklMNECY3msaW7jw55YfUJuHBc1GcUStyYpg43z0myvlAuUJiENNgj30pliu5WdbEDMH7q88230iAlcpgKadt6Q0nX+ILdtX3QzpgXcArmk4zTGrEMOInStf2t+agUnV5JVILjw1p6JI2JFcMJREGwPxsIpBlkMymHUEzYV7srCA+6C5LyJ42yU/YbTv9qZOK/lfwu5WrUhWUcZ/lQ9q7Y49i3Xfx7zCeM4iEmQ+PXFSW2FkJuGvgojnj4TxN4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/bDvD0sv1Kt69nE346NeZGzyJMbyg2LSEytf8HnGJA=;
 b=XqcHYJDoDxHnrU4+SQx8BfvVTqQYiCqWTIaGn3/g/JosCNeDyfKS67k4/j+VbUvjxpx6DekCbKgLFZI7S1FAlVLW7NN/rzDAgwgv7q0S7aBr/0iDiiBPdyXUlKkaNegSibg+rX44qQk0o39JXFCLD1MegfidUZ/h5c3mqOy+fPgZoakgPqpq2dcPw+waqJh99XdOVepdPn7+jN/LWIoqVjSRYhHwemsKSkQb+ftd8fVCLRTUxJJjzgeLGRnDIrOjFdkXNWkZaVQJJhVMFa6/EmFPlcSXqH2LuD1qn1HXuc00Kuyd8gT0Rm81J/xA5lvQYsT19fo6NOv87mZ4Y8tKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/bDvD0sv1Kt69nE346NeZGzyJMbyg2LSEytf8HnGJA=;
 b=gEQuO01JkCxZlH3B72JXVQVb7n3o6gQjAMnMHyTrXiDKU1jLp0obsglZKatRC2n72O55D8LQ3zhVn2H5TRi5ZOlVlOFwp85Y7ZltGIdzXLucvf+k2r2L7IKCuNEiJxhgKO0PtLrfEPNVcannH1K4815hsJ+kxdS0QeTvNvEpNCk=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:32 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:32 +0000
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
Subject: [PATCH v1 11/14] mm/mshare: unmap vmas in mshare_unlink
Date:   Mon, 11 Apr 2022 10:05:55 -0600
Message-Id: <fa5583368b0a6492ecb13180c29d7bfb29f73dd9.1649370874.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 884ea063-ea31-4e39-161d-08da1bd5629a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45645CC5C8D467348EB379F486EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZNVjujnqM7bek/baaMbwaBKyeH9qrHZURn+cAstw1bCFx4gqZ6cNNvRZPG42rhj8gELU6L0HaXf7ur8hqwede5BmGvoJbDgNDW+xg5pJBjtqLsx0SoPwp+wr44lzk09HWkEJF8iNTvMLpKffgDQCmJ+zJPAL3LXX8W1qe0PMGJy/NYoMg9JGykyBe2QZ0xAkAMMm0rtPyYsiyplO82auRABNTp0RkjhRjip7y2OY4miZHyM7f3w068V/xI5DT7j+cxc6sboPbEHa2IIVn5KagqlPqa+kqIJIk18HWSrgKOfHGC5v1Xm7oM5JYQ0yLjoADOIU1H6tCoLmoiq4N8xPaJLeJgaocB+upFk0Z6co8j24HJHAD7izYOOrMadNV9uKG1QVgl92FEJcHqoJXA1wouejc6t1dIhnFeH5aU0DLEh6JkvwImOJsHF0WrwpS4uXVC1ICctBGNdP0wdMTRzK0bF5Er/2S/yXurF9Ok2KyPnhmz+qJlvzcu92/im2x737ndRjzfc91Iets3KgAZAIltOQsv1yVAsTtt74G+Ad7gArsnxbboXGuW7LARmGc5OQzVsRkIVE4AMJ7vAqUyCCVIGurYWTviBgPzXj0jRHxRh2/McyvmbLnF9e2IcmDZep0GDNv17JBv9kPx07hqxfg/PPoP5DHz7fUWafHYHmX/EcueTscqHdPloVLrQGctVEG7eD801GFGwcbfw3mDHsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(4744005)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F45v9g1aCCvyPODFWzgygRE4oYZNxZ1OEhJ+MBmv6Uf2dWtJPW1WAu1+8lzR?=
 =?us-ascii?Q?0cN16aNthl2UAypk6GcURaAg64H/GCoVoW9BFxp9IZo6OTVxcgHETLGV49Lc?=
 =?us-ascii?Q?3KQxjlu0SE3YvSTl/Ek5JvOE8/S2+ZmOJiglr78v2c5S21VuD6ONESOuZdPG?=
 =?us-ascii?Q?q5PSZx/oTaGtiITApJiGVEK6yLAQhVCdGmVxXEAs+4N7zC7Gq+4X8uuOobMn?=
 =?us-ascii?Q?jVHN2Lbo2+PhXAVX82n81Yqs3tF4QDKQ9Lz7yaVkBMaHdJoRK0fl8gPk0BF0?=
 =?us-ascii?Q?m30IoMUFa6qMqbQ68hj25M0YnFIIgyHbjENhPSWH8CnIk3jWMnM7b4gUp98F?=
 =?us-ascii?Q?MzlCyZtLQNOm1gUYeYLj57bTLdJKVR6wSeDeB8wS7m5l/AVtfSF2+/rUxf83?=
 =?us-ascii?Q?RwnrCAwTvY4heL1ijvBDzLMgWhinRSHVRKb34whR32eNt3G9Wk+5EtwaJprM?=
 =?us-ascii?Q?xz3nXKC5q0nj6eoGrxWYHcRCxbzRi2ldjeJ72sHL9TT7q95TelAuq+W8V7hW?=
 =?us-ascii?Q?Ik0zlC5c17wGW2ZH8x6oY58wKAPmG8mTuFEHX0pkXzsqfwrKjo+8Ja4UCK3h?=
 =?us-ascii?Q?/OUQ1DYG/U4ELSBKh811i8xBgdSq5vWPXTGuaTj0eTnevqzVp70rYwFGSgGd?=
 =?us-ascii?Q?68WYyz6cMnBiAaqktztprDF6bmPQyK95uMF3DNqyPzmrbVcqhM+Lk2j02sIg?=
 =?us-ascii?Q?NQQHKkW9qsAeSc0l1K4Oq65sucSYRkJHej7/TWMrK3Ju4TtyJDMkyfdj5Gg9?=
 =?us-ascii?Q?yCmeZwiJGStVaY3OnpY2QXHxng5LEDdeMRjm+eOEaPquQ4shGqFE59tOwV3O?=
 =?us-ascii?Q?b9EzpOQhSaO/JpeTk1aqe8UDm/YvTPbh7jToQyINvWlMjCHS4yvduzEliUZW?=
 =?us-ascii?Q?2oWkGf4i4Cfv22Hs7Mgz9jYpY2hvuEQFmCY4VtaMD0iyOrPCZuPwuVAiCN3I?=
 =?us-ascii?Q?7TghIZPSdaYgQ49vuTqjKk65Z6X22b0+qLv32Crggypr6zyElfyxQ3Rfi+8s?=
 =?us-ascii?Q?VWrvDvNe5ATOpUAHMUlsKoo9hYR3EYEiGxfwqai6g/Dw8V6QsosyVRupi5fi?=
 =?us-ascii?Q?s14qhB1XE2yVKpY5lKl0krkhdPnzc3pmL8n35XGlLk4DjNp/qmRSdDHOqRam?=
 =?us-ascii?Q?kptW/y2nrwmcAM7M+XTaWKu+Mc5PeH+lLzoUK/W0zjfBf+YOEEdt1Sdhsp7v?=
 =?us-ascii?Q?NH5HNOEB1AVrg+yR0rZ07bpCZozvETrdJ2ro2lHFZe0wawB9ubcTYP1pOrUT?=
 =?us-ascii?Q?GHy8sweYs9YR7jpbWUGc2p1VcGH3DLtCld79MyXdYrWE3aeefcu7/EPBYxwC?=
 =?us-ascii?Q?JlxN2ROklzIV38zKrjKamXYF6opdQtztHbtxR95wcKCE2jszRIMR+7YvLekA?=
 =?us-ascii?Q?8gC93BpeaUeHl4CEbEHEdhR8j4mFx61lxVd9ruG6VXP0Bu3ds+1/x1cJeUof?=
 =?us-ascii?Q?EVBpJQ9BBG4+ojPMnbYowZe1LSkfNwUQMlnxQr3+lYzlD6y5RnNis0MAlkIr?=
 =?us-ascii?Q?zvJ2zocE1duJgk29/uS0F2/chXZOUCB4Gmf73qSEGSG7aUcr0Idmz/3nCcSR?=
 =?us-ascii?Q?AhEVpeqdhDMWJQuRQJsc3BqxBy+GMIIpSWtSqppL2xqPhRSWVoK6K4h43U52?=
 =?us-ascii?Q?awfZlkRpIOV8ur+E5cAdqiqq7E5HsuyL79asoFDQMERZrAqzji7OtzW93EkG?=
 =?us-ascii?Q?W2ON3SD3wOtsPySPNdSzYcgpOsTw5F+ht7nR7D1kc9/JLpUdBi71mGHJxOBG?=
 =?us-ascii?Q?xY2QvgZVC17LYTyPqEm+GYawIem1bsY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884ea063-ea31-4e39-161d-08da1bd5629a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:32.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOl9sN1Bsq8Wv5HgAvxh+Y2erXM20rHgCaFmBEo/tpKu4Q72x8xldDt42JoGW5/EFK28Ks4EmoJZbpDqTLMpFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=929
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: goWhaugfxPE19_fKgHV3pPSZr0CitvQX
X-Proofpoint-GUID: goWhaugfxPE19_fKgHV3pPSZr0CitvQX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mshare() maps in vma for the calling task. These vmas should be
unmapped when the task calls mshare_unlink(). Add minimal code to
unmap vmas.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index 40c495ffc0ca..ec23d1db79b2 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -490,6 +490,17 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 		mmput(info->mm);
 		kfree(info);
 	} else {
+		/*
+		 * TODO: If mshare'd range is still mapped in the process,
+		 * it should be unmapped. Following is minimal code and
+		 * might need fix up
+		 */
+		unsigned long tmp;
+
+		tmp = info->mm->task_size - info->mm->mmap_base;
+		if (info->host_mm != current->mm)
+			vm_munmap(info->mm->mmap_base, tmp);
+
 		dput(dentry);
 	}
 
-- 
2.32.0

