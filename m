Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0F6F5E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjECSka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjECSkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:40:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB972B2;
        Wed,  3 May 2023 11:40:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hov9l000710;
        Wed, 3 May 2023 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=gHtHW+WeteJIlgj4ex5EPdvIGvjZ35NFrZOauH7vYkQ=;
 b=IfxaRcA0eZOIKYbGdRRZQngHUnao7rOOh039rXVbwl7dlm6n+5svHEg0IMpAkcEng9U0
 cosx7HJbmds7Y52bIr9wd+b+iBRIli5jUZbfYG068lQpOrak8SnZhZWUlcJtYNpGkAtM
 cCv2LNRqueWWLjQ568TRa8I6LvsmRNteiH5Uh8f6zCd2Zk1d/LDjmIh5MSxcNvUFjbrn
 sIl/Ly+wP95BNIDpiqM7crlJoIMahAU23L4KOM+oHPsb7DV/awQleZiGLiaWw1eNrdS0
 zj4NsuaGUsC7qnnn+GcMXuDFgxKXfz8NQ/NhXDA20aB592mfvFgvLzKWrN0KmeV65rq2 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv0181-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hsbt8020802;
        Wed, 3 May 2023 18:39:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7g9r0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 18:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+ETxxoL8csbeywetRr1epfwDnQJXoYXwVKKt77+L2ctWT221q/Mfp5TUzrh4BwldaaUOu/ws1KGfwA3TAI7bQCZLzhJN8jvdDZMgqX02kLrXyYCW2TMl3Ca6Wku5z7VZMwquvVb0inQQFKJsDivQKovUTbM/Uux7eWyqydveBPI8w3I6RyBchBKOGkMrgqI593qtcNuD/gVMyNkg5NYMxIjDS9FPJsCcuFoRbFm8IppZyArdf/7Nk0lQMYV1+GZZLUqXI1qlxRDD4Yg38oz8ZAeQ8LhFB5EWcNZUIX1ABUnZauBv1eLsYq+6bIO2pGWZ2y3Bw2qI568BZWkjJp0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHtHW+WeteJIlgj4ex5EPdvIGvjZ35NFrZOauH7vYkQ=;
 b=GnH9XzlHWDJxxnjPoMrX/F5FgWX1B5huBn3vR6ICb50kxsInFOPIfOFhMAq1DXCIhQhWduHWWwGc4/9qXyjQDf7u9s079gl+dlWUoAKL/061gzRfsoeiJjJysH98F925a/b00V8keAFpqklPczRWvJvle4IA8YgqJVGSHKrY8X5Zxu4/yEmyxkvBEU4BezjQ4vGMjNkwEjBiRPaElpAN06aJw7tolZGVBvCOU3ThxpMURi5kzD2RSHyhYNJRK4AhB0qp6Z9ApWIX8jHjM7C8B1wFXiqLOt0Zkm+yT6hzqkaOVasueklfoFB3pwU8wjXB7gpnxe26KaxK1zTd3xoH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHtHW+WeteJIlgj4ex5EPdvIGvjZ35NFrZOauH7vYkQ=;
 b=Br32S/FIEoTH4q2ht7GYg7oGK220kLQzz0dzeF2Ow8S+UsnnAtR77uMDJGhvFHuxMeRYaRjjMGTvxafaB0SMTMGuGXurERWmLbCvBnIe5qkejZQk07OqFRW74DKUSRn4JGmzZBJNe8/pWnp0lNYRc2RNaYQEuU0iLQtc0DLhVrY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6171.namprd10.prod.outlook.com (2603:10b6:208:3a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:39:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:39:37 +0000
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
Subject: [PATCH RFC 07/16] block: Add bdev_find_max_atomic_write_alignment()
Date:   Wed,  3 May 2023 18:38:12 +0000
Message-Id: <20230503183821.1473305-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503183821.1473305-1-john.g.garry@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:5:60::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6cbf23-da9f-4a2b-c71f-08db4c05bf5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUCHT0D961ajXUprjinzOtqpAieZfG9tyngLvyn8XLT3jStVvmXmpiKOI6FMZkZp01VkMKr+PAwAixccKM/+CTl5f9xs7Og3tSkTGgumQIay5/WLMYFY8DRmtUE6nuE0ThrJMfNMX1LZwmMNqhKL2pOm5nSmkZHI8zWWRyW+9fJvHxxy2MT6SN1t7Y+7ZoErut/ccmZRIuKISKwH84GIVdQX+/PHLi/x/nrYFGIHnNrpVWdqiRc4uCKqQifiR+qa3JBYaAxzK8MK1GyZ51SiKa60ESmWQTLiL81T0PLIXUT1NLeYfiKQWJOY/KwhR5eeS/ZtcBLT385fOu5P+OYoGLDLIK7/GjFZAbayhVeacbbfB60xfyqax5R9HpOicLcIZGiGxC9cnG+Uo52rJgTV9ox4A8a/gZciEVEpW6EOO69QGiYMhsuwlbpaTdztx/NZxdOn8IifEJqJKZh0/RsE1Ug8fp1nRXIAqqiY2jP+336ko/3+iAUSvDXLM0GC6jJ5nyhqNlmrLPwUcRBX5MK1ekMFYLUwJRY5L5/LW7zGkrvDjUXYhAV78mQZ9TpC+pKqOUFzc05Zfw2L/o52gk/uKeYsKQcy9nhxeGnPugaq8wE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(2616005)(186003)(4326008)(103116003)(921005)(36756003)(38100700002)(83380400001)(66556008)(7416002)(66476007)(86362001)(41300700001)(8676002)(2906002)(107886003)(5660300002)(6666004)(478600001)(8936002)(6486002)(6506007)(316002)(26005)(6512007)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTAnYK72ellEkFpSkF5jjjtmXcUtGuzTuddaohnCHbi3MGDYSSURjt6jcYEe?=
 =?us-ascii?Q?uWCqeIu9Gq0NVxjKs6KhFYV9X8WFba/n2ZEDyX2jaNJKVz/4LE0xXBaqf9gH?=
 =?us-ascii?Q?uMS/c0RhErJXOLPGFXVWgldmLnPNcO1U9xeBibiyAQmgNUTfPXYfTq63Iylo?=
 =?us-ascii?Q?vDUHNxbkqV4vMqCs0LGfpzKeEsFitE4hO9wEMysGR+9Rh7x5BSzkCt9nmIXe?=
 =?us-ascii?Q?NxTkCEgmCT6x0D7aZCVKoflieZyOPKzdhIKjN2Y7tDr7wU8rc1wKd0sNcPxR?=
 =?us-ascii?Q?PiuvLHDdkRpdVE9ip7aFtfmoNu21Jh9gGmmijUC2AGVyXCr833aQ2seZvltz?=
 =?us-ascii?Q?5ueMc9MYm5ELWrjKIpmgim2spcuXjyeGvKDcKLCP30RL034ug9hgytp+XVnY?=
 =?us-ascii?Q?wyBPtgnLmo8XuRujKS4ZQEL4MWvRzyobZoX/uf3mQknlBGxCLMgMSSzuIXyB?=
 =?us-ascii?Q?DJHSxbS2tUCg0nIS4YKH/DJcT0gAJNxDeRq14J//CNijuTtPtyXO0bWr3I+w?=
 =?us-ascii?Q?+4eucQdneC76/by01ldd+hq+s2Zi3GkWsRbh4exCltTVs8/rQj0ZIV5Chd0c?=
 =?us-ascii?Q?+dnoFWI1zUuI3oglFH+QCyagvM+zwt1ljF9/Gn6N2UJLs2qwZCXn1LUwLM7+?=
 =?us-ascii?Q?sB57EYkVHKA4RYjvor1tSx87EzTuCd4Qii+gK2LtI0Ajswdwf/SlxMiK3U4I?=
 =?us-ascii?Q?QaNEXmSce5njaTr9h3ZSAQtvOrYSaNWBn/Bi7PmI/VjvL3G9a0UltYYGKpDr?=
 =?us-ascii?Q?5df/BCIghtKzeAmDXsS+gTy7YhopUMiP/D46mwa3satJRGJooFGerFnZNQrW?=
 =?us-ascii?Q?Vn8ZCfThYd9jsqLDpdfb1lLZytrvZvHkyfDgaZkOm6GfY2na7BkXUpyu/qXG?=
 =?us-ascii?Q?ItU+gNsypLXocz1gnBS1nGz9ApGsvbVZe8DxyoGXy1a1YnN95snjbeXnDer0?=
 =?us-ascii?Q?RFpMYcEXJAx8pwblsrHDJzzEQR6EuvbDSUdP6xWa3/YEb/RL1CkBzYF25QJW?=
 =?us-ascii?Q?RbY1E70aTq3o4/jPr+Fis3CKl4bQp4zSdfsrlF7FLrPbG+6KWYlzvw6mVk+R?=
 =?us-ascii?Q?zvlQNcDe97R7gPYUP7ZdmV5U1XzdsTJQcQkvqAkSI14AK9zvMvvRCFajLo0x?=
 =?us-ascii?Q?4g7v2b3U+53lPa7bdq8sxMZF1VMv1kHeFzYTKkdhUy8vK911HBmw2/v9WcBo?=
 =?us-ascii?Q?VtIzsW2MK02dc+38uYGtFam4A9the2Oyc+JPBKdg6sjUtVjv5RrJpXeA3xUa?=
 =?us-ascii?Q?GuOBNvOfz4FVMnE5f7OqVYLEr6n5xzLpq3S4PWamcZv39YxptQYcrHjksIJc?=
 =?us-ascii?Q?E6UazOwMOX+a+5SqxEhxMxUS4uDc4rvl637ucBtcSK6Fl8FT5ecctVoVDtmf?=
 =?us-ascii?Q?vRHRo3RmoJL7Wgl/YwXWb6fq67OZPf6I3DUBloFTy2tH558TVsib/Wb0jXt8?=
 =?us-ascii?Q?ds/WWM0GYINF6C5EgVU6Af2To0H9nNp9Bh9Y4OGf3DY0zZqVfB5Hcw6b7Ner?=
 =?us-ascii?Q?cfsEuB2uHHZVB07bIAP0IhhJ+8ZWGSJZqTqGclmZzUk4nKVZnjOpsl6inyyS?=
 =?us-ascii?Q?q1iEPW8/i59gKn3VmMzG2e5k3sKOgJoVtl10EYkI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PxHaU1BhdSng9RI0MDC/xfH00kvShdxwVqQFrQ6LsvRyr/E6zvtUEY5dJlNM?=
 =?us-ascii?Q?iumX36BR6Yv1lR9ztXS1JMkx7y+yla3c+2MjCToNRA1oHuVWM5K+3DOu1gEN?=
 =?us-ascii?Q?L3/ibFpDF++YoWj4jLoNAZKUWq+BZ0rHzk7iobbpWUTcRBLJvXBU6C1yDeV6?=
 =?us-ascii?Q?q6ppmIexQ8xb+6C3ANoeuEo+OYaRVWoo2Y9pwq0yP8vcREJYNBN1jvDM33H9?=
 =?us-ascii?Q?T3fPHe1RFwq2nKdaAsf1QwXdTrJuGIyQP0xCIY3SoebOEnRZTRtVask7UbKk?=
 =?us-ascii?Q?X8NfGofIErlLlMIWi8SywRj+I+6YRl18ZBSe7Onx/3e1R1kXO74itYkCVjUu?=
 =?us-ascii?Q?K6Bpr12xApBiNmR1YwGL+/vWF09nHAzAahZJAvcylHiEJHAdzNDn+dp753Qh?=
 =?us-ascii?Q?y1wFhBRf8/agLiXTjIizh60crMdW64MHRfaVTkw2RVoQcvUYEcSYI3e4bne/?=
 =?us-ascii?Q?nnsfPTLqBYIbd6+CKOyDroI32UAon4FvIjVsgfAsn30tDLrDKc/pVzIZyEIg?=
 =?us-ascii?Q?I7yLGdTECCtcyANrC2Zy47Cpjtj4HTSGwP91tkTPKRQZrumZ1x2kwXyGnUAj?=
 =?us-ascii?Q?5zERbiy9iuWqC5dPNuzLUI3jJny+NhvtCfnqHB0+2l9lanZSf73BWuW1OEsM?=
 =?us-ascii?Q?GCyzFByiOEaGaqpKceSvMDZ8tuc2UDTgrRYsEOXWRHVA4UQpNsaWtEBZJfwZ?=
 =?us-ascii?Q?+C+4DIQdSsWJiUzSHjT+BWsKHSnU5l4R/ZaOHk4mZQ2nKC8jc6xUOFEbKtan?=
 =?us-ascii?Q?hl6C4e4nRjjdPfGJrHomsgFkmuuf4JfvB3ZACMHH4QEandJNnp3Z+xM3hLsO?=
 =?us-ascii?Q?O6KpBrbKdPTOfHXF9x1HlQL0Mn+5eNXVIcods1F2zcotqsD5n0Yh/Xok1lCc?=
 =?us-ascii?Q?BljplfMSQU0Z7ELYdY7uJTVyYHpBp4XJNil3MN0qQWoCRBhn/BExNZIhZVd6?=
 =?us-ascii?Q?3g4RAlSoZS6i1Z3j8Ec3Rt+9i/807xeFHDP2xk8tcr/aUCXEZsL/eegA4i4/?=
 =?us-ascii?Q?UAq2J39CzJhjLkCzO9OEraTy8Xvwp6axeImQiEJHzqOBJESyBWkca+b275Gm?=
 =?us-ascii?Q?ITZvgSWkGrp8n4wv3pQDGJ0txy6457a3TvQJUs7vws+vldURlfd1CYDbdyWN?=
 =?us-ascii?Q?fgHgdJ7ZIPCQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6cbf23-da9f-4a2b-c71f-08db4c05bf5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:39:37.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb/jAGYKV/fxepLOOkOZLK+MJ6n979X6iBV1O/i0WqNDYE6B49Mf+lLbDjQk49GBp2xqPM6GHAgHwAHRa8Dskg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_13,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030160
X-Proofpoint-ORIG-GUID: ilWJuQGNZW_kcmJvPVFEtRAR-7nNxk_f
X-Proofpoint-GUID: ilWJuQGNZW_kcmJvPVFEtRAR-7nNxk_f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to find the max alignment of an atomic write for a bdev
when provided with an offset and length.

We should be able to optimise this function later, most especially since
the values involved are powers-of-2.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c           | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  9 +++++++++
 2 files changed, 48 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 6a5fd5abaadc..3373f0d5cad9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -46,6 +46,45 @@ struct block_device *I_BDEV(struct inode *inode)
 }
 EXPORT_SYMBOL(I_BDEV);
 
+unsigned int bdev_find_max_atomic_write_alignment(struct block_device *bdev,
+					loff_t pos, unsigned int len)
+{
+	struct request_queue *bd_queue = bdev->bd_queue;
+	struct queue_limits *limits = &bd_queue->limits;
+	unsigned int atomic_write_unit_min = limits->atomic_write_unit_min;
+	unsigned int atomic_write_unit_max = limits->atomic_write_unit_max;
+	unsigned int max_align;
+
+	pos /= SECTOR_SIZE;
+	len /= SECTOR_SIZE;
+
+	max_align = min_not_zero(len, atomic_write_unit_max);
+
+	if (len <= 1)
+		return atomic_write_unit_min * SECTOR_SIZE;
+
+	max_align = rounddown_pow_of_two(max_align);
+	while (1) {
+		unsigned int mod1, mod2;
+
+		if (max_align == 0)
+			return atomic_write_unit_min * SECTOR_SIZE;
+
+		/* This should not happen */
+		if (!is_power_of_2(max_align))
+			goto end;
+
+		mod1 = len % max_align;
+		mod2 = pos % max_align;
+		if (!mod1 && !mod2)
+			break;
+end:
+		max_align /= 2;
+	}
+
+	return max_align * SECTOR_SIZE;
+}
+
 static void bdev_write_inode(struct block_device *bdev)
 {
 	struct inode *inode = bdev->bd_inode;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 19d33b2897b2..96138550928c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1529,6 +1529,8 @@ void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void bdev_statx_atomic(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
+unsigned int bdev_find_max_atomic_write_alignment(struct block_device *bdev,
+				loff_t pos, unsigned int len);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
@@ -1553,6 +1555,13 @@ static inline void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
 static inline void printk_all_partitions(void)
 {
 }
+static inline unsigned int bdev_find_max_atomic_write_alignment(
+				struct block_device *bdev,
+				loff_t pos, unsigned int len)
+{
+	return 0;
+}		
+				
 #endif /* CONFIG_BLOCK */
 
 int fsync_bdev(struct block_device *bdev);
-- 
2.31.1

