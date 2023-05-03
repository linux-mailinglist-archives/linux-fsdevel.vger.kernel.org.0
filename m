Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E46F5E4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjECSme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjECSk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544E72B2;
        Wed,  3 May 2023 11:40:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hom1v017459;
        Wed, 3 May 2023 18:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jPwsteNaU9GXozxZhUVMYdJt2KKbOl367bZW1+vO2Xg=;
 b=cz8Djm9X06UtiD/QuBAP4bnFGT721QOdWTrNtnjlmo+OCNijO/mI80FHb14oMIdLmuew
 k7jvjErIOwFwyQja35GAKK37vnpWC2YhzNFR0JCI21rEdTgDq6dti+PIGYHVUgU1NDpJ
 BVZu2dYbO3pxkkCKLca2jva/xXqjB1vEDy4lF2OIzjG5la/TDFfFBOeXgHMXW/owj4sc
 QQPrSs3N8+cEnEPz1NXzFIOhtNFwDklw9vJMLsmLHfebRXm0/P/34Pje8Xzeg6wFG8z4
 lP6G206JYKc/vfla0C44sQtJpqDIFfDSgQUPN+ohxQdWjSr91Tpw6KFZvbhiKK5aQXdl 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aqyht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343HcHP8040441;
        Wed, 3 May 2023 18:40:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7h049-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTdiv+MIiLP2K/+FPQdnDe5uSJGEFFDcNWX3e0s/WzPmAnzw84fLhBfviGduglZic+GFisNe9UvXLCpfOVN6gyjaBBBibXtBj8kRISgGlqmWB169Ejqv1ehDHvcI2U7k+0nSIGqG5YTq3kMU9yopR6Lo5+GG0YQ1QEThEjYXgzItU71W9aNwkUiYOOX+nmL8Wcj6C/9alF4e3glyF6fz6IF7ot7FgjKpWkg36GM3wCJ2Uit1tufjmQJfK8gBCVUxJoYto7KOtBVuB0jHT7wewLSAaH9pA2bHlT3T+Z+GLcXjV3eH64QC+4rr30u5zuI2nAbkARSHoYJf+NxpTTBQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPwsteNaU9GXozxZhUVMYdJt2KKbOl367bZW1+vO2Xg=;
 b=a8NUEq5iFRO3BWcNYIK2AHDyHR8JF067QFaZaYzkY+Kdw08dByDJwE4kAD98jmyGd8PHyVFcGPmP2m7fMJeQT3byNvWuKqF5R1OwHfol+cytzAuGJnbXNS3bPdJfRa+Lx7WMzqHIwOc1vti0R7uV2WY371Jlx7C3Yeke1lK1dg8BE6Vnm6ML6GqGMz9Zn2P17fgKXKpTze3r9F4s7fE8YFzfxZqpawundGKXqgx1MzYVtUP/0vh3K3SPg1yoJpVXzEf9rCpcW9I9V76WQah3wo/rCCu+n5BoV2xkjR05QLeG0A4SRcUAIVvEEZkEXi6qNgNzLLdxLRtHztOEpqkGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPwsteNaU9GXozxZhUVMYdJt2KKbOl367bZW1+vO2Xg=;
 b=WtxG0H8lGxLUhM1E4xiZ0C7VrPxCvGcfTz0gxq4kAZSrigC937Jnw5yHjz/vVzM8N8LRauqvIMbtHurznkJhfDxfe9Ea941wopTE2AALtgQUdSxhUBmSXhAXLsp7lgmDtt6rR+RP+mONIzcBi4TQOFPZxqL00UuW7nLja3zEsQU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:40:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:40:06 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 14/16] scsi: sd: Add WRITE_ATOMIC_16 support
Date:   Wed,  3 May 2023 18:38:19 +0000
Message-Id: <20230503183821.1473305-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6c74a6-d66c-4534-dc95-08db4c05d09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: manxg4H21PiRaxmTg3Bk+7o+JIkRs04kYjyjjRmzVsSEamYzj+lmb+zUZm1r2EtCEs1c1hWtw4DWXS11bHvJHEeIQp5RK781GeM7IldTOkX3YnDYC4sySCE7OxYk+6+oaqeQQJFQ6Htzge8iuWVtmYJjNaMv8kZ6KlFvFg5Syg/FfbJb3okj9HOXr8Pj4wM4SlMoeDj0T4fR1nZ3vTZi1znLnTwbIk2luqShVizfHT46v2uj9Mro/5RIdhf9p8hyqt29HsJph3bymoKkqJOwlJWTI2k/anfbWnVTZ0yd/gQwZhuyNHn7x0IMyEBxk7V3pOQ88TSvtWCUtdhQBNKzhqv9EQFRpsD7zjXErPUUxdieP6yrhm4AA362MY9cZ0zaYL3hcQqdg9DWyETQw5Q/9w3KIlAKwGRY0SNOwXY1clHipWwvdCUCC4w+wKa0aeZN1wlTRqJR62Bc8b2nTP5TOcNUm7+0u5aBSr2wSpyOxrRCYUEjZEznYFcJPPS2zuQiTMJTAvgjG3SFaNTRT/PcdpCZIZeEGONQawQif7eBKwT/kO1AIzIsQ3QicJJGEKR4FmAsQcp1VqIRiHO4WbusPUlruvIdMonns7tZYSNsOFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(107886003)(6512007)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(921005)(4326008)(316002)(66476007)(5660300002)(66946007)(2906002)(7416002)(8676002)(36756003)(86362001)(103116003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxcKICn6wo+lczty+JzhJuhB1pzpYZNfE79g2CWwMceOl26+/+I0ygldN36k?=
 =?us-ascii?Q?Z33ZrP3rNeQZzhJLiWBYfuWGbWXEP1l5pE6PulQusThm61AbkKIxevjemlZf?=
 =?us-ascii?Q?EWOTsh7rlwJgWukx+J52Ym9zKvx4gZPZR4rt4Nq5yidUTB0SRxO2CZU2pQMl?=
 =?us-ascii?Q?JUHvODkXueK7rZhfRxt1mXwpwnpIcMLyvqoDPNfpIboSdUMazKJPkOv9mQyy?=
 =?us-ascii?Q?NC9UPUWbG18JG3EmhIt9/O17GmvSX3NqgJJ13j5udNmqxLvm4rYDGKPNXm8I?=
 =?us-ascii?Q?xOMccyGFFFjEHP1CLlb59lHJZ2H8xyiQPcWIHMrrUx0+fBrbp+czfzK3husn?=
 =?us-ascii?Q?Uv7k/86DrdxdX+VKfXe+kWd6hpFXeCz8rkLL6Sy7JYgi8zgNywPUPqhLHCNc?=
 =?us-ascii?Q?6ytOYPEgRiwXiNvzsw7aXWJnlvKxC1EUAotTXUYrXMDEWQevSAzxjffmHwm5?=
 =?us-ascii?Q?WRusxgjM33BoGoOppkwwNKU+cfr+CIB3AWSEp3RKzedWP/jVb4zu/YTnnbmq?=
 =?us-ascii?Q?uLO6zn/09V+zZWriTV6zEMNxSCERTVlqyWQD11l/mTZ2TLIcFvWbBmnSq7qx?=
 =?us-ascii?Q?Q5WizR7AMl8UvmdXYK02Sn92rtSGpQe342hURaEU+OJLRVA7+vWAx7WXeQPu?=
 =?us-ascii?Q?GXXoL43wSivcg9mkHsSctDW8zkTH2GhuTupPne0IOCm/VMlG8sjo1gaqSFJJ?=
 =?us-ascii?Q?laalD82aBJqlHbezfoMng180rAFii0oWwzh8faCaC3F/ijaQxDrrvWiiDODD?=
 =?us-ascii?Q?sobDf3FvnNw8qkyo1Uw5wQ26xz1akWtRX+tMGq79qytKjUeqvvhMxthLfHFA?=
 =?us-ascii?Q?rqq37HXYABw9BBFzi/185yZ08w4HR/zmqSofgj8stV67uIE2C5zx63v8o7KV?=
 =?us-ascii?Q?JNIfIc0WqSTE1F+6ZfypQj0vWBeRH7+TK5U3xuggIwv8gnYkaNWjuB2iDlTS?=
 =?us-ascii?Q?FHVAWDn9Czk4N890pxXK4nZLYV9kWu5+/vgSt5xjjohm7ll2LZAgDp29Au1t?=
 =?us-ascii?Q?cACtKGQdycRLKWDdfy+3aOIk2sfl0UH0q7fEskGX7Mqfo/dUqa9CJDjTV2Qq?=
 =?us-ascii?Q?QUM4jlrT9xQb/4Wp8HRL9VxVQ1s8qe7/FIhyW0y+drlFGPr5lE/mvFxcBFqY?=
 =?us-ascii?Q?uS3At5eIccI4bNV3Po0qPSxgcajNcDpz7qMpDPwnvKeF7rGPgrsGIBPzf/XV?=
 =?us-ascii?Q?LBp9E4nJHx5e3zJd2ji2VpspC05qRaAkNKEWRbdyAHsXJDKg4xoJNmmkyEKH?=
 =?us-ascii?Q?trQpGsxWvcjiv1FthG8cGqdmswSAnNT0OLTuV/vBZGvejdS0zs2oZ5I1UIwT?=
 =?us-ascii?Q?L4iCr3XfoXvjDPKRpGb1eTLXe0Hk8suVxfmnlO84EvYqsk6cupfSKo6tZyyQ?=
 =?us-ascii?Q?K0cnVCQId3V4auboLpxuZGkJGG2NmSfLGliWWK4vowHYAH9lgryDwRIFn0+j?=
 =?us-ascii?Q?XH8YYQVQvcs8opZOsgAlK5O4EeHSdAAPpjo5PKYAoPedHk5odLRmbOSc9W4p?=
 =?us-ascii?Q?EOrpCM1go3sE3sFAdswxegeTML+MaIXfmAaSEPPeUGwWTXRtWc6CZWdKase+?=
 =?us-ascii?Q?kM1x4qMGJlBBQRSWj+sR4FRy2KOV00fsfySOw61R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u1pUaiGdPagcrS1E5gzXtLPTCa5tw7PHXsoCp1DELJiEZabjkQpwHAi5kcma?=
 =?us-ascii?Q?VAORfnYXnw7wTIU2LEr/jMS0XSjq8TyuZcqvUg2Y0ABAnqoktNwucgIsuOSN?=
 =?us-ascii?Q?pQFUTMY3ImeHMocUV2np1PGlNcrol0zvreiPSEaZnZzJ2PY8263YHXOEYIg6?=
 =?us-ascii?Q?OXpdNGbmFLBGtvw/VtnCEZqpirLqNw5LTft2T7+QJa9CM3CJ817XYbEIWv7V?=
 =?us-ascii?Q?wYn04Y3HkPK9nN4UDA1K+oAep4ky6Pzrvg5Kw1+PxcCLoW1y1Vu5VwA6OwsU?=
 =?us-ascii?Q?1hzfPKwahDjamsY/jaq2IU0YQFuMvuKSmslMVA9FOQaWk7etcCXHPK/dQuFK?=
 =?us-ascii?Q?IkSRgCp2jTPdfLE4mEUJrr1Ink6ddTvUh48YrtGikGs9W1KpG/0U2aWyIyT1?=
 =?us-ascii?Q?cHggyDWdGRc48ZUZ2LCoUe/frdcgRUzrbn45kb2JTd/YfEKjAQP3vZyexHGj?=
 =?us-ascii?Q?cwIYJUW/C5PoTMp2wRlg4VKr8o6hih4sUwYAp/E0m1wFboQa4FzV8j+Thfzj?=
 =?us-ascii?Q?xq/Qc8P7A7D711OORtjfyxWFaFKoy0VvQtU5rJ+yGXRAUPFXpBTQHyUcA++0?=
 =?us-ascii?Q?Joc9KGcQ47M/0yxQZ60qletoXR36J8sPBd7mVolNW2eJHenKa/Ik3xEzD0Vo?=
 =?us-ascii?Q?4zjufwjsP0OLsGjPkJSxKNcxje8P8aGiEB3h5N9ZcXGOOLiiOLlAyZArfKq3?=
 =?us-ascii?Q?r7BiM6+OUpPXwrSm7vQQjVjkjFgWVcd5id9tkFCT8DOgZfyo+Vd9GADmrfxQ?=
 =?us-ascii?Q?yFFaJJcaF9grNm03iAWfd/hiUVCmxIau+5oBfPVV3NqLngSdeiVu+kH8tFKX?=
 =?us-ascii?Q?ZWEF9ifaIgcxahxC6BFZtOPRbISRuaHEHDSBWzrfVOQqy55HpqU8tS8Pa+wq?=
 =?us-ascii?Q?vX6yLXyuRZ/iQELGs+VzT7NctjRd88p4MyO7xwNN0Vbuw+HR3P7bj0fGFjM0?=
 =?us-ascii?Q?XK4FonjLNvShvMNxhDSlXU68RL0absH82Xv8HzOlmIkbsUJVYO8kl7DdJRFU?=
 =?us-ascii?Q?NECurcFkbsLEhcMxnBkvWwivx63YPIFu7N7KGMilG0ce41EKqnTc7NZUW0E7?=
 =?us-ascii?Q?VnlfNEApQIIcbPNqu9Rpd5OVEfFSCGjgV3iVaJt6Eu2+m++nbU7yPQUGWnwx?=
 =?us-ascii?Q?4CL6BMjivo+5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6c74a6-d66c-4534-dc95-08db4c05d09b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:40:06.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7LvM0jteJnAS83+9uUPLy9ZnfXZnufl7mFISziIIvS19zJEA74/iphE7qoH+r++54731i6preZeCDuFhU20gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030160
X-Proofpoint-GUID: vFfc-7-Yi9Gba-xt9EoKxX_QQfYJ0gXQ
X-Proofpoint-ORIG-GUID: vFfc-7-Yi9Gba-xt9EoKxX_QQfYJ0gXQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add function sd_setup_atomic_cmnd() to setup an WRITE_ATOMIC_16
CDB for when REQ_ATOMIC flag is set for the request.

Also add trace info.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_trace.c | 22 ++++++++++++++++++++++
 drivers/scsi/sd.c         | 20 ++++++++++++++++++++
 include/scsi/scsi_proto.h |  1 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 41a950075913..3e47c4472a80 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -325,6 +325,26 @@ scsi_trace_zbc_out(struct trace_seq *p, unsigned char *cdb, int len)
 	return ret;
 }
 
+static const char *
+scsi_trace_atomic_write16_out(struct trace_seq *p, unsigned char *cdb, int len)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned int boundary_size;
+	unsigned int nr_blocks;
+	sector_t lba;
+
+	lba = get_unaligned_be64(&cdb[2]);
+	boundary_size = get_unaligned_be16(&cdb[10]);
+	nr_blocks = get_unaligned_be16(&cdb[12]);
+
+	trace_seq_printf(p, "lba=%llu txlen=%u boundary_size=%u",
+			  lba, nr_blocks, boundary_size);
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *
 scsi_trace_varlen(struct trace_seq *p, unsigned char *cdb, int len)
 {
@@ -385,6 +405,8 @@ scsi_trace_parse_cdb(struct trace_seq *p, unsigned char *cdb, int len)
 		return scsi_trace_zbc_in(p, cdb, len);
 	case ZBC_OUT:
 		return scsi_trace_zbc_out(p, cdb, len);
+	case WRITE_ATOMIC_16:
+		return scsi_trace_atomic_write16_out(p, cdb, len);
 	default:
 		return scsi_trace_misc(p, cdb, len);
 	}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8db8b9389227..e69473fa2dd7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1139,6 +1139,23 @@ static blk_status_t sd_setup_rw6_cmnd(struct scsi_cmnd *cmd, bool write,
 	return BLK_STS_OK;
 }
 
+static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
+					sector_t lba, unsigned int nr_blocks,
+					unsigned char flags)
+{
+	cmd->cmd_len  = 16;
+	cmd->cmnd[0]  = WRITE_ATOMIC_16;
+	cmd->cmnd[1]  = flags;
+	put_unaligned_be64(lba, &cmd->cmnd[2]);
+	cmd->cmnd[10] = 0;
+	cmd->cmnd[11] = 0;
+	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
+	cmd->cmnd[14] = 0;
+	cmd->cmnd[15] = 0;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -1149,6 +1166,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
 	bool write = rq_data_dir(rq) == WRITE;
+	bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;
 	unsigned char protect, fua;
 	blk_status_t ret;
 	unsigned int dif;
@@ -1208,6 +1226,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
+	} else if (atomic_write) {
+		ret = sd_setup_atomic_cmnd(cmd, lba, nr_blocks, protect | fua);
 	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index fbe5bdfe4d6e..c449be9cba60 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -119,6 +119,7 @@
 #define WRITE_SAME_16	      0x93
 #define ZBC_OUT		      0x94
 #define ZBC_IN		      0x95
+#define WRITE_ATOMIC_16	0x9c
 #define SERVICE_ACTION_BIDIRECTIONAL 0x9d
 #define SERVICE_ACTION_IN_16  0x9e
 #define SERVICE_ACTION_OUT_16 0x9f
-- 
2.31.1

