Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595F06A8FA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 04:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCCDEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 22:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCCDEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:04:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA931997;
        Thu,  2 Mar 2023 19:04:05 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6Tcl007328;
        Fri, 3 Mar 2023 03:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=KaSWF/F+IBJ1caKOTaCAwPENtKtgjrRq4wbFLeMGcjY=;
 b=QnvzQYN9Ldpt5D+eEx+dWXNNHLIAnp0mvimavAoeTj2MFiOEV7W5w8prT93t2mloxDKD
 6FIJr0Bepr67cOz8ALWsuUBvGiCZOl1+5AnepBVQfKm4fTCY1K3fldm4KfvT2IrRN2DP
 USnx/N1XjxBsOF+I9GRWCZHiIqxLrVxT5NUAnJRvS42ofUo71MR5XCmsOp9ek9k5Hikw
 p+s3Db1mRnZCod/Ymo/M+e/0OlvMiG6DMSeemSX7gDYyOxTuDiYI3gUjsGJvsLENtl4Y
 MSvQiQksW86AMMpjY9uFTcFeUzQKl/foR39og5j+420CXWS5MfWIaP2vKixulT8MVbNz Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wwgpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 03:03:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32317iKX034869;
        Fri, 3 Mar 2023 03:03:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sh17v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 03:03:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSwW4FfvWn+mtJtWuP7u0SzScJ0zBRY2Zt75bhQe4W/5b20UYFm9JAlRXfzYxiFepeajE3pBD2CT12Rszcjbvn2en3s4m7sE/IJIajp6b8bZvOyUXhDf+MwwjUM9i7bKJbiP3sKTOrk48fYvoUtqa7ZparJ3QbeLt1ftI6Fp4Hcw8a8sbjz1dVnnEu2w9u6T4DHeQDIV92kIayAFCvXorm0ojjOIPLSNT6J9pTOMPhI5G57h4+DhD596wfwZkxedoniV07IbyVaKrDCIMREETMmB41ZGh6BDCX4Xc5E7tf6CH2Hdy4e2eTMiJOgQFQbP5Lr+Sg/YokqQkp7kJ2JOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaSWF/F+IBJ1caKOTaCAwPENtKtgjrRq4wbFLeMGcjY=;
 b=TpQej5cZFPGb5JC2NromY5JPNOrGtUw4ZG2YIXDeaDxIkWxLWn7NiTfSQB2JI2srChmxwK6K7cfHn5coXgHc/upDiUiJ9smpJKT6js5M+9Xo7PSZLoFWnVB8fnf1iNex0ITUINh2IUGULt8Rq5FWYofzQEzgL3dyOHpF+Y313V0la0R8ek6QLlPTc4B6VNkZHn3uvaDtHpzIzBVvqWQxx9oEh5qgYCv9+VaW6cyP1CnCmFqR+Ip1D5yNQwRYk6KXJFcZRvN8NGkNbSRlWsXfPgsBo/0iH0KkwWoEXB2WiKtsxLB4wR62D7+UinwE1m6wx2g4H56NmIMQ9LpJMV/5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaSWF/F+IBJ1caKOTaCAwPENtKtgjrRq4wbFLeMGcjY=;
 b=fr8aszVYKs2YQusPi/5zOg+DXsAm2XjclOOWbkhezM2UAUpzXSIadYWi04QsqZG8xlzogPwjjO1YmrK3/BUZGkpi1+90ZgL5xlPZH0L3sSoa1EZTCygqnIS34kFg2OrEwARw5alXVHKOmkdXdAI3kkzjRAkBlTbKXWb8gnPI3MI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7386.namprd10.prod.outlook.com (2603:10b6:208:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Fri, 3 Mar
 2023 03:03:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 03:03:51 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn3yfss4.fsf@ca-mkp.ca.oracle.com>
References: <Y/7L74P6jSWwOvWt@mit.edu> <ZAAdA5UG+qrJLRmY@magnolia>
Date:   Thu, 02 Mar 2023 22:03:48 -0500
In-Reply-To: <ZAAdA5UG+qrJLRmY@magnolia> (Darrick J. Wong's message of "Wed, 1
        Mar 2023 19:50:27 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f8d989-60a3-4c4c-97d3-08db1b93ea59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwKjLAOklQAE/MYFXu4NMmWLGSehvmgNJwmcnoiipyLAuNuU4UlUN+RqXC/IHBkyCwfInlwMEjZUlw24XP92SioYEK/eKzNDPC+QVFjfKXS2RzJvMwzHs94ipgqA9DM1TcWR1u6iRmiuv3pboji+Bdan05VPlGsL32i0qSyXnP6M0OLoDaRLVJ7TsJ8crtnrmUac2w3Eqxy78OIpeaucc7Gwk+Pfn1bxQfM7P1QrgMScDrvvN2EXgCyggIFbNXZCn0quHxMamtgi2RllHsF1Zdi3QR26Ew1KOGpNxv/y0lr6cB58zSOGC3kPlCzEF75kvsLcJVNEjewzWqZRAzRKw6DXnyssnujljx+gb1Rk5+LplR+FH+xS3bDy9ZVYGKYwzrSTzbk+Y632GLM6Q6KWsQ1r8PVQnGbEDpgByuvhtMb3+k3/jUY8GJW858gZk4WisYTJUAh10yUaI4vCt4XK1zZ40EQsGPDygKlzhtIj7E7UTpCPUFPZ3kHf/8KeVlzQYHChJrCvb7LB2KKWQ3OlYHED3KS297SjScHX79LMrH+VDOl6heSRu7jhOhlNU+g/xsF3tlKUMUUeFTLKEdrmr8WVHYc5HkWXB5y97BkavRJPsnPP8ktvH5U6SkYSg5qQPBt0b5FXp7sa7rCqelOfnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(6666004)(38100700002)(5660300002)(8936002)(478600001)(86362001)(66946007)(26005)(186003)(66556008)(6486002)(6506007)(6512007)(316002)(8676002)(36916002)(2906002)(66476007)(4744005)(6916009)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7AAj9hk1JqgQbdVmUkJuwXlRmw5YuwF8s3EDxs3KN62R7jVP2Mb6uUnVo3k?=
 =?us-ascii?Q?izDsa0GYVlBYXhSMMUG6hl8Km1G3adT8SdTFbxe3tn/B0zXgHLHlO7TSXVgj?=
 =?us-ascii?Q?iGEzBdxYKt0roDxttpMol76vTWzegeVZg9/UUev3l2QfjdE1KkMv1Pi6Ywgb?=
 =?us-ascii?Q?/EJYxAv5A+CvPEMsO0f7VMsxDvUOnUVjmNB6qaFxtP+bg+MsY9qgp/gwMLLi?=
 =?us-ascii?Q?PGXAqZfL7CXCvGkkp71QvpXH38Cn9ltggD04/MEYuVfHePzlpMsJwFD8MLfl?=
 =?us-ascii?Q?CGOlf8W/lVgGwkAygUAMo3PYFwpd/mDcR3A4GJrmpwrtaoEyyM1Rw35Sopwr?=
 =?us-ascii?Q?vuZQ2toVIiuojw61695ldZ8Fv8jSuns3NWKQxyDXhfjGpNh2teCCLaQqjJMN?=
 =?us-ascii?Q?fP0KjpY7DV4ZJoRF705q3/wrZ0RIJfRQatIFPH/ZRHWJmAQkXtNbwBbW0W/U?=
 =?us-ascii?Q?omTbkpNrOJnwo5O+Fkv0a4wqmHAPR2Ta0H+YQaPxR2LwFq7Y9r046Hvcw3cI?=
 =?us-ascii?Q?dVxcufv/Bh1hKkMknU4NPhuApt5TKrFoDe3wCi5k4q5iuhYNm4Soam95nXvg?=
 =?us-ascii?Q?sAVnc9U6IW1i9BgmTre76cIpKiOxofxdVN//pHvgHJjDgNYLOYkN4avh8e81?=
 =?us-ascii?Q?kH1a9ppZqNC2ek+tq2duw5EFG8RUbjuFeW3mELulwcev4ycMqMtlp1MB7XUf?=
 =?us-ascii?Q?/5UBPFmkK4pW8lQqcMkOUmCwjhniJWWw9T2xmy/dw64xFiLAK8O8mmVatRml?=
 =?us-ascii?Q?gUCz+nu+LrdYLA2zTfQ/5y2GkaCsA90wKshFqFYqbY81qrENroePWNyTIPTJ?=
 =?us-ascii?Q?i7V8wUK93bjL7J8eLuffK2r0AbzP2Yhq2IYritGJENF34gMGDo1vmDpiirIu?=
 =?us-ascii?Q?FJV8KDcE/xLnP1MFJ81JexNtQcy7xSVFcWT/58rts5c/JkS+F9bieGu91xec?=
 =?us-ascii?Q?OfqyjAAU0xWjd5UH8Fvi9vcJNuHgeLkLjS4gGi5Nna0rscSWdgEfTzLQZxM+?=
 =?us-ascii?Q?W0sAvnxDm3s8CoKJ2XmKrpL7eOQo02vmPO7ZaokiEa57KXH+KCsLRBc7YTZQ?=
 =?us-ascii?Q?Lt9y4IogAOgC5uyZZX+HbmrbFhLvkiyYpGpH4mD57WVZyxLj+OExeqHZJQpX?=
 =?us-ascii?Q?5n58fysVCZzP1e/+bhyo2FzTJnh+ZfGV1VSTR9jKPzTWJs54Oz0bF2Kzvtjy?=
 =?us-ascii?Q?Fo4NuMXBa5F7MEl5cexqvzlDG+7jLTXRfvOB0AWnusn7QijrzAPZO5JXWx4Z?=
 =?us-ascii?Q?mPq+PSxqmaL/zWsD478tm6tzDoSvdxz35qkwBisVtZEg+bYEFTT33uz0wAvL?=
 =?us-ascii?Q?5p3QQL+kmwRq+D+eqzp4QBUfHIfi3ku4VbFFiMyS0Jj1aBw1QMTgugpYS+8d?=
 =?us-ascii?Q?nb5R6mrZhNQiTpr9m640bWQyoZgxD/0bqMZ02GJsK/R4CzxXXPJ4AE5aqX90?=
 =?us-ascii?Q?OF0vYt0FQZMhvjb6Zu2W+zDjWJfOLECitutZJp2GJF65YAaDyR2k31cNxvLQ?=
 =?us-ascii?Q?coq5rs52v/zGP5F4h08egeYlD+CnpDy+AeiFzFaJe66OvWQaA3pIlu2/Eg9Q?=
 =?us-ascii?Q?emWNw3PTHJ/NobKskYaEPe+/FVm/Fnwqgaes79KYoHCc9NAFb9VF02JKwnY7?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mhf0/lWRAcQZPAALcpdmITn1fBN646K1uJEL00cFAVwZmvfBHp7SJDG+j6FXSuDwEphhS4339TToTSmCfopGUshGXw40y34BCWGSmyYw0Lp02hAYc/QqbTEtSdAubIp/v71hMECYB6CGjJQSaK0DfvSGmEiK34qcOp1y9RlwXtZVRHLlIJSYUtqkMASkUdp9MMRHq1hgQ4Pa2F/SsKW1G9nPcgd2MCf/0dK4TYJ3muZTI8hGNN0uWMqkKBvm0JJ/AoIgqRlU42ATTsd60/5pQVJKvA9+3ggLwcW8lV3f3tnZe8BnXIN0eHbPvCpaJs2VYE3iuClFqFYDA1VuDhEYWg51d0YRaM6ulAnsnv3YIYh7I9tT5U5e0X/GjlaKTG8OziJ1+GkPN8/Acu0Zj0s/1HHdM5cl70iZCWP3BVGcolos+u7BQXLvX5xw4ipxTLQkWLwnSDH3eqg7C/vEGvCk3p3rkJQpgYRFGS+8/Qthv1NQln2rVvBw2ilee1zhnOkeKRdj7dp84tUS/MDYgZ+iJSv61NWKt8H1M7FCmT3lfr3UmEsRSMaajOtKSKIhK3ph01HCCOkDFQQ/2iLgo5vYhK5x5saQm++GCvVM+1Bx4gKw1cqMzxQ+tULVrUnjTTvc7R6vYdQc09HtgIMi6t7sgIHD8COEfX9FZ1bz5z191HwTESZwsgxghVtBa+iBc6sGawM1cjdA/GLIAjMoHLqGVQItTaakYrRQthSePG4OxF1h0Go4XLadVNhBc5Owy8fFOYwqoAOZNp41pR+cAM8hP2qCur3Fwfa/Np51gxS98L39tHzaBnrvdezc0vevxmhGlq9DyyuFoZH+5m/B1ZN1mUdP/WBk6Ed9coY1PHZmIecsk704SI02DgM4j4hZ/ZnRozuEdXeF/zoBbz1bXwUVjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f8d989-60a3-4c4c-97d3-08db1b93ea59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 03:03:51.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsersVqcQHYNXTHjlhQkG7dR+YINfMq8dGMMRMejLIuOvUUahUgY5kgbek9SXvVKJbA4yMNBddbMcnJPwUCiVoykWq9GCaEiAiLaIzyn6iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=924 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030023
X-Proofpoint-GUID: NNGW3AsCJBNbTOOBIa0--cA1L8hquplW
X-Proofpoint-ORIG-GUID: NNGW3AsCJBNbTOOBIa0--cA1L8hquplW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Darrick,

> T10 PI gives the kernel a means to associate its own checksums (and a
> goofy u16 tag) with LBAs on disk.  There haven't been that many actual
> SCSI devices that implement it,

Storage arrays have traditionally put their own internal magic in that
tag space and therefore did not allow filesystems to use it.

That has changed with the latest NVMe PI amendments which allow a larger
tag (and CRC). The tag space can be split between storage and
application/filesystem use. There are definitely interesting things that
can be done in this area.

-- 
Martin K. Petersen	Oracle Linux Engineering
