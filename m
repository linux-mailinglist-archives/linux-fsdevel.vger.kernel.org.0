Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEA69F62C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 15:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjBVOLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 09:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVOLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:11:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29636FDA;
        Wed, 22 Feb 2023 06:11:44 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x0Jj001203;
        Wed, 22 Feb 2023 12:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=88KOuSRbfC61Ww7DbSMb1A6sxwOw58WRAstUAecAxz4=;
 b=Lsd8Kc/JCAp+tnO7aL6NGl7vTacPwDCA0fhqk5youf4zY/iGNK/Gd0WKpG8VvhflZ475
 OfB+xue1vlPBr7tdMcnyRw/E3HZsIyaZwXbTUOWQI2y46V4bvUVo6FDF04ggRUJkHCWt
 JW4zWwo4uWNfh5hkBryyk6qiMF/+LISgS6qjeL7lguJqW2D4K1U9cSfrWKVF0d5Q3K/2
 MjGcm2KJsXQR2mFl3kQPi9zPlUTNYw3ct6qOywHXUw/UsfmEskqZuJnliuL7Mw5iX1tS
 HBREsIyE4wBoGyUaLB+d1hysn+V4TvULk2Df/tdRZLkn/TcOiW7+IoJBvhx/E658aN0u NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcfrd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MAn8Rw040902;
        Wed, 22 Feb 2023 12:16:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fwhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJiBINgbyASGg7X8Xak/QBXoNrw76uNSH0JbQ/mRk6Hq+p+usoXeI9bLtWaql9RXkknoLZsnVY3SQ4dgl4L8qlYRDzHqwnBPW56Mak5smHwE+HSScoGcoAgR1P3UXDa3eRlirMghNej1BkzdPPj70YkTFKA5pUaAkOznUKDRi3cr10VyEClxU77tE4oMhSGt/IAX0Fo/FaxL/Q4zL5Sajh4RDTNG/eNA1ENmuPupq7iLwjBCoxhCLaZgM8hjHRw3MTlOq/Mp8lwlIa2dA5cYSWefIc05jYphxH4iC3M9xwMvmji4ktJKnty68vY4IPLluspMCQ++xjjl3CKXUMZWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88KOuSRbfC61Ww7DbSMb1A6sxwOw58WRAstUAecAxz4=;
 b=Ud8OjBcnkV8g4pdDfSWcysCyzCJZ/2bv8khBrVAkb8ynVbugEpCMLB5WhKLtMr492woq9/BvX+7cPw0tkH5vYpzJCOZH6jur2iItisapuLmb0AfUAc1iDOdggUuk6M1j6VheJpDP6lTuluJpzXeB2rmk5/kxSEN9+Nf/xuZOEiPRu5VAJ0Qt+B/TYp/61IQz3R3rZ/SOj/wvoNuPU+b6q1STC6sRD9lmDT671NVa7tGQyObbFQVhhRGsQ5CCLrSaycjWB2EPXUhtryoI2ZZQ6vH+WWAMj69btn0gvjz3a6FxE7tsjdPy8XbhTNZpNaVuA0YTp2oQiGmLalpNGf+ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88KOuSRbfC61Ww7DbSMb1A6sxwOw58WRAstUAecAxz4=;
 b=LlsHgmNH57WtliECHbafJJQYY6zQBTG6nz0guCdGTYuJgNSVE7N5iqxsDZxcDEg7vd8SkPZX9rhh9Jb28twD25RcjHO8YI0je6O4MZACFoI9SGyI5KKzvmY6UHCFoVK+o5HohIDWxWUxX8xTeimX16F1MSoI6/493p37R+tnE4g=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:16:52 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:16:52 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 24/27] kbuild, binfmt_elf: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:50 +0000
Message-Id: <20230222121453.91915-25-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: d94381ad-3400-4a50-8052-08db14ceae7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BRbiflH1d8E7w5ZgGJLg1GvTdKS1CcIrfPJStpn+IQruRNXoQeBBpDWhnSAHhtN9uilDyW+B9RDU2DVM/5kLpYYHw6NBH+tSpZVBD9QuT1w1mBKYY5GDxCZz5XbyHEFZUpRbLFFLwSaQ/SegAllcE6mak71GLRzvHhhv4+4dhxNbHo3Up1elNFS6VsoJK3IuG17fXraR4UzePmvx5+HFPcodnXmm4pnX6NMyBsMvApFtjsyMwZD4Gi4xQ7ZHEmZMpPyZs4Umbb9bFYVlvcmbDhooZY2f1FvMNLo1EafYChwr3t1BLrJJSUqVJlThtK4yRaPJBiS3qr8uSgaWVfcrjI3eU9myaSiNM2Yv2cOrIWxTNqGhpoVGL8nOU8zw3C62JKFa9HifvBEaM70gNHtYyQwHFMg0NOe6+GBV7z89lSf4ZOyi0Ry47OAOWRV8ql1lEzWOn0DkfIOaKjWWv/QTgiRbWvtv95kzVXs7c0hWI0GgM+4vPOZ8cVy0SoViHQqN0MRZpPqF3DwKob9i54/3dbNfwzoXlb9jN3BTpu+zAFiWN3E74LKnEVDnu5sDUg5v65PnIOXaf58H0g5XSweImi/4ajHO7zm5ew+e50WIPOMxdSL+h4y/jXHpuI/89mTX0UrdaNgXFD//jxNZToeTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zN26pV8GUFCAjhDCaPuFFfb0iwP2ekB3FeOCe4yMj8xq9BQU54EwLZB80bNA?=
 =?us-ascii?Q?U12eJbSJSRVKgjiRJ3iVOUM9qaEOiGFVl042D+0F7oz5nV4QEBevdGbZNCmT?=
 =?us-ascii?Q?1M231mFgNpaZsgYFe9ICLWxcncBbCj/zcgwAO3dAGzD0OV3PEk0uGBebJsOR?=
 =?us-ascii?Q?d1fOnfV4P5arIp1sskGkAyMm+xsj6lb4/Nc3x/0Vf6eCuh4j6XDvSc2CLsaj?=
 =?us-ascii?Q?MbP22HWiAE1o4lEkrK10QpLupENqoT62RnNrq39CC6AlPYblNOQAncBkNMPt?=
 =?us-ascii?Q?rGwCBAu4YDc0z5dj9vKPoMcz6RJeFyiWBPkFhYcWSKHt1bVRJd6P8qQEmt65?=
 =?us-ascii?Q?2JpRh1aDb5KFRYw+Dm/bxyk5UqwHIbacLLdvkdJGCqy31aianxrIBsUx7r1Z?=
 =?us-ascii?Q?U/EHftnTlW3SnwV7HGAsvZ+/St08DE7kxysw4LMFmQFwsDPYFYM+pyP84XB7?=
 =?us-ascii?Q?KjQ7Jf/54Jyh2q5bOM+4/LRxxwm6rSpkfRFklTpJ954I9BSe6tlIexhO5TSY?=
 =?us-ascii?Q?wYUw4lTxGCjbxjyFeSDyruTcUS+dc5UYlatGT4YTGqvCwbDOYcp/tvEEdmsh?=
 =?us-ascii?Q?qWz/QdNVBz+hI8Ado4FVvwy4jSZSdXC7e8a/LVJRmrVii9IN9Ss83q3flko4?=
 =?us-ascii?Q?k/vHfIr+Ra3GNCTcl4qMrMX21Dul+kEOgWmd89REhmMxLmoe5hKk0C1bb+6J?=
 =?us-ascii?Q?IWoTi3I2/DvlqYs4pPRNFN4LFUsjNNxqPA4olj1Q0hihB6WoHKFS62Uu4RA4?=
 =?us-ascii?Q?Zt+9TXeDd9nSH3gisLQ8JF98KYDxUqWdFpIguI0Th1io2phFbUVWdmY/D6jL?=
 =?us-ascii?Q?PNECrQbbKkaP3IW9R1UD+rl12nSNdqHtoesknaxw/r/BZ0792Irx1BWV9Io+?=
 =?us-ascii?Q?VQNaPhvPd9ZhlqmQWJywJ17kfIZSLyP6W6/oX4khs6SaBbw5XPdXfK0tCl7X?=
 =?us-ascii?Q?HPfI50pRXlo85xr7Xc/LHYm6JpYFYYFWi7vtHzSaqIkrpzBGIREJV09av2M4?=
 =?us-ascii?Q?1CLFjK0TlB4W715p7Ty0+DrTuyblqy6PiJ+O4P1xLBnXHCCmSHBR2crHdV4U?=
 =?us-ascii?Q?ah1+Zd1ki0PyBy9pU6JQDbVVoV/08iGH/dCHkY9L6+MYwhmZFufKcoIr0qkO?=
 =?us-ascii?Q?fLtcUs/EyiPdU7BwwwHiDRZE9IkrTsasu/EVB7CrLwgY5U20hGUaSxaqExme?=
 =?us-ascii?Q?fenrj4AFewMMdSxfIfWCVVQLZtTdODtjY4ARrSuBlETAFWtyFKdB41aqPUqU?=
 =?us-ascii?Q?qqiy22t2k+eYUEXsPDOWS87bz1ibzHva0XraV/WewbayA90Ylxf+j0EjCQkw?=
 =?us-ascii?Q?IDDNAEi6V/jxirwDtV+D3TJwnEKgdstNldM78GVMItRmR0Jvmxcqh139dM3i?=
 =?us-ascii?Q?cS8u2lK9AySLIInfYBK2TH3Yj1yoCuwrg2NnlSn6cLASsnfriD2nZuapUHWK?=
 =?us-ascii?Q?hYslqzw8fy14Y4yHnHACaW+/7qWDZCNxXiwGaavG989D63TQSjNs5MIv3Kcs?=
 =?us-ascii?Q?gE8aIT49dUr5HEH1NGcj348uo+S26b0sf+IpOdpA30j3OgeuY4RseT3fOgOj?=
 =?us-ascii?Q?PQ01LDrB6xZDoMA/Dbbh0ELjtETbqxkR8wNo6SFY3Q0FzcDSSaI8rvyc/0qB?=
 =?us-ascii?Q?EJCJGm984tLXF5K4MVzUOeo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FVPhoncL0gvMWctRZkkTmgRrB/iljdTFEd++dsBknhFuyKLQeIbBgoGEASlHHfyzZaqRPXk5blEa2ekQzHGPyps3U10aafJX2jLfjTkK7GfR/c4jBOwc7RjmSOJwTeMGUR1845kVMljbKxlnuHEYrEVtSkXIxKHGgGaBkN5pKjVamuFUizC0kTVCddviHxoziIov3uckxfYI+ywd63q2g+TDDQtL1LWuiYWDNlB8VvOsGq0I6uUls+1EqR27q24ExY++kxz86RWW7VQBH4mt68nChsZqSHLzx3WPimYVPBLJr3WjRkcgF0O6g1V+BPYI2CHzZA2CC6S07yZH0YMrg1LyGkVlqeonKL5dK4AnzzwHebAcpkTkfy/67Ia9GcKRG+7TRfvK/S7FZ5GmrU8T5BWt+ECDZGfQh/APlw3nNPt6mrOLZtQt82rCTO2PbW9b8ACcF3B9WoR29oZW1dJ6OR8hrb9hBpLHjPBHAFuMG/u/x1jUREmQpO9DZ87LKzLRcSvcoDBBQsDEVPjGHOj3O9nIOUzYt/f1AXedutJF9pn6oMyYLr+1Ux22ix+t3W9flG+JDGkkob7qMbV7wR899kEtQaDhkdp7fvgXjBOrnIbrEDA9lBUaQev7Sl2ypvkQIQor1qn6RGCBf2voAeHNDrNOHk68kP7pIfaCnGoLqD8rK34xIU60by2h6JoZrvVz7W64NlApBLLb5Bo+FbJuYneRq4+ss+f2+i8BhOaxSiHZHTP7YxMhbOED7BCR/MuV2wCYD8wcJI8Dt+e2r1dOMx/WJrLcIOFuytXkTeEYO4rJEkiE3Jax8gt3TP+TVIbgr6vSzh7SHQ/waV42/dVkQXp93nN4FZjDnwSToB8PRCHQk2upM/Dgn9yKSU1k8F7+gZU0v8Qks5p3nxOMgl1vxg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94381ad-3400-4a50-8052-08db14ceae7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:16:52.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNNLkJfCA55ciZvCYtlLvYEL1b2rY8KohhpXVaymO98saUUkvLpL8UGLGAdKzOB3jbJLueVnIOqmRVPifIL1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: Xm68ASdTJoe-b-r96L0yUaHX0e8gdFe7
X-Proofpoint-ORIG-GUID: Xm68ASdTJoe-b-r96L0yUaHX0e8gdFe7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/binfmt_elf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9a780fafc539..40e87c0eaf15 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2169,7 +2169,6 @@ static void __exit exit_elf_binfmt(void)
 
 core_initcall(init_elf_binfmt);
 module_exit(exit_elf_binfmt);
-MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
 #include "binfmt_elf_test.c"
-- 
2.39.1.268.g9de2f9a303

